From: "Cui, Flora" <fcui-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add DRIVER_SYNCOBJ_TIMELINE to amdgpu
Date: Tue, 28 May 2019 03:05:53 +0000
Message-ID: <3e5a2a4c-f4b5-d600-30a4-ce6e50e2cd72@amd.com>
References: <20190528025203.11593-1-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190528025203.11593-1-david1.zhou-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <E376AEF075889643B60A30F6B44402F0-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>

dGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBGbG9yYSBDdWkgPEZsb3JhLkN1aUBhbWQuY29tPg0K
DQrlnKggNS8yOC8yMDE5IDEwOjUyIEFNLCBDaHVubWluZyBaaG91IOWGmemBkzoNCj4gQ2hhbmdl
LUlkOiBJMmIxYWYxNDc4ZmJkZGJiNTA4NGI5MGIzZmY4NWMyZWI5NjRiZDIxNw0KPiBTaWduZWQt
b2ZmLWJ5OiBDaHVubWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPg0KPiAtLS0NCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAzICsrLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiBpbmRleCA3ODcwNmRmYTc1M2EuLjFmMzhk
NmZjMWZlMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0K
PiBAQCAtMTMwNyw3ICsxMzA3LDggQEAgc3RhdGljIHN0cnVjdCBkcm1fZHJpdmVyIGttc19kcml2
ZXIgPSB7DQo+ICAgCS5kcml2ZXJfZmVhdHVyZXMgPQ0KPiAgIAkgICAgRFJJVkVSX1VTRV9BR1Ag
fCBEUklWRVJfQVRPTUlDIHwNCj4gICAJICAgIERSSVZFUl9HRU0gfA0KPiAtCSAgICBEUklWRVJf
UFJJTUUgfCBEUklWRVJfUkVOREVSIHwgRFJJVkVSX01PREVTRVQgfCBEUklWRVJfU1lOQ09CSiwN
Cj4gKwkgICAgRFJJVkVSX1BSSU1FIHwgRFJJVkVSX1JFTkRFUiB8IERSSVZFUl9NT0RFU0VUIHwg
RFJJVkVSX1NZTkNPQkogfA0KPiArCSAgICBEUklWRVJfU1lOQ09CSl9USU1FTElORSwNCj4gICAJ
LmxvYWQgPSBhbWRncHVfZHJpdmVyX2xvYWRfa21zLA0KPiAgIAkub3BlbiA9IGFtZGdwdV9kcml2
ZXJfb3Blbl9rbXMsDQo+ICAgCS5wb3N0Y2xvc2UgPSBhbWRncHVfZHJpdmVyX3Bvc3RjbG9zZV9r
bXMsDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
