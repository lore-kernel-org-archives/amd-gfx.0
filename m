From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 2/3] drm/amdgpu: Allow dma_map_sg() coalescing
Date: Mon, 30 Apr 2018 14:00:20 +0100
Message-ID: <dd4897fc-e19a-313b-3d5b-c6e54bd081dc@arm.com>
References: <c15119b9e8e18d96fbef6592fd7e827883c7bf59.1523977133.git.robin.murphy@arm.com>
 <622c9ac3784170880dbde6900146e68631df958a.1523977133.git.robin.murphy@arm.com>
 <59bb29d9-da0c-1542-88bf-71bed96f3ed2@codeaurora.org>
 <6338cb4f-6968-c657-212f-6bfd988f880c@codeaurora.org>
 <e6f7aef7-7515-a9c1-a411-2c8865415fc3@arm.com>
 <438346cf-274f-3ff7-34e9-9ab1440fb26f@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <438346cf-274f-3ff7-34e9-9ab1440fb26f@codeaurora.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sinan Kaya <okaya@codeaurora.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

T24gMjcvMDQvMTggMjA6NDIsIFNpbmFuIEtheWEgd3JvdGU6Cj4gT24gNC8yNy8yMDE4IDExOjU0
IEFNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Cj4+PiB1YnVudHVAdWJ1bnR1On4vYW1kZ3B1JF8u
L3ZlY3RvcmFkZF9oaXAuZXhlCj4+PiBbwqAgODM0LjAwMjIwNl0gY3JlYXRlX3Byb2Nlc3M6NjIw
Cj4+PiBbwqAgODM3LjQxMzAyMV0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVy
IGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAxOAo+Pgo+PiDCozUgc2F5cyB0
aGF0J3Mgc2dfZG1hX2xlbihOVUxMKSwgd2hpY2ggaW1wbGllcyBlaXRoZXIgdGhhdCBzb21ldGhp
bmcncyBnb25lIGhvcnJpYmx5IHdyb25nIHdpdGggdGhlIHNjYXR0ZXJsaXN0IERNQSBtYXBwaW5n
IHN1Y2ggdGhhdCB0aGUgbGVuZ3RocyBkb24ndCBtYXRjaCwgb3IgbXVjaCBtb3JlIGxpa2VseSB0
aGF0IHR0bS5kbWFfYWRkcmVzcyBpcyBOVUxMIGFuZCBJJ3ZlIG1pc3NlZCB0aGUgdGlueSBzdWJ0
bGV0eSBiZWxvdy4gRG9lcyB0aGF0IGZpeCBtYXR0ZXJzPwo+IAo+IFR1cm5lZCBvdXQgdG8gYmUg
YSBudWxsIHBvaW50ZXIgcHJvYmxlbSBhZnRlciBzZ19uZXh0KCkuIFRoZSBmb2xsb3dpbmcgaGVs
cGVkLgoKVWdoLCByaWdodCwgdGhlIHdob2xlIHRoaW5nJ3MgaW4gdGhlIHdyb25nIHBsYWNlIHN1
Y2ggdGhhdCB3aGVuIGFkZHJzIGlzIAp2YWxpZCB3ZSBjYW4gZGVyZWZlcmVuY2UganVuayBvbiB0
aGUgd2F5IG91dCBvZiB0aGUgbG9vcCAoZW50aXJlbHkgCm5lZWRsZXNzbHkpLi4uIHYzIGNvbWlu
ZyB1cC4KClJvYmluLgoKPiAKPiArICAgICAgICAgICAgICAgaWYgKGFkZHJzICYmIChkbWFfbGVu
ID09IDApKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9zZyA9IHNnX25leHQoZG1h
X3NnKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICBkbWFfbGVuID0gc2dfZG1hX2xlbihkbWFf
c2cpOwo+IC0gICAgICAgICAgICAgICAgICAgICAgIGFkZHIgPSBzZ19kbWFfYWRkcmVzcyhkbWFf
c2cpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChkbWFfc2cpIHsKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGRtYV9sZW4gPSBzZ19kbWFfbGVuKGRtYV9zZyk7Cj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGRyID0gc2dfZG1hX2FkZHJlc3MoZG1hX3Nn
KTsKPiArICAgICAgICAgICAgICAgICAgICAgICB9Cj4gICAgICAgICAgICAgICAgICB9Cj4gICAK
PiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
