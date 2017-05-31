From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: Remove two ! operations in an if condition
Date: Wed, 31 May 2017 10:59:24 +0800
Message-ID: <592E318C.3010807@amd.com>
References: <1496180868-2617-1-git-send-email-AlexBin.Xie@amd.com>
 <1496180868-2617-2-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496180868-2617-2-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE35bm0MDXmnIgzMeaXpSAwNTo0NywgQWxleCBYaWUgd3JvdGU6Cj4gICBNYWtlIHRo
ZSBjb2RlIGVhc2llciB0byB1bmRlcnN0YW5kLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBYaWUg
PEFsZXhCaW4uWGllQGFtZC5jb20+Cm9rIHRvIG1lLCBSZXZpZXdlZC1ieTogQ2h1bm1pbmcgWmhv
dSA8ZGF2aWQxLnpob3VAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIHwgNiArKysrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwo+IGluZGV4IDdhMzIzZjkuLjlmZGViODIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwo+IEBAIC02ODAsOSArNjgwLDExIEBAIGJvb2wgYW1kZ3B1X3ZtX25l
ZWRfcGlwZWxpbmVfc3luYyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCj4gICAKPiAgIAlpZiAo
YW1kZ3B1X3ZtX2hhZF9ncHVfcmVzZXQoYWRldiwgaWQpKQo+ICAgCQlyZXR1cm4gdHJ1ZTsKPiAt
CWlmICghdm1fZmx1c2hfbmVlZGVkICYmICFnZHNfc3dpdGNoX25lZWRlZCkKPiArCj4gKwlpZiAo
dm1fZmx1c2hfbmVlZGVkIHx8IGdkc19zd2l0Y2hfbmVlZGVkKQo+ICsJCXJldHVybiB0cnVlOwo+
ICsJZWxzZQo+ICAgCQlyZXR1cm4gZmFsc2U7Cj4gLQlyZXR1cm4gdHJ1ZTsKPiAgIH0KPiAgIAo+
ICAgLyoqCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
