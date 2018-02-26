From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 07/22] drm/amdgpu: fix fence_emit NULL pointer ref risk
Date: Mon, 26 Feb 2018 10:58:23 +0100
Message-ID: <7b88f084-1c05-71ed-38ac-fa3f72ceb539@gmail.com>
References: <1519622300-8990-1-git-send-email-Monk.Liu@amd.com>
 <1519622300-8990-8-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1519622300-8990-8-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjYuMDIuMjAxOCB1bSAwNjoxOCBzY2hyaWViIE1vbmsgTGl1Ogo+IENoYW5nZS1JZDogSWMz
OWRlNzMzMzhkNTE1ZDRlMzNhODI4ZjQ0NWQ4YTNjM2JhNTQ0YmIKPiBTaWduZWQtb2ZmLWJ5OiBN
b25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9mZW5jZS5jIHwgMyArKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9mZW5jZS5jCj4gaW5kZXggMDA4ZTE5OC4uNDAxZDcxMCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4gQEAgLTE2Myw3ICsxNjMsOCBAQCBpbnQg
YW1kZ3B1X2ZlbmNlX2VtaXQoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBzdHJ1Y3QgZG1hX2Zl
bmNlICoqZikKPiAgIAo+ICAgCXJjdV9hc3NpZ25fcG9pbnRlcigqcHRyLCBkbWFfZmVuY2VfZ2V0
KCZmZW5jZS0+YmFzZSkpOwo+ICAgCj4gLQkqZiA9ICZmZW5jZS0+YmFzZTsKPiArCWlmIChmKQo+
ICsJCSpmID0gJmZlbmNlLT5iYXNlOwoKTkFLLCByZXR1cm5pbmcgdGhlIGZlbmNlIHBvaW50ZXIg
aXNuJ3Qgb3B0aW9uYWwgaGVyZS4KCkNocmlzdGlhbi4KCj4gICAKPiAgIAlyZXR1cm4gMDsKPiAg
IH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
