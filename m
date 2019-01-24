From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Thu, 24 Jan 2019 11:23:44 +0000
Message-ID: <57590a48-4629-e2a1-8673-ce9eb2ec210b@amd.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAKv+Gu9umPEmB+wh54NOTYcQ14oxf7rwVAXgCqo7V2A+VwkqPA@mail.gmail.com>
Content-Language: en-US
Content-ID: <9F6D95F38827FC45AA3D1323D4075171@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Michael Ellerman <mpe@ellerman.id.au>, =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>, Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>, "Huang, Ray" <Ray.Huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjQuMDEuMTkgdW0gMTA6NTkgc2NocmllYiBBcmQgQmllc2hldXZlbDoNCj4gW1NOSVBdDQo+
IFRoaXMgaXMgKmV4YWN0bHkqIG15IHBvaW50IHRoZSB3aG9sZSB0aW1lLg0KPg0KPiBUaGUgY3Vy
cmVudCBjb2RlIGhhcw0KPg0KPiBzdGF0aWMgaW5saW5lIGJvb2wgZHJtX2FyY2hfY2FuX3djX21l
bW9yeSh2b2lkKQ0KPiB7DQo+ICNpZiBkZWZpbmVkKENPTkZJR19QUEMpICYmICFkZWZpbmVkKENP
TkZJR19OT1RfQ09IRVJFTlRfQ0FDSEUpDQo+ICAgICByZXR1cm4gZmFsc2U7DQo+DQo+IHdoaWNo
IG1lYW5zIHRoZSBvcHRpbWl6YXRpb24gaXMgZGlzYWJsZWQgKnVubGVzcyB0aGUgc3lzdGVtIGlz
DQo+IG5vbi1jYWNoZSBjb2hlcmVudCoNCj4NCj4gU28gaWYgeW91IGhhdmUgcmVwb3J0cyB0aGF0
IHRoZSBvcHRpbWl6YXRpb24gd29ya3Mgb24gc29tZSBQb3dlclBDLCBpdA0KPiBtdXN0IGJlIG5v
bi1jYWNoZSBjb2hlcmVudCBQb3dlclBDLCBiZWNhdXNlIHRoYXQgaXMgdGhlIG9ubHkgcGxhY2UN
Cj4gd2hlcmUgaXQgaXMgZW5hYmxlZCBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+DQo+PiBUaGUgb25s
eSBwcm9ibGVtYXRpYyBoZXJlIGFjdHVhbGx5IHNlZW1zIHRvIGJlIEFSTSwgc28geW91IHNob3Vs
ZA0KPj4gcHJvYmFibHkganVzdCBhZGQgYW4gIiNpZmRlZiAuLl9BUk0gcmV0dXJuIGZhbHNlOyIu
DQo+Pg0KPiBBUk0vYXJtNjQgZG9lcyBub3QgaGF2ZSBhIEtjb25maWcgc3ltYm9sIGxpa2UNCj4g
Q09ORklHX05PVF9DT0hFUkVOVF9DQUNIRSwgc28gd2UgY2FuIG9ubHkgZGlzYWJsZSBpdCBldmVy
eXdoZXJlLiBJZg0KPiB0aGVyZSBhcmUgbm9uLWNvaGVyZW50IEFSTSBzeXN0ZW1zIHRoYXQgYXJl
IGN1cnJlbnRseSB3b3JraW5nIGluIHRoZQ0KPiBzYW1lIHdheSBhcyB0aG9zZSBub24tY29oZXJl
bnQgUG93ZXJQQyBzeXN0ZW1zLCB3ZSB3aWxsIGJyZWFrIHRoZW0gYnkNCj4gZG9pbmcgdGhpcy4N
Cg0KU3VtbWluZyB0aGUgdGhpbmdzIEkndmUgcmVhZCBzbyBmYXIgZm9yIEFSTSB1cCBJIGFjdHVh
bGx5IHRoaW5rIGl0IA0KZGVwZW5kcyBvbiBhIHJ1bnRpbWUgY29uZmlndXJhdGlvbiBhbmQgbm90
IG9uIGNvbXBpbGUgdGltZSBvbmUuDQoNClNvIHRoZSB3aG9sZSBpZGVhIG9mIHByb3ZpZGluZyB0
aGUgZGV2aWNlIHRvIHRoZSBkcm1fKl9jYW5fd2NfbWVtb3J5KCkgDQpmdW5jdGlvbiBpc24ndCBz
byBmYXIgZmV0Y2hlZC4NCg0KQnV0IGZvciBub3cgSSBkbyBwcmVmZXIgd29ya2luZyBhbmQgc2xp
Z2h0bHkgc2xvd2VyIHN5c3RlbSBvdmVyIGJyb2tlbiANCm9uZSwgc28gSSB0aGluayB3ZSBzaG91
bGQganVzdCBkaXNhYmxlIHRoaXMgb24gQVJNIGZvciBub3cuDQoNCkNocmlzdGlhbi4NCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
