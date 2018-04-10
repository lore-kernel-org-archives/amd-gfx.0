From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 17/19] Store device_name as
 AMDGPUEntRec::master_node
Date: Tue, 10 Apr 2018 10:51:19 +0100
Message-ID: <CACvgo51bhtdetMOv6e+TptYDVfSajvepb2XwQ3dKg=gnzPKvxQ@mail.gmail.com>
References: <20180404142954.31360-1-emil.l.velikov@gmail.com>
 <20180404142954.31360-18-emil.l.velikov@gmail.com>
 <995c2313-3603-e05b-fc19-93dec3ba9876@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <995c2313-3603-e05b-fc19-93dec3ba9876-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTAgQXByaWwgMjAxOCBhdCAwOToyOSwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVy
Lm5ldD4gd3JvdGU6Cj4gT24gMjAxOC0wNC0wNCAwNDoyOSBQTSwgRW1pbCBWZWxpa292IHdyb3Rl
Ogo+PiBGcm9tOiBFbWlsIFZlbGlrb3YgPGVtaWwudmVsaWtvdkBjb2xsYWJvcmEuY29tPgo+Pgo+
PiBSZW5hbWUgdGhlIHZhcmlhYmxlIHRvIHJlZmxlY3Qgd2hhdCBpdCBpcy4gUGx1cyBtb3ZlIGl0
IG91dCBvZiB0aGUgZHJpMgo+PiBzZWN0aW9uIC0gaXQncyB1c2VkIGluIGRyaTIgYW5kIGRyaTMu
Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEVtaWwgVmVsaWtvdiA8ZW1pbC52ZWxpa292QGNvbGxhYm9y
YS5jb20+Cj4KPiBbLi4uXQo+Cj4+IGRpZmYgLS1naXQgYS9zcmMvYW1kZ3B1X3Byb2JlLmMgYi9z
cmMvYW1kZ3B1X3Byb2JlLmMKPj4gaW5kZXggNDk1OWJkNi4uZTlhZmU0MiAxMDA2NDQKPj4gLS0t
IGEvc3JjL2FtZGdwdV9wcm9iZS5jCj4+ICsrKyBiL3NyYy9hbWRncHVfcHJvYmUuYwo+PiBAQCAt
MTc4LDYgKzE3OCwxMCBAQCBzdGF0aWMgQm9vbCBhbWRncHVfZGV2aWNlX3NldHVwKFNjcm5JbmZv
UHRyIHBTY3JuLAo+PiAgICAgICBpZiAocEFNREdQVUVudC0+ZmQgPCAwKQo+PiAgICAgICAgICAg
ICAgIHJldHVybiBGQUxTRTsKPj4KPj4gKyAgICAgcEFNREdQVUVudC0+bWFzdGVyX25vZGUgPSBk
cm1HZXREZXZpY2VOYW1lRnJvbUZkMihwQU1ER1BVRW50LT5mZCk7Cj4+ICsgICAgIGlmIChwQU1E
R1BVRW50LT5tYXN0ZXJfbm9kZSkKPj4gKyAgICAgICAgICAgIGdvdG8gZXJyb3JfYW1kZ3B1Owo+
Cj4gVGhpcyBzaG91bGQgYmUKPgo+ICAgICAgICAgaWYgKCFwQU1ER1BVRW50LT5tYXN0ZXJfbm9k
ZSkKPgo+IHNob3VsZG4ndCBpdD8KPgo+Cj4gLi4uIFdoaWNoIHJhaXNlcyB0aGUgcXVlc3Rpb246
IEhvdyBkaWQgeW91IHRlc3QgdGhlc2UgcGF0Y2hlcz8gOikKPgpJIG1lbnRpb25lZCBpdCBpbiB0
aGUgY292ZXIgbGV0dGVyLCBidXQgc2VlbXMgdG8gaGF2ZSBkcm9wcGVkIGl0IC0KdGhleSBhcmUg
dW50ZXN0ZWQuClRoZXJlJ3MgYSByNjAwIGNhcmQgY2xvc2UtYnkgSSBjb3VsZCB0ZXN0IHdpdGgs
IGJ1dCBubyBhbWRncHUgb25lIDotXAoKLUVtaWwKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
