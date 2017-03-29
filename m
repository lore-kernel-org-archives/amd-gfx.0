From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix multi-level page table bugs for large
 BOs
Date: Wed, 29 Mar 2017 17:22:01 +0200
Message-ID: <d7279f4d-023e-a8fb-c08f-4e85fec87bd6@amd.com>
References: <1490749231-16157-1-git-send-email-Felix.Kuehling@amd.com>
 <1490749231-16157-4-git-send-email-Felix.Kuehling@amd.com>
 <58DB21CB.4090800@amd.com>
 <DM5PR1201MB0235AB2363725D0D8320265292350@DM5PR1201MB0235.namprd12.prod.outlook.com>
 <58DB4D02.7020903@amd.com> <8acdbd65-f99d-3e0e-b61b-318cf27d7a3b@vodafone.de>
 <bdbacee3-2c61-ebcb-1421-5c0a77dc27e0@amd.com>
 <a2d6c20e-d35f-e135-342b-47f86683c3e3@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a2d6c20e-d35f-e135-342b-47f86683c3e3-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMjkuMDMuMjAxNyB1bSAxNjo0NiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDI5LzAz
LzE3IDExOjMyIFBNLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPj4gT24gMTctMDMtMjkgMDI6NTIg
QU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBQbGVhc2UgY2xlYW4gdGhhdCB1cCBhbmQg
YWxzbyByZW1vdmUgYWxsIHRob3NlIFdBUk5fT04oKSwgd2UgZG9uJ3QKPj4+IHdhbnQgdG8gc3Bh
bSB0aGUgc3lzdGVtIGxvZyB3aXRoIGJhY2t0cmFjZXMgbGlrZSB0aGlzLgo+PiBJIGRpc2FncmVl
LiBXaGVuIHlvdSBzZWUgdGhlIGJhY2t0cmFjZXMgZnJvbSBXQVJOX09OcyBpbgo+PiBhbWRncHVf
dm1fZ2V0X3B0LCBpdCBtZWFucyB0aGUgZHJpdmVyIGlzIHRyeWluZyB0byB1cGRhdGUgYSBwYWdl
IHRhYmxlCj4+IHRoYXQgaGFzbid0IGJlZW4gYWxsb2NhdGVkLiBXaXRob3V0IHRob3NlIFdBUk5f
T05zIHRoZXJlIGlzIGFic29sdXRlbHkKPj4gbm8gd2FybmluZyBvZiBhbnkga2luZCAtIGFtZGdw
dV92bV91cGRhdGVfcHRlIGp1c3QgZmFpbHMgc2lsZW50bHkgKGl0J3MKPj4gYSB2b2lkIGZ1bmN0
aW9uKS4KPj4KPj4gVGhlcmVmb3JlIEkgd291bGRuJ3QgY2FsbCB0aG9zZSB3YXJuaW5ncyBzcGFt
LiBHaXZlbiB0aGF0IHRoZSBWTSBQVAo+PiBhbGxvY2F0aW9uIGNvZGUgZm9yIG11bHRpLWxldmVs
cyBpcyBub24tdHJpdmlhbCwgSSB0aGluayB0aGF0J3MgYSBnb29kCj4+IHNhbml0eSBjaGVjayB0
byBoYXZlIGFuZCByZWFsbHkgaGVscGZ1bCB0byBzZWUgaW4gYSBsb2cgd2hlbiB1c2VyIHJlcG9y
dAo+PiByYW5kb20gVk0gZmF1bHRzLgo+IFdBUk5fT05fT05DRSBtaWdodCBiZSBhIGNvbXByb21p
c2UuIFdlJ2xsIHN0aWxsIGdldCBhIGJhY2t0cmFjZSwgYnV0IGl0Cj4gd29uJ3QgY2F1c2UgY3Jh
enkgbG9nIHNwYW0gaWYgdGhlIGJhZCBjb25kaXRpb24gaXMgY29uc2lzdGVudGx5IGhpdC4KR29v
ZCBpZGVhLiBXZSBzaG91bGQgYWxzbyBvbmx5IGFkZCBvbmUgYXQgdGhlIGJlZ2lubmluZyBvZiB0
aGUgZnVuY3Rpb24gCmFuZCBub3QgbXVsdGlwbGUgY2F0Y2hlcyBmb3IgZWFjaCBkZXBlbmRlbnQg
dmFyaWFibGUuCgpSZWdhcmRzLApDaHJpc3RpYW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
