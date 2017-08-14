From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] first is incorrect if hit NULL/signaled fence
Date: Mon, 14 Aug 2017 10:12:12 +0200
Message-ID: <74cd845f-b7f0-99dc-e05c-807f65556c83@vodafone.de>
References: <1502449145-24917-1-git-send-email-Monk.Liu@amd.com>
 <1a8970d4-8353-2aac-d536-b7d735a2a951@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1a8970d4-8353-2aac-d536-b7d735a2a951-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTQuMDguMjAxNyB1bSAwMzo1OSBzY2hyaWViIHpob3VjbTE6Cj4KPgo+IE9uIDIwMTflubQw
OOaciDEx5pelIDE4OjU5LCBNb25rIExpdSB3cm90ZToKPj4gRnJvbTogTW9uayBMaXUgPG1vbmsu
bGl1QGFtZC5jb20+Cj4+Cj4+IENoYW5nZS1JZDogSWQ2NWE1YmM1NGRiMDc0ZWE3ODg1MjAzYmIw
OTg2NjVhZmIwNTI0NDgKPj4gU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPG1vbmsubGl1QGFtZC5j
b20+Cj4gUmV2aWV3ZWQtYnk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+CgpS
ZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoK
Pgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyB8IDEg
Kwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgCj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPj4gaW5kZXggNGU3MjY1ZC4uYzQ4YTMyMSAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPj4gQEAgLTEyNzIsNiAr
MTI3Miw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2NzX3dhaXRfYW55X2ZlbmNlKHN0cnVjdCAKPj4g
YW1kZ3B1X2RldmljZSAqYWRldiwKPj4gICAgICAgICAgICAgICBhcnJheVtpXSA9IGZlbmNlOwo+
PiAgICAgICAgICAgfSBlbHNlIHsgLyogTlVMTCwgdGhlIGZlbmNlIGhhcyBiZWVuIGFscmVhZHkg
c2lnbmFsZWQgKi8KPj4gICAgICAgICAgICAgICByID0gMTsKPj4gKyAgICAgICAgICAgIGZpcnN0
ID0gaTsKPj4gICAgICAgICAgICAgICBnb3RvIG91dDsKPj4gICAgICAgICAgIH0KPj4gICAgICAg
fQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
