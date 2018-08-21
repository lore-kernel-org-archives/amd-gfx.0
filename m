From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: indent an if statement
Date: Tue, 21 Aug 2018 14:51:19 -0400
Message-ID: <3d491f32-245c-30ac-4f13-39da721c3dbc@amd.com>
References: <20180814090944.qjm4vxyrjdqxu4d7@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180814090944.qjm4vxyrjdqxu4d7-vMlZ3nK25oGAIHFoDFOv9A@public.gmane.org>
Content-Language: en-US
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
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Charlene Liu <charlene.liu-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>, Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>, Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0wOC0xNCAwNTowOSBBTSwgRGFuIENhcnBlbnRlciB3cm90ZToKPiBUaGUgaWYgc3Rh
dGVtZW50IGlzbid0IGluZGVudGVkIGFuZCBpdCBtYWtlcyBzdGF0aWMgY2hlY2tlcnMgY29tcGxh
aW4uCj4gCj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFj
bGUuY29tPgoKUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQu
Y29tPgoKSGFycnkKCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kY19yZXNvdXJjZS5jCj4gaW5kZXggNGNhNDFkNmUzYmNmLi5kODJiYTU4YzcyMGYgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3Vy
Y2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291
cmNlLmMKPiBAQCAtMzQ5LDcgKzM0OSw3IEBAIHN0YXRpYyBib29sIGlzX2RwX2FuZF9oZG1pX3No
YXJhYmxlKAo+ICAKPiAgCWlmIChzdHJlYW0xLT5jbGFtcGluZy5jX2RlcHRoICE9IENPTE9SX0RF
UFRIXzg4OCB8fAo+ICAJICAgIHN0cmVhbTItPmNsYW1waW5nLmNfZGVwdGggIT0gQ09MT1JfREVQ
VEhfODg4KQo+IC0JcmV0dXJuIGZhbHNlOwo+ICsJCXJldHVybiBmYWxzZTsKPiAgCj4gIAlyZXR1
cm4gdHJ1ZTsKPiAgCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
