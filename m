From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] dma-buf/reservation: should keep the new fence in
 add_shared_inplace
Date: Tue, 6 Mar 2018 11:15:50 +0800
Message-ID: <1520306150-29325-4-git-send-email-Monk.Liu@amd.com>
References: <1520306150-29325-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1520306150-29325-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
IGIvZHJpdmVycy9kbWEtYnVmL3Jlc2VydmF0aW9uLmMKaW5kZXggMzE0ZWIxMC4uMjliN2U0NSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9kbWEtYnVmL3Jlc2VydmF0aW9uLmMKKysrIGIvZHJpdmVycy9k
bWEtYnVmL3Jlc2VydmF0aW9uLmMKQEAgLTExOCw3ICsxMTgsNyBAQCByZXNlcnZhdGlvbl9vYmpl
Y3RfYWRkX3NoYXJlZF9pbnBsYWNlKHN0cnVjdCByZXNlcnZhdGlvbl9vYmplY3QgKm9iaiwKIAkJ
b2xkX2ZlbmNlID0gcmN1X2RlcmVmZXJlbmNlX3Byb3RlY3RlZChmb2JqLT5zaGFyZWRbaV0sCiAJ
CQkJCQlyZXNlcnZhdGlvbl9vYmplY3RfaGVsZChvYmopKTsKIAotCQlpZiAob2xkX2ZlbmNlLT5j
b250ZXh0ID09IGZlbmNlLT5jb250ZXh0KSB7CisJCWlmIChkbWFfZmVuY2VfaXNfbGF0ZXIoZmVu
Y2UsIG9sZF9mZW5jZSkpIHsKIAkJCS8qIG1lbW9yeSBiYXJyaWVyIGlzIGFkZGVkIGJ5IHdyaXRl
X3NlcWNvdW50X2JlZ2luICovCiAJCQlSQ1VfSU5JVF9QT0lOVEVSKGZvYmotPnNoYXJlZFtpXSwg
ZmVuY2UpOwogCQkJd3JpdGVfc2VxY291bnRfZW5kKCZvYmotPnNlcSk7Ci0tIAoyLjcuNAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
