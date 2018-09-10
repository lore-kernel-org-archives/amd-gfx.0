From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: move PSP init prior to IH in gpu reset
Date: Mon, 10 Sep 2018 09:07:03 +0200
Message-ID: <8cee1da5-406d-444b-dafb-6b3732616006@gmail.com>
References: <1536559989-19549-1-git-send-email-Emily.Deng@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1536559989-19549-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

QW0gMTAuMDkuMjAxOCB1bSAwODoxMyBzY2hyaWViIEVtaWx5IERlbmc6Cj4gc2luY2Ugd2UgdXNl
IFBTUCB0byBwcm9ncmFtIElIIHJlZ3Mgbm93Cj4KPiBTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8
TW9uay5MaXVAYW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jCj4gaW5kZXggOTM0NzZiOC4uYWNmYzYzZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtMTk1Nyw2ICsxOTU3LDcgQEAgc3RhdGljIGlu
dCBhbWRncHVfZGV2aWNlX2lwX3JlaW5pdF9lYXJseV9zcmlvdihzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiAgIAlzdGF0aWMgZW51bSBhbWRfaXBfYmxvY2tfdHlwZSBpcF9vcmRlcltdID0g
ewo+ICAgCQlBTURfSVBfQkxPQ0tfVFlQRV9HTUMsCj4gICAJCUFNRF9JUF9CTE9DS19UWVBFX0NP
TU1PTiwKPiArCQlBTURfSVBfQkxPQ0tfVFlQRV9QU1AsCj4gICAJCUFNRF9JUF9CTE9DS19UWVBF
X0lILAo+ICAgCX07Cj4gICAKPiBAQCAtMTk4Nyw3ICsxOTg4LDYgQEAgc3RhdGljIGludCBhbWRn
cHVfZGV2aWNlX2lwX3JlaW5pdF9sYXRlX3NyaW92KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQo+ICAgCj4gICAJc3RhdGljIGVudW0gYW1kX2lwX2Jsb2NrX3R5cGUgaXBfb3JkZXJbXSA9IHsK
PiAgIAkJQU1EX0lQX0JMT0NLX1RZUEVfU01DLAo+IC0JCUFNRF9JUF9CTE9DS19UWVBFX1BTUCwK
PiAgIAkJQU1EX0lQX0JMT0NLX1RZUEVfRENFLAo+ICAgCQlBTURfSVBfQkxPQ0tfVFlQRV9HRlgs
Cj4gICAJCUFNRF9JUF9CTE9DS19UWVBFX1NETUEsCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
