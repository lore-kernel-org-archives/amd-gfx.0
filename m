From: Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 hmm 02/11] mm/mmu_notifiers: do not speculatively
 allocate a mmu_notifier_mm
Date: Wed, 14 Aug 2019 13:32:13 -0700
Message-ID: <d2d8d6a8-7ac5-8f04-c11a-61140fccc5e1@nvidia.com>
References: <20190806231548.25242-1-jgg@ziepe.ca>
 <20190806231548.25242-3-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190806231548.25242-3-jgg-uk2M96/98Pc@public.gmane.org>
Content-Language: en-US
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
To: Jason Gunthorpe <jgg-uk2M96/98Pc@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Dimitri Sivanich <sivanich-sJ/iWh9BUns@public.gmane.org>, Gavin Shan <shangw-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Andrea Righi <andrea-oIIqvOZpAevzfdHfmsDf5w@public.gmane.org>, linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

Ck9uIDgvNi8xOSA0OjE1IFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gRnJvbTogSmFzb24g
R3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgo+IAo+IEEgcHJpb3IgY29tbWl0IGUwZjNjM2Y3
OGRhMiAoIm1tL21tdV9ub3RpZmllcjogaW5pdCBub3RpZmllciBpZiBuZWNlc3NhcnkiKQo+IG1h
ZGUgYW4gYXR0ZW1wdCBhdCBkb2luZyB0aGlzLCBidXQgaGFkIHRvIGJlIHJldmVydGVkIGFzIGNh
bGxpbmcKPiB0aGUgR0ZQX0tFUk5FTCBhbGxvY2F0b3IgdW5kZXIgdGhlIGlfbW1hcF9tdXRleCBj
YXVzZXMgZGVhZGxvY2ssIHNlZQo+IGNvbW1pdCAzNWNmYTJiMGI0OTEgKCJtbS9tbXVfbm90aWZp
ZXI6IGFsbG9jYXRlIG1tdV9ub3RpZmllciBpbiBhZHZhbmNlIikuCj4gCj4gSG93ZXZlciwgd2Ug
Y2FuIGF2b2lkIHRoYXQgcHJvYmxlbSBieSBkb2luZyB0aGUgYWxsb2NhdGlvbiBvbmx5IHVuZGVy
Cj4gdGhlIG1tYXBfc2VtLCB3aGljaCBpcyBhbHJlYWR5IGhhcHBlbmluZy4KPiAKPiBTaW5jZSBh
bGwgd3JpdGVycyB0byBtbS0+bW11X25vdGlmaWVyX21tIGhvbGQgdGhlIHdyaXRlIHNpZGUgb2Yg
dGhlCj4gbW1hcF9zZW0gcmVhZGluZyBpdCB1bmRlciB0aGF0IHNlbSBpcyBkZXRlcm1pbmlzdGlj
IGFuZCB3ZSBjYW4gdXNlIHRoYXQgdG8KPiBkZWNpZGUgaWYgdGhlIGFsbG9jYXRpb24gcGF0aCBp
cyByZXF1aXJlZCwgd2l0aG91dCBzcGVjdWxhdGlvbi4KPiAKPiBUaGUgYWN0dWFsIHVwZGF0ZSB0
byBtbXVfbm90aWZpZXJfbW0gbXVzdCBzdGlsbCBiZSBkb25lIHVuZGVyIHRoZQo+IG1tX3Rha2Vf
YWxsX2xvY2tzKCkgdG8gZW5zdXJlIHJlYWQtc2lkZSBjb2hlcmVuY3kuCj4gCj4gU2lnbmVkLW9m
Zi1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgoKTG9va3MgZ29vZCB0byBt
ZS4KUmV2aWV3ZWQtYnk6IFJhbHBoIENhbXBiZWxsIDxyY2FtcGJlbGxAbnZpZGlhLmNvbT4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
