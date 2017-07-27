From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Support IOMMU on Raven
Date: Thu, 27 Jul 2017 11:38:07 +0200
Message-ID: <e8a9027f-097d-d533-eaa5-6dbef85784ad@vodafone.de>
References: <1501102004-22847-1-git-send-email-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1501102004-22847-1-git-send-email-Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
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
To: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjYuMDcuMjAxNyB1bSAyMjo0NiBzY2hyaWViIFlvbmcgWmhhbzoKPiBXZSBhY2hpZXZlZCB0
aGF0IGJ5IHNldHRpbmcgdGhlIFBURXMgdG8gMiAodGhlIFNZU1RFTSBiaXQgaXMgc2V0KSB3aGVu
Cj4gdGhlIGNvcnJlc3BvbmRpbmcgYWRkcmVzc2VzIGFyZSBub3Qgb2NjdXBpZWQgYnkgZ3B1IGRy
aXZlciBhbGxvY2F0ZWQKPiBidWZmZXJzLgo+Cj4gQ2hhbmdlLUlkOiBJOTk1YzExYzdhMjViZGFm
N2ExNjcwMGQ5ZTA4YThmZTI4N2Q0OTQxNwo+IFNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9u
Zy5aaGFvQGFtZC5jb20+CgpbU05JUF0KCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9vYmplY3QuaAo+IGluZGV4IDgzM2IxNzIuLjQyNzEyNDMgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCj4gQEAgLTEzMiwxNCArMTMyLDE2IEBA
IGludCBhbWRncHVfYm9fY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCQkJ
ICAgIGJvb2wga2VybmVsLCB1MzIgZG9tYWluLCB1NjQgZmxhZ3MsCj4gICAJCQkgICAgc3RydWN0
IHNnX3RhYmxlICpzZywKPiAgIAkJCSAgICBzdHJ1Y3QgcmVzZXJ2YXRpb25fb2JqZWN0ICpyZXN2
LAo+IC0JCQkgICAgc3RydWN0IGFtZGdwdV9ibyAqKmJvX3B0cik7Cj4gKwkJCSAgICBzdHJ1Y3Qg
YW1kZ3B1X2JvICoqYm9fcHRyLAo+ICsJCQkgICAgdWludDY0X3QgaW5pdF92YWx1ZSk7ClR3byBj
b21tZW50cyBoZXJlOiBUaGUgbmV3IHBhcmFtZXRlciBpbml0X3ZhbHVlIHNob3VsZCBjb21lIGJl
Zm9yZSAKYm9fcHRyLCBjYXVzZSBib19wdHIgaXMgdGhlIHJlc3VsdCBvZiB0aGUgZnVuY3Rpb24u
IEFuZCBwbGVhc2Ugc3BsaXQgdXAgCnRoYXQgY2hhbmdlIGludG8gYSBzZXBhcmF0ZSBwYXRjaC4K
CkFwYXJ0IGZyb20gdGhhdCB0aGUgY2hhbmdlIGxvb2tzIGdvb2QgdG8gbWUsCkNocmlzdGlhbi4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
