From: zhengbin <zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/5] drm/amd/powerplay: Remove unneeded variable 'ret' in
 smu7_hwmgr.c
Date: Wed, 27 Nov 2019 17:33:40 +0800
Message-ID: <1574847222-51515-4-git-send-email-zhengbin13@huawei.com>
References: <1574847222-51515-1-git-send-email-zhengbin13@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1574847222-51515-1-git-send-email-zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, rex.zhu-5C7GfCeVMHo@public.gmane.org, evan.quan-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org

Rml4ZXMgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
aHdtZ3Ivc211N19od21nci5jOjUxODg6NS04OiBVbm5lZWRlZCB2YXJpYWJsZTogInJldCIuIFJl
dHVybiAiMCIgb24gbGluZSA1MTk2CgpSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1
YXdlaS5jb20+ClNpZ25lZC1vZmYtYnk6IHpoZW5nYmluIDx6aGVuZ2JpbjEzQGh1YXdlaS5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jIHwg
NCArLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21n
ci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jCmlu
ZGV4IGMzZjU4NjYuLmQ3MGFiYWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9od21nci9zbXU3X2h3bWdyLmMKQEAgLTUxODUsMTMgKzUxODUsMTEgQEAgdWludDhfdCBz
bXU3X2dldF9zbGVlcF9kaXZpZGVyX2lkX2Zyb21fY2xvY2sodWludDMyX3QgY2xvY2ssCgogaW50
IHNtdTdfaW5pdF9mdW5jdGlvbl9wb2ludGVycyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogewot
CWludCByZXQgPSAwOwotCiAJaHdtZ3ItPmh3bWdyX2Z1bmMgPSAmc211N19od21ncl9mdW5jczsK
IAlpZiAoaHdtZ3ItPnBwX3RhYmxlX3ZlcnNpb24gPT0gUFBfVEFCTEVfVjApCiAJCWh3bWdyLT5w
cHRhYmxlX2Z1bmMgPSAmcHB0YWJsZV9mdW5jczsKIAllbHNlIGlmIChod21nci0+cHBfdGFibGVf
dmVyc2lvbiA9PSBQUF9UQUJMRV9WMSkKIAkJaHdtZ3ItPnBwdGFibGVfZnVuYyA9ICZwcHRhYmxl
X3YxXzBfZnVuY3M7CgotCXJldHVybiByZXQ7CisJcmV0dXJuIDA7CiB9Ci0tCjIuNy40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
