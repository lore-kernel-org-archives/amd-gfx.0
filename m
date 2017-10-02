From: James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/9][drm-next] Add uvd6.3 HEVC encode feature in amdgpu
Date: Mon,  2 Oct 2017 10:13:05 -0400
Message-ID: <1506953594-26977-1-git-send-email-James.Zhu@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

VGhlc2UgcGF0Y2hlcyBhZGQgaGVhZGVycy9yaW5ncy90ZXN0X2Nhc2VzL0lSUXMgdG8gc3VwcG9y
dCB1dmQ2LjMgSEVWQwplbmNvZGUgaW4gYW1kZ3B1CiAKU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1
IDxKYW1lcy5aaHVAYW1kLmNvbT4KLS0tCkphbWVzIFpodSAoOSk6CiAgZHJtL2FtZGdwdTogYWRk
IHV2ZCBlbmMgcmVnaXN0ZXJzIGluIGhlYWRlcgogIGRybS9hbWRncHU6IGFkZCB1dmQgZW5jIGNv
bW1hbmQgaW4gaGVhZGVyCiAgZHJtL2FtZGdwdTogYWRkIG5ldyB1dmQgZW5jIHJpbmcgbWV0aG9k
cwogIGRybS9hbWRncHU6IGFkZCB1dmQgZW5jIHJpbmdzCiAgZHJtL2FtZGdwdTogYWRkIHV2ZCBl
bmMgaW50byBydW4gcXVldWUKICBkcm0vYW1kZ3B1OiBhZGQgdXZkIGVuYyB2bSBmdW5jdGlvbnMK
ICBkcm0vYW1kZ3B1OiBhZGQgdXZkIGVuYyByaW5nIHRlc3QKICBkcm0vYW1kZ3B1OiBhZGQgdXZk
IGVuYyBpYiB0ZXN0CiAgZHJtL2FtZGdwdTogYWRkIHV2ZCBlbmMgaXJxCgogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYyAgICAgICAgICAgICAgfCA0ODUgKysrKysrKysrKysr
KysrKysrKystCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aWQuaCAgICAgICAgICAgICAg
ICAgICB8ICAxMCArCiAuLi4vZ3B1L2RybS9hbWQvaW5jbHVkZS9hc2ljX3JlZy91dmQvdXZkXzZf
MF9kLmggICB8ICAxNSArCiAzIGZpbGVzIGNoYW5nZWQsIDUwNCBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQoKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
