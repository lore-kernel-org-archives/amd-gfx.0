From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu_gem: fix error handling path in
 amdgpu_gem_va_update_vm
Date: Thu, 15 Feb 2018 13:32:36 +0100
Message-ID: <b3638ffe-b29f-b30b-4a2c-ccc50f7562b0@gmail.com>
References: <20180215052000.GA25691@embeddedgus>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180215052000.GA25691@embeddedgus>
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
To: "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>
Cc: "Gustavo A. R. Silva" <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

QW0gMTUuMDIuMjAxOCB1bSAwNjoyMCBzY2hyaWViIEd1c3Rhdm8gQS4gUi4gU2lsdmE6Cj4gQ3Vy
cmVudGx5LCBpZiBhbWRncHVfdm1fYm9fdXBkYXRlKCkgZmFpbHMsIHRoZSByZXR1cm5lZCBlcnJv
cgo+IGlzIGJlaW5nIGlnbm9yZWQuCj4KPiBGaXggdGhpcyBieSBwcm9wZXJseSBjaGVja2luZyBf
cl8gYWZ0ZXIgY2FsbGluZyBhbWRncHVfdm1fYm9fdXBkYXRlLgo+IEFsc28sIHJlbW92ZSByZWR1
bmRhbnQgY29kZSBqdXN0IGJlZm9yZSBsYWJlbCBfZXJyb3JfLgo+Cj4gQWRkcmVzc2VzLUNvdmVy
aXR5LUlEOiAxNDY0MjgwICgiVW51c2VkIHZhbHVlIikKPiBGaXhlczogMGFiYzY4NzhmYzJkICgi
ZHJtL2FtZGdwdTogdXBkYXRlIFZNIFBEcyBhZnRlciB0aGUgUFRzIikKPiBTaWduZWQtb2ZmLWJ5
OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPgoKUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgfCA3ICsrKystLS0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4gaW5kZXggZTQ4YjRlYy4uZGI4NWZj
MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPiBAQCAtNTIz
LDEyICs1MjMsMTMgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2dlbV92YV91cGRhdGVfdm0oc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCWdvdG8gZXJyb3I7Cj4gICAKPiAgIAlpZiAob3Bl
cmF0aW9uID09IEFNREdQVV9WQV9PUF9NQVAgfHwKPiAtCSAgICBvcGVyYXRpb24gPT0gQU1ER1BV
X1ZBX09QX1JFUExBQ0UpCj4gKwkgICAgb3BlcmF0aW9uID09IEFNREdQVV9WQV9PUF9SRVBMQUNF
KSB7Cj4gICAJCXIgPSBhbWRncHVfdm1fYm9fdXBkYXRlKGFkZXYsIGJvX3ZhLCBmYWxzZSk7Cj4g
KwkJaWYgKHIpCj4gKwkJCWdvdG8gZXJyb3I7Cj4gKwl9Cj4gICAKPiAgIAlyID0gYW1kZ3B1X3Zt
X3VwZGF0ZV9kaXJlY3RvcmllcyhhZGV2LCB2bSk7Cj4gLQlpZiAocikKPiAtCQlnb3RvIGVycm9y
Owo+ICAgCj4gICBlcnJvcjoKPiAgIAlpZiAociAmJiByICE9IC1FUkVTVEFSVFNZUykKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
