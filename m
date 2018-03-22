From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH][next] drm/amdgpu: fix spelling mistake: "asssert" ->
 "assert"
Date: Thu, 22 Mar 2018 16:43:09 +0100
Message-ID: <0ddcfc5a-e15c-5b01-bce3-17d0673bb4fb@amd.com>
References: <20180322154144.31363-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180322154144.31363-1-colin.king@canonical.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Colin King <colin.king@canonical.com>, Alex Deucher <alexander.deucher@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, "monk.liu" <monk.liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjIuMDMuMjAxOCB1bSAxNjo0MSBzY2hyaWViIENvbGluIEtpbmc6Cj4gRnJvbTogQ29saW4g
SWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KPgo+IFRyaXZpYWwgZml4IHRvIHNw
ZWxsaW5nIG1pc3Rha2UgaW4gcHJfZXJyIGVycm9yIG1lc3NhZ2UgdGV4dAo+Cj4gU2lnbmVkLW9m
Zi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KCkFja2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYyB8IDIgKy0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9teGdwdV9haS5jCj4gaW5kZXggOGZiOTMzYzYyY2Y1Li40OTMzNDg2NzI0NzUgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMKPiBAQCAtMTI5LDcgKzEyOSw3
IEBAIHN0YXRpYyB2b2lkIHhncHVfYWlfbWFpbGJveF90cmFuc19tc2cgKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+ICAgCQl4Z3B1X2FpX21haWxib3hfc2V0X3ZhbGlkKGFkZXYsIGZhbHNl
KTsKPiAgIAkJdHJuID0geGdwdV9haV9wZWVrX2FjayhhZGV2KTsKPiAgIAkJaWYgKHRybikgewo+
IC0JCQlwcl9lcnIoInRybj0leCBBQ0sgc2hvdWxkIG5vdCBhc3NzZXJ0ISB3YWl0IGFnYWluICFc
biIsIHRybik7Cj4gKwkJCXByX2VycigidHJuPSV4IEFDSyBzaG91bGQgbm90IGFzc2VydCEgd2Fp
dCBhZ2FpbiAhXG4iLCB0cm4pOwo+ICAgCQkJbXNsZWVwKDEpOwo+ICAgCQl9Cj4gICAJfSB3aGls
ZSh0cm4pOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
