From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v5 1/2] drm/amd: validate user pitch alignment
Date: Mon, 7 Jan 2019 10:54:03 +0100
Message-ID: <14420828-884e-df3e-3b41-5b87203a20a3@daenzer.net>
References: <20181223215239.173339-2-yuzhao@google.com>
 <20181230010021.196990-1-yuzhao@google.com>
 <75d5f1d6-b259-6944-6ee0-8cc68cb1af0e@daenzer.net>
 <20190107040038.GA180037@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190107040038.GA180037-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
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
To: Yu Zhao <yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: David Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Daniel Stone <daniels-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wMS0wNyA1OjAwIGEubS4sIFl1IFpoYW8gd3JvdGU6Cj4gT24gVGh1LCBKYW4gMDMs
IDIwMTkgYXQgMDU6MzM6MTlQTSArMDEwMCwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4+IE9uIDIw
MTgtMTItMzAgMjowMCBhLm0uLCBZdSBaaGFvIHdyb3RlOgo+Pj4gVXNlcnNwYWNlIG1heSByZXF1
ZXN0IHBpdGNoIGFsaWdubWVudCB0aGF0IGlzIG5vdCBzdXBwb3J0ZWQgYnkgR1BVLgo+Pj4gU29t
ZSByZXF1ZXN0cyAzMiwgYnV0IEdQVSBpZ25vcmVzIGl0IGFuZCB1c2VzIGRlZmF1bHQgNjQgd2hl
biBjcHAgaXMKPj4+IDQuIElmIEdFTSBvYmplY3QgaXMgYWxsb2NhdGVkIGJhc2VkIG9uIHRoZSBz
bWFsbGVyIGFsaWdubWVudCwgR1BVCj4+PiBETUEgd2lsbCBnbyBvdXQgb2YgYm91bmQuCj4+Pgo+
Pj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2NC4yKwo+Pj4gU2lnbmVkLW9mZi1ieTog
WXUgWmhhbyA8eXV6aGFvQGdvb2dsZS5jb20+Cj4+PiAtLS0KPj4+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jIHwgMTYgKysrKysrKysrKysrKysrKwo+Pj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCj4+PiBpbmRleCAxNWNlN2U2ODFkNjcuLjE2YWY4
MGNjZDBhMCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kaXNwbGF5LmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
aXNwbGF5LmMKPj4+IEBAIC01MjcsNiArNTI3LDIyIEBAIGFtZGdwdV9kaXNwbGF5X3VzZXJfZnJh
bWVidWZmZXJfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCj4+PiAgCXN0cnVjdCBkcm1f
Z2VtX29iamVjdCAqb2JqOwo+Pj4gIAlzdHJ1Y3QgYW1kZ3B1X2ZyYW1lYnVmZmVyICphbWRncHVf
ZmI7Cj4+PiAgCWludCByZXQ7Cj4+PiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZGV2
LT5kZXZfcHJpdmF0ZTsKPj4+ICsJaW50IGNwcCA9IGRybV9mb3JtYXRfcGxhbmVfY3BwKG1vZGVf
Y21kLT5waXhlbF9mb3JtYXQsIDApOwo+Pj4gKwlpbnQgcGl0Y2ggPSBtb2RlX2NtZC0+cGl0Y2hl
c1swXSAvIGNwcDsKPj4+ICsKPj4+ICsJaWYgKHBpdGNoIDwgbW9kZV9jbWQtPndpZHRoKSB7Cj4+
PiArCQlEUk1fREVCVUdfS01TKCJFeHBlY3RpbmcgcGl0Y2goJWQpL2NwcCglZCkgPj0gd2lkdGgo
JWQpXG4iLAo+Pj4gKwkJCSAgICAgIG1vZGVfY21kLT5waXRjaGVzWzBdLCBjcHAsIG1vZGVfY21k
LT53aWR0aCk7Cj4+PiArCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKPj4+ICsJfQo+Pgo+PiBU
aGlzIHNob3VsZCBwb3NzaWJseSBiZSB0ZXN0ZWQgaW4gZHJtX2ludGVybmFsX2ZyYW1lYnVmZmVy
X2NyZWF0ZSBpbnN0ZWFkLgo+IAo+IEl0IHNlZW1zIHRvIG1lIGRybV9mb3JtYXRfaW5mb19taW5f
cGl0Y2goKSBpbiBmcmFtZWJ1ZmZlcl9jaGVjaygpCj4gYWxyZWFkeSBkb2VzIGl0LiBXZSBjb3Vs
ZCBqdXN0IHJlbW92ZSB0aGUgY2hlY2sgaGVyZT8KClllYWgsIGxvb2tzIGxpa2UgdGhhdCBzaG91
bGQgYmUgZmluZS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNp
YXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
