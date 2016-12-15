From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: update tile table for verde
Date: Thu, 15 Dec 2016 16:21:59 +0100
Message-ID: <CAAxE2A4X=dvoeBCp=jYCTKfQF4Jovu0bTyGoBFndW9pJv=ixyA@mail.gmail.com>
References: <1481790677-1006-1-git-send-email-Flora.Cui@amd.com>
 <BN6PR12MB1652F7E6B5C760597185BA6CF79D0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652F7E6B5C760597185BA6CF79D0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVGh1LCBEZWMgMTUsIDIwMTYgYXQgNDoxNiBQTSwgRGV1Y2hlciwgQWxleGFuZGVyCjxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPiB3cm90ZToKPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0KPj4gRnJvbTogYW1kLWdmeCBbbWFpbHRvOmFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVz
a3RvcC5vcmddIE9uIEJlaGFsZgo+PiBPZiBGbG9yYSBDdWkKPj4gU2VudDogVGh1cnNkYXksIERl
Y2VtYmVyIDE1LCAyMDE2IDM6MzEgQU0KPj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4+IENjOiBDdWksIEZsb3JhCj4+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6
IHVwZGF0ZSB0aWxlIHRhYmxlIGZvciB2ZXJkZQo+Pgo+PiBDaGFuZ2UtSWQ6IEk0ZTNjNjk4YTA0
ZTVmN2VlMDVjMDI2OGVlYzEyZGY1MTlmMjMwNWQ0Cj4+IFNpZ25lZC1vZmYtYnk6IEZsb3JhIEN1
aSA8RmxvcmEuQ3VpQGFtZC5jb20+Cj4KPiBTZXJpZXMgaXM6Cj4gUmV2aWV3ZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPgo+IE1hcmVrIG9yIE5pY29sYWks
Cj4KPiBXaWxsIHRoaXMgY2F1c2UgYW55IGlzc3VlcyB3aXRoIG1lc2E/ICBJIHRoaW5rIHdlIHNo
b3VsZCBiZSBvayBvbiBhbWRncHUuCgpJdCBzaG91bGRuJ3QgY2F1c2UgYW55IGlzc3Vlcy4KCk1h
cmVrCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
