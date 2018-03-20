From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 14/34] drm/amd/display: Don't call amdgpu_dm_display_resume as
 it doesn't exist
Date: Tue, 20 Mar 2018 15:12:39 -0400
Message-ID: <20180320191259.14453-15-harry.wentland@amd.com>
References: <20180320191259.14453-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180320191259.14453-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgoKYW1kZ3B1X2RtX2Rp
c3BsYXlfcmVzdW1lIHdhcyBtZXJnZWQgaW50byBkbV9yZXN1bWUuCk5vIG5lZWQgdG8gY2FsbCB0
aGVzZSBmdW5jdGlvbnMgc2VwYXJhdGVseS4KClNpZ25lZC1vZmYtYnk6IE1pa2l0YSBMaXBza2kg
PG1pa2l0YS5saXBza2lAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxIYXJy
eS5XZW50bGFuZEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMK
aW5kZXggODk2NTQyNDE4MzMwLi5hOTdmMjc4YzQ1MjAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtMTYzMiw3ICsxNjMyLDYg
QEAgc3RhdGljIHNzaXplX3QgczNfZGVidWdfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2aWNlLAog
CWlmIChyZXQgPT0gMCkgewogCQlpZiAoczNfc3RhdGUpIHsKIAkJCWRtX3Jlc3VtZShhZGV2KTsK
LQkJCWFtZGdwdV9kbV9kaXNwbGF5X3Jlc3VtZShhZGV2KTsKIAkJCWRybV9rbXNfaGVscGVyX2hv
dHBsdWdfZXZlbnQoYWRldi0+ZGRldik7CiAJCX0gZWxzZQogCQkJZG1fc3VzcGVuZChhZGV2KTsK
LS0gCjIuMTQuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
