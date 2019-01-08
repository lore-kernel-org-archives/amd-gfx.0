From: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/3] drm/amdgpu: Fix suspend/resume issues with MST
Date: Tue,  8 Jan 2019 16:11:26 -0500
Message-ID: <20190108211133.32564-1-lyude@redhat.com>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, "David (ChunMing) Zhou" <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Bhawanpreet Lakha <bhawanpreet.lakha-5C7GfCeVMHo@public.gmane.org>, David Francis <david.francis-5C7GfCeVMHo@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Jerry Zuo <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>, Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>, Anthony Koo <anthony.koo-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

Rml4IHRoZSBzdXNwZW5kL2lzc3VlcyB0aGF0IEplcnJ5IFp1byBmb3VuZCBpbiBhbWRncHUsIGFu
ZCBhZGQgc29tZQpjb21waWxlciB3YXJuaW5ncyBmb3IgZHJpdmVycyBpZ25vcmluZyB0aGUgcmV0
dXJuIGNvZGUgb2YKZHJtX2RwX21zdF90b3BvbG9neV9tZ3JfcmVzdW1lKCkgdG8gaGVscCBlbnN1
cmUgd2UgZG9uJ3QgbmVlZCB0byBmaXgKdGhpcyBhZ2FpbiBpbiB0aGUgZnV0dXJlIGZvciBzb21l
b25lIGVsc2UncyBkcml2ZXIuCgpDYzogSmVycnkgWnVvIDxKZXJyeS5adW9AYW1kLmNvbT4KCkx5
dWRlIFBhdWwgKDMpOgogIGRybS9hbWRncHU6IERvbid0IGlnbm9yZSByYyBmcm9tIGRybV9kcF9t
c3RfdG9wb2xvZ3lfbWdyX3Jlc3VtZSgpCiAgZHJtL2FtZGdwdTogRG9uJ3QgZmFpbCByZXN1bWUg
cHJvY2VzcyBpZiByZXN1bWluZyBhdG9taWMgc3RhdGUgZmFpbHMKICBkcm0vZHBfbXN0OiBBZGQg
X19tdXN0X2NoZWNrIHRvIGRybV9kcF9tc3RfdG9wb2xvZ3lfbWdyX3Jlc3VtZSgpCgogLi4uL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMzcgKysrKysrKysrKysr
Ky0tLS0tLQogaW5jbHVkZS9kcm0vZHJtX2RwX21zdF9oZWxwZXIuaCAgICAgICAgICAgICAgIHwg
IDMgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0p
CgotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
