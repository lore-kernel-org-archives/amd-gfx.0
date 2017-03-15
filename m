From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx6: drop gds unrefs
Date: Wed, 15 Mar 2017 15:22:02 +0100
Message-ID: <77a7d943-61f5-9883-6a41-e73b0c171db1@vodafone.de>
References: <1489586194-13113-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489586194-13113-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMTUuMDMuMjAxNyB1bSAxNDo1NiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBMZWZ0b3ZlciBm
cm9tIGdmeDcgY29kZS4gIGdmeDYgbmV2ZXIgc2V0cyB1cCB0aGUgZ2RzIGJ1ZmZlcnMKPiBpbiB0
aGUgZmlyc3QgcGxhY2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPiBmb3IgdGhlIHNlcmllcy4KCj4gLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjZfMC5jIHwgNCAtLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwg
NCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjZfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYwo+IGlu
ZGV4IDcyNTlkZWQuLjRjNDg3NGYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y2XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
Nl8wLmMKPiBAQCAtMzMwOCwxMCArMzMwOCw2IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y2XzBfc3dfZmlu
aSh2b2lkICpoYW5kbGUpCj4gICAJaW50IGk7Cj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7Cj4gICAKPiAtCWFtZGdwdV9ib191
bnJlZigmYWRldi0+Z2RzLm9hX2dmeF9ibyk7Cj4gLQlhbWRncHVfYm9fdW5yZWYoJmFkZXYtPmdk
cy5nd3NfZ2Z4X2JvKTsKPiAtCWFtZGdwdV9ib191bnJlZigmYWRldi0+Z2RzLmdkc19nZnhfYm8p
Owo+IC0KPiAgIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4Lm51bV9nZnhfcmluZ3M7IGkrKykK
PiAgIAkJYW1kZ3B1X3JpbmdfZmluaSgmYWRldi0+Z2Z4LmdmeF9yaW5nW2ldKTsKPiAgIAlmb3Ig
KGkgPSAwOyBpIDwgYWRldi0+Z2Z4Lm51bV9jb21wdXRlX3JpbmdzOyBpKyspCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
