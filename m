From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add warning message for INT SW fallback.
Date: Sat, 22 Sep 2018 09:17:25 +0200
Message-ID: <47a7c870-af78-04e3-9736-adcecfb8758e@gmail.com>
References: <1537559505-24299-1-git-send-email-andrey.grodzovsky@amd.com>
 <1537559505-24299-2-git-send-email-andrey.grodzovsky@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1537559505-24299-2-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org

QW0gMjEuMDkuMjAxOCB1bSAyMTo1MSBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+IFNpZ25l
ZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgo+
IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCAxICsK
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPiBpbmRleCBkYTM2NzMxLi4xYWUyNTgzIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPiBAQCAtMjc0LDYgKzI3
NCw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9mZW5jZV9mYWxsYmFjayhzdHJ1Y3QgdGltZXJfbGlz
dCAqdCkKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBmcm9tX3RpbWVyKHJpbmcsIHQs
Cj4gICAJCQkJCSAgICAgIGZlbmNlX2Rydi5mYWxsYmFja190aW1lcik7Cj4gICAKPiArCURSTV9J
TkZPKCJGYWxsYmFjayB0byBTVyBpbnRlcnJ1cHQgb24gcmluZyAlcyBkdWUgdG8gSFcgaW50ZXJy
dXB0IHRpbWUgb3V0IiwgcmluZy0+bmFtZSk7CgpQbGVhc2UgbWFrZSB0aGF0IGEgRFJNX1dBUk4o
KSwgYXBhcnQgZnJvbSB0aGF0IHRoZSBzZXJpZXMgaXMgClJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpUaGFua3MgZm9yIHRha2luZyBjYXJl
IG9mIHRoaXMsCkNocmlzdGlhbi4KCj4gICAJYW1kZ3B1X2ZlbmNlX3Byb2Nlc3MocmluZyk7Cj4g
ICB9Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
