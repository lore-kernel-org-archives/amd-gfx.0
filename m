From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: fix spelling in amdgpu_powerplay.h
Date: Mon, 17 Oct 2016 10:02:39 +0200
Message-ID: <7946276b-7b37-a26f-8390-07a3f8c5a21b@vodafone.de>
References: <1476458927-9557-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1476458927-9557-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

QW0gMTQuMTAuMjAxNiB1bSAxNzoyOCBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBhbmQgdXBkYXRl
IGEgY29tbWVudCBhcyB3ZWxsLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcG93ZXJwbGF5LmggfCA2ICsrKy0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG93ZXJwbGF5LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcG93ZXJwbGF5LmgKPiBpbmRleCBkYTVjZjQ3Li5lZTZlYTZjIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wb3dlcnBsYXkuaAo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wb3dlcnBsYXkuaAo+IEBA
IC0yMywxMSArMjMsMTEgQEAKPiAgICAqCj4gICAgKi8KPiAgIAo+IC0jaWZuZGVmIF9fQU1ER1BV
X1BPUFdFUlBMQVlfSF9fCj4gLSNkZWZpbmUgX19BTURHUFVfUE9QV0VSUExBWV9IX18KPiArI2lm
bmRlZiBfX0FNREdQVV9QT1dFUlBMQVlfSF9fCj4gKyNkZWZpbmUgX19BTURHUFVfUE9XRVJQTEFZ
X0hfXwo+ICAgCj4gICAjaW5jbHVkZSAiYW1kX3NoYXJlZC5oIgo+ICAgCj4gICBleHRlcm4gY29u
c3Qgc3RydWN0IGFtZF9pcF9mdW5jcyBhbWRncHVfcHBfaXBfZnVuY3M7Cj4gICAKPiAtI2VuZGlm
IC8qIF9fQU1EU09DX0RNX0hfXyAqLwo+ICsjZW5kaWYgLyogX19BTURHUFVfUE9XRVJQTEFZX0hf
XyAqLwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
