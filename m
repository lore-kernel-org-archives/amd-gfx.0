From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH -next] drm/amd/display: remove set but not used variable
 'core_freesync'
Date: Mon, 7 Oct 2019 11:57:26 -0400
Message-ID: <CADnq5_M_c90Gd0w4Hp+xChdYjxCE4=nVogsntVD+vd3U4+N36A@mail.gmail.com>
References: <20191006105735.60708-1-yuehaibing@huawei.com>
 <db644945-24df-7d67-7fc6-880833466593@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <db644945-24df-7d67-7fc6-880833466593-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Cyr,
 Aric" <Aric.Cyr-5C7GfCeVMHo@public.gmane.org>, "Harmanprit.Tatla-5C7GfCeVMHo@public.gmane.org" <Harmanprit.Tatla-5C7GfCeVMHo@public.gmane.org>, "Li,
 Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, YueHaibing <yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Othman, Ahmad" <Ahmad.Othman-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "Amini, Reza" <Reza.Amini-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "daniel-/w4YWyX8dFk@public.gmane.org" <daniel-/w4YWyX8dFk@public.gmane.org>, "bayan.zabihiyan-5C7GfCeVMHo@public.gmane.org" <bayan.zabihiyan-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Koo, Anthony" <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCBPY3QgNywgMjAxOSBhdCAxMDowNiBBTSBIYXJyeSBXZW50bGFuZCA8aHdlbnRsYW5A
YW1kLmNvbT4gd3JvdGU6Cj4KPiBPbiAyMDE5LTEwLTA2IDY6NTcgYS5tLiwgWXVlSGFpYmluZyB3
cm90ZToKPiA+IEZpeGVzIGdjYyAnLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZScgd2FybmluZzoK
PiA+Cj4gPiByaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvbW9kdWxlcy9mcmVl
c3luYy9mcmVlc3luYy5jOgo+ID4gIEluIGZ1bmN0aW9uIG1vZF9mcmVlc3luY19nZXRfc2V0dGlu
Z3M6Cj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L21vZHVsZXMvZnJl
ZXN5bmMvZnJlZXN5bmMuYzo5ODQ6MjQ6Cj4gPiAgd2FybmluZzogdmFyaWFibGUgY29yZV9mcmVl
c3luYyBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQo+ID4KPiA+
IEl0IGlzIG5vdCB1c2VkIHNpbmNlIGNvbW1pdCA5OGU2NDM2ZDNhZjUgKCJkcm0vYW1kL2Rpc3Bs
YXk6IFJlZmFjdG9yIEZyZWVTeW5jIG1vZHVsZSIpCj4gPgo+ID4gUmVwb3J0ZWQtYnk6IEh1bGsg
Um9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8
eXVlaGFpYmluZ0BodWF3ZWkuY29tPgo+Cj4gUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxo
YXJyeS53ZW50bGFuZEBhbWQuY29tPgo+CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKPiBIYXJy
eQo+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9mcmVl
c3luYy9mcmVlc3luYy5jIHwgNCAtLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25z
KC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1
bGVzL2ZyZWVzeW5jL2ZyZWVzeW5jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9k
dWxlcy9mcmVlc3luYy9mcmVlc3luYy5jCj4gPiBpbmRleCA5Y2U1NmE4Li4yMzdkZGE3IDEwMDY0
NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvZnJlZXN5bmMv
ZnJlZXN5bmMuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMv
ZnJlZXN5bmMvZnJlZXN5bmMuYwo+ID4gQEAgLTk4MSwxMyArOTgxLDkgQEAgdm9pZCBtb2RfZnJl
ZXN5bmNfZ2V0X3NldHRpbmdzKHN0cnVjdCBtb2RfZnJlZXN5bmMgKm1vZF9mcmVlc3luYywKPiA+
ICAgICAgICAgICAgICAgdW5zaWduZWQgaW50ICppbnNlcnRlZF9mcmFtZXMsCj4gPiAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGludCAqaW5zZXJ0ZWRfZHVyYXRpb25faW5fdXMpCj4gPiAgewo+ID4g
LSAgICAgc3RydWN0IGNvcmVfZnJlZXN5bmMgKmNvcmVfZnJlZXN5bmMgPSBOVUxMOwo+ID4gLQo+
ID4gICAgICAgaWYgKG1vZF9mcmVlc3luYyA9PSBOVUxMKQo+ID4gICAgICAgICAgICAgICByZXR1
cm47Cj4gPgo+ID4gLSAgICAgY29yZV9mcmVlc3luYyA9IE1PRF9GUkVFU1lOQ19UT19DT1JFKG1v
ZF9mcmVlc3luYyk7Cj4gPiAtCj4gPiAgICAgICBpZiAodnJyLT5zdXBwb3J0ZWQpIHsKPiA+ICAg
ICAgICAgICAgICAgKnZfdG90YWxfbWluID0gdnJyLT5hZGp1c3Qudl90b3RhbF9taW47Cj4gPiAg
ICAgICAgICAgICAgICp2X3RvdGFsX21heCA9IHZyci0+YWRqdXN0LnZfdG90YWxfbWF4Owo+ID4K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
