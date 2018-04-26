From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 19/32] drm/amdgpu: add VEGAM to VCE harvest config
Date: Wed, 25 Apr 2018 21:18:24 -0500
Message-ID: <20180426021837.17758-19-alexander.deucher@amd.com>
References: <20180426021837.17758-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180426021837.17758-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgoKU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8
bGVvLmxpdUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYyB8
IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMKaW5kZXggYWM5NjE3MjY5YTJmLi4wOTk5
Yzg0M2Y2MjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18w
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYwpAQCAtMzg4LDcg
KzM4OCw4IEBAIHN0YXRpYyB1bnNpZ25lZCB2Y2VfdjNfMF9nZXRfaGFydmVzdF9jb25maWcoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJZGVmYXVsdDoKIAkJaWYgKChhZGV2LT5hc2ljX3R5
cGUgPT0gQ0hJUF9QT0xBUklTMTApIHx8CiAJCSAgICAoYWRldi0+YXNpY190eXBlID09IENISVBf
UE9MQVJJUzExKSB8fAotCQkgICAgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1BPTEFSSVMxMikp
CisJCSAgICAoYWRldi0+YXNpY190eXBlID09IENISVBfUE9MQVJJUzEyKSB8fAorCQkgICAgKGFk
ZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0FNKSkKIAkJCXJldHVybiBBTURHUFVfVkNFX0hBUlZF
U1RfVkNFMTsKIAogCQlyZXR1cm4gMDsKLS0gCjIuMTMuNgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
