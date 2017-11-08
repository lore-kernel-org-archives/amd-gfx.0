From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: bypass lru touch for KIQ ring submission
Date: Wed, 8 Nov 2017 10:35:26 +0100
Message-ID: <167cf643-449c-a440-f1af-c3fd3f974c9a@gmail.com>
References: <1510108224-8499-1-git-send-email-Pixel.Ding@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1510108224-8499-1-git-send-email-Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
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
To: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDguMTEuMjAxNyB1bSAwMzozMCBzY2hyaWViIFBpeGVsIERpbmc6Cj4gS0lRIHJpbmcgc3Vi
bWlzc2lvbiBpcyB1c2VkIGZvciByZWdpc3RlciBhY2Nlc3Npbmcgb24gU1JJT1YKPiBWRiB0aGF0
IGNvdWxkIGhhcHBlbiBib3RoIGluIGlycSBlbmFibGVkIGFuZCBpcnEgZGlzYWJsZWQgY2FzZXMu
Cj4gSW52ZXJzaW9uIGxvY2sgY291bGQgaGFwcGVuIG9uIGFkZXYtPnJpbmdfbHJ1X2xpc3RfbG9j
aywgd2hpbGUKPiB0aGlzIG9wZXJhdGlvbiBpcyB1c2VsZXNzIGFuZCBqdXN0IGFkZHMgb3Zlcmhl
YWQgaW4gdGhpcyB1c2UKPiBjYXNlLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGl4ZWwgRGluZyA8UGl4
ZWwuRGluZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmluZy5jIHwgMyArKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmluZy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jpbmcu
Ywo+IGluZGV4IGU1ZWNlMWYuLmE5OGZiYmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yaW5nLmMKPiBAQCAtMTM2LDcgKzEzNiw4IEBAIHZvaWQgYW1kZ3B1X3Jpbmdf
Y29tbWl0KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPiAgIAlpZiAocmluZy0+ZnVuY3MtPmVu
ZF91c2UpCj4gICAJCXJpbmctPmZ1bmNzLT5lbmRfdXNlKHJpbmcpOwo+ICAgCj4gLQlhbWRncHVf
cmluZ19scnVfdG91Y2gocmluZy0+YWRldiwgcmluZyk7Cj4gKwlpZiAocmluZy0+ZnVuY3MtPnR5
cGUgIT0gQU1ER1BVX1JJTkdfVFlQRV9LSVEpCj4gKwkJYW1kZ3B1X3JpbmdfbHJ1X3RvdWNoKHJp
bmctPmFkZXYsIHJpbmcpOwo+ICAgfQo+ICAgCj4gICAvKioKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
