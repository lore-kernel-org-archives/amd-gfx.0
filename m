From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix compile warning in amdgpu_kms.c
Date: Mon, 2 Jan 2017 11:19:17 +0100
Message-ID: <a602c752-2c29-6518-f309-cafdc7979a5a@vodafone.de>
References: <1483349019-28373-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1483349019-28373-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDIuMDEuMjAxNyB1bSAxMDoyMyBzY2hyaWViIFJleCBaaHU6Cj4gd2FybmluZzoKPiBjb21w
YXJpc29uIG9mIGRpc3RpbmN0IHBvaW50ZXIgdHlwZXMgbGFja3MgYSBjYXN0Cj4gICBtaW4oKHNp
emVfdClzaXplLCBiaW9zX3NpemUgLSBiaW9zX29mZnNldCkpCj4KPiBDaGFuZ2UtSWQ6IEliNzdl
YWM1YjE1ZDA5ZDE2OWQyZTk1Y2ZmNzYwOGIzOTVmYjBmNjRjCj4gU2lnbmVkLW9mZi1ieTogUmV4
IFpodSA8UmV4LlpodUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ttcy5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ttcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2tt
cy5jCj4gaW5kZXggMzI3M2Q4Yy4uNDdiYzhlMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfa21zLmMKPiBAQCAtNTYxLDcgKzU2MSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X2luZm9faW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwgc3RydWN0IGRy
bV9maWxlCj4gICAKPiAgIAkJCWJpb3MgPSBhZGV2LT5iaW9zICsgYmlvc19vZmZzZXQ7Cj4gICAJ
CQlyZXR1cm4gY29weV90b191c2VyKG91dCwgYmlvcywKPiAtCQkJCW1pbigoc2l6ZV90KXNpemUs
IGJpb3Nfc2l6ZSAtIGJpb3Nfb2Zmc2V0KSkKPiArCQkJCW1pbihzaXplLCBiaW9zX3NpemUgLSBi
aW9zX29mZnNldCkpCj4gICAJCQkJCT8gLUVGQVVMVCA6IDA7Cj4gICAJCX0KPiAgIAkJZGVmYXVs
dDoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
