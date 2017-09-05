From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/6] drm/amdgpu: move taking mmap_sem into get_user_pages
Date: Tue, 5 Sep 2017 18:02:57 -0400
Message-ID: <cb095cd0-64c5-2b51-d101-f330f5f77a3b@amd.com>
References: <1504625871-1756-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1504625871-1756-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

SSBmb3VuZCBhbm90aGVyIHByb2JsZW0gYXMgSSB3YXMgbG9va2luZyBhdCBhZGFwdGluZyBLRkQn
cyB1c2VycHRyIGNvZGUuCgoKT24gMjAxNy0wOS0wNSAxMTozNyBBTSwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBAQCAtNjIy
LDYgKzYyMiw4IEBAIGludCBhbWRncHVfdHRtX3R0X2dldF91c2VyX3BhZ2VzKHN0cnVjdCB0dG1f
dHQgKnR0bSwgc3RydWN0IHBhZ2UgKipwYWdlcykKPiAgCWlmICghKGd0dC0+dXNlcmZsYWdzICYg
QU1ER1BVX0dFTV9VU0VSUFRSX1JFQURPTkxZKSkKPiAgCQlmbGFncyB8PSBGT0xMX1dSSVRFOwo+
ICAKPiArCWRvd25fcmVhZCgmY3VycmVudC0+bW0tPm1tYXBfc2VtKTsKPiArCj4gIAlpZiAoZ3R0
LT51c2VyZmxhZ3MgJiBBTURHUFVfR0VNX1VTRVJQVFJfQU5PTk9OTFkpIHsKPiAgCQkvKiBjaGVj
ayB0aGF0IHdlIG9ubHkgdXNlIGFub255bW91cyBtZW1vcnkKPiAgCQkgICB0byBwcmV2ZW50IHBy
b2JsZW1zIHdpdGggd3JpdGViYWNrICovCj4gQEAgLTY1Nyw2ICs2NTksOCBAQCBpbnQgYW1kZ3B1
X3R0bV90dF9nZXRfdXNlcl9wYWdlcyhzdHJ1Y3QgdHRtX3R0ICp0dG0sIHN0cnVjdCBwYWdlICoq
cGFnZXMpCj4gIAo+ICAJfSB3aGlsZSAocGlubmVkIDwgdHRtLT5udW1fcGFnZXMpOwo+ICAKPiAr
CXVwX3JlYWQoJmN1cnJlbnQtPm1tLT5tbWFwX3NlbSk7Cj4gKwo+ICAJcmV0dXJuIDA7Cj4gIAo+
ICByZWxlYXNlX3BhZ2VzOgoKWW91IG5lZWQgYW5vdGhlciB1cF9yZWFkIGluIHRoZSByZWxlYXNl
X3BhZ2VzIGVycm9yIGhhbmRpbmcgcGF0aC4KClJlZ2FyZHMsCiAgRmVsaXgKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
