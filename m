From: Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH libdrm] libdrm: Allow dynamic drm majors on linux
Date: Thu, 4 Oct 2018 16:43:37 +0000
Message-ID: <cff87264-5d40-d620-68fc-d4b60fd52289@vmware.com>
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
 <CACvgo5289XdFe9S4r3uSUA20QP37Zy0iiYEW_nHMho4yc0Pi8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo5289XdFe9S4r3uSUA20QP37Zy0iiYEW_nHMho4yc0Pi8A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <D85190296A925D40B31C78E434B4D4A2-HX+pjaQZbrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Hellstrom <thomas-4+hqylr40dJg9hUCZPvPmw@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, linux-graphics-maintainer <linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGksIEVtaWwsDQoNCk9uIDEwLzA0LzIwMTggMDQ6MTIgUE0sIEVtaWwgVmVsaWtvdiB3cm90ZToN
Cj4gT24gU3VuLCAzMCBTZXAgMjAxOCBhdCAxODozMSwgVGhvbWFzIEhlbGxzdHJvbSA8dGhvbWFz
QHNoaXBtYWlsLm9yZz4gd3JvdGU6DQo+PiBIaSwgRW1pbCwNCj4+DQo+PiBPbiAwOS8wNS8yMDE4
IDAzOjUzIFBNLCBFbWlsIFZlbGlrb3Ygd3JvdGU6DQo+Pj4gT24gNSBTZXB0ZW1iZXIgMjAxOCBh
dCAxNDoyMCwgVGhvbWFzIEhlbGxzdHJvbSA8dGhlbGxzdHJvbUB2bXdhcmUuY29tPiB3cm90ZToN
Cj4+Pg0KPj4+Pj4gSW4gdGhhdCBjYXNlLCBwbGVhc2UgZ2l2ZSBtZSAyNGggdG8gZG8gYSBsaWJk
cm0gcmVsZWFzZSBiZWZvcmUgcHVzaGluZy4NCj4+Pj4+IEkgaGFkIHRvIHB1c2ggc29tZSB3b3Jr
YXJvdW5kcyBmb3IgdGhlIHNhbmRib3hpbmcgbWVudGlvbmVkIGVhcmxpZXIgOi1cDQo+Pj4+Pg0K
Pj4+Pj4gVGhhbmtzDQo+Pj4+PiBFbWlsDQo+Pj4+IE91Y2gsIEkganVzdCBwdXNoZWQgdGhlIHBh
dGNoLCBidXQgZmVlbCBmcmVlIHRvIGN1dCB0aGUgcmVsZWFzZSBqdXN0IGJlZm9yZQ0KPj4+PiB0
aGF0IGNvbW1pdC4NCj4+Pj4NCj4+PiBUaGF0IGRvZXNuJ3QgcXVpdGUgd29yay4gQmFycmluZyBh
bnkgb2JqZWN0aW9ucyBJJ2xsOiByZXZlcnQsIHJlbGVhc2UsIHJlYXBwbHkuDQo+Pj4NCj4+PiAt
RW1pbA0KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+Pj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdA0KPj4+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4+PiBodHRwczovL25hMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZs
aXN0aW5mbyUyRmRyaS1kZXZlbCZhbXA7ZGF0YT0wMiU3QzAxJTdDdGhlbGxzdHJvbSU0MHZtd2Fy
ZS5jb20lN0MwMWE1NDM0ZjRhZTk0ZDQxZTAyMTA4ZDYyYTA0MmQ4YiU3Q2IzOTEzOGNhM2NlZTRi
NGFhNGQ2Y2Q4M2Q5ZGQ2MmYwJTdDMSU3QzAlN0M2MzY3NDI1OTQ3NjMyNTE1MDgmYW1wO3NkYXRh
PWY0cFZtTWwlMkIyR2ZJOEhJUjRHcmlURDFFZDJlSHlFZEF0dE1iY0ZvYXZwMCUzRCZhbXA7cmVz
ZXJ2ZWQ9MA0KPj4gV2hhdCBoYXBwZW5lZCBoZXJlPyBJIGNhbid0IHJlYWxseSBzZWUgbXkgY29t
bWl0IG5vciBhIHJldmVydCBub3IgYQ0KPj4gcmVsZWFzZSBpbiBsaWJkcm0uDQo+Pg0KPiBDb21p
bmcgYmFjayBmcm9tIGhvbGlkYXlzK1hEQy4gSScgbSBkb2luZyBhIHJlbGVhc2UgaW4gYSBtb21l
bnQgYW5kDQo+IHdpbGwgcGljayB5b3VyIHBhdGNoIGp1c3QgYWZ0ZXIgdGhhdC4NCj4NCj4gSG1t
IHlvdSBzYWlkIHlvdSBwdXNoZWQgdGhlIHBhdGNoLCB5ZXQgaXQncyBub3QgaW4gbWFzdGVyIC4u
LiBOb3Qgc3VyZQ0KPiB3aGF0IGhhcHBlbmVkIHRoZXJlLg0KPiBFaXRoZXIgd2F5IC0gaXQnbGwg
YmUgdGhlcmUgc2hvcnRseS4NCg0KWWVzLCB0aGF0J3Mgc3RyYW5nZS4gSSdtIG9mZnNpdGUgdG9v
IHNvIEkgY2FuJ3QgY2hlY2sgdGhlIHN5c3RlbSBmcm9tIA0Kd2hpY2ggSSBwdXNoZWQgaXQuIEJ1
dCBhbnl3YXksIEknbGwgcHVzaCBpdCBsYXRlciB0b2RheSBpZiB5b3UgaGF2ZW4ndCANCmFscmVh
ZHkuDQoNClRoYW5rcywNClRob21hcw0KDQoNCj4NCj4gVGhhbmtzDQo+IEVtaWwNCg0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
