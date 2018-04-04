From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 08/19] Simplify fd_ref handling in
 amdgpu_probe()
Date: Wed,  4 Apr 2018 15:29:43 +0100
Message-ID: <20180404142954.31360-9-emil.l.velikov@gmail.com>
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

RnJvbTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KClNpZ25lZC1v
ZmYtYnk6IEVtaWwgVmVsaWtvdiA8ZW1pbC52ZWxpa292QGNvbGxhYm9yYS5jb20+Ci0tLQogc3Jj
L2FtZGdwdV9wcm9iZS5jIHwgOSArKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2FtZGdwdV9wcm9iZS5jIGIv
c3JjL2FtZGdwdV9wcm9iZS5jCmluZGV4IGQxYWQxM2YuLjhhMTYwNjAgMTAwNjQ0Ci0tLSBhL3Ny
Yy9hbWRncHVfcHJvYmUuYworKysgYi9zcmMvYW1kZ3B1X3Byb2JlLmMKQEAgLTIzNywxNCArMjM3
LDkgQEAgYW1kZ3B1X3Byb2JlKFNjcm5JbmZvUHRyIHBTY3JuLCBpbnQgZW50aXR5X251bSwKIAog
CQlpZiAoIWFtZGdwdV9kZXZpY2Vfc2V0dXAocFNjcm4sIHBjaV9kZXYsIGRldiwgcFByaXYtPnB0
cikpCiAJCQlnb3RvIGVycm9yOwotCi0JCXBBTURHUFVFbnQgPSBwUHJpdi0+cHRyOwotCQlwQU1E
R1BVRW50LT5mZF9yZWYgPSAxOwotCi0JfSBlbHNlIHsKLQkJcEFNREdQVUVudCA9IHBQcml2LT5w
dHI7Ci0JCXBBTURHUFVFbnQtPmZkX3JlZisrOwogCX0KKwlwQU1ER1BVRW50ID0gcFByaXYtPnB0
cjsKKwlwQU1ER1BVRW50LT5mZF9yZWYrKzsKIAogCXhmODZTZXRFbnRpdHlJbnN0YW5jZUZvclNj
cmVlbihwU2NybiwgcEVudC0+aW5kZXgsCiAJCQkJICAgICAgIHhmODZHZXROdW1FbnRpdHlJbnN0
YW5jZXMocEVudC0+Ci0tIAoyLjE2LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
