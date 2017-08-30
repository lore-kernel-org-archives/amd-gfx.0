From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amdgpu: add IOCTL interface for per VM BOs v2
Date: Wed, 30 Aug 2017 15:46:51 +0900
Message-ID: <4c0b0f45-43c7-f831-d407-8d2ffba4c586@daenzer.net>
References: <1504026462-1788-1-git-send-email-deathsimple@vodafone.de>
 <1504026462-1788-3-git-send-email-deathsimple@vodafone.de>
 <CY4PR12MB16532A33114CD81C3389D05EF79F0@CY4PR12MB1653.namprd12.prod.outlook.com>
 <c7a4040d-6458-96a2-8096-498be5d0cf5d@vodafone.de>
 <f2c9784d-880b-00da-cdcd-b794dc43b1da@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f2c9784d-880b-00da-cdcd-b794dc43b1da-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMzAvMDgvMTcgMDM6NDIgUE0sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+IE9uIDMwLzA4LzE3
IDAzOjA5IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAyOS4wOC4yMDE3IHVtIDE5
OjIwIHNjaHJpZWIgRGV1Y2hlciwgQWxleGFuZGVyOgo+Pj4+IEZyb206IGFtZC1nZnggW21haWx0
bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnXSBPbiBCZWhhbGYKPj4+PiBP
ZiBDaHJpc3RpYW4gS8O2bmlnCj4+Pj4KPj4+PiBAQCAtODksNiArODksOCBAQCBleHRlcm4gIkMi
IHsKPj4+PiAgICNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfU0hBRE9XICAgICAgICAoMSA8PCA0
KQo+Pj4+ICAgLyogRmxhZyB0aGF0IGFsbG9jYXRpbmcgdGhlIEJPIHNob3VsZCB1c2UgbGluZWFy
IFZSQU0gKi8KPj4+PiAgICNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9DT05USUdVT1VT
ICAgICgxIDw8IDUpCj4+Pj4gKy8qIEZsYWcgdGhhdCBCTyBpcyBsb2NhbCBpbiB0aGUgVk0gKi8K
Pj4+PiArI2RlZmluZSBBTURHUFVfR0VNX0NSRUFURV9MT0NBTCAgICAgICAgICAgICgxIDw8IDYp
Cj4+PiBJJ20gbm90IGNyYXp5IGFib3V0IHRoZSBuYW1lIExPQ0FMLiAgTWF5YmUgc29tZXRoaW5n
IGxpa2UgQUxXQVlTX1ZBTElEPwo+Pgo+PiBXb3JrcyBmb3IgbWUgYXMgd2VsbC4gRGF2ZSBhbnkg
b3RoZXIgb3Bpbmlvbj8KPj4KPj4gSWYgZXZlcnlib2R5IGlzIG9rIHdpdGggQUxXQVlTX1ZBTElE
IEknbSBnb2luZyB0byB1c2UgdGhhdCBvbmUuCj4gCj4gRldJVywgSSBsaWtlIExPQ0FMIGJldHRl
ciB0aGFuIEFMV0FZU19WQUxJRC4gVGhlIGxhdHRlciBzdWdnZXN0cyB0aGF0Cj4gdGhlIEJPIGlz
IHZhbGlkIHVuZGVyIGFueSBjaXJjdW1zdGFuY2VzLCB3aGVyZWFzIExPQ0FMIGluZGljYXRlcyB0
aGF0IGl0Cj4gY2Fubm90IGJlIHVzZWQgb3V0c2lkZSBvZiB0aGUgR1BVVk0gaXQgd2FzIGNyZWF0
ZWQgaW4uCj4gCj4gSSBkb24ndCBmZWVsIHN0cm9uZ2x5IGFib3V0IGl0IHRob3VnaCwgZmVlbCBm
cmVlIHRvIGdvIHdpdGggZWl0aGVyLgoKQW5vdGhlciBpZGVhOgoKLyogVGhlIEJPIGNhbiBvbmx5
IGJlIHVzZWQgaW4gdGhlIFZNIGl0IHdhcyBjcmVhdGVkIGluICovCiNkZWZpbmUgQU1ER1BVX0dF
TV9DUkVBVEVfVU5TSEFSRUFCTEUgICAgICAgICAgICAoMSA8PCA2KQoKCi0tIApFYXJ0aGxpbmcg
TWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5h
bWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAg
ICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
