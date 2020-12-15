Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AEAC2BB9A
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 01:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516EE2074B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 01:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516EE2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361236E150;
	Tue, 15 Dec 2020 01:09:07 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC0386E17E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 01:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/QcI6dJPzzq/K7naMNzusiBkgX+KJVXg1EhxUhGNL7E=; b=KTAv8yXmuh3vi12Pibw4+LZMrx
 40CzASpEK2Z9uzBXz3sdjdl0FPQ4t1fskYAyHWIZXOX4Q9Kle7d9hoMmrsr7f8MOCFen2TAEfUm1N
 YeZFoHYBdCj0TwBtyIR3lXfOlh4ANZuial5x6/uS0zDgo3NMidBHzQZjj60dG9jbYAO1DR3Zkiuc7
 04/CH9ck9uelOW/9X9GeHrBHZk7CFkkhL/N4hJ8++QcMAv/3sdNUQmR6057Z83lEIaOGF2YOUF1Hp
 0+ci/hP2ZLskeOcKE3kCHVj1YoHEL60CUsMKQHa3iVpP/n3axbZ2TcN4MQM5dGofGp2J8pI9iZPyJ
 VKnFO/bQ==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1koypr-000334-BD; Tue, 15 Dec 2020 01:09:03 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] amdgpu: resize BAR0 to the maximum available size,
 even if it doesn't cover VRAM (v5)
