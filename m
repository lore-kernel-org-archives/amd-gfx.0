From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v2 0/3] Cleanup evergreen/si IRQ handling code
Date: Wed, 24 May 2017 14:31:37 -0400
Message-ID: <CADnq5_POKbtQ5zuq-OXbw31M13kLOou7zcJQz0jvYXtc0O2XcA@mail.gmail.com>
References: <20170516211202.20325-1-lyude@redhat.com>
 <20170519234840.5644-1-lyude@redhat.com>
 <51a14f4e-8771-3bca-b05f-25732da50b34@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <51a14f4e-8771-3bca-b05f-25732da50b34@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: Lyude <lyude@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gU2F0LCBNYXkgMjAsIDIwMTcgYXQgNzozOSBBTSwgQ2hyaXN0aWFuIEvDtm5pZwo8ZGVhdGhz
aW1wbGVAdm9kYWZvbmUuZGU+IHdyb3RlOgo+IEFtIDIwLjA1LjIwMTcgdW0gMDE6NDggc2Nocmll
YiBMeXVkZToKPj4KPj4gVGhpcyBpcyB0aGUgZmlyc3QgcGFydCBvZiBtZSBnb2luZyB0aHJvdWdo
IGFuZCBjbGVhbmluZyB1cCB0aGUgSVJRCj4+IGhhbmRsaW5nCj4+IGNvZGUgZm9yIHJhZGVvbiwg
c2luY2UgYWZ0ZXIgdGFraW5nIGEgbG9vayBhdCBpdCB0aGUgb3RoZXIgZGF5IHdoaWxlCj4+IHRy
eWluZyB0bwo+PiBkZWJ1ZyBzb21ldGhpbmcgSSByZWFsaXplZCBiYXNpY2FsbHkgYWxsIG9mIHRo
ZSBjb2RlIHdhcyBjb3B5IHBhc3RlZAo+PiBldmVyeXdoZXJlLCBhbmQgcXVpdGUgZGlmZmljdWx0
IHRvIGFjdHVhbGx5IHJlYWQgdGhyb3VnaC4KPj4KPj4gV2lsbCBjb21lIHVwIHdpdGggc29tZXRo
aW5nIGZvciByNjAwIGFuZCBjaWsgb25jZSBJJ3ZlIGdvdCB0aGUgY2hpcHNldHMgb24KPj4gaGFu
ZAo+PiB0byB0ZXN0IHdpdGguCj4+Cj4+IEx5dWRlICgzKToKPj4gICAgZHJtL3JhZGVvbjogQ2xl
YW51cCBkaXNwbGF5IGludGVycnVwdCBoYW5kbGluZyBmb3IgZXZlcmdyZWVuLCBzaQo+PiAgICBk
cm0vcmFkZW9uOiBDbGVhbnVwIEhETUkgYXVkaW8gaW50ZXJydXB0IGhhbmRsaW5nIGZvciBldmVy
Z3JlZW4KPj4gICAgZHJtL3JhZGVvbjogQ2xlYW51cCBwYWdlZmxpcHBpbmcgSVJRIGhhbmRsaW5n
IGZvciBldmVyZ3JlZW4sIHNpCj4KPgo+IEkgZG9uJ3QgaGF2ZSB0aW1lIHRvIGRvIGEgbGluZSBi
eSBsaW5lIHJldmlldywgYnV0IHdoYXQgSSBzYXcgbG9va2VkIHZlcnkKPiBnb29kIHRvIG1lLgo+
Cj4gU28gdGhlIHdob2xlIHNlcmVzIGlzIEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+LgoKQXBwbGllZC4gIHRoYW5rcyEKCkFsZXgKCgo+Cj4gQlRX
OiBZb3UgZG9uJ3Qgd2FudCB0byB0YWtlIGEgbG9vayBhdCB0aGUgb3RoZXIgaHcgZ2VuZXJhdGlv
bnMgYXMgd2VsbD8KPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+ICAgZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uYyAgICAgIHwgOTQzCj4+ICsrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb24uaCAgICAg
ICAgIHwgIDI3ICstCj4+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faXJxX2ttcy5j
IHwgIDM1ICsrCj4+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5jICAgICAgICAgICAgIHwg
NjU1ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0KPj4gICA0IGZpbGVzIGNoYW5nZWQsIDM0NCBpbnNl
cnRpb25zKCspLCAxMzE2IGRlbGV0aW9ucygtKQo+Pgo+Cj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbAo=
