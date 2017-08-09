From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 065/120] drm/amd/display: add preferred mode from Video Format
 Preference Data Block
Date: Wed, 9 Aug 2017 11:01:51 -0400
Message-ID: <20170809150246.8835-66-harry.wentland@amd.com>
References: <20170809150246.8835-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170809150246.8835-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, Charlene Liu <charlene.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQW5kcmV5IEdyb2R6b3Zza3kgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+CgpDaGFu
Z2UtSWQ6IEkzN2QzMTNjYTBlMTdiMGQ0NDZhNjg1NzVjYWZhOTQxNjU4NDkwMjRlClNpZ25lZC1v
ZmYtYnk6IENoYXJsZW5lIExpdSA8Y2hhcmxlbmUubGl1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBW
aXRhbHkgUHJvc3lhayA8Vml0YWx5LlByb3N5YWtAYW1kLmNvbT4KQWNrZWQtYnk6IEhhcnJ5IFdl
bnRsYW5kIDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9jYWxjcy9kY25fY2FsY3MuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
YWxjcy9kY25fY2FsY3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9k
Y25fY2FsY3MuYwppbmRleCA4NzViOThkYWU2ZTEuLmJlNmUzY2E5ZmIwZCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxjcy5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY25fY2FsY3MuYwpAQCAtODU2LDgg
Kzg1Niw2IEBAIGJvb2wgZGNuX3ZhbGlkYXRlX2JhbmR3aWR0aCgKIAkJCQktIHBpcGUtPnN0cmVh
bS0+dGltaW5nLnZfZnJvbnRfcG9yY2g7CiAJCXYtPnZhY3RpdmVbaW5wdXRfaWR4XSA9IHBpcGUt
PnN0cmVhbS0+dGltaW5nLnZfYWRkcmVzc2FibGU7CiAJCXYtPnBpeGVsX2Nsb2NrW2lucHV0X2lk
eF0gPSBwaXBlLT5zdHJlYW0tPnRpbWluZy5waXhfY2xrX2toeiAvIDEwMDAuMGY7Ci0JCWlmIChw
aXBlLT5zdHJlYW0tPnRpbWluZy5waXhlbF9lbmNvZGluZyA9PSBQSVhFTF9FTkNPRElOR19ZQ0JD
UjQyMCkKLQkJCXYtPnBpeGVsX2Nsb2NrW2lucHV0X2lkeF0gLz0gMjsKIAogCiAJCWlmICghcGlw
ZS0+c3VyZmFjZSl7Ci0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
