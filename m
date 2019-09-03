From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: use moving fence instead of exclusive for
 VM updates
Date: Tue, 3 Sep 2019 20:37:26 +0000
Message-ID: <a3fa0403-63a4-e9d1-aeed-79ed0fb66379@amd.com>
References: <20190902105219.2813-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190902105219.2813-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <96388496CC366F48B5D74C7F08CF82A8-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wOS0wMiA2OjUyIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+IE1ha2Ug
Vk0gdXBkYXRlcyBkZXBlbmQgb24gdGhlIG1vdmluZyBmZW5jZSBpbnN0ZWFkIG9mIHRoZSBleGNs
dXNpdmUgb25lLg0KDQpJbiBlZmZlY3QsIHRoaXMgbWFrZXMgdGhlIHBhZ2UgdGFibGUgdXBkYXRl
IGRlcGVuZCBvbiB0aGUgbGFzdCBtb3ZlIG9mIA0KdGhlIEJPLCByYXRoZXIgdGhhbiB0aGUgbGFz
dCBjaGFuZ2Ugb2YgdGhlIGJ1ZmZlciBjb250ZW50cy4gTWFrZXMgc2Vuc2UuDQoNClJldmlld2Vk
LWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCg0KDQo+DQo+IE1h
a2VzIGl0IGxlc3MgbGlrZWx5IHRvIGFjdHVhbGx5IGhhdmUgYSBkZXBlbmRlbmN5Lg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMiAr
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBpbmRleCAxODlhZDU2OTk5
NDYuLjUwMWUxMzQyMDc4NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMNCj4gQEAgLTE3MDYsNyArMTcwNiw3IEBAIGludCBhbWRncHVfdm1fYm9fdXBkYXRlKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgIAkJCXR0bSA9IGNvbnRhaW5lcl9vZihiby0+
dGJvLnR0bSwgc3RydWN0IHR0bV9kbWFfdHQsIHR0bSk7DQo+ICAgCQkJcGFnZXNfYWRkciA9IHR0
bS0+ZG1hX2FkZHJlc3M7DQo+ICAgCQl9DQo+IC0JCWV4Y2x1c2l2ZSA9IHJlc2VydmF0aW9uX29i
amVjdF9nZXRfZXhjbChiby0+dGJvLnJlc3YpOw0KPiArCQlleGNsdXNpdmUgPSBiby0+dGJvLm1v
dmluZzsNCj4gICAJfQ0KPiAgIA0KPiAgIAlpZiAoYm8pIHsNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
