Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D28CA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 21:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E73F2087F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 21:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E73F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D38366E5E7;
	Tue, 29 Oct 2019 21:15:57 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 238816E5E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 21:15:57 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id x14so227665qtq.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 14:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Gd8n2MGwCpWI/7xEqyzSeWXt/1lOH1eHa8JGn61tPWY=;
 b=pA3qS6XDHrRh2W04H13qhU5tB5Hq8jI3j7V+EQm2G/cG7nmiToYc65zu54qmBxhryK
 6+o2WhR5KYcxhbkqbwZCA8GBhXzRbMHoPe+fXmY4RvNBg3FJT/yN/b4SXa4u9qmDSClf
 oWFPMdvx7jdpcP8ykgB6u4SRc1s9Icn3IuQBKGepMGw2fZRTUP+BakklbW7xJN3CCTHZ
 5tWGee26sd7tbgSj0gIwifq90V8HXEzZtEP5g1sNlOecW7hjeE9Ir81om3JvrDB3OTd6
 saOvPrUWFZRd8g0B4amVMZzkM+J5emjQRascz1HMjOhwFo8GjzE0AGLQExUDo+PI30ib
 Qa/Q==
X-Gm-Message-State: APjAAAW9CUmS1LjqUShRwugI5rw2WJL8rsijiC3m2sY0tEyIHd+8OT+f
 nUrxPD/LCQmq2V/dgE5ErloR8rPu
X-Google-Smtp-Source: APXvYqw3Tp1G/0T8uSiQNTYgUvfFsCxDrQvTtPk5lX+1LRpenM8RSJyf+9xKXnnyT+2voEpWOG4HPA==
X-Received: by 2002:ac8:35a4:: with SMTP id k33mr1423180qtb.354.1572383755720; 
 Tue, 29 Oct 2019 14:15:55 -0700 (PDT)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id w15sm10111340qtk.43.2019.10.29.14.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 14:15:55 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gmc10: properly set BANK_SELECT and FRAGMENT_SIZE
Date: Tue, 29 Oct 2019 17:15:44 -0400
Message-Id: <20191029211544.1534432-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Gd8n2MGwCpWI/7xEqyzSeWXt/1lOH1eHa8JGn61tPWY=;
 b=TdT9v5IZXG3+3/+olpVZ/UOcHEm6O7EBk0Hnn+N2Ifc7xEbZ9SWNny53cTyC3wLAlA
 WFX3CbWyUcUbR6cusHrYwAngg7puG8C3Sy0MWqJ3KnomHj2x3HKRd3jN+BIQYwwNpdTr
 5KoAhk/ZlapsJNmJzw9viAxyOMep+2NZOqvJfs/2iVFl1HGQogBCz7E9gYUIjevRk67t
 VmokW+AGAb0IeO4QZ/bKwkqCjHT5/nQHXlv5bxwkW0xeLd0Z32Cuto8F3AyeysWkT01+
 rzpx55mjaJg1d2cxNEG9wkgzj0cSy/El0rvQrNVhsAz/ss3L2bnOvUSoV7kW6PleZsoQ
 hPwA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029211544.6olgd4qaYHiLJrfVHyfBgKLrJq3IaW_ZGh-M3UBc_OA@z>

VGhlc2Ugd2VyZSBub3QgYWxpZ25lZCBmb3Igb3B0aW1hbCBwZXJmb3JtYW5jZSBmb3IgR1BVVk0u
CgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YyXzAuYyB8IDkgKysrKysr
KysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92Ml8wLmMgIHwgOSArKysrKysr
KysKIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92Ml8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhodWJfdjJfMC5jCmluZGV4IGI2MDFjNjc0MGVmNS4uYjRmMzJkODUzY2ExIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjJfMC5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92Ml8wLmMKQEAgLTE1NSw2ICsxNTUs
MTUgQEAgc3RhdGljIHZvaWQgZ2Z4aHViX3YyXzBfaW5pdF9jYWNoZV9yZWdzKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQogCVdSRUczMl9TT0MxNShHQywgMCwgbW1HQ1ZNX0wyX0NOVEwyLCB0
bXApOwogCiAJdG1wID0gbW1HQ1ZNX0wyX0NOVEwzX0RFRkFVTFQ7CisJaWYgKGFkZXYtPmdtYy50
cmFuc2xhdGVfZnVydGhlcikgeworCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgR0NWTV9MMl9D
TlRMMywgQkFOS19TRUxFQ1QsIDEyKTsKKwkJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIEdDVk1f
TDJfQ05UTDMsCisJCQkJICAgIEwyX0NBQ0hFX0JJR0tfRlJBR01FTlRfU0laRSwgOSk7CisJfSBl
bHNlIHsKKwkJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIEdDVk1fTDJfQ05UTDMsIEJBTktfU0VM
RUNULCA5KTsKKwkJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIEdDVk1fTDJfQ05UTDMsCisJCQkJ
ICAgIEwyX0NBQ0hFX0JJR0tfRlJBR01FTlRfU0laRSwgNik7CisJfQogCVdSRUczMl9TT0MxNShH
QywgMCwgbW1HQ1ZNX0wyX0NOVEwzLCB0bXApOwogCiAJdG1wID0gbW1HQ1ZNX0wyX0NOVEw0X0RF
RkFVTFQ7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92Ml8w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92Ml8wLmMKaW5kZXggMmVlYTcw
MmRlOGVlLi45NDU1MzM2MzQ3MTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L21taHViX3YyXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92
Ml8wLmMKQEAgLTE0Miw2ICsxNDIsMTUgQEAgc3RhdGljIHZvaWQgbW1odWJfdjJfMF9pbml0X2Nh
Y2hlX3JlZ3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJV1JFRzMyX1NPQzE1KE1NSFVC
LCAwLCBtbU1NVk1fTDJfQ05UTDIsIHRtcCk7CiAKIAl0bXAgPSBtbU1NVk1fTDJfQ05UTDNfREVG
QVVMVDsKKwlpZiAoYWRldi0+Z21jLnRyYW5zbGF0ZV9mdXJ0aGVyKSB7CisJCXRtcCA9IFJFR19T
RVRfRklFTEQodG1wLCBNTVZNX0wyX0NOVEwzLCBCQU5LX1NFTEVDVCwgMTIpOworCQl0bXAgPSBS
RUdfU0VUX0ZJRUxEKHRtcCwgTU1WTV9MMl9DTlRMMywKKwkJCQkgICAgTDJfQ0FDSEVfQklHS19G
UkFHTUVOVF9TSVpFLCA5KTsKKwl9IGVsc2UgeworCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwg
TU1WTV9MMl9DTlRMMywgQkFOS19TRUxFQ1QsIDkpOworCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRt
cCwgTU1WTV9MMl9DTlRMMywKKwkJCQkgICAgTDJfQ0FDSEVfQklHS19GUkFHTUVOVF9TSVpFLCA2
KTsKKwl9CiAJV1JFRzMyX1NPQzE1KE1NSFVCLCAwLCBtbU1NVk1fTDJfQ05UTDMsIHRtcCk7CiAK
IAl0bXAgPSBtbU1NVk1fTDJfQ05UTDRfREVGQVVMVDsKLS0gCjIuMjMuMAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
