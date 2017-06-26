From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH v2] drm/amdgpu: fix solid screen and hard hang when 2k +
 4k display connected with DP
Date: Mon, 26 Jun 2017 14:32:55 +0000
Message-ID: <BN6PR12MB1652B0EF96EE2252A6B389B3F7DF0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1498479491-31585-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1498479491-31585-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Jiang, Sonny" <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org>, "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Qiao,
 Joe(Markham)" <Joe2.Qiao-5C7GfCeVMHo@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IEh1YW5nIFJ1aSBbbWFpbHRvOnJh
eS5odWFuZ0BhbWQuY29tXQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAyNiwgMjAxNyA4OjE4IEFNCj4g
VG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXI7IEtv
ZW5pZywgQ2hyaXN0aWFuCj4gQ2M6IFdhbmcsIEtlbjsgUWlhbywgSm9lKE1hcmtoYW0pOyBKaWFu
ZywgU29ubnk7IEh1YW4sIEFsdmluOyBIdWFuZywgUmF5Cj4gU3ViamVjdDogW1BBVENIIHYyXSBk
cm0vYW1kZ3B1OiBmaXggc29saWQgc2NyZWVuIGFuZCBoYXJkIGhhbmcgd2hlbiAyayArCj4gNGsg
ZGlzcGxheSBjb25uZWN0ZWQgd2l0aCBEUAo+IAo+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8
cmF5Lmh1YW5nQGFtZC5jb20+CgpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgoKPiAtLS0KPiAKPiBWMSAtPiBWMjoKPiAtIEFkZCBSRUFEX09OQ0UgdG8g
YXZvaWQgY29tcGxpZXIgbWlnaHQgY2F1c2UgdG8gcmVhZCBhcyBwcmV2aW91cyBmZW5jZQo+IHZh
bHVlLgo+IAo+IEkgd2lsbCByZWZpbmUgZmVuY2UgY2hlY2tpbmcgd2l0aCBmZW5jZSBpbnRlcmZh
Y2UgYXQgYW1kZ3B1X2ZlbmNlLmMgYWZ0ZXIgUzMKPiBzdHJlc3MgaXNzdWUgY29tcGxldGVkIGFz
IENocmlzdGlhbidzIHN1Z2dlc3Rpb24uCj4gCj4gVGhhbmtzLAo+IFJheQo+IAo+IC0tLQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCAyICstCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+IGluZGV4IDViZWQ0ODMuLmFmM2M4N2IgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCj4gQEAgLTEzMCw3ICsxMzAs
NyBAQCBwc3BfY21kX3N1Ym1pdF9idWYoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsCj4gIAlyZXQg
PSBwc3BfY21kX3N1Ym1pdChwc3AsIHVjb2RlLCBjbWRfYnVmX21jX2FkZHIsCj4gIAkJCSAgICAg
ZmVuY2VfbWNfYWRkciwgaW5kZXgpOwo+IAo+IC0Jd2hpbGUgKCooKHVuc2lnbmVkIGludCAqKXBz
cC0+ZmVuY2VfYnVmKSAhPSBpbmRleCkgewo+ICsJd2hpbGUgKFJFQURfT05DRSgqKCh1bnNpZ25l
ZCBpbnQgKilwc3AtPmZlbmNlX2J1ZikpIDwgaW5kZXgpIHsKPiAgCQltc2xlZXAoMSk7Cj4gIAl9
Cj4gCj4gLS0KPiAyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
