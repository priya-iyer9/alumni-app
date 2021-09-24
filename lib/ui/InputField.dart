import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint, errorMessage;
  bool error, enabled;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  Widget? suffixIcon;
  int? maxLines;
  TextInputAction? textInputAction;
  final FocusNode? focusNode;
  InputField(
      {this.controller,
      this.hint,
      this.obscureText,
      this.suffixIcon,
      this.maxLines,
      required this.error,
      this.errorMessage,
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.enabled = true,
      this.onEditingComplete,
      this.focusNode,
      this.textInputAction});
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Color(0xffE0E0E0),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1),
                child: TextField(
                  textInputAction: widget.textInputAction,
                  enabled: widget.enabled,
                  onEditingComplete: widget.onEditingComplete,
                  enableInteractiveSelection: true,
                  focusNode: widget.focusNode,
                  toolbarOptions: ToolbarOptions(
                      copy: true, paste: true, cut: true, selectAll: true),
                  keyboardType: widget.keyboardType,
                  onChanged: widget.onChanged,
                  obscureText: widget.obscureText ?? false,
                  controller: widget.controller,
                  style: TextStyle(
                      fontSize: 15,
                      color: widget.enabled ? Colors.black : Color(0xff909090)),
                  cursorColor: Color(0xff77ACF1),
                  cursorWidth: 1,
                  maxLines: widget.maxLines ?? null,
                  textAlignVertical: widget.suffixIcon == null
                      ? TextAlignVertical.top
                      : TextAlignVertical.center,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 18),
                      border: InputBorder.none,
                      hintText: widget.hint,
                      hintStyle: TextStyle(
                          color: widget.error ? Colors.red : Colors.grey[600],
                          fontSize: 13),
                      suffixIcon: widget.suffixIcon),
                ),
              )),
          widget.error
              ? Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(widget.errorMessage.toString(),
                      style: TextStyle(color: Colors.red)),
                )
              : Container(height: 0)
        ],
      ),
    );
  }
}

class CustomDropDown extends StatelessWidget {
  final List<String> items;
  final String? text;
  final String hint;
  final Function(String?) onChanged;
  final bool error;
  CustomDropDown(
      {required this.items,
      required this.onChanged,
      required this.text,
      required this.hint,
      required this.error});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: error ? Color(0xffE0E0E0) : Color(0xffE0E0E0),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: DropdownButton<String>(
          isExpanded: true,
          dropdownColor: Color(0xfff0f0f0),
          elevation: 0,
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
          hint: Text(text == null ? hint : text.toString(),
              style: TextStyle(
                  color: text == null
                      ? error
                          ? Colors.red
                          : Color(0xffa4a4a4)
                      : Colors.black,
                  fontSize: 13)),
          underline: Container(),
          icon: Icon(Icons.keyboard_arrow_down_sharp, color: Color(0xffa4a4a4)),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
