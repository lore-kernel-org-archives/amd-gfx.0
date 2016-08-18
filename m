From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/5] drm/amdgpu: fix sdma_v2_4_ring_test_ib
Date: Thu, 18 Aug 2016 09:38:42 +0800
Message-ID: <57B511A2.2000500@amd.com>
References: <1471436784-13252-1-git-send-email-deathsimple@vodafone.de>
 <1471436784-13252-4-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471436784-13252-4-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE25bm0MDjmnIgxN+aXpSAyMDoyNiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBG
cm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4KPiBUeXBv
IGluIGNoZWNraW5nIHRoZSByZXR1cm4gY29kZS4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENodW5taW5n
IFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zZG1hX3YyXzQuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NkbWFfdjJfNC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92Ml80
LmMKPiBpbmRleCBlODIyMjk2Li4yYjEwZTg4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NkbWFfdjJfNC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc2RtYV92Ml80LmMKPiBAQCAtNzE0LDcgKzcxNCw3IEBAIHN0YXRpYyBpbnQgc2RtYV92Ml80
X3JpbmdfdGVzdF9pYihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIGxvbmcgdGltZW91dCkKPiAg
IAkJRFJNX0VSUk9SKCJhbWRncHU6IElCIHRlc3QgdGltZWQgb3V0XG4iKTsKPiAgIAkJciA9IC1F
VElNRURPVVQ7Cj4gICAJCWdvdG8gZXJyMTsKPiAtCX0gZWxzZSBpZiAocikgewo+ICsJfSBlbHNl
IGlmIChyIDwgMCkgewo+ICAgCQlEUk1fRVJST1IoImFtZGdwdTogZmVuY2Ugd2FpdCBmYWlsZWQg
KCVsZCkuXG4iLCByKTsKPiAgIAkJZ290byBlcnIxOwo+ICAgCX0KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
