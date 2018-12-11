From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix stub function name
Date: Tue, 11 Dec 2018 09:24:57 +0100
Message-ID: <35532370-a2eb-1885-91a4-3bb62e60d3ad@gmail.com>
References: <1544477327-21625-1-git-send-email-Felix.Kuehling@amd.com>
 <0b6312a0-d876-eb4c-ac4b-9c70ad083338@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0b6312a0-d876-eb4c-ac4b-9c70ad083338-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>

QWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCkFt
IDEwLjEyLjE4IHVtIDIyOjQ2IHNjaHJpZWIgR3JvZHpvdnNreSwgQW5kcmV5Ogo+IEFja2VkLWJ5
OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KPgo+IEFuZHJl
eQo+Cj4KPiBPbiAxMi8xMC8yMDE4IDA0OjI5IFBNLCBLdWVobGluZywgRmVsaXggd3JvdGU6Cj4+
IFRoaXMgZnVuY3Rpb24gd2FzIHJlbmFtZWQgaW4gYSBwcmV2aW91cyBjb21taXQuIFVwZGF0ZSB0
aGUgc3R1Ygo+PiBmdW5jdGlvbiBuYW1lIGZvciBidWlsZHMgd2l0aCBDT05GSUdfSFNBX0FNRCBk
aXNhYmxlZC4KPj4KPj4gRml4ZXM6IDYyZjY1ZDNjYjM0YSAoImRybS9hbWRncHU6IEFkZCBLRkQg
VlJBTSBsaW1pdCBjaGVja2luZyIpCj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+PiAtLS0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2FtZGtmZC5jIHwgMiArLQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmQuYwo+PiBpbmRleCAzOWY3YzhjLi4yZGZhZjE1IDEwMDY0NAo+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4+IEBAIC01ODYsNyArNTg2
LDcgQEAgYm9vbCBhbWRrZmRfZmVuY2VfY2hlY2tfbW0oc3RydWN0IGRtYV9mZW5jZSAqZiwgc3Ry
dWN0IG1tX3N0cnVjdCAqbW0pCj4+ICAgIAlyZXR1cm4gZmFsc2U7Cj4+ICAgIH0KPj4gICAgCj4+
IC12b2lkIGFtZGdwdV9hbWRrZmRfdW5yZXNlcnZlX3N5c3RlbV9tZW1vcnlfbGltaXQoc3RydWN0
IGFtZGdwdV9ibyAqYm8pCj4+ICt2b2lkIGFtZGdwdV9hbWRrZmRfdW5yZXNlcnZlX21lbW9yeV9s
aW1pdChzdHJ1Y3QgYW1kZ3B1X2JvICpibykKPj4gICAgewo+PiAgICB9Cj4+ICAgIAo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWls
aW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
