From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Use new TTM flag to avoid OOM
 triggering.
Date: Tue, 16 Jan 2018 11:42:30 -0500
Message-ID: <ce727655-b4cc-0e41-eeef-7e768fe958d6@amd.com>
References: <1e5d9bed-fe91-360f-e798-772d669f6377@gmail.com>
 <1516115906-26095-1-git-send-email-andrey.grodzovsky@amd.com>
 <1516115906-26095-2-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1516115906-26095-2-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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

T24gMjAxOC0wMS0xNiAxMDoxOCBBTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4gQXZvaWQg
T09NIG9uIHN5YXRlbSBwYWdlcyBhbGxvY2F0aW9ucy4KPgo+IHYyOgo+IFJlbW92ZSBtb2RlcHJv
YmUgcGFyYW1ldGVyLCBtYWtpbmcgdGhpcyBiZWhhdmlvdXIgdGhlIG9ubHkgb3B0aW9uLgo+Cj4g
U2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5j
b20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8
IDQgKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gaW5kZXggNWM0YzNlMC4uYjRkYzNi
ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPiBA
QCAtNDIwLDYgKzQyMCwxMCBAQCBzdGF0aWMgaW50IGFtZGdwdV9ib19kb19jcmVhdGUoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICNlbmRpZgo+ICAKPiAgCWJvLT50Ym8uYmRldiA9ICZh
ZGV2LT5tbWFuLmJkZXY7Cj4gKwo+ICsJLyogV2Ugb3B0IHRvIGF2b2lkIE9PTSBvbiBzeXN0ZW0g
cGFnZXMgYWxsb2NhdGlvbnMgKi8KPiArCWJvLT50Ym8uYmRldi0+bm9fcmV0cnkgPSB0cnVlOwo+
ICsKCkNvdWxkbid0IHRoaXMgYmUgZG9uZSBvbmNlIGluIGFtZGdwdV90dG1faW5pdCBqdXN0IGFm
dGVyIGNhbGxpbmcKdHRtX2JvX2RldmljZV9pbml0PyBObyBuZWVkIHRvIGRvIHRoaXMgZm9yIGV2
ZXJ5IEJPIGNyZWF0aW9uLgoKUmVnYXJkcywKwqAgRmVsaXgKCj4gIAlhbWRncHVfdHRtX3BsYWNl
bWVudF9mcm9tX2RvbWFpbihibywgZG9tYWluKTsKPiAgCj4gIAlyID0gdHRtX2JvX2luaXRfcmVz
ZXJ2ZWQoJmFkZXYtPm1tYW4uYmRldiwgJmJvLT50Ym8sIHNpemUsIHR5cGUsCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
