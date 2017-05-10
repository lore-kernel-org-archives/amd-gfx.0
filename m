From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/3] GPU-DRM-Radeon: Fine-tuning for three function
 implementations
Date: Wed, 10 May 2017 13:30:37 +0200
Message-ID: <66a88c64-cc8f-45ed-81c6-f7e2947f1f18@amd.com>
References: <74d2df52-f509-e6d2-5b35-e25b7cbd1fbe@users.sourceforge.net>
 <799fb921-f620-9054-680d-90b14e4c517c@amd.com>
 <8c4e7dde-06d5-3f13-2322-f661e9d3dbf4@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8c4e7dde-06d5-3f13-2322-f661e9d3dbf4-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

QW0gMTAuMDUuMjAxNyB1bSAwMjoyMyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDAzLzA1
LzE3IDA5OjQ2IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAwMi4wNS4yMDE3IHVt
IDIyOjA0IHNjaHJpZWIgU0YgTWFya3VzIEVsZnJpbmc6Cj4+PiBGcm9tOiBNYXJrdXMgRWxmcmlu
ZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+Cj4+PiBEYXRlOiBUdWUsIDIgTWF5IDIw
MTcgMjI6MDA6MDIgKzAyMDAKPj4+Cj4+PiBUaHJlZSB1cGRhdGUgc3VnZ2VzdGlvbnMgd2VyZSB0
YWtlbiBpbnRvIGFjY291bnQKPj4+IGZyb20gc3RhdGljIHNvdXJjZSBjb2RlIGFuYWx5c2lzLgo+
Pj4KPj4+IE1hcmt1cyBFbGZyaW5nICgzKToKPj4+ICAgICBVc2Ugc2VxX3B1dGMoKSBpbiByYWRl
b25fc2FfYm9fZHVtcF9kZWJ1Z19pbmZvKCkKPj4+ICAgICBVc2Ugc2VxX3B1dHMoKSBpbiByYWRl
b25fZGVidWdmc19wbV9pbmZvKCkKPj4+ICAgICBVc2Ugc2VxX3B1dHMoKSBpbiByMTAwX2RlYnVn
ZnNfY3BfY3NxX2ZpZm8oKQo+PiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgo+IEJhc2VkIG9uCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvYXJjaGl2ZXMvZHJpLWRldmVsLzIwMTctTWF5LzE0MDgzNy5odG1sCj4gYW5kIGZvbGxv
d3VwcywgSSdtIGFmcmFpZCB3ZSdsbCBoYXZlIHRvIG1ha2Ugc3VyZSBNYXJrdXMnIHBhdGNoZXMg
aGF2ZQo+IGJlZW4gdGVzdGVkIGFkZXF1YXRlbHkgYmVmb3JlIGFwcGx5aW5nIHRoZW0uCgpJIGNh
bid0IGp1ZGdlIHRoZSBiYWNrZ3JvdW5kIG9mIHRoYXQgZGVjaXNpb24sIGJ1dCBhdCBsZWFzdCB0
aG9zZSB0cmVlIApwYXRjaGVzIGZvciByYWRlb24gbG9va2VkIHRyaXZpYWwgdG8gbWUuCgpJIGRv
bid0IHNlZSBtdWNoIHdoYXQgY291bGQgZ28gd3Jvbmcgd2hlbiBtZXJnaW5nIHRoZW0uIE9uIHRo
ZSBvdGhlciAKaGFuZCB5b3UgYXJlIHJpZ2h0IHRoYXQgdHJ5aW5nIHRvIGZpbmQgaGFyZHdhcmUg
dG8gdGVzdCB0aGF0IHN0dWZmIGNvdWxkIApiZSBjaGFsbGVuZ2luZy4KCkNocmlzdGlhbi4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
