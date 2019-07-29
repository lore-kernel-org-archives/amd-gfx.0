From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 15/30] drm/amd/powerplay: support VCN powergate status
 retrieval for SW SMU
Date: Mon, 29 Jul 2019 15:14:53 -0500
Message-ID: <20190729201508.16136-16-alexander.deucher@amd.com>
References: <20190729201508.16136-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190729201508.16136-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KCkNvbW1vbmx5IHVzZWQgZm9yIFZD
TiBwb3dlcmdhdGUgc3RhdHVzIHJldHJpZXZhbCBmb3IgU1cgU01VLgoKU2lnbmVkLW9mZi1ieTog
RXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEtlbm5ldGggRmVuZyA8
a2VubmV0aC5mZW5nQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9h
bWRncHVfc211LmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKaW5kZXggOGViZmU0MWE0
ZGM5Li4zZjYxNWQ0NjI0YzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2FtZGdwdV9zbXUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRn
cHVfc211LmMKQEAgLTQyNCw2ICs0MjQsMTAgQEAgaW50IHNtdV9jb21tb25fcmVhZF9zZW5zb3Io
c3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGVudW0gYW1kX3BwX3NlbnNvcnMgc2Vuc29yLAogCQkq
KHVpbnQzMl90ICopZGF0YSA9IHNtdV9mZWF0dXJlX2lzX2VuYWJsZWQoc211LCBTTVVfRkVBVFVS
RV9EUE1fVkNFX0JJVCkgPyAxIDogMDsKIAkJKnNpemUgPSA0OwogCQlicmVhazsKKwljYXNlIEFN
REdQVV9QUF9TRU5TT1JfVkNOX1BPV0VSX1NUQVRFOgorCQkqKHVpbnQzMl90ICopZGF0YSA9IHNt
dV9mZWF0dXJlX2lzX2VuYWJsZWQoc211LCBTTVVfRkVBVFVSRV9WQ05fUEdfQklUKSA/IDEgOiAw
OworCQkqc2l6ZSA9IDQ7CisJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCXJldCA9IC1FSU5WQUw7CiAJ
CWJyZWFrOwotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
