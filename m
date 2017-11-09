From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 67/73] drm/amd/display: Fix formatting for null pointer
 dereference fix
Date: Thu, 9 Nov 2017 15:06:03 -0500
Message-ID: <20171109200609.14566-68-harry.wentland@amd.com>
References: <20171109200609.14566-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171109200609.14566-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMjc3MDc4YzhkNmM1NDdmYjVhNjg1ODQ1ZjY2MTdiZjk4ODZjNmZlNApTaWdu
ZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdHJlYW0uYyB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3N0cmVhbS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfc3RyZWFtLmMKaW5kZXggZjU2MTIzMmU4
ODY3Li4xZWZhNWI2MmUyNTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjX3N0cmVhbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjX3N0cmVhbS5jCkBAIC0yODUsNyArMjg1LDcgQEAgYm9vbCBkY19zdHJlYW1fc2V0
X2N1cnNvcl9wb3NpdGlvbigKIAkJCXBvc19jcHkuZW5hYmxlID0gZmFsc2U7CiAKIAotCQlpZiAo
aXBwICE9TlVMTCAmJiBpcHAtPmZ1bmNzLT5pcHBfY3Vyc29yX3NldF9wb3NpdGlvbiAhPSBOVUxM
KQorCQlpZiAoaXBwICE9IE5VTEwgJiYgaXBwLT5mdW5jcy0+aXBwX2N1cnNvcl9zZXRfcG9zaXRp
b24gIT0gTlVMTCkKIAkJCWlwcC0+ZnVuY3MtPmlwcF9jdXJzb3Jfc2V0X3Bvc2l0aW9uKGlwcCwg
JnBvc19jcHksICZwYXJhbSk7CiAKIAkJaWYgKG1pICE9IE5VTEwgJiYgbWktPmZ1bmNzLT5zZXRf
Y3Vyc29yX3Bvc2l0aW9uICE9IE5VTEwpCi0tIAoyLjE0LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
