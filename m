From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/8] dma-buf: test shared slot allocation when mutex debugging
 is active
Date: Thu,  4 Oct 2018 15:12:45 +0200
Message-ID: <20181004131250.2373-3-christian.koenig@amd.com>
References: <20181004131250.2373-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181004131250.2373-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

U2V0IHNoYXJlZF9tYXggdG8gdGhlIG51bWJlciBvZiBzaGFyZWQgZmVuY2VzIHJpZ2h0IGJlZm9y
ZSB3ZSByZWxlYXNlCnRoZSBsb2NrLgoKVGhpcyB3YXkgZXZlcnkgYXR0ZW1wdCB0byBhZGQgYSBz
aGFyZWQgZmVuY2Ugd2l0aG91dCBwcmV2aW91c2x5CnJlc2VydmluZyBhIHNsb3Qgd2lsbCBjYXVz
ZSBhbiBlcnJvci4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L3Jlc2VydmF0aW9uLmggfCA1ICsrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9yZXNlcnZhdGlvbi5oIGIvaW5jbHVkZS9saW51eC9yZXNlcnZhdGlvbi5oCmluZGV4IDVk
ZGIwZTE0MzcyMS4uMmYwZmZjYTM1NzgwIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3Jlc2Vy
dmF0aW9uLmgKKysrIGIvaW5jbHVkZS9saW51eC9yZXNlcnZhdGlvbi5oCkBAIC0yMTQsNiArMjE0
LDExIEBAIHJlc2VydmF0aW9uX29iamVjdF90cnlsb2NrKHN0cnVjdCByZXNlcnZhdGlvbl9vYmpl
Y3QgKm9iaikKIHN0YXRpYyBpbmxpbmUgdm9pZAogcmVzZXJ2YXRpb25fb2JqZWN0X3VubG9jayhz
dHJ1Y3QgcmVzZXJ2YXRpb25fb2JqZWN0ICpvYmopCiB7CisjaWZkZWYgQ09ORklHX0RFQlVHX01V
VEVYRVMKKwkvKiBUZXN0IHNoYXJlZCBmZW5jZSBzbG90IHJlc2VydmF0aW9uICovCisJaWYgKG9i
ai0+ZmVuY2UpCisJCW9iai0+ZmVuY2UtPnNoYXJlZF9tYXggPSBvYmotPmZlbmNlLT5zaGFyZWRf
Y291bnQ7CisjZW5kaWYKIAl3d19tdXRleF91bmxvY2soJm9iai0+bG9jayk7CiB9CiAKLS0gCjIu
MTQuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
