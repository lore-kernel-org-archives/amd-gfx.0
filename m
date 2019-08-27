From: Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] mm/hmm: hmm_range_fault() infinite loop
Date: Tue, 27 Aug 2019 13:16:13 -0700
Message-ID: <f5c1f198-4bdd-3c23-428f-764f894b9997@nvidia.com>
References: <20190823221753.2514-1-rcampbell@nvidia.com>
 <20190823221753.2514-3-rcampbell@nvidia.com>
 <20190827184157.GA24929@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190827184157.GA24929-uk2M96/98Pc@public.gmane.org>
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
To: Jason Gunthorpe <jgg-uk2M96/98Pc@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

Ck9uIDgvMjcvMTkgMTE6NDEgQU0sIEphc29uIEd1bnRob3JwZSB3cm90ZToKPiBPbiBGcmksIEF1
ZyAyMywgMjAxOSBhdCAwMzoxNzo1M1BNIC0wNzAwLCBSYWxwaCBDYW1wYmVsbCB3cm90ZToKPiAK
Pj4gU2lnbmVkLW9mZi1ieTogUmFscGggQ2FtcGJlbGwgPHJjYW1wYmVsbEBudmlkaWEuY29tPgo+
PiAgIG1tL2htbS5jIHwgMyArKysKPj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
Cj4+Cj4+IGRpZmYgLS1naXQgYS9tbS9obW0uYyBiL21tL2htbS5jCj4+IGluZGV4IDI5MzcxNDg1
ZmU5NC4uNDg4MmI4M2FlY2NiIDEwMDY0NAo+PiArKysgYi9tbS9obW0uYwo+PiBAQCAtMjkyLDYg
KzI5Miw5IEBAIHN0YXRpYyBpbnQgaG1tX3ZtYV93YWxrX2hvbGVfKHVuc2lnbmVkIGxvbmcgYWRk
ciwgdW5zaWduZWQgbG9uZyBlbmQsCj4+ICAgCWhtbV92bWFfd2Fsay0+bGFzdCA9IGFkZHI7Cj4+
ICAgCWkgPSAoYWRkciAtIHJhbmdlLT5zdGFydCkgPj4gUEFHRV9TSElGVDsKPj4gICAKPj4gKwlp
ZiAod3JpdGVfZmF1bHQgJiYgd2Fsay0+dm1hICYmICEod2Fsay0+dm1hLT52bV9mbGFncyAmIFZN
X1dSSVRFKSkKPj4gKwkJcmV0dXJuIC1FUEVSTTsKPiAKPiBDYW4gd2Fsay0+dm1hIGJlIE5VTEwg
aGVyZT8gaG1tX3ZtYV9kb19mYXVsdCgpIHRvdWNoZXMgaXQKPiB1bmNvbmRpdGlvbmFsbHkuCj4g
Cj4gSmFzb24KPiAKd2Fsay0+dm1hIGNhbiBiZSBOVUxMLiBobW1fdm1hX2RvX2ZhdWx0KCkgbm8g
bG9uZ2VyIHRvdWNoZXMgaXQKdW5jb25kaXRpb25hbGx5LCB0aGF0IGlzIHdoYXQgdGhlIHByZWNl
ZGluZyBwYXRjaCBmaXhlcy4KSSBzdXBwb3NlIEkgY291bGQgY2hhbmdlIGhtbV92bWFfd2Fsa19o
b2xlXygpIHRvIGNoZWNrIGZvciBOVUxMCmFuZCBmaWxsIGluIHRoZSBwZm5zW10gYXJyYXksIEkg
anVzdCBjaG9zZSB0byBoYW5kbGUgaXQgaW4KaG1tX3ZtYV9kb19mYXVsdCgpLgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
