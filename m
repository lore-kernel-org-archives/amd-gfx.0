From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use the num_rings variable for checking vce
 rings
Date: Thu, 12 Jan 2017 13:20:02 +0100
Message-ID: <1c0d2dcf-be43-7b40-125c-f483bce413a0@vodafone.de>
References: <1484169185-11012-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1484169185-11012-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMTEuMDEuMjAxNyB1bSAyMjoxMyBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBEaWZmZXJlbmNl
IGZhbWlsaWVzIG1heSBoYXZlIGRpZmZlcmVudCBudW1iZXJzIG9mIHJpbmdzLiBVc2UKPiB0aGUg
dmFyaWFibGUgcmF0aGVyIHRoYW4gYSBoYXJkY29kZWQgbnVtYmVyLgo+Cj4gU2lnbmVkLW9mZi1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgo+IC0tLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgfCA0ICsrLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+IGluZGV4IDI5ZDZkODQuLjNmZjI5MjkgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+IEBAIC03NSwxMCArNzUsMTAg
QEAgaW50IGFtZGdwdV9jc19nZXRfcmluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMy
IGlwX3R5cGUsCj4gICAJCSpvdXRfcmluZyA9ICZhZGV2LT51dmQucmluZzsKPiAgIAkJYnJlYWs7
Cj4gICAJY2FzZSBBTURHUFVfSFdfSVBfVkNFOgo+IC0JCWlmIChyaW5nIDwgMil7Cj4gKwkJaWYg
KHJpbmcgPCBhZGV2LT52Y2UubnVtX3JpbmdzKXsKPiAgIAkJCSpvdXRfcmluZyA9ICZhZGV2LT52
Y2UucmluZ1tyaW5nXTsKPiAgIAkJfSBlbHNlIHsKPiAtCQkJRFJNX0VSUk9SKCJvbmx5IHR3byBW
Q0UgcmluZ3MgYXJlIHN1cHBvcnRlZFxuIik7Cj4gKwkJCURSTV9FUlJPUigib25seSAlZCBWQ0Ug
cmluZ3MgYXJlIHN1cHBvcnRlZFxuIiwgYWRldi0+dmNlLm51bV9yaW5ncyk7Cj4gICAJCQlyZXR1
cm4gLUVJTlZBTDsKPiAgIAkJfQo+ICAgCQlicmVhazsKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
