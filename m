From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/ttm: Add dummy *populate_and_*map_pages()
 functions
Date: Thu, 24 Aug 2017 13:52:22 +0200
Message-ID: <e1728599-204b-89f5-dffd-b396ee4db057@vodafone.de>
References: <20170824104818.9973-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170824104818.9973-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjQuMDguMjAxNyB1bSAxMjo0OCBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBPbiBub24gSU9U
TEIvSU9NTVUgYnVpbGRzIHRoZXNlIGZ1bmN0aW9ucyB3b3VsZCBiZSB1bmRlZmluZWQuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+Cj4gLS0tCj4g
ICBpbmNsdWRlL2RybS90dG0vdHRtX3BhZ2VfYWxsb2MuaCB8IDEwICsrKysrKysrKysKPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9k
cm0vdHRtL3R0bV9wYWdlX2FsbG9jLmggYi9pbmNsdWRlL2RybS90dG0vdHRtX3BhZ2VfYWxsb2Mu
aAo+IGluZGV4IDg2OTU5MThlYTYyOS4uNDQwMGMwODE2OWNkIDEwMDY0NAo+IC0tLSBhL2luY2x1
ZGUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5oCj4gKysrIGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9w
YWdlX2FsbG9jLmgKPiBAQCAtMTE2LDYgKzExNiwxNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdHRt
X2RtYV91bnBvcHVsYXRlKHN0cnVjdCB0dG1fZG1hX3R0ICp0dG1fZG1hLAo+ICAgCQkJCSAgICAg
IHN0cnVjdCBkZXZpY2UgKmRldikKPiAgIHsKPiAgIH0KPiArCj4gK3N0YXRpYyBpbmxpbmUgaW50
IHR0bV9wb3B1bGF0ZV9hbmRfbWFwX3BhZ2VzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHR0
bV9kbWFfdHQgKnR0KQo+ICt7Cj4gKwlyZXR1cm4gMDsKCldlIHNob3VsZCBwcm9iYWJseSByZXR1
cm4gLUVOT01FTSBoZXJlLCBqdXN0IGxpa2UgdGhlIGR1bW15IAp0dG1fZG1hX3BvcHVsYXRlKCkg
ZG9lcy4KCldpdGggdGhhdCBmaXhlZCB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgCjxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LgoKUmVnYXJkcywKQ2hyaXN0aWFu
LgoKPiArfQo+ICsKPiArc3RhdGljIGlubGluZSB2b2lkIHR0bV91bm1hcF9hbmRfdW5wb3B1bGF0
ZV9wYWdlcyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCB0dG1fZG1hX3R0ICp0dCkKPiArewo+
ICt9Cj4gKwo+ICAgI2VuZGlmCj4gICAKPiAgICNlbmRpZgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
