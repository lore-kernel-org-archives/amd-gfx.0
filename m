From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: hide an unused variable
Date: Thu, 19 Sep 2019 12:49:47 -0400
Message-ID: <CADnq5_OnhBx_cCHNNQcWkd1SosSfdF9jXYpoE-iYSuZbsVOicQ@mail.gmail.com>
References: <20190918195418.2042610-1-arnd@arndb.de>
 <73842ec4-2767-c918-6ede-d05ff653255c@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <73842ec4-2767-c918-6ede-d05ff653255c-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zhang,
 Dingchen (David)" <Dingchen.Zhang-5C7GfCeVMHo@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Francis,
 David" <David.Francis-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBTZXAgMTksIDIwMTkgYXQgOTo0NSBBTSBIYXJyeSBXZW50bGFuZCA8aHdlbnRsYW5A
YW1kLmNvbT4gd3JvdGU6Cj4KPiBPbiAyMDE5LTA5LTE4IDM6NTMgcC5tLiwgQXJuZCBCZXJnbWFu
biB3cm90ZToKPiA+IFdpdGhvdXQgQ09ORklHX0RFQlVHX0ZTLCB3ZSBnZXQgYSB3YXJuaW5nIGZv
ciBhbiB1bnVzZWQKPiA+IHZhcmlhYmxlOgo+ID4KPiA+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1Ly4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jOjYwMjA6MzM6IGVycm9yOiB1bnVz
ZWQgdmFyaWFibGUgJ3NvdXJjZScgWy1XZXJyb3IsLVd1bnVzZWQtdmFyaWFibGVdCj4gPgo+ID4g
SGlkZSB0aGUgdmFyaWFibGUgaW4gYW4gI2lmZGVmIGxpa2UgaXRzIG9ubHkgdXNlcnMuCj4gPgo+
ID4gRml4ZXM6IDE0YjI1ODQ2MzZjNiAoImRybS9hbWQvZGlzcGxheTogYWRkIGZ1bmN0aW9uYWxp
dHkgdG8gZ3JhYiBEUFJYIENSQyBlbnRyaWVzLiIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJl
cmdtYW5uIDxhcm5kQGFybmRiLmRlPgo+Cj4gUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxo
YXJyeS53ZW50bGFuZEBhbWQuY29tPgo+CgpBcHBsaWVkLiAgdGhhbmtzIQoKQWxleAoKPiBIYXJy
eQo+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jIHwgMiArKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiA+
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMKPiA+IGluZGV4IGUxYjA5YmI0MzJiZC4uNzQyNTJmNTdiYWZiIDEwMDY0NAo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+
ID4gQEAgLTYwMTcsNyArNjAxNyw5IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9lbmFibGVfY3J0
Y19pbnRlcnJ1cHRzKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCj4gPiAgICAgICBzdHJ1Y3QgZHJt
X2NydGMgKmNydGM7Cj4gPiAgICAgICBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKm9sZF9jcnRjX3N0
YXRlLCAqbmV3X2NydGNfc3RhdGU7Cj4gPiAgICAgICBpbnQgaTsKPiA+ICsjaWZkZWYgQ09ORklH
X0RFQlVHX0ZTCj4gPiAgICAgICBlbnVtIGFtZGdwdV9kbV9waXBlX2NyY19zb3VyY2Ugc291cmNl
Owo+ID4gKyNlbmRpZgo+ID4KPiA+ICAgICAgIGZvcl9lYWNoX29sZG5ld19jcnRjX2luX3N0YXRl
KHN0YXRlLCBjcnRjLCBvbGRfY3J0Y19zdGF0ZSwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG5ld19jcnRjX3N0YXRlLCBpKSB7Cj4gPgo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
