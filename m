From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/12] drm/amdgpu: send IVs to the KFD only after
 processing them
Date: Thu, 27 Sep 2018 11:32:02 +0200
Message-ID: <fa8dd071-ca32-d2d7-74c6-dd5eff132aae@gmail.com>
References: <20180926135330.2218-1-christian.koenig@amd.com>
 <20180926135330.2218-2-christian.koenig@amd.com>
 <1537986270.3887323.1521702048.0DEA7A63@webmail.messagingengine.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1537986270.3887323.1521702048.0DEA7A63-2RFepEojUI2N1INw9kWLP6GC3tUn3ZHUQQ4Iyu8u01E@public.gmane.org>
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
To: Jay Cornwall <jay-gJmSnxjMpeIS+FvcfC7Uqw@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjYuMDkuMjAxOCB1bSAyMDoyNCBzY2hyaWViIEpheSBDb3Jud2FsbDoKPiBPbiBXZWQsIFNl
cCAyNiwgMjAxOCwgYXQgMDg6NTMsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFRoaXMgYWxs
b3dzIHVzIHRvIGZpbHRlciBvdXQgVk0gZmF1bHRzIGluIHRoZSBHTUMgY29kZS4KPj4KPj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+
IFRoZSBLRkQgbmVlZHMgdG8gcmVjZWl2ZSBub3RpZmljYXRpb24gb2YgdW5oYW5kbGVkIFZNIGZh
dWx0czsgd2hlbiBkZW1hbmQgcGFnaW5nIGlzIGRpc2FibGVkIG9yIHRoZSBhZGRyZXNzIGlzIG5v
dCBwYWdlYWJsZS4gSXQgcHJvcGFnYXRlcyB0aGlzIHRvIHRoZSBVTUQgKFJPQyBydW50aW1lIG9y
IHRoZSBST0MgZGVidWdnZXIpLgo+Cj4gRG9lcyB0aGlzIHBhdGNoIGNoYW5nZSB0aGF0IGJlaGF2
aW9yPwoKUG90ZW50aWFsbHkgeWVzLiBXZSBoYXZlIHNvbWUgY29kZSBpbiB0aGUgR01DIGhhbmRs
aW5nIGZvciB0aGlzLCBidXQgSSdtIAphY3R1YWxseSBub3Qgc3VyZSBpZiB0aGF0IGlzIHRoZSB1
c2VkIHBhdGguCgpUaGFua3MgZm9yIHRoZSBjb21tZW50LCBJIHdpbGwgdGFrZSB0aGF0IGludG8g
YWNjb3VudCBhbmQgb25seSBibG9jayAKZm9yd2FyZGluZyB0byB0aGUgS0ZEIGlmIHRoZSBHTUMg
cmVhbGx5IGZpbHRlcmVkIHRoZSByZXF1ZXN0LgoKQ2hyaXN0aWFuLgoKPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0
Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
