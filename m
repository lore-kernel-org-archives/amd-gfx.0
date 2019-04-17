From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH libdrm] libdrm: Fix issue about differrent domainID but
 same BDF
Date: Wed, 17 Apr 2019 19:26:17 +0100
Message-ID: <CACvgo53kFFRbrr+DHd6sizDQTK7TYTKN0JHHWrOL1Wk9-+gS7g@mail.gmail.com>
References: <1550130818-28008-1-git-send-email-Emily.Deng@amd.com>
 <CADnq5_Mny2NtWS1g07k+mKJngrCYk+9HzKiTVE9rMxM9vy9Uug@mail.gmail.com>
 <BN7PR12MB2644451E74B12311A8F32CE28F7F0@BN7PR12MB2644.namprd12.prod.outlook.com>
 <CADnq5_N50TSvfsjnZ+=-BWdaOn48ajVtxj4WOLVkgiKk2dBr4Q@mail.gmail.com>
 <CACvgo53VyaApCBZ-LLtRee8VSEMnXo2CKDGntKEgWr8Vhvg9pA@mail.gmail.com>
 <BN6PR12MB1809960E2DA180FABF62384FF77A0@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <BN6PR12MB1809960E2DA180FABF62384FF77A0@BN6PR12MB1809.namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Deng, Emily" <Emily.Deng@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCAyNSBGZWIgMjAxOSBhdCAxOTo1MywgRGV1Y2hlciwgQWxleGFuZGVyCjxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPiB3cm90ZToKPgo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0KPiA+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5v
cmc+IE9uIEJlaGFsZiBPZiBFbWlsCj4gPiBWZWxpa292Cj4gPiBTZW50OiBNb25kYXksIEZlYnJ1
YXJ5IDI1LCAyMDE5IDg6MDkgQU0KPiA+IFRvOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdt
YWlsLmNvbT4KPiA+IENjOiBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgTWFsaW5n
IGxpc3QgLSBEUkkgZGV2ZWxvcGVycyA8ZHJpLQo+ID4gZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPjsgYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4KPiA+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggbGliZHJtXSBsaWJkcm06IEZpeCBpc3N1ZSBhYm91dCBkaWZmZXJy
ZW50IGRvbWFpbklEIGJ1dAo+ID4gc2FtZSBCREYKPiA+Cj4gPiBIaSBhbGwsCj4gPgo+ID4gVGhp
cyBwYXRjaCBjYXVzZXMgdW5uZWNlc3Nhcnkgcm91bmQgdHJpcCBieSBvcGVubmluZyB0aGUgbm9k
ZXMuIEFzCj4gPiBtZW50aW9uZWQgcHJldmlvdXNseSB0aGlzIGNvdWxkIGJlIHRyaXZpYWxseSBm
aXhlZCBbMV0uCj4gPgo+ID4gRXZlbiBFbWlseSBhY2tub3dsZWRnZWQgdGhhdCBbMV0sIHlldCB0
aGUgc3ViLXBhciBmaXggd2FzIG1lcmdlZC4gQ2FuIHdlCj4gPiByZXZlcnQrZml4dXAgdGhpcyBw
cm9wZXJseT8KPiA+Cj4KPiBTb3JyeSwgSSB0b3RhbGx5IG1pc3NlZCB5b3VyIHJlcGx5LiAgSSdt
IGhhdmluZyBJbnRlcm5ldCBpc3N1ZXMgYXQgdGhlIG1vbWVudCBzbyBpZiB5b3Ugd2FudCB0byBy
ZXZlcnQgZm9yIG5vdywgSSdsbCB3b3JrIHdpdGggRW1pbHkgdG8gYWRkcmVzcyB5b3VyIHN1Z2dl
c3Rpb25zIGxhdGVyIGluIHRoZSB3ZWVrIG9yIG5leHQuICBFbWlseSwgY2FuIHlvdSB0YWtlIGEg
bG9vayBhdCBhZGRyZXNzaW5nIEVtaWwncyBjb25jZXJucyB3aXRoIGFuIHVwZGF0ZWQgcGF0Y2g/
Cj4KCkRvZXNuJ3Qgc2VlbSBsaWtlIHRoZXJlJ3MgYW55IGZvbGxvdy11cCB3b3JrIG9uIHRoaXMs
IHNvIEkndmUgcmV2ZXJ0ZWQKdGhpcyBmb3Igbm93LgpJJ20gYSBzYWQgcGFuZGEgZm9yIGRvaW5n
IGl0IC0gaG9wZWZ1bGx5IHYyIHdpbGwgY29tZSBzaG9ydGx5LgoKCi1FbWlsCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
