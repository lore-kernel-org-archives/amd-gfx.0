From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 01/13] drm/amdgpu: introduce and honour DRM_FORCE_AUTH
 workaround
Date: Fri, 21 Jun 2019 09:41:20 +0200
Message-ID: <80d7f5d7-e1a3-f03b-6dd9-d1979da27adc@daenzer.net>
References: <20190527081741.14235-1-emil.l.velikov@gmail.com>
 <20190614120927.GA32412@arch-x1c3>
 <9dbdda6c-8916-e5ae-1676-86828b9890e7@amd.com>
 <20190614155325.GC32412@arch-x1c3>
 <84b3337c-0cdc-44d4-02c6-c56bd729ed47@amd.com>
 <20190620163012.GF1896@arch-x1c3>
 <9cad6e74-4751-0b0a-35d1-e8f0ac4d3efc@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9cad6e74-4751-0b0a-35d1-e8f0ac4d3efc-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wNi0yMSA5OjEyIGEubS4sIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3RlOgo+IAo+IEZp
cnN0IG9mIGFsbCBJIHRyaWVkIHRvIGRpc2FibGUgRFJNIGF1dGhlbnRpY2F0aW9uIGNvbXBsZXRl
bHkgd2l0aCBhIAo+IGtlcm5lbCBjb25maWcgb3B0aW9uLiBTdXJwcmlzaW5nbHkgdGhhdCBhY3R1
YWxseSB3b3JrcyBvdXQgb2YgdGhlIGJveCBhdCAKPiBsZWFzdCBvbiB0aGUgQU1ER1BVIHN0YWNr
Lgo+IAo+IFRoaXMgZWZmZWN0aXZlbHkgYWxsb3dzIHVzIHRvIGdldCByaWQgb2YgRFJJMiBhbmQg
dGhlIHJlbGF0ZWQgc2VjdXJpdHkgCj4gcHJvYmxlbXMuIE9ubHkgdGhpbmcgbGVmdCBmb3IgdGhh
dCBpcyB0aGF0IEknbSBqdXN0IG5vdCBzdXJlIGhvdyB0byAKPiBzaWduYWwgdGhpcyB0byB1c2Vy
c3BhY2Ugc28gdGhhdCB0aGUgRERYIHdvdWxkbid0IGFkdmVydGlzZSBEUkkyIGF0IGFsbCAKPiBh
bnkgbW9yZS4KCkZXSVcsIGdldHRpbmcgcmlkIG9mIERSSTIgYWxzbyBuZWVkcyB0byBiZSBkaXNj
dXNzZWQgd2l0aCBhbWRncHUtcHJvCk9wZW5HTCBkcml2ZXIgZm9sa3MuCgoKPiBBcyBhIG5leHQg
c3RlcCBJIGxvb2tlZCBpbnRvIGlmIHdlIGNhbiBkaXNhYmxlIHRoZSBjb21tYW5kIHN1Ym1pc3Np
b24gCj4gZm9yIERSTSBtYXN0ZXIuIFR1cm5lZCBvdXQgdGhhdCB0aGlzIGlzIHJlbGF0aXZlbHkg
ZWFzeSBhcyB3ZWxsLgo+IAo+IEFsbCB3ZSBoYXZlIHRvIGRvIGlzIHRvIGZpeCB0aGUgYnVnIE1p
Y2hlbCBwb2ludGVkIG91dCBhYm91dCBLTVMgaGFuZGxlcyAKPiBmb3IgZGlzcGxheQoKSSdtIHdv
cmtpbmcgb24gdGhhdCwgY29uc2lkZXIgaXQgZml4ZWQuCgoKPiBhbmQgbGV0IHRoZSBERFggdXNl
IGEgcmVuZGVyIG5vZGUgaW5zdGVhZCBvZiB0aGUgRFJNIG1hc3RlciBmb3IgR2xhbW9yLgo+IFN0
aWxsIG5lZWQgdG8gc3luYyB1cCB3aXRoIE1pY2hlbCBhbmQvb3IgTWFyZWsgd2hhdHMgdGhlIGJl
c3Qgd2F5IG9mCj4gZG9pbmcgdGhpcy4KCk15IHN1Z2dlc3Rpb24gd2FzIHRvIGFkZCBhIG5ldyB2
YXJpYW50IG9mIGFtZGdwdV9kZXZpY2VfaW5pdGlhbGl6ZS4gV2hlbgp0aGUgbmV3IHZhcmlhbnQg
aXMgY2FsbGVkLCBsaWJkcm1fYW1kZ3B1IGludGVybmFsbHkgdXNlcyBhIHJlbmRlciBub2RlCmZv
ciBjb21tYW5kIHN1Ym1pc3Npb24gZXRjLiB3aGVuZXZlciBwb3NzaWJsZS4KCgotLSAKRWFydGhs
aW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgaHR0cHM6Ly93
d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
