From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: separate gpu address from bo pin
Date: Tue, 26 Jun 2018 16:28:54 +0800
Message-ID: <5B31F946.6020404@amd.com>
References: <1529992843-649-1-git-send-email-Jerry.Zhang@amd.com>
 <6c63256a-17d2-ee6e-8b3c-2e0a928aeb84@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6c63256a-17d2-ee6e-8b3c-2e0a928aeb84-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDYvMjYvMjAxOCAwMzo0NiBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAxOC0w
Ni0yNiAwODowMCBBTSwgSnVud2VpIFpoYW5nIHdyb3RlOgo+PiBJdCBjb3VsZCBiZSBnb3QgYnkg
YW1kZ3B1X2JvX2dwdV9vZmZzZXQoKSBpZiBuZWVkCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEp1bndl
aSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4KPj4KPj4gWy4uLl0KPj4KPj4gQEAgLTkzMSw3
ICs5MjgsNiBAQCBpbnQgYW1kZ3B1X2JvX3Bpbl9yZXN0cmljdGVkKHN0cnVjdCBhbWRncHVfYm8g
KmJvLCB1MzIgZG9tYWluLAo+PiAgICAqIGFtZGdwdV9ib19waW4gLSBwaW4gYW4gJmFtZGdwdV9i
byBidWZmZXIgb2JqZWN0Cj4+ICAgICogQGJvOiAmYW1kZ3B1X2JvIGJ1ZmZlciBvYmplY3QgdG8g
YmUgcGlubmVkCj4+ICAgICogQGRvbWFpbjogZG9tYWluIHRvIGJlIHBpbm5lZCB0bwo+PiAtICog
QGdwdV9hZGRyOiBHUFUgb2Zmc2V0IG9mIHRoZSAmYW1kZ3B1X2JvIGJ1ZmZlciBvYmplY3QKPj4g
ICAgKgo+PiAgICAqIEEgc2ltcGxlIHdyYXBwZXIgdG8gYW1kZ3B1X2JvX3Bpbl9yZXN0cmljdGVk
KCkuCj4+ICAgICogUHJvdmlkZXMgYSBzaW1wbGVyIEFQSSBmb3IgYnVmZmVycyB0aGF0IGRvIG5v
dCBoYXZlIGFueSBzdHJpY3QgcmVzdHJpY3Rpb25zCj4KPiBUaGlzIGFsc28gbmVlZHMgdG8gYmUg
cmVtb3ZlZCBpbiB0aGUgY29tbWVudCBiZWZvcmUKPiBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQu
IFdpdGggdGhhdCBmaXhlZCwKCkV4YWN0bHksIEkgd2lsbC4KCkplcnJ5Cgo+Cj4gUmV2aWV3ZWQt
Ynk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+Cj4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
