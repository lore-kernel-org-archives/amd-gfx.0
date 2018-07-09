From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH] drm/amdgpu/acp: Fix slab-out-of-bounds in mfd_add_device
 in acp_hw_init
Date: Mon, 9 Jul 2018 12:10:30 +0530
Message-ID: <ae639d60-9fc9-04fe-debd-ac1c3be86d16@amd.com>
References: <20180413161601.109431-1-djkurtz@chromium.org>
 <6e46904a-d721-d583-8ab5-82cb07df7934@amd.com>
 <CAGS+omATU0gus_EvbHtegGK1ZkaKVmSOr1E6QLQjd+LA_tC_LA@mail.gmail.com>
 <CADnq5_Nwt+i2Sezh2Rmg9VyYYbc8LAMJyS6eQf9K5yAp-GgAXA@mail.gmail.com>
 <4444b8ea-ba99-902d-cb5b-5cf3f05b4803@amd.com>
 <CADnq5_Me=_g6St_j8fYy20eiZK6fbmdp3zZ9WQMM5S5BuZY6uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_Me=_g6St_j8fYy20eiZK6fbmdp3zZ9WQMM5S5BuZY6uQ@mail.gmail.com>
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
To: Alex Deucher <alexdeucher@gmail.com>, "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, jclinton@chromium.org, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Pj4+PiBXYXMgdGhpcyBwYXRjaCBldmVyIHBpY2tlZCB1cD8gIEkgY2FuJ3QgZmluZCBpdCBpbiBh
Z2Q1Zi9saW51eC4KPj4+Cj4+Pgo+Pj4gSXQgd2Fzbid0IGFwcGxpZWQuICBJIGRvbid0IHNlZSA1
MWY3NDE1MDM5ZDQgKCJkcm0vYW1kL2FtZGdwdToKPj4+IGNyZWF0aW5nIHR3byBJMlMgaW5zdGFu
Y2VzIGZvciBzdG9uZXkvY3oiKSB1cHN0cmVhbSB5ZXQgZWl0aGVyLgo+Pj4gRGFuaWVsLCBWaWpl
bmRhciwgd2hpY2ggb25lcyBkbyB5b3Ugd2FudCBhcHBsaWVkPyAgQ2FuIHlvdSBzZW5kIG1lIHRo
ZQo+Pj4gcGF0Y2hlcz8KPj4+Cj4+PiBBbGV4Cj4+Cj4+Cj4+IEhpIEFsZXgsCj4+Cj4+ICJkcm0v
YW1kL2FtZGdwdTogY3JlYXRpbmcgdHdvIEkyUyBpbnN0YW5jZXMgZm9yIHN0b25leS9jeiIgcGF0
Y2ggZXhpc3RzIGluCj4+IGRybS1uZXh0IGJyYW5jaC4gUGxlYXNlIHBpY2sgdGhlIHBhdGNoIC4K
PiAKPiBTbyBqdXN0IHRoYXQgb25lPyAgSSBzZWVtIHRvIHJlY2FsbCB0aGVyZSBiZWluZyBsYXRl
ciByZXZpc2lvbnMgb2YKPiB0aGF0IHBhdGNoIHRoYXQgeW91IHJld29ya2VkIGFmdGVyIGFwcGx5
aW5nIHRoZSBvcmlnaW5hbCB2ZXJzaW9uLgo+IEFsc28gdGhhdCBwYXRjaCB3YXMgb3JpZ2luYWxs
eSBwYXJ0IG9mIGEgbGFyZ2VyIHNlcmllcy4gIEFyZSB0aG9zZQo+IGNoYW5nZXMgcmVxdWlyZWQg
dG9vPwo+IAo+IEFsZXgKPiAKCkhpIEFsZXgsCgpJbiBhZ2Q1Zi9saW51eCwgYnJhbmNoICJhbWQt
c3RhZ2luZy1kcm0tbmV4dCIsCjUwNmY3ZDEgZHJtL2FtZC9hbWRncHU6IGNyZWF0aW5nIHR3byBJ
MlMgaW5zdGFuY2VzIGZvciBzdG9uZXkvY3oKcGF0Y2ggaXMgcHJlc2VudC4KVGhpcyBwYXRjaCBp
cyB0aGUgY29ycmVjdCB2ZXJzaW9uIGFuZCB0aGVyZSBhcmVuJ3QgYW55IG90aGVyIGNoYW5nZXMK
cmVxdWlyZWQgd2l0aCBpdC4KCk9ubHkgRGFuJ3MsIHRoaXMgbWFpbCdzIHBhdGNoIGlzIGN1cnJl
bnRseSBtaXNzaW5nIGZvcm0gdGhlIHRyZWUuCgpUaGFua3MsCkFrc2h1Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QK
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
