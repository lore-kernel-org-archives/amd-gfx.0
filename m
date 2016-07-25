From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: enable UVD VM only on polaris
Date: Mon, 25 Jul 2016 12:29:20 -0400
Message-ID: <57963E60.1090809@amd.com>
References: <1469457856-3411-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469457856-3411-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAwNy8yNS8yMDE2IDEwOjQ0IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEZyb206
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPgo+IFN0b25leSBz
dXBwb3J0IGl0LCBidXQgZG9lc24ndCBoYXMgdW5saW1pdGVkIHNlc3Npb24gc3VwcG9ydC4KPgo+
IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KClJldmlld2VkLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+CgpSZWdhcmRzLApMZW8K
Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jIHwgMiArLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMKPiBpbmRleCBmNDZkMTFjLi40ZmE1MDkxIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jCj4gQEAgLTEwNzQsNyArMTA3
NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3MgdXZkX3Y2XzBfcmlu
Z192bV9mdW5jcyA9IHsKPiAgIAo+ICAgc3RhdGljIHZvaWQgdXZkX3Y2XzBfc2V0X3JpbmdfZnVu
Y3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICB7Cj4gLQlpZiAoYWRldi0+YXNpY190
eXBlID49IENISVBfU1RPTkVZKSB7Cj4gKwlpZiAoYWRldi0+YXNpY190eXBlID49IENISVBfUE9M
QVJJUzEwKSB7Cj4gICAJCWFkZXYtPnV2ZC5yaW5nLmZ1bmNzID0gJnV2ZF92Nl8wX3Jpbmdfdm1f
ZnVuY3M7Cj4gICAJCURSTV9JTkZPKCJVVkQgaXMgZW5hYmxlZCBpbiBWTSBtb2RlXG4iKTsKPiAg
IAl9IGVsc2UgewoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
