From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: checking for NULL instead of IS_ERR()
Date: Mon, 6 Nov 2017 16:30:42 -0500
Message-ID: <CADnq5_OhFBvmVzpkhJ8p_FM9i29-5pozmyj9esfFsoPj_pBa8A@mail.gmail.com>
References: <20171106114340.w6li3f4iltg24bdp@mwanda>
 <823814f1-4133-bffa-fe34-c676a2466d1d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <823814f1-4133-bffa-fe34-c676a2466d1d-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

T24gTW9uLCBOb3YgNiwgMjAxNyBhdCA2OjUxIEFNLCBDaHJpc3RpYW4gS8O2bmlnCjxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+IEFtIDA2LjExLjIwMTcgdW0gMTI6NDMgc2Nocmll
YiBEYW4gQ2FycGVudGVyOgo+Pgo+PiBiYWNrbGlnaHRfZGV2aWNlX3JlZ2lzdGVyKCkgbmV2ZXIg
cmV0dXJucyBOVUxMLCBpdCByZXR1cm5zIGVycm9yCj4+IHBvaW50ZXJzIG9uIGVycm9yIHNvIHRo
ZSBjaGVjayBoZXJlIGlzIHdyb25nLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVy
IDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+Cj4KPgo+IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpBcHBsaWVkLiAgdGhhbmtzIQoKQWxleAoK
Pgo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYwo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMKPj4gaW5kZXggMzNhMTVhMWQ4MThjLi43NWY5MzgzZjViOWIgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMK
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0u
Ywo+PiBAQCAtMTI5Niw3ICsxMjk2LDcgQEAgYW1kZ3B1X2RtX3JlZ2lzdGVyX2JhY2tsaWdodF9k
ZXZpY2Uoc3RydWN0Cj4+IGFtZGdwdV9kaXNwbGF5X21hbmFnZXIgKmRtKQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAmYW1kZ3B1X2RtX2JhY2tsaWdodF9vcHMsCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICZwcm9wcyk7Cj4+ICAgLSAgICAgaWYgKE5VTEwgPT0gZG0tPmJhY2tsaWdodF9k
ZXYpCj4+ICsgICAgICAgaWYgKElTX0VSUihkbS0+YmFja2xpZ2h0X2RldikpCj4+ICAgICAgICAg
ICAgICAgICBEUk1fRVJST1IoIkRNOiBCYWNrbGlnaHQgcmVnaXN0cmF0aW9uIGZhaWxlZCFcbiIp
Owo+PiAgICAgICAgIGVsc2UKPj4gICAgICAgICAgICAgICAgIERSTV9ERUJVR19EUklWRVIoIkRN
OiBSZWdpc3RlcmVkIEJhY2tsaWdodCBkZXZpY2U6ICVzXG4iLAo+PiBibF9uYW1lKTsKPgo+Cj4K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
