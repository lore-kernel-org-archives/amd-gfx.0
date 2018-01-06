From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Failing S3 resume since "Add missing irqflags tracing to
 native_load_gs_index()"
Date: Sat, 6 Jan 2018 09:55:53 -0500
Message-ID: <54e8303c-47e7-40a6-6b70-d7fd2abd3462@amd.com>
References: <e57b5775-d7f2-a89c-f007-41b4db704251@amd.com>
 <62B74215-776F-4DB0-A316-FCE56E1328F0@amacapital.net>
 <84ec8c27-77ea-4915-aabb-657225194e3a@amd.com>
 <0D266FAA-2C99-4944-81D1-8CBE140A5D26@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0D266FAA-2C99-4944-81D1-8CBE140A5D26-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
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
Cc: Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, Josh Poimboeuf <jpoimboe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, marta.lofstedt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, "Kirill A. Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

T24gMjAxOC0wMS0wNSAwNjowNyBQTSwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOgo+IAo+IAo+PiBP
biBKYW4gNSwgMjAxOCwgYXQgMTo1MSBQTSwgSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5k
QGFtZC5jb20+IHdyb3RlOgo+Pgo+Pj4gT24gMjAxOC0wMS0wNSAwNDoyOCBQTSwgQW5keSBMdXRv
bWlyc2tpIHdyb3RlOgo+Pj4gSXQncyBhIGtub3duIGlzc3VlLCBhbmQgaXQgc2hvdWxkIGJlIGZp
eGVkIGluIG5ld2VyIC1yYyBrZXJuZWxzLgo+Pj4KPj4KPj4gSSdtIHN0aWxsIHNlZWluZyB0aGlz
IG9uIHY0LjE1LXJjNi4gV2lsbCBJIG5lZWQgcmM3IG9yIHRoZSBsYXRlc3QgeDg2IG1lcmdlcyBp
biBsaW51cydzIG1hc3Rlcj8KPj4KPiAKPiBObywgaXQgc2hvdWxkIGJlIGZpbmUgaW4gLXJjNi4g
IEkgZG9uJ3Qgc3VwcG9zZSB5b3UgY291bGQgdHJ5IGJpc2VjdGluZyBidXQgcmV2ZXJ0aW5nIHRo
ZSBuYXRpdmVfbG9hZF9nc19pbmRleCBjaGFuZ2Ugb24gZWFjaCBpdGVyYXRpb24/CgooZml4aW5n
IHVwIHRoZSBhbWQtZ2Z4IGFkZHJlc3MpCgpJJ2xsIGdpdmUgdGhhdCBhIHRyeSBvbiBNb25kYXkg
d2hlbiBJJ20gYmFjayBhdCB3b3JrLgoKSGFycnkKCj4gCj4+IFRoYW5rcywKPj4gSGFycnkKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
