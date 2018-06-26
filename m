From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Drop unnecessary header file
Date: Tue, 26 Jun 2018 10:43:26 -0400
Message-ID: <af9504db-3769-fe30-708a-5bb8932799ed@amd.com>
References: <1529992395-8694-1-git-send-email-rezhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1529992395-8694-1-git-send-email-rezhu-5C7GfCeVMHo@public.gmane.org>
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
To: rex zhu <rezhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0wNi0yNiAwMTo1MyBBTSwgcmV4IHpodSB3cm90ZToKPiBwb3dlcnBsYXkgaW1wbGVt
ZW50IGh3bWdyX2Z1bmN0aW9uIHRhYmxlIGZvciBhbGwgc3VwcG9ydGVkIGFzaWNzIGluCj4gb3Jk
ZXIgdG8gY29uY2VhbCB0aGUgYXNpYydzIGRldGFpbCBpbmZvbWF0aW9uLiBzbyBubyBuZWVkIHRv
IGluY2x1ZGUKPiB0aGUgc211MTBfaHdtZ3IuaAo+IAo+IFNpZ25lZC1vZmYtYnk6IFJleCBaaHUg
PFJleC5aaHVAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG1fcHBfc211LmMgfCAxIC0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVs
ZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG1fcHBfc211LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUuYwo+IGluZGV4IGFkOTZlMmEuLjJhY2JjYzcgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG1fcHBfc211LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbV9wcF9zbXUuYwo+IEBAIC0zNCw3ICszNCw2IEBACj4gICNpbmNsdWRlICJhbWRn
cHVfcG0uaCIKPiAgI2luY2x1ZGUgImRtX3BwX3NtdS5oIgo+ICAjaW5jbHVkZSAiLi4vLi4vcG93
ZXJwbGF5L2luYy9od21nci5oIgo+IC0jaW5jbHVkZSAiLi4vLi4vcG93ZXJwbGF5L2h3bWdyL3Nt
dTEwX2h3bWdyLmgiCgpXZSBkb24ndCBldmVuIG5lZWQgdGhlIHJlbGF0aXZlIHJlZmVyZW5jZSBz
aW5jZSBwb3dlcnBsYXkvTWFrZWZpbGUgYWRkcyB0aGUgcmlnaHQgaW5jbHVkZSBmb2xkZXIuIEkg
Y2FuIHNlbmQgYSBzZXBhcmF0ZSBwYXRjaCBmb3IgdGhhdCwgdGhvdWdoLgoKUmV2aWV3ZWQtYnk6
IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgoKSGFycnkKCj4gIAo+ICAK
PiAgYm9vbCBkbV9wcF9hcHBseV9kaXNwbGF5X3JlcXVpcmVtZW50cygKPiAKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
