From: "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix size calc error in bo_create_kernel_at
Date: Tue, 17 Sep 2019 06:50:29 +0000
Message-ID: <BYAPR12MB28064B780C374BF4F2B14E69F18F0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20190917061643.29367-1-tao.zhou1@amd.com>
 <20190917061643.29367-2-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190917061643.29367-2-tao.zhou1-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

U2VyaWVzIGlzOgpSZXZpZXdlZC1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+
CgpSZWdhcmRzLApHdWNodW4KCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCkZyb206IFpob3Ux
LCBUYW8gPFRhby5aaG91MUBhbWQuY29tPiAKU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE3LCAy
MDE5IDI6MTcgUE0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBDaGVuLCBHdWNo
dW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KQ2M6
IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPgpTdWJqZWN0OiBbUEFUQ0ggMi8yXSBkcm0v
YW1kZ3B1OiBmaXggc2l6ZSBjYWxjIGVycm9yIGluIGJvX2NyZWF0ZV9rZXJuZWxfYXQKCnJlcGxh
Y2Ugb2Zmc2V0IHdpdGggc2l6ZQoKU2lnbmVkLW9mZi1ieTogVGFvIFpob3UgPHRhby56aG91MUBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8
IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwppbmRleCBlY2FkODRlMWI0
ZTIuLjJmY2QyZDE0Y2JmMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X29iamVjdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
YmplY3QuYwpAQCAtMzY2LDcgKzM2Niw3IEBAIGludCBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbF9h
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlpbnQgcjsKIAogCW9mZnNldCAmPSBQQUdF
X01BU0s7Ci0Jc2l6ZSA9IEFMSUdOKG9mZnNldCwgUEFHRV9TSVpFKTsKKwlzaXplID0gQUxJR04o
c2l6ZSwgUEFHRV9TSVpFKTsKIAogCXIgPSBhbWRncHVfYm9fY3JlYXRlX3Jlc2VydmVkKGFkZXYs
IHNpemUsIFBBR0VfU0laRSwgZG9tYWluLCBib19wdHIsCiAJCQkJICAgICAgTlVMTCwgTlVMTCk7
Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
