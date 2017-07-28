From: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use 256 bit buffers for all wb allocations
Date: Fri, 28 Jul 2017 23:34:18 +0100
Message-ID: <5e9447b6-eecb-4546-4d98-1674255b1964@gmail.com>
References: <1501258540-9950-1-git-send-email-alexander.deucher@amd.com>
 <b589c629-dc1e-0cd4-80e5-aa6b1aa910ab@gmail.com>
 <CADnq5_PumnBBWeb0j2KyxSURtizKrMUrY4FWH1TKn4wX9L+Gxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PumnBBWeb0j2KyxSURtizKrMUrY4FWH1TKn4wX9L+Gxw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QWxleCBEZXVjaGVyIHdyb3RlOgo+IE9uIEZyaSwgSnVsIDI4LCAyMDE3IGF0IDY6MDggUE0sIEFu
ZHkgRnVybmlzcyA8YWRmLmxpc3RzQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IEFsZXggRGV1Y2hlciB3
cm90ZToKPj4+Cj4+PiBNYXkgd2FzdGUgYSBiaXQgb2YgbWVtb3J5LCBidXQgc2ltcGxpZmllcyB0
aGUgaW50ZXJmYWNlCj4+PiBzaWduaWZpY2FudGx5Lgo+Pgo+Pgo+PiBDYW4ndCBib290IHRvbmdh
IHdpdGggdGhpcyAodGVzdGluZyA0LjE0LXdpcCkKPiAKPiBTaG91bGQgYmUgZml4ZWQgd2l0aCB0
aGlzIHBhdGNoLgoKWWVzLCBPSyB3aXRoIHRoYXQsIHRoYW5rcy4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
