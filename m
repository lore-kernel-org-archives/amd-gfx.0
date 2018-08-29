From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 7/7] drm/amdgpu: try to make kernel allocations USWC
Date: Wed, 29 Aug 2018 16:08:09 +0200
Message-ID: <20180829140809.1812-7-christian.koenig@amd.com>
References: <20180829140809.1812-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180829140809.1812-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

Tm90IDEwMCUgc3VyZSBpZiB0aGF0IGlzIGEgZ29vZCBpZGVhIG9yIG5vdC4gSW4gdGhlb3J5IG9u
bHkgdGhlIHdyaXRlYmFjayBCTwpzaG91bGQgYmUgcmVhZCBtb3N0IG9mIHRoZSB0aW1lLCBidXQg
d2hvIGtub3dzPwoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVj
dC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCmluZGV4IGRl
OTkwYmRjZGQ2Yy4uNzk0Yzg3NDMwOWQwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X29iamVjdC5jCkBAIC0yNTUsNyArMjU1LDggQEAgaW50IGFtZGdwdV9ib19jcmVhdGVf
cmVzZXJ2ZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJYnAuYnl0ZV9hbGlnbiA9IGFs
aWduOwogCWJwLmRvbWFpbiA9IGRvbWFpbjsKIAlicC5mbGFncyA9IEFNREdQVV9HRU1fQ1JFQVRF
X0NQVV9BQ0NFU1NfUkVRVUlSRUQgfAotCQlBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VP
VVM7CisJCUFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fQ09OVElHVU9VUyB8CisJCUFNREdQVV9HRU1f
Q1JFQVRFX0NQVV9HVFRfVVNXQzsKIAlicC50eXBlID0gdHRtX2JvX3R5cGVfa2VybmVsOwogCWJw
LnJlc3YgPSBOVUxMOwogCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
