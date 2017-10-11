From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH][drm-next] drm/amdgpu: make function
 uvd_v6_0_enc_get_destroy_msg static
Date: Wed, 11 Oct 2017 12:41:23 +0200
Message-ID: <169aed1d-f068-9ae1-1de0-eb14afae3991@gmail.com>
References: <20171011092111.16842-1-colin.king@canonical.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171011092111.16842-1-colin.king@canonical.com>
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
To: Colin King <colin.king@canonical.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>, James Zhu <James.Zhu@amd.com>, Ken Wang <Qingqing.Wang@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMTEuMTAuMjAxNyB1bSAxMToyMSBzY2hyaWViIENvbGluIEtpbmc6Cj4gRnJvbTogQ29saW4g
SWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KPgo+IFRoZSBmdW5jdGlvbiB1dmRf
djZfMF9lbmNfZ2V0X2Rlc3Ryb3lfbXNnIGlzIGxvY2FsIHRvIHRoZSBzb3VyY2UgYW5kCj4gZG9l
cyBub3QgbmVlZCB0byBiZSBpbiBnbG9iYWwgc2NvcGUsIHNvIG1ha2UgaXQgc3RhdGljLgo+Cj4g
Q2xlYW5zIHVwIHNwYXJzZSB3YXJuaW5nOgo+IHN5bWJvbCAndXZkX3Y2XzBfZW5jX2dldF9kZXN0
cm95X21zZycgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlCj4gc3RhdGljPwo+Cj4gU2ln
bmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+
IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYyB8IDUgKysrLS0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMKPiBpbmRleCA2MGFmNzMxMGEyMzQuLjcx
Mjk5YzY3YzUxNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRf
djZfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYwo+IEBA
IC0yNjgsOCArMjY4LDkgQEAgc3RhdGljIGludCB1dmRfdjZfMF9lbmNfZ2V0X2NyZWF0ZV9tc2co
c3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1aW50MzJfdCBoYW5kbGUKPiAgICAqCj4gICAgKiBD
bG9zZSB1cCBhIHN0cmVhbSBmb3IgSFcgdGVzdCBvciBpZiB1c2Vyc3BhY2UgZmFpbGVkIHRvIGRv
IHNvCj4gICAgKi8KPiAtaW50IHV2ZF92Nl8wX2VuY19nZXRfZGVzdHJveV9tc2coc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nLCB1aW50MzJfdCBoYW5kbGUsCj4gLQkJCQkgYm9vbCBkaXJlY3QsIHN0
cnVjdCBkbWFfZmVuY2UgKipmZW5jZSkKPiArc3RhdGljIGludCB1dmRfdjZfMF9lbmNfZ2V0X2Rl
c3Ryb3lfbXNnKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPiArCQkJCQl1aW50MzJfdCBoYW5k
bGUsCj4gKwkJCQkJYm9vbCBkaXJlY3QsIHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSkKPiAgIHsK
PiAgIAljb25zdCB1bnNpZ25lZCBpYl9zaXplX2R3ID0gMTY7Cj4gICAJc3RydWN0IGFtZGdwdV9q
b2IgKmpvYjsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
