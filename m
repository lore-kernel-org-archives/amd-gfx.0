From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Implement ttm_bo_driver.access_vram
 callback
Date: Thu, 13 Jul 2017 17:23:27 -0400
Message-ID: <57fd2f8d-7e80-8661-1c57-741bd33a11d8@amd.com>
References: <1499980105-7721-1-git-send-email-Felix.Kuehling@amd.com>
 <1499980105-7721-2-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1499980105-7721-2-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTctMDctMTMgMDU6MDggUE0sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uaAo+IEBAIC03OCw2ICs3OCw4IEBAIGludCBhbWRncHVf
ZmlsbF9idWZmZXIoc3RydWN0IGFtZGdwdV9ibyAqYm8sCj4gIAkJCXN0cnVjdCBkbWFfZmVuY2Ug
KipmZW5jZSk7Cj4gIAo+ICBpbnQgYW1kZ3B1X21tYXAoc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVj
dCB2bV9hcmVhX3N0cnVjdCAqdm1hKTsKPiAraW50IGFtZGdwdV9ib19tbWFwKHN0cnVjdCBmaWxl
ICpmaWxwLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwKPiArCQkgICBzdHJ1Y3QgdHRtX2Jv
X2RldmljZSAqYmRldik7Cj4gIGJvb2wgYW1kZ3B1X3R0bV9pc19ib3VuZChzdHJ1Y3QgdHRtX3R0
ICp0dG0pOwo+ICBpbnQgYW1kZ3B1X3R0bV9iaW5kKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAq
Ym8sIHN0cnVjdCB0dG1fbWVtX3JlZyAqYm9fbWVtKTsKPiAgaW50IGFtZGdwdV90dG1fcmVjb3Zl
cl9nYXJ0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKT29wcywgdGhpcyBpcyBhIHJlbW5h
bnQgZnJvbSB0aGUgb2xkIHZlcnNpb24gdGhhdCBoYWNrZWQgdGhlIHR0bV92bV9vcHMKaW4gYW1k
Z3B1LiBJJ2xsIHJlbW92ZSB0aGlzIGJlZm9yZSBJIHN1Ym1pdC4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
