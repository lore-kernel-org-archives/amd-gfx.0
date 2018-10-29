From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH v4 3/4] drm: Document variable refresh properties
Date: Mon, 29 Oct 2018 17:37:49 +0100
Message-ID: <481ae686-adda-5857-5538-2b0af2e25427@daenzer.net>
References: <20181011163942.28267-1-nicholas.kazlauskas@amd.com>
 <20181011163942.28267-4-nicholas.kazlauskas@amd.com>
 <20181026143719.01381cdd@eldfell>
 <bdda3a3b-c912-98bf-8dbd-29a5b58086df@amd.com>
 <20181026145321.GV9144@intel.com>
 <f21251f7-10e2-e0f7-702d-bd3868ac8edc@amd.com>
 <20181026175924.GH9144@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181026175924.GH9144@intel.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "manasi.d.navare@intel.com" <manasi.d.navare@intel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOC0xMC0yNiA3OjU5IHAubS4sIFZpbGxlIFN5cmrDpGzDpCB3cm90ZToKPiBPbiBGcmks
IE9jdCAyNiwgMjAxOCBhdCAwNTozNDoxNVBNICswMDAwLCBLYXpsYXVza2FzLCBOaWNob2xhcyB3
cm90ZToKPj4gT24gMTAvMjYvMTggMTA6NTMgQU0sIFZpbGxlIFN5cmrDpGzDpCB3cm90ZToKPj4+
Cj4+PiBTcGVha2luZyBvZiB0aW1lc3RhbXBzLiBXaGF0IGlzIHRoZSBleHBlY3RlZCBiZWhhdmlv
dXIgb2YgdmJsYW5rCj4+PiB0aW1lc3RhbXBzIHdoZW4gdnJyIGlzIGVuYWJsZWQ/Cj4+Cj4+IFdo
ZW4gdnJyIGlzIGVuYWJsZWQgdGhlIGR1cmF0aW9uIG9mIHRoZSB2ZXJ0aWNhbCBmcm9udCBwb3Jj
aCB3aWxsIGJlCj4+IGV4dGVuZGVkIHVudGlsIGZsaXAgb3IgdGltZW91dCBvY2N1cnMuIFRoZSB2
YmxhbmsgdGltZXN0YW1wIHdpbGwgdmFyeQo+PiBiYXNlZCBvbiBkdXJhdGlvbiBvZiB0aGUgdmVy
dGljYWwgZnJvbnQgcG9yY2guIFRoZSBtaW4vbWF4IGR1cmF0aW9uIGZvcgo+PiB0aGUgZnJvbnQg
cG9yY2ggY2FuIGJlIHNwZWNpZmllZCBieSB0aGUgZHJpdmVyIHZpYSB0aGUgbWluL21heCByYW5n
ZS4KPj4KPj4gTm8gY2hhbmdlcyB0byB2YmxhbmsgdGltZXN0YW1waW5nIGhhbmRsaW5nIHNob3Vs
ZCBiZSBuZWNlc3NhcnkgdG8KPj4gYWNjb21tb2RhdGUgdmFyaWFibGUgcmVmcmVzaCByYXRlLgo+
IAo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIHRpbWVzdGFtcCBpcyBzdXBwb3NlZCB0byBjb3Jy
ZXNwb25kIHRvIHRoZSBmaXJzdAo+IGFjdGl2ZSBwaXhlbC4gQW5kIHNpbmNlIHdlIGRvbid0IGtu
b3cgaG93IGxvbmcgdGhlIGZyb250IHBvcmNoIHdpbGwgYmUKPiB3ZSBjYW4ndCByZWFsaXN0aWNh
bGx5IHJlcG9ydCB0aGUgdHJ1ZSB2YWx1ZS4gU28gSSBndWVzcyBqdXN0IGFzc3VtaW5nCj4gbWlu
IGZyb250IHBvcmNoIGxlbmd0aCBpcyBhcyBnb29kIGFzIGFueXRoaW5nIGVsc2U/CgpUaGF0IChh
bmQgZG9jdW1lbnRpbmcgdGhhdCB0aGUgdGltZXN0YW1wIGNvcnJlc3BvbmRzIHRvIHRoZSBlYXJs
aWVzdApwb3NzaWJsZSBmaXJzdCBhY3RpdmUgcGl4ZWwsIG5vdCBuZWNlc3NhcmlseSB0aGUgYWN0
dWFsIG9uZSwgd2l0aCBWUlIpCm1pZ2h0IGJlIGdvb2QgZW5vdWdoIGZvciB0aGUgYWN0dWFsIHZi
bGFuayBldmVudCB0aW1lc3RhbXBzLgoKCkhvd2V2ZXIsIEknbSBub3Qgc28gc3VyZSBhYm91dCB0
aGUgdGltZXN0YW1wcyBvZiBwYWdlIGZsaXAgY29tcGxldGlvbgpldmVudHMuIFRob3NlIGNvdWxk
IGJlIHZlcnkgbWlzbGVhZGluZyBpZiB0aGUgZmxpcCBjb21wbGV0ZXMgdG93YXJkcyB0aGUKdGlt
ZW91dCwgd2hpY2ggY291bGQgcmVzdWx0IGluIGJhZCBiZWhhdmlvdXIgb2YgYXBwbGljYXRpb25z
IHdoaWNoIHVzZQp0aGVtIGZvciBhbmltYXRpb24gdGltaW5nLgoKTWF5YmUgdGhlIHRpbWVzdGFt
cCBjb3VsZCBiZSB1cGRhdGVkIGFwcHJvcHJpYXRlbHkgKHllcywgSSdtIGhhbmQtd2F2aW5nCjop
IGluIGRybV9jcnRjX3NlbmRfdmJsYW5rX2V2ZW50PwoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETD
pG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxp
YnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFu
ZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwK
