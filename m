From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: check domain sanity in
 amdgpu_bo_pin_restricted()
Date: Thu, 18 Aug 2016 10:10:08 +0200
Message-ID: <b7f08d9c-875c-86e0-05f0-6ffebfc7b858@vodafone.de>
References: <1471498619-7497-1-git-send-email-Flora.Cui@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471498619-7497-1-git-send-email-Flora.Cui-5C7GfCeVMHo@public.gmane.org>
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
To: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTguMDguMjAxNiB1bSAwNzozNiBzY2hyaWViIEZsb3JhIEN1aToKPiBhYm9ydCBpZiB0aGUg
Ym8gaXMgcGluZWQgdG8gb3RoZXIgZG9tYWluIGFscmVhZHkKPgo+IENoYW5nZS1JZDogSTBlOGVi
M2UwYWYwZmFkMWVkYWY2NDcwNTAzOTllNWEzNjIyNmE1ZDkKPiBTaWduZWQtb2ZmLWJ5OiBGbG9y
YSBDdWkgPEZsb3JhLkN1aUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9yIHRoZSB3aG9sZSAKc2VyaWVzLgoKPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDUgKysrKysK
PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPiBpbmRleCA0ZDA4NGVlLi4wYTBmM2NiIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+IEBAIC01MjAs
NiArNTIwLDExIEBAIGludCBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQoc3RydWN0IGFtZGdwdV9i
byAqYm8sIHUzMiBkb21haW4sCj4gICAJCXJldHVybiAtRUlOVkFMOwo+ICAgCj4gICAJaWYgKGJv
LT5waW5fY291bnQpIHsKPiArCQl1aW50MzJfdCBtZW1fdHlwZSA9IGJvLT50Ym8ubWVtLm1lbV90
eXBlOwo+ICsKPiArCQlpZiAoZG9tYWluICE9IGFtZGdwdV9tZW1fdHlwZV90b19kb21haW4obWVt
X3R5cGUpKQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4gICAJCWJvLT5waW5fY291bnQrKzsK
PiAgIAkJaWYgKGdwdV9hZGRyKQo+ICAgCQkJKmdwdV9hZGRyID0gYW1kZ3B1X2JvX2dwdV9vZmZz
ZXQoYm8pOwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
