From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 31/31] drm/amd/display: No need to assert on stream_status
Date: Tue, 23 May 2017 10:09:09 -0400
Message-ID: <20170523140909.9924-32-harry.wentland@amd.com>
References: <20170523140909.9924-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170523140909.9924-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

VGhpcyB3aWxsIGJlIE5VTEwgb24gYSBuZXcgc3RyZWFtLiBEQyBoYW5kbGVzIGl0IGdyYWNlZnVs
bHkuCgpTaWduZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV90
eXBlcy5jIHwgMyAtLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3R5cGVz
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV90eXBl
cy5jCmluZGV4IDVkMzRjZTZjN2ZhZi4uNzE4MjQyNWJiY2MyIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV90eXBlcy5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3R5cGVzLmMKQEAg
LTMwNjQsOSArMzA2NCw2IEBAIHN0YXRpYyBlbnVtIHN1cmZhY2VfdXBkYXRlX3R5cGUgIGFtZGdw
dV9kbV9jaGVja19zdXJmYWNlc191cGRhdGVfdHlwZSgKIAkJCWRjX3N0cmVhbV9nZXRfc3RhdHVz
KGRjX3N0cmVhbSk7CiAJZW51bSBzdXJmYWNlX3VwZGF0ZV90eXBlIHVwZGF0ZV90eXBlOwogCi0J
QVNTRVJUKHN0cmVhbV9zdGF0dXMpOwotCi0KIAltZW1zZXQoc3JmX3VwZGF0ZXMsIDAsIHNpemVv
ZihzcmZfdXBkYXRlcykpOwogCW1lbXNldChmbGlwX2FkZHIsIDAsIHNpemVvZihmbGlwX2FkZHIp
KTsKIAltZW1zZXQocGxhbmVfaW5mbywgMCwgc2l6ZW9mKHBsYW5lX2luZm8pKTsKLS0gCjIuMTEu
MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
