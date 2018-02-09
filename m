From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2] drm/amdgpu: Fix potential uninitialized use of 'idle' in
 amdgpu_ids.c
Date: Fri, 9 Feb 2018 13:49:10 -0500
Message-ID: <20180209184910.21679-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

djI6IFVzZSBOVUxMIGFuZCByZXZlcnNlIGNocmlzdG1hcyB0cmVlIG9yZGVyaW5nCgpTaWduZWQt
b2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMgfCAzICsrLQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9pZHMuYwppbmRleCA3ZDI4MDU3MjljMjAuLjU2M2U3NDc1NWFhYiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lkcy5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYwpAQCAtNDA2LDcgKzQwNiw4IEBAIGlu
dCBhbWRncHVfdm1pZF9ncmFiKHN0cnVjdCBhbWRncHVfdm0gKnZtLCBzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmcsCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2OwogCXVu
c2lnbmVkIHZtaHViID0gcmluZy0+ZnVuY3MtPnZtaHViOwogCXN0cnVjdCBhbWRncHVfdm1pZF9t
Z3IgKmlkX21nciA9ICZhZGV2LT52bV9tYW5hZ2VyLmlkX21nclt2bWh1Yl07Ci0Jc3RydWN0IGFt
ZGdwdV92bWlkICppZCwgKmlkbGU7CisJc3RydWN0IGFtZGdwdV92bWlkICppZGxlID0gTlVMTDsK
KwlzdHJ1Y3QgYW1kZ3B1X3ZtaWQgKmlkID0gTlVMTDsKIAlpbnQgciA9IDA7CiAKIAltdXRleF9s
b2NrKCZpZF9tZ3ItPmxvY2spOwotLSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
