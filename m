From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: disable runtime pm in certain cases
Date: Mon, 31 Oct 2016 11:08:00 -0400
Message-ID: <1477926480-13391-2-git-send-email-alexander.deucher@amd.com>
References: <1477926480-13391-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1477926480-13391-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

SWYgdGhlIHBsYXRmb3JtIGRvZXMgbm90IHN1cHBvcnQgaHlicmlkIGdyYXBoaWNzIG9yIEFUUFgg
ZEdQVQpwb3dlciBjb250cm9sLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMK
aW5kZXggNTVjNDEzYS4uOGY0OGJlZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ttcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9rbXMuYwpAQCAtOTksNiArOTksOCBAQCBpbnQgYW1kZ3B1X2RyaXZlcl9sb2FkX2ttcyhzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2LCB1bnNpZ25lZCBsb25nIGZsYWdzKQogCiAJaWYgKChhbWRncHVf
cnVudGltZV9wbSAhPSAwKSAmJgogCSAgICBhbWRncHVfaGFzX2F0cHgoKSAmJgorCSAgICAoYW1k
Z3B1X2lzX2F0cHhfaHlicmlkKCkgfHwKKwkgICAgIGFtZGdwdV9oYXNfYXRweF9kZ3B1X3Bvd2Vy
X2NudGwoKSkgJiYKIAkgICAgKChmbGFncyAmIEFNRF9JU19BUFUpID09IDApKQogCQlmbGFncyB8
PSBBTURfSVNfUFg7CiAKLS0gCjIuNS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
