From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 05/14] drm/amdgpu: Fix definition of
 KFD_CIK_SDMA_QUEUE_OFFSET
Date: Tue, 5 Dec 2017 10:15:46 +0200
Message-ID: <CAFCwf10bdqFhzhsRoJHuf7-fHujTcQNzt-jpzj7Voa0TDOnGDQ@mail.gmail.com>
References: <1511825396-24579-1-git-send-email-Felix.Kuehling@amd.com>
 <1511825396-24579-6-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1511825396-24579-6-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBOb3YgMjgsIDIwMTcgYXQgMToyOSBBTSwgRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+IHdyb3RlOgo+IFRoaXMgY291bnRzIHRoZSBxdWV1ZSBvZmZzZXQgaW4g
cmVnaXN0ZXIgaW5kZXgsIG5vdCByZWdpc3RlciBhZGRyZXNzLgo+Cj4gU2lnbmVkLW9mZi1ieTog
RmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2Npa2QuaCB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvY2lrZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrZC5oCj4g
aW5kZXggNmE5ZTM4YS4uY2VlNmU4YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9jaWtkLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWtkLmgK
PiBAQCAtNTYyLDcgKzU2Miw3IEBACj4gICNkZWZpbmUgICAgICAgIFBSSVZBVEVfQkFTRSh4KSAo
KHgpIDw8IDApIC8qIHNjcmF0Y2ggKi8KPiAgI2RlZmluZSAgICAgICAgU0hBUkVEX0JBU0UoeCkg
ICgoeCkgPDwgMTYpIC8qIExEUyAqLwo+Cj4gLSNkZWZpbmUgS0ZEX0NJS19TRE1BX1FVRVVFX09G
RlNFVCAgICAgIDB4MjAwCj4gKyNkZWZpbmUgS0ZEX0NJS19TRE1BX1FVRVVFX09GRlNFVCAobW1T
RE1BMF9STEMxX1JCX0NOVEwgLSBtbVNETUEwX1JMQzBfUkJfQ05UTCkKPgo+ICAvKiB2YWxpZCBm
b3IgYm90aCBERUZBVUxUX01UWVBFIGFuZCBBUEUxX01UWVBFICovCj4gIGVudW0gewo+IC0tCj4g
Mi43LjQKPgoKVGhpcyBwYXRjaCBpczoKQWNrZWQtYnk6IE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJh
eUBnbWFpbC5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
