From: Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/atomic: Save flip flags in drm_plane_state
Date: Mon, 16 Jan 2017 18:21:32 -0200
Message-ID: <20170116202132.GH16017@joana>
References: <1484581498-32309-1-git-send-email-Andrey.Grodzovsky@amd.com>
 <1484581498-32309-2-git-send-email-Andrey.Grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484581498-32309-2-git-send-email-Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org

SGkgQW5kcmV5LAoKMjAxNy0wMS0xNiBBbmRyZXkgR3JvZHpvdnNreSA8QW5kcmV5Lkdyb2R6b3Zz
a3lAYW1kLmNvbT46Cgo+IEFsbG93cyB1c2luZyBhdG9taWMgZmxpcCBoZWxwZXJzIGZvciBkcml2
ZXJzCj4gdXNpbmcgQVNZTkMgZmxpcC4KPiBSZW1vdmUgQVNZTkNfRkxJUCByZXN0cmljdGlvbiBp
biBoZWxwZXJzIGFuZAo+IGNhY2hlcyB0aGUgcGFnZSBmbGlwIGZsYWdzIGluIGRybV9wbGFuZV9z
dGF0ZQo+IHRvIGJlIHVzZWQgaW4gdGhlIGxvdyBsZXZlbCBkcml2ZXJzLgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPgo+IC0t
LQo+ICBkcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pY19oZWxwZXIuYyB8IDEwICsrKy0tLS0tLS0K
PiAgaW5jbHVkZS9kcm0vZHJtX3BsYW5lLmggICAgICAgICAgICAgfCAgOCArKysrKysrKwo+ICAy
IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4gCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljX2hlbHBlci5jIGIvZHJpdmVycy9n
cHUvZHJtL2RybV9hdG9taWNfaGVscGVyLmMKPiBpbmRleCBhNGU1NDc3Li5mODNkYzQzIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljX2hlbHBlci5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2RybV9hdG9taWNfaGVscGVyLmMKPiBAQCAtMjczNyw3ICsyNzM3LDggQEAg
c3RhdGljIGludCBwYWdlX2ZsaXBfY29tbW9uKAo+ICAJCQkJc3RydWN0IGRybV9hdG9taWNfc3Rh
dGUgKnN0YXRlLAo+ICAJCQkJc3RydWN0IGRybV9jcnRjICpjcnRjLAo+ICAJCQkJc3RydWN0IGRy
bV9mcmFtZWJ1ZmZlciAqZmIsCj4gLQkJCQlzdHJ1Y3QgZHJtX3BlbmRpbmdfdmJsYW5rX2V2ZW50
ICpldmVudCkKPiArCQkJCXN0cnVjdCBkcm1fcGVuZGluZ192YmxhbmtfZXZlbnQgKmV2ZW50LAo+
ICsJCQkJdWludDMyX3QgZmxhZ3MpCgpEaWQgeW91IGJ1aWxkIHRoaXMgcGF0Y2g/IEl0IGlzIGNo
YW5naW5nIHRoZSBzaWduYXR1cmUgb2YKcGFnZV9mbGlwX2NvbW1vbigpIGJ1dCBubyBjaGFuZ2Vz
IHRvIHRoZSBjYWxsZXJzLgoKR3VzdGF2bwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
