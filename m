From: Shaobo He <shaobo-sDh8Nw2yj/+Vc3sceRu5cw@public.gmane.org>
Subject: Potential NULL pointer dereference in radeon_ttm_tt_populate
Date: Mon, 18 Mar 2019 14:58:23 -0600
Message-ID: <186647c5-188d-1a92-c7c1-e13195780220@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SGVsbG8gZXZlcnlvbmUsCgpNeSBuYW1lIGlzIFNoYW9ibyBIZSBhbmQgSSBhbSBhIGdyYWR1YXRl
IHN0dWRlbnQgYXQgVW5pdmVyc2l0eSBvZiBVdGFoLiBJIGFtIAp1c2luZyBhIHN0YXRpYyBhbmFs
eXNpcyB0b29sIHRvIHNlYXJjaCBmb3IgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlcyBhbmQgY2Ft
ZSAKYWNyb3NzIGEgcG90ZW50aWFsbHkgaW52YWxpZCBtZW1vcnkgYWNjZXNzIGluIHRoZSBmaWxl
IApkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYzogaW4gZnVuY3Rpb24gYHJhZGVv
bl90dG1fdHRfcG9wdWxhdGVgLCAKZnVuY3Rpb24gYHJhZGVvbl90dG1fdHRfdG9fZ3R0YCBjYW4g
cmV0dXJuIGEgTlVMTCBwb2ludGVyIHdoaWNoIGlzIGRlcmVmZXJlbmNlZCAKYnkgdGhlIGNhbGwg
dG8gYGRybV9wcmltZV9zZ190b19wYWdlX2FkZHJfYXJyYXlzYC4KClBsZWFzZSBsZXQgbWUga25v
dyBpZiBpdCBtYWtlcyBzZW5zZS4gSSBhbSBsb29raW5nIGZvcndhcmQgdG8geW91ciByZXBseS4K
CkJlc3QsClNoYW9ibwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
