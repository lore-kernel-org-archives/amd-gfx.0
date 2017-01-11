From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix bug set incorrect value to vce
 register
Date: Wed, 11 Jan 2017 12:51:33 +0100
Message-ID: <646b0b19-1a04-bd4b-ddc8-4b0fb930689c@vodafone.de>
References: <1484106519-10827-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1484106519-10827-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

QW0gMTEuMDEuMjAxNyB1bSAwNDo0OCBzY2hyaWViIFJleCBaaHU6Cj4gQ2hhbmdlLUlkOiBJMTQ5
NTg5NGQwMWNhMTBlNWQ0OTZlNzFmNWQ0YjFhOTNhMTIzMzZmMwo+IFNpZ25lZC1vZmYtYnk6IFJl
eCBaaHUgPFJleC5aaHVAYW1kLmNvbT4KCk5vdCBkZWVwbHkgaW50byBWQ0UgcHJvZ3JhbW1pbmcg
YW55IG1vcmUsIGJ1dCBib3RoIHBhdGNoZXMgbG9vayBsaWtlIAp0aGV5IG1ha2Ugc2Vuc2UgYW5k
IGFyZSBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyAKPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4uCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNlX3YzXzAuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3ZjZV92M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jCj4g
aW5kZXggZTNiYWQ4MmQuLjBhYzQ5ODMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNlX3YzXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zj
ZV92M18wLmMKPiBAQCAtMTc1LDcgKzE3NSw3IEBAIHN0YXRpYyB2b2lkIHZjZV92M18wX3NldF92
Y2Vfc3dfY2xvY2tfZ2F0aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCQlXUkVH
MzIobW1WQ0VfVUVOQ19DTE9DS19HQVRJTkdfMiwgZGF0YSk7Cj4gICAKPiAgIAkJZGF0YSA9IFJS
RUczMihtbVZDRV9VRU5DX1JFR19DTE9DS19HQVRJTkcpOwo+IC0JCWRhdGEgJj0gfjB4ZmZjMDAw
MDA7Cj4gKwkJZGF0YSAmPSB+MHgzZmY7Cj4gICAJCVdSRUczMihtbVZDRV9VRU5DX1JFR19DTE9D
S19HQVRJTkcsIGRhdGEpOwo+ICAgCj4gICAJCWRhdGEgPSBSUkVHMzIobW1WQ0VfVUVOQ19ETUFf
RENMS19DVFJMKTsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
