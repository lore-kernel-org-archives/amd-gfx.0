From: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/6] umc ras code refinement
Date: Thu, 1 Aug 2019 14:43:05 +0800
Message-ID: <20190801064311.7307-1-tao.zhou1@amd.com>
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

VGhlIHNlcmllcyByZWZpbmVzIHVtYyByYXMgY29kZSwgbm8gZnVuY3Rpb25hbCBjaGFuZ2UuCgpU
YW8gWmhvdSAoNik6CiAgZHJtL2FtZGdwdTogcmVtb3ZlIHRoZSBjbGVhciBvZiBNQ0FfQUREUgog
IGRybS9hbWRncHU6IGFkZCBtb3JlIHBhcmFtZXRlcnMgYW5kIGZ1bmN0aW9ucyB0byBhbWRncHVf
dW1jIHN0cnVjdHVyZQogIGRybS9hbWRncHU6IGluaXRpYWxpemUgbmV3IHBhcmFtZXRlcnMgYW5k
IGZ1bmN0aW9ucyBmb3IgYW1kZ3B1X3VtYwogICAgc3RydWN0dXJlCiAgZHJtL2FtZGdwdTogYWRk
IG1hY3JvIG9mIHVtYyBmb3IgZWFjaCBjaGFubmVsCiAgZHJtL2FtZGdwdTogYXBwbHkgdW1jX2Zv
cl9lYWNoX2NoYW5uZWwgbWFjcm8gdG8gdW1jXzZfMQogIGRybS9hbWRncHU6IGFkZCBlcnJvciBh
ZGRyZXNzIHF1ZXJ5IGZvciB1bWMgcmFzCgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhcy5jIHwgIDUgKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91bWMu
aCB8IDM2ICsrKysrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMg
ICB8IDEyICsrKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMgICB8IDky
ICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Vt
Y192Nl8xLmggICB8ICA1ICsrCiA1IGZpbGVzIGNoYW5nZWQsIDkxIGluc2VydGlvbnMoKyksIDU5
IGRlbGV0aW9ucygtKQoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
