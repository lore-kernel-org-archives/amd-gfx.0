From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: arm32 build failure after abe882a39a9c ("drm/amd/display: fix
 issue with eDP not detected on driver load")
Date: Tue, 25 Jun 2019 13:59:17 +1000
Message-ID: <CAPM=9txaQ43GwOzXSE3prTRLbMt+ip=s_ssmFzWsfsTYdLssaw@mail.gmail.com>
References: <20190618011124.GA67760@archlinux-epyc>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190618011124.GA67760@archlinux-epyc>
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
To: Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Jun Lei <Jun.Lei-5C7GfCeVMHo@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

SGkgQWxleCwKCnBsZWFzZSByZXNvbHZlIHRoaXMgQVNBUCwgSSBjYW5ub3QgcHVsbCB5b3VyIHRy
ZWUgd2l0aG91dCB0aGlzIGZpeGVkCmFzIGl0IGJyZWFrcyBteSBhcm0gYnVpbGRzIGhlcmUuCgph
biA4IHNlY29uZCBkZWxheSB0aGVyZSBzZWVtcyBwb2ludGxlc3MgYW5kIGFyYml0YXJ5LCBhbiA4
IHNlYyBkZWxheQp0aGVyZSB3aXRob3V0IGEgY29tbWVudCwgc2VlbXMgbGlrZSBhIGxhY2sgb2Yg
cmV2aWV3LgoKRGF2ZS4KCk9uIFR1ZSwgMTggSnVuIDIwMTkgYXQgMTE6MTIsIE5hdGhhbiBDaGFu
Y2VsbG9yCjxuYXRlY2hhbmNlbGxvckBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gSGkgYWxsLAo+Cj4g
QWZ0ZXIgY29tbWl0IGFiZTg4MmEzOWE5YyAoImRybS9hbWQvZGlzcGxheTogZml4IGlzc3VlIHdp
dGggZURQIG5vdAo+IGRldGVjdGVkIG9uIGRyaXZlciBsb2FkIikgaW4gLW5leHQsIGFybTMyIGFs
bHllc2NvbmZpZyBidWlsZHMgc3RhcnQKPiBmYWlsaW5nIGF0IGxpbmsgdGltZToKPgo+IGFybS1s
aW51eC1nbnVlYWJpLWxkOiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19s
aW5rLm86IGluCj4gZnVuY3Rpb24gYGRjX2xpbmtfZGV0ZWN0JzoKPiBkY19saW5rLmM6KC50ZXh0
KzB4MjYwYyk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYF9fYmFkX3VkZWxheScKPgo+IGFybTMy
IG9ubHkgYWxsb3dzIGEgdWRlbGF5IHZhbHVlIG9mIHVwIHRvIDIwMDAsIHNlZQo+IGFyY2gvYXJt
L2luY2x1ZGUvYXNtL2RlbGF5LmggZm9yIG1vcmUgaW5mby4KPgo+IFBsZWFzZSBsb29rIGludG8g
dGhpcyB3aGVuIHlvdSBoYXZlIGEgY2hhbmNlIQo+IE5hdGhhbgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
