From: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/4] enable umc ras ce interrupt
Date: Thu, 1 Aug 2019 14:53:38 +0800
Message-ID: <20190801065342.8450-1-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, hawking.zhang-5C7GfCeVMHo@public.gmane.org, dennis.li-5C7GfCeVMHo@public.gmane.org, guchun.chen-5C7GfCeVMHo@public.gmane.org, xinhui.pan-5C7GfCeVMHo@public.gmane.org
Cc: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>

VGhlc2UgcGF0Y2hlcyBhZGQgc3VwcG9ydCBmb3IgdW1jIGNlIGludGVycnVwdCwgdGhlIGludGVy
cnVwdCBpcwpjb250cm9sbGVkIGJ5IGEgZXJyb3IgY291bnQgdGhyZXNob2xkLgoKVGFvIFpob3Ug
KDQpOgogIGRybS9hbWRncHU6IHN1cHBvcnQgY2UgaW50ZXJydXB0IGluIHJhcyBtb2R1bGUKICBk
cm0vYW1kZ3B1OiBpbXBsZW1lbnQgdW1jIHJhcyBpbml0IGZ1bmN0aW9uCiAgZHJtL2FtZGdwdTog
dXBkYXRlIHRoZSBjYWxjIGFsZ29yaXRobSBvZiB1bWMgZWNjIGVycm9yIGNvdW50CiAgZHJtL2Ft
ZGdwdTogb25seSB1bmNvcnJlY3RhYmxlIGVycm9yIG5lZWRzIGdwdSByZXNldAoKIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyB8IDEyICsrKystLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgICB8ICA2ICsrKy0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3VtY192Nl8xLmMgICB8IDQyICsrKysrKysrKysrKysrKysrKysrKystLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmggICB8ICA3ICsrKysrCiA0IGZpbGVz
IGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgotLSAKMi4xNy4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
