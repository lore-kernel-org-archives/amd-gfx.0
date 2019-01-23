From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 04/20] drm/amd/display: Know what a pageflip is
Date: Wed, 23 Jan 2019 10:20:03 +0100
Message-ID: <2f86ea47-260e-388a-9166-0e965aef676a@daenzer.net>
References: <1548181746-23783-1-git-send-email-sunpeng.li@amd.com>
 <1548181746-23783-5-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1548181746-23783-5-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: sunpeng.li-5C7GfCeVMHo@public.gmane.org
Cc: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOS0wMS0yMiA3OjI4IHAubS4sIHN1bnBlbmcubGlAYW1kLmNvbSB3cm90ZToKPiBGcm9t
OiBEYXZpZCBGcmFuY2lzIDxEYXZpZC5GcmFuY2lzQGFtZC5jb20+Cj4gCj4gW1doeV0KPiBXZSB3
ZXJlIGFzc3VtaW5nIHRoYXQgYW55IGNvbW1pdCB3aXRoIGFsbG93X21vZGVzZXQgPT0gZmFsc2UK
PiB3YXMgYSBwYWdlZmxpcC4gIFRoaXMgd2FzIGFnYWluc3QgZHJtIGludGVudGlvbiBhbmQgb25s
eQo+IHdvcmtlZCBieSBzaGVlciBsdWNrCj4gCj4gW0hvd10KPiBBIHBhZ2VmbGlwIGlzIHRoZSBj
aGFuZ2UgZnJvbSBvbmUgZnJhbWVidWZmZXIgdG8gYW5vdGhlcgo+IAo+IFNpZ25lZC1vZmYtYnk6
IERhdmlkIEZyYW5jaXMgPERhdmlkLkZyYW5jaXNAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogSGFy
cnkgV2VudGxhbmQgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IE5pY2hv
bGFzIEthemxhdXNrYXMgPE5pY2hvbGFzLkthemxhdXNrYXNAYW1kLmNvbT4KPiBBY2tlZC1ieTog
TGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Cj4gCj4gWy4uLl0KPiAgCj4gQEAgLTUwMTAsNyAr
NTAxMiw4IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9jb21taXRfcGxhbmVzKHN0cnVjdCBkcm1f
YXRvbWljX3N0YXRlICpzdGF0ZSwKPiAgCQlpZiAoIW5ld19jcnRjX3N0YXRlLT5hY3RpdmUpCj4g
IAkJCWNvbnRpbnVlOwo+ICAKPiAtCQlwZmxpcF9uZWVkZWQgPSAhc3RhdGUtPmFsbG93X21vZGVz
ZXQ7Cj4gKwkJcGZsaXBfbmVlZGVkID0gb2xkX3BsYW5lX3N0YXRlLT5mYiAmJgo+ICsJCQkob2xk
X3BsYW5lX3N0YXRlLT5mYiAhPSBuZXdfcGxhbmVfc3RhdGUtPmZiIHx8IGFmYi0+YWRkcmVzcyAh
PSBvbGRfYWZiLT5hZGRyZXNzKTsKClRoZSBzZWNvbmQgY2hlY2sgYWZ0ZXIgdGhlIHx8IGNhbm5v
dCBiZSB0cnVlIGlmIG9sZF9wbGFuZV9zdGF0ZS0+ZmIgPT0KbmV3X3BsYW5lX3N0YXRlLT5mYiwg
c28gaXQncyBkZWFkIGNvZGUuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUg
ZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVy
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
