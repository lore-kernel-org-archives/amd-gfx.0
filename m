From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Don't print error when bo_pin is
 interrupted
Date: Thu, 26 Oct 2017 15:47:51 -0400
Message-ID: <12620d6f-894b-64c8-f812-4f46714f5723@amd.com>
References: <20171026194209.12767-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171026194209.12767-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org

CgpPbiAyMDE3LTEwLTI2IDAzOjQyIFBNLCBIYXJyeSBXZW50bGFuZCB3cm90ZToKPiBTaWduZWQt
b2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAzICsr
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
Cj4gaW5kZXggY2YxNTcwMWYyMDhkLi41NTkzZmYwNWQyYTYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiBAQCAtMjk0NCw3
ICsyOTQ0LDggQEAgc3RhdGljIGludCBkbV9wbGFuZV9oZWxwZXJfcHJlcGFyZV9mYihzdHJ1Y3Qg
ZHJtX3BsYW5lICpwbGFuZSwKPiAgIAlhbWRncHVfYm9fdW5yZXNlcnZlKHJibyk7Cj4gICAKPiAg
IAlpZiAodW5saWtlbHkociAhPSAwKSkgewo+IC0JCURSTV9FUlJPUigiRmFpbGVkIHRvIHBpbiBm
cmFtZWJ1ZmZlclxuIik7Cj4gKwkJaWYgKHIgIT0gLUVJTlRSKQo+ICsJCQlEUk1fRVJST1IoIkZh
aWxlZCB0byBwaW4gZnJhbWVidWZmZXJcbiIpOwoKSSB0aGluayB0aGUgZXJyb3IgY291bGQgYWxz
byBiZSBFUkFTVEFSVFNZUyAoZS5nLiBmb3IgCndhaXRfZXZlbnRfaW50ZXJydXB0YWJsZSkgb3Ig
ZXZlbiBFQUdBSU4KClRoYW5rcywKQW5kcmV5Cgo+ICAgCQlyZXR1cm4gcjsKPiAgIAl9Cj4gICAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
