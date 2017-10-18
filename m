From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/6] drm/amdgpu:reduce wb to 512 slot
Date: Wed, 18 Oct 2017 11:06:36 +0200
Message-ID: <967c8b46-ecdb-216c-5b0f-14eedaac055f@gmail.com>
References: <1508316505-8506-1-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1508316505-8506-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

QW0gMTguMTAuMjAxNyB1bSAxMDo0OCBzY2hyaWViIE1vbmsgTGl1Ogo+IHdpdGggY3VycmVudCBX
QiB1c2FnZSB3ZSBvbmx5IHVzZSA1NyBzbG90cywgc28gNTEyCj4gaXMgZXh0cmVhbWx5IHN1ZmZp
Y2llbnQsIGFuZCByZWR1Y2UgdG8gNTEyIGNhbgo+IG1ha2UgV0IgZml0IGludG8gb25lIHBhZ2Uu
Cj4KPiBDaGFuZ2UtSWQ6IEk0MjYxNjMwNzMxZjEzMmI5YmVjOTFiMDAzN2U5MTQwMzBiNWMwMzFm
Cj4gU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+CgpSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIHwgMiArLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHUuaAo+IGluZGV4IDdlY2ZjNTMuLjQ2OTdiYTIgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHUuaAo+IEBAIC0xMTU1LDcgKzExNTUsNyBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgYW1kZ3B1X3NldF9pYl92YWx1ZShzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCwKPiAg
IC8qCj4gICAgKiBXcml0ZWJhY2sKPiAgICAqLwo+IC0jZGVmaW5lIEFNREdQVV9NQVhfV0IgMTAy
NAkvKiBSZXNlcnZlIGF0IG1vc3QgMTAyNCBXQiBzbG90cyBmb3IgYW1kZ3B1LW93bmVkIHJpbmdz
LiAqLwo+ICsjZGVmaW5lIEFNREdQVV9NQVhfV0IgNTEyCS8qIFJlc2VydmUgYXQgbW9zdCA1MTIg
V0Igc2xvdHMgZm9yIGFtZGdwdS1vd25lZCByaW5ncy4gKi8KPiAgIAo+ICAgc3RydWN0IGFtZGdw
dV93YiB7Cj4gICAJc3RydWN0IGFtZGdwdV9ibwkqd2Jfb2JqOwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
