From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu: add AMDGPU_GEM_CREATE_VRAM_LINEAR flag v2
Date: Tue, 30 Aug 2016 09:44:05 +0200
Message-ID: <44d5d29e-848c-56b2-7f5d-a48a82672288@vodafone.de>
References: <1472462424-3052-1-git-send-email-deathsimple@vodafone.de>
 <1472462424-3052-2-git-send-email-deathsimple@vodafone.de>
 <MWHPR12MB1694759D47B2D6579C5D8F5BF7E10@MWHPR12MB1694.namprd12.prod.outlook.com>
 <8221ebac-36e1-7a5b-2d02-92db63c4cc24@daenzer.net>
 <20160830014919.GA6272@flora>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160830014919.GA6272@flora>
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
To: Flora Cui <flora.cui-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMzAuMDguMjAxNiB1bSAwMzo0OSBzY2hyaWViIEZsb3JhIEN1aToKPiBPbiBUdWUsIEF1ZyAz
MCwgMjAxNiBhdCAwOTo1Nzo1NkFNICswOTAwLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPj4gT24g
MjkvMDgvMTYgMTA6NDcgUE0sIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToKPj4+PiBGcm9tOiBh
bWQtZ2Z4IFttYWlsdG86YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZ10gT24g
QmVoYWxmCj4+Pj4gT2YgQ2hyaXN0aWFuIEvDtm5pZwo+Pj4+IFNlbnQ6IE1vbmRheSwgQXVndXN0
IDI5LCAyMDE2IDU6MjAgQU0KPj4+IEkgc3RpbGwgdGhpbmsgdGhpcyBzaG91bGQgYmUgcmVuYW1l
ZCBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMKPj4+IG9yIHRoZSBhbnRpLWZsYWcg
QU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9TQ0FUVEVSX0dBVEhFUiB0byBhdm9pZAo+Pj4gY29uZnVz
aW9uIHdpdGggbGluZWFyIGluIHRoZSB0aWxpbmcgc2Vuc2UuCj4+IFNlY29uZGVkLgo+Pgo+IGFu
ZCB0aGlzIGNvdWxkIGJlIHRoZSBkZWZhdWx0IG9wdGlvbiB1bmxlc3MKPiBBTURHUFVfR0VNX0NS
RUFURV9WUkFNX1NDQVRURVJfR0FUSEVSIGlzIHNwZWNpZmllZC4KClllYWgsIGJ1dCB0aGVuIHdl
IHdvbid0IGNvcnJlY3RseSB1c2UgaXQgd2l0aCBleGlzdGluZyB1c2Vyc3BhY2UuCgpJIHdpbGwg
anVzdCByZW5hbWUgaXQgdG8gQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9DT05USUdVT1VTLgoKQ2hy
aXN0aWFuLgoKPj4gLS0gCj4+IEVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAg
IHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KPj4gTGlicmUgc29mdHdhcmUgZW50
aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCj4+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWls
aW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
