From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/6] drm/ttm: add TTM_PL_FLAG_CONTIGUOUS
Date: Thu, 30 Mar 2017 15:39:02 +0900
Message-ID: <0feb8b91-ce19-4e93-4e9b-6cdd5ded1f8d@daenzer.net>
References: <1490792146-2218-1-git-send-email-deathsimple@vodafone.de>
 <1490792146-2218-4-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490792146-2218-4-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjkvMDMvMTcgMDk6NTUgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gRnJvbTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IAo+IFRoaXMgYWxsb3dz
IGRyaXZlcnMgdG8gc3BlY2lmeSBpZiB0aGV5IG5lZWQgYSBjb250aWd1b3VzIGFsbG9jYXRpb24g
b3Igbm90Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KClsuLi5dCgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS90dG0vdHRt
X3BsYWNlbWVudC5oIGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9wbGFjZW1lbnQuaAo+IGluZGV4IDkz
MmJlMGMuLjQwZjk0N2YgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9kcm0vdHRtL3R0bV9wbGFjZW1l
bnQuaAo+ICsrKyBiL2luY2x1ZGUvZHJtL3R0bS90dG1fcGxhY2VtZW50LmgKPiBAQCAtNjMsNiAr
NjMsNyBAQAo+ICAjZGVmaW5lIFRUTV9QTF9GTEFHX0NBQ0hFRCAgICAgICgxIDw8IDE2KQo+ICAj
ZGVmaW5lIFRUTV9QTF9GTEFHX1VOQ0FDSEVEICAgICgxIDw8IDE3KQo+ICAjZGVmaW5lIFRUTV9Q
TF9GTEFHX1dDICAgICAgICAgICgxIDw8IDE4KQo+ICsjZGVmaW5lIFRUTV9QTF9GTEFHX0NPTlRJ
R1VPVVMJKDEgPDwgMTkpCgpUaGUgdmFsdWUgb24gdGhpcyBsaW5lIGRvZXNuJ3QgbGluZSB1cCwg
YmVjYXVzZSBpdCB1c2VzIGEgdGFiIGluc3RlYWQgb2YKc3BhY2VzLgoKCi0tIApFYXJ0aGxpbmcg
TWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5h
bWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAg
ICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
