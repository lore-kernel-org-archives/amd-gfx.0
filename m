From: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 1/3] amdgpu: add missing unlock on
 drmPrimeFDToHandle() failure
Date: Mon, 23 Jan 2017 17:15:33 +0100
Message-ID: <88bb524f-e720-9cf3-ebbb-90b644c00712@gmail.com>
References: <20170122184813.12995-1-emil.l.velikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170122184813.12995-1-emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjIuMDEuMjAxNyAxOTo0OCwgRW1pbCBWZWxpa292IHdyb3RlOgo+IENjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IEVtaWwgVmVsaWtvdiA8ZW1pbC5s
LnZlbGlrb3ZAZ21haWwuY29tPgoKUmV2aWV3ZWQtYnk6IE5pY29sYWkgSMOkaG5sZSA8bmljb2xh
aS5oYWVobmxlQGFtZC5jb20+Cgo+IC0tLQo+ICBhbWRncHUvYW1kZ3B1X2JvLmMgfCAxICsKPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvYW1kZ3B1L2Ft
ZGdwdV9iby5jIGIvYW1kZ3B1L2FtZGdwdV9iby5jCj4gaW5kZXggZDMwZmQxZTcuLmM5ZjMxNTg3
IDEwMDY0NAo+IC0tLSBhL2FtZGdwdS9hbWRncHVfYm8uYwo+ICsrKyBiL2FtZGdwdS9hbWRncHVf
Ym8uYwo+IEBAIC0zMDIsNiArMzAyLDcgQEAgaW50IGFtZGdwdV9ib19pbXBvcnQoYW1kZ3B1X2Rl
dmljZV9oYW5kbGUgZGV2LAo+ICAJCS8qIEdldCBhIEtNUyBoYW5kbGUuICovCj4gIAkJciA9IGRy
bVByaW1lRkRUb0hhbmRsZShkZXYtPmZkLCBzaGFyZWRfaGFuZGxlLCAmaGFuZGxlKTsKPiAgCQlp
ZiAocikgewo+ICsJCQlwdGhyZWFkX211dGV4X3VubG9jaygmZGV2LT5ib190YWJsZV9tdXRleCk7
Cj4gIAkJCXJldHVybiByOwo+ICAJCX0KPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
