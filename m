From: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: log smu version
Date: Mon, 12 Nov 2018 06:49:30 +0000
Message-ID: <1542005352-8672-1-git-send-email-shirish.s@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S,
 Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCBwcmludHMgdGhlIHZlcnNpb24gb2YgU01VIGZpcm13YXJlLgoKU2lnbmVkLW9m
Zi1ieTogU2hpcmlzaCBTIDxzaGlyaXNoLnNAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9zbXVtZ3Ivc211OF9zbXVtZ3IuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L3NtdW1nci9zbXU4X3NtdW1nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvc211bWdyL3NtdThfc211bWdyLmMKaW5kZXggMDliODQ0ZS4uMTQzOTgzNSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3NtdThfc211bWdyLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3NtdThfc211bWdyLmMKQEAg
LTczNyw2ICs3MzcsMTAgQEAgc3RhdGljIGludCBzbXU4X3N0YXJ0X3NtdShzdHJ1Y3QgcHBfaHdt
Z3IgKmh3bWdyKQogCiAJY2dzX3dyaXRlX3JlZ2lzdGVyKGh3bWdyLT5kZXZpY2UsIG1tTVAwUFVC
X0lORF9JTkRFWCwgaW5kZXgpOwogCWh3bWdyLT5zbXVfdmVyc2lvbiA9IGNnc19yZWFkX3JlZ2lz
dGVyKGh3bWdyLT5kZXZpY2UsIG1tTVAwUFVCX0lORF9EQVRBKTsKKwlwcl9pbmZvKCJzbXUgdmVy
c2lvbiAlMDJkLiUwMmQuJTAyZFxuIiwKKwkJKChod21nci0+c211X3ZlcnNpb24gPj4gMTYpICYg
MHhGRiksCisJCSgoaHdtZ3ItPnNtdV92ZXJzaW9uID4+IDgpICYgMHhGRiksCisJCShod21nci0+
c211X3ZlcnNpb24gJiAweEZGKSk7CiAJYWRldi0+cG0uZndfdmVyc2lvbiA9IGh3bWdyLT5zbXVf
dmVyc2lvbiA+PiA4OwogCiAJcmV0dXJuIHNtdThfcmVxdWVzdF9zbXVfbG9hZF9mdyhod21ncik7
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
