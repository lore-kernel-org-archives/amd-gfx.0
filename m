From: Mathias =?ISO-8859-1?Q?Fr=F6hlich?= <Mathias.Froehlich-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix reference counting for struct
 dc_sink.
Date: Fri, 22 Feb 2019 06:52:25 +0100
Message-ID: <2882587.xoYNfK9vrO@notebook.internal>
References: <20190210101301.5940-1-Mathias.Froehlich@gmx.net>
 <19888642.k12MuCASrQ@notebook.internal>
 <cc434ed7-ee0d-6cea-3a9c-0dab37115b8e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cc434ed7-ee0d-6cea-3a9c-0dab37115b8e-5C7GfCeVMHo@public.gmane.org>
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
To: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>
Cc: "Daenzer, Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

R29vZCBNb3JuaW5nLAoKT24gVGh1cnNkYXksIDIxIEZlYnJ1YXJ5IDIwMTkgMjI6MDA6NDAgQ0VU
IExpLCBTdW4gcGVuZyAoTGVvKSB3cm90ZToKPiAKPiBPbiAyMDE5LTAyLTIwIDEyOjI0IGEubS4s
IE1hdGhpYXMgRnLDtmhsaWNoIHdyb3RlOgo+ID4gSGksCj4gPiAKPiA+IHBpbmc/Cj4gPiAuLi4g
dG8gdGhlIGRjIGZvbGtzPwo+ID4gCj4gPiBiZXN0Cj4gPiBNYXRoaWFzCj4gCj4gSGkgTWF0aGlh
cywKPiAKPiBTb3JyeSBmb3IgdGhlIHdhaXQsIGNoYW5nZSBsb29rcyBnb29kIHRvIG1lLgo+IAo+
IFJldmlld2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KPiAuLi5hbmQgbWVyZ2Vk
Lgo+IAo+IFRoYW5rcyBmb3IgY2xlYW5pbmcgdGhpcyB1cC4KPiBMZW8KVGhhbmtzIQoKTWF0aGlh
cwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
