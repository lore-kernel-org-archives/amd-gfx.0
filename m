From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Initialize stream_update with memset
Date: Fri, 22 Mar 2019 13:54:56 +0000
Message-ID: <8cfa7952-39f5-70da-4bda-e2603cb04309@amd.com>
References: <20190322131512.22103-1-nicholas.kazlauskas@amd.com>
 <2afb73d6-2baf-880a-6f4e-49303f4ccded@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2afb73d6-2baf-880a-6f4e-49303f4ccded-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
Content-Language: en-US
Content-ID: <07F640D2D4BF3E4CAEF3E02FC498386A-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Paul Menzel <pmenzel+amd-gfx-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
Cc: "Li, Sun
 peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMy8yMi8xOSA5OjQ5IEFNLCBQYXVsIE1lbnplbCB3cm90ZToNCj4gRGVhciBOaWNob2xhcywN
Cj4gDQo+IA0KPiBPbiAwMy8yMi8xOSAxNDoxNSwgTmljaG9sYXMgS2F6bGF1c2thcyB3cm90ZToN
Cj4+IFRoZSBicmFjZSBpbml0aWFsaXphdGlvbiB1c2VkIGhlcmUgZ2VuZXJhdGVzIGVycm9ycyBv
biBzb21lDQo+PiBjb21waWxlcnMuIFVzZSBtZW1zZXQgdG8gbWFrZSB0aGlzIG1vcmUgcG9ydGFi
bGUuDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIHNwZWNpZnkgdGhlIHByb2JsZW1hdGljIGNvbXBp
bGVyL3Rvb2xjaGFpbiBpbg0KPiB0aGUgY29tbWl0IG1lc3NhZ2U/DQo+IA0KPiBb4oCmXQ0KPiAN
Cj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBhdWwNCj4gDQoNCkkgYWN0dWFsbHkgbWVhbnQg
d2FybmluZyBpbiB0aGlzIGNhc2UgLSBzaW5jZSBJIHVzdWFsbHkgYnVpbGQgYW1kZ3B1IA0Kd2l0
aCB3YXJuaW5ncyBhcyBlcnJvcnMuIEluIHRoaXMgY2FzZSBpdCB3YXMgYW4gb2xkZXIgdmVyc2lv
biBvZiBHQ0MgDQp0aGF0IGdlbmVyYXRlZCB0aGUgd2FybmluZyAoNC45KS4gVGhvdWdoIEkgdGhp
bmsgY2xhbmcgZG9lcyBhcyB3ZWxsLCBJIA0KZm9yZ290IHRvIG1ha2UgdGhpcyBwYXRjaCBhZnRl
ciBJIHNhdyB0aGUgZW1haWwgZnJvbSBOaWxzIFdhbGxtw6luaXVzIGEgDQp3aGlsZSBiYWNrLiBU
aGVyZSB3ZXJlIHNpbWlsYXIgaXNzdWVzIGluIGEgZmV3IG90aGVyIHBsYWNlczoNCg0KaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvYXJjaGl2ZXMvYW1kLWdmeC8yMDE5LUZlYnJ1YXJ5LzAz
MTExNi5odG1sDQoNCkknbGwgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSBhbmQgcG9zdCBhIHYy
LCB0aGFua3MhDQoNCk5pY2hvbGFzIEthemxhdXNrYXMNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
