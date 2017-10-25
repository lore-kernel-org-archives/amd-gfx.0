From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 14/16] drm/amdkfd: increase IH num entries to 8192
Date: Wed, 25 Oct 2017 15:18:43 +0300
Message-ID: <CAFCwf103UKPQVWMOv9sPTXAQ2r=JSoVU7X7xs1hvcD2D0=Ud2A@mail.gmail.com>
References: <1508545400-24338-1-git-send-email-Felix.Kuehling@amd.com>
 <1508545400-24338-15-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1508545400-24338-15-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Andres Rodriguez <andres.rodriguez-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gU2F0LCBPY3QgMjEsIDIwMTcgYXQgMzoyMyBBTSwgRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+IHdyb3RlOgo+IEZyb206IEFuZHJlcyBSb2RyaWd1ZXogPGFuZHJlcy5y
b2RyaWd1ZXpAYW1kLmNvbT4KPgo+IEEgbGFyZ2VyIGJ1ZmZlciB3aWxsIGxldCB1cyBhY2NvbW1v
ZGF0ZSBhcHBsaWNhdGlvbnMgd2l0aCBhIGxhcmdlIGFtb3VudAo+IG9mIHNlbWktc2ltdWx0YW5l
b3VzIGV2ZW50IHNpZ25hbHMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXMgUm9kcmlndWV6IDxh
bmRyZXMucm9kcmlndWV6QGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9pbnRlcnJ1cHQuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2ludGVycnVwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2lu
dGVycnVwdC5jCj4gaW5kZXggZmZiYjkxYS4uYTE0NzI2OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfaW50ZXJydXB0LmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfaW50ZXJydXB0LmMKPiBAQCAtNDUsNyArNDUsNyBAQAo+ICAjaW5j
bHVkZSA8bGludXgva2ZpZm8uaD4KPiAgI2luY2x1ZGUgImtmZF9wcml2LmgiCj4KPiAtI2RlZmlu
ZSBLRkRfSUhfTlVNX0VOVFJJRVMgMTAyNAo+ICsjZGVmaW5lIEtGRF9JSF9OVU1fRU5UUklFUyA4
MTkyCj4KPiAgc3RhdGljIHZvaWQgaW50ZXJydXB0X3dxKHN0cnVjdCB3b3JrX3N0cnVjdCAqKTsK
Pgo+IC0tCj4gMi43LjQKPgoKVGhpcyBwYXRjaCBpczoKQWNrZWQtYnk6IE9kZWQgR2FiYmF5IDxv
ZGVkLmdhYmJheUBnbWFpbC5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
