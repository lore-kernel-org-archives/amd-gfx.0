From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/vce: add support for hw config packet (v2)
Date: Fri, 30 Sep 2016 14:48:00 +0200
Message-ID: <b20647d3-7d03-6c33-803b-a231f3ff547d@vodafone.de>
References: <1475182636-31880-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1475182636-31880-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMjkuMDkuMjAxNiB1bSAyMjo1NyBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBUaGlzIGlzIG5l
ZWRlZCBmb3IgcHJvcGVyIFZDRSBEUE0gb24gc29tZSBBUFVzLgo+Cj4gdjI6IGZpeCB0aGUgYXNp
YyBsaXN0Cj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
Y2UuYyB8IDE0ICsrKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYwo+IGluZGV4IDMy
N2IzZjcuLjlhNTM0ZTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZjZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zj
ZS5jCj4gQEAgLTcwMCw2ICs3MDAsMjAgQEAgaW50IGFtZGdwdV92Y2VfcmluZ19wYXJzZV9jcyhz
dHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCwgdWludDMyX3QgaWJfaWR4KQo+ICAgCQljYXNlIDB4
MDUwMDAwMDk6IC8qIGNsb2NrIHRhYmxlICovCj4gICAJCQlicmVhazsKPiAgIAo+ICsJCWNhc2Ug
MHgwNTAwMDAwYzogLyogaHcgY29uZmlnICovCj4gKwkJCXN3aXRjaCAocC0+YWRldi0+YXNpY190
eXBlKSB7Cj4gKyNpZmRlZiBDT05GSUdfRFJNX0FNREdQVV9DSUsKPiArCQkJY2FzZSBDSElQX0tB
VkVSSToKPiArCQkJY2FzZSBDSElQX01VTExJTlM6Cj4gKyNlbmRpZgo+ICsJCQljYXNlIENISVBf
Q0FSUklaTzoKPiArCQkJCWJyZWFrOwo+ICsJCQlkZWZhdWx0Ogo+ICsJCQkJciA9IC1FSU5WQUw7
Cj4gKwkJCQlnb3RvIG91dDsKPiArCQkJfQo+ICsJCQlicmVhazsKPiArCj4gICAJCWNhc2UgMHgw
MzAwMDAwMTogLyogZW5jb2RlICovCj4gICAJCQlyID0gYW1kZ3B1X3ZjZV9jc19yZWxvYyhwLCBp
Yl9pZHgsIGlkeCArIDEwLCBpZHggKyA5LAo+ICAgCQkJCQkJKnNpemUsIDApOwoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
