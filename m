From: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH hmm 02/15] mm/mmu_notifier: add an interval tree notifier
Date: Mon, 21 Oct 2019 15:47:48 -0400
Message-ID: <20191021194748.GA5644@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-3-jgg@ziepe.ca>
 <20191021183056.GA3177@redhat.com>
 <20191021185421.GG6285@mellanox.com>
 <20191021191157.GA5208@redhat.com>
 <20191021192448.GK6285@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191021192448.GK6285-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Content-Disposition: inline
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
To: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Cc: Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Felix.Kuehling-5C7GfCeVMHo@public.gmane.org" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

T24gTW9uLCBPY3QgMjEsIDIwMTkgYXQgMDc6MjQ6NTNQTSArMDAwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IE9uIE1vbiwgT2N0IDIxLCAyMDE5IGF0IDAzOjExOjU3UE0gLTA0MDAsIEplcm9t
ZSBHbGlzc2Ugd3JvdGU6Cj4gPiA+IFNpbmNlIHRoYXQgcmVhZGVyIGlzIG5vdCBsb2NrZWQgd2Ug
bmVlZCByZWxlYXNlIHNlbWFudGljcyBoZXJlIHRvCj4gPiA+IGVuc3VyZSB0aGUgdW5sb2NrZWQg
cmVhZGVyIHNlZXMgYSBmdWxseSBpbml0aW5hbGl6ZWQgbW11X25vdGlmaWVyX21tCj4gPiA+IHN0
cnVjdHVyZSB3aGVuIGl0IG9ic2VydmVzIHRoZSBwb2ludGVyLgo+ID4gCj4gPiBJIHRob3VnaHQg
dGhlIG1tX3Rha2VfYWxsX2xvY2tzKCkgd291bGQgaGF2ZSBoYWQgYSBiYXJyaWVyIGFuZCB0aHVz
Cj4gPiB0aGF0IHlvdSBjb3VsZCBub3Qgc2VlIG1tdV9ub3RpZmllciBzdHJ1Y3QgcGFydGlhbHkg
aW5pdGlhbGl6ZWQuIAo+IAo+IE5vdCBzdXJlLCB1c3VhbGx5IGEgbG9jayBhY3F1aXJlIGRvZXNu
J3QgaGF2ZSBhIHN0b3JlIGJhcnJpZXI/CgpZZWFoIGxpa2VseS4KCj4gCj4gRXZlbiBpZiBpdCBk
aWQsIHdlIHdvdWxkIHN0aWxsIG5lZWQgc29tZSBwYWlyaW5nIHJlYWQgYmFycmllci4uCj4gCj4g
PiBoYXZpbmcgdGhlIGFjcXVpcmUvcmVsZWFzZSBhcyBzYWZldHkgbmV0IGRvZXMgbm90IGh1cnQu
IE1heWJlIGFkZCBhCj4gPiBjb21tZW50IGFib3V0IHRoZSBzdHJ1Y3QgaW5pdGlhbGl6YXRpb24g
bmVlZGluZyB0byBiZSB2aXNpYmxlIGJlZm9yZQo+ID4gcG9pbnRlciBpcyBzZXQuCj4gCj4gSXMg
dGhpcyBjbGVhcj8KPiAKPiAgICAgICAgICAqIHJlbGVhc2Ugc2VtYW50aWNzIG9uIHRoZSBpbml0
aWFsaXphdGlvbiBvZiB0aGUKPiAgICAgICAgICAqIG1tdV9ub3RpZmllcl9tbSdzIGNvbnRlbnRz
IGFyZSBwcm92aWRlZCBmb3IgdW5sb2NrZWQgcmVhZGVycy4KPiAJICogYWNxdWlyZSBjYW4gb25s
eSBiZSB1c2VkIHdoaWxlIGhvbGRpbmcgdGhlCj4gICAgICAgICAgKiBtbWdyYWIgb3IgbW1nZXQs
IGFuZCBpcyBzYWZlIGJlY2F1c2Ugb25jZSBjcmVhdGVkIHRoZQo+ICAgICAgICAgICogbW11X25v
dGlmaWZlcl9tbSBpcyBub3QgZnJlZWQgdW50aWwgdGhlIG1tIGlzIGRlc3Ryb3llZC4KPiAgICAg
ICAgICAqIFVzZXJzIGhvbGRpbmcgdGhlIG1tYXBfc2VtIG9yIG9uZSBvZiB0aGUKPiAJICogbW1f
dGFrZV9hbGxfbG9ja3MoKSBkbyBub3QgbmVlZCB0byB1c2UgYWNxdWlyZSBzZW1hbnRpY3MuCj4g
Cj4gSXQgYWxzbyBoZWxwcyBleHBsYWluIHdoeSB0aGVyZSBpcyBubyBsb2NraW5nIGFyb3VuZCB0
aGUgb3RoZXIKPiByZWFkZXJzLCB3aGljaCBoYXMgcHV6emxlZCBtZSBpbiB0aGUgcGFzdCBhdCBs
ZWFzdC4KClBlcmZlY3QuCgpKw6lyw7RtZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
