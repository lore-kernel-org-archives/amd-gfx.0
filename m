From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amd/amdgpu: init allow_reserved_eviction and resv
 when create a new bo
Date: Wed, 13 Dec 2017 11:00:14 +0100
Message-ID: <2591c505-20e2-3e2b-9df3-6b9fa5473511@amd.com>
References: <1513142278-4294-1-git-send-email-Hongbo.He@amd.com>
 <1513142278-4294-2-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513142278-4294-2-git-send-email-Hongbo.He-5C7GfCeVMHo@public.gmane.org>
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
To: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTMuMTIuMjAxNyB1bSAwNjoxNyBzY2hyaWViIFJvZ2VyIEhlOgo+IENoYW5nZS1JZDogSTBj
NjU3MWMyYTY0ZTZjNWJkYWQ4MGNjYmNjY2I0MGViYTFjMjBiNGUKPiBTaWduZWQtb2ZmLWJ5OiBS
b2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+CgpXZSBzaG91bGQgc3VwcGx5IHRoZSByZXN2IG9i
amVjdCBpbiBhbWRncHVfY3NfYm9fdmFsaWRhdGUoKSBhcyB3ZWxsLCBvciAKb3RoZXJ3aXNlIHRo
ZSBkZWxldGVkIG9iamVjdCBoYW5kbGluZyB3b24ndCB3b3JrIGFzIGRlc2lyZWQgYW55IG1vcmUu
CgpBcGFydCBmcm9tIHRoYXQgbG9va3MgZ29vZCB0byBtZS4KCkNocmlzdGlhbi4KCj4gLS0tCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgfCAyICstCj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPiBpbmRleCBkYzBhOGJlLi43Yzdm
NTZmNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2Jq
ZWN0LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMK
PiBAQCAtMzI3LDcgKzMyNyw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2JvX2RvX2NyZWF0ZShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkJCSAgICAgICB1aW50NjRfdCBpbml0X3ZhbHVl
LAo+ICAgCQkJICAgICAgIHN0cnVjdCBhbWRncHVfYm8gKipib19wdHIpCj4gICB7Cj4gLQlzdHJ1
Y3QgdHRtX29wZXJhdGlvbl9jdHggY3R4ID0geyAha2VybmVsLCBmYWxzZSB9Owo+ICsJc3RydWN0
IHR0bV9vcGVyYXRpb25fY3R4IGN0eCA9IHsgIWtlcm5lbCwgZmFsc2UsIHRydWUsIHJlc3YgfTsK
PiAgIAlzdHJ1Y3QgYW1kZ3B1X2JvICpibzsKPiAgIAllbnVtIHR0bV9ib190eXBlIHR5cGU7Cj4g
ICAJdW5zaWduZWQgbG9uZyBwYWdlX2FsaWduOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
