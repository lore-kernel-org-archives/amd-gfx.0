From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/2] *** add scheduling policy ***
Date: Thu, 16 Mar 2017 17:00:47 +0800
Message-ID: <1489654849-6031-1-git-send-email-David1.Zhou@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

QW5kcmVzIGFkZGVkIGhpZ2ggcHJpb3JpdHkgcXVldWUgZm9yIHVzZXJzcGFjZSwgd2hpY2ggZ290
IG1lIHRvIHRoaW5rIG1vcmUgYWJvdXQKc2NoZWR1bGluZyBwb2xpY3ksIGlmIGhpZ2ggcHJpb3Jp
dHkgcXVldWUgaXMgYWx3YXlzIGZ1bGwgYW5kIGJ1c3ksIGxvdyBwcmlvcml0eSBxdWV1ZSBjb3Vs
ZCBzdGFydmUuCgoKQ2h1bm1pbmcgWmhvdSAoMik6CiAgZHJtL2FtZC9zY2hlZDogcmV2aXNlIHBy
aW9yaXR5IG51bWJlcgogIGRybS9hbWQvc2NoZWQ6IGFkZCBzY2h1ZHVsaW5nIHBvbGljeQoKIGRy
aXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYyB8IDMwICsrKysrKysr
KysrKysrKysrKysrKystLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3Nj
aGVkdWxlci5oIHwgMTEgKysrKysrLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25z
KCspLCA5IGRlbGV0aW9ucygtKQoKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
