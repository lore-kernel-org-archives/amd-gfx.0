From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/7] drm/amdgpu: update the shadow PD together with the
 real one
Date: Thu, 29 Sep 2016 14:10:02 +0200
Message-ID: <5ad68770-f356-33b6-a3d0-7cec66c56ca3@vodafone.de>
References: <1475135557-11537-1-git-send-email-deathsimple@vodafone.de>
 <1475135557-11537-2-git-send-email-deathsimple@vodafone.de>
 <57ECDC65.40203@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <57ECDC65.40203-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjkuMDkuMjAxNiB1bSAxMToxOCBzY2hyaWViIHpob3VjbTE6Cj4KPgo+IE9uIDIwMTblubQw
OeaciDI55pelIDE1OjUyLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiAtICAgIGlmIChjb3Vu
dCkKPj4gKyAgICBpZiAoY291bnQpIHsKPj4gKyAgICAgICAgaWYgKHZtLT5wYWdlX2RpcmVjdG9y
eS1zaGFkb3cpCj4gRm9yZ2V0IGNvbXBpbGUgZml4IHRvIGFtZW5kPwoKVXBzLCBubyB0aGF0IGFj
dHVhbGx5IGNvbXBpbGVzIGJlY2F1c2Ugd2UgaGF2ZSBhIGxvY2FsIHZhcmlhYmxlIG5hbWVkIAoi
c2hhZG93IiAoYW5kIGJ5IGNvaW5jaWRlbnQgYWN0dWFsbHkgZG9lcyB3aGF0IGl0IHNob3VsZCBk
bykuCgpBbnl3YXkgY2xlYXJseSBhIHR5cG8uIENhbiBJIGdldCB5b3VyIHJiIGZvciB0aGUgc2Vy
aWVzPwoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IFJlZ2FyZHMsCj4gRGF2aWQgWmhvdQo+PiAr
IGFtZGdwdV92bV9kb19zZXRfcHRlcygmcGFyYW1zLCBsYXN0X3NoYWRvdywgbGFzdF9wdCwKPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgY291bnQsIGluY3IsIEFNREdQVV9QVEVfVkFMSUQp
Owo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
