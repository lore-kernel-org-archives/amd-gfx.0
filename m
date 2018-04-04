From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 15/19] Do not export the DriverRec AMDGPU
Date: Wed,  4 Apr 2018 15:29:50 +0100
Message-ID: <20180404142954.31360-16-emil.l.velikov@gmail.com>
References: <20180404142954.31360-1-emil.l.velikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180404142954.31360-1-emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

RnJvbTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KCkFuYWxvZ291
cyB0byBwcmV2aW91cyBjb21taXQgLSB1bnVzZWQgZXh0ZXJuYWxseSBhbmQgc2hvdWxkIG5vdCBi
ZQpleHBvcnRlZC4KClNpZ25lZC1vZmYtYnk6IEVtaWwgVmVsaWtvdiA8ZW1pbC52ZWxpa292QGNv
bGxhYm9yYS5jb20+Ci0tLQogc3JjL2FtZGdwdV9wcm9iZS5jIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2FtZGdw
dV9wcm9iZS5jIGIvc3JjL2FtZGdwdV9wcm9iZS5jCmluZGV4IDBhNDZjZjEuLjQ5NTliZDYgMTAw
NjQ0Ci0tLSBhL3NyYy9hbWRncHVfcHJvYmUuYworKysgYi9zcmMvYW1kZ3B1X3Byb2JlLmMKQEAg
LTMwNSw3ICszMDUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9pZF9tYXRjaCBhbWRncHVf
ZGV2aWNlX21hdGNoW10gPSB7CiAgICAgezAsIDAsIDB9LAogfTsKIAotX1hfRVhQT1JUIERyaXZl
clJlYyBBTURHUFUgPSB7CitEcml2ZXJSZWMgQU1ER1BVID0gewogCUFNREdQVV9WRVJTSU9OX0NV
UlJFTlQsCiAJQU1ER1BVX0RSSVZFUl9OQU1FLAogCUFNREdQVUlkZW50aWZ5LAotLSAKMi4xNi4w
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
