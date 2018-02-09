From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amdgpu: replace iova debugfs file with iomem
Date: Fri, 9 Feb 2018 09:51:32 -0500
Message-ID: <bb5cd938-c9cc-5a72-a7e7-269c14d6dabb@amd.com>
References: <20180202190948.2654-1-christian.koenig@amd.com>
 <20180202190948.2654-5-christian.koenig@amd.com>
 <9b2c3354-ea82-722d-a6d2-42e2cf1e6540@amd.com>
 <5f37bea8-a6a3-c879-e8ec-f24948647a3e@gmail.com>
 <d6176df1-81dd-1bd8-577d-f962960ab173@amd.com>
 <ae110a8d-b1a3-7ce3-6a0d-a5bb41c48952@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ae110a8d-b1a3-7ce3-6a0d-a5bb41c48952-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDkvMDIvMTggMDk6MTIgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gTm8sIHRoZXJl
IGlzIHNpbXBseSBubyBuZWVkIHRvIGluaXRpYWxpemUgdGhlIHN5c3RlbSBkb21haW4uIFdoYXQg
YXJlIAo+IHRoZSB2YWx1ZXMgb2YgcC0+bWFwcGluZyBhbmQgYWRldi0+bW1hbi5iZGV2LmRldl9t
YXBwaW5nIHdoZW4gdGhleSBkb24ndCAKPiBtYXRjaD8gTWF5YmUgd2UgYXJlIGFsbG9jYXRpbmcg
bWVtb3J5IGJlZm9yZSBpbml0aWFsaXppbmcgCj4gYWRldi0+bW1hbi5iZGV2LmRldl9tYXBwaW5n
LgoKSW4gbXkgdGVzdCBzZXR1cCBJJ20gcnVubmluZyB0ZXN0IDMgZnJvbSBsaWJkcm0gKHN1aXRl
IDEpIHdpdGggYSBwYXVzZSAKYmVmb3JlIHRoZSB1bm1hcC9mcmVlIGNhbGwuICBTbyB0aGUgSUIg
c2hvdWxkIHN0aWxsIGJlIG1hcHBlZC4gIEluZGVlZCAKdGhlIFZNIFBURSBkZWNvZGluZyBoYXMg
dGhlIFYgYml0IHNldC4KCj4gT3IgZG8geW91IGhhdmUgbW9yZSB0aGFuIG9uZSBHUFUgaW4gdGhl
IHN5c3RlbT8gRS5nLiBBUFUrZEdQVT8gQ291bGQgaXQgCj4gYmUgdGhhdCB5b3UgcmVhZCB0aHJv
dWdoIHRoZSB3cm9uZyBkZXZpY2U/CgpJIGZvdW5kIHRoZSBpc3N1ZToKCgl3aGlsZSAoc2l6ZSkg
ewoJCXBoeXNfYWRkcl90IGFkZHIgPSAqcG9zICYgUEFHRV9NQVNLOwoJCWxvZmZfdCBvZmYgPSAq
cG9zICYgflBBR0VfTUFTSzsKCQlzaXplX3QgYnl0ZXMgPSBQQUdFX1NJWkUgLSBvZmY7CgoiYnl0
ZXMiIHNob3VsZCBiZSBsaW1pdGVkIGJ5IHRoZSAnc2l6ZScgcGFyYW1ldGVyIHBhc3NlZCBpbi4g
IFdoYXQgaXMgCmhhcHBlbmluZyBpbnN0ZWFkIGlzIGl0J3MgcmVhZGluZyB0aGUgZW50aXJlIFBU
QiB1bnRpbCBpdCBoaXRzIGEgVj0wIApwYWdlIGFuZCB0aGVuIHJldHVybnMgYW4gZXJyb3IgYW5k
IGluIHRoZSBwcm9jZXNzIGlzIGRvaW5nICJmdW4gdGhpbmdzIiAKdG8gdGhlIHVzZXIgbW9kZSBh
cHBsaWNhdGlvbiAoYnkgY29weWluZyBtb3JlIGRhdGEgdGhhbiBJIGFza2VkIGZvcikuCgoKVG9t
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
