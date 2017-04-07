From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix "fix 64bit division"
Date: Fri, 7 Apr 2017 16:55:50 +0800
Message-ID: <58E75416.3010201@amd.com>
References: <1491554650-9691-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1491554650-9691-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAwNC8wNy8yMDE3IDA0OjQ0IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEZyb206
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPgo+IFRoZSBvZmZz
ZXQgbXVzdCBiZSA2NGJpdCBhbmQgYWRkIGJhY2sgdGhlIGFjY2lkZW50aWFsIGRyb3BwZWQgbGlu
ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4K
Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCAzICsr
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IGluZGV4IGM5MWYxM2IuLmJh
MTFmZjI1NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dHRtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBA
QCAtNTUxLDkgKzU1MSwxMCBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBhbWRncHVfdHRtX2lvX21l
bV9wZm4oc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywKPiAgIHsKPiAgIAlzdHJ1Y3QgZHJt
X21tX25vZGUgKm1tID0gYm8tPm1lbS5tbV9ub2RlOwo+ICAgCXVpbnQ2NF90IHNpemUgPSBtbS0+
c2l6ZTsKPiAtCXVuc2lnbmVkIGxvbmcgb2Zmc2V0ID0gcGFnZV9vZmZzZXQ7Cj4gKwl1aW50NjRf
dCBvZmZzZXQgPSBwYWdlX29mZnNldDsKPgo+ICAgCXBhZ2Vfb2Zmc2V0ID0gZG9fZGl2KG9mZnNl
dCwgc2l6ZSk7Cj4gKwltbSArPSBvZmZzZXQ7Cj4gICAJcmV0dXJuIChiby0+bWVtLmJ1cy5iYXNl
ID4+IFBBR0VfU0hJRlQpICsgbW0tPnN0YXJ0ICsgcGFnZV9vZmZzZXQ7Cj4gICB9Cj4KPgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
