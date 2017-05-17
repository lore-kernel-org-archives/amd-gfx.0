From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix re-program vm invalidate eng address
 range for gfxhub on resume
Date: Wed, 17 May 2017 15:43:47 +0800
Message-ID: <591BFF33.2010303@amd.com>
References: <1495006729-17310-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1495006729-17310-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex
 Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

QnkgdGhpcyBjaGFuZ2UsIEkgc3VnZ2VzdCB0byByZW1vdmUgbW1odWIvZ2Z4aHViX3YxXzBfaXBf
ZnVuY3MgYW5kIHRoZWlyIApJUCBibG9jaywgdW5pZnkgdGhlbSB0byBnbWMgaXAgYmxvY2ssIHRo
aXMgd2F5IHdlIGNhbm5vdCBsb3N0IHNldHRpbmcgCndoZW4gcmVzdW1lIGJhY2suCgpSZWdhcmRz
LApEYXZpZCBaaG91CgpPbiAyMDE35bm0MDXmnIgxN+aXpSAxNTozOCwgSHVhbmcgUnVpIHdyb3Rl
Ogo+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gLS0tCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjFfMC5jIHwgMiArLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YxXzAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92MV8wLmMKPiBpbmRleCAwMDUwNzVmLi40MTMxMzUxNCAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjFfMC5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YxXzAuYwo+IEBAIC0zNjgs
NyArMzY4LDcgQEAgc3RhdGljIGludCBnZnhodWJfdjFfMF9zdXNwZW5kKHZvaWQgKmhhbmRsZSkK
PiAgIAo+ICAgc3RhdGljIGludCBnZnhodWJfdjFfMF9yZXN1bWUodm9pZCAqaGFuZGxlKQo+ICAg
ewo+IC0JcmV0dXJuIDA7Cj4gKwlyZXR1cm4gZ2Z4aHViX3YxXzBfaHdfaW5pdChoYW5kbGUpOwo+
ICAgfQo+ICAgCj4gICBzdGF0aWMgYm9vbCBnZnhodWJfdjFfMF9pc19pZGxlKHZvaWQgKmhhbmRs
ZSkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
