From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx8: enable cp/rlc ints after we disable
 clockgating
Date: Thu, 16 Mar 2017 12:26:09 -0400
Message-ID: <13e57f0b-5082-e610-fcd4-3aff04899a9a@amd.com>
References: <1489519966-14076-1-git-send-email-alexander.deucher@amd.com>
 <CADnq5_OLYbf8mAfquxfLgSaPfSjRi0f-UQXQbOsAe+2kU1oQjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OLYbf8mAfquxfLgSaPfSjRi0f-UQXQbOsAe+2kU1oQjg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

T24gMTYvMDMvMTcgMTI6MjQgUE0sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBUdWUsIE1hciAx
NCwgMjAxNyBhdCAzOjMyIFBNLCBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4g
d3JvdGU6Cj4+IEV2ZW4gaWYgd2UgZGlzYWJsZSBjbG9ja2dhdGluZywgd2Ugc3RpbGwgbmVlZCB0
byBtYWtlIHN1cmUgdGhlCj4+IGNwL3JsYyBpbnRlcnJ1cHRzIGFyZSBlbmFibGVkIGZvciBwb3dl
cmdhdGluZyB3aGljaCBtaWdodCBzdGlsbAo+PiBiZSBlbmFibGVkLgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4KPiBBbnlvbmU/
CgpIYXZlbid0IGhhZCBhIGNoYW5jZSB0byB0cnkgaXQgb3V0IChvbmx5IG9uZSBkZXZlbCBib2Fy
ZC4uLikuCgpJbiBwcmluY2lwbGUgdGhhdCBzaG91bGQgd29yayBwcm92aWRlZCB0aGlzIGlzIGNh
bGxlZCB3aGVuIENHQ0cgaXMgZGlzYWJsZWQuCgpUb20KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
