From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Failing S3 resume since "Add missing irqflags tracing to
 native_load_gs_index()"
Date: Fri, 19 Jan 2018 12:18:47 -0500
Message-ID: <859de65b-a5ac-e0e7-99cb-10d70248b6d5@amd.com>
References: <e57b5775-d7f2-a89c-f007-41b4db704251@amd.com>
 <62B74215-776F-4DB0-A316-FCE56E1328F0@amacapital.net>
 <84ec8c27-77ea-4915-aabb-657225194e3a@amd.com>
 <0D266FAA-2C99-4944-81D1-8CBE140A5D26@amacapital.net>
 <54e8303c-47e7-40a6-6b70-d7fd2abd3462@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <54e8303c-47e7-40a6-6b70-d7fd2abd3462-5C7GfCeVMHo@public.gmane.org>
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
To: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Cc: Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, marta.lofstedt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Josh Poimboeuf <jpoimboe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, "Kirill A. Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

T24gMjAxOC0wMS0wNiAwOTo1NSBBTSwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4gT24gMjAxOC0w
MS0wNSAwNjowNyBQTSwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOgo+Pgo+Pgo+Pj4gT24gSmFuIDUs
IDIwMTgsIGF0IDE6NTEgUE0sIEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29t
PiB3cm90ZToKPj4+Cj4+Pj4gT24gMjAxOC0wMS0wNSAwNDoyOCBQTSwgQW5keSBMdXRvbWlyc2tp
IHdyb3RlOgo+Pj4+IEl0J3MgYSBrbm93biBpc3N1ZSwgYW5kIGl0IHNob3VsZCBiZSBmaXhlZCBp
biBuZXdlciAtcmMga2VybmVscy4KPj4+Pgo+Pj4KPj4+IEknbSBzdGlsbCBzZWVpbmcgdGhpcyBv
biB2NC4xNS1yYzYuIFdpbGwgSSBuZWVkIHJjNyBvciB0aGUgbGF0ZXN0IHg4NiBtZXJnZXMgaW4g
bGludXMncyBtYXN0ZXI/Cj4+Pgo+Pgo+PiBObywgaXQgc2hvdWxkIGJlIGZpbmUgaW4gLXJjNi4g
IEkgZG9uJ3Qgc3VwcG9zZSB5b3UgY291bGQgdHJ5IGJpc2VjdGluZyBidXQgcmV2ZXJ0aW5nIHRo
ZSBuYXRpdmVfbG9hZF9nc19pbmRleCBjaGFuZ2Ugb24gZWFjaCBpdGVyYXRpb24/Cj4gCj4gKGZp
eGluZyB1cCB0aGUgYW1kLWdmeCBhZGRyZXNzKQo+IAo+IEknbGwgZ2l2ZSB0aGF0IGEgdHJ5IG9u
IE1vbmRheSB3aGVuIEknbSBiYWNrIGF0IHdvcmsuCgpBcG9sb2dpZXMgZm9yIHRoZSB2ZXJ5IGxh
dGUgcmVzcG9uc2UuIEkgbW9zdGx5IGJsYW1lIHRoZSBmbHUuCgpBbnl3YXlzLCB0aGluZ3MgYXJl
IHdvcmtpbmcgbm93LiBUZXN0ZWQgcmM1LCByYzYsIGFuZCByYzgrIGFuZCBhbGwgbG9vayBnb29k
LgoKTm90IHN1cmUgd2h5IEkgc2F3IGlzc3VlcyB3aXRoIHJjNiBiZWZvcmUuIEkgbXVzdCd2ZSBt
aXNzZWQgc29tZXRoaW5nLgoKSGFycnkKCj4gCj4gSGFycnkKPiAKPj4KPj4+IFRoYW5rcywKPj4+
IEhhcnJ5Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cj4g
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
