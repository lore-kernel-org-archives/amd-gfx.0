From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/23] drm/amdgpu: change wptr to 64 bits
Date: Fri, 16 Jun 2017 12:28:09 -0400
Message-ID: <20170616162808.GA3868@gmail.com>
References: <1489031093-4720-1-git-send-email-alexander.deucher@amd.com>
 <1489031093-4720-3-git-send-email-alexander.deucher@amd.com>
 <2aa692b0-a42c-de15-91f0-0b5142d70ce9@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2aa692b0-a42c-de15-91f0-0b5142d70ce9-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBNYXIgMDksIDIwMTcgYXQgMTA6NTc6MjdBTSArMDEwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAwOS4wMy4yMDE3IHVtIDA0OjQ0IHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+
ID4gRnJvbTogS2VuIFdhbmcgPFFpbmdxaW5nLldhbmdAYW1kLmNvbT4KPiA+IAo+ID4gTmV3ZXIg
YXNpY3MgdXNlIDY0IGJpdCB3cHRycwo+IAo+IFdlIG5lZWQgYSBiZXR0ZXIgcGF0Y2ggZGVzY3Jp
cHRpb24uIE5ld2VyIGFzaWNzIGRvZXNuJ3QgdXNlIDY0Yml0IHdwdHJzLCBidXQKPiByYXRoZXIg
bmVlZCB0aGVtIQo+IAo+IEUuZy4gaWYgdGhlIHdwdHIgaXMgbm93IHNtYWxsZXIgdGhhbiB0aGUg
cnB0ciB0aGF0IGRvZXNuJ3QgaW5kaWNhdGUgYSB3cmFwCj4gYXJvdW5kIGFueSBtb3JlLgoKV2hh
dCBkb2VzIGl0IG1lYW5zID8gRG9lc24ndCBtYWtlIHNlbnNlLCB5b3UgYXJlIGFsbG9jYXRpbmcg
MVRCIGNvbW1hbmQKYnVmZmVyIGFuZCBrbm93IHlvdSB3aWxsIG5ldmVyIHJ1biBvdXQgb2Ygc3Bh
Y2UgPyA7KQoKRWl0aGVyIHdlIGFyZSB0YWxraW5nIGFib3V0IGEgcmluZyBidWZmZXIgYW5kIHRo
ZW4gd3B0ciA8IHJwdHIgbWVhbnMgd3JhcAphcm91bmQgb3Igd2UgYXJlIHRhbGtpbmcgYWJvdXQg
c29tZXRoaW5nIG5ldyB0aGF0IGlzIG5vdCBhIHJpbmcgYnVmZmVyLgoKNjQgYml0cyBvciAzMiBi
aXRzIGRvZXNuJ3QgbWF0dGVyIGZyb20gcmluZyBidWZmZXIgcG9pbnQgb2Ygdmlldy4gU28gaQph
bSBwdXp6bGUgYWJvdXQgd2hhdCB0aGlzIG5ldyB0aGluZyBpcy4gQW55d2hlcmUgaSBjYW4gcmVh
ZCBhYm91dCB0aGlzCm5ldyBjb21tYW5kIGJ1ZmZlciB0aGluZ3kgPyBCZWNhdXNlIGZyb20gd2hl
cmUgaSBzdGFuZCBpdCBsb29rcyBsaWtlIGl0CndvdWxkIGJlIGJldHRlciB0byBiZSBzb21ldGhp
bmcgZWxzZSB0aGFuIGEgcmluZyBidWZmZXIgaWYgdGhlcmUgaXMgbm8Kd3JhcCBhcm91bmQuCgpD
aGVlcnMsCkrDqXLDtG1lIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
