From: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/4] add support for ras page retirement
Date: Fri, 30 Aug 2019 20:24:49 +0800
Message-ID: <20190830122453.19703-1-tao.zhou1@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org, guchun.chen-5C7GfCeVMHo@public.gmane.org, dennis.li-5C7GfCeVMHo@public.gmane.org, hawking.zhang-5C7GfCeVMHo@public.gmane.org
Cc: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>

VGhpcyBzZXJpZXMgc2F2ZXMgdW1jIGVycm9yIHBhZ2UgaW5mbyBpbnRvIGEgcmVjb3JkIHN0cnVj
dHVyZSBhbmQgc3RvcmVzCnJlY29yZHMgdG8gZWVwcm9tLCBpdCBhbHNvIGxvYWRzIGVycm9yIHJl
Y29yZHMgZnJvbSBlZXByb20gYW5kIHJlc2VydmVycwpyZWxhdGVkIHJldGlyZWQgcGFnZXMgZHVy
aW5nIGdwdSBpbml0LgoKClRhbyBaaG91ICg0KToKICBkcm0vYW1kZ3B1OiBjaGFuZ2UgcmFzIGJw
cyB0eXBlIHRvIGVlcHJvbSB0YWJsZSByZWNvcmQgc3RydWN0dXJlCiAgZHJtL2FtZGdwdTogSG9v
ayBFRVBST00gdGFibGUgdG8gUkFTCiAgZHJtL2FtZGdwdTogc2F2ZSB1bWMgZXJyb3IgcmVjb3Jk
cwogIGRybS9hbWRncHU6IG1vdmUgdGhlIGNhbGwgb2YgcmFzIHJlY292ZXJ5X2luaXQgYW5kIGJh
ZCBwYWdlIHJlc2VydmUgdG8KICAgIHByb3BlciBwbGFjZQoKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8ICAxNiArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhcy5jICAgIHwgMTcwICsrKysrKysrKysrKysrKy0tLS0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oICAgIHwgIDE4ICsrLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyAgICAgIHwgIDI5ICsrKy0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMgICAgICB8ICAzOSArKysrLQogNSBmaWxlcyBjaGFuZ2Vk
LCAyMDIgaW5zZXJ0aW9ucygrKSwgNzAgZGVsZXRpb25zKC0pCgotLSAKMi4xNy4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
