From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH RFC v2] drm/amdgpu: Set/clear CPU_ACCESS flag on page
 fault and move to VRAM
Date: Mon, 3 Jul 2017 18:56:27 +0900
Message-ID: <6d89e599-5dd7-6b06-5b0e-8b3efac28d54@daenzer.net>
References: <1498835932-5053-3-git-send-email-john@fastquake.com>
 <1498836668-5872-1-git-send-email-john@fastquake.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1498836668-5872-1-git-send-email-john-xq/Ko7C6e2Bl57MIdRCFDg@public.gmane.org>
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
To: John Brooks <john-xq/Ko7C6e2Bl57MIdRCFDg@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

T24gMDEvMDcvMTcgMTI6MzEgQU0sIEpvaG4gQnJvb2tzIHdyb3RlOgo+IFdoZW4gYSBCTyBpcyBt
b3ZlZCB0byBWUkFNLCBjbGVhciBBTURHUFVfQk9fRkxBR19DUFVfQUNDRVNTLiBUaGlzIGFsbG93
cyBpdAo+IHRvIHBvdGVudGlhbGx5IGxhdGVyIG1vdmUgdG8gaW52aXNpYmxlIFZSQU0gaWYgdGhl
IENQVSBkb2VzIG5vdCBhY2Nlc3MgaXQKPiBhZ2Fpbi4KPiAKPiBTZXR0aW5nIHRoZSBDUFVfQUND
RVNTIGZsYWcgaW4gYW1kZ3B1X2JvX2ZhdWx0X3Jlc2VydmVfbm90aWZ5KCkgYWxzbyBtZWFucwo+
IHRoYXQgd2UgY2FuIHJlbW92ZSB0aGUgbG9vcCB0byByZXN0cmljdCBscGZuIHRvIHRoZSBlbmQg
b2YgdmlzaWJsZSBWUkFNLAo+IGJlY2F1c2UgYW1kZ3B1X3R0bV9wbGFjZW1lbnRfaW5pdCgpIHdp
bGwgZG8gaXQgZm9yIHVzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gQnJvb2tzIDxqb2huQGZh
c3RxdWFrZS5jb20+CgpbLi4uXQoKPiBAQCAtNDQ2LDYgKzQ0OCwxMiBAQCBzdGF0aWMgaW50IGFt
ZGdwdV9tb3ZlX3JhbV92cmFtKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCj4gIAlpZiAo
dW5saWtlbHkocikpIHsKPiAgCQlnb3RvIG91dF9jbGVhbnVwOwo+ICAJfQo+ICsKPiArCS8qIFRo
ZSBwYWdlIGZhdWx0IGhhbmRsZXIgd2lsbCByZS1zZXQgdGhpcyBpZiB0aGUgQ1BVIGFjY2Vzc2Vz
IHRoZSBCTwo+ICsJICogYWZ0ZXIgaXQncyBtb3ZlZC4KPiArCSAqLwo+ICsJYWJvLT5mbGFncyAm
PSB+QU1ER1BVX0JPX0ZMQUdfQ1BVX0FDQ0VTUzsKCkkndmUgY29tZSB0byByZWFsaXplIHRoYXQg
dGhlIGZsYWcgYWxzbyBuZWVkcyB0byBiZSBjbGVhcmVkIGF0IHRoZSBlbmQKb2YgYW1kZ3B1X2Jv
X2NyZWF0ZV9yZXN0cmljdGVkLCBvdGhlcndpc2Ugd2Ugd2lsbCBpbmNvcnJlY3RseSBhc3N1bWUK
dGhhdCBldmVyeSBCTyBjcmVhdGVkIHdpdGggdGhpcyBmbGFnIGhhcyBiZWVuIGFjY2Vzc2VkIGJ5
IHRoZSBDUFUuCgoKQlRXLCB0aGVyZSdzIGFsc28gYSBtaW5vciBpc3N1ZSBoZXJlIGluIHRoYXQg
dGhlIGZsYWdzIG1lbWJlciBpcyB1NjQsCmJ1dCB0aGUgZmxhZ3MgYXJlIGRlZmluZWQgYXMgaW50
cy4gUHJvYmFibHkgZG9lc24ndCBtYXR0ZXIgc28gZmFyLCBidXQKaXQgd291bGQgYXMgc29vbiBh
cyBhbnkgZmxhZydzIHZhbHVlIGlzID49ICgxIDw8IDMyKS4KCgotLSAKRWFydGhsaW5nIE1pY2hl
bCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNv
bQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVz
YSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
