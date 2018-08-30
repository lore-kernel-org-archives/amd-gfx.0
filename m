From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add error return value for finding bo
 by cpu mapping
Date: Thu, 30 Aug 2018 17:26:38 +0800
Message-ID: <5B87B84E.9090307@amd.com>
References: <1535619003-18067-1-git-send-email-Jerry.Zhang@amd.com>
 <01272587-1647-4456-57fa-ad809a100c34@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <01272587-1647-4456-57fa-ad809a100c34-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDgvMzAvMjAxOCAwNDo1NyBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAxOC0w
OC0zMCAxMDo1MCBhLm0uLCBKdW53ZWkgWmhhbmcgd3JvdGU6Cj4+IElmIG5vdGhpbmcgaXMgZm91
bmQsIGVycm9yIHNob3VsZCBiZSByZXR1cm5lZC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSnVud2Vp
IFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgo+Pgo+PiBbLi4uXQo+Pgo+PiBAQCAtNTc3LDEw
ICs1NzgsMTEgQEAgaW50IGFtZGdwdV9maW5kX2JvX2J5X2NwdV9tYXBwaW5nKGFtZGdwdV9kZXZp
Y2VfaGFuZGxlIGRldiwKPj4gICAJfSBlbHNlIHsKPj4gICAJCSpidWZfaGFuZGxlID0gTlVMTDsK
Pj4gICAJCSpvZmZzZXRfaW5fYm8gPSAwOwo+PiArCQlyID0gLUVJTlZBTDsKPgo+IEkgdGhpbmsg
LUVOT0VOVCB3b3VsZCBiZSBiZXR0ZXIsIHRvIGRpZmZlcmVudGlhdGUgdGhpcyBlcnJvciBmcm9t
Cj4gcGFzc2luZyBpbnZhbGlkIHBvaW50ZXIgLyBzaXplIHBhcmFtZXRlcnMuCgpNbW0sIGdvb2Qg
cG9pbnQsIHBlcmhhcHMgRU5YSU8gaXMgYmV0dGVyLAp3aGljaCBpcyB1c2VkIGluIGFtZGdwdSB0
dG0gZm9yIGFkZHJlc3Mgb3V0IG9mIGV4aXN0aW5nIHJhbmdlLgoKI2RlZmluZSBFTk9FTlQgICAg
ICAgICAgIDIgICAgICAvKiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5ICovCiNkZWZpbmUgRU5Y
SU8gICAgICAgICAgICA2ICAgICAgLyogTm8gc3VjaCBkZXZpY2Ugb3IgYWRkcmVzcyAqLwoKUmVn
YXJkcywKSmVycnkKCj4KPiBXaXRoIHRoYXQsCj4KPiBSZXZpZXdlZC1ieTogTWljaGVsIETDpG56
ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Cj4KPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
