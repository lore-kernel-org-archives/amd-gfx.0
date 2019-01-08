From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] drm/amdgpu: Fix suspend/resume issues with MST
Date: Tue, 8 Jan 2019 16:17:31 -0500
Message-ID: <CADnq5_N=wu0C+ZknUqXhodOye3i-ySGVVn9Mrb4_6W1jRPp_EA@mail.gmail.com>
References: <20190108211133.32564-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190108211133.32564-1-lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "David (ChunMing) Zhou" <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, David Francis <david.francis-5C7GfCeVMHo@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>, Bhawanpreet Lakha <bhawanpreet.lakha-5C7GfCeVMHo@public.gmane.org>, Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Jerry Zuo <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>, Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>, Anthony Koo <anthony.koo-5C7GfCeVMHo@public.gmane.org>

T24gVHVlLCBKYW4gOCwgMjAxOSBhdCA0OjExIFBNIEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gRml4IHRoZSBzdXNwZW5kL2lzc3VlcyB0aGF0IEplcnJ5IFp1byBmb3Vu
ZCBpbiBhbWRncHUsIGFuZCBhZGQgc29tZQo+IGNvbXBpbGVyIHdhcm5pbmdzIGZvciBkcml2ZXJz
IGlnbm9yaW5nIHRoZSByZXR1cm4gY29kZSBvZgo+IGRybV9kcF9tc3RfdG9wb2xvZ3lfbWdyX3Jl
c3VtZSgpIHRvIGhlbHAgZW5zdXJlIHdlIGRvbid0IG5lZWQgdG8gZml4Cj4gdGhpcyBhZ2FpbiBp
biB0aGUgZnV0dXJlIGZvciBzb21lb25lIGVsc2UncyBkcml2ZXIuCj4KPiBDYzogSmVycnkgWnVv
IDxKZXJyeS5adW9AYW1kLmNvbT4KPgo+IEx5dWRlIFBhdWwgKDMpOgo+ICAgZHJtL2FtZGdwdTog
RG9uJ3QgaWdub3JlIHJjIGZyb20gZHJtX2RwX21zdF90b3BvbG9neV9tZ3JfcmVzdW1lKCkKPiAg
IGRybS9hbWRncHU6IERvbid0IGZhaWwgcmVzdW1lIHByb2Nlc3MgaWYgcmVzdW1pbmcgYXRvbWlj
IHN0YXRlIGZhaWxzCj4gICBkcm0vZHBfbXN0OiBBZGQgX19tdXN0X2NoZWNrIHRvIGRybV9kcF9t
c3RfdG9wb2xvZ3lfbWdyX3Jlc3VtZSgpCgpJIGNhbiB0YWtlIHRoZXNlIHRocm91Z2ggdGhlIGFt
ZGdwdSB0cmVlIG9yIHlvdSBjYW4gY29tbWl0IHRoZW0gdG8KZHJtLW1pc2MgKGFzc3VtaW5nIHlv
dSBoYXZlIGNvbW1pdCByaWdodHMpLiAgRWl0aGVyIHdheSB3b3JrcyBmb3IgbWUuCgpUaGFua3Ms
CgpBbGV4Cgo+Cj4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0u
YyB8IDM3ICsrKysrKysrKysrKystLS0tLS0KPiAgaW5jbHVkZS9kcm0vZHJtX2RwX21zdF9oZWxw
ZXIuaCAgICAgICAgICAgICAgIHwgIDMgKy0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRp
b25zKCspLCAxMyBkZWxldGlvbnMoLSkKPgo+IC0tCj4gMi4yMC4xCj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0
Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
