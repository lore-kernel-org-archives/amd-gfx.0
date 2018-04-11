From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCHv2] drm/amdkfd: Remove vla
Date: Wed, 11 Apr 2018 11:30:38 +0200
Message-ID: <5444bdd3-e97f-043e-9032-1a072bcca85d@gmail.com>
References: <20180411010243.17771-1-labbott@redhat.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180411010243.17771-1-labbott@redhat.com>
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
To: Laura Abbott <labbott@redhat.com>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Cc: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMTEuMDQuMjAxOCB1bSAwMzowMiBzY2hyaWViIExhdXJhIEFiYm90dDoKPiBUaGVyZSdzIGFu
IG9uZ29pbmcgZWZmb3J0IHRvIHJlbW92ZSBWTEFzWzFdIGZyb20gdGhlIGtlcm5lbCB0byBldmVu
dHVhbGx5Cj4gdHVybiBvbiAtV3ZsYS4gU3dpdGNoIHRvIGEgY29uc3RhbnQgdmFsdWUgdGhhdCBj
b3ZlcnMgYWxsIGhhcmR3YXJlLgo+Cj4gWzFdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzMv
Ny82MjEKPgo+IFNpZ25lZC1vZmYtYnk6IExhdXJhIEFiYm90dCA8bGFiYm90dEByZWRoYXQuY29t
PgoKSXQgd291bGQgYmUgbmljZXIgdG8gaGF2ZSBhIGRlZmluZSBmb3IgdGhhdCBzb21ld2hlcmUu
CgpBbnl3YXkgdGhlIHBhdGNoIGlzIEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+IApmb3Igbm93LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPiAtLS0K
PiB2MjogU3dpdGNoIHRvIGEgbGFyZ2VyIHNpemUgdG8gYWNjb3VudCBmb3Igb3RoZXIgaGFyZHdh
cmUKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pbnRlcnJ1cHQuYyB8
IDggKysrKystLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2lu
dGVycnVwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludGVycnVwdC5jCj4g
aW5kZXggMDM1YzM1MWY0N2M1Li5jM2E1YTgwZTMxYWUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludGVycnVwdC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2ludGVycnVwdC5jCj4gQEAgLTEzOSwxMCArMTM5LDEyIEBAIHN0YXRp
YyB2b2lkIGludGVycnVwdF93cShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gICB7Cj4gICAJ
c3RydWN0IGtmZF9kZXYgKmRldiA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3Qga2ZkX2RldiwK
PiAgIAkJCQkJCWludGVycnVwdF93b3JrKTsKPiArCXVpbnQzMl90IGloX3JpbmdfZW50cnlbOF07
Cj4gICAKPiAtCXVpbnQzMl90IGloX3JpbmdfZW50cnlbRElWX1JPVU5EX1VQKAo+IC0JCQkJZGV2
LT5kZXZpY2VfaW5mby0+aWhfcmluZ19lbnRyeV9zaXplLAo+IC0JCQkJc2l6ZW9mKHVpbnQzMl90
KSldOwo+ICsJaWYgKGRldi0+ZGV2aWNlX2luZm8tPmloX3JpbmdfZW50cnlfc2l6ZSA+ICg4ICog
c2l6ZW9mKHVpbnQzMl90KSkpIHsKPiArCQlkZXZfZXJyKGtmZF9jaGFyZGV2KCksICJSaW5nIGVu
dHJ5IHRvbyBzbWFsbFxuIik7Cj4gKwkJcmV0dXJuOwo+ICsJfQo+ICAgCj4gICAJd2hpbGUgKGRl
cXVldWVfaWhfcmluZ19lbnRyeShkZXYsIGloX3JpbmdfZW50cnkpKQo+ICAgCQlkZXYtPmRldmlj
ZV9pbmZvLT5ldmVudF9pbnRlcnJ1cHRfY2xhc3MtPmludGVycnVwdF93cShkZXYsCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
