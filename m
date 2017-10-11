From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/display: drop unused dm_delay_in_microseconds
Date: Wed, 11 Oct 2017 13:17:39 -0400
Message-ID: <41709075-31cc-768a-3e3f-59dd3da97ae5@amd.com>
References: <1507740690-3377-1-git-send-email-alexander.deucher@amd.com>
 <1507740690-3377-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1507740690-3377-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

T24gMjAxNy0xMC0xMSAxMjo1MSBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IE5vIGxvbmdlciB1
c2VkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KClNlcmllcyBpcwpSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5Lndl
bnRsYW5kQGFtZC5jb20+CgpIYXJyeQoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fc2VydmljZXMuYyB8IDcgLS0tLS0tLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fc2VydmljZXMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3NlcnZpY2VzLmMKPiBpbmRleCAy
YzNjZDUxLi40M2JmODI5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtX3NlcnZpY2VzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9zZXJ2aWNlcy5jCj4gQEAgLTU5LDEzICs1
OSw2IEBAIGJvb2wgZG1fcmVhZF9wZXJzaXN0ZW50X2RhdGEoc3RydWN0IGRjX2NvbnRleHQgKmN0
eCwKPiAgCXJldHVybiBmYWxzZTsKPiAgfQo+ICAKPiAtdm9pZCBkbV9kZWxheV9pbl9taWNyb3Nl
Y29uZHMoc3RydWN0IGRjX2NvbnRleHQgKmN0eCwKPiAtCQkJCQl1bnNpZ25lZCBpbnQgbWljcm9T
ZWNvbmRzKQo+IC17Cj4gLQkvKlRPRE8gaW1wbGVtZW50Ki8KPiAtCXJldHVybjsKPiAtfQo+IC0K
PiAgLyoqKiogcG93ZXIgY29tcG9uZW50IGludGVyZmFjZXMgKioqKi8KPiAgCj4gIGJvb2wgZG1f
cHBfcHJlX2RjZV9jbG9ja19jaGFuZ2UoCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
