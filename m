From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Thu, 24 Jan 2019 17:04:37 +0100
Message-ID: <66a7aa82-3ebd-55c3-0263-ee9694294896@daenzer.net>
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <20190124091316.GA22796@infradead.org>
 <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
 <CAKv+Gu_3LurSN-6w1WijPfpJpc+Pgu0YTnwTfMrXMF3-AKAnJA@mail.gmail.com>
 <953e5e5f-5d47-d6df-40df-c8c94db5447f@amd.com>
 <CAKv+Gu9umPEmB+wh54NOTYcQ14oxf7rwVAXgCqo7V2A+VwkqPA@mail.gmail.com>
 <57590a48-4629-e2a1-8673-ce9eb2ec210b@amd.com>
 <CAKv+Gu_2f0FaJ+Th7H48u4GrPX=MM9xw0fFjdwhfRrr1nhgEkA@mail.gmail.com>
 <40ad3ae7-9970-0cb9-d35c-05e128f83820@amd.com>
 <CAKv+Gu_D4FC05Rz3Oxm_dTWLaGt+a3EDecbsrge1eHY7gFXEYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAKv+Gu_D4FC05Rz3Oxm_dTWLaGt+a3EDecbsrge1eHY7gFXEYg@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>, "Huang,
 Ray" <Ray.Huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>, Sean Paul <sean@poorly.run>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0wMS0yNCAxMjo0NSBwLm0uLCBBcmQgQmllc2hldXZlbCB3cm90ZToKPiBPbiBUaHUs
