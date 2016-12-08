From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 06/12] drm/amd/display: Fix warning in freesync module
Date: Wed, 7 Dec 2016 20:26:18 -0500
Message-ID: <20161208012624.8914-7-harry.wentland@amd.com>
References: <20161208012624.8914-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161208012624.8914-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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

Q2hhbmdlLUlkOiBJMjI1ODY2YmYyNjBiMGZkNWNmNGFhYmNhZGIzMzgxZDNiM2VkNmU5MwpTaWdu
ZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KUmV2aWV3
ZWQtYnk6IFRvbnkgQ2hlbmcgPFRvbnkuQ2hlbmdAYW1kLmNvbT4KQWNrZWQtYnk6IEhhcnJ5IFdl
bnRsYW5kIDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9tb2R1bGVzL2ZyZWVzeW5jL2ZyZWVzeW5jLmMgfCAzICsrKwogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9tb2R1bGVzL2ZyZWVzeW5jL2ZyZWVzeW5jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvbW9kdWxlcy9mcmVlc3luYy9mcmVlc3luYy5jCmluZGV4IGViOTEyYmFhMDE2OS4uODg5
MmU4YmVjN2MzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxl
cy9mcmVlc3luYy9mcmVlc3luYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9t
b2R1bGVzL2ZyZWVzeW5jL2ZyZWVzeW5jLmMKQEAgLTc0Niw2ICs3NDYsOSBAQCB2b2lkIG1vZF9m
cmVlc3luY191cGRhdGVfc3RhdGUoc3RydWN0IG1vZF9mcmVlc3luYyAqbW9kX2ZyZWVzeW5jLAog
CQkJCWZyZWVzeW5jX3Byb2dyYW1fcmVxdWlyZWQgPSB0cnVlOwogCQkJfQogCQkJYnJlYWs7CisJ
CWNhc2UgRlJFRVNZTkNfU1RBVEVfTk9ORToKKwkJCS8qIGhhbmRsZSBoZXJlIHRvIGF2b2lkIHdh
cm5pbmcgKi8KKwkJCWJyZWFrOwogCQl9CiAJfQogCi0tIAoyLjkuMwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
