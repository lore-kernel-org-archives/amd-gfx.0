From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH -next] drm/amd/display: Make dc_link_detect_helper static
Date: Wed, 16 Oct 2019 12:19:15 -0400
Message-ID: <CADnq5_MzELoYV2=Fzioy_YqxdyQg+RXQKL4CUwayGP3_RMRg3A@mail.gmail.com>
References: <20191016111541.20208-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191016111541.20208-1-yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: YueHaibing <yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Chris Park <Chris.Park-5C7GfCeVMHo@public.gmane.org>, Eric Yang <Eric.Yang2-5C7GfCeVMHo@public.gmane.org>, "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>, Wenjing Liu <Wenjing.Liu-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Nikola Cornij <nikola.cornij-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Martin Leung <martin.leung-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, david.galiffi-5C7GfCeVMHo@public.gmane.org, Jun Lei <Jun.Lei-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>

T24gV2VkLCBPY3QgMTYsIDIwMTkgYXQgODoyOSBBTSBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1
YXdlaS5jb20+IHdyb3RlOgo+Cj4gRml4IHNwYXJzZSB3YXJuaW5nOgo+Cj4gZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYzo3NDY6NjoKPiAgd2Fy
bmluZzogc3ltYm9sICdkY19saW5rX2RldGVjdF9oZWxwZXInIHdhcyBub3QgZGVjbGFyZWQuIFNo
b3VsZCBpdCBiZSBzdGF0aWM/Cj4KPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1
YXdlaS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWku
Y29tPgoKQXBwbGllZC4gIHRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYyB8IDMgKystCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMKPiBpbmRleCBmYjE4NjgxLi45MzUwNTM2IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwo+IEBA
IC03NDMsNyArNzQzLDggQEAgc3RhdGljIGJvb2wgd2FpdF9mb3JfYWx0X21vZGUoc3RydWN0IGRj
X2xpbmsgKmxpbmspCj4gICAqIFRoaXMgZG9lcyBub3QgY3JlYXRlIHJlbW90ZSBzaW5rcyBidXQg
d2lsbCB0cmlnZ2VyIERNCj4gICAqIHRvIHN0YXJ0IE1TVCBkZXRlY3Rpb24gaWYgYSBicmFuY2gg
aXMgZGV0ZWN0ZWQuCj4gICAqLwo+IC1ib29sIGRjX2xpbmtfZGV0ZWN0X2hlbHBlcihzdHJ1Y3Qg
ZGNfbGluayAqbGluaywgZW51bSBkY19kZXRlY3RfcmVhc29uIHJlYXNvbikKPiArc3RhdGljIGJv
b2wgZGNfbGlua19kZXRlY3RfaGVscGVyKHN0cnVjdCBkY19saW5rICpsaW5rLAo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIGRjX2RldGVjdF9yZWFzb24gcmVhc29uKQo+
ICB7Cj4gICAgICAgICBzdHJ1Y3QgZGNfc2lua19pbml0X2RhdGEgc2lua19pbml0X2RhdGEgPSB7
IDAgfTsKPiAgICAgICAgIHN0cnVjdCBkaXNwbGF5X3NpbmtfY2FwYWJpbGl0eSBzaW5rX2NhcHMg
PSB7IDAgfTsKPiAtLQo+IDIuNy40Cj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
