From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/scheduler: add NULL pointer check for run queue (v2)
Date: Mon, 16 Jul 2018 11:27:11 +0200
Message-ID: <a22b98b1-df9f-438c-d7b4-af6dadda574b@amd.com>
References: <1531733034-22183-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1531733034-22183-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTYuMDcuMjAxOCB1bSAxMToyMyBzY2hyaWViIEp1bndlaSBaaGFuZzoKPiBUbyBjaGVjayBy
cSBwb2ludGVyIGJlZm9yZSBhZGRpbmcgZW50aXR5IGludG8gaXQuCj4gVGhhdCBhdm9pZHMgTlVM
TCBwb2ludGVyIGFjY2VzcyBpbiBzb21lIGNhc2UuCj4KPiB2MjogbW92ZSB0aGUgY2hlY2sgdG8g
Y2FsbGVyCj4KPiBTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFt
ZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxl
ci5jIHwgNSArKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jIGIvZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmMKPiBpbmRleCAxNmJmNDQ2Li5k
YWM3MWUzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvZ3B1X3NjaGVk
dWxlci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmMK
PiBAQCAtNTQ3LDYgKzU0NywxMSBAQCB2b2lkIGRybV9zY2hlZF9lbnRpdHlfcHVzaF9qb2Ioc3Ry
dWN0IGRybV9zY2hlZF9qb2IgKnNjaGVkX2pvYiwKPiAgIAlpZiAoZmlyc3QpIHsKPiAgIAkJLyog
QWRkIHRoZSBlbnRpdHkgdG8gdGhlIHJ1biBxdWV1ZSAqLwo+ICAgCQlzcGluX2xvY2soJmVudGl0
eS0+cnFfbG9jayk7Cj4gKwkJaWYgKCFlbnRpdHktPnJxKSB7Cj4gKwkJCURSTV9FUlJPUigiVHJ5
aW5nIHRvIHB1c2ggdG8gYSBraWxsZWQgZW50aXR5XG4iKTsKPiArCQkJc3Bpbl91bmxvY2soJmVu
dGl0eS0+cnFfbG9jayk7Cj4gKwkJCXJldHVybjsKPiArCQl9Cj4gICAJCWRybV9zY2hlZF9ycV9h
ZGRfZW50aXR5KGVudGl0eS0+cnEsIGVudGl0eSk7Cj4gICAJCXNwaW5fdW5sb2NrKCZlbnRpdHkt
PnJxX2xvY2spOwo+ICAgCQlkcm1fc2NoZWRfd2FrZXVwKHNjaGVkKTsKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
