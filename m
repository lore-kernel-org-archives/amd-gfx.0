From: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Use ARRAY_SIZE macro in
 kfd_build_sysfs_node_entry
Date: Thu, 15 Feb 2018 12:08:44 +0200
Message-ID: <CAFCwf13TGeBGiS_4KiTWwbY3T23JZkWod6DJE-Mi=RmYXRr54w@mail.gmail.com>
References: <20180119003955.GA28885@embeddedor.com>
 <1fea2528-11a5-0210-6350-e916ebfebbdf@amd.com>
 <422e897f-4b65-10f6-4184-36b78b6ea274@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <422e897f-4b65-10f6-4184-36b78b6ea274@embeddedor.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: David Airlie <airlied@linux.ie>, Felix Kuehling <felix.kuehling@amd.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

SGkgR3VzdGF2bywKVGhlIHBhdGNoIGlzIHF1ZXVlZCBmb3IgdGhlIG1lcmdlIHdpbmRvdyBvZiBr
ZXJuZWwgNC4xNyAob3BlbnMgaW4KYWJvdXQgNyB3ZWVrcyBmcm9tIG5vdykuCgpPZGVkCgpPbiBX
ZWQsIEZlYiAxNCwgMjAxOCBhdCAxMTozMCBQTSwgR3VzdGF2byBBLiBSLiBTaWx2YQo8Z2Fyc2ls
dmFAZW1iZWRkZWRvci5jb20+IHdyb3RlOgo+IEhpIGFsbCwKPgo+IEkgd2FzIGp1c3Qgd29uZGVy
aW5nIGFib3V0IHRoZSBzdGF0dXMgb2YgdGhpcyBwYXRjaC4KPgo+IFRoYW5rcwo+IC0tCj4gR3Vz
dGF2bwo+Cj4KPiBPbiAwMS8xOS8yMDE4IDA0OjE4IFBNLCBGZWxpeCBLdWVobGluZyB3cm90ZToK
Pj4KPj4gTG9va3MgZ29vZC4gVGhpcyBjaGFuZ2UgaXMgUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhs
aW5nCj4+IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+Pgo+PiBSZWdhcmRzLAo+PiAgICBGZWxp
eAo+Pgo+Pgo+PiBPbiAyMDE4LTAxLTE4IDA3OjM5IFBNLCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdy
b3RlOgo+Pj4KPj4+IFVzZSBBUlJBWV9TSVpFIGluc3RlYWQgb2YgZGl2aWRpbmcgc2l6ZW9mIGFy
cmF5IHdpdGggc2l6ZW9mIGFuIGVsZW1lbnQuCj4+Pgo+Pj4gVGhpcyBpc3N1ZSB3YXMgZGV0ZWN0
ZWQgd2l0aCB0aGUgaGVscCBvZiBDb2NjaW5lbGxlLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEd1
c3Rhdm8gQS4gUi4gU2lsdmEgPGdhcnNpbHZhQGVtYmVkZGVkb3IuY29tPgo+Pj4gLS0tCj4+PiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jIHwgMiArLQo+Pj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPj4+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPj4+IGluZGV4IGM2YTc2
MDkuLjc3ODMyNTAgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfdG9wb2xvZ3kuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Rv
cG9sb2d5LmMKPj4+IEBAIC02NzcsNyArNjc3LDcgQEAgc3RhdGljIGludCBrZmRfYnVpbGRfc3lz
ZnNfbm9kZV9lbnRyeShzdHJ1Y3QKPj4+IGtmZF90b3BvbG9neV9kZXZpY2UgKmRldiwKPj4+ICAg
ICAgICAgfQo+Pj4gICAgICAgICAvKiBBbGwgaGFyZHdhcmUgYmxvY2tzIGhhdmUgdGhlIHNhbWUg
bnVtYmVyIG9mIGF0dHJpYnV0ZXMuICovCj4+PiAtICAgICAgIG51bV9hdHRycyA9IHNpemVvZihw
ZXJmX2F0dHJfaW9tbXUpL3NpemVvZihzdHJ1Y3Qga2ZkX3BlcmZfYXR0cik7Cj4+PiArICAgICAg
IG51bV9hdHRycyA9IEFSUkFZX1NJWkUocGVyZl9hdHRyX2lvbW11KTsKPj4+ICAgICAgICAgbGlz
dF9mb3JfZWFjaF9lbnRyeShwZXJmLCAmZGV2LT5wZXJmX3Byb3BzLCBsaXN0KSB7Cj4+PiAgICAg
ICAgICAgICAgICAgcGVyZi0+YXR0cl9ncm91cCA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBrZmRf
cGVyZl9hdHRyKQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgKiBudW1fYXR0cnMgKyBzaXpl
b2Yoc3RydWN0IGF0dHJpYnV0ZV9ncm91cCksCj4+Cj4+Cj4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
