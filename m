From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amdgpu: add IOCTL interface for per VM BOs v2
Date: Wed, 30 Aug 2017 15:42:36 +0900
Message-ID: <f2c9784d-880b-00da-cdcd-b794dc43b1da@daenzer.net>
References: <1504026462-1788-1-git-send-email-deathsimple@vodafone.de>
 <1504026462-1788-3-git-send-email-deathsimple@vodafone.de>
 <CY4PR12MB16532A33114CD81C3389D05EF79F0@CY4PR12MB1653.namprd12.prod.outlook.com>
 <c7a4040d-6458-96a2-8096-498be5d0cf5d@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c7a4040d-6458-96a2-8096-498be5d0cf5d-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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

T24gMzAvMDgvMTcgMDM6MDkgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjkuMDgu
MjAxNyB1bSAxOToyMCBzY2hyaWViIERldWNoZXIsIEFsZXhhbmRlcjoKPj4+IEZyb206IGFtZC1n
ZnggW21haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnXSBPbiBCZWhh
bGYKPj4+IE9mIENocmlzdGlhbiBLw7ZuaWcKPj4+Cj4+PiBAQCAtODksNiArODksOCBAQCBleHRl
cm4gIkMiIHsKPj4+ICAgI2RlZmluZSBBTURHUFVfR0VNX0NSRUFURV9TSEFET1cgICAgICAgICgx
IDw8IDQpCj4+PiAgIC8qIEZsYWcgdGhhdCBhbGxvY2F0aW5nIHRoZSBCTyBzaG91bGQgdXNlIGxp
bmVhciBWUkFNICovCj4+PiAgICNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9DT05USUdV
T1VTICAgICgxIDw8IDUpCj4+PiArLyogRmxhZyB0aGF0IEJPIGlzIGxvY2FsIGluIHRoZSBWTSAq
Lwo+Pj4gKyNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfTE9DQUwgICAgICAgICAgICAoMSA8PCA2
KQo+PiBJJ20gbm90IGNyYXp5IGFib3V0IHRoZSBuYW1lIExPQ0FMLiAgTWF5YmUgc29tZXRoaW5n
IGxpa2UgQUxXQVlTX1ZBTElEPwo+IAo+IFdvcmtzIGZvciBtZSBhcyB3ZWxsLiBEYXZlIGFueSBv
dGhlciBvcGluaW9uPwo+IAo+IElmIGV2ZXJ5Ym9keSBpcyBvayB3aXRoIEFMV0FZU19WQUxJRCBJ
J20gZ29pbmcgdG8gdXNlIHRoYXQgb25lLgoKRldJVywgSSBsaWtlIExPQ0FMIGJldHRlciB0aGFu
IEFMV0FZU19WQUxJRC4gVGhlIGxhdHRlciBzdWdnZXN0cyB0aGF0CnRoZSBCTyBpcyB2YWxpZCB1
bmRlciBhbnkgY2lyY3Vtc3RhbmNlcywgd2hlcmVhcyBMT0NBTCBpbmRpY2F0ZXMgdGhhdCBpdApj
YW5ub3QgYmUgdXNlZCBvdXRzaWRlIG9mIHRoZSBHUFVWTSBpdCB3YXMgY3JlYXRlZCBpbi4KCkkg
ZG9uJ3QgZmVlbCBzdHJvbmdseSBhYm91dCBpdCB0aG91Z2gsIGZlZWwgZnJlZSB0byBnbyB3aXRo
IGVpdGhlci4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
