From: Flora Cui <flora.cui-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu: add AMDGPU_GEM_CREATE_VRAM_LINEAR flag v2
Date: Tue, 30 Aug 2016 09:49:20 +0800
Message-ID: <20160830014919.GA6272@flora>
References: <1472462424-3052-1-git-send-email-deathsimple@vodafone.de>
 <1472462424-3052-2-git-send-email-deathsimple@vodafone.de>
 <MWHPR12MB1694759D47B2D6579C5D8F5BF7E10@MWHPR12MB1694.namprd12.prod.outlook.com>
 <8221ebac-36e1-7a5b-2d02-92db63c4cc24@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8221ebac-36e1-7a5b-2d02-92db63c4cc24-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, 'Christian =?iso-8859-1?Q?K=F6nig'?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBBdWcgMzAsIDIwMTYgYXQgMDk6NTc6NTZBTSArMDkwMCwgTWljaGVsIETDpG56ZXIg
d3JvdGU6Cj4gT24gMjkvMDgvMTYgMTA6NDcgUE0sIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToK
PiA+PiBGcm9tOiBhbWQtZ2Z4IFttYWlsdG86YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZ10gT24gQmVoYWxmCj4gPj4gT2YgQ2hyaXN0aWFuIEvDtm5pZwo+ID4+IFNlbnQ6IE1v
bmRheSwgQXVndXN0IDI5LCAyMDE2IDU6MjAgQU0KPiA+IAo+ID4gSSBzdGlsbCB0aGluayB0aGlz
IHNob3VsZCBiZSByZW5hbWVkIEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fQ09OVElHVU9VUwo+ID4g
b3IgdGhlIGFudGktZmxhZyBBTURHUFVfR0VNX0NSRUFURV9WUkFNX1NDQVRURVJfR0FUSEVSIHRv
IGF2b2lkCj4gPiBjb25mdXNpb24gd2l0aCBsaW5lYXIgaW4gdGhlIHRpbGluZyBzZW5zZS4KPiAK
PiBTZWNvbmRlZC4KPiAKYW5kIHRoaXMgY291bGQgYmUgdGhlIGRlZmF1bHQgb3B0aW9uIHVubGVz
cwpBTURHUFVfR0VNX0NSRUFURV9WUkFNX1NDQVRURVJfR0FUSEVSIGlzIHNwZWNpZmllZC4KPiAK
PiAtLSAKPiBFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgaHR0cDovL3d3dy5hbWQuY29tCj4gTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAg
ICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
