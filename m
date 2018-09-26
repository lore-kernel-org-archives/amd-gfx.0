From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/16] drm/amd/display: Add a check-function for virtual
 signal type
Date: Wed, 26 Sep 2018 13:42:04 -0400
Message-ID: <1537983737-17773-4-git-send-email-sunpeng.li@amd.com>
References: <1537983737-17773-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1537983737-17773-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Nikola Cornij <nikola.cornij-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTmlrb2xhIENvcm5paiA8bmlrb2xhLmNvcm5pakBhbWQuY29tPgoKW3doeV0KU2FtZSBm
dW5jdGlvbnMgZXhpc3QgZm9yIGFsbCBvdGhlciBzaWduYWwgdHlwZXMuCgpbaG93XQpBZGQgYSBm
dW5jdGlvbiB0aGF0IGNoZWNrcyBhZ2FpbnN0IHZpcnR1YWwgc2lnbmFsIHR5cGUuCgpTaWduZWQt
b2ZmLWJ5OiBOaWtvbGEgQ29ybmlqIDxuaWtvbGEuY29ybmlqQGFtZC5jb20+ClJldmlld2VkLWJ5
OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvaW5jbHVkZS9zaWduYWxfdHlwZXMuaCB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
aW5jbHVkZS9zaWduYWxfdHlwZXMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNs
dWRlL3NpZ25hbF90eXBlcy5oCmluZGV4IDAzNDc2YjEuLmY1NmQyODkgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL3NpZ25hbF90eXBlcy5oCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL3NpZ25hbF90eXBlcy5oCkBAIC0xMDIs
NCArMTAyLDkgQEAgc3RhdGljIGlubGluZSBib29sIGRjX2lzX2F1ZGlvX2NhcGFibGVfc2lnbmFs
KGVudW0gc2lnbmFsX3R5cGUgc2lnbmFsKQogCQlkY19pc19oZG1pX3NpZ25hbChzaWduYWwpKTsK
IH0KIAorc3RhdGljIGlubGluZSBib29sIGRjX2lzX3ZpcnR1YWxfc2lnbmFsKGVudW0gc2lnbmFs
X3R5cGUgc2lnbmFsKQoreworCXJldHVybiAoc2lnbmFsID09IFNJR05BTF9UWVBFX1ZJUlRVQUwp
OworfQorCiAjZW5kaWYKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
