From: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v8 00/10] drm/i915: Implement proper fallback training for MST
Date: Wed, 11 Apr 2018 19:42:39 -0400
Message-ID: <20180411234302.2896-1-lyude@redhat.com>
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
To: intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Joonas Lahtinen <joonas.lahtinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Roman Li <roman.li-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "Jerry (Fangzhi) Zuo" <jerry.zuo-5C7GfCeVMHo@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rodrigo Vivi <rodrigo.vivi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

TmV4dCB2ZXJzaW9uIG9mIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMv
NDE1NzYvCgpPbmx5IGNoYW5nZXMgYXJlIHJlbW92aW5nIGR1cGxpY2F0ZSBTb0JzIHRoYXQgZ2l0
IHNlbmQtZW1haWwgYW5ub3lpbmdseQphZGRlZC4gU29ycnkgYWJvdXQgdGhhdCA6KAoKTHl1ZGUg
UGF1bCAoMTApOgogIGRybS9hdG9taWM6IFByaW50IGRlYnVnIG1lc3NhZ2Ugb24gYXRvbWljIGNo
ZWNrIGZhaWx1cmUKICBkcm0vaTkxNTogTW92ZSBEUCBtb2Rlc2V0IHJldHJ5IHdvcmsgaW50byBp
bnRlbF9kcAogIGRybS9kcF9tc3Q6IEZpeCBuYW1pbmcgb24gZHJtX2F0b21pY19nZXRfbXN0X3Rv
cG9sb2d5X3N0YXRlKCkKICBkcm0vZHBfbXN0OiBSZW1vdmUgYWxsIGV2aWwgZHVwbGljYXRlIHN0
YXRlIHBvaW50ZXJzCiAgZHJtL2RwX21zdDogTWFrZSBkcm1fZHBfbXN0X3RvcG9sb2d5X3N0YXRl
IHN1YmNsYXNzYWJsZQogIGRybS9kcF9tc3Q6IEFkZCByZXNldF9zdGF0ZSBjYWxsYmFjayB0byB0
b3BvbG9neSBtZ3IKICBkcm0vaTkxNTogT25seSB1c2Ugb25lIGxpbmsgYncgY29uZmlnIGZvciBN
U1QgdG9wb2xvZ2llcwogIGRybS9pOTE1OiBNYWtlIGludGVsX2RwX21zdF9hdG9taWNfY2hlY2so
KSBpZGVtcG90ZW50CiAgZHJtL2RwX21zdDogQWRkIE1TVCBmYWxsYmFjayByZXRyYWluaW5nIGhl
bHBlcnMKICBkcm0vaTkxNTogSW1wbGVtZW50IHByb3BlciBmYWxsYmFjayB0cmFpbmluZyBmb3Ig
TVNUCgogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyAg
fCAgMTQgKy0KIC4uLi9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5j
ICAgIHwgIDQ2ICstCiAuLi4vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlw
ZXMuaCAgICB8ICAgNCArLQogZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWMuYyAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDUgKy0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5
LmMgICAgICAgICAgICAgIHwgNTUwICsrKysrKysrKysrKysrKysrKysrLQogZHJpdmVycy9ncHUv
ZHJtL2k5MTUvaW50ZWxfZGRpLmMgICAgICAgICAgICAgICAgICAgfCAgMTAgKy0KIGRyaXZlcnMv
Z3B1L2RybS9pOTE1L2ludGVsX2Rpc3BsYXkuYyAgICAgICAgICAgICAgIHwgIDE0ICstCiBkcml2
ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9kcC5jICAgICAgICAgICAgICAgICAgICB8IDM3NiArKysr
KysrKysrLS0tLQogZHJpdmVycy9ncHUvZHJtL2k5MTUvaW50ZWxfZHBfbGlua190cmFpbmluZy5j
ICAgICAgfCAgIDYgKy0KIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RwX21zdC5jICAgICAg
ICAgICAgICAgIHwgMTg2ICsrKysrLS0KIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2Rydi5o
ICAgICAgICAgICAgICAgICAgIHwgIDIwICstCiBkcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9udjUw
X2Rpc3BsYXkuYyAgICAgICAgICAgICB8ICAxNyArLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fZHBfbXN0LmMgICAgICAgICAgICAgfCAgMTMgKy0KIGluY2x1ZGUvZHJtL2RybV9kcF9t
c3RfaGVscGVyLmggICAgICAgICAgICAgICAgICAgIHwgIDQzICstCiAxNCBmaWxlcyBjaGFuZ2Vk
LCAxMTIwIGluc2VydGlvbnMoKyksIDE4NCBkZWxldGlvbnMoLSkKCi0tIAoyLjE0LjMKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
