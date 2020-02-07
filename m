Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4799C35250
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 19:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD65217BA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 19:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZsee5xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD65217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C9BD6FD6C;
	Fri,  7 Feb 2020 19:51:11 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D0A6FD71;
 Fri,  7 Feb 2020 19:51:10 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id j20so252154qka.10;
 Fri, 07 Feb 2020 11:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=th/ZgWYLAtD7x9QpC0cnoR2MFKa3NkheKEaS9VVgMWk=;
 b=SZsee5xpM7I5CdhIUV/YI45kivS0/aXXyqCCL74EbQomIbPSTtzBHw00wR272IN+JE
 zjUaTXiBTjJsq23+WrCiE+szAmsiM3g0VvDHCUXNiuHiklF5Gams7Af+7dQ2S8OAk97G
 RVjgRocD0B7qkgtXVty2Lszq1Yc2x4uWj57vjLgbRIlKrIQVQC0p+pWb9rIvS7uA1Dvh
 ZckhO2fe0UVZsKXSdc+jUg0O0SX6Tc+5PquBE4Dqxl2soapaZ39ACBkKZpeoS70X1+9d
 TQI6e2r6glamJJggcBIo3gflaXL8SqiPmn7kgRe5BEnUSQk6SWKzSFNMBfr7Yo1eQJ9B
 wdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=th/ZgWYLAtD7x9QpC0cnoR2MFKa3NkheKEaS9VVgMWk=;
 b=AHSswcQwv7Wlvt9ieECup2oCeIgbdJhxbJTETHtAyLYoZ33LsLJHli4fVxNLD+jRSH
 eS/sxVmxk+FB+qWdvWaf0bR2qsaPXej9Wsz/rlRR9KiuaXp3Uld1u7055F33DFZWbuE1
 xeRff3DoHC89bIBLuWK/2dMquYqKeSmaXwpRNruW3hVKHz1n8TQP1swn2jWNtNXSFZOc
 i7KCfjw9kT6QmQs5cVg7klsWP9Wj+Xru4j0Ka5Nik7h1+unJKUfINmprXkbpf/6cfJ85
 3qWKLEF/Xm6cB2pGMMYu7sKfy53OMKnW4DoITHRkcau+8ski9e7JcvQfOqglvxi9bgg8
 Z97w==
X-Gm-Message-State: APjAAAUXQKXy84nD2Wpi3XwnjrL83YzMzjI+EuNs/lz84tCWILp243wt
 KVBHbgmrABZEATw1W8aezgN0grJ3
X-Google-Smtp-Source: APXvYqyS0ij02u9eMv56it9KwAIFxSxFFiVKtZ+PoaKJhr1fohJeLnIhy9UtXAB0U0RWMbH8USqZow==
X-Received: by 2002:a37:4d85:: with SMTP id a127mr504632qkb.267.1581105068953; 
 Fri, 07 Feb 2020 11:51:08 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id w16sm1752226qkj.135.2020.02.07.11.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 11:51:08 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 03/15] drm/amdgpu/pm: move debugfs init into core amdgpu
 debugfs
