From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 05/21] drm/amdgpu: add JPEG IP block type
Date: Tue, 12 Nov 2019 13:03:13 -0500
Message-ID: <20191112180329.3927-6-leo.liu@amd.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191112180329.3927-1-leo.liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbSBWQ04yLjAsIEpQRUcyLjAgaXMgYSBzZXBhcmF0ZWQgSVAgYmxvY2suCgpTaWduZWQtb2Zm
LWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9p
bmNsdWRlL2FtZF9zaGFyZWQuaCB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNs
dWRlL2FtZF9zaGFyZWQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVk
LmgKaW5kZXggZGM3ZWIyOGYwMjk2Li5kNWJjOGJlNGQ3MGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9pbmNsdWRlL2FtZF9zaGFyZWQuaApAQCAtNTMsNyArNTMsOCBAQCBlbnVtIGFtZF9pcF9ibG9j
a190eXBlIHsKIAlBTURfSVBfQkxPQ0tfVFlQRV9WQ0UsCiAJQU1EX0lQX0JMT0NLX1RZUEVfQUNQ
LAogCUFNRF9JUF9CTE9DS19UWVBFX1ZDTiwKLQlBTURfSVBfQkxPQ0tfVFlQRV9NRVMKKwlBTURf
SVBfQkxPQ0tfVFlQRV9NRVMsCisJQU1EX0lQX0JMT0NLX1RZUEVfSlBFRwogfTsKIAogZW51bSBh
bWRfY2xvY2tnYXRpbmdfc3RhdGUgewotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
