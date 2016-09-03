From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: [PATCH 4/4] amdkfd: Fix possible dangling ptr in kfd_dbgmgr_destroy()
Date: Sat,  3 Sep 2016 12:49:07 +1000
Message-ID: <1472870947-11300-5-git-send-email-funfunctor@folklore1984.net>
References: <1472870947-11300-1-git-send-email-funfunctor@folklore1984.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472870947-11300-1-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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

U2lnbmVkLW9mZi1ieTogRWR3YXJkIE8nQ2FsbGFnaGFuIDxmdW5mdW5jdG9yQGZvbGtsb3JlMTk4
NC5uZXQ+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RiZ21nci5jIHwgMSAr
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZGJnbWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfZGJnbWdyLmMKaW5kZXggNTZkNjc2My4uOGEyNmQ1YSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RiZ21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9kYmdtZ3IuYwpAQCAtNTgsNiArNTgsNyBAQCB2b2lkIGtmZF9kYmdtZ3Jf
ZGVzdHJveShzdHJ1Y3Qga2ZkX2RiZ21nciAqcG1ncikKIAlpZiAocG1nciAhPSBOVUxMKSB7CiAJ
CWtmZF9kYmdtZ3JfdW5pbml0aWFsaXplKHBtZ3IpOwogCQlrZnJlZShwbWdyKTsKKwkJcG1nciA9
IE5VTEw7CiAJfQogfQogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