Date: Fri,  7 Feb 2020 14:50:46 -0500
Message-Id: <20200207195058.2354-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207195058.2354-1-alexander.deucher@amd.com>
References: <20200207195058.2354-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW4gb3JkZXIgdG8gcmVtb3ZlIHRoZSBsb2FkIGFuZCB1bmxvYWQgZHJtIGNhbGxiYWNrcywKd2Ug
bmVlZCB0byByZW9yZGVyIHRoZSBpbml0IHNlcXVlbmNlIHRvIG1vdmUgYWxsIHRoZSBkcm0KZGVi
dWdmcyBmaWxlIGhhbmRsaW5nLiAgRG8gdGhpcyBmb3IgcG0uCgpBY2tlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyB8IDcgKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3BtLmMgICAgICB8IDkgKy0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcG0uaCAgICAgIHwgMiArKwogMyBmaWxlcyBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGVidWdmcy5jCmluZGV4IGY0OTYwNGMwZDBiOC4uYzFkNjZjYzZlNmQ4IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKQEAgLTMxLDYgKzMx
LDcgQEAKICNpbmNsdWRlIDxkcm0vZHJtX2RlYnVnZnMuaD4KIAogI2luY2x1ZGUgImFtZGdwdS5o
IgorI2luY2x1ZGUgImFtZGdwdV9wbS5oIgogCiAvKioKICAqIGFtZGdwdV9kZWJ1Z2ZzX2FkZF9m
aWxlcyAtIEFkZCBzaW1wbGUgZGVidWdmcyBlbnRyaWVzCkBAIC0xMjM0LDYgKzEyMzUsMTIgQEAg
aW50IGFtZGdwdV9kZWJ1Z2ZzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCXJl
dHVybiByOwogCX0KIAorCXIgPSBhbWRncHVfZGVidWdmc19wbV9pbml0KGFkZXYpOworCWlmIChy
KSB7CisJCURSTV9FUlJPUigiRmFpbGVkIHRvIHJlZ2lzdGVyIGRlYnVnZnMgZmlsZSBmb3IgZHBt
IVxuIik7CisJCXJldHVybiByOworCX0KKwogCXJldHVybiBhbWRncHVfZGVidWdmc19hZGRfZmls
ZXMoYWRldiwgYW1kZ3B1X2RlYnVnZnNfbGlzdCwKIAkJCQkJQVJSQVlfU0laRShhbWRncHVfZGVi
dWdmc19saXN0KSk7CiB9CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCmluZGV4
IGIwM2IxZWI3YmEwNC4uYmMzY2YwNGExYTk0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcG0uYwpAQCAtNDEsOCArNDEsNiBAQAogI2luY2x1ZGUgImh3bWdyLmgiCiAjZGVmaW5l
IFdJRFRIXzRLIDM4NDAKIAotc3RhdGljIGludCBhbWRncHVfZGVidWdmc19wbV9pbml0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KTsKLQogc3RhdGljIGNvbnN0IHN0cnVjdCBjZ19mbGFnX25h
bWUgY2xvY2tzW10gPSB7CiAJe0FNRF9DR19TVVBQT1JUX0dGWF9NR0NHLCAiR3JhcGhpY3MgTWVk
aXVtIEdyYWluIENsb2NrIEdhdGluZyJ9LAogCXtBTURfQ0dfU1VQUE9SVF9HRlhfTUdMUywgIkdy
YXBoaWNzIE1lZGl1bSBHcmFpbiBtZW1vcnkgTGlnaHQgU2xlZXAifSwKQEAgLTMzOTgsMTEgKzMz
OTYsNiBAQCBpbnQgYW1kZ3B1X3BtX3N5c2ZzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiAJCURSTV9FUlJPUigiZmFpbGVkIHRvIGNyZWF0ZSBkZXZpY2UgZmlsZSB1bmlxdWVfaWRc
biIpOwogCQlyZXR1cm4gcmV0OwogCX0KLQlyZXQgPSBhbWRncHVfZGVidWdmc19wbV9pbml0KGFk
ZXYpOwotCWlmIChyZXQpIHsKLQkJRFJNX0VSUk9SKCJGYWlsZWQgdG8gcmVnaXN0ZXIgZGVidWdm
cyBmaWxlIGZvciBkcG0hXG4iKTsKLQkJcmV0dXJuIHJldDsKLQl9CiAKIAlpZiAoKGFkZXYtPmFz
aWNfdHlwZSA+PSBDSElQX1ZFR0ExMCkgJiYKIAkgICAgIShhZGV2LT5mbGFncyAmIEFNRF9JU19B
UFUpKSB7CkBAIC0zNjY5LDcgKzM2NjIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9pbmZv
X2xpc3QgYW1kZ3B1X3BtX2luZm9fbGlzdFtdID0gewogfTsKICNlbmRpZgogCi1zdGF0aWMgaW50
IGFtZGdwdV9kZWJ1Z2ZzX3BtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCitpbnQg
YW1kZ3B1X2RlYnVnZnNfcG1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKICNp
ZiBkZWZpbmVkKENPTkZJR19ERUJVR19GUykKIAlyZXR1cm4gYW1kZ3B1X2RlYnVnZnNfYWRkX2Zp
bGVzKGFkZXYsIGFtZGdwdV9wbV9pbmZvX2xpc3QsIEFSUkFZX1NJWkUoYW1kZ3B1X3BtX2luZm9f
bGlzdCkpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Bt
LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uaAppbmRleCAzZGExZGEy
Nzc4MDUuLjVkYjBlZjg2ZTg0YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3BtLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Bt
LmgKQEAgLTQzLDQgKzQzLDYgQEAgdm9pZCBhbWRncHVfZHBtX2VuYWJsZV91dmQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgZW5hYmxlKTsKIHZvaWQgYW1kZ3B1X2RwbV9lbmFibGVf
dmNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29sIGVuYWJsZSk7CiB2b2lkIGFtZGdw
dV9kcG1fZW5hYmxlX2pwZWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgZW5hYmxl
KTsKIAoraW50IGFtZGdwdV9kZWJ1Z2ZzX3BtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpOworCiAjZW5kaWYKLS0gCjIuMjQuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
