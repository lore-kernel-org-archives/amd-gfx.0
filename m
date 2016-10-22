From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: cancel reset work on fini
Date: Sat, 22 Oct 2016 19:48:49 +0200
Message-ID: <3f7de4df-d626-701c-12be-ab9ce593ac8e@vodafone.de>
References: <1477082714-15229-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1477082714-15229-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMjEuMTAuMjAxNiB1bSAyMjo0NSBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBDYW5jZWwgYW55
IHBlbmRpbmcgcmVzZXQgd29yayB3aGVuIHdlIHRlYXIgZG93biB0aGUgZHJpdmVyLgo+Cj4gU2ln
bmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKUmV2
aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgo+
IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jIHwgMiArKwo+
ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9pcnEuYwo+IGluZGV4IDI3ODcwOGYuLjlmYTgwOTggMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jCj4gQEAgLTIzOSw2ICsyMzksNyBAQCBp
bnQgYW1kZ3B1X2lycV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCWlmIChy
KSB7Cj4gICAJCWFkZXYtPmlycS5pbnN0YWxsZWQgPSBmYWxzZTsKPiAgIAkJZmx1c2hfd29yaygm
YWRldi0+aG90cGx1Z193b3JrKTsKPiArCQljYW5jZWxfd29ya19zeW5jKCZhZGV2LT5yZXNldF93
b3JrKTsKPiAgIAkJcmV0dXJuIHI7Cj4gICAJfQo+ICAgCj4gQEAgLTI2NCw2ICsyNjUsNyBAQCB2
b2lkIGFtZGdwdV9pcnFfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAkJaWYg
KGFkZXYtPmlycS5tc2lfZW5hYmxlZCkKPiAgIAkJCXBjaV9kaXNhYmxlX21zaShhZGV2LT5wZGV2
KTsKPiAgIAkJZmx1c2hfd29yaygmYWRldi0+aG90cGx1Z193b3JrKTsKPiArCQljYW5jZWxfd29y
a19zeW5jKCZhZGV2LT5yZXNldF93b3JrKTsKPiAgIAl9Cj4gICAKPiAgIAlmb3IgKGkgPSAwOyBp
IDwgQU1ER1BVX01BWF9JUlFfU1JDX0lEOyArK2kpIHsKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
