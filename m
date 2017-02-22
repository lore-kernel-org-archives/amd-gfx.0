From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: bump driver version for new lds buffer query
Date: Wed, 22 Feb 2017 10:11:35 +0100
Message-ID: <8a6e6579-82db-e75a-270f-6efa65244a1d@vodafone.de>
References: <1487716437-28039-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1487716437-28039-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

QW0gMjEuMDIuMjAxNyB1bSAyMzozMyBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDMgKystCj4gICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4gaW5kZXggNzJjMzNiOS4uMGRkMGUyZCAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiBAQCAtNjAsOSArNjAs
MTAgQEAKPiAgICAqIC0gMy44LjAgLSBBZGQgc3VwcG9ydCByYXN0ZXIgY29uZmlnIGluaXQgaW4g
dGhlIGtlcm5lbAo+ICAgICogLSAzLjkuMCAtIEFkZCBzdXBwb3J0IGZvciBtZW1vcnkgcXVlcnkg
aW5mbyBhYm91dCBWUkFNIGFuZCBHVFQuCj4gICAgKiAtIDMuMTAuMCAtIEFkZCBzdXBwb3J0IGZv
ciBzZW5zb3IgcXVlcnkgaW5mbyAoY2xvY2tzLCB0ZW1wLCBldGMpLgo+ICsgKiAtIDMuMTEuMCAt
IEFkZCBxdWVyeSBmb3IgZG91YmxlIG9mZmNoaXAgTERTIGJ1ZmZlcnMKPiAgICAqLwo+ICAgI2Rl
ZmluZSBLTVNfRFJJVkVSX01BSk9SCTMKPiAtI2RlZmluZSBLTVNfRFJJVkVSX01JTk9SCTEwCj4g
KyNkZWZpbmUgS01TX0RSSVZFUl9NSU5PUgkxMQo+ICAgI2RlZmluZSBLTVNfRFJJVkVSX1BBVENI
TEVWRUwJMAo+ICAgCj4gICBpbnQgYW1kZ3B1X3ZyYW1fbGltaXQgPSAwOwoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
