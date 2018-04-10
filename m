From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 02/19] Guard ODEV_ATTRIB_FD usage with
 the correct ifdef
Date: Tue, 10 Apr 2018 10:27:08 +0200
Message-ID: <6b34615c-1149-737a-6ec0-685470ae9d1f@daenzer.net>
References: <20180404142954.31360-1-emil.l.velikov@gmail.com>
 <20180404142954.31360-3-emil.l.velikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180404142954.31360-3-emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-CA
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNC0wNCAwNDoyOSBQTSwgRW1pbCBWZWxpa292IHdyb3RlOgo+IEZyb206IEVtaWwg
VmVsaWtvdiA8ZW1pbC52ZWxpa292QGNvbGxhYm9yYS5jb20+Cj4gCj4gU2lnbmVkLW9mZi1ieTog
RW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KPiAtLS0KPiAgc3JjL2Ft
ZGdwdV9wcm9iZS5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvc3JjL2FtZGdwdV9wcm9iZS5jIGIvc3JjL2Ft
ZGdwdV9wcm9iZS5jCj4gaW5kZXggMDc1ZTVjMS4uZTY1YzgzYiAxMDA2NDQKPiAtLS0gYS9zcmMv
YW1kZ3B1X3Byb2JlLmMKPiArKysgYi9zcmMvYW1kZ3B1X3Byb2JlLmMKPiBAQCAtMTIwLDcgKzEy
MCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2tlcm5lbF9vcGVuX2ZkKFNjcm5JbmZvUHRyIHBTY3Ju
LAo+ICAJY2hhciAqYnVzaWQ7Cj4gIAlpbnQgZmQ7Cj4gIAo+IC0jaWZkZWYgWEY4Nl9QREVWX1NF
UlZFUl9GRAo+ICsjaWZkZWYgT0RFVl9BVFRSSUJfRkQKPiAgCWlmIChwbGF0Zm9ybV9kZXYpIHsK
PiAgCQlmZCA9IHhmODZfZ2V0X3BsYXRmb3JtX2RldmljZV9pbnRfYXR0cmliKHBsYXRmb3JtX2Rl
diwKPiAgCQkJCQkJCSBPREVWX0FUVFJJQl9GRCwgLTEpOwo+IAoKT0RFVl9BVFRSSUJfRkQgZG9l
c24ndCBzZWVtIG9idmlvdXNseSBtb3JlICJjb3JyZWN0IiB0aGFuClhGODZfUERFVl9TRVJWRVJf
RkQsIHNpbmNlIGJvdGggd2VyZSBhZGRlZCBpbiB0aGUgc2FtZSB4c2VydmVyIGNvbW1pdCwKYW5k
IHRoZSBsYXR0ZXIgbWlnaHQgYmUgaGVscGZ1bCBmb3IgdW5kZXJzdGFuZGluZyB0aGlzIGlzIHJl
bGF0ZWQgdG8gdGhlCm90aGVyIGNvZGUgZ3VhcmRlZCBieSBYRjg2X1BERVZfU0VSVkVSX0ZELgoK
Ci0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAg
ICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
