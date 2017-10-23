From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/ttm:fix memory leak due to individualize
Date: Mon, 23 Oct 2017 09:05:34 +0200
Message-ID: <036d39f9-01ef-3515-7ef5-abfffd62d786@gmail.com>
References: <1508725896-6092-1-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1508725896-6092-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

QW0gMjMuMTAuMjAxNyB1bSAwNDozMSBzY2hyaWViIE1vbmsgTGl1Ogo+IENoYW5nZS1JZDogSTZk
MDZiODFiOGI4OTQ3NzVlNTVlNDk1ZTk2ZjNjOTk5YjgzY2YyYmUKPiBTaWduZWQtb2ZmLWJ5OiBN
b25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL3R0
bS90dG1fYm8uYyB8IDUgKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9i
by5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwo+IGluZGV4IDk3MTI1Y2IuLjNjOWMw
ZDkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKPiBAQCAtNDYwLDggKzQ2MCwxMSBAQCBzdGF0aWMg
dm9pZCB0dG1fYm9fY2xlYW51cF9yZWZzX29yX3F1ZXVlKHN0cnVjdCB0dG1fYnVmZmVyX29iamVj
dCAqYm8pCj4gICAJCWlmIChyZXNlcnZhdGlvbl9vYmplY3RfdGVzdF9zaWduYWxlZF9yY3UoJmJv
LT50dG1fcmVzdiwgdHJ1ZSkpIHsKPiAgIAkJCXR0bV9ib19kZWxfZnJvbV9scnUoYm8pOwo+ICAg
CQkJc3Bpbl91bmxvY2soJmdsb2ItPmxydV9sb2NrKTsKPiAtCQkJaWYgKGJvLT5yZXN2ICE9ICZi
by0+dHRtX3Jlc3YpCj4gKwkJCWlmIChiby0+cmVzdiAhPSAmYm8tPnR0bV9yZXN2KSB7Cj4gICAJ
CQkJcmVzZXJ2YXRpb25fb2JqZWN0X3VubG9jaygmYm8tPnR0bV9yZXN2KTsKPiArCQkJCXJlc2Vy
dmF0aW9uX29iamVjdF9maW5pKCZiby0+dHRtX3Jlc3YpOwo+ICsJCQl9Cj4gKwo+ICAgCQkJdHRt
X2JvX2NsZWFudXBfbWVtdHlwZV91c2UoYm8pOwo+ICAgCQkJcmV0dXJuOwo+ICAgCQl9CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
