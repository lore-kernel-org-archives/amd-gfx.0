From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: When to kmap PT BOs?
Date: Thu, 30 Aug 2018 08:50:54 +0200
Message-ID: <2e37a1ff-501e-f097-2d0f-9d1e2486593c@gmail.com>
References: <7a9aa339-e771-c667-4eb8-6f30c7c37c15@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7a9aa339-e771-c667-4eb8-6f30c7c37c15-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

SGkgRmVsaXgsCgphaCwgY3JhcCB5b3UgYXJlIHJpZ2h0LgoKSSBtb3ZlZCB0aGUga21hcCB0byBh
bWRncHVfdm1fdXBkYXRlX2RpcmVjdG9yaWVzKCkgYmVjYXVzZSBJIHRob3VnaHQgCnRoYXQgaXQg
d291bGQgYmUgY2xlYW5lciB0byBoYXZlIHRoYXQgY2xvc2VyIHdoZXJlIGl0IGlzIHVzZWQuCgpC
dXQgdGhhdCBzb3VuZHMgbGlrZSBpdCBkb2Vzbid0IHdvcmsgYXMgaW50ZW5kZWQuIEdvaW5nIHRv
IHJldmVydCB0aGF0IApwYXRjaC4KClRoYW5rcywKQ2hyaXN0aWFuLgoKQW0gMzAuMDguMjAxOCB1
bSAwMDozMCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IEhpLAo+Cj4gQ3VycmVudGx5IFBUIEJP
cyBhcmUga21hcHBlZCBpbiBhbWRncHVfdm1fdXBkYXRlX2RpcmVjdG9yaWVzLiBUaGF0Cj4gbWVh
bnMsIHRvIGF2b2lkIGtlcm5lbCBvb3BzZXMgYWZ0ZXIgcGFnZSB0YWJsZSBldmljdGlvbnMsIEkg
bmVlZCB0byBjYWxsCj4gYW1kZ3B1X3ZtX3VwZGF0ZV9kaXJlY3RvcmllcyBiZWZvcmUgY2FsbGlu
ZyBhbWRncHVfdm1fYm9fdXBkYXRlLgo+Cj4gQnV0IGFtZGdwdV92bV9ib191cGRhdGUgY2FuIGFs
c28gbW92ZSBQVHMgb24gdGhlIHZtLT5yZWxvY2F0ZWQgbGlzdAo+IGR1cmluZyBodWdlIHBhZ2Ug
aGFuZGxpbmcuIFRoYXQgbWVhbnMgSSBhbHNvIG5lZWQgdG8gY2FsbAo+IGFtZGdwdV92bV91cGRh
dGVfZGlyZWN0b3JpZXMgYWZ0ZXIgYW1kZ3B1X3ZtX2JvX3VwZGF0ZS4KPgo+IEkgdGhpbmsgYSBi
ZXR0ZXIgc29sdXRpb24gaXMgdG8gbW92ZSBrbWFwcGluZyBvdXQgb2YKPiBhbWRncHVfdm1fdXBk
YXRlX2RpcmVjdG9yaWVzLiBCdXQgSSdtIG5vdCBzdXJlIHdoYXQncyB0aGUgcmlnaHQgcGxhY2UK
PiBmb3IgaXQuIEFueSBzdWdnZXN0aW9ucz8gRm9yIGEgcXVpY2sgZml4IGZvciBrZXJuZWwgb29w
c2VzIGFmdGVyIHBhZ2UKPiB0YWJsZSBldmljdGlvbnMgaW4gdGhlIFJPQ20gMS45IHJlbGVhc2Ug
SSdsbCBjYWxsCj4gYW1kZ3B1X3ZtX3VwZGF0ZV9kaXJlY3RvcmllcyB0d2ljZS4gSWYgdGhlcmUg
YXJlIG5vIG5ldyBlbnRyaWVzIG9uIHRoZQo+IHZtLT5yZWxvY2F0ZWQgbGlzdHMsIHRoZSBzZWNv
bmQgY2FsbCB3b24ndCBhZGQgbXVjaCBvdmVyaGVhZCBhbnl3YXkuCj4KPiBUaGFua3MsCj4gIMKg
IEZlbGl4Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
