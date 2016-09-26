From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] drm/amdgpu: implement raster configuration
Date: Tue, 27 Sep 2016 01:13:03 +0200
Message-ID: <CAAxE2A7qzNC1mBJ9Q0SbL3A8xmfjhMrYk6Ey4kB3ws9s7VUDeg@mail.gmail.com>
References: <1474166210-21736-1-git-send-email-ray.huang@amd.com>
 <CAAxE2A7nSCd-_ViLiJ5RZfTC54DNoYCKL2Ny=WgLSDVCEcdVOQ@mail.gmail.com>
 <MWHPR12MB1694E693082763289AA98A51F7CD0@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB1694E693082763289AA98A51F7CD0-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBTZXAgMjYsIDIwMTYgYXQgMTA6NDIgUE0sIERldWNoZXIsIEFsZXhhbmRlcgo8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT4gd3JvdGU6Cj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tCj4+IEZyb206IE1hcmVrIE9sxaHDoWsgW21haWx0bzptYXJhZW9AZ21haWwuY29tXQo+PiBT
ZW50OiBNb25kYXksIFNlcHRlbWJlciAyNiwgMjAxNiA0OjM5IFBNCj4+IFRvOiBIdWFuZywgUmF5
Cj4+IENjOiBhbWQtZ2Z4IG1haWxpbmcgbGlzdDsgRGV1Y2hlciwgQWxleGFuZGVyOyBXYW5nLCBL
ZW47IEh1YW4sIEFsdmluCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8zXSBkcm0vYW1kZ3B1OiBp
bXBsZW1lbnQgcmFzdGVyIGNvbmZpZ3VyYXRpb24KPj4KPj4gVGhlIHNlcmllcyBpcyBtaXNzaW5n
IGEgRFJNIHZlcnNpb24gYnVtcCwgc28gTWVzYSBjYW4ndCByZWFsbHkgdXNlIGl0Cj4+IGV2ZW4g
aWYgaXQgd2FudGVkLgo+Pgo+Cj4gV2UgYnVtcGVkIGl0IGFscmVhZHkgdGhpcyBjeWNsZSBmb3Ig
c2V2ZXJhbCBvdGhlciB0aGluZ3MsIGJ1dCBJIGNhbiBhZGQgYSBzcGVjaWZpYyBidW1wIGZvciB0
aGlzIGFzIHdlbGwgaWYgdGhhdCBpcyBwcmVmZXJyZWQuCgpPaCwgdGhhdCdzIG5vdCBuZWNlc3Nh
cnkuIE9uZSBidW1wIHBlciBjeWNsZSBpcyBPSy4KCk1hcmVrCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
