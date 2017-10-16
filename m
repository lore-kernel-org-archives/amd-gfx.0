From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 14/20] drm/amd/display: Fix one more place for dc_stream_state
 leak
Date: Mon, 16 Oct 2017 16:31:48 -0400
Message-ID: <20171016203154.6401-15-harry.wentland@amd.com>
References: <20171016203154.6401-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171016203154.6401-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

T25lIG1vcmUgdGhpbmcgdGhhdCBoYXBwZW5lZCBkdWUgdG8gdW5ldmVuIGFwcGx5aW5nIG9mIHBh
dGNoZXMuIFRoaXMKbWlycm9ycyB3aGF0IERhcnJlbiBTYWx0IGZpeGVkLgoKU2lnbmVkLW9mZi1i
eTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IGFkYzc2ZWNiODRm
NS4uMDQ4YjNjNTJhYjI3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTQ1ODksNyArNDU4OSw3IEBAIHN0YXRpYyBpbnQgZG1f
dXBkYXRlX2NydGNzX3N0YXRlKHN0cnVjdCBkYyAqZGMsCiAJCQkgKiBUT0RPOiBuZWVkIHRvIGRp
ZyBvdXQgdGhlIHJvb3QgY2F1c2Ugb2YgdGhhdAogCQkJICovCiAJCQlpZiAoIWFjb25uZWN0b3Ig
fHwgKCFhY29ubmVjdG9yLT5kY19zaW5rICYmIGFjb25uZWN0b3ItPm1zdF9wb3J0KSkKLQkJCQlj
b250aW51ZTsKKwkJCQlnb3RvIG5leHRfY3J0YzsKIAogCQkJaWYgKG1vZGVyZXNldF9yZXF1aXJl
ZChjcnRjX3N0YXRlKSkKIAkJCQlnb3RvIG5leHRfY3J0YzsKLS0gCjIuMTQuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
