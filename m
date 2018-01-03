From: Tom Stellard <tstellar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: PCIe3 atomics requirement for amdkfd
Date: Wed, 3 Jan 2018 06:56:56 -0800
Message-ID: <a5d6072b-6fea-f161-3773-50f58766ed45@redhat.com>
References: <c2c34443-9ba1-661b-476d-b657a7ddfe85@redhat.com>
 <3f7e6fed-8668-b469-8813-e6677cb980ca@gmail.com>
Reply-To: tstellar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3f7e6fed-8668-b469-8813-e6677cb980ca-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Felix_K=c3=bchling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>

T24gMTIvMjMvMjAxNyAwNzo0MCBBTSwgRmVsaXggS8O8aGxpbmcgd3JvdGU6Cj4gQXMgSSB1bmRl
cnN0YW5kIGl0LCBpdCB3b3VsZCByZXF1aXJlIGNoYW5nZXMgaW4gdGhlIFJPQ3IgUnVudGltZSBh
bmQgaW4KPiB0aGUgZmlybXdhcmUgKE1FQyBtaWNyb2NvZGUpLiBJdCBhbHNvIGNoYW5nZXMgdGhl
IHByb2dyYW1taW5nIG1vZGVsLCBzbwo+IGl0IG1heSBhZmZlY3QgY2VydGFpbiBhcHBsaWNhdGlv
bnMgb3IgaGlnaGVyIGxldmVsIGxhbmd1YWdlIHJ1bnRpbWVzCj4gdGhhdCByZWx5IG9uIGF0b21p
YyBvcGVyYXRpb25zLgo+IAoKSG93IGRvZXMgdGhlIE1FQyBtaWNyb2NvZGUga25vdyB0aGF0IGl0
IGlzIHJ1bm5pbmcgYSBST0NtIHdvcmtsb2FkIGFzIG9wcG9zZWQKdG8gYSBncmFwaGljcyB3b3Jr
bG9hZCB0aGF0IGRvZXNuJ3QgcmVxdWlyZSBQQ0llMyBhdG9taWNzLiAgSXMgdGhlcmUgYSBzcGVj
aWZpYwpjb25maWd1cmF0aW9uIGJpdCB0aGF0IGlzIHNldCB0byBpbmRpY2F0ZSB0aGUgUk9DbSBw
cm9ncmFtbWluZyBtb2RlbCBpcyBuZWVkZWQ/CgotVG9tCgo+IFJlZ2FyZHMsCj4gICBGZWxpeAo+
IAo+IAo+IEFtIDE5LjEyLjIwMTcgdW0gMTY6MDQgc2NocmllYiBUb20gU3RlbGxhcmQ6Cj4+IEhp
LAo+Pgo+PiBIb3cgaGFyZCBvZiBhIHJlcXVpcmVtZW50IGlzIFBDSWUzIGF0b21pY3MgZm9yIGRH
UFVzIHdpdGggdGhlIGFtZGtmZAo+PiBrZXJuZWwgZHJpdmVyPyAgSXMgaXQgcG9zc2libGUgdG8g
bWFrZSBtb2RpZmljYXRpb25zIHRvIHRoZSBydW50aW1lL2tlcm5lbAo+PiBkcml2ZXIgdG8gZHJv
cCB0aGlzIHJlcXVpcmVtZW50Pwo+Pgo+PiAtVG9tCj4+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+IAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
