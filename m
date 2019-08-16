From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] drm/amd/powerplay: set Arcturus default fclk as bootup
 value on dpm disabled
Date: Fri, 16 Aug 2019 14:08:07 +0800
Message-ID: <20190816060807.11922-4-evan.quan@amd.com>
References: <20190816060807.11922-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190816060807.11922-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

T24gZmNsayBkcG0gZGlzYWJsZWQsIHRoZSBkZWZhdWx0IGRwbSB0YWJsZSB3aWxsIGJlIHNldHVw
IHdpdGggb25seSBvbmUKbGV2ZWwgYW5kIGNsb2NrIGZyZXF1ZW5jeSBhcyBib290dXAgdmFsdWUu
CgpDaGFuZ2UtSWQ6IEllY2Y3NGFhNWJkMTBjOWFhNzgzOWJjMzI4NzdjZmE5OWJjYmVmNGIzClNp
Z25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgfCAzICsrLQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKaW5kZXggOTEwN2JlYmE2NzkwLi5kYjhiZTZkOGQ5
MDMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3Bw
dC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jCkBA
IC00NjMsNyArNDYzLDggQEAgc3RhdGljIGludCBhcmN0dXJ1c19zZXRfZGVmYXVsdF9kcG1fdGFi
bGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpCiAJCQlyZXR1cm4gcmV0OwogCQl9CiAJfSBlbHNl
IHsKLQkJc2luZ2xlX2RwbV90YWJsZS0+Y291bnQgPSAwOworCQlzaW5nbGVfZHBtX3RhYmxlLT5j
b3VudCA9IDE7CisJCXNpbmdsZV9kcG1fdGFibGUtPmRwbV9sZXZlbHNbMF0udmFsdWUgPSBzbXUt
PnNtdV90YWJsZS5ib290X3ZhbHVlcy5mY2xrIC8gMTAwOwogCX0KIAlhcmN0dXJ1c19pbml0X3Np
bmdsZV9kcG1fc3RhdGUoJihzaW5nbGVfZHBtX3RhYmxlLT5kcG1fc3RhdGUpKTsKIAotLSAKMi4y
Mi4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
