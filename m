From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/scheduler:fix duplicate operation in entity fini
Date: Mon, 23 Oct 2017 09:12:27 +0200
Message-ID: <f11286ce-66aa-55d4-e29b-4c751e192212@gmail.com>
References: <1508738432-27426-1-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1508738432-27426-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjMuMTAuMjAxNyB1bSAwODowMCBzY2hyaWViIE1vbmsgTGl1Ogo+IG5vIG5lZWQgdG8gbWFu
dWFsbHkgY2xlYW51cCBqb2IgYW5kIGZlbmNlIGFmdGVyIHNjaGVkX2ZlbmNlX2ZpbmlzaCgpLAo+
IHRoZXkgYXJlIGF1dG8gaGFuZGxlZCBieSB0aGUgY2FsbGJhY2sKPgo+IENoYW5nZS1JZDogSTlk
YTI2MDY0YzllNzNjMTc4OTQ5NjYzYmVkMWU0OTA1MzllOTVlNDEKPiBTaWduZWQtb2ZmLWJ5OiBN
b25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jIHwgMyArLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmMKPiBpbmRleCAzOWI2MjA1Li5mOWYzZGFhIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYwo+IEBA
IC0yMzAsMTEgKzIzMCwxMCBAQCB2b2lkIGFtZF9zY2hlZF9lbnRpdHlfZmluaShzdHJ1Y3QgYW1k
X2dwdV9zY2hlZHVsZXIgKnNjaGVkLAo+ICAgCQlrdGhyZWFkX3VucGFyayhzY2hlZC0+dGhyZWFk
KTsKPiAgIAkJd2hpbGUgKGtmaWZvX291dCgmZW50aXR5LT5qb2JfcXVldWUsICZqb2IsIHNpemVv
Zihqb2IpKSkgewo+ICAgCQkJc3RydWN0IGFtZF9zY2hlZF9mZW5jZSAqc19mZW5jZSA9IGpvYi0+
c19mZW5jZTsKPiArCj4gICAJCQlhbWRfc2NoZWRfZmVuY2Vfc2NoZWR1bGVkKHNfZmVuY2UpOwo+
ICAgCQkJZG1hX2ZlbmNlX3NldF9lcnJvcigmc19mZW5jZS0+ZmluaXNoZWQsIC1FU1JDSCk7Cj4g
ICAJCQlhbWRfc2NoZWRfZmVuY2VfZmluaXNoZWQoc19mZW5jZSk7Cj4gLQkJCWRtYV9mZW5jZV9w
dXQoJnNfZmVuY2UtPmZpbmlzaGVkKTsKPiAtCQkJc2NoZWQtPm9wcy0+ZnJlZV9qb2Ioam9iKTsK
PiAgIAkJfQo+ICAgCj4gICAJfQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
