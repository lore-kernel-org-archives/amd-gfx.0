From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdkfd: Add proper prefix to functions
Date: Fri, 19 Oct 2018 09:20:30 +0200
Message-ID: <c2527b0d-077e-96cb-51c0-aff2390de2a0@daenzer.net>
References: <1539897297-12082-1-git-send-email-Amber.Lin@amd.com>
 <1539897297-12082-3-git-send-email-Amber.Lin@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539897297-12082-3-git-send-email-Amber.Lin-5C7GfCeVMHo@public.gmane.org>
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
To: "Lin, Amber" <Amber.Lin-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0xMC0xOCAxMToxNSBwLm0uLCBMaW4sIEFtYmVyIHdyb3RlOgo+IEFkZCBhbWRncHVf
YW1ka2ZkXyBwcmVmaXggdG8gYW1kZ3B1IGZ1bmN0aW9ucyBzZXJ2ZWQgZm9yIGFtZGtmZCB1c2Fn
ZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBbWJlciBMaW4gPEFtYmVyLkxpbkBhbWQuY29tPgo+IAo+
ICBbLi4uXQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMK
PiBpbmRleCBjMzFhODg0Li40ZTM4NGFiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmQuYwo+IEBAIC0yNjgsNyArMjY4LDcgQEAgdm9pZCBhbWRncHVfYW1k
a2ZkX2dwdV9yZXNldChzdHJ1Y3Qga2dkX2RldiAqa2dkKQo+ICAJCWFtZGdwdV9kZXZpY2VfZ3B1
X3JlY292ZXIoYWRldiwgTlVMTCk7Cj4gIH0KPiAgCj4gLWludCBhbGxvY19ndHRfbWVtKHN0cnVj
dCBrZ2RfZGV2ICprZ2QsIHNpemVfdCBzaXplLAo+ICtpbnQgYW1kZ3B1X2FtZGtmZF9hbGxvY19n
dHRfbWVtKHN0cnVjdCBrZ2RfZGV2ICprZ2QsIHNpemVfdCBzaXplLAo+ICAJCQl2b2lkICoqbWVt
X29iaiwgdWludDY0X3QgKmdwdV9hZGRyLAo+ICAJCQl2b2lkICoqY3B1X3B0ciwgYm9vbCBtcWRf
Z2Z4OSkKCkluIGNhc2VzIGxpa2UgdGhpcywgcGxlYXNlIGZpeCB1cCB0aGUgaW5kZW50YXRpb24g
b2YgY29udGludWF0aW9uIGxpbmVzCnRvIG1hdGNoIHRoZSBtb2RpZmllZCBmaXJzdCBsaW5lLgoK
Ci0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAg
ICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
