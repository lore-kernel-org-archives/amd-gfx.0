From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 05/11] drm/amd/display: implement dm_delay_in_microseconds
Date: Wed, 11 Oct 2017 11:57:54 -0400
Message-ID: <d363cb9e-9c9b-49fd-ad05-8580884ec86c@amd.com>
References: <1507730801-17362-1-git-send-email-alexander.deucher@amd.com>
 <1507730801-17362-5-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1507730801-17362-5-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, harry.wenland-5C7GfCeVMHo@public.gmane.org

T24gMjAxNy0xMC0xMSAxMDowNiBBTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IGRjIHVzZXMgdGhp
cy4gIE5vdCBzdXJlIGhvdyBpbXBvcnRhbnQgaXQgaXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9zZXJ2aWNlcy5jIHwgMyArLS0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9k
bV9zZXJ2aWNlcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG1fc2VydmljZXMuYwo+IGluZGV4IDU2YmM3Y2MuLjJhNThmODYgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fc2VydmljZXMu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
X3NlcnZpY2VzLmMKPiBAQCAtMTAzLDggKzEwMyw3IEBAIGJvb2wgZG1fcmVhZF9wZXJzaXN0ZW50
X2RhdGEoc3RydWN0IGRjX2NvbnRleHQgKmN0eCwKPiAgdm9pZCBkbV9kZWxheV9pbl9taWNyb3Nl
Y29uZHMoc3RydWN0IGRjX2NvbnRleHQgKmN0eCwKPiAgCQkJCQl1bnNpZ25lZCBpbnQgbWljcm9T
ZWNvbmRzKQo+ICB7Cj4gLQkvKlRPRE8gaW1wbGVtZW50Ki8KPiAtCXJldHVybjsKPiArCXVkZWxh
eShtaWNyb1NlY29uZHMpOwo+ICB9Cj4gIAoKV2UgY2FuIGRyb3AgdGhpcyBjb21wbGV0ZWx5IGFu
ZCByZXBsYWNlIGFsbCBjYWxscyB0byBpdCB3aXRoIHVkZWxheS4KTm90IHN1cmUgd2h5IHdlIGhh
dmUgdGhpcyBpbiB0aGUgZmlyc3QgcGxhY2UuCgpIYXJyeQoKPiAgLyoqKiogcG93ZXIgY29tcG9u
ZW50IGludGVyZmFjZXMgKioqKi8KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
