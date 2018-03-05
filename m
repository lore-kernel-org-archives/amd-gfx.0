From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] dma-buf/reservation: should keep the new fence in
 add_shared_inplace
Date: Mon, 5 Mar 2018 19:20:55 +0800
Message-ID: <1520248855-662-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZjZhOTc5YmE5ZmQ2YzkyM2I4MjIxMmYzNWYwN2E5ZmYzMWM4Njc2NwpTaWdu
ZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2RtYS1i
dWYvcmVzZXJ2YXRpb24uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1Zi9yZXNlcnZhdGlvbi5j
IGIvZHJpdmVycy9kbWEtYnVmL3Jlc2VydmF0aW9uLmMKaW5kZXggMzc1ZGU0MS4uOWI4NzUyNjcg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZG1hLWJ1Zi9yZXNlcnZhdGlvbi5jCisrKyBiL2RyaXZlcnMv
ZG1hLWJ1Zi9yZXNlcnZhdGlvbi5jCkBAIC0xMTgsNyArMTE4LDcgQEAgcmVzZXJ2YXRpb25fb2Jq
ZWN0X2FkZF9zaGFyZWRfaW5wbGFjZShzdHJ1Y3QgcmVzZXJ2YXRpb25fb2JqZWN0ICpvYmosCiAJ
CW9sZF9mZW5jZSA9IHJjdV9kZXJlZmVyZW5jZV9wcm90ZWN0ZWQoZm9iai0+c2hhcmVkW2ldLAog
CQkJCQkJcmVzZXJ2YXRpb25fb2JqZWN0X2hlbGQob2JqKSk7CiAKLQkJaWYgKG9sZF9mZW5jZS0+
Y29udGV4dCA9PSBmZW5jZS0+Y29udGV4dCkgeworCQlpZiAoZG1hX2ZlbmNlX2lzX2xhdGVyKGZl
bmNlLCBvbGRfZmVuY2UpKSB7CiAJCQkvKiBtZW1vcnkgYmFycmllciBpcyBhZGRlZCBieSB3cml0
ZV9zZXFjb3VudF9iZWdpbiAqLwogCQkJUkNVX0lOSVRfUE9JTlRFUihmb2JqLT5zaGFyZWRbaV0s
IGZlbmNlKTsKIAkJCXdyaXRlX3NlcWNvdW50X2VuZCgmb2JqLT5zZXEpOwotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
