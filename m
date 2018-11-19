From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: Remove duplicate
 header
Date: Mon, 19 Nov 2018 14:19:17 -0500
Message-ID: <CADnq5_NY+B8=heDKwsYPnbp5c7McGkHqFo15zgzMjJyMAwiB5w@mail.gmail.com>
References: <20181119163219.GA26520@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181119163219.GA26520@hp-pavilion-15-notebook-pc-brajeswar>
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
To: brajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>, sabyasachi.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>, jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <shirish.s-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCBOb3YgMTksIDIwMTggYXQgMjoxNyBQTSBCcmFqZXN3YXIgR2hvc2gKPGJyYWplc3dh
ci5saW51eEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gUmVtb3ZlIGdjYS9nZnhfOF8wX2VudW0uaCB3
aGljaCBpcyBpbmNsdWRlZCBtb3JlIHRoYW4gb25jZQo+Cj4gU2lnbmVkLW9mZi1ieTogQnJhamVz
d2FyIEdob3NoIDxicmFqZXN3YXIubGludXhAZ21haWwuY29tPgoKQXBwbGllZC4gIHRoYW5rcyEK
CkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgfCAx
IC0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y4XzAuYwo+IGluZGV4IDNkMGYyNzdhNjUyMy4uNGNhMWVjZjFmZmQ3IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCj4gQEAgLTQ0LDcgKzQ0LDYgQEAK
PiAgI2luY2x1ZGUgImdjYS9nZnhfOF8wX2QuaCIKPiAgI2luY2x1ZGUgImdjYS9nZnhfOF8wX2Vu
dW0uaCIKPiAgI2luY2x1ZGUgImdjYS9nZnhfOF8wX3NoX21hc2suaCIKPiAtI2luY2x1ZGUgImdj
YS9nZnhfOF8wX2VudW0uaCIKPgo+ICAjaW5jbHVkZSAiZGNlL2RjZV8xMF8wX2QuaCIKPiAgI2lu
Y2x1ZGUgImRjZS9kY2VfMTBfMF9zaF9tYXNrLmgiCj4gLS0KPiAyLjE3LjEKPgo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5n
IGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
