From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add emit reg write reg wait for vcn jpeg
Date: Wed, 11 Jul 2018 15:00:51 -0400
Message-ID: <3e409ddf-a670-3526-3adf-42c0c8343e5d@amd.com>
References: <1531335341-2585-1-git-send-email-boyuan.zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1531335341-2585-1-git-send-email-boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-GB
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
To: boyuan.zhang-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UmV2aWV3ZWQtYnk6IExlbyBMaXUgPGxlby5saXVAYW1kLmNvbT4KCgpPbiAwNy8xMS8yMDE4IDAy
OjU1IFBNLCBib3l1YW4uemhhbmdAYW1kLmNvbSB3cm90ZToKPiBGcm9tOiBCb3l1YW4gWmhhbmcg
PGJveXVhbi56aGFuZ0BhbWQuY29tPgo+Cj4gVGhlIGVtaXRfcmVnX3dyaXRlX3JlZ193YWl0IGZ1
bmN0aW9uIHdhcyBub3QgYXNzaWduZWQgZm9yIHZjbiBqcGVnLgo+IFRoaXMgcGF0Y2ggYWRkIGl0
IGJhY2suCj4KPiBTaWduZWQtb2ZmLWJ5OiBCb3l1YW4gWmhhbmcgPGJveXVhbi56aGFuZ0BhbWQu
Y29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYyB8IDEg
Kwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3Zjbl92MV8wLmMKPiBpbmRleCBiODJjOTIwLi40ZmNjYjIxIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCj4gQEAgLTE3MjIsNiArMTcyMiw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3MgdmNuX3YxXzBfanBlZ19yaW5nX3ZtX2Z1
bmNzID0gewo+ICAgCS5lbmRfdXNlID0gYW1kZ3B1X3Zjbl9yaW5nX2VuZF91c2UsCj4gICAJLmVt
aXRfd3JlZyA9IHZjbl92MV8wX2pwZWdfcmluZ19lbWl0X3dyZWcsCj4gICAJLmVtaXRfcmVnX3dh
aXQgPSB2Y25fdjFfMF9qcGVnX3JpbmdfZW1pdF9yZWdfd2FpdCwKPiArCS5lbWl0X3JlZ193cml0
ZV9yZWdfd2FpdCA9IGFtZGdwdV9yaW5nX2VtaXRfcmVnX3dyaXRlX3JlZ193YWl0X2hlbHBlciwK
PiAgIH07Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHZjbl92MV8wX3NldF9kZWNfcmluZ19mdW5jcyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
