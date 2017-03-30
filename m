From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 1/6] drm/ttm: cleanup and optimize ttm_bo_mem_compat
Date: Thu, 30 Mar 2017 15:38:52 +0900
Message-ID: <0aeb9046-86c6-f14f-490e-cbf74079e107@daenzer.net>
References: <1490792146-2218-1-git-send-email-deathsimple@vodafone.de>
 <1490792146-2218-2-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1490792146-2218-2-git-send-email-deathsimple@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjkvMDMvMTcgMDk6NTUgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gRnJvbTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IAo+IE5vIG5lZWQgdG8g
aW1wbGVtZW50IHRoZSBzYW1lIGxvZ2ljIHR3aWNlLiBBbHNvIGNoZWNrIGlmIHRoZSBidXN5IHBs
YWNlbWVudHMKPiBhcmUgaWRlbnRpY2FsIHRvIHRoZSBhbHJlYWR5IHNjYW5uZWQgcGxhY2VtZW50
cyBiZWZvcmUgY2hlY2tpbmcgdGhlbS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpbLi4uXQoKPiBAQCAtMTA3Nyw2ICsxMDY1
LDIzIEBAIGJvb2wgdHRtX2JvX21lbV9jb21wYXQoc3RydWN0IHR0bV9wbGFjZW1lbnQgKnBsYWNl
bWVudCwKPiAgCQkgICAgKCpuZXdfZmxhZ3MgJiBtZW0tPnBsYWNlbWVudCAmIFRUTV9QTF9NQVNL
X01FTSkpCj4gIAkJCXJldHVybiB0cnVlOwo+ICAJfQo+ICsJcmV0dXJuIGZhbHNlOwo+ICt9Cj4g
Kwo+ICtib29sIHR0bV9ib19tZW1fY29tcGF0KHN0cnVjdCB0dG1fcGxhY2VtZW50ICpwbGFjZW1l
bnQsCj4gKwkJICAgICAgIHN0cnVjdCB0dG1fbWVtX3JlZyAqbWVtLAo+ICsJCSAgICAgICB1aW50
MzJfdCAqbmV3X2ZsYWdzKQo+ICt7Cj4gKwlpZiAodHRtX2JvX3BsYWNlc19jb21wYXQocGxhY2Vt
ZW50LT5wbGFjZW1lbnQsIHBsYWNlbWVudC0+bnVtX3BsYWNlbWVudCwKPiArCQkJCSBtZW0sIG5l
d19mbGFncykpCj4gKwkJcmV0dXJuIHRydWU7Cj4gKwo+ICsJaWYgKChwbGFjZW1lbnQtPmJ1c3lf
cGxhY2VtZW50ICE9IHBsYWNlbWVudC0+cGxhY2VtZW50IHx8Cj4gKwkgICAgIHBsYWNlbWVudC0+
bnVtX2J1c3lfcGxhY2VtZW50ICE9IHBsYWNlbWVudC0+bnVtX3BsYWNlbWVudCkgJiYKCgkgICAg
IHBsYWNlbWVudC0+bnVtX2J1c3lfcGxhY2VtZW50ID4gcGxhY2VtZW50LT5udW1fcGxhY2VtZW50
KSAmJgoKPwoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3Qg
ICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
