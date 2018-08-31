From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH libdrm] libdrm: Allow dynamic drm majors on linux
Date: Fri, 31 Aug 2018 16:27:46 +0100
Message-ID: <CACvgo53Wd1fq8=V_v7jjuFGimUfh7xD+ccCg-jOTjLSJdWUKeA@mail.gmail.com>
References: <20180831115419.4922-1-thellstrom@vmware.com>
 <CACvgo50fT1JAfmCLeZT1STRe_nnPo9PQjgk9+S5VRk-o5P088w@mail.gmail.com>
 <bbb94b6f-c9d5-27ab-9e6d-4b4c1d85db8e@vmware.com>
 <33fb1ba6-cc44-f747-545b-9f877917933e@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <33fb1ba6-cc44-f747-545b-9f877917933e@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Thomas Hellstrom <thellstrom@vmware.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, ML dri-devel <dri-devel@lists.freedesktop.org>, VMware Graphics <linux-graphics-maintainer@vmware.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMzEgQXVndXN0IDIwMTggYXQgMTU6MzgsIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnpl
ci5uZXQ+IHdyb3RlOgo+Cj4gWyBBZGRpbmcgdGhlIGFtZC1nZnggbGlzdCBdCj4KPiBPbiAyMDE4
LTA4LTMxIDM6MDUgcC5tLiwgVGhvbWFzIEhlbGxzdHJvbSB3cm90ZToKPj4gT24gMDgvMzEvMjAx
OCAwMjozMCBQTSwgRW1pbCBWZWxpa292IHdyb3RlOgo+Pj4gT24gMzEgQXVndXN0IDIwMTggYXQg
MTI6NTQsIFRob21hcyBIZWxsc3Ryb20gPHRoZWxsc3Ryb21Adm13YXJlLmNvbT4KPj4+IHdyb3Rl
Ogo+Pj4+IFRvIGRldGVybWluZSB3aGV0aGVyIGEgZGV2aWNlIG5vZGUgaXMgYSBkcm0gZGV2aWNl
IG5vZGUgb3Igbm90LCB0aGUgY29kZQo+Pj4+IGN1cnJlbnRseSBjb21wYXJlcyB0aGUgbm9kZSdz
IG1ham9yIG51bWJlciB0byB0aGUgc3RhdGljIGRybSBtYWpvcgo+Pj4+IGRldmljZQo+Pj4+IG51
bWJlci4KPj4+Pgo+Pj4+IFRoaXMgYnJlYWtzIHRoZSBzdGFuZGFsb25lIHZtd2dmeCBkcml2ZXIg
b24gWFdheWxhbmQgZHJpIGNsaWVudHMsCj4+Pj4KPj4+IEFueSBwYXJ0aWN1bGFyIHJlYXNvbiB3
aHkgdGhlIGNvZGUgZG9lc24ndCB1c2UgYSBmaXhlZCBub2RlIHRoZXJlPwo+Pj4gSXQgd2lsbCBt
YWtlIHRoZSBkaWZmIHZzIHRoZSBpbi1rZXJuZWwgZHJpdmVyIGEgYml0IHNtYWxsZXIuCj4+IEJl
Y2F1c2UgdGhlbiBpdCB3b24ndCBiZSBhYmxlIHRvIGludGVyb3BlcmF0ZSB3aXRoIG90aGVyIGlu
LXRyZWUKPj4gZHJpdmVycywgbGlrZSB2aXJ0dWFsIGRybSBkcml2ZXJzIG9yIHBhc3N0aHJvdWdo
IHVzYiBkcm0gZHJpdmVycy4KPj4gVGhlcmUgaXMgbm8gY2xlYW4gd2F5IHRvIHNoYXJlIHRoZSBt
aW5vciBudW1iZXIgYWxsb2NhdGlvbiB3aXRoIGluLXRyZWUKPj4gZHJtLCBzbyBzdGFuZGFsb25l
IHZtd2dmeCBpcyB1c2luZyBkeW5hbWljIG1ham9yIGFsbG9jYXRpb24uCj4KPiBJIHdvbmRlciB3
aHkgSSBoYXZlbid0IGhlYXJkIG9mIGFueSBvZiB0aGVzZSBpc3N1ZXMgd2l0aCB0aGUgc3RhbmRh
bG9uZQo+IHZlcnNpb24gb2YgYW1kZ3B1IHNoaXBwZWQgaW4gcGFja2FnZWQgQU1EIHJlbGVhc2Vz
LiBEb2VzIHRoYXQgYWxzbyB1c2UgYQo+IGRpZmZlcmVudCBtYWpvciBudW1iZXI/IElmIHllcywg
bWF5YmUgaXQncyBqdXN0IHRoYXQgbm9ib2R5IGhhcyB0cmllZAo+IFh3YXlsYW5kIGNsaWVudHMg
d2l0aCB0aGF0IGRyaXZlci4gSWYgbm8sIGhvdyBkb2VzIGl0IGF2b2lkIHRoZSBvdGhlcgo+IGlz
c3VlcyBkZXNjcmliZWQgYWJvdmU/Cj4KQUZBSUNULCB0aGUgZGlmZmVyZW5jZSBpcyB0aGF0IHRo
ZSBzdGFuZGFsb25lIHZtd2dmeCB1c2VzIGFuIGludGVybmFsCmNvcHkgb2YgZHJtIGNvcmUuCkl0
IGRvZXNuJ3QgcmV1c2UgdGhlIGluLWtlcm5lbCBkcm0sIGhlbmNlIGl0IGNhbm5vdCBrbm93IHdo
aWNoIG1pbm9yIGl0IGNhbiB1c2UuCgotRW1pbApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwK
