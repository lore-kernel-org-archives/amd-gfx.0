From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: fix issue dpm blocked by no led config.
Date: Tue, 21 Mar 2017 09:51:12 -0400
Message-ID: <1490104273-335-3-git-send-email-alexander.deucher@amd.com>
References: <1490104273-335-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490104273-335-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgoKc29tZSBjYXJkcyBkb24ndCBzdXBwb3J0
IGxlZCBjb25maWcuCnNvIG5vdCByZXR1cm4gZXJyb3IgaW4gdGhpcyBjYXNlLgoKU2lnbmVkLW9m
Zi1ieTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jCmluZGV4IDRiZWNkNTcuLjQzZmRiYjEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21n
ci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21n
ci5jCkBAIC04NzMsNyArODczLDcgQEAgc3RhdGljIGludCB2ZWdhMTBfc2V0dXBfZHBtX2xlZF9j
b25maWcoc3RydWN0IHBwX2h3bWdyICpod21ncikKIAlwcF90YWJsZS0+TGVkUGluMCA9ICh1aW50
OF90KShtYXNrICYgMHhmZik7CiAJcHBfdGFibGUtPkxlZFBpbjEgPSAodWludDhfdCkoKG1hc2sg
Pj4gOCkgJiAweGZmKTsKIAlwcF90YWJsZS0+TGVkUGluMiA9ICh1aW50OF90KSgobWFzayA+PiAx
NikgJiAweGZmKTsKLQlyZXR1cm4gcmV0OworCXJldHVybiAwOwogfQogCiBzdGF0aWMgaW50IHZl
Z2ExMF9zZXR1cF9hc2ljX3Rhc2soc3RydWN0IHBwX2h3bWdyICpod21ncikKLS0gCjIuNS41Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
