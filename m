From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 0/3] drm/amdgpu: update golden setting of VI
Date: Tue, 2 Aug 2016 13:23:31 +0800
Message-ID: <1470115414-23733-1-git-send-email-ray.huang@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

SGkgYWxsLAoKVGhpcyBwYXRjaCBzZXQgYXJlIGFsbCBjaGFuZ2VzIG9mIGdvbGRlbiBzZXR0aW5n
LCBtZ2NnX2NnY2cgc2V0dGluZywKdGlsaW5nIG1vZGUgYXJyYXkgYW5kIHJldiBpZCBvZiBWSSBz
ZXJpZXMgb2YgY2FyZHMuCgpDaGFuZ2VzIGZyb20gVjEgLT4gVjI6Ci0gUG9sYXJpczEwIGNoYW5n
ZXMgYXJlIGluIHRvbmdhIGFuZCBwb2xhcmlzMTEgcGF0Y2hlcy4gQW5kIGZpeCBpdC4KClRoYW5r
cywKUnVpCgpIdWFuZyBSdWkgKDMpOgogIGRybS9hbWRncHU6IHVwZGF0ZSBnb2xkZW4gc2V0dGlu
ZyBvZiB0b25nYQogIGRybS9hbWRncHU6IHVwZGF0ZSBnb2xkZW4gc2V0dGluZyBvZiBwb2xhcmlz
MTEKICBkcm0vYW1kZ3B1OiB1cGRhdGUgZ29sZGVuIHNldHRpbmcgb2YgcG9sYXJpczEwCgogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyB8IDEwICsrKysrKy0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
