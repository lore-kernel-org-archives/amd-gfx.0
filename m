From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/soc15: drop dead function
Date: Wed, 12 Jul 2017 09:44:29 +0200
Message-ID: <11dd9e11-f8a4-7eab-d2c1-429dccfc80bf@vodafone.de>
References: <1499814009-28657-1-git-send-email-alexander.deucher@amd.com>
 <59658F60.2040708@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <59658F60.2040708-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

WWVhaCwganVzdCBhIHJlYmFzaW5nIGFydGlmYWN0LgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCkFtIDEyLjA3LjIwMTcgdW0gMDQ6NTQg
c2NocmllYiB6aG91Y20xOgo+IFJldmlld2VkLWJ5OiBDaHVubWluZyBaaG91IDxkYXZpZDEuemhv
dUBhbWQuY29tPgo+Cj4gT24gMjAxN+W5tDA35pyIMTLml6UgMDc6MDAsIEFsZXggRGV1Y2hlciB3
cm90ZToKPj4gTWF5YmUgYSBsZWZ0b3ZlciBmcm9tIGJyaW5ndXA/Cj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPj4gLS0tCj4+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyB8IDcgLS0tLS0tLQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCA3IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc29jMTUuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
b2MxNS5jCj4+IGluZGV4IGRkNThkZTkuLjlkZmYyOTQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMTUuYwo+PiBAQCAtNTc4LDEzICs1NzgsNiBAQCBzdGF0aWMgdWludDMyX3Qgc29j
MTVfZ2V0X3Jldl9pZChzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+ICAgICAgICAg
ICByZXR1cm4gbmJpb192Nl8xX2dldF9yZXZfaWQoYWRldik7Cj4+ICAgfQo+PiAgIC0KPj4gLWlu
dCBnbWNfdjlfMF9tY193YWl0X2Zvcl9pZGxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+
PiAtewo+PiAtICAgIC8qIHRvIGJlIGltcGxlbWVudGVkIGluIE1DIElQKi8KPj4gLSAgICByZXR1
cm4gMDsKPj4gLX0KPj4gLQo+PiAgIHN0YXRpYyB2b2lkIHNvYzE1X2ZsdXNoX2hkcChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKPj4gICB7Cj4+ICAgICAgIGlmIChhZGV2LT5mbGFncyAmIEFN
RF9JU19BUFUpCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
