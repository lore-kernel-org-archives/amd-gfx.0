From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix a typo
Date: Thu, 22 Jun 2017 09:35:27 +0200
Message-ID: <5ff65f82-9d15-4606-7e25-e4f75c172aed@vodafone.de>
References: <1498099356-31332-1-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1498099356-31332-1-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjIuMDYuMjAxNyB1bSAwNDo0MiBzY2hyaWViIEFsZXggWGllOgo+IFNpZ25lZC1vZmYtYnk6
IEFsZXggWGllIDxBbGV4QmluLlhpZUBhbWQuY29tPgoKV2l0aCB0aGUgY29tbWl0IG1lc3NhZ2Ug
Zml4ZWQgYXMgTWljaGVsIHN1Z2dlc3RlZCBwYXRjaGVzICMxIGFuZCAjMiBhcmUgClJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGFzIHdlbGwu
CgpPbiBwYXRjaCAjMyBNYXJlayBuZWVkcyB0byB0YWtlIGEgbG9vaywgY2F1c2UgSSBkb24ndCBr
bm93IHRoZSBsb2dpYyAKYmVoaW5kIHRoYXQuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+IC0tLQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgfCAyICstCj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gaW5kZXggNzYzNWYzOC4uOTRjMjdmYyAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gQEAgLTQ5NCw3ICs0OTQsNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV9jc19wYXJzZXJfYm9zKHN0cnVjdCBhbWRncHVfY3NfcGFyc2Vy
ICpwLAo+ICAgCQkJCSAmZS0+dXNlcl9pbnZhbGlkYXRlZCkgJiYgZS0+dXNlcl9wYWdlcykgewo+
ICAgCj4gICAJCQkJLyogV2UgYWNxdWlyZWQgYSBwYWdlIGFycmF5LCBidXQgc29tZWJvZHkKPiAt
CQkJCSAqIGludmFsaWRhdGVkIGl0LiBGcmVlIGl0IGFuIHRyeSBhZ2Fpbgo+ICsJCQkJICogaW52
YWxpZGF0ZWQgaXQuIEZyZWUgaXQgYW5kIHRyeSBhZ2Fpbgo+ICAgCQkJCSAqLwo+ICAgCQkJCXJl
bGVhc2VfcGFnZXMoZS0+dXNlcl9wYWdlcywKPiAgIAkJCQkJICAgICAgZS0+cm9iai0+dGJvLnR0
bS0+bnVtX3BhZ2VzLAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
