From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix null pointer issue in
 amdgpu_cs_wait_any_fence
Date: Thu, 9 Nov 2017 10:05:28 +0100
Message-ID: <0ed1ec89-c411-67af-3ea2-f0359eb73cff@gmail.com>
References: <1510214382-6807-1-git-send-email-Emily.Deng@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1510214382-6807-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
To: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDkuMTEuMjAxNyB1bSAwODo1OSBzY2hyaWViIEVtaWx5IERlbmc6Cj4gVGhlIGFycmF5W2Zp
cnN0XSBtYXkgYmUgbnVsbCB3aGVuIHRoZSBmZW5jZSBoYXMgYWxyZWFkeSBiZWVuIHNpZ25hbGVk
Lgo+Cj4gQlVHOiBTV0RFVi0xMzYyMzkKPgo+IFNpZ25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVt
aWx5LkRlbmdAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2NzLmMgfCA3ICsrKysrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2NzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3Mu
Ywo+IGluZGV4IDM1NGM4NzQuLjE4MmRmMDggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfY3MuYwo+IEBAIC0xNTAyLDggKzE1MDIsMTEgQEAgc3RhdGljIGludCBhbWRncHVf
Y3Nfd2FpdF9hbnlfZmVuY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJbWVtc2V0
KHdhaXQsIDAsIHNpemVvZigqd2FpdCkpOwo+ICAgCXdhaXQtPm91dC5zdGF0dXMgPSAociA+IDAp
Owo+ICAgCXdhaXQtPm91dC5maXJzdF9zaWduYWxlZCA9IGZpcnN0Owo+IC0JLyogc2V0IHJldHVy
biB2YWx1ZSAwIHRvIGluZGljYXRlIHN1Y2Nlc3MgKi8KPiAtCXIgPSBhcnJheVtmaXJzdF0tPmVy
cm9yOwo+ICsKPiArCWlmIChhcnJheVtmaXJzdF0pCj4gKwkJciA9IGFycmF5W2ZpcnN0XS0+ZXJy
b3I7Cj4gKwllbHNlCj4gKwkJciA9IDA7Cj4gICAKPiAgIGVycl9mcmVlX2ZlbmNlX2FycmF5Ogo+
ICAgCWZvciAoaSA9IDA7IGkgPCBmZW5jZV9jb3VudDsgaSsrKQoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
