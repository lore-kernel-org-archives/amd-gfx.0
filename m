From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm: Harmonize CIK ASIC support in radeon and amdgpu (v2)
Date: Tue, 25 Apr 2017 15:28:15 +0900
Message-ID: <cebca833-9e3f-86c5-8100-feca6ea590e5@daenzer.net>
References: <1491866474-1016-1-git-send-email-Felix.Kuehling@amd.com>
 <ac35e641-6fd9-a5d1-c4d9-35e71fa9eb08@daenzer.net>
 <cbcc54ec-c86f-f0eb-715e-f66790b5f964@amd.com>
 <340a5310-e6d1-5e09-81aa-d7106bcdca02@daenzer.net>
 <dedfed15-00b3-83ff-aca7-f4dffff8cc09@amd.com>
 <4bd2c7cf-a555-6cee-a863-b56ee824f9ad@daenzer.net>
 <f2f87cd4-c6c5-7c62-3035-d2f1584d7f00@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f2f87cd4-c6c5-7c62-3035-d2f1584d7f00-5C7GfCeVMHo@public.gmane.org>
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

T24gMjIvMDQvMTcgMDI6MDUgQU0sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+IF9fc2V0dXAgZG9l
c24ndCB3b3JrIGluIG1vZHVsZXMuCgpSaWdodC4gV2UgY291bGQgYnVpbGQgc29tZXRoaW5nIGxp
a2UKZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZiX2NtZGxpbmUuYzp2aWRlb19zZXR1cCgpIGlu
dG8gdGhlIGtlcm5lbCB0bwpoYW5kbGUgdGhpcywgYnV0IGl0J3MgYSBiaXQgdWdseSwgd2hpY2gg
aXMgb25lIHJlYXNvbiB3aHkgSSB3YXMgbGVhbmluZwp0b3dhcmRzOgoKCj4gczgyNTBfb3B0aW9u
cyBpcyBvbmx5IGNvbXBpbGVkIGlmIHRoZSBkcml2ZXIgaXMgbm90IGEgbW9kdWxlLgoKVGhhdCBk
b2Vzbid0IHByZXZlbnQgdXMgZnJvbSB1c2luZyBfX21vZHVsZV9wYXJhbV9jYWxsIGRpcmVjdGx5
LCBkb2VzIGl0PwoKQWx0aG91Z2gsIHRoYXQgc3RpbGwgZG9lc24ndCB3b3JrIGFzIEkgZW52aXNp
b24gaWYgb25seSBvbmUgZHJpdmVyJ3MKb3B0aW9uIGlzIHNldCBlLmcuIGluIC9ldGMvbW9kcHJv
YmUuZC8qLmNvbmYgLgoKClNvLCBJJ20gc3RhcnRpbmcgdG8gdGhpbmsgd2UgbmVlZCBhIHNoYXJl
ZCBtb2R1bGUgZm9yIHRoaXMsIHdoaWNoCnByb3ZpZGVzIG9uZSBvciBtdWx0aXBsZSBtb2R1bGUg
cGFyYW1ldGVycyB0byBjaG9vc2Ugd2hpY2ggZHJpdmVyIHRvIHVzZQpmb3IgQ0lLL1NJWzBdLCBh
bmQgcHJvdmlkZXMgdGhlIHJlc3VsdCB0byB0aGUgYW1kZ3B1L3JhZGVvbiBkcml2ZXJzLgpUaGF0
IG1pZ2h0IG1ha2UgdGhpbmdzIGVhc2llciBmb3IgYW1kZ3B1LXBybyAvIG90aGVyIHN0YW5kYWxv
bmUgYW1kZ3B1CnZlcnNpb25zIGluIHRoZSBsb25nIHJ1biBhcyB3ZWxsLCBhcyB0aGV5IGNvdWxk
IGFkZCBmaWxlcyB0bwovZXRjL21vZHByb2JlLmQvIGNob29zaW5nIHRoZW1zZWx2ZXMgYnkgZGVm
YXVsdCwgd2l0aG91dCBoYXZpbmcgdG8KYmxhY2tsaXN0IHJhZGVvbi4KCldoYXQgZG8geW91IGd1
eXMgdGhpbms/CgoKWzBdIG9yIHBvc3NpYmx5IGV2ZW4gbW9yZSBmaW5lLWdyYWluZWQgaW4gdGhl
IGZ1dHVyZQoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAg
ICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
