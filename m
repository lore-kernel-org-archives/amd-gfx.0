From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amdgpu: add IOCTL interface for per VM BOs v3
Date: Wed, 30 Aug 2017 18:55:45 -0400
Message-ID: <5ec19bf2-75a2-91f2-e3d7-aeb5719f53e7@amd.com>
References: <1504105209-1558-1-git-send-email-deathsimple@vodafone.de>
 <1504105209-1558-3-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1504105209-1558-3-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0wOC0zMCAxMTowMCBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHJpbWUuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wcmltZS5jCj4gQEAgLTEzNiw3ICsxMzYsOCBAQCBz
dHJ1Y3QgZG1hX2J1ZiAqYW1kZ3B1X2dlbV9wcmltZV9leHBvcnQoc3RydWN0IGRybV9kZXZpY2Ug
KmRldiwKPiAgewo+ICAJc3RydWN0IGFtZGdwdV9ibyAqYm8gPSBnZW1fdG9fYW1kZ3B1X2JvKGdv
YmopOwo+ICAKPiAtCWlmIChhbWRncHVfdHRtX3R0X2dldF91c2VybW0oYm8tPnRiby50dG0pKQo+
ICsJaWYgKGFtZGdwdV90dG1fdHRfZ2V0X3VzZXJtbShiby0+dGJvLnR0bSkgfHwKPiArCSAgICBi
by0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9WTV9BTFdBWVNfVkFMSUQpCj4gIAkJcmV0dXJu
IEVSUl9QVFIoLUVQRVJNKTsKPiAgCj4gIAlyZXR1cm4gZHJtX2dlbV9wcmltZV9leHBvcnQoZGV2
LCBnb2JqLCBmbGFncyk7CgpJcyB0aGlzIGxpbWl0YXRpb24gbmVjZXNzYXJ5PyBJZiBpdCB3ZXJl
bid0IGZvciB0aGlzLCBJJ2QgdXNlIHBlci1WTSBCT3MKZm9yIEtGRCwgYmVjYXVzZSB3ZSBhbHdh
eXMgbmVlZCB0byB2YWxpZGF0ZSBhbGwgb3VyIEJPcyB3aGVuIHdlIHJlc3RvcmUKZnJvbSBhbiBl
dmljdGlvbiBhbnl3YXkuIEJ1dCB3ZSBuZWVkIHRvIGJlIGFibGUgdG8gc3VwcG9ydCBidWZmZXIK
c2hhcmluZyBhdCB0aGUgc2FtZSB0aW1lLiBBbmQgd2UgZG9uJ3Qga25vdyB3aGljaCBidWZmZXJz
IGFuIGFwcGxpY2F0aW9uCnBsYW5zIHRvIHNoYXJlZCBhdCBhbGxvY2F0aW9uIHRpbWUuCgpFaXRo
ZXIgd2F5LCB3ZSBjb3VsZCBhZGRyZXNzIHRoaXMgbGF0ZXIuIFRoaXMgcGF0Y2ggaXMgUmV2aWV3
ZWQtYnk6CkZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKUmVnYXJkcywK
ICBGZWxpeAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
