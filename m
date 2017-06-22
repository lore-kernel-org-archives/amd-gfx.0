From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: optimize out a spin lock (v2)
Date: Thu, 22 Jun 2017 12:09:51 +0900
Message-ID: <082d9d6f-da0d-00c7-f43d-4f270b841987@daenzer.net>
References: <1498099554-31861-1-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1498099554-31861-1-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjIvMDYvMTcgMTE6NDUgQU0sIEFsZXggWGllIHdyb3RlOgo+IFVzZSBhdG9taWMgaW5zdGVh
ZCBvZiBzcGluIGxvY2suCj4gdjI6IEFkanVzdCBjb21taXQgbWVzc2FnZQo+IAo+IFNpZ25lZC1v
ZmYtYnk6IEFsZXggWGllIDxBbGV4QmluLlhpZUBhbWQuY29tPgoKVGhlIHNob3J0bG9nIHNob3Vs
ZCBiZSBtb3JlIHNwZWNpZmljLCBlLmcuIHNvbWV0aGluZyBsaWtlICJkcm0vYW1kZ3B1OgpEcm9w
IHNwaW5sb2NrIGZyb20gbW1fc3RhdHMiLgoKSXQncyBpbXBvcnRhbnQgZm9yIHRoZSBHaXQgY29t
bWl0IHNob3J0bG9nIHRvIGJlIGFzIHNwZWNpZmljIGFzIHBvc3NpYmxlCmJlY2F1c2UgaW4gbWFu
eSBjYXNlcyBvbmx5IHRoZSBzaG9ydGxvZ3Mgb2YgY29tbWl0cyBhcmUgdmlzaWJsZS4KCgpJJ2xs
IGxlYXZlIGl0IHRvIG90aGVycyB0byBqdWRnZSB3aGV0aGVyIHRoZSBjb252ZXJzaW9uIGZyb20g
c3BpbmxvY2sgdG8KYXRvbWljcyBpcyBzYWZlIC8gYW4gb3ZlcmFsbCB3aW4uCgoKPiAgCS8qIFRo
aXMgcmV0dXJucyAwIGlmIHRoZSBkcml2ZXIgaXMgaW4gZGVidCB0byBkaXNhbGxvdyAob3B0aW9u
YWwpCj4gIAkgKiBidWZmZXIgbW92ZXMuCj4gIAkgKi8KPiAtCW1heF9ieXRlcyA9IHVzX3RvX2J5
dGVzKGFkZXYsIGFkZXYtPm1tX3N0YXRzLmFjY3VtX3VzKTsKPiAtCj4gLQlzcGluX3VubG9jaygm
YWRldi0+bW1fc3RhdHMubG9jayk7Cj4gKwltYXhfYnl0ZXMgPSB1c190b19ieXRlcyhhZGV2LCBh
Y2N1bV91cyk7Cj4gIAlyZXR1cm4gbWF4X2J5dGVzOwo+ICB9CgpZb3UgY2FuIGp1c3QgbWFrZSB0
aGlzCgoJcmV0dXJuIHVzX3RvX2J5dGVzKGFkZXYsIGFjY3VtX3VzKTsKCmFuZCByZW1vdmUgdGhl
IG1heF9ieXRlcyBsb2NhbC4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBl
bnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
