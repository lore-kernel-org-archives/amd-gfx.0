From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: set bulk_moveable to false when a per VM is
 released
Date: Wed, 5 Sep 2018 17:09:31 +0200
Message-ID: <9b550913-4304-0bfe-ba24-e8ddb6a4047b@amd.com>
References: <20180905150826.15779-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180905150826.15779-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SGkgVG9tLAoKcGxlYXNlIGNoZWNrIGlmIHRoYXQgcGF0Y2ggaGVscHMgd2l0aCB5b3VyIEtBU0FO
IHByb2JsZW0uCgpUaGFua3MsCkNocmlzdGlhbi4KCkFtIDA1LjA5LjIwMTggdW0gMTc6MDggc2No
cmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IE90aGVyd2lzZSB3ZSBtaWdodCBydW4gaW50byBhIHVz
ZSBhZnRlciBmcmVlIGR1cmluZyBidWxrIG1vdmUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDQgKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMK
PiBpbmRleCBlYTVlMjc3YWUwMzguLmVkMWU2YWJkYTM5MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTI1MTMsOCArMjUxMywxMiBAQCB2b2lkIGFtZGdw
dV92bV9ib19ybXYoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCSAgICAgIHN0cnVj
dCBhbWRncHVfYm9fdmEgKmJvX3ZhKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfYm9fdmFfbWFw
cGluZyAqbWFwcGluZywgKm5leHQ7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IGJvX3ZhLT5i
YXNlLmJvOwo+ICAgCXN0cnVjdCBhbWRncHVfdm0gKnZtID0gYm9fdmEtPmJhc2Uudm07Cj4gICAK
PiArCWlmIChibyAmJiBiby0+dGJvLnJlc3YgPT0gdm0tPnJvb3QuYmFzZS5iby0+dGJvLnJlc3Yp
Cj4gKwkJdm0tPmJ1bGtfbW92ZWFibGUgPSBmYWxzZTsKPiArCj4gICAJbGlzdF9kZWwoJmJvX3Zh
LT5iYXNlLmJvX2xpc3QpOwo+ICAgCj4gICAJc3Bpbl9sb2NrKCZ2bS0+aW52YWxpZGF0ZWRfbG9j
ayk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
