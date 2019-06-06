From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH][next] drm/amd/display: remove redundant assignment to
 status
Date: Thu, 6 Jun 2019 13:30:55 +0300
Message-ID: <20190606103055.GJ31203@kadam>
References: <20190530161219.2507-1-colin.king@canonical.com>
 <a190bcd5-cda8-84c6-093a-98438a605032@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a190bcd5-cda8-84c6-093a-98438a605032-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Li,
 Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "Koo, Anthony" <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gRnJpLCBNYXkgMzEsIDIwMTkgYXQgMDg6MTk6MDNQTSArMDAwMCwgSGFycnkgV2VudGxhbmQg
d3JvdGU6Cj4gT24gMjAxOS0wNS0zMCAxMjoxMiBwLm0uLCBDb2xpbiBLaW5nIHdyb3RlOgo+ID4g
RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KPiA+IAo+ID4g
VGhlIHZhcmlhYmxlIHN0YXR1cyBpcyBpbml0aWFsaXplZCB3aXRoIGEgdmFsdWUgdGhhdCBpcyBu
ZXZlciByZWFkCj4gPiBhbmQgc3RhdHVzIGlzIHJlYXNzaWduZWQgc2V2ZXJhbCBzdGF0ZW1lbnRz
IGxhdGVyLiBUaGlzIGluaXRpYWxpemF0aW9uCj4gPiBpcyByZWR1bmRhbnQgYW5kIGNhbiBiZSBy
ZW1vdmVkLgo+ID4gCj4gPiBBZGRyZXNzZXMtQ292ZXJpdHk6ICgiVW51c2VkIHZhbHVlIikKPiA+
IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+
Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5r
X2RwLmMgfCAyICstCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY29yZS9kY19saW5rX2RwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29y
ZS9kY19saW5rX2RwLmMKPiA+IGluZGV4IDY1ZDZjYWVkYmQ4Mi4uY2Y2MTY2YTFiZTUzIDEwMDY0
NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19k
cC5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5r
X2RwLmMKPiA+IEBAIC0yMzY3LDcgKzIzNjcsNyBAQCBzdGF0aWMgYm9vbCByZXRyaWV2ZV9saW5r
X2NhcChzdHJ1Y3QgZGNfbGluayAqbGluaykKPiA+ICAJdW5pb24gZG93bl9zdHJlYW1fcG9ydF9j
b3VudCBkb3duX3N0cm1fcG9ydF9jb3VudDsKPiA+ICAJdW5pb24gZWRwX2NvbmZpZ3VyYXRpb25f
Y2FwIGVkcF9jb25maWdfY2FwOwo+ID4gIAl1bmlvbiBkcF9kb3duc3RyZWFtX3BvcnRfcHJlc2Vu
dCBkc19wb3J0ID0geyAwIH07Cj4gPiAtCWVudW0gZGNfc3RhdHVzIHN0YXR1cyA9IERDX0VSUk9S
X1VORVhQRUNURUQ7Cj4gPiArCWVudW0gZGNfc3RhdHVzIHN0YXR1czsKPiAKPiBOb3Qgc3VyZSB0
aGlzIGltcHJvdmVzIHRoZSBzaXR1YXRpb24uCj4gCj4gSSdkIHByZWZlciB0byBoYXZlIGEgZGVm
YXVsdCBoZXJlIGluIGNhc2Ugc29tZW9uZSBjaGFuZ2VzIHRoZSBjb2RlIGJlbG93Cj4gYW5kIGZv
cmdldHMgdG8gc2V0IHRoZSBzdGF0dXMuCgpUaGUgZGVhZCBjb2RlIGNvbmZ1c2VzIGh1bWFuIHJl
YWRlcnMsIGJlY2F1c2UgcGVvcGxlIG5hdHVyYWxseSBhc3N1bWUgaXQKaXMgbm90IGRlYWQuCgpH
Q0MgaGFzIGEgZmVhdHVyZSB0byB3YXJuIGFib3V0IHVuaW5pdGlhbGl6ZWQgdmFyaWFibGVzIGFu
ZCB3ZSdyZQpyYW5kb21seSBpbml0aWFsaXppbmcgc3RhdHVzIHRvIGEgYm9ndXMgdmFsdWUgdG8g
ZGlzYWJsZSBzdGF0aWMKYW5hbHlzaXMuLi4KCnJlZ2FyZHMsCmRhbiBjYXJwZW50ZXIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
