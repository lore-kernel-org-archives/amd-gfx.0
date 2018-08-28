From: Samuel Pitoiset <samuel.pitoiset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Vega10] [bisected] Performance regression with Dawn Of War III and
 RADV
Date: Tue, 28 Aug 2018 14:12:12 +0200
Message-ID: <90c1a4f4-0745-19af-a254-0942804cca3e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: evan.quan-5C7GfCeVMHo@public.gmane.org
Cc: rex.zhu-5C7GfCeVMHo@public.gmane.org, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgdGhlcmUsCgpJIGZvdW5kIGEgcGVyZm9ybWFuY2UgcmVncmVzc2lvbiB0aGF0IGFmZmVjdHMg
bXkgVmVnYTEwIHdpdGggRGF3biBPZiBXYXIgCklJSSBhbmQgUkFEViAoaWUuIDc0RlBTIC0+IDcx
RlBTKS4gSSBiaXNlY3RlZCB0bzoKCmNvbW1pdCBlYTdmNDkyYjZhYzZlY2VkMGQwOWNjYjJiMGEy
OTA5YTAwMjVlMjJlCkF1dGhvcjogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KRGF0ZTog
ICBNb24gSnVsIDE2IDE3OjIzOjE5IDIwMTggKzA4MDAKCiAgICAgZHJtL2FtZC9wb3dlcnBsYXk6
IGNvcnJlY3QgdGhlIGFyZ3VtZW50IGZvciBQUFNNQ19NU0dfU2V0VWNsa0Zhc3RTd2l0Y2gKCiAg
ICAgVGhlIGFyZ3VtZW50IHdhcyBzZXQgd3JvbmdseS4gRmFzdC9zbG93IHN3aXRjaCB3YXMgYXNr
ZWQgd2hlbiB0aGVyZSBpcwogICAgIGFjdHVhbGx5IGEgc2xvdy9mYXN0IHN3aXRjaCBuZWVkZWQu
CgogICAgIENoYW5nZS1JZDogSWJjZmRmNzQxZGVhMTcwMGNjMzc5NmY4NDI5MTYwNjIzMWU3MzJm
NGIKICAgICBTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgogICAg
IFJldmlld2VkLWJ5OiBSZXggWmh1PHJleC56aHVAYW1kLmNvbT4KCkFueSBpZGVhcz8KClRoYW5r
cywKU2FtdWVsLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
