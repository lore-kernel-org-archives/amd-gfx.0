From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update kernel-doc for some functions
Date: Mon, 24 Oct 2016 12:13:27 -0400
Message-ID: <CADnq5_P+WbmTHxBR_9_T14v+r3riUvvrtLpqqgJCj-dgMQ7hCA@mail.gmail.com>
References: <1477247507-11378-5-git-send-email-notasas@gmail.com>
 <20d1f285-6a45-fe57-404a-1974b4e62a49@folklore1984.net>
 <db14a045-b135-4e2a-f67b-867f8a50296f@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <db14a045-b135-4e2a-f67b-867f8a50296f@vodafone.de>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Edward O'Callaghan <funfunctor@folklore1984.net>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBPY3QgMjQsIDIwMTYgYXQgNToxNCBBTSwgQ2hyaXN0aWFuIEvDtm5pZwo8ZGVhdGhz
aW1wbGVAdm9kYWZvbmUuZGU+IHdyb3RlOgo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Lgo+Cj4KPiBBbSAyNC4xMC4yMDE2IHVtIDAwOjI5
IHNjaHJpZWIgRWR3YXJkIE8nQ2FsbGFnaGFuOgo+Cj4gUmV2aWV3ZWQtYnk6IEVkd2FyZCBPJ0Nh
bGxhZ2hhbiA8ZnVuZnVuY3RvckBmb2xrbG9yZTE5ODQubmV0Pgo+Cj4gT24gMTAvMjQvMjAxNiAw
NTozMSBBTSwgR3JhenZ5ZGFzIElnbm90YXMgd3JvdGU6Cj4KPiBUaGUgbmFtZXMgd2VyZSB3cm9u
Zy4KPgo+IFNpZ25lZC1vZmYtYnk6IEdyYXp2eWRhcyBJZ25vdGFzIDxub3Rhc2FzQGdtYWlsLmNv
bT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvc2NoZWRfZmVuY2UuYyB8
IDQgKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL3NjaGVkX2Zl
bmNlLmMKPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL3NjaGVkX2ZlbmNlLmMKPiBp
bmRleCA2YjYzYmVhLi4zNjUzYjVhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
c2NoZWR1bGVyL3NjaGVkX2ZlbmNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3NjaGVk
dWxlci9zY2hlZF9mZW5jZS5jCj4gQEAgLTEwMyw3ICsxMDMsNyBAQCBzdGF0aWMgdm9pZCBhbWRf
c2NoZWRfZmVuY2VfZnJlZShzdHJ1Y3QgcmN1X2hlYWQgKnJjdSkKPiAgfQo+Cj4gIC8qKgo+IC0g
KiBhbWRfc2NoZWRfZmVuY2VfcmVsZWFzZSAtIGNhbGxiYWNrIHRoYXQgZmVuY2UgY2FuIGJlIGZy
ZWVkCj4gKyAqIGFtZF9zY2hlZF9mZW5jZV9yZWxlYXNlX3NjaGVkdWxlZCAtIGNhbGxiYWNrIHRo
YXQgZmVuY2UgY2FuIGJlIGZyZWVkCj4gICAqCj4gICAqIEBmZW5jZTogZmVuY2UKPiAgICoKPiBA
QCAtMTE4LDcgKzExOCw3IEBAIHN0YXRpYyB2b2lkIGFtZF9zY2hlZF9mZW5jZV9yZWxlYXNlX3Nj
aGVkdWxlZChzdHJ1Y3QKPiBmZW5jZSAqZikKPiAgfQo+Cj4gIC8qKgo+IC0gKiBhbWRfc2NoZWRf
ZmVuY2VfcmVsZWFzZV9zY2hlZHVsZWQgLSBkcm9wIGV4dHJhIHJlZmVyZW5jZQo+ICsgKiBhbWRf
c2NoZWRfZmVuY2VfcmVsZWFzZV9maW5pc2hlZCAtIGRyb3AgZXh0cmEgcmVmZXJlbmNlCj4gICAq
Cj4gICAqIEBmOiBmZW5jZQo+ICAgKgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
