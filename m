From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 17/31] drm/amd/display: Add missed wait_for_prev_commits.
Date: Tue, 23 May 2017 10:08:55 -0400
Message-ID: <20170523140909.9924-18-harry.wentland@amd.com>
References: <20170523140909.9924-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170523140909.9924-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQW5kcmV5IEdyb2R6b3Zza3kgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+CgpDaGFu
Z2UtSWQ6IEllNWYzMzQ5N2U4YWIyMmRhOGFlMzU0OTAyODAyM2UwZTU4Mzc4NjdmClNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPgpSZXZp
ZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fdHlwZXMuYyB8IDEg
KwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fdHlwZXMuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3R5cGVzLmMKaW5kZXggNmQ4
YTEyNzdkNTllLi5hYjZhOTY5NzQzYTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3R5cGVzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fdHlwZXMuYwpAQCAtMzI5Miw2ICszMjky
LDcgQEAgaW50IGFtZGdwdV9kbV9hdG9taWNfY2hlY2soc3RydWN0IGRybV9kZXZpY2UgKmRldiwK
IAkJCQkJCQlzdXJmYWNlKTsKIAogCQkJCW5lZWRfdG9fdmFsaWRhdGUgPSB0cnVlOworCQkJCXdh
aXRfZm9yX3ByZXZfY29tbWl0cyA9IHRydWU7CiAJCQl9CiAJCX0KIAl9Ci0tIAoyLjExLjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
