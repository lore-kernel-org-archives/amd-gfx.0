From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix prime teardown order
Date: Fri, 9 Mar 2018 15:07:21 +0100
Message-ID: <083be9c1-d3e7-ea5a-c5ad-453002f844ef@gmail.com>
References: <20180309134604.2390-1-christian.koenig@amd.com>
 <d0c896ef-de5f-ff95-ea2b-14eb51064c4d@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d0c896ef-de5f-ff95-ea2b-14eb51064c4d-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDkuMDMuMjAxOCB1bSAxNTowNSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDMtMDkgMDI6NDYgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFdlIHVubWFwcGVkIGlt
cG9ydGVkIERNQS1idWZzIHdoZW4gdGhlIEdFTSBoYW5kbGUgd2FzIGRyb3BwZWQsIG5vdCB3aGVu
IHRoZQo+PiBoYXJkd2FyZSB3YXMgZG9uZSB3aXRoIHRoZSBidWZmZXJlLgo+IEdvb2QgY2F0Y2gh
IEkgZ3Vlc3MgdGhhdCBleHBsYWlucyBzb21lIG9kZGl0aWVzIEkgc29tZXRpbWVzIHNhdyB3aXRo
Cj4gUFJJTUUuIEJvdGggcGF0Y2hlcyBhcmUKClllYWggYW5kIGl0IHRvb2sgbWUgYSBtb250aCB0
byBodW50IHRoYXQgZG93bi4gVGhhbmtzIHRvIElPTU1VIG9yIApvdGhlcndpc2UgSSB3b3VsZG4n
dCBoYXZlIGV2ZW4gbm90aWNlZCB0aGF0IHNvbWV0aGluZyBpcyB3cm9uZy4KCj4gUmV2aWV3ZWQt
Ynk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgoKVGhhbmtzLApDaHJp
c3RpYW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
