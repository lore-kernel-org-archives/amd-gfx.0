From: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] mm/hmm: Only set FAULT_FLAG_ALLOW_RETRY for
 non-blocking
Date: Fri, 10 May 2019 16:14:03 -0400
Message-ID: <20190510201403.GG4507@redhat.com>
References: <20190510195258.9930-1-Felix.Kuehling@amd.com>
 <20190510195258.9930-3-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190510195258.9930-3-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "alex.deucher-5C7GfCeVMHo@public.gmane.org" <alex.deucher-5C7GfCeVMHo@public.gmane.org>

T24gRnJpLCBNYXkgMTAsIDIwMTkgYXQgMDc6NTM6MjRQTSArMDAwMCwgS3VlaGxpbmcsIEZlbGl4
IHdyb3RlOgo+IERvbid0IHNldCB0aGlzIGZsYWcgYnkgZGVmYXVsdCBpbiBobW1fdm1hX2RvX2Zh
dWx0LiBJdCBpcyBzZXQKPiBjb25kaXRpb25hbGx5IGp1c3QgYSBmZXcgbGluZXMgYmVsb3cuIFNl
dHRpbmcgaXQgdW5jb25kaXRpb25hbGx5Cj4gY2FuIGxlYWQgdG8gaGFuZGxlX21tX2ZhdWx0IGRv
aW5nIGEgbm9uLWJsb2NraW5nIGZhdWx0LCByZXR1cm5pbmcKPiAtRUJVU1kgYW5kIHVubG9ja2lu
ZyBtbWFwX3NlbSB1bmV4cGVjdGVkbHkuCj4gCj4gU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxp
bmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogSsOpcsO0bWUgR2xpc3Nl
IDxqZ2xpc3NlQHJlZGhhdC5jb20+Cgo+IC0tLQo+ICBtbS9obW0uYyB8IDIgKy0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L21tL2htbS5jIGIvbW0vaG1tLmMKPiBpbmRleCBiNjVjMjdkNWMxMTkuLjNjNGYxZDYyMjAyZiAx
MDA2NDQKPiAtLS0gYS9tbS9obW0uYwo+ICsrKyBiL21tL2htbS5jCj4gQEAgLTMzOSw3ICszMzks
NyBAQCBzdHJ1Y3QgaG1tX3ZtYV93YWxrIHsKPiAgc3RhdGljIGludCBobW1fdm1hX2RvX2ZhdWx0
KHN0cnVjdCBtbV93YWxrICp3YWxrLCB1bnNpZ25lZCBsb25nIGFkZHIsCj4gIAkJCSAgICBib29s
IHdyaXRlX2ZhdWx0LCB1aW50NjRfdCAqcGZuKQo+ICB7Cj4gLQl1bnNpZ25lZCBpbnQgZmxhZ3Mg
PSBGQVVMVF9GTEFHX0FMTE9XX1JFVFJZIHwgRkFVTFRfRkxBR19SRU1PVEU7Cj4gKwl1bnNpZ25l
ZCBpbnQgZmxhZ3MgPSBGQVVMVF9GTEFHX1JFTU9URTsKPiAgCXN0cnVjdCBobW1fdm1hX3dhbGsg
KmhtbV92bWFfd2FsayA9IHdhbGstPnByaXZhdGU7Cj4gIAlzdHJ1Y3QgaG1tX3JhbmdlICpyYW5n
ZSA9IGhtbV92bWFfd2Fsay0+cmFuZ2U7Cj4gIAlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSA9
IHdhbGstPnZtYTsKPiAtLSAKPiAyLjE3LjEKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
