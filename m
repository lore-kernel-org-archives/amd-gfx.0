From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/powerplay: fix issue can't load another smu
 firmware.
Date: Fri, 23 Dec 2016 17:50:01 +0800
Message-ID: <1482486601-4681-2-git-send-email-Rex.Zhu@amd.com>
References: <1482486601-4681-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1482486601-4681-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

bmVlZCB0byByZWxlYXNlIGZhaWxlZCBzbXUgZmlybXdhcmUgYmVmb3JlIGxvYWQgYW5vdGhlcgpm
aXJtd2FyZS4KCkNoYW5nZS1JZDogSWZiOWUwZjYzYTUyNjFkZmZlZjI4ZWUxZTBjZTk4MmQ5YzVi
MDM0NGMKU2lnbmVkLW9mZi1ieTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgpSZXZpZXdlZC1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpSZXZpZXdlZC1ieTog
SHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9zbXVtZ3IvcG9sYXJpczEwX3NtdW1nci5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9zbXVtZ3IvcG9sYXJpczEwX3NtdW1nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvc211bWdyL3BvbGFyaXMxMF9zbXVtZ3IuYwppbmRleCBmMzhhNjg3Li40OWNkODg3IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvcG9sYXJpczEwX3Nt
dW1nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9wb2xhcmlz
MTBfc211bWdyLmMKQEAgLTMyOCw2ICszMjgsNyBAQCBzdGF0aWMgaW50IHBvbGFyaXMxMF9zdGFy
dF9zbXUoc3RydWN0IHBwX3NtdW1nciAqc211bWdyKQogCQkJLyogSWYgZmFpbGVkLCB0cnkgd2l0
aCBkaWZmZXJlbnQgc2VjdXJpdHkgS2V5LiAqLwogCQkJaWYgKHJlc3VsdCAhPSAwKSB7CiAJCQkJ
c211X2RhdGEtPnNtdTdfZGF0YS5zZWN1cml0eV9oYXJkX2tleSBePSAxOworCQkJCWNnc19yZWxf
ZmlybXdhcmUoc211bWdyLT5kZXZpY2UsIENHU19VQ09ERV9JRF9TTVUpOwogCQkJCXJlc3VsdCA9
IHBvbGFyaXMxMF9zdGFydF9zbXVfaW5fcHJvdGVjdGlvbl9tb2RlKHNtdW1ncik7CiAJCQl9CiAJ
CX0KLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
