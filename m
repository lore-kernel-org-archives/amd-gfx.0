From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amdgpu: add IOCTL interface for per VM BOs v2
Date: Wed, 30 Aug 2017 09:34:51 +0200
Message-ID: <c6cdb302-94a8-8136-ab77-a4831c35b16d@vodafone.de>
References: <1504026462-1788-1-git-send-email-deathsimple@vodafone.de>
 <1504026462-1788-3-git-send-email-deathsimple@vodafone.de>
 <CY4PR12MB16532A33114CD81C3389D05EF79F0@CY4PR12MB1653.namprd12.prod.outlook.com>
 <c7a4040d-6458-96a2-8096-498be5d0cf5d@vodafone.de>
 <f2c9784d-880b-00da-cdcd-b794dc43b1da@daenzer.net>
 <4c0b0f45-43c7-f831-d407-8d2ffba4c586@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4c0b0f45-43c7-f831-d407-8d2ffba4c586-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMzAuMDguMjAxNyB1bSAwODo0NiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDMwLzA4
LzE3IDAzOjQyIFBNLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPj4gT24gMzAvMDgvMTcgMDM6MDkg
UE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAyOS4wOC4yMDE3IHVtIDE5OjIwIHNj
aHJpZWIgRGV1Y2hlciwgQWxleGFuZGVyOgo+Pj4+PiBGcm9tOiBhbWQtZ2Z4IFttYWlsdG86YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZ10gT24gQmVoYWxmCj4+Pj4+IE9mIENo
cmlzdGlhbiBLw7ZuaWcKPj4+Pj4KPj4+Pj4gQEAgLTg5LDYgKzg5LDggQEAgZXh0ZXJuICJDIiB7
Cj4+Pj4+ICAgICNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfU0hBRE9XICAgICAgICAoMSA8PCA0
KQo+Pj4+PiAgICAvKiBGbGFnIHRoYXQgYWxsb2NhdGluZyB0aGUgQk8gc2hvdWxkIHVzZSBsaW5l
YXIgVlJBTSAqLwo+Pj4+PiAgICAjZGVmaW5lIEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fQ09OVElH
VU9VUyAgICAoMSA8PCA1KQo+Pj4+PiArLyogRmxhZyB0aGF0IEJPIGlzIGxvY2FsIGluIHRoZSBW
TSAqLwo+Pj4+PiArI2RlZmluZSBBTURHUFVfR0VNX0NSRUFURV9MT0NBTCAgICAgICAgICAgICgx
IDw8IDYpCj4+Pj4gSSdtIG5vdCBjcmF6eSBhYm91dCB0aGUgbmFtZSBMT0NBTC4gIE1heWJlIHNv
bWV0aGluZyBsaWtlIEFMV0FZU19WQUxJRD8KPj4+IFdvcmtzIGZvciBtZSBhcyB3ZWxsLiBEYXZl
IGFueSBvdGhlciBvcGluaW9uPwo+Pj4KPj4+IElmIGV2ZXJ5Ym9keSBpcyBvayB3aXRoIEFMV0FZ
U19WQUxJRCBJJ20gZ29pbmcgdG8gdXNlIHRoYXQgb25lLgo+PiBGV0lXLCBJIGxpa2UgTE9DQUwg
YmV0dGVyIHRoYW4gQUxXQVlTX1ZBTElELiBUaGUgbGF0dGVyIHN1Z2dlc3RzIHRoYXQKPj4gdGhl
IEJPIGlzIHZhbGlkIHVuZGVyIGFueSBjaXJjdW1zdGFuY2VzLCB3aGVyZWFzIExPQ0FMIGluZGlj
YXRlcyB0aGF0IGl0Cj4+IGNhbm5vdCBiZSB1c2VkIG91dHNpZGUgb2YgdGhlIEdQVVZNIGl0IHdh
cyBjcmVhdGVkIGluLgo+Pgo+PiBJIGRvbid0IGZlZWwgc3Ryb25nbHkgYWJvdXQgaXQgdGhvdWdo
LCBmZWVsIGZyZWUgdG8gZ28gd2l0aCBlaXRoZXIuCj4gQW5vdGhlciBpZGVhOgo+Cj4gLyogVGhl
IEJPIGNhbiBvbmx5IGJlIHVzZWQgaW4gdGhlIFZNIGl0IHdhcyBjcmVhdGVkIGluICovCj4gI2Rl
ZmluZSBBTURHUFVfR0VNX0NSRUFURV9VTlNIQVJFQUJMRSAgICAgICAgICAgICgxIDw8IDYpCgpU
aGF0IGluIHR1cm4gZG9lc24ndCBub3RlIHRoYXQgaXQgaXMgYWx3YXlzIGF2YWlsYWJsZS4KCkFk
ZGl0aW9uYWwgdG8gdGhhdCBJIG9ubHkgbGltaXRlZCBzaGFyaW5nIHRoZSBCTyBiZWNhdXNlIG9m
IHRoZSBiYWQgCnBlcmZvcm1hbmNlIGFuZCBtZW1vcnkgdXNhZ2UuIEluIHRoZW9yeSB3ZSBjb3Vs
ZCBzaGFyZSB0aGVtIHByZXR0eSB3ZWxsLgoKSG93IGFib3V0IFZNX0xPQ0FMID8KCkNocmlzdGlh
bi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
