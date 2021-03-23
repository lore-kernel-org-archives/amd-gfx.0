Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B9C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 14:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889876197F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 14:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889876197F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4C06E902;
	Tue, 23 Mar 2021 14:55:02 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F5E6E900
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 14:55:00 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id w3so27589304ejc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g9I1tUpyL9eaYIdSDwfJUfVZpIRfEsNJVUwrNa8qPkY=;
 b=e4ijnEgw+sVcDd2EBr88Wj1kcQVTXCKfnoXOhjdEZswJsE6kzszLi38dy+/Q8Qg+7O
 Erfz8Zk4Dn9jE2ALHG/T+OUaoljo76xcN10+4mNwnB6c6jD2z5F8O5YrzjgJXampkSQ6
 LjCiS5iCNz4V8iCKsQh6y23ucChNRONg46xrSvf6LV1PSoN+WlBrPQD73dwLqS7y6/iV
 mpAuiLIsdz6J0atzUssabt5Ww34pP2jqlKf5XxlsUAALCysSCTAEAednMypndzQJENQf
 ru6KYAmtbbXXc5j02rj6Pf1svy4g8b/tOrRUAtnUaUTlV63IEwJ3lgkxiNGSeKGh3EzL
 CXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g9I1tUpyL9eaYIdSDwfJUfVZpIRfEsNJVUwrNa8qPkY=;
 b=DpCmNhO45jAGUSmT4pdtTu4lC9qZpXCkZUIpHH3g/cLBImWqlo5p1/5CeyMkaL9bW4
 T0SkpidG7wTDuVROOUDUW1SzwdEz1AJAwkfGuZuVCUkPP9zC28SgoUgkHJbwqZBESTQj
 OUsEjuCWA4MNT5WlXvbATf6spL+aPvCl2uDxiWOOIZfu6O/+KcPuTVgviH86r9fMLlIl
 rGOPMqh0a2qt6BnPhVO21a7B+gf2zMfUGkTz7livbA5W84j+5du1De1CVBJhMgkMzneP
 mI6qn61Nxid7T22bl1gVsMQegDdWPxRFYdRT8gM5izPUEYfDfAN56mYSMVxtvBB8G3Zm
 TRHQ==
X-Gm-Message-State: AOAM530YzcCZ0JOYTxeU99VI+bkZZ6qNbWv18s+Ko+ui/CuVmqU0QLVD
 xaoyjfkSz4Ty75QwmfkOXs2e+YVLzok=
X-Google-Smtp-Source: ABdhPJx3FwZalwTCGwldZGX43roXr1K+bTLRwF/hnurTz8LT+MvNcfvw5TtaD7+bo/OxdECim5pvQw==
X-Received: by 2002:a17:906:688:: with SMTP id u8mr5210677ejb.38.1616511299482; 
 Tue, 23 Mar 2021 07:54:59 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:8d10:1bcf:598:9db5])
 by smtp.gmail.com with ESMTPSA id n26sm12955152eds.22.2021.03.23.07.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Mar 2021 07:54:59 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: use zero as start for dummy resource walks
Date: Tue, 23 Mar 2021 15:54:57 +0100
Message-Id: <20210323145458.38910-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: nirmodas@amd.com, Guchun.Chen@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2hlbiB3ZSBkb24ndCBoYXZlIGEgcGh5c2ljYWxseSBiYWNraW5nIHN0b3JlIHdlIHNob3VsZCB1
c2UgemVybyBpbnN0ZWFkCm9mIHRoZSB2aXJ0dWFsIHN0YXJ0IGFkZHJlc3Mgc2luY2UgdGhhdCBp
c24ndCBuZWNlc3NhcnkgYSB2YWxpZCBwaHlzaWNhbApvbmUuCgpTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc19jdXJzb3IuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oCmluZGV4IDQwZjJhZGYzMDViYy4uZTk0MzYyY2Nm
OWQ1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1
cnNvci5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29y
LmgKQEAgLTU0LDcgKzU0LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGFtZGdwdV9yZXNfZmlyc3Qo
c3RydWN0IHR0bV9yZXNvdXJjZSAqcmVzLAogCXN0cnVjdCBkcm1fbW1fbm9kZSAqbm9kZTsKIAog
CWlmICghcmVzIHx8ICFyZXMtPm1tX25vZGUpIHsKLQkJY3VyLT5zdGFydCA9IHN0YXJ0OworCQlj
dXItPnN0YXJ0ID0gMDsKIAkJY3VyLT5zaXplID0gc2l6ZTsKIAkJY3VyLT5yZW1haW5pbmcgPSBz
aXplOwogCQljdXItPm5vZGUgPSBOVUxMOwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
