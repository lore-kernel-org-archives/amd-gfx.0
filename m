From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 7/9] drm/amdgpu:block kms open during gpu_reset
Date: Thu, 26 Oct 2017 09:18:18 +0200
Message-ID: <46bc9872-0bd7-c2b7-4879-6cab5789f252@gmail.com>
References: <1508923343-24404-1-git-send-email-Monk.Liu@amd.com>
 <1508923343-24404-8-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1508923343-24404-8-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

TkFLLCB3aHkgdGhlIGhlY2sgc2hvdWxkIHdlIGRvIHRoaXM/IEl0IHdvdWxkIGp1c3QgYmxvY2sg
YWxsIG5ldyAKcHJvY2Vzc2VzIGZyb20gdXNpbmcgdGhlIGRldmljZS4KCkNocmlzdGlhbi4KCkFt
IDI1LjEwLjIwMTcgdW0gMTE6MjIgc2NocmllYiBNb25rIExpdToKPiBDaGFuZ2UtSWQ6IEliZGIw
ZWE5ZTM3NjlkNTcyZmJiYzEzYmJmMWVmNzNmMWFmMmFiN2JlCj4gU2lnbmVkLW9mZi1ieTogTW9u
ayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfa21zLmMgfCAzICsrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9r
bXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwo+IGluZGV4IDRh
OWY3NDkuLmMxNTVjZTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ttcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2tt
cy5jCj4gQEAgLTgxMyw2ICs4MTMsOSBAQCBpbnQgYW1kZ3B1X2RyaXZlcl9vcGVuX2ttcyhzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGVfcHJpdikKPiAgIAlpZiAo
ciA8IDApCj4gICAJCXJldHVybiByOwo+ICAgCj4gKwlpZiAoYWRldi0+aW5fZ3B1X3Jlc2V0KQo+
ICsJCXJldHVybiAtRU5PREVWOwo+ICsKPiAgIAlmcHJpdiA9IGt6YWxsb2Moc2l6ZW9mKCpmcHJp
diksIEdGUF9LRVJORUwpOwo+ICAgCWlmICh1bmxpa2VseSghZnByaXYpKSB7Cj4gICAJCXIgPSAt
RU5PTUVNOwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
