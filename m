From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH hmm] drm/amdkfd: fix a use after free race with
 mmu_notififer unregister
Date: Tue, 6 Aug 2019 11:33:26 +0300
Message-ID: <CAFCwf10aRHeXuOg+5o6=VgzM1dhFQde=b0jZSmgF4DfibYcp_A@mail.gmail.com>
References: <20190802200705.GA10110@ziepe.ca>
 <c59ebe8b-9b18-24b8-b02c-8ccaa7df4dc9@amd.com>
 <20190806073105.GA20575@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190806073105.GA20575-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
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
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Ben Goz <ben.goz-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBBdWcgNiwgMjAxOSBhdCAxMDozMSBBTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOgo+Cj4gQnR3LCB3aG8gbWFpbnRhaW5zIGFta2ZkIHRoZXNlIGRh
eXM/ICBNQUlOVEFJTkVSUyBzdGlsbCBsaXN0cwo+IE9kZWQsIGJ1dCBoZSBzZWVtcyB0byBoYXZl
IG1vdmVkIG9uIHRvIEhhYmFuYWxhYnMgYW5kIG1haW50YWlucyB0aGF0Cj4gZHJpdmVycyBub3cg
d2hpbGUgbm90IGhhdmluZyBhbnkgYWN0aW9uIG9uIGFtZGtmZCBmb3Igb3ZlciBhIHllYXIuCgpJ
J3ZlIHNlbnQgYSBwYXRjaCB0byB1cGRhdGUgdGhlIE1BSU5UQUlORVJTIGZpbGUgYSBtb250aCBh
Z28gdG8KZHJpLWRldmVsIGFuZCBEYXZlCihodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9h
cmNoaXZlcy9kcmktZGV2ZWwvMjAxOS1KdWx5LzIyNTI3Mi5odG1sKQoKVGhhbmtzLApPZGVkCgpP
ZGVkCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
