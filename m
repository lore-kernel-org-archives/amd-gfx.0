From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH 2/2] drm/scheduler: Remove obsolete spinlock.
Date: Wed, 16 May 2018 10:25:49 -0400
Message-ID: <f57485c2-1b66-5282-cc8d-c9c88c7ba1a9@amd.com>
References: <1526412674-15913-1-git-send-email-andrey.grodzovsky@amd.com>
 <1526412674-15913-2-git-send-email-andrey.grodzovsky@amd.com>
 <dda4fb88-e228-e10b-46a5-27ba9888b78d@amd.com>
 <MWHPR12MB14530840CD7DB545DD286827EA920@MWHPR12MB1453.namprd12.prod.outlook.com>
 <3a54ce0c-6821-9c94-a67f-2b1a3c74959d@amd.com>
 <8f358856-f16d-3622-d28b-32fed49ba4aa@amd.com>
 <0d936838-8a88-9bd7-d4ff-053cd73f41cc@gmail.com>
 <72266649-c75c-15d3-41b6-59f2dd10235d@amd.com>
 <0be3bb9a-004a-7390-469c-3f974ed44055@amd.com>
 <1526473713.10230.1.camel@pengutronix.de>
 <755d0607-4191-55d2-a21a-9a87305499ad@gmail.com>
 <1526475600.10230.3.camel@pengutronix.de>
 <96b4e712-5e80-0053-301e-3f89940be8f0@amd.com>
 <1526476562.10230.5.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1526476562.10230.5.camel@pengutronix.de>
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
To: Lucas Stach <l.stach@pengutronix.de>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