IDI0IEphbiAyMDE5IGF0IDEyOjM3LCBLb2VuaWcsIENocmlzdGlhbgo+IDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+IHdyb3RlOgo+PiBBbSAyNC4wMS4xOSB1bSAxMjoyNiBzY2hyaWViIEFyZCBC
aWVzaGV1dmVsOgo+Pj4gT24gVGh1LCAyNCBKYW4gMjAxOSBhdCAxMjoyMywgS29lbmlnLCBDaHJp
c3RpYW4KPj4+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Pj4+IEFtIDI0LjAx
LjE5IHVtIDEwOjU5IHNjaHJpZWIgQXJkIEJpZXNoZXV2ZWw6Cj4+Pj4+IFtTTklQXQo+Pj4+PiBU
aGlzIGlzICpleGFjdGx5KiBteSBwb2ludCB0aGUgd2hvbGUgdGltZS4KPj4+Pj4KPj4+Pj4gVGhl
IGN1cnJlbnQgY29kZSBoYXMKPj4+Pj4KPj4+Pj4gc3RhdGljIGlubGluZSBib29sIGRybV9hcmNo
X2Nhbl93Y19tZW1vcnkodm9pZCkKPj4+Pj4gewo+Pj4+PiAjaWYgZGVmaW5lZChDT05GSUdfUFBD
KSAmJiAhZGVmaW5lZChDT05GSUdfTk9UX0NPSEVSRU5UX0NBQ0hFKQo+Pj4+PiAgICAgIHJldHVy
biBmYWxzZTsKPj4+Pj4KPj4+Pj4gd2hpY2ggbWVhbnMgdGhlIG9wdGltaXphdGlvbiBpcyBkaXNh
YmxlZCAqdW5sZXNzIHRoZSBzeXN0ZW0gaXMKPj4+Pj4gbm9uLWNhY2hlIGNvaGVyZW50Kgo+Pj4+
Pgo+Pj4+PiBTbyBpZiB5b3UgaGF2ZSByZXBvcnRzIHRoYXQgdGhlIG9wdGltaXphdGlvbiB3b3Jr
cyBvbiBzb21lIFBvd2VyUEMsIGl0Cj4+Pj4+IG11c3QgYmUgbm9uLWNhY2hlIGNvaGVyZW50IFBv
d2VyUEMsIGJlY2F1c2UgdGhhdCBpcyB0aGUgb25seSBwbGFjZQo+Pj4+PiB3aGVyZSBpdCBpcyBl
bmFibGVkIGluIHRoZSBmaXJzdCBwbGFjZS4KPj4+Pj4KPj4+Pj4+IFRoZSBvbmx5IHByb2JsZW1h
dGljIGhlcmUgYWN0dWFsbHkgc2VlbXMgdG8gYmUgQVJNLCBzbyB5b3Ugc2hvdWxkCj4+Pj4+PiBw
cm9iYWJseSBqdXN0IGFkZCBhbiAiI2lmZGVmIC4uX0FSTSByZXR1cm4gZmFsc2U7Ii4KPj4+Pj4+
Cj4+Pj4+IEFSTS9hcm02NCBkb2VzIG5vdCBoYXZlIGEgS2NvbmZpZyBzeW1ib2wgbGlrZQo+Pj4+
PiBDT05GSUdfTk9UX0NPSEVSRU5UX0NBQ0hFLCBzbyB3ZSBjYW4gb25seSBkaXNhYmxlIGl0IGV2
ZXJ5d2hlcmUuIElmCj4+Pj4+IHRoZXJlIGFyZSBub24tY29oZXJlbnQgQVJNIHN5c3RlbXMgdGhh
dCBhcmUgY3VycmVudGx5IHdvcmtpbmcgaW4gdGhlCj4+Pj4+IHNhbWUgd2F5IGFzIHRob3NlIG5v
bi1jb2hlcmVudCBQb3dlclBDIHN5c3RlbXMsIHdlIHdpbGwgYnJlYWsgdGhlbSBieQo+Pj4+PiBk
b2luZyB0aGlzLgo+Pj4+IFN1bW1pbmcgdGhlIHRoaW5ncyBJJ3ZlIHJlYWQgc28gZmFyIGZvciBB
Uk0gdXAgSSBhY3R1YWxseSB0aGluayBpdAo+Pj4+IGRlcGVuZHMgb24gYSBydW50aW1lIGNvbmZp
Z3VyYXRpb24gYW5kIG5vdCBvbiBjb21waWxlIHRpbWUgb25lLgo+Pj4+Cj4+Pj4gU28gdGhlIHdo
b2xlIGlkZWEgb2YgcHJvdmlkaW5nIHRoZSBkZXZpY2UgdG8gdGhlIGRybV8qX2Nhbl93Y19tZW1v
cnkoKQo+Pj4+IGZ1bmN0aW9uIGlzbid0IHNvIGZhciBmZXRjaGVkLgo+Pj4+Cj4+PiBUaGFuayB5
b3UuCj4+Pgo+Pj4+IEJ1dCBmb3Igbm93IEkgZG8gcHJlZmVyIHdvcmtpbmcgYW5kIHNsaWdodGx5
IHNsb3dlciBzeXN0ZW0gb3ZlciBicm9rZW4KPj4+PiBvbmUsIHNvIEkgdGhpbmsgd2Ugc2hvdWxk
IGp1c3QgZGlzYWJsZSB0aGlzIG9uIEFSTSBmb3Igbm93Lgo+Pj4+Cj4+PiBBZ2FpbiwgdGhpcyBp
cyBub3QgYWJvdXQgbm9uLWNhY2hlIGNvaGVyZW50IGJlaW5nIHNsb3dlciB3aXRob3V0IHRoZQo+
Pj4gb3B0aW1pemF0aW9uLCBpdCBpcyBhYm91dCBub24tY2FjaGUgY29oZXJlbnQgbGlrZWx5IG5v
dCB3b3JraW5nICphdAo+Pj4gYWxsKiB1bmxlc3MgdGhlIG9wdGltaXphdGlvbiBpcyBlbmFibGVk
Lgo+Pgo+PiBBcyBNaWNoZWwgdHJpZWQgdG8gZXhwbGFpbiB0aGlzIENBTidUIGhhcHBlbi4gVGhl
IG9wdGltaXphdGlvbiBpcyBhCj4+IHB1cmVseSBvcHRpb25hbCByZXF1ZXN0IGZyb20gdXNlcnNw
YWNlLgo+Pgo+IAo+IFJpZ2h0Lgo+IAo+IFNvIGluIHRoYXQgY2FzZSwgd2UgY2FuIGFzc3VtZSB0
aGF0IHRoZSBmb2xsb3dpbmcgdGVzdAo+IAo+IHN0YXRpYyBpbmxpbmUgYm9vbCBkcm1fYXJjaF9j
YW5fd2NfbWVtb3J5KHZvaWQpCj4gewo+ICNpZiBkZWZpbmVkKENPTkZJR19QUEMpICYmICFkZWZp
bmVkKENPTkZJR19OT1RfQ09IRVJFTlRfQ0FDSEUpCj4gICAgIHJldHVybiBmYWxzZTsKPiAKPiBp
cyBib2d1cywgYW5kIGl0IHdhcyBqdXN0IHVubmVjZXNzYXJ5IGNhdXRpb24gb24gdGhlIHBhcnQg
b2YgdGhlCj4gYXV0aG9yIHRvIGRpc3JlZ2FyZCBub24tY2FjaGUgY29oZXJlbnQgZGV2aWNlcy4K
ClRoaXMgaXMgZHJpdmVyLWluZGVwZW5kZW50IGNvcmUgY29kZSwgbWVhbmluZyAibm9uLXNub29w
ZWQgUENJZQp0cmFuc2ZlcnMgZG9uJ3Qgd29yayBvbiBjYWNoZSBjb2hlcmVudCBQUEMiLiBJdCBk
b2Vzbid0IGltcGx5IGFueXRoaW5nCmFib3V0IHdoZXRoZXIgb3Igbm90IGFtZGdwdSBvciBhbnkg
b3RoZXIgZHJpdmVyIHdvcmtzIG9uCm5vbi1jYWNoZS1jb2hlcmVudCBQUEMgaW4gZ2VuZXJhbC4K
CgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
