From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: do not execute 0-sized IBs
Date: Thu, 3 Oct 2019 10:09:37 +0200
Message-ID: <12e0b546-faaf-38c3-c0fc-1e713348b62e@gmail.com>
References: <20191003080306.3514-1-pierre-eric.pelloux-prayer@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191003080306.3514-1-pierre-eric.pelloux-prayer-5C7GfCeVMHo@public.gmane.org>
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
To: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMDMuMTAuMTkgdW0gMTA6MDMgc2NocmllYiBQZWxsb3V4LXByYXllciwgUGllcnJlLWVyaWM6
Cj4gVGhpcyBjYW4gYmUgc2FmZWx5IHNraXBwZWQgZW50aXJlbHkuCj4gVGhpcyBzZWVtcyB0byBo
ZWxwIHdpdGggaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTEx
NDgxLgoKTkFLLCBwbGVhc2UgaW5zdGVhZCBmaXggZ21jX3YxMF8wX2ZsdXNoX2dwdV90bGIgdG8g
aW5jbHVkZSBhdCBsZWFzdCBzb21lIApOT1AgaW4gdGhlIHN1Ym1pdHRlZCBJQnMuCgpDaHJpc3Rp
YW4uCgo+Cj4gU2lnbmVkLW9mZi1ieTogUGllcnJlLUVyaWMgUGVsbG91eC1QcmF5ZXIgPHBpZXJy
ZS1lcmljLnBlbGxvdXgtcHJheWVyQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfaWIuYyB8IDUgKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfaWIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4gaW5k
ZXggNjA2NTU4MzRkNjQ5Li5hYTE2M2U2NzlmMWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfaWIuYwo+IEBAIC0yMjcsNiArMjI3LDExIEBAIGludCBhbWRncHVfaWJfc2No
ZWR1bGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1bnNpZ25lZCBudW1faWJzLAo+ICAgCQkg
ICAgIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkgLyogZm9yIFNSSU9WIHByZWVtcHRpb24sIFByZWFt
YmxlIENFIGliIG11c3QgYmUgaW5zZXJ0ZWQgYW55d2F5ICovCj4gICAJCQljb250aW51ZTsKPiAg
IAo+ICsJCWlmIChpYi0+bGVuZ3RoX2R3ID09IDApIHsKPiArCQkJLyogT24gTmF2aSBnbWNfdjEw
XzBfZmx1c2hfZ3B1X3RsYiBlbWl0cyAwIHNpemVkIElCICovCj4gKwkJCWNvbnRpbnVlOwo+ICsJ
CX0KPiArCj4gICAJCWFtZGdwdV9yaW5nX2VtaXRfaWIocmluZywgam9iLCBpYiwgc3RhdHVzKTsK
PiAgIAkJc3RhdHVzICY9IH5BTURHUFVfSEFWRV9DVFhfU1dJVENIOwo+ICAgCX0KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
