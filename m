From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display/dcn10_hw_sequencer_debug: Remove
 duplicate header
Date: Thu, 20 Dec 2018 11:54:53 -0500
Message-ID: <CADnq5_Oq4TZee5C1mU4Rrdin8gLbBM5hFWn2hS+NsvVhUfndsQ@mail.gmail.com>
References: <20181220122841.GA24907@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181220122841.GA24907@hp-pavilion-15-notebook-pc-brajeswar>
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
To: Brajeswar Ghosh <brajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Wesley.Chalmers-5C7GfCeVMHo@public.gmane.org, Sabyasachi Gupta <sabyasachi.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher, Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBEZWMgMjAsIDIwMTggYXQgOTozNiBBTSBCcmFqZXN3YXIgR2hvc2gKPGJyYWplc3dh
ci5saW51eEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gUmVtb3ZlIGN1c3RvbV9mbG9hdC5oIHdoaWNo
IGlzIGluY2x1ZGVkIG1vcmUgdGhhbiBvbmNlCj4KPiBTaWduZWQtb2ZmLWJ5OiBCcmFqZXN3YXIg
R2hvc2ggPGJyYWplc3dhci5saW51eEBnbWFpbC5jb20+CgpBcHBsaWVkLiAgdGhhbmtzIQoKQWxl
eAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3
X3NlcXVlbmNlcl9kZWJ1Zy5jIHwgMSAtCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2Rj
bjEwX2h3X3NlcXVlbmNlcl9kZWJ1Zy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlcl9kZWJ1Zy5jCj4gaW5kZXggNjQxNTg5MDA3MzBmLi41
YTU2M2UyMzFiZTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlcl9kZWJ1Zy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlcl9kZWJ1Zy5jCj4gQEAgLTQw
LDcgKzQwLDYgQEAKPiAgI2luY2x1ZGUgImlwcC5oIgo+ICAjaW5jbHVkZSAibXBjLmgiCj4gICNp
bmNsdWRlICJyZWdfaGVscGVyLmgiCj4gLSNpbmNsdWRlICJjdXN0b21fZmxvYXQuaCIKPiAgI2lu
Y2x1ZGUgImRjbjEwX2h1YnAuaCIKPiAgI2luY2x1ZGUgImRjbjEwX2h1YmJ1Yi5oIgo+ICAjaW5j
bHVkZSAiZGNuMTBfY21fY29tbW9uLmgiCj4gLS0KPiAyLjE3LjEKPgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QK
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
