From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] libdrm: Allow dynamic drm majors on linux
Date: Thu, 4 Oct 2018 15:12:29 +0100
Message-ID: <CACvgo5289XdFe9S4r3uSUA20QP37Zy0iiYEW_nHMho4yc0Pi8A@mail.gmail.com>
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
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a3af864a-8914-3bef-ff26-02c7672a9e50-4+hqylr40dJg9hUCZPvPmw@public.gmane.org>
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
To: Thomas Hellstrom <thomas-4+hqylr40dJg9hUCZPvPmw@public.gmane.org>
Cc: Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, VMware Graphics <linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gU3VuLCAzMCBTZXAgMjAxOCBhdCAxODozMSwgVGhvbWFzIEhlbGxzdHJvbSA8dGhvbWFzQHNo
aXBtYWlsLm9yZz4gd3JvdGU6Cj4KPiBIaSwgRW1pbCwKPgo+IE9uIDA5LzA1LzIwMTggMDM6NTMg
UE0sIEVtaWwgVmVsaWtvdiB3cm90ZToKPiA+IE9uIDUgU2VwdGVtYmVyIDIwMTggYXQgMTQ6MjAs
IFRob21hcyBIZWxsc3Ryb20gPHRoZWxsc3Ryb21Adm13YXJlLmNvbT4gd3JvdGU6Cj4gPgo+ID4+
PiBJbiB0aGF0IGNhc2UsIHBsZWFzZSBnaXZlIG1lIDI0aCB0byBkbyBhIGxpYmRybSByZWxlYXNl
IGJlZm9yZSBwdXNoaW5nLgo+ID4+PiBJIGhhZCB0byBwdXNoIHNvbWUgd29ya2Fyb3VuZHMgZm9y
IHRoZSBzYW5kYm94aW5nIG1lbnRpb25lZCBlYXJsaWVyIDotXAo+ID4+Pgo+ID4+PiBUaGFua3MK
PiA+Pj4gRW1pbAo+ID4+Cj4gPj4gT3VjaCwgSSBqdXN0IHB1c2hlZCB0aGUgcGF0Y2gsIGJ1dCBm
ZWVsIGZyZWUgdG8gY3V0IHRoZSByZWxlYXNlIGp1c3QgYmVmb3JlCj4gPj4gdGhhdCBjb21taXQu
Cj4gPj4KPiA+IFRoYXQgZG9lc24ndCBxdWl0ZSB3b3JrLiBCYXJyaW5nIGFueSBvYmplY3Rpb25z
IEknbGw6IHJldmVydCwgcmVsZWFzZSwgcmVhcHBseS4KPiA+Cj4gPiAtRW1pbAo+ID4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+IGRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKPiA+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCj4KPiBX
aGF0IGhhcHBlbmVkIGhlcmU/IEkgY2FuJ3QgcmVhbGx5IHNlZSBteSBjb21taXQgbm9yIGEgcmV2
ZXJ0IG5vciBhCj4gcmVsZWFzZSBpbiBsaWJkcm0uCj4KQ29taW5nIGJhY2sgZnJvbSBob2xpZGF5
cytYREMuIEknIG0gZG9pbmcgYSByZWxlYXNlIGluIGEgbW9tZW50IGFuZAp3aWxsIHBpY2sgeW91
ciBwYXRjaCBqdXN0IGFmdGVyIHRoYXQuCgpIbW0geW91IHNhaWQgeW91IHB1c2hlZCB0aGUgcGF0
Y2gsIHlldCBpdCdzIG5vdCBpbiBtYXN0ZXIgLi4uIE5vdCBzdXJlCndoYXQgaGFwcGVuZWQgdGhl
cmUuCkVpdGhlciB3YXkgLSBpdCdsbCBiZSB0aGVyZSBzaG9ydGx5LgoKVGhhbmtzCkVtaWwKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
