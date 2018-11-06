From: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/vega20: add CLK base offset
Date: Tue, 6 Nov 2018 16:51:22 +0000
Message-ID: <ea750584-1e9d-29fa-e680-b6070ecb99e4@amd.com>
References: <20181106162400.21189-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181106162400.21189-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <CBEF728CA33717458F21C9B28D508C6B-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0xMS0wNiAxMToyNCBhLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6DQo+IEluIGNhc2Ug
d2UgbmVlZCB0byBhY2Nlc3MgQ0xLIHJlZ2lzdGVycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KQWNrZWQtYnk6IEhhcnJ5
IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KDQpIYXJyeQ0KDQo+IC0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX3JlZ19pbml0LmMgfCAxICsNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2EyMF9yZWdfaW5pdC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmVnYTIwX3JlZ19pbml0LmMNCj4gaW5kZXggMmQ0NDczNTU3YjBkLi5kMTNmYzRm
Y2I1MTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2EyMF9y
ZWdfaW5pdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2EyMF9yZWdf
aW5pdC5jDQo+IEBAIC00OSw2ICs0OSw3IEBAIGludCB2ZWdhMjBfcmVnX2Jhc2VfaW5pdChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gIAkJYWRldi0+cmVnX29mZnNldFtTTVVJT19IV0lQ
XVtpXSA9ICh1aW50MzJfdCAqKSgmKFNNVUlPX0JBU0UuaW5zdGFuY2VbaV0pKTsNCj4gIAkJYWRl
di0+cmVnX29mZnNldFtOQklGX0hXSVBdW2ldID0gKHVpbnQzMl90ICopKCYoTkJJT19CQVNFLmlu
c3RhbmNlW2ldKSk7DQo+ICAJCWFkZXYtPnJlZ19vZmZzZXRbVEhNX0hXSVBdW2ldID0gKHVpbnQz
Ml90ICopKCYoVEhNX0JBU0UuaW5zdGFuY2VbaV0pKTsNCj4gKwkJYWRldi0+cmVnX29mZnNldFtD
TEtfSFdJUF1baV0gPSAodWludDMyX3QgKikoJihDTEtfQkFTRS5pbnN0YW5jZVtpXSkpOw0KPiAg
CX0NCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
