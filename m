From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: resvert "disable bulk moves for now"
Date: Thu, 12 Sep 2019 14:02:17 +0000
Message-ID: <f0b19f35-5852-8cbe-2256-e769169d8884@amd.com>
References: <20190912101535.71686-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190912101535.71686-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <7E47B364020F0B48BED8E3FB7EA6A548-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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

UkIgb24gaXQgdG8gZ28gYWhlYWQuDQoNCi1EYXZpZA0KDQrlnKggMjAxOS85LzEyIDE4OjE1LCBD
aHJpc3RpYW4gS8O2bmlnIOWGmemBkzoNCj4gVGhpcyByZXZlcnRzIGNvbW1pdCBhMjEzYzJjN2Uy
MzVjZmMwZTBhMTYxYTU1OGY3ZmRmMmZiM2E2MjRhLg0KPg0KPiBUaGUgY2hhbmdlcyB0byBmaXgg
dGhpcyBzaG91bGQgaGF2ZSBsYW5kZWQgaW4gNS4xLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMiAtLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYw0KPiBpbmRleCA0ODM0OWU0ZjA3MDEuLmZkM2ZiYWE3M2ZhMyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gQEAgLTYwMywxNCArNjAzLDEyIEBAIHZv
aWQgYW1kZ3B1X3ZtX21vdmVfdG9fbHJ1X3RhaWwoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
DQo+ICAgCXN0cnVjdCB0dG1fYm9fZ2xvYmFsICpnbG9iID0gYWRldi0+bW1hbi5iZGV2Lmdsb2I7
DQo+ICAgCXN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSAqYm9fYmFzZTsNCj4gICANCj4gLSNpZiAw
DQo+ICAgCWlmICh2bS0+YnVsa19tb3ZlYWJsZSkgew0KPiAgIAkJc3Bpbl9sb2NrKCZnbG9iLT5s
cnVfbG9jayk7DQo+ICAgCQl0dG1fYm9fYnVsa19tb3ZlX2xydV90YWlsKCZ2bS0+bHJ1X2J1bGtf
bW92ZSk7DQo+ICAgCQlzcGluX3VubG9jaygmZ2xvYi0+bHJ1X2xvY2spOw0KPiAgIAkJcmV0dXJu
Ow0KPiAgIAl9DQo+IC0jZW5kaWYNCj4gICANCj4gICAJbWVtc2V0KCZ2bS0+bHJ1X2J1bGtfbW92
ZSwgMCwgc2l6ZW9mKHZtLT5scnVfYnVsa19tb3ZlKSk7DQo+ICAgDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
