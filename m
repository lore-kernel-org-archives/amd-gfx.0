From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 13/30] drm/amd/powerplay: add new sensor type for VCN
 powergate status
Date: Mon, 29 Jul 2019 15:14:51 -0500
Message-ID: <20190729201508.16136-14-alexander.deucher@amd.com>
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

RnJvbTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KClZDTiBpcyB3aWRlbHkgdXNlZCBp
biBuZXcgQVNJQ3MgYW5kIGRpZmZlcmVudCBmcm9tIHRyYW5kaXRpb25hbApVVkQgYW5kIFZDRS4K
ClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+ClJldmlld2VkLWJ5
OiBLZW5uZXRoIEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9pbmNsdWRlL2tnZF9wcF9pbnRlcmZhY2UuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2tn
ZF9wcF9pbnRlcmZhY2UuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50
ZXJmYWNlLmgKaW5kZXggOTVlZGMzZDNhOWM0Li5iYmExMjkxYWU0MDUgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9pbmNsdWRlL2tnZF9wcF9pbnRlcmZhY2UuaApAQCAtMTIzLDYgKzEyMyw3
IEBAIGVudW0gYW1kX3BwX3NlbnNvcnMgewogCUFNREdQVV9QUF9TRU5TT1JfRU5BQkxFRF9TTUNf
RkVBVFVSRVNfTUFTSywKIAlBTURHUFVfUFBfU0VOU09SX01JTl9GQU5fUlBNLAogCUFNREdQVV9Q
UF9TRU5TT1JfTUFYX0ZBTl9SUE0sCisJQU1ER1BVX1BQX1NFTlNPUl9WQ05fUE9XRVJfU1RBVEUs
CiB9OwogCiBlbnVtIGFtZF9wcF90YXNrIHsKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
