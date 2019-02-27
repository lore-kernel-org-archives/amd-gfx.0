From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] drm: prefix header search paths with
 $(srctree)/
Date: Wed, 27 Feb 2019 21:05:24 +0100
Message-ID: <20190227200524.GA26912@ravnborg.org>
References: <1548906999-22143-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1548906999-22143-1-git-send-email-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Rodrigo Vivi <rodrigo.vivi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, intel-gvt-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Zhi Wang <zhi.a.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: amd-gfx.lists.freedesktop.org

SGkgTWFzYWhpcm8uCgpPbiBUaHUsIEphbiAzMSwgMjAxOSBhdCAxMjo1NjozOVBNICswOTAwLCBN
YXNhaGlybyBZYW1hZGEgd3JvdGU6Cj4gQ3VycmVudGx5LCB0aGUgS2J1aWxkIGNvcmUgbWFuaXB1
bGF0ZXMgaGVhZGVyIHNlYXJjaCBwYXRocyBpbiBhIGNyYXp5Cj4gd2F5IFsxXS4KPiAKPiBUbyBm
aXggdGhpcyBtZXNzLCBJIHdhbnQgYWxsIE1ha2VmaWxlcyB0byBhZGQgZXhwbGljaXQgJChzcmN0
cmVlKS8gdG8KPiB0aGUgc2VhcmNoIHBhdGhzIGluIHRoZSBzcmN0cmVlLiBTb21lIE1ha2VmaWxl
cyBhcmUgYWxyZWFkeSB3cml0dGVuIGluCj4gdGhhdCB3YXksIGJ1dCBub3QgYWxsLiBUaGUgZ29h
bCBvZiB0aGlzIHdvcmsgaXMgdG8gbWFrZSB0aGUgbm90YXRpb24KPiBjb25zaXN0ZW50LCBhbmQg
ZmluYWxseSBnZXQgcmlkIG9mIHRoZSBncm9zcyBoYWNrcy4KPiAKPiBIYXZpbmcgd2hpdGVzcGFj
ZXMgYWZ0ZXIgLUkgZG9lcyBub3QgbWF0dGVyIHNpbmNlIGNvbW1pdCA0OGY2ZTNjZjViYzYKPiAo
ImtidWlsZDogZG8gbm90IGRyb3AgLUkgd2l0aG91dCBwYXJhbWV0ZXIiKS4KPiAKPiBbMV06IGh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvOTYzMjM0Ny8KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBNYXNhaGlybyBZYW1hZGEgPHlhbWFkYS5tYXNhaGlyb0Bzb2Npb25leHQuY29tPgoKUGF0
Y2ggbG9va3MgZ29vZDoKUmV2aWV3ZWQtYnk6IFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9y
Zz4KCj4gLS0tCj4gCj4gSSBwdXQgYWxsIGdwdS9kcm0gY2hhbmdlcyBpbnRvIGEgc2luZ2xlIHBh
dGNoIGJlY2F1c2UKPiB0aGV5IGFyZSB0cml2aWFsIGNvbnZlcnNpb24uCj4KPiBQbGVhc2UgbGV0
IG1lIGtub3cgaWYgSSBuZWVkIHRvIHNwbGl0IHRoaXMgaW50byBwZXItZHJpdmVyIHBhdGNoZXMu
CkFncmVlIHRoYXQgaXQgaXMgZ29vZCB0byBoYXZlIHRob3NlIHJlbGF0ZWQgY2huZ2VzIHRvZ2V0
aGVyIGluIG9uZSBwYXRjaC4KCkkgc3RpbGwgbmVlZCB0byBsb29rIGludG8gZ2V0dGluZyBjb21t
aXQtcmlnaHRzLgpEYW5pZWwgLSBjYW4geW91IHRha2UgdGhpcyB0byBkcm0tbWlzYz8KCglTYW0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KRnJlZWRyZW5v
IG1haWxpbmcgbGlzdApGcmVlZHJlbm9AbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZnJlZWRyZW5v
