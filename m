From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 27/34] drm/amd/display: Add num_active_wb to DML
Date: Tue, 20 Mar 2018 15:12:52 -0400
Message-ID: <20180320191259.14453-28-harry.wentland@amd.com>
References: <20180320191259.14453-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180320191259.14453-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Eric Bernstein <eric.bernstein-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRXJpYyBCZXJuc3RlaW4gPGVyaWMuYmVybnN0ZWluQGFtZC5jb20+CgpTaWduZWQtb2Zm
LWJ5OiBFcmljIEJlcm5zdGVpbiA8ZXJpYy5iZXJuc3RlaW5AYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IFRvbnkgQ2hlbmcgPFRvbnkuQ2hlbmdAYW1kLmNvbT4KQWNrZWQtYnk6IEhhcnJ5IFdlbnRsYW5k
IDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kbWwvZGlzcGxheV9tb2RlX3N0cnVjdHMuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RtbC9kaXNwbGF5X21vZGVfc3RydWN0cy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RtbC9kaXNwbGF5X21vZGVfc3RydWN0cy5oCmluZGV4IGUyOTZkZTZjYTUwMi4uY2U3NTBl
ZGMxZTVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rp
c3BsYXlfbW9kZV9zdHJ1Y3RzLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RtbC9kaXNwbGF5X21vZGVfc3RydWN0cy5oCkBAIC0yMjQsNiArMjI0LDcgQEAgc3RydWN0CV92
Y3NfZHBpX2Rpc3BsYXlfb3V0cHV0X3BhcmFtc19zdAl7CiAJaW50CW91dHB1dF9icHA7CiAJaW50
CWRzY19lbmFibGU7CiAJaW50CXdiX2VuYWJsZTsKKwlpbnQJbnVtX2FjdGl2ZV93YjsKIAlpbnQJ
b3BwX2lucHV0X2JwYzsKIAlpbnQJb3V0cHV0X3R5cGU7CiAJaW50CW91dHB1dF9mb3JtYXQ7Ci0t
IAoyLjE0LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
