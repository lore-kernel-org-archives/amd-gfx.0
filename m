From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_vm_bo_update param error
Date: Thu, 22 Sep 2016 15:24:56 +0200
Message-ID: <df57e1b4-73c5-f759-739a-e7f9e1069cbd@vodafone.de>
References: <1474515666-24562-1-git-send-email-Flora.Cui@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1474515666-24562-1-git-send-email-Flora.Cui-5C7GfCeVMHo@public.gmane.org>
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
To: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjIuMDkuMjAxNiB1bSAwNTo0MSBzY2hyaWViIEZsb3JhIEN1aToKPiBDaGFuZ2UtSWQ6IEk4
NmRjN2QzZmM0ZDYxOTdiZDEzNTYzYTQyMDcxOGE4NDEyY2U5ZGJjCj4gU2lnbmVkLW9mZi1ieTog
RmxvcmEgQ3VpIDxGbG9yYS5DdWlAYW1kLmNvbT4KCkdvb2QgY2F0Y2guIFRoYXQgY2xlYXJseSBy
ZXN1bHRzIGluIHNvbWUgYWRkaXRpb25hbCBvdmVyaGVhZCBpZiBub3QgCndvcnNlIG90aGVyd2lz
ZS4KClBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nZW0uYwo+IGluZGV4IDk0MTQxNmEuLmE3ZWE5YTMgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4gQEAgLTUyOCw3ICs1MjgsNyBAQCBzdGF0aWMg
dm9pZCBhbWRncHVfZ2VtX3ZhX3VwZGF0ZV92bShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwK
PiAgIAkJZ290byBlcnJvcl91bnJlc2VydmU7Cj4gICAKPiAgIAlpZiAob3BlcmF0aW9uID09IEFN
REdQVV9WQV9PUF9NQVApCj4gLQkJciA9IGFtZGdwdV92bV9ib191cGRhdGUoYWRldiwgYm9fdmEs
ICZib192YS0+Ym8tPnRiby5tZW0pOwo+ICsJCXIgPSBhbWRncHVfdm1fYm9fdXBkYXRlKGFkZXYs
IGJvX3ZhLCBmYWxzZSk7Cj4gICAKPiAgIGVycm9yX3VucmVzZXJ2ZToKPiAgIAl0dG1fZXVfYmFj
a29mZl9yZXNlcnZhdGlvbigmdGlja2V0LCAmbGlzdCk7CgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
