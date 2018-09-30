From: Thomas Hellstrom <thomas@shipmail.org>
Subject: Re: [PATCH libdrm] libdrm: Allow dynamic drm majors on linux
Date: Sun, 30 Sep 2018 19:31:17 +0200
Message-ID: <a3af864a-8914-3bef-ff26-02c7672a9e50@shipmail.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CACvgo52dj75j--gi8UrUZ9txpAjRXRpKzr-QaH92deS1=Lfk_w@mail.gmail.com>
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
To: Emil Velikov <emil.l.velikov@gmail.com>, Thomas Hellstrom <thellstrom@vmware.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, VMware Graphics <linux-graphics-maintainer@vmware.com>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

SGksIEVtaWwsCgpPbiAwOS8wNS8yMDE4IDAzOjUzIFBNLCBFbWlsIFZlbGlrb3Ygd3JvdGU6Cj4g
T24gNSBTZXB0ZW1iZXIgMjAxOCBhdCAxNDoyMCwgVGhvbWFzIEhlbGxzdHJvbSA8dGhlbGxzdHJv
bUB2bXdhcmUuY29tPiB3cm90ZToKPgo+Pj4gSW4gdGhhdCBjYXNlLCBwbGVhc2UgZ2l2ZSBtZSAy
NGggdG8gZG8gYSBsaWJkcm0gcmVsZWFzZSBiZWZvcmUgcHVzaGluZy4KPj4+IEkgaGFkIHRvIHB1
c2ggc29tZSB3b3JrYXJvdW5kcyBmb3IgdGhlIHNhbmRib3hpbmcgbWVudGlvbmVkIGVhcmxpZXIg
Oi1cCj4+Pgo+Pj4gVGhhbmtzCj4+PiBFbWlsCj4+Cj4+IE91Y2gsIEkganVzdCBwdXNoZWQgdGhl
IHBhdGNoLCBidXQgZmVlbCBmcmVlIHRvIGN1dCB0aGUgcmVsZWFzZSBqdXN0IGJlZm9yZQo+PiB0
aGF0IGNvbW1pdC4KPj4KPiBUaGF0IGRvZXNuJ3QgcXVpdGUgd29yay4gQmFycmluZyBhbnkgb2Jq
ZWN0aW9ucyBJJ2xsOiByZXZlcnQsIHJlbGVhc2UsIHJlYXBwbHkuCj4KPiAtRW1pbAo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1h
aWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAoKV2hhdCBoYXBw
ZW5lZCBoZXJlPyBJIGNhbid0IHJlYWxseSBzZWUgbXkgY29tbWl0IG5vciBhIHJldmVydCBub3Ig
YSAKcmVsZWFzZSBpbiBsaWJkcm0uCgovVGhvbWFzCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZHJpLWRldmVsCg==
