From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v2 0/2] drm/drv: Rework drm_dev_unplug()
 (was: Remove drm_dev_unplug())
Date: Thu, 21 Feb 2019 12:31:31 +0100
Message-ID: <0ec502be-88b6-c2b6-990b-69dfe7488650@tronnes.org>
References: <20190208140103.28919-1-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20190208140103.28919-1-noralf@tronnes.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org
Cc: David1.Zhou@amd.com, Andrey.Grodzovsky@amd.com, oleksandr_andrushchenko@epam.com, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, airlied@redhat.com, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

CgpEZW4gMDguMDIuMjAxOSAxNS4wMSwgc2tyZXYgTm9yYWxmIFRyw7hubmVzOgo+IFRoaXMgc2Vy
aWVzIG1ha2VzIGRybV9kZXZfdW5wbHVnKCkgY29tcGF0aWJsZSB3aXRoIHRoZSB1cGNvbWluZwo+
IGRldm1fZHJtX2Rldl9pbml0KCksIGZpeGVzIGEgZG91YmxlIGRybV9kZXZfdW5yZWdpc3Rlcigp
IHNpdHVhdGlvbiBhbmQKPiBzaW1wbGlmaWVzIHRoZSBkcm1fZGV2aWNlIHJlZiBoYW5kbGluZyB3
cnQgdG8gdGhlIGxhc3QgZmQgY2xvc2VkIGFmdGVyCj4gdW5yZWdpc3Rlci4KPiAKPiBUaGUgZmly
c3QgdmVyc2lvbiBvZiB0aGlzIHBhdGNoc2V0IHJlbW92ZWQgZHJtX2Rldl91bnBsdWcoKSwgc2Vl
IGhlcmUKPiBmb3IgdGhlIGRpc2N1c3Npb24gYXMgdG8gd2h5IGl0IGlzIGtlcHQgZm9yIHRoZSB0
aW1lIGJlaW5nOgo+IAo+IFsyLzZdIGRybS9kcnY6IFByZXBhcmUgdG8gcmVtb3ZlIGRybV9kZXZf
dW5wbHVnKCkKPiBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvMjgyOTAy
Lwo+IAo+IE5vcmFsZi4KPiAKPiBOb3JhbGYgVHLDuG5uZXMgKDIpOgo+ICAgZHJtOiBGaXggZHJt
X3JlbGVhc2UoKSBhbmQgZGV2aWNlIHVucGx1Zwo+ICAgZHJtL2RydjogZHJtX2Rldl91bnBsdWco
KTogTW92ZSBvdXQgZHJtX2Rldl9wdXQoKSBjYWxsCj4gCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDEgKwo+ICBkcml2ZXJzL2dwdS9kcm0vZHJtX2Rydi5jICAg
ICAgICAgICAgICAgfCA1IC0tLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9kcm1fZmlsZS5jICAgICAg
ICAgICAgICB8IDYgKystLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS91ZGwvdWRsX2Rydi5jICAgICAg
ICAgICB8IDEgKwo+ICBkcml2ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnQuYyAgICAgfCAx
ICsKPiAgNSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4g
CgpBcHBsaWVkIHRvIGRybS1taXNjLW5leHQsIHRoYW5rcyBmb3IgcmV2aWV3aW5nLgoKTm9yYWxm
LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwt
Z2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4
