From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amdgpu: fix structurally dead code vcn_v2_5_hw_init
Date: Tue, 1 Oct 2019 16:57:23 -0500
Message-ID: <3c6ebf4a-8cba-40e2-7d70-c4d5006a160b@embeddedor.com>
References: <20191001171635.GA17306@embeddedor>
 <192815d9-5ecb-09a7-4624-5fd36126890d@amd.com>
 <823b10a3-fe0e-2e8c-02c3-534944dbe6d2@embeddedor.com>
 <dc76a52b-09a2-7ab9-b53e-52500f4f8669@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <dc76a52b-09a2-7ab9-b53e-52500f4f8669@amd.com>
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
To: "Liu, Leo" <Leo.Liu@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

CgpPbiAxMC8xLzE5IDE2OjQ2LCBMaXUsIExlbyB3cm90ZToKCj4+Pj4gKwkJcmluZy0+c2NoZWQu
cmVhZHkgPSB0cnVlOwo+Pj4gVGhpcyBpcyByZWR1bmRhbnQuIGFsbCB0aGUgc2NoZWQtPnJlYWR5
IGlzIGluaXRpYWxpemVkIGFzIHRydWUsIHBsZWFzZQo+Pj4gcmVmZXIgdG8gZHJtX3NjaGVkX2lu
aXQoKQo+Pj4KPj4gSSBzZWUuLi4gc28gaW4gdGhlIGZvbGxvd2luZyBjb21taXQgMWI2MWRlNDVk
ZmFmICgiZHJtL2FtZGdwdTogYWRkIGluaXRpYWwgVkNOMi4wIHN1cHBvcnQgKHYyKSIpCj4+IHRo
YXQgbGluZSBpcyBhbHNvIHJlZHVuZGFudD8KPiAKPiBZZXMuCj4gCgpPSy4KCj4gCj4+Pj4gICAg
CQlyID0gYW1kZ3B1X3JpbmdfdGVzdF9yaW5nKHJpbmcpOwo+Pj4+ICAgIAkJaWYgKHIpIHsKPj4+
PiAgICAJCQlyaW5nLT5zY2hlZC5yZWFkeSA9IGZhbHNlOwo+Pj4+IEBAIC0yNjYsOCArMjY3LDcg
QEAgc3RhdGljIGludCB2Y25fdjJfNV9od19pbml0KHZvaWQgKmhhbmRsZSkKPj4+PiAgICAKPj4+
PiAgICAJCWZvciAoaSA9IDA7IGkgPCBhZGV2LT52Y24ubnVtX2VuY19yaW5nczsgKytpKSB7Cj4+
Pj4gICAgCQkJcmluZyA9ICZhZGV2LT52Y24uaW5zdFtqXS5yaW5nX2VuY1tpXTsKPj4+PiAtCQkJ
cmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsKPj4+PiAtCQkJY29udGludWU7Cj4+Pj4gKwkJCXJp
bmctPnNjaGVkLnJlYWR5ID0gdHJ1ZTsKPj4+IEJlY2F1c2UgdGhlIFZDTiAyLjUgRlcgc3RpbGwg
aGFzIGlzc3VlIGZvciBlbmNvZGUsIHNvIHdlIGhhdmUgaXQKPj4+IGRpc2FibGVkIGhlcmUuCj4+
Pgo+PiBPSy4gU28sIG1heWJlIHdlIGNhbiBhZGQgYSBjb21tZW50IHBvaW50aW5nIHRoYXQgb3V0
Pwo+IAo+IFRoYXQgY291bGQgYmUgYmV0dGVyLgo+IAoKR3JlYXQuIEknbSBnbGFkIGl0J3Mgbm90
IGEgYnVnLiAgSSdsbCB3cml0ZSBhIHBhdGNoIGZvciB0aGF0IHNvIG90aGVyCnBlb3BsZSBkb24n
dCB3YXN0ZSB0aW1lIHRha2luZyBhIGxvb2suCgpJIGFwcHJlY2lhdGUgeW91ciBmZWVkYmFjay4K
VGhhbmtzCi0tCkd1c3Rhdm8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVs
