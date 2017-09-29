From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] amdgpu/dm: constify rgb formats.
Date: Thu, 28 Sep 2017 20:48:45 -0400
Message-ID: <6951a345-fc4c-0412-5d2a-07a65be7b50f@amd.com>
References: <20170929003224.7601-1-airlied@gmail.com>
 <20170929003224.7601-2-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170929003224.7601-2-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0wOS0yOCAwODozMiBQTSwgRGF2ZSBBaXJsaWUgd3JvdGU6Cj4gRnJvbTogRGF2ZSBB
aXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYXZlIEFpcmxp
ZSA8YWlybGllZEByZWRoYXQuY29tPgoKUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJy
eS53ZW50bGFuZEBhbWQuY29tPgoKSGFycnkKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IGluZGV4IGVmOTM4NTIuLjYxY2Nk
ZGQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMKPiBAQCAtMzA2Miw3ICszMDYyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBk
cm1fcGxhbmVfaGVscGVyX2Z1bmNzIGRtX3BsYW5lX2hlbHBlcl9mdW5jcyA9IHsKPiAgICogcGxh
bmUgY2FwYWJpbGl0aWVzLCBvciBpbml0aWFsaXplIHRoaXMgYXJyYXkgdG8gYWxsIGZvcm1hdHMs
IHNvIGludGVybmFsIGRybQo+ICAgKiBjaGVjayB3aWxsIHN1Y2NlZWQsIGFuZCBsZXQgREMgdG8g
aW1wbGVtZW50IHByb3BlciBjaGVjawo+ICAgKi8KPiAtc3RhdGljIHVpbnQzMl90IHJnYl9mb3Jt
YXRzW10gPSB7Cj4gK3N0YXRpYyBjb25zdCB1aW50MzJfdCByZ2JfZm9ybWF0c1tdID0gewo+ICAJ
RFJNX0ZPUk1BVF9SR0I4ODgsCj4gIAlEUk1fRk9STUFUX1hSR0I4ODg4LAo+ICAJRFJNX0ZPUk1B
VF9BUkdCODg4OCwKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
