From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu:256dw is enough for one ib_schedule
Date: Thu, 25 Aug 2016 10:12:10 +0200
Message-ID: <41466125-a69e-07c7-bb18-153c841c1d48@vodafone.de>
References: <1472104695-2177-1-git-send-email-Monk.Liu@amd.com>
 <1472104695-2177-3-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472104695-2177-3-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

V2VsbCB1c2Vyc3BhY2UgaXMgYWxsb3dlZCB0byBzZW5kIGFueSBudW1iZXIgb2YgSUJzIGRvd24g
dG8gdGhpcyBpZiBJIApyZW1lbWJlciBjb3JyZWN0bHkuCgpTbyB3ZSBjbGVhcmx5IG5lZWQgc29t
ZXRoaW5nIGRlcGVuZGluZyBvbiB0aGUgbnVtYmVyIG9mIElCcyBvciByZWplY3QgCnN1Ym1pc3Np
b25zIHdpdGggdG8gbWFueSBJQnMgZWFybGllciBpbiB0aGUgQ1MuCgpPdGhlcndpc2Ugd2UgY2xl
YXJseSBvcGVuIHVwIGEgcG9zc2libGUgcHJvYmxlbSB3aGVyZSB1c2Vyc3BhY2UgY2FuIAp0cmln
Z2VyIGEgcmluZyBvdmVycnVuLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKQW0gMjUuMDguMjAxNiB1
bSAwNzo1OCBzY2hyaWViIE1vbmsgTGl1Ogo+IENoYW5nZS1JZDogSTFlZTMyNTgyNzY4NjhhNzUz
ZTUzNmFlMmQ5YWUxYjEyZTdlYWY3OTEKPiBTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5M
aXVAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9p
Yi5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2li
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+IGluZGV4IDRlNWIy
ZjMuLmI4MjkwNGMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2liLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+
IEBAIC0xNTEsNyArMTUxLDcgQEAgaW50IGFtZGdwdV9pYl9zY2hlZHVsZShzdHJ1Y3QgYW1kZ3B1
X3JpbmcgKnJpbmcsIHVuc2lnbmVkIG51bV9pYnMsCj4gICAJCXJldHVybiAtRUlOVkFMOwo+ICAg
CX0KPiAgIAo+IC0JciA9IGFtZGdwdV9yaW5nX2FsbG9jKHJpbmcsIDI1NiAqIG51bV9pYnMpOwo+
ICsJciA9IGFtZGdwdV9yaW5nX2FsbG9jKHJpbmcsIDI1Nik7Cj4gICAJaWYgKHIpIHsKPiAgIAkJ
ZGV2X2VycihhZGV2LT5kZXYsICJzY2hlZHVsaW5nIElCIGZhaWxlZCAoJWQpLlxuIiwgcik7Cj4g
ICAJCXJldHVybiByOwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
