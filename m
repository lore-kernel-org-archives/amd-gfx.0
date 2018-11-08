From: "Zhang, Jerry(Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/sdma4: use page queue 1 for buffer funcs
Date: Thu, 8 Nov 2018 10:11:31 +0800
Message-ID: <9da6b213-e2d2-c0eb-6f6d-8ce39bcc2152@amd.com>
References: <20181107172949.27158-1-alexander.deucher@amd.com>
 <20181107172949.27158-2-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181107172949.27158-2-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

T24gMTEvOC8xOCAxOjI5IEFNLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gVXNlIHBhZ2UgcXVldWUg
MCByYXRoZXIgdGhhbiAxIHRvIGF2b2lkIGNvbnRlbnRpb24gd2l0aCBHUFVWTQo+IHVwZGF0ZXMg
dXNpbmcgcGFnZSBxdWV1ZSAwLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKQSBsaXR0bGUgY29uZnVzZSwgSSB0aG91Z2h0IHdlIHdl
cmUgZ29pbmcgdG8gdXNlIHBhZ2UgcXVldWUoaW4gYW55IAppbnN0YW5jZSkgZm9yIFBUIHVwZGF0
ZSwKZ2Z4IHJpbmcgZm9yIGdlbmVyYWwgc2RtYSBqb2JzLgoKQW55IG1pc3Npbmc/CgpSZWdhcmRz
LApKZXJyeQo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMg
fCAzICsrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKPiBpbmRleCA0YjViNDdk
ZDJmNGMuLjQ0YzE2YTVjNTQyOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zZG1hX3Y0XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFf
djRfMC5jCj4gQEAgLTIwNjIsNyArMjA2Miw4IEBAIHN0YXRpYyB2b2lkIHNkbWFfdjRfMF9zZXRf
YnVmZmVyX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgewo+ICAgCWFkZXYt
Pm1tYW4uYnVmZmVyX2Z1bmNzID0gJnNkbWFfdjRfMF9idWZmZXJfZnVuY3M7Cj4gICAJaWYgKGFk
ZXYtPnNkbWEuaGFzX3BhZ2VfcXVldWUpCj4gLQkJYWRldi0+bW1hbi5idWZmZXJfZnVuY3Nfcmlu
ZyA9ICZhZGV2LT5zZG1hLmluc3RhbmNlWzBdLnBhZ2U7Cj4gKwkJLyogdXNlIHBhZ2UgcXVldWUg
MSBzaW5jZSBwYWdlIHF1ZXVlIDAgd2lsbCBiZSB1c2VkIGZvciBWTSB1cGRhdGVzICovCj4gKwkJ
YWRldi0+bW1hbi5idWZmZXJfZnVuY3NfcmluZyA9ICZhZGV2LT5zZG1hLmluc3RhbmNlWzFdLnBh
Z2U7Cj4gICAJZWxzZQo+ICAgCQlhZGV2LT5tbWFuLmJ1ZmZlcl9mdW5jc19yaW5nID0gJmFkZXYt
PnNkbWEuaW5zdGFuY2VbMF0ucmluZzsKPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
