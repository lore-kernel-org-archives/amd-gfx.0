From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: do not block gpu resume when cp ring test
 failed.
Date: Thu, 30 Mar 2017 18:24:42 +0900
Message-ID: <5ed63c06-4049-7f77-6253-3f4f01d6ee35@daenzer.net>
References: <MWHPR12MB1694422BE19A18B45E985734FB340@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB1694422BE19A18B45E985734FB340-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMzAvMDMvMTcgMDM6NDUgUE0sIFpodSwgUmV4IHdyb3RlOgo+IFllcywgd2UgdHJpZWQgdG8g
Zml4IGl0LiBpdCBpcyBhIHRpbWluZyBpc3N1ZS4KPiBCdXQgaXQgd2FzIG5vdCBhIGNyaXRpY2Fs
IGVycm9yLiBTbyBubyBuZWVkIHRvIGJsb2NrIGdwdSByZXN1bWUuCj4gCj4gSW4gZmFjdCwgV2Ug
b25seSByZXR1cm4gZXJyb3Igd2hlbiB0aGUgbGFzdCByaW5nIHRlc3QgZmFpbGVkIGluIHRoZSBv
cmlnaW5hbCBsb2dpYyAKClRoYXQgbWFrZXMgc29tZSBzZW5zZSB0byBtZSwgYnV0IGF0IGxlYXN0
IHRoZSBjb21taXQgbG9nIHdvdWxkIG5lZWQgdG8KYmUgY2hhbmdlZCBub3QgdG8gdGFsayBhYm91
dCB0aGUgS0lRIHJlbGF0ZWQgcmFuZG9tIGZhaWx1cmVzIGJ1dCBqdXN0CmFib3V0IHRoYXQgZ2Z4
X3Y4XzBfa2lxX3Jlc3VtZSB3b3VsZCBvbmx5IHJldHVybiBmYWlsdXJlIGlmIHRoZSBsYXN0CnJp
bmcgdGVzdCBmYWlsZWQgYW55d2F5LgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3
YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVs
b3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
