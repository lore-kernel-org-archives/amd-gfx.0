From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use ttm pool first
Date: Wed, 24 Jan 2018 18:59:09 +0800
Message-ID: <ba67c47b-fa18-4c92-cbec-6dc6855dd1b5@amd.com>
References: <20180124091707.32059-1-david1.zhou@amd.com>
 <36db7c3c-aa12-d11f-ef5d-63fc40c395ba@amd.com>
 <e93a1953-cfc2-f4f4-7ae5-4bc28cfb44e5@amd.com>
 <35b80a48-17bc-d608-ab69-6ac8608b7730@amd.com>
 <77f05a88-6201-b075-ef29-3c5907dc3f8f@amd.com>
 <291e091d-529b-1ec8-55fc-c53b627c8423@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <291e091d-529b-1ec8-55fc-c53b627c8423-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org

CgpPbiAyMDE45bm0MDHmnIgyNOaXpSAxODo1MiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBB
bSAyNC4wMS4yMDE4IHVtIDExOjMyIHNjaHJpZWIgQ2h1bm1pbmcgWmhvdToKPj4gT24gMjAxOOW5
tDAx5pyIMjTml6UgMTc6NDksIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBbU05JUF0KPj4+
IE5vcGUsIGFzIEkgd3JvdGUgdGhhdCB3b24ndCB3b3JrLiBZb3UgbXVzdCBpbXByb3ZlIHRoZSBk
ZXRlY3Rpb24gaWYgCj4+PiB3ZSBuZWVkIGNvaGVyZW50IG9yIG5vdCBjb2hlcmVudCBhbGxvY2F0
aW9uLgo+PiBCdXQgaG93IHRvIGRpZmZlcmVudGlhdGUgY29oZXJlbnQgb3Igbm90IGNvaGVyZW50
IGFsbG9jYXRpb24/IGNoZWNrIAo+PiBpZiBtYXggaW8gYWRkcmVzcyBvZiBzeXN0ZW0gbWVtb3J5
IHVuZGVyIDQwYml0cyBwY2llIGFkZHJlc3Mgc3BhY2U/IAo+PiBEbyB5b3Uga25vdyBob3cgdG8g
Z2V0IHRoZSBtYXggaW8gYWRkcmVzcyBvZiBzeXN0ZW0gbWVtb3J5Pwo+Cj4gV2VsbCB0aGF0IGlz
IGEgZ29vZCBxdWVzdGlvbiwgd2hpY2ggbm9ib2R5IGhhZCBhbiBhbnN3ZXIgZm9yIHNvIGZhciAK
PiAoYW5kIGEgY291cGxlIG9mIHBlb3BsZSBhbHJlYWR5IGxvb2tlZCBpbnRvIGl0KS4KPgo+IFdl
IGNvdWxkIHN0YXJ0IGJ5IGNoZWNraW5nIGlmIG1heF9wZm4gaXMgPD0gdGhlIDQwYml0cyBsaW1p
dCBvciBpZiAKPiBJT01NVSBpcyBlbmFibGVkIGluc3RlYWQgb2YgU1dJT1RMQi4KSG93IHRvIGdl
dCBtYXhfcGZuPwoKYnR3LCBzZWVtcyBvbmx5IGFtZGdwdSBhbmQgcmFkZW9uIGRyaXZlciB1c2Ug
ZG1hIHBhdGguCgpSZWdhcmRzLApEYXZpZCBaaG91Cj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
