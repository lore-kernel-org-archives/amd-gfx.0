From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: set firmware loading type as direct by default
 for raven
Date: Tue, 4 Jul 2017 17:39:51 +0800
Message-ID: <595B6267.9040600@amd.com>
References: <1499157314-28393-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1499157314-28393-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?windows-1252?Q?Christian_K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

SGkgUmF5LAoKVGhhbmtzIGZvciB5b3VyIGluaXRpYWwgcGF0Y2ggdG8gZW5hYmxlIFBTUCBvcHRp
b24gZm9yIFJhdmVuLgoKVG8gc2ltcGxpZnkgaXQsIHdlIG1heSBsZXZlcmFnZSBWRUdBMTAgY2Fz
ZSBmb3IgUmF2ZW4gZGlyZWN0bHkuCkFuZCByZW1vdmUgYWxsIFJhdmVuIGV4aXN0aW5nIGNvZGUg
dW5kZXIgImNhc2UgQ0hJUF9SQVZFTiIKSG93IGRvIHlvdSB0aGluayBhYm91dCBpdD8KCkplcnJ5
CgpPbiAwNy8wNC8yMDE3IDA0OjM1IFBNLCBIdWFuZyBSdWkgd3JvdGU6Cj4gSW4gcHJldmlvdXMg
Y2FzZSwgZHJpdmVyIGNhbid0IGVuYWJsZSBwc3AgdmlhIHRoZSBrZXJuZWwgcGFyYW1ldGVyIGZv
ciByYXZlbi4KPiBXZSBzaG91bGQgb3BlbiB0aGlzIHBhdGggYW5kIHNldCBpdCBhcyBkaXJlY3Qg
YnkgZGVmYXVsdCB0aWxsIHBzcCBmaXJtd2FyZQo+IGxvYWRpbmcgaXMgd29ya2FibGUuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMgfCA2ICstLS0tLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMKPiBpbmRleCAxN2E5MzVkLi5mY2ZiOWQ0
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMKPiBAQCAt
Mjc1LDE0ICsyNzUsMTAgQEAgYW1kZ3B1X3Vjb2RlX2dldF9sb2FkX3R5cGUoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIGludCBsb2FkX3R5cGUpCj4gICAJCWVsc2UKPiAgIAkJCXJldHVybiBB
TURHUFVfRldfTE9BRF9QU1A7Cj4gICAJY2FzZSBDSElQX1JBVkVOOgo+IC0jaWYgMAo+IC0JCWlm
ICghbG9hZF90eXBlKQo+ICsJCWlmIChsb2FkX3R5cGUgIT0gMikKPiAgIAkJCXJldHVybiBBTURH
UFVfRldfTE9BRF9ESVJFQ1Q7Cj4gICAJCWVsc2UKPiAgIAkJCXJldHVybiBBTURHUFVfRldfTE9B
RF9QU1A7Cj4gLSNlbHNlCj4gLQkJcmV0dXJuIEFNREdQVV9GV19MT0FEX0RJUkVDVDsKPiAtI2Vu
ZGlmCj4gICAJZGVmYXVsdDoKPiAgIAkJRFJNX0VSUk9SKCJVbmtub3cgZmlybXdhcmUgbG9hZCB0
eXBlXG4iKTsKPiAgIAl9Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
