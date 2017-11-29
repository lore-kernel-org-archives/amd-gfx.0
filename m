From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] drm/radeon: Clean up rest of amdkfd support
Date: Wed, 29 Nov 2017 19:30:58 +0100
Message-ID: <2abe185e-7539-0e36-56a5-29d021dab755@gmail.com>
References: <20171129172453.4953-1-michel@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171129172453.4953-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjkuMTEuMjAxNyB1bSAxODoyNCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IEZyb206IE1p
Y2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9yIHRoZSBzZXJpZXMuCgo+
Cj4gVGhlIGZpcnN0IGZvdXIgcGF0Y2hlcyBhcmUgbW9zdGx5IHN0cmFpZ2h0IHJldmVydHMgb2Yg
Y2hhbmdlcyB3aGljaAo+IHdlcmUgbWFkZSBmb3IgYW1ka2ZkIHN1cHBvcnQsIHBhdGNoIDUgY2xl
YW5zIHVwIGEgbGVmdG92ZXIgZGVmaW5lLgo+Cj4gTWljaGVsIETDpG56ZXIgKDUpOgo+ICAgIFJl
dmVydCAiZHJtL3JhZGVvbjogYWRkaW5nIHN5bmNocm9uaXphdGlvbiBmb3IgR1JCTSBHRlgiCj4g
ICAgUmV2ZXJ0ICJkcm0vcmFkZW9uOiBSZXBvcnQgZG9vcmJlbGwgY29uZmlndXJhdGlvbiB0byBh
bWRrZmQiCj4gICAgUmV2ZXJ0ICJkcm0vcmFkZW9uL2NpazogRG9uJ3QgdG91Y2ggaW50IG9mIHBp
cGVzIDEtNyIKPiAgICBSZXZlcnQgImRybS9yYWRlb246IHJlZHVjZSBudW1iZXIgb2YgZnJlZSBW
TUlEcyBhbmQgcGlwZXMgaW4gS1YiCj4gICAgZHJtL3JhZGVvbjogUmVtb3ZlIEtGRF9DSUtfU0RN
QV9RVUVVRV9PRkZTRVQKPgo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuYyAgICAgICAg
ICAgfCAxMTQgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL2Npa19yZWcuaCAgICAgICB8ICAgMiAtCj4gICBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbi5oICAgICAgICB8ICAgNiAtLQo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fZGV2aWNlLmMgfCAgMzIgLS0tLS0tLS0tCj4gICA0IGZpbGVzIGNoYW5nZWQsIDgx
IGluc2VydGlvbnMoKyksIDczIGRlbGV0aW9ucygtKQo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
