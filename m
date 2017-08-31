From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/amdgpu: restrict userptr even more
Date: Thu, 31 Aug 2017 10:10:07 +0800
Message-ID: <2da0229c-eb1a-be28-e7d1-cd0226324d99@amd.com>
References: <1504105209-1558-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1504105209-1558-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QWNrZWQtYnk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+LCBGb3IgdGhlIG90
aGVyIHRocmVlLCB3ZSdkIApiZXR0ZXIgdG8gd2FpdCBmb3Igb3VyIFVNRCBndXlzIHRlc3RzLgoK
Ck9uIDIwMTflubQwOOaciDMw5pelIDIzOjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEZy
b206IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPgo+IERvbid0
IGFsbG93IHRoZW0gdG8gYmUgR0VNIGltcG9ydGVkIGludG8gYW5vdGhlciBwcm9jZXNzLgo+Cj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
Pgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgNiAr
KysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPiBpbmRleCBkMDI4ODA2Li5lMzJhMmI1IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+IEBAIC0xMTIsNyArMTEy
LDEzIEBAIGludCBhbWRncHVfZ2VtX29iamVjdF9vcGVuKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAq
b2JqLAo+ICAgCXN0cnVjdCBhbWRncHVfZnByaXYgKmZwcml2ID0gZmlsZV9wcml2LT5kcml2ZXJf
cHJpdjsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSA9ICZmcHJpdi0+dm07Cj4gICAJc3RydWN0
IGFtZGdwdV9ib192YSAqYm9fdmE7Cj4gKwlzdHJ1Y3QgbW1fc3RydWN0ICptbTsKPiAgIAlpbnQg
cjsKPiArCj4gKwltbSA9IGFtZGdwdV90dG1fdHRfZ2V0X3VzZXJtbShhYm8tPnRiby50dG0pOwo+
ICsJaWYgKG1tICYmIG1tICE9IGN1cnJlbnQtPm1tKQo+ICsJCXJldHVybiAtRVBFUk07Cj4gKwo+
ICAgCXIgPSBhbWRncHVfYm9fcmVzZXJ2ZShhYm8sIGZhbHNlKTsKPiAgIAlpZiAocikKPiAgIAkJ
cmV0dXJuIHI7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
