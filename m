From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm: Harmonize CIK ASIC support in radeon and amdgpu (v2)
Date: Thu, 27 Apr 2017 18:22:34 +0900
Message-ID: <04fb5e39-c951-d58f-97c7-eedb604624fd@daenzer.net>
References: <1491866474-1016-1-git-send-email-Felix.Kuehling@amd.com>
 <ac35e641-6fd9-a5d1-c4d9-35e71fa9eb08@daenzer.net>
 <cbcc54ec-c86f-f0eb-715e-f66790b5f964@amd.com>
 <340a5310-e6d1-5e09-81aa-d7106bcdca02@daenzer.net>
 <dedfed15-00b3-83ff-aca7-f4dffff8cc09@amd.com>
 <4bd2c7cf-a555-6cee-a863-b56ee824f9ad@daenzer.net>
 <f2f87cd4-c6c5-7c62-3035-d2f1584d7f00@amd.com>
 <cebca833-9e3f-86c5-8100-feca6ea590e5@daenzer.net>
 <588f3a43-3f29-e733-1ffd-154878303f0f@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <588f3a43-3f29-e733-1ffd-154878303f0f-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjcvMDQvMTcgMDU6MTUgQU0sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+IAo+IEhpIE1pY2hl
bCwKPiAKPiBZb3Ugc2FpZCBpbiBhbiBlYXJsaWVyIGVtYWlsIHRoYXQgaXQgZG9lc24ndCBoYXZl
IHRvIGJlIGNvbnZlbmllbnQuIFdpdGgKPiB0aGF0IGluIG1pbmQsIEkgd2VudCBiYWNrIHRvIGEg
bWluaW1hbGlzdGljIHNvbHV0aW9uIHRoYXQgZG9lc24ndCBuZWVkCj4gYW55IGFkZGl0aW9uYWwg
S2NvbmZpZyBvcHRpb25zIGFuZCBvbmx5IHVzZXMgdHdvIG1vZHVsZSBwYXJhbWV0ZXJzIChvbmUK
PiBpbiByYWRlb24sIG9uZSBpbiBhbWRncHUpLgo+IAo+IEknbSBhdHRhY2hpbmcgbXkgV0lQIHBh
dGNoZXMgZm9yIHJlZmVyZW5jZSAoY3VycmVudGx5IGJhc2VkIG9uCj4gYW1kLWtmZC1zdGFnaW5n
KS4gRm9yIGFuIG9mZmljaWFsIHJldmlldyBJJ2QgcmViYXNlIHRoZW0gb24KPiBhbWQtc3RhZ2lu
Zy00LjksIHJlbW92ZSB0aGUgI2lmLTAtZWQgaGFjayB0aGF0IGRpZG4ndCB3b3JrIG91dCwgYW5k
IGFkZAo+IHRoZSBzYW1lIGZvciBTSS4KPiAKPiBDYW4gZXZlcnlvbmUgY2FuIGFncmVlIHRoYXQg
dGhpcyBpcyBnb29kIGVub3VnaD8KClllcywgc29tZXRoaW5nIGxpa2UgdGhpcyBjb3VsZCBiZSBh
IGdvb2QgZmlyc3Qgc3RlcCBpbiB0aGUgcmlnaHQKZGlyZWN0aW9uLiBTb21lIGNvbW1lbnRzOgoK
VGhlIHJhZGVvbiBvcHRpb25zIHNob3VsZCBiZSBhdmFpbGFibGUgcmVnYXJkbGVzcyBvZgpDT05G
SUdfRFJNX0FNREdQVV9DSUsvU0ksIG9yIHRoZXkgd29uJ3QgYmUgdXNlZnVsIGZvciBhbWRncHUt
cHJvIC8gb3RoZXIKb3V0LW9mLXRyZWUgYW1kZ3B1IGJ1aWxkcy4KClRoZSBkZWZhdWx0IGF0IHRo
aXMgcG9pbnQgc2hvdWxkIHBvc3NpYmx5IHN0aWxsIGJlIGZvciBDSUsgR1BVcyB0byBiZQpkcml2
ZW4gYnkgcmFkZW9uLCBldmVuIGlmIENPTkZJR19EUk1fQU1ER1BVX0NJSyBpcyBlbmFibGVkOyBt
b3JlCmRlZmluaXRlbHkgc28gZm9yIFNJLiBUaGVuIHdlIGNhbiBmbGlwIHRoZSBkZWZhdWx0IGFu
ZCByZW1vdmUKQ09ORklHX0RSTV9BTURHUFVfQ0lLL1NJIGF0IHNvbWUgcG9pbnQgaW4gdGhlIGZ1
dHVyZSwgYW5kIChtdWNoKSBsYXRlcgptYXliZSByZW1vdmUgdGhlIENJSy9TSSBjb2RlIGZyb20g
cmFkZW9uLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3Qg
ICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
