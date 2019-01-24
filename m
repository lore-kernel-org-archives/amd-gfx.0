From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Thu, 24 Jan 2019 11:37:32 +0000
Message-ID: <40ad3ae7-9970-0cb9-d35c-05e128f83820@amd.com>
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAKv+Gu_2f0FaJ+Th7H48u4GrPX=MM9xw0fFjdwhfRrr1nhgEkA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <59400AED9633BA419EDBE63373A4A150-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

QW0gMjQuMDEuMTkgdW0gMTI6MjYgc2NocmllYiBBcmQgQmllc2hldXZlbDoNCj4gT24gVGh1LCAy
NCBKYW4gMjAxOSBhdCAxMjoyMywgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT4gd3JvdGU6DQo+PiBBbSAyNC4wMS4xOSB1bSAxMDo1OSBzY2hyaWViIEFyZCBC
aWVzaGV1dmVsOg0KPj4+IFtTTklQXQ0KPj4+IFRoaXMgaXMgKmV4YWN0bHkqIG15IHBvaW50IHRo
ZSB3aG9sZSB0aW1lLg0KPj4+DQo+Pj4gVGhlIGN1cnJlbnQgY29kZSBoYXMNCj4+Pg0KPj4+IHN0
YXRpYyBpbmxpbmUgYm9vbCBkcm1fYXJjaF9jYW5fd2NfbWVtb3J5KHZvaWQpDQo+Pj4gew0KPj4+
ICNpZiBkZWZpbmVkKENPTkZJR19QUEMpICYmICFkZWZpbmVkKENPTkZJR19OT1RfQ09IRVJFTlRf
Q0FDSEUpDQo+Pj4gICAgICByZXR1cm4gZmFsc2U7DQo+Pj4NCj4+PiB3aGljaCBtZWFucyB0aGUg
b3B0aW1pemF0aW9uIGlzIGRpc2FibGVkICp1bmxlc3MgdGhlIHN5c3RlbSBpcw0KPj4+IG5vbi1j
YWNoZSBjb2hlcmVudCoNCj4+Pg0KPj4+IFNvIGlmIHlvdSBoYXZlIHJlcG9ydHMgdGhhdCB0aGUg
b3B0aW1pemF0aW9uIHdvcmtzIG9uIHNvbWUgUG93ZXJQQywgaXQNCj4+PiBtdXN0IGJlIG5vbi1j
YWNoZSBjb2hlcmVudCBQb3dlclBDLCBiZWNhdXNlIHRoYXQgaXMgdGhlIG9ubHkgcGxhY2UNCj4+
PiB3aGVyZSBpdCBpcyBlbmFibGVkIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4+Pg0KPj4+PiBUaGUg
b25seSBwcm9ibGVtYXRpYyBoZXJlIGFjdHVhbGx5IHNlZW1zIHRvIGJlIEFSTSwgc28geW91IHNo
b3VsZA0KPj4+PiBwcm9iYWJseSBqdXN0IGFkZCBhbiAiI2lmZGVmIC4uX0FSTSByZXR1cm4gZmFs
c2U7Ii4NCj4+Pj4NCj4+PiBBUk0vYXJtNjQgZG9lcyBub3QgaGF2ZSBhIEtjb25maWcgc3ltYm9s
IGxpa2UNCj4+PiBDT05GSUdfTk9UX0NPSEVSRU5UX0NBQ0hFLCBzbyB3ZSBjYW4gb25seSBkaXNh
YmxlIGl0IGV2ZXJ5d2hlcmUuIElmDQo+Pj4gdGhlcmUgYXJlIG5vbi1jb2hlcmVudCBBUk0gc3lz
dGVtcyB0aGF0IGFyZSBjdXJyZW50bHkgd29ya2luZyBpbiB0aGUNCj4+PiBzYW1lIHdheSBhcyB0
aG9zZSBub24tY29oZXJlbnQgUG93ZXJQQyBzeXN0ZW1zLCB3ZSB3aWxsIGJyZWFrIHRoZW0gYnkN
Cj4+PiBkb2luZyB0aGlzLg0KPj4gU3VtbWluZyB0aGUgdGhpbmdzIEkndmUgcmVhZCBzbyBmYXIg
Zm9yIEFSTSB1cCBJIGFjdHVhbGx5IHRoaW5rIGl0DQo+PiBkZXBlbmRzIG9uIGEgcnVudGltZSBj
b25maWd1cmF0aW9uIGFuZCBub3Qgb24gY29tcGlsZSB0aW1lIG9uZS4NCj4+DQo+PiBTbyB0aGUg
d2hvbGUgaWRlYSBvZiBwcm92aWRpbmcgdGhlIGRldmljZSB0byB0aGUgZHJtXypfY2FuX3djX21l
bW9yeSgpDQo+PiBmdW5jdGlvbiBpc24ndCBzbyBmYXIgZmV0Y2hlZC4NCj4+DQo+IFRoYW5rIHlv
dS4NCj4NCj4+IEJ1dCBmb3Igbm93IEkgZG8gcHJlZmVyIHdvcmtpbmcgYW5kIHNsaWdodGx5IHNs
b3dlciBzeXN0ZW0gb3ZlciBicm9rZW4NCj4+IG9uZSwgc28gSSB0aGluayB3ZSBzaG91bGQganVz
dCBkaXNhYmxlIHRoaXMgb24gQVJNIGZvciBub3cuDQo+Pg0KPiBBZ2FpbiwgdGhpcyBpcyBub3Qg
YWJvdXQgbm9uLWNhY2hlIGNvaGVyZW50IGJlaW5nIHNsb3dlciB3aXRob3V0IHRoZQ0KPiBvcHRp
bWl6YXRpb24sIGl0IGlzIGFib3V0IG5vbi1jYWNoZSBjb2hlcmVudCBsaWtlbHkgbm90IHdvcmtp
bmcgKmF0DQo+IGFsbCogdW5sZXNzIHRoZSBvcHRpbWl6YXRpb24gaXMgZW5hYmxlZC4NCg0KQXMg
TWljaGVsIHRyaWVkIHRvIGV4cGxhaW4gdGhpcyBDQU4nVCBoYXBwZW4uIFRoZSBvcHRpbWl6YXRp
b24gaXMgYSANCnB1cmVseSBvcHRpb25hbCByZXF1ZXN0IGZyb20gdXNlcnNwYWNlLg0KDQo+IE90
aGVyd2lzZSwgdGhlIGRyaXZlciB3aWxsIHZtYXAoKSBETUEgcGFnZXMgd2l0aCBjYWNoZWFibGUg
YXR0cmlidXRlcywNCj4gd2hpbGUgdGhlIG5vbi1jYWNoZSBjb2hlcmVudCBkZXZpY2UgdXNlcyB1
bmNhY2hlZCBhdHRyaWJ1dGVzLCBicmVha2luZw0KPiBjb2hlcmVuY3kuDQoNCkFnYWluIHRoaXMg
aXMgbWFuZGF0ZWQgYnkgdGhlIHVzZXJzcGFjZSBBUElzIGFueXdheS4gRS5nLiB3ZSBjYW4ndCAN
CnZtYXAoKSBwYWdlcyBpbiBhbnkgb3RoZXIgd2F5IG9yIG91ciB1c2Vyc3BhY2UgQVBJcyB3b3Vs
ZCBicmVhay4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
