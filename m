From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [PATCH libdrm] libdrm: Allow dynamic drm majors on linux
Date: Tue, 2 Oct 2018 19:55:38 +0000
Message-ID: <52466140-1d36-671c-52e5-38b42eef1202@vmware.com>
References: <20180831115419.4922-1-thellstrom@vmware.com>
 <CACvgo50fT1JAfmCLeZT1STRe_nnPo9PQjgk9+S5VRk-o5P088w@mail.gmail.com>
 <bbb94b6f-c9d5-27ab-9e6d-4b4c1d85db8e@vmware.com>
 <33fb1ba6-cc44-f747-545b-9f877917933e@daenzer.net>
 <CACvgo53Wd1fq8=V_v7jjuFGimUfh7xD+ccCg-jOTjLSJdWUKeA@mail.gmail.com>
 <c1dc7253-d505-dd16-480c-ee9a862d57ef@vmware.com>
 <abe23e5a-2271-d428-06ba-de4d2d62179e@vmware.com>
 <20180903163310.GJ21634@phenom.ffwll.local>
 <91ad6140-4e56-afc1-2515-9ca973d0ea05@vmware.com>
 <CAPM=9tzScEQ-RWK55zKeT_yXiN6iAyx34DVX1eCgA3ZqC_SpuQ@mail.gmail.com>
 <CACvgo50cfLHWDUEjeNet4H3F4i3okdhSsXfjNiPvH-YZbQsyEg@mail.gmail.com>
 <53ece2d8-e4ae-331d-16e9-8ad5d067844d@vmware.com>
 <CACvgo53t4OSsdmxdHSqrfSWKZGYg4s+uXrSV3gWcignwNxfE8A@mail.gmail.com>
 <ce00f764-1ebd-aac8-45e3-95eda4b02fc0@vmware.com>
 <CACvgo52dj75j--gi8UrUZ9txpAjRXRpKzr-QaH92deS1=Lfk_w@mail.gmail.com>
 <a3af864a-8914-3bef-ff26-02c7672a9e50@shipmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <a3af864a-8914-3bef-ff26-02c7672a9e50@shipmail.org>
Content-Language: en-US
Content-ID: <91B5EC5352D74C4E81DB3BF6D5C056EF@namprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>, linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

UGluZz8NCg0KT24gMDkvMzAvMjAxOCAwNzozMSBQTSwgVGhvbWFzIEhlbGxzdHJvbSB3cm90ZToN
Cj4gSGksIEVtaWwsDQo+DQo+IE9uIDA5LzA1LzIwMTggMDM6NTMgUE0sIEVtaWwgVmVsaWtvdiB3
cm90ZToNCj4+IE9uIDUgU2VwdGVtYmVyIDIwMTggYXQgMTQ6MjAsIFRob21hcyBIZWxsc3Ryb20g
DQo+PiA8dGhlbGxzdHJvbUB2bXdhcmUuY29tPiB3cm90ZToNCj4+DQo+Pj4+IEluIHRoYXQgY2Fz
ZSwgcGxlYXNlIGdpdmUgbWUgMjRoIHRvIGRvIGEgbGliZHJtIHJlbGVhc2UgYmVmb3JlIA0KPj4+
PiBwdXNoaW5nLg0KPj4+PiBJIGhhZCB0byBwdXNoIHNvbWUgd29ya2Fyb3VuZHMgZm9yIHRoZSBz
YW5kYm94aW5nIG1lbnRpb25lZCBlYXJsaWVyIA0KPj4+PiA6LVwNCj4+Pj4NCj4+Pj4gVGhhbmtz
DQo+Pj4+IEVtaWwNCj4+Pg0KPj4+IE91Y2gsIEkganVzdCBwdXNoZWQgdGhlIHBhdGNoLCBidXQg
ZmVlbCBmcmVlIHRvIGN1dCB0aGUgcmVsZWFzZSBqdXN0IA0KPj4+IGJlZm9yZQ0KPj4+IHRoYXQg
Y29tbWl0Lg0KPj4+DQo+PiBUaGF0IGRvZXNuJ3QgcXVpdGUgd29yay4gQmFycmluZyBhbnkgb2Jq
ZWN0aW9ucyBJJ2xsOiByZXZlcnQsIA0KPj4gcmVsZWFzZSwgcmVhcHBseS4NCj4+DQo+PiAtRW1p
bA0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+
IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QNCj4+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsDQo+DQo+IFdoYXQgaGFwcGVuZWQgaGVyZT8gSSBjYW4ndCByZWFsbHkgc2VlIG15IGNv
bW1pdCBub3IgYSByZXZlcnQgbm9yIGEgDQo+IHJlbGVhc2UgaW4gbGliZHJtLg0KPg0KPiAvVGhv
bWFzDQo+DQo+DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bAo=
