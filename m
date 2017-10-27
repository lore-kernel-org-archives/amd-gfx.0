From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] drm/amd/display: Don't print error when bo_pin is
 interrupted
Date: Fri, 27 Oct 2017 18:13:12 +0200
Message-ID: <7d14cf4f-2f5c-e16d-50b3-d53fff96ab27@gmail.com>
References: <20171027155114.21528-1-harry.wentland@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171027155114.21528-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org

QW0gMjcuMTAuMjAxNyB1bSAxNzo1MSBzY2hyaWViIEhhcnJ5IFdlbnRsYW5kOgo+IHYyOiBBbHNv
IGRvbid0IHByaW50IGZvciBFUkVTVEFSVFNZUyBvciBFQUdBSU4KPiB2MzogQmVzdCBwcmFjdGlj
ZSBpcyB0byBvbmx5IGlnbm9yZSBFUkVTVEFSVFNZUwo+Cj4gU2lnbmVkLW9mZi1ieTogSGFycnkg
V2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KCj4gLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMyArKy0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IGluZGV4IGNm
MTU3MDFmMjA4ZC4uODEzMzcxMWQ4NWI5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gQEAgLTI5NDQsNyArMjk0NCw4IEBA
IHN0YXRpYyBpbnQgZG1fcGxhbmVfaGVscGVyX3ByZXBhcmVfZmIoc3RydWN0IGRybV9wbGFuZSAq
cGxhbmUsCj4gICAJYW1kZ3B1X2JvX3VucmVzZXJ2ZShyYm8pOwo+ICAgCj4gICAJaWYgKHVubGlr
ZWx5KHIgIT0gMCkpIHsKPiAtCQlEUk1fRVJST1IoIkZhaWxlZCB0byBwaW4gZnJhbWVidWZmZXJc
biIpOwo+ICsJCWlmIChyICE9IC1FUkVTVEFSVFNZUykpCj4gKwkJCURSTV9FUlJPUigiRmFpbGVk
IHRvIHBpbiBmcmFtZWJ1ZmZlciB3aXRoIGVycm9yICVkXG4iLCByKTsKPiAgIAkJcmV0dXJuIHI7
Cj4gICAJfQo+ICAgCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
