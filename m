From: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>
Subject: regression on raven (gmc9)
Date: Mon, 2 Apr 2018 07:17:30 -0400
Message-ID: <2bd09049-695a-ef03-3a45-53610d366b38@amd.com>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

VGhpcyBjb21taXQKCltyb290QHJhdmVuIGxpbnV4XSMgZ2l0IGJpc2VjdCBiYWQKYzcwNGQ3YTE1
ZDI5MmU2ZTIyMmI3ZTk5MGVkN2U5ZjQxNjE3Y2RkOCBpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdApj
b21taXQgYzcwNGQ3YTE1ZDI5MmU2ZTIyMmI3ZTk5MGVkN2U5ZjQxNjE3Y2RkOApBdXRob3I6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KRGF0ZTogICBUdWUgTWFyIDI3
IDE3OjEwOjU2IDIwMTggLTA1MDAKCiAgICAgZHJtL2FtZGdwdS9nbWM5OiB1c2UgYW1kZ3B1X3Jp
bmdfZW1pdF9yZWdfd3JpdGVfcmVnX3dhaXQgaW4gZ3B1IHRsYiAKZmx1c2gKCiAgICAgVXNlIGFt
ZGdwdV9yaW5nX2VtaXRfcmVnX3dyaXRlX3JlZ193YWl0LiAgT24gZW5naW5lcyB0aGF0IHN1cHBv
cnQgaXQsCiAgICAgaXQgcHJvdmlkZXMgYSB3cml0ZSBhbmQgd2FpdCBpbiBhIHNpbmdsZSBwYWNr
ZXQgd2hpY2ggYXZvaWRzIGEgbWlzc2VkCiAgICAgYWNrIGlmIGEgd29ybGQgc3dpdGNoIGhhcHBl
bnMgYmV0d2VlbiB0aGUgcmVxdWVzdCBhbmQgd2FpdGluZyBmb3IgdGhlCiAgICAgYWNrLgoKICAg
ICBSZXZpZXdlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KICAgICBSZXZpZXdl
ZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgogICAgIFNp
Z25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCjow
NDAwMDAgMDQwMDAwIGEwOGExMmEzMTZkMDllYTIzMTMzNzEzNmNjN2FhMDc2ZDRkYTQ0YTggCjUy
MWM4YTE4YjBjNjNlMTg1ZTQxNmEyNjc2MTlhOTI4MjJkN2YyNjggTSAgICAgIGRyaXZlcnMKCkNh
dXNlcyBteSByYXZlbjEgdG8gbG9ja3VwIG9uIHN0YXJ0aW5nIFggd2l0aCBhIGdmeCByaW5nIHN0
YWxsLgoKVG9tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
