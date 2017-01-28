From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH libdrm 0/3] some -pro patches for integration
Date: Sat, 28 Jan 2017 21:49:29 +0200
Message-ID: <1485632972-4790-1-git-send-email-notasas@gmail.com>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

SSd2ZSB0YWtlbiBzZXZlcmFsIHBhdGNoZXMgZnJvbSBhbWRncHUtcHJvIGxpYmRybSB0aGF0IGxv
b2sgdXNlZnVsCnRvIG1lIGFuZCBJIHRoaW5rIGNhbiBiZSBhcHBsaWVkIGFscmVhZHkuIFRoZSBv
bmx5IHRoaW5ncyBJIGRpZCB3YXMKcmViYXNpbmcsIGZpeGluZyBzb21lIHR5cG9zIGFuZCBkcm9w
cGluZyBDaGFuZ2UtSWQuCgpBbGV4IFhpZSAoMyk6CiAgYW1kZ3B1OiBGcmVlL3VuaW5pdCB2YW1n
cl8zMiBpbiB0aGVvcmV0aWNhbGx5IGNvcnJlY3Qgb3JkZXIKICBhbWRncHU6IHZhbWdyIGNhbiBi
ZSBhIHN0cnVjdCBpbnN0ZWFkIG9mIGEgcG9pbnRlcgogIGFtZGdwdTogdmFtZ3JfMzIgY2FuIGJl
IGEgc3RydWN0IGluc3RlYWQgb2YgYSBwb2ludGVyCgogYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyAg
IHwgMjQgKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCiBhbWRncHUvYW1kZ3B1X2ludGVybmFsLmgg
fCAgNCArKy0tCiBhbWRncHUvYW1kZ3B1X3ZhbWdyLmMgICAgfCAgNiArKystLS0KIDMgZmlsZXMg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pCgotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
