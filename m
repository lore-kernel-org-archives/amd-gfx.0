From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: replace iova debugfs file with iomem (v2)
Date: Mon, 12 Feb 2018 11:40:53 -0500
Message-ID: <f218e0b7-2150-0114-4164-5cb090491454@amd.com>
References: <20180209172750.15675-1-tom.stdenis@amd.com>
 <4708aad9-9ff0-d09f-9bb6-453c01c848a4@amd.com>
 <50edcafc-23dd-3c44-021f-cf5989d06dc2@gmail.com>
 <761fbdc6-bf8d-b8f4-350f-515418921b30@amd.com>
 <50cdbb8f-3b64-bed3-322c-bcce05b39370@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <50cdbb8f-3b64-bed3-322c-bcce05b39370-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDkvMDIvMTggMDE6NDQgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDkuMDIu
MjAxOCB1bSAxOToxOSBzY2hyaWViIFRvbSBTdCBEZW5pczoKPj4gT24gMDkvMDIvMTggMDE6MTcg
UE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAwOS4wMi4yMDE4IHVtIDE4OjI4IHNj
aHJpZWIgVG9tIFN0IERlbmlzOgo+Pj4+IE9uIDA5LzAyLzE4IDEyOjI3IFBNLCBUb20gU3QgRGVu
aXMgd3JvdGU6Cj4+Pj4+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPgo+Pj4+Cj4+Pj4gT29wcywgSSdsbCByZW1vdmUgdGhpcyBmcm9tIHRo
ZSBjb21taXQgbWVzc2FnZSBiZWZvcmUgcHVzaGluZyA6LSkKPj4+Pgo+Pj4+IEkgZGlkIGdpdmUg
eW91IGNyZWRpdCBiZWxvdyB0aG91Z2guCj4+Pgo+Pj4gVGhlIHBhdGNoIGJlZm9yZSB0aGlzIG9u
ZSBpc24ndCBtZXJnZWQgeWV0IGJlY2F1c2UgSSdtIHN0aWxsIG5vdCBzdXJlIAo+Pj4gaWYgdGhh
dCB3b3JrcyB1bmRlciBhbGwgY2lyY3Vtc3RhbmNlcyBvciBub3QuCj4+Pgo+Pj4gQ291bGQgeW91
IGdpdmUgaXQgc29tZSBleHRlbmRlZCB0ZXN0aW5nPyBFc3BlY2lhbGx5IGlmIGl0IHdvcmsgd2l0
aCAKPj4+IGV2aWN0aW9uLgo+Pgo+PiBJIHN1cHBvc2VkIHRoZXJlIGlzIGEgcmFjZSBvbiB0aGUg
a21hcCdlZCBtZW1vcnkgd2hpY2ggaXMgd2h5IEkgYWRkZWQgCj4+IGEgcHRyIGNoZWNrLsKgIE5v
dCBwZXJmZWN0IGJ1dCBzaW5jZSBpdCdzIGEgZGVidWdmcyBlbnRyeSBwcm9iYWJseSAKPj4gYmV0
dGVyIHRoYW4gaXQgbmVlZHMgdG8gYmUuCj4gCj4gSSB0aGluayB5b3UgY2FuIGRyb3AgdGhhdCwg
a21hcCBjYW4gb25seSByZXR1cm4gTlVMTCBvbiAzMmJpdCBzeXN0ZW1zIAo+IHdoZW4gd2UgcmFu
IG91dCBvZiB2bWFwIGFyZWEgYW5kIHRoZW4geW91IGNhbiBiYXNpY2FsbHkgY2FsbCBwYW5pYygp
IGFzIAo+IHdlbGwuCj4gCj4gVGhlIHF1ZXN0aW9uIGlzIGlmIHNldHRpbmcgcGFnZS0+bWFwcGlu
ZyBkdXJpbmcgYWxsb2NhdGlvbiBoYXMgc29tZSAKPiB1bmRlc2lyZWQgc2lkZSBlZmZlY3QuCgoK
SGF2ZW4ndCBub3RpY2VkIGFueXRoaW5nIHdpdGggcGlnbGl0IG9yIG90aGVyIEZPU1MgR0wgZ2Ft
ZXMuCgpJcyB0aGVyZSBhIHNwZWNpZmljIHRlc3QgeW91J2QgbGlrZSBtZSB0byBjb25zaWRlcj8K
ClRvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
