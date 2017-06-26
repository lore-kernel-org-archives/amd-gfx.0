From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix solid screen and hard hang when 2k + 4k
 display connected with DP
Date: Mon, 26 Jun 2017 18:53:03 +0800
Message-ID: <20170626105302.GA1824@hr-amur2>
References: <1498460629-9481-1-git-send-email-ray.huang@amd.com>
 <24e624a1-3f79-752a-ef12-adf5c1b407a2@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <24e624a1-3f79-752a-ef12-adf5c1b407a2-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Qiao,
 Joe(Markham)" <Joe2.Qiao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Jiang,
 Sonny" <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCBKdW4gMjYsIDIwMTcgYXQgMDM6MTg6NTJQTSArMDgwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAyNi4wNi4yMDE3IHVtIDA5OjAzIHNjaHJpZWIgSHVhbmcgUnVpOgo+ID4g
U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiA+IENjOiBYaWFv
amllIFl1YW4gPFhpYW9qaWUuWXVhbkBhbWQuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDIgKy0KPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
Cj4gYW1kZ3B1L2FtZGdwdV9wc3AuYwo+ID4gaW5kZXggNWJlZDQ4My4uNjBkMDQ1NSAxMDA2NDQK
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCj4gPiBAQCAtMTMwLDcg
KzEzMCw3IEBAIHBzcF9jbWRfc3VibWl0X2J1ZihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKPiA+
ICAgICAgICByZXQgPSBwc3BfY21kX3N1Ym1pdChwc3AsIHVjb2RlLCBjbWRfYnVmX21jX2FkZHIs
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmVuY2VfbWNfYWRkciwgaW5kZXgpOwo+
ID4gIAo+ID4gLSAgICAgd2hpbGUgKCooKHVuc2lnbmVkIGludCAqKXBzcC0+ZmVuY2VfYnVmKSAh
PSBpbmRleCkgewo+ID4gKyAgICAgd2hpbGUgKCooKHVuc2lnbmVkIGludCAqKXBzcC0+ZmVuY2Vf
YnVmKSA8IGluZGV4KSB7Cj4gCj4gVGhhdCBpcyBzdGlsbCBob3JyaWJsZSBpbmNvcnJlY3QuIEF0
IGJhcmUgbWluaW11bSB5b3UgbmVlZCB0byB1c2UgdGhlCj4gUkVBRF9PTkNFKCkgbWFjcm8gaGVy
ZS4KPiAKClNvLCBSRUFEX09OQ0UoKigodW5zaWduZWQgaW50ICopcHNwLT5mZW5jZV9idWYpKSA8
IGluZGV4LgpEbyB5b3UgbWVhbiB0aGUgY29tcGxpZXIgbWlnaHQgY2F1c2UgdG8gcmVhZCB0aGUg
cHJldmlvdXMgZmVuY2UgYnVmZmVyCnZhbHVlIGlmIHdlIGRvbid0IGFkZCBSRUFEX09OQ0U/Cgo+
IEJ1dCBpdCB3b3VsZCBiZSBldmVuIGJldHRlciB0byBjb21wbGV0ZWx5IGRyb3AgdGhpcyBhbmQg
dXNlIHRoZSBmZW5jZQo+IGltcGxlbWVudGF0aW9uIGluIGFtZGdwdV9mZW5jZS5jIGFzIHdlbGwu
Cj4gCgpJIHVuZGVyc3RhbmQsIEkgd2lsbCByZWZhY3RvciBpdCBhZnRlciBTMyBzdHJlc3MgY29t
cGxldGVkLgoKVGhhbmtzLApSYXkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
