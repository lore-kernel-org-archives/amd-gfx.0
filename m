Return-Path: <SRS0=VV5o=DU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE369C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 17:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356EA2531B
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 17:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN5L2rLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356EA2531B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86C56E917;
	Tue, 13 Oct 2020 17:08:24 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5FF6E917
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 17:08:23 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id l24so229232edj.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DlXI5GOALQmeRn6obakiwX/6B8uX7GKpydixydTR5No=;
 b=hN5L2rLwWonQBmQtWyatqIHI/53m6a4YXbqiqHdk+3AsCk2XAID2ZiMIXc7RZOqVMZ
 IsPiezvRWYfFS//MIKWB96UQGagSlz+7olCiVtlWTEx/7ALwWAz3v29PWHdX/uy/yx/f
 0fx0mwZggWk/w10zai9qsFKGhBZ2t8Wqoju0Nhn0MDLcZwzGXzKHt1CMk1j0tAqmIuQE
 G/LsZDjDaaYOw9syuKyNN3MHF7s5umfhYjwdJyVpad7FA7nj15OQYqeq8dDXt9TujmAS
 b0a12EZw/5pWtyyt13hTKli7BaCahNkwxQNvmH2m5hrqA3MCaixfJ19sAXi9/iJc2ed1
 q4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DlXI5GOALQmeRn6obakiwX/6B8uX7GKpydixydTR5No=;
 b=ehYFdrioxjDvtuSWgSCFEbmeFF41AO9yFn2mVbbBOH/ygXUaBOG5Zq6qnIfQ22KawL
 MVVfUuYqma3agLdYAfRcfVQLuEbjtHxK85nhcwc6OnGrdXrxgRuK9dooCb6ItCwuKZ2D
 vo6SRVvvgmPkF1UW8haIXa0QAJGfyhyLeAey8nX0vTZ+j0o5felY4htW+EDCulOeZqyF
 KVB/lsnRwcaXtOm+Ej80UZxPPQxm+HrB5FM/MpO9LMDDtDUEPsibQJLlLFuUXxl3O5C4
 Fal+a/zd4OuKn5Y/yozy77JkUxh7o6FFyOJ1ImHx/A7UeZlDGq4iT+t/v6mnbG3KO7g9
 yqQw==
X-Gm-Message-State: AOAM533jREBtNQhQfYkhBXexlOave4LmdF1cdhjTXVpfjA9eNkpqSzts
 /RfVbRCYN5wNq52akbHEL+mhR+R986w=
X-Google-Smtp-Source: ABdhPJxGIYzXE6NTGoe20ZIqXyOPDHLMoGeF/FvtNohFH4+b0Kukv/8YcMhUo2C1LTQpj1W3pDpUbQ==
X-Received: by 2002:a05:6402:1c1b:: with SMTP id
 ck27mr577199edb.218.1602608901742; 
 Tue, 13 Oct 2020 10:08:21 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:9711:d7bf:4386:539c])
 by smtp.gmail.com with ESMTPSA id bt16sm281238ejb.89.2020.10.13.10.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 10:08:21 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: increase the reserved VM size to 2MB
Date: Tue, 13 Oct 2020 19:08:19 +0200
Message-Id: <20201013170820.1548-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Madhav.Chauhan@amd.com, xinhui.pan@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SWRlYWxseSB0aGlzIHNob3VsZCBiZSBhIG11bHRpcGxlIG9mIHRoZSBWTSBibG9jayBzaXplLgoy
TUIgc2hvdWxkIGF0IGxlYXN0IGZpdCBmb3IgVmVnYS9OYXZpLgoKU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmgKaW5kZXggN2M0NjkzN2MxYzBlLi44MWNjZDBhMGMzZGIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCkBAIC0xMTIsOCArMTEyLDggQEAgc3RydWN0IGFtZGdw
dV9ib19saXN0X2VudHJ5OwogI2RlZmluZSBBTURHUFVfTU1IVUJfMAkJCQkxCiAjZGVmaW5lIEFN
REdQVV9NTUhVQl8xCQkJCTIKIAotLyogaGFyZGNvZGUgdGhhdCBsaW1pdCBmb3Igbm93ICovCi0j
ZGVmaW5lIEFNREdQVV9WQV9SRVNFUlZFRF9TSVpFCQkJKDFVTEwgPDwgMjApCisvKiBSZXNlcnZl
IDJNQiBhdCB0b3AvYm90dG9tIG9mIGFkZHJlc3Mgc3BhY2UgZm9yIGtlcm5lbCB1c2UgKi8KKyNk
ZWZpbmUgQU1ER1BVX1ZBX1JFU0VSVkVEX1NJWkUJCQkoMlVMTCA8PCAyMCkKIAogLyogbWF4IHZt
aWRzIGRlZGljYXRlZCBmb3IgcHJvY2VzcyAqLwogI2RlZmluZSBBTURHUFVfVk1fTUFYX1JFU0VS
VkVEX1ZNSUQJMQotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
