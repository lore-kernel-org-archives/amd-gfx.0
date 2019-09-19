From: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: enable full ras by default
Date: Thu, 19 Sep 2019 03:30:45 +0000
Message-ID: <DM5PR12MB14182A2669789A3B985B7626FC890@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20190919031444.8203-1-guchun.chen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190919031444.8203-1-guchun.chen-5C7GfCeVMHo@public.gmane.org>
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
To: "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: "Li, Candice" <Candice.Li-5C7GfCeVMHo@public.gmane.org>

UmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmVn
YXJkcywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaGVuLCBH
dWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+IA0KU2VudDogMjAxOeW5tDnmnIgxOeaXpSAxMTox
NQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgSGF3a2luZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBHcm9k
em92c2t5LCBBbmRyZXkgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+DQpDYzogTGksIENhbmRp
Y2UgPENhbmRpY2UuTGlAYW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNv
bT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogZW5hYmxlIGZ1bGwgcmFzIGJ5IGRlZmF1
bHQNCg0KRW5hYmxlIGZ1bGwgcmFzIGJ5IGRlZmF1bHQsIHVzZXIgZG9lcyBub3QgbmVlZCB0byBl
bmFibGUgaXQgYnkgYm9vdCBwYXJhbWV0ZXIuDQoNClNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVu
IDxndWNodW4uY2hlbkBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQppbmRl
eCA0MjA4ODhlOTQxZGYuLmRkM2I1ZGZhYWE3MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rydi5jDQpAQCAtMTUwLDcgKzE1MCw3IEBAIHN0cnVjdCBhbWRncHVfbWdwdV9p
bmZvIG1ncHVfaW5mbyA9IHsNCiAJLm11dGV4ID0gX19NVVRFWF9JTklUSUFMSVpFUihtZ3B1X2lu
Zm8ubXV0ZXgpLA0KIH07DQogaW50IGFtZGdwdV9yYXNfZW5hYmxlID0gLTE7DQotdWludCBhbWRn
cHVfcmFzX21hc2sgPSAweGZmZmZmZmZiOw0KK3VpbnQgYW1kZ3B1X3Jhc19tYXNrID0gMHhmZmZm
ZmZmZjsNCiANCiAvKioNCiAgKiBET0M6IHZyYW1saW1pdCAoaW50KQ0KLS0NCjIuMTcuMQ0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
