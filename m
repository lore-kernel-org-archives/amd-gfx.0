From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/6] drm/amdgpu:don't check soft_reset for sriov
Date: Wed, 18 Oct 2017 11:10:18 +0200
Message-ID: <6c8fee64-0eba-b1f5-b475-428fbbe1fcbf@gmail.com>
References: <1508316505-8506-1-git-send-email-Monk.Liu@amd.com>
 <1508316505-8506-6-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1508316505-8506-6-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

QW0gMTguMTAuMjAxNyB1bSAxMDo0OCBzY2hyaWViIE1vbmsgTGl1Ogo+IENoYW5nZS1JZDogSWFm
ZTI5NGFlYTY2YWUwYzE0MGFmMDYyZWM3ODMyMWMyMmE3NGU2MTUKPiBTaWduZWQtb2ZmLWJ5OiBN
b25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KCiMxIGFuZCAjNCBpbiB0aGlzIHNlcmllcyBoYXZl
IG15IHJiLgoKQ2FuJ3Qgc2F5IG11Y2ggYWJvdXQgdGhlIHJlc3QsIGJ1dCBmZWVsIGZyZWUgdG8g
YWRkIG15IEFja2VkLWJ5IHRvIHRoZW0uCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+IC0tLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMyArKysKPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBpbmRleCBmZWM2MGJjOS4uZWUzODQ2YyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtMjY5OSw2ICsy
Njk5LDkgQEAgc3RhdGljIGJvb2wgYW1kZ3B1X2NoZWNrX3NvZnRfcmVzZXQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCj4gICAJaW50IGk7Cj4gICAJYm9vbCBhc2ljX2hhbmcgPSBmYWxzZTsK
PiAgIAo+ICsJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkKPiArCQlyZXR1cm4gdHJ1ZTsKPiAr
Cj4gICAJZm9yIChpID0gMDsgaSA8IGFkZXYtPm51bV9pcF9ibG9ja3M7IGkrKykgewo+ICAgCQlp
ZiAoIWFkZXYtPmlwX2Jsb2Nrc1tpXS5zdGF0dXMudmFsaWQpCj4gICAJCQljb250aW51ZTsKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
