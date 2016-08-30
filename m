From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 08/14] drm/amdgpu: fix the tahiti specific value of
 DEEP_SLEEP_CLK_SEL field
Date: Tue, 30 Aug 2016 19:50:05 +0800
Message-ID: <1472557811-8015-9-git-send-email-ray.huang@amd.com>
References: <1472557811-8015-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472557811-8015-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Hui Yu <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJYjViNjE0NmZhNzEyMTkyZGVjMTIwNzAyODMxMjUyZDkyMjEzMzViYgpTaWdu
ZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jIHwgOCArKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NpX2RwbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBt
LmMKaW5kZXggMTc2NGMwYi4uOTA4NDJjMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc2lfZHBtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBt
LmMKQEAgLTQxNzMsNyArNDE3MywxMyBAQCBzdGF0aWMgdm9pZCBzaV9wcm9ncmFtX3Jlc3BvbnNl
X3RpbWVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogc3RhdGljIHZvaWQgc2lfcHJvZ3Jh
bV9kc19yZWdpc3RlcnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJc3RydWN0IGV2
ZXJncmVlbl9wb3dlcl9pbmZvICplZ19waSA9IGV2ZXJncmVlbl9nZXRfcGkoYWRldik7Ci0JdTMy
IHRtcCA9IDE7IC8qIFhYWDogMHgxMCBvbiB0YWhpdGkgQTAgKi8KKwl1MzIgdG1wOworCisJLyog
REVFUF9TTEVFUF9DTEtfU0VMIGZpZWxkIHNob3VsZCBiZSAweDEwIG9uIHRhaGl0aSBBMCAqLwor
CWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9UQUhJVEkgJiYgYWRldi0+cmV2X2lkID09IDB4
MCkKKwkJdG1wID0gMHgxMDsKKwllbHNlCisJCXRtcCA9IDB4MTsKIAogCWlmIChlZ19waS0+c2Ns
a19kZWVwX3NsZWVwKSB7CiAJCVdSRUczMl9QKE1JU0NfQ0xLX0NOVEwsIERFRVBfU0xFRVBfQ0xL
X1NFTCh0bXApLCB+REVFUF9TTEVFUF9DTEtfU0VMX01BU0spOwotLSAKMi43LjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
