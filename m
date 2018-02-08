From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/10] drm/amd/pp: Enable auto automan feature on Polaris
Date: Thu, 8 Feb 2018 17:14:19 +0800
Message-ID: <1518081259-18120-11-git-send-email-Rex.Zhu@amd.com>
References: <1518081259-18120-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1518081259-18120-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNjliMjRjZTY1ZGRiMzYxYTg5ZTVhYzliMTk3YWU2ZGY5YjYwYTllNQpTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2h3bWdyL2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9od21n
ci5jCmluZGV4IGY1MGI2Y2QuLjU0OWU4MzAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2h3bWdyL2h3bWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvaHdtZ3IvaHdtZ3IuYwpAQCAtMTAyMyw2ICsxMDIzLDEwIEBAIGludCBwb2xhcmlzX3Nl
dF9hc2ljX3NwZWNpYWxfY2FwcyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogCQlwaG1fY2FwX3Nl
dChod21nci0+cGxhdGZvcm1fZGVzY3JpcHRvci5wbGF0Zm9ybUNhcHMsCiAJCQkJCQkJUEhNX1Bs
YXRmb3JtQ2Fwc19UQ1BSYW1waW5nKTsKIAl9CisKKwlpZiAoaHdtZ3ItPmZlYXR1cmVfbWFzayAm
IFBQX0FVVE9XQVRUTUFOX01BU0spCisJCWh3bWdyLT5hdXRvd2F0dG1hbl9lbmFibGVkID0gdHJ1
ZTsgLyogY3VycmVudGx5IG9ubHkgZW5hYmxlZCBvbiBwb2xhcmlzICovCisKIAlyZXR1cm4gMDsK
IH0KIAotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