Date: Tue, 15 Dec 2020 01:08:57 +0000
Message-Id: <20201215010902.18945-4-devspam@moreofthesa.me.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215010902.18945-1-devspam@moreofthesa.me.uk>
References: <20201215010902.18945-1-devspam@moreofthesa.me.uk>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:8b0:897:1650::2
X-SA-Exim-Mail-From: devspam@moreofthesa.me.uk
X-SA-Exim-Scanned: No (on spam.moreofthesa.me.uk);
 SAEximRunCond expanded to false
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Darren Salt <devspam@moreofthesa.me.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBhbGxvd3MgQkFSMCByZXNpemluZyB0byBiZSBkb25lIGZvciBjYXJkcyB3aGljaCBkb24n
dCBhZHZlcnRpc2Ugc3VwcG9ydApmb3IgYSBzaXplIGxhcmdlIGVub3VnaCB0byBjb3ZlciB0aGUg
VlJBTSBidXQgd2hpY2ggZG8gYWR2ZXJ0aXNlIGF0IGxlYXN0Cm9uZSBzaXplIGxhcmdlciB0aGFu
IHRoZSBkZWZhdWx0LiBGb3IgZXhhbXBsZSwgbXkgUlggNTYwMCBYVCwgd2hpY2gKYWR2ZXJ0aXNl
cyAyNTZNQiwgNTEyTUIgYW5kIDFHQi4KClt2NV0gRHJvcCB0aGUgcmV0cnkgbG9vcOKApgoKW3Y0
XSBVc2UgYml0IG9wcyB0byBmaW5kIHNpemVzIHRvIHRyeS4KClt2M10gRG9uJ3QgdXNlIHBjaV9y
ZWJhcl9nZXRfY3VycmVudF9zaXplKCkuCgpbdjJdIFJld3JpdHRlbiB0byB1c2UgUENJIGhlbHBl
ciBmdW5jdGlvbnM7IHNvbWUgZXh0cmEgbG9nIHRleHQuCgpTaWduZWQtb2ZmLWJ5OiBEYXJyZW4g
U2FsdCA8ZGV2c3BhbUBtb3Jlb2Z0aGVzYS5tZS51az4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAzOCArKysrKysrKysrKysrKysrKy0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggNjYzN2I4NGFlYjg1Li5hYzk0
ZjhkYjA2YTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMK
QEAgLTExMDYsOCArMTEwNiw5IEBAIHZvaWQgYW1kZ3B1X2RldmljZV93Yl9mcmVlKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCB1MzIgd2IpCiAgKi8KIGludCBhbWRncHVfZGV2aWNlX3Jlc2l6
ZV9mYl9iYXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7Ci0JdTY0IHNwYWNlX25lZWRl
ZCA9IHJvdW5kdXBfcG93X29mX3R3byhhZGV2LT5nbWMucmVhbF92cmFtX3NpemUpOwotCXUzMiBy
YmFyX3NpemUgPSBvcmRlcl9iYXNlXzIoKChzcGFjZV9uZWVkZWQgPj4gMjApIHwgMSkpIC0gMTsK
KwlpbnQgcmJhcl9zaXplLCBjdXJyZW50X3NpemU7CisJdTY0IGN1cnJlbnRfYnl0ZXM7CisJdTMy
IGF2YWlsYWJsZV9zaXplczsKIAlzdHJ1Y3QgcGNpX2J1cyAqcm9vdDsKIAlzdHJ1Y3QgcmVzb3Vy
Y2UgKnJlczsKIAl1bnNpZ25lZCBpOwpAQCAtMTExOCwxMSArMTExOSwxNSBAQCBpbnQgYW1kZ3B1
X2RldmljZV9yZXNpemVfZmJfYmFyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWlmIChh
bWRncHVfc3Jpb3ZfdmYoYWRldikpCiAJCXJldHVybiAwOwogCi0JLyogc2tpcCBpZiB0aGUgYmlv
cyBoYXMgYWxyZWFkeSBlbmFibGVkIGxhcmdlIEJBUiAqLwotCWlmIChhZGV2LT5nbWMucmVhbF92
cmFtX3NpemUgJiYKLQkgICAgKHBjaV9yZXNvdXJjZV9sZW4oYWRldi0+cGRldiwgMCkgPj0gYWRl
di0+Z21jLnJlYWxfdnJhbV9zaXplKSkKKwljdXJyZW50X2J5dGVzID0gcGNpX3Jlc291cmNlX2xl
bihhZGV2LT5wZGV2LCAwKTsKKworCS8qIFNraXAgaWYgdGhlIEJJT1MgaGFzIGFscmVhZHkgZW5h
YmxlZCBsYXJnZSBCQVIsIGNvdmVyaW5nIHRoZSBWUkFNICovCisJaWYgKGN1cnJlbnRfYnl0ZXMg
Pj0gYWRldi0+Z21jLnJlYWxfdnJhbV9zaXplKQogCQlyZXR1cm4gMDsKIAorCWN1cnJlbnRfc2l6
ZSA9IGN1cnJlbnRfYnl0ZXMgPyBwY2lfcmViYXJfYnl0ZXNfdG9fc2l6ZShjdXJyZW50X2J5dGVz
KSA6IC0xOworCXJiYXJfc2l6ZSA9IHBjaV9yZWJhcl9ieXRlc190b19zaXplKGFkZXYtPmdtYy5y
ZWFsX3ZyYW1fc2l6ZSk7CisKIAkvKiBDaGVjayBpZiB0aGUgcm9vdCBCVVMgaGFzIDY0Yml0IG1l
bW9yeSByZXNvdXJjZXMgKi8KIAlyb290ID0gYWRldi0+cGRldi0+YnVzOwogCXdoaWxlIChyb290
LT5wYXJlbnQpCkBAIC0xMTM4LDYgKzExNDMsMTggQEAgaW50IGFtZGdwdV9kZXZpY2VfcmVzaXpl
X2ZiX2JhcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlpZiAoIXJlcykKIAkJcmV0dXJu
IDA7CiAKKwlhdmFpbGFibGVfc2l6ZXMgPSBwY2lfcmViYXJfZ2V0X3Bvc3NpYmxlX3NpemVzKGFk
ZXYtPnBkZXYsIDApOworCWlmIChhdmFpbGFibGVfc2l6ZXMgPT0gMCkKKwkJcmV0dXJuIDA7CisK
KwkvKiBGaW5kIHRoZSBiaXQgcG9zIHJlcHJlc2VudGluZyB0aGUgc21hbGxlc3Qgc2l6ZSBjb3Zl
cmluZyB0aGUgVlJBTS4KKwkgKiBPdGhlcndpc2UgZmluZCB0aGUgYml0IHBvcyByZXByZXNlbnRp
bmcgdGhlIGxhcmdlc3QgYXZhaWxhYmxlIHNpemUuCisJICogcmJhcl9zaXplIG1heSBiZSBzbWFs
bGVyIGJ1dCBzaG91bGQgYmUgdW5jaGFuZ2VkLgorCSAqLworCXJiYXJfc2l6ZSA9IChmZnMoYXZh
aWxhYmxlX3NpemVzICYgKC0xIDw8IHJiYXJfc2l6ZSkpID8gOiBmbHMoYXZhaWxhYmxlX3NpemVz
KSkgLSAxOworCWlmIChyYmFyX3NpemUgPCAwKQorCQlyZXR1cm4gMDsgLyogY2FuJ3QgaGFwcGVu
ICovCisKIAkvKiBEaXNhYmxlIG1lbW9yeSBkZWNvZGluZyB3aGlsZSB3ZSBjaGFuZ2UgdGhlIEJB
UiBhZGRyZXNzZXMgYW5kIHNpemUgKi8KIAlwY2lfcmVhZF9jb25maWdfd29yZChhZGV2LT5wZGV2
LCBQQ0lfQ09NTUFORCwgJmNtZCk7CiAJcGNpX3dyaXRlX2NvbmZpZ193b3JkKGFkZXYtPnBkZXYs
IFBDSV9DT01NQU5ELApAQCAtMTE1MSwxMCArMTE2OCwxMyBAQCBpbnQgYW1kZ3B1X2RldmljZV9y
ZXNpemVfZmJfYmFyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCXBjaV9yZWxlYXNlX3Jl
c291cmNlKGFkZXYtPnBkZXYsIDApOwogCiAJciA9IHBjaV9yZXNpemVfcmVzb3VyY2UoYWRldi0+
cGRldiwgMCwgcmJhcl9zaXplKTsKLQlpZiAociA9PSAtRU5PU1BDKQotCQlEUk1fSU5GTygiTm90
IGVub3VnaCBQQ0kgYWRkcmVzcyBzcGFjZSBmb3IgYSBsYXJnZSBCQVIuIik7Ci0JZWxzZSBpZiAo
ciAmJiByICE9IC1FTk9UU1VQUCkKLQkJRFJNX0VSUk9SKCJQcm9ibGVtIHJlc2l6aW5nIEJBUjAg
KCVkKS4iLCByKTsKKwlpZiAociA9PSAtRU5PVFNVUFApIHsKKwkJZGV2X2luZm8oYWRldi0+ZGV2
LCAiQkFSIHJlc2l6aW5nIG5vdCBzdXBwb3J0ZWQuIik7CisJfSBlbHNlIGlmIChyID09IC1FTk9T
UEMpIHsKKwkJZGV2X2luZm8oYWRldi0+ZGV2LCAiTm90IGVub3VnaCBQQ0kgYWRkcmVzcyBzcGFj
ZSBmb3IgYSBsYXJnZSBCQVIuIik7CisJfSBlbHNlIGlmIChyKSB7CisJCWRldl9lcnIoYWRldi0+
ZGV2LCAiUHJvYmxlbSByZXNpemluZyBCQVIwICglZCkuIiwgcik7CisJfQogCiAJcGNpX2Fzc2ln
bl91bmFzc2lnbmVkX2J1c19yZXNvdXJjZXMoYWRldi0+cGRldi0+YnVzKTsKIAotLSAKMi4yMC4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
