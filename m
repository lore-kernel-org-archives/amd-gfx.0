From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] amdgpu/dc: don't memset after kzalloc.
Date: Tue, 3 Oct 2017 09:50:27 -0400
Message-ID: <57f26c67-8418-11f7-98ac-17dab2d9ed79@amd.com>
References: <20171003023733.4996-1-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171003023733.4996-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

T24gMjAxNy0xMC0wMiAxMDozNyBQTSwgRGF2ZSBBaXJsaWUgd3JvdGU6Cj4gRnJvbTogRGF2ZSBB
aXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KPiAKPiBXZSBhbGxvY2F0ZSB0aGlzIHN0cnVjdCB6
ZXJvZWQsIHNvIGRvbid0IG5lZWQgdG8gbWVtc2V0IGluIHRoZQo+IGNvbnN0cnVjdG9yLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IERhdmUgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5jb20+CgpSZXZpZXdl
ZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CgpIYXJyeQoKPiAt
LS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfc3VyZmFjZS5jIHwg
MiAtLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfc3VyZmFjZS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfc3VyZmFjZS5jCj4gaW5kZXggZjE3MGFl
OS4uZmYwNzEwNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kY19zdXJmYWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kY19zdXJmYWNlLmMKPiBAQCAtMzcsOCArMzcsNiBAQAo+ICBzdGF0aWMgdm9pZCBjb25z
dHJ1Y3Qoc3RydWN0IGRjX2NvbnRleHQgKmN0eCwgc3RydWN0IGRjX3BsYW5lX3N0YXRlICpwbGFu
ZV9zdGF0ZSkKPiAgewo+ICAJcGxhbmVfc3RhdGUtPmN0eCA9IGN0eDsKPiAtCW1lbXNldCgmcGxh
bmVfc3RhdGUtPmhkcl9zdGF0aWNfY3R4LAo+IC0JCQkwLCBzaXplb2Yoc3RydWN0IGRjX2hkcl9z
dGF0aWNfbWV0YWRhdGEpKTsKPiAgfQo+ICAKPiAgc3RhdGljIHZvaWQgZGVzdHJ1Y3Qoc3RydWN0
IGRjX3BsYW5lX3N0YXRlICpwbGFuZV9zdGF0ZSkKPiAKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
