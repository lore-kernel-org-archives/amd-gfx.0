From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/i915: Before pageflip, also wait for shared dmabuf
 fences.
Date: Mon, 31 Oct 2016 17:06:46 +0900
Message-ID: <9cfe6998-6f02-8cf8-c69d-e71233145f39@daenzer.net>
References: <3f4643cb-52a9-d7ae-439b-5f6fc6e718cc@vodafone.de>
 <d2430ff8-43bd-bff2-9b02-847cabfd56c0@vodafone.de>
 <ed1a57a4-1409-6d07-998a-2b54f466f710@daenzer.net>
 <20160923120954.GH22164@dvetter-linux.ger.corp.intel.com>
 <8c21f70a-7f96-480e-9784-93f2d48f52bb@daenzer.net>
 <20160926080419.GV20761@phenom.ffwll.local>
 <CAHbf0-HZ6EotqwgvkxRTdRF97xB3qBA=DRKAzaAXguV_PR_P8w@mail.gmail.com>
 <d74d34a7-5221-d282-d9d1-b0e1007fc0c7@daenzer.net>
 <c77a2cb9-1f0e-f1a3-aedd-a111cd6ba8e8@vodafone.de>
 <e92512c7-4fb5-6fa1-e93f-0322d1537c46@daenzer.net>
 <CAHbf0-GGMWZrhB+PKpc-QbD__6fqB4pQVFfN+gzLWNhi+DuG3Q@mail.gmail.com>
 <720351a2-7597-aee3-58ce-9d65cad5762f@daenzer.net>
 <7eb19a73-a558-d2e6-bd8d-34fe95045dfd@gmail.com>
 <CAHbf0-H0owRAp_VXWd84E03OiPKXSE0jZ1=+OAtvoKuoSyt_=A@mail.gmail.com>
 <CAHbf0-EY2OM_HgxTjmMi4-f5TQ8fkqf5XYBxHZtJVsnSpxPyyA@mail.gmail.com>
 <c45e2f4c-c075-47b6-7e02-3bd98748c83a@daenzer.net>
 <c8b4f6fe-4348-f264-3ea2-ab7e105c1d78@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <c8b4f6fe-4348-f264-3ea2-ab7e105c1d78@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>, Mike Lothian <mike@fireburn.co.uk>, Mario Kleiner <mario.kleiner.de@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Nayan Deshmukh <nayan26deshmukh@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMzEvMTAvMTYgMDU6MDAgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMzEuMTAu
MjAxNiB1bSAwNzo0NCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBPbiAyOS8xMC8xNiAxMDo1
OCBQTSwgTWlrZSBMb3RoaWFuIHdyb3RlOgo+Pj4gSSB0dXJuZWQgb24gdnN5bmMgYW5kIGV2ZXJ5
dGhpbmcgd29ya3MgZ3JlYXQgaW4gdG9tYiByYWlkZXIKPj4+Cj4+PiA6RAo+Pj4KPj4+IFRoYW5r
cyBhZ2FpbiB0byBldmVyeW9uZSB3aG8gbWFkZSB0aGlzIHBvc3NpYmxlCj4+Pgo+Pj4gT24gRnJp
LCAyOCBPY3QgMjAxNiBhdCAxOTozNyBNaWtlIExvdGhpYW4gPG1pa2VAZmlyZWJ1cm4uY28udWsK
Pj4+IDxtYWlsdG86bWlrZUBmaXJlYnVybi5jby51az4+IHdyb3RlOgo+Pj4KPj4+ICAgICAgSGkg
TWFyaW8KPj4+Cj4+PiAgICAgIFRoYXQgZml4ZXMgdGhlIHRlYXJpbmcsIGl0J3MgYmVlbiByZXBs
YWNlZCB3aXRoIGEgc3RyYW5nZSBzdHV0dGVyLAo+Pj4gICAgICBsaWtlIGl0J3Mgb25seSBzaG93
aW5nIGhhbGYgdGhlIG51bWJlciBvZiBmcmFtZXMgYmVpbmcgcmVwb3J0ZWQgLQo+Pj4gICAgICBp
dCdzIHJlYWxseSBub3RpY2VhYmxlIGluIHRvbWIgcmFpZGVyCj4+IEkgd29uZGVyIGlmIHRoZSBz
dHV0dGVyIG1pZ2h0IGJlIGR1ZSB0byB0aGUgZEdQVSB3cml0aW5nIGFub3RoZXIgZnJhbWUKPj4g
YmVmb3JlIHRoZSBpR1BVIGlzIGRvbmUgcHJvY2Vzc2luZyB0aGUgcHJldmlvdXMgb25lLiBDaHJp
c3RpYW4sIGRvZXMgdGhlCj4+IGFtZGdwdSBzY2hlZHVsZXIgd2FpdCBmb3Igc2hhcmVkIGZlbmNl
cyBvZiBzaGFyZWQgQk9zIHRvIHNpZ25hbCBiZWZvcmUKPj4gc3VibWl0dGluZyBqb2JzIHVzaW5n
IHRoZW0gdG8gdGhlIEdQVT8KPiAKPiBZZWFoLCB0aGF0IHNob3VsZCB3b3JrLiBXZSB3YWl0IGZv
ciBib3RoIHRoZSBleGNsdXNpdmUgYXMgd2VsbCBhcyBhbGwKPiBzaGFyZWQgZmVuY2VzIGJlZm9y
ZSBDUyBvciBwYWdlZmxpcC4KPiAKPiBPbmx5IG9uIENTIHdlIGZpbHRlciB0aGUgc2hhcmVkIGZl
bmNlcyBzbyB0aGF0IHdlIGRvbid0IG5lY2Vzc2FyeSB3YWl0Cj4gZm9yIHN1Ym1pc3Npb25zIGZy
b20gdGhlIHNhbWUgcHJvY2Vzcy4KCk5vdGUgdGhhdCBpdCBjYW4gYmUgdGhlIHNhbWUgcHJvY2Vz
cyAoWG9yZykgaW4gdGhlIFJhbmRSIDEuNCBtdWx0aWhlYWQKY2FzZS4gQnV0IGl0IHNvdW5kcyBs
aWtlIE1pa2UncyBzdHV0dGVyIGNhbid0IGJlIGR1ZSB0byB0aGUgaXNzdWUgSSB3YXMKdGhpbmtp
bmcgb2YuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAg
ICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