CgpPbiAwNS8xNi8yMDE4IDA5OjE2IEFNLCBMdWNhcyBTdGFjaCB3cm90ZToKPiBBbSBNaXR0d29j
aCwgZGVuIDE2LjA1LjIwMTgsIDE1OjEwICswMjAwIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoK
Pj4gQW0gMTYuMDUuMjAxOCB1bSAxNTowMCBzY2hyaWViIEx1Y2FzIFN0YWNoOgo+Pj4gQW0gTWl0
dHdvY2gsIGRlbiAxNi4wNS4yMDE4LCAxNDozMiArMDIwMCBzY2hyaWViIENocmlzdGlhbiBLw7Zu
aWc6Cj4+Pj4gQW0gMTYuMDUuMjAxOCB1bSAxNDoyOCBzY2hyaWViIEx1Y2FzIFN0YWNoOgo+Pj4+
PiBBbSBNaXR0d29jaCwgZGVuIDE2LjA1LjIwMTgsIDE0OjA4ICswMjAwIHNjaHJpZWIgQ2hyaXN0
aWFuIEvDtm5pZzoKPj4+Pj4+IFllcywgZXhhY3RseS4KPj4+Pj4+Cj4+Pj4+PiBGb3Igbm9ybWFs
IHVzZXIgc3BhY2UgY29tbWFuZCBzdWJtaXNzaW9uIHdlIHNob3VsZCBoYXZlIHRvbnMgb2YKPj4+
Pj4+IGxvY2tzCj4+Pj4+PiBndWFyYW50ZWVpbmcgdGhhdCAoZS5nLiBqdXN0IHRoZSBWTSBsb2Nr
IHNob3VsZCBkbykuCj4+Pj4+Pgo+Pj4+Pj4gRm9yIGtlcm5lbCBtb3ZlcyB3ZSBoYXZlIHRoZSBt
dXRleCBmb3IgdGhlIEdUVCB3aW5kb3dzIHdoaWNoCj4+Pj4+PiBwcm90ZWN0cwo+Pj4+Pj4gaXQu
Cj4+Pj4+Pgo+Pj4+Pj4gVGhlIGNvdWxkIGJlIHByb2JsZW1zIHdpdGggdGhlIFVWRC9WQ0UgcXVl
dWVzIHRvIGNsZWFudXAgdGhlCj4+Pj4+PiBoYW5kbGVzCj4+Pj4+PiB3aGVuIGFuIGFwcGxpY2F0
aW9uIGNyYXNoZXMuCj4+Pj4+IEZXSVcsIGV0bmF2aXYgaXMgY3VycmVudGx5IGNvbXBsZXRlbHkg
dW5sb2NrZWQgaW4gdGhpcyBwYXRoLCBidXQgSQo+Pj4+PiBiZWxpZXZlIHRoYXQgdGhpcyBpc24n
dCBhbiBpc3N1ZSBhcyB0aGUgc2NoZWQgZmVuY2Ugc2VxIG51bWJlcnMgYXJlCj4+Pj4+IHBlcgo+
Pj4+PiBlbnRpdHkuIFNvIHRvIGFjdHVhbGx5IGVuZCB1cCB3aXRoIHJldmVyc2VkIHNlcW5vcyBv
bmUgY29udGV4dCBoYXMKPj4+Pj4gdG8KPj4+Pj4gcHJlZW1wdCBpdHNlbGYgdG8gZG8gYW5vdGhl
ciBzdWJtaXQsIHdoaWxlIHRoZSBjdXJyZW50IG9uZSBoYXNuJ3QKPj4+Pj4gcmV0dXJuZWQgZnJv
bSBrZXJuZWwgc3BhY2UsIHdoaWNoIEkgYmVsaWV2ZSBpcyBhIGZhaXJseSB0aGVvcmV0aWNhbAo+
Pj4+PiBpc3N1ZS4gSXMgbXkgdW5kZXJzdGFuZGluZyBjb3JyZWN0Pwo+Pj4+IFllcy4gVGhlIHBy
b2JsZW0gaXMgd2l0aCB0aGUgcmlnaHQgdGltaW5nIHRoaXMgY2FuIGJlIHVzZWQgdG8gYWNjZXNz
Cj4+Pj4gZnJlZWQgdXAgbWVtb3J5Lgo+Pj4+Cj4+Pj4gSWYgeW91IHRoZW4gbWFuYWdlIHRvIHBs
YWNlIGEgcGFnZSB0YWJsZSBpbiB0aGF0IGZyZWVkIHVwIG1lbW9yeQo+Pj4+IHRha2luZwo+Pj4+
IG92ZXIgdGhlIHN5c3RlbSBpcyBqdXN0IGEgdHlwaW5nIGV4ZXJjaXNlLgo+Pj4gVGhhbmtzLiBJ
IGJlbGlldmUgd2UgZG9uJ3QgaGF2ZSB0aGlzIHByb2JsZW0gaW4gZXRuYXZpdiwgYXMgbWVtb3J5
Cj4+PiByZWZlcmVuY2luZyBpcyB0aWVkIHRvIHRoZSBqb2IgYW5kIHdpbGwgb25seSBiZSB1bnJl
ZmVyZW5jZWQgb24KPj4+IGZyZWVfam9iLCBidXQgSSdsbCByZS1jaGVjayB0aGlzIHdoZW4gSSd2
ZSBnb3Qgc29tZSB0aW1lLgo+PiBXZWxsIHRoYXQgZGVwZW5kcyBvbiBob3cgeW91IHVzZSB0aGUg
c2VxdWVuY2UgbnVtYmVycy4KPj4KPj4gSWYgeW91IHVzZSB0aGVtIGZvciBqb2IgY29tcGxldGlv
biBjaGVjayBzb21ld2hlcmUgdGhlbiB5b3UgY2VydGFpbmx5Cj4+IGhhdmUgYSBwcm9ibGVtIGlm
IGpvYiBBIGdldHMgdGhlIDEgYW5kIEIgdGhlIDIsIGJ1dCBCIGNvbXBsZXRlcyBiZWZvcmUgQS4K
PiBXZSBkb24ndCBkbyB0aGlzIGFueW1vcmUuIEFsbCB0aGUgZXRuYXZpdiBpbnRlcm5hbHMgYXJl
IGRyaXZlbiBieSB0aGUKPiBmZW5jZSBzaWduYWwgY2FsbGJhY2tzLgo+Cj4+IEF0IGJhcmUgbWlu
aW11bSB0aGF0J3Mgc3RpbGwgYSBidWcgd2UgbmVlZCB0byBmaXggYmVjYXVzZSBpdCBjb25mdXNl
cwo+PiBmdW5jdGlvbnMgbGlrZSBkbWFfZmVuY2VfaXNfbGF0ZXIoKSBhbmQgZG1hX2ZlbmNlX2xh
dGVyKCkuCj4gQWdyZWVkLiBBbHNvIGFtZW5kaW5nIHRoZSBkb2N1bWVudGF0aW9uIHRvIHN0YXRl
IHRoYXQKPiBkcm1fc2NoZWRfam9iX2luaXQoKSBhbmQgZHJtX3NjaGVkX2VudGl0eV9wdXNoX2pv
YigpIG5lZWQgdG8gYmUgY2FsbGVkCj4gdW5kZXIgYSBjb21tb24gbG9jayBzZWVtcyBsaWtlIGEg
Z29vZCBpZGVhLgoKSSB3aWxsIHJlc3BpbiB0aGUgcGF0Y2ggd2l0aCBhZGRlZCBkb2N1bWVudGF0
aW9uLgoKQW5kcmV5Cgo+IFJlZ2FyZHMsCj4gTHVjYXMKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
