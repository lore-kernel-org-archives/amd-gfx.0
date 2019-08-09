From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 22/27] drm/amdgpu: enable power gating for renoir
Date: Fri,  9 Aug 2019 10:52:57 -0500
Message-ID: <20190809155302.4733-22-alexander.deucher@amd.com>
References: <20190809155302.4733-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190809155302.4733-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQWFyb24gTGl1IDxhYXJvbi5saXVAYW1kLmNvbT4KCmVuYWJsZSBnZnggcG93ZXIgZ2F0
aW5nIGZvciByZW5vaXIKClNpZ25lZC1vZmYtYnk6IEFhcm9uIExpdSA8YWFyb24ubGl1QGFtZC5j
b20+ClJldmlld2VkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgpSZXZpZXdlZC1i
eTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV8wLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCmluZGV4IDI0YjgyOTgyYzMyNC4uMmFh
ZTMzNzNlYWJlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKQEAgLTQ3OTUs
NiArNDc5NSw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKHZv
aWQgKmhhbmRsZSwKIAogCXN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7CiAJY2FzZSBDSElQX1JB
VkVOOgorCWNhc2UgQ0hJUF9SRU5PSVI6CiAJCWlmICghZW5hYmxlKSB7CiAJCQlhbWRncHVfZ2Z4
X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsKIAkJCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRl
di0+Z2Z4LmdmeF9vZmZfZGVsYXlfd29yayk7Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
