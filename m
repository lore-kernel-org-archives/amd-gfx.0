From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add error return value for finding bo by
 cpu mapping
Date: Thu, 30 Aug 2018 10:57:54 +0200
Message-ID: <01272587-1647-4456-57fa-ad809a100c34@daenzer.net>
References: <1535619003-18067-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1535619003-18067-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wOC0zMCAxMDo1MCBhLm0uLCBKdW53ZWkgWmhhbmcgd3JvdGU6Cj4gSWYgbm90aGlu
ZyBpcyBmb3VuZCwgZXJyb3Igc2hvdWxkIGJlIHJldHVybmVkLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4KPiAKPiBbLi4uXQo+ICAKPiBAQCAt
NTc3LDEwICs1NzgsMTEgQEAgaW50IGFtZGdwdV9maW5kX2JvX2J5X2NwdV9tYXBwaW5nKGFtZGdw
dV9kZXZpY2VfaGFuZGxlIGRldiwKPiAgCX0gZWxzZSB7Cj4gIAkJKmJ1Zl9oYW5kbGUgPSBOVUxM
Owo+ICAJCSpvZmZzZXRfaW5fYm8gPSAwOwo+ICsJCXIgPSAtRUlOVkFMOwoKSSB0aGluayAtRU5P
RU5UIHdvdWxkIGJlIGJldHRlciwgdG8gZGlmZmVyZW50aWF0ZSB0aGlzIGVycm9yIGZyb20KcGFz
c2luZyBpbnZhbGlkIHBvaW50ZXIgLyBzaXplIHBhcmFtZXRlcnMuCgpXaXRoIHRoYXQsCgpSZXZp
ZXdlZC1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgoKLS0gCkVh
cnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRw
Oi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAg
ICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
