Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015CFC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A066720784
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A066720784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B81989E50;
	Mon,  4 Jan 2021 17:53:49 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD50489E50
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 17:53:47 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id 19so24135851qkm.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Jan 2021 09:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gtOpQPkGKX0yFz5Psq93dvrHxw5YWixBARcxD8TTPD4=;
 b=HXyNl/ZsiKs2sX767eJlMkDT8pC0aTI8g8y2jcQ25pLtmihJRzDvg/TJUuYQNa7CTX
 kZRve45I0Oo2ltmyA3AtyQGm14mJKcJSq+Qr2U2tNnQT2n7sqQNiWNl8Sa7mPc6piLvu
 Tur4lTxFFrV4O7+wuzvy9h5RByKDyZz2abu63fquqLyFaVOGYL6Z8I75HVQO71+bsUKC
 sfhXk5bPSo60IMHciu/TB86Jhfbw1Vr0nDxFXTrkDrS+x2q7Pipy2l/RTSoFD6/I1Dbn
 kGEgG5hHhttR9NwstDglJqhFwvoAsCKwRyGxOxTYODLKIPt3q8M+eZowl6O1QVJ0/ypX
 rsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gtOpQPkGKX0yFz5Psq93dvrHxw5YWixBARcxD8TTPD4=;
 b=cOm1GL2mKl0PtVdVBnp0IKCikQ2WYOxHEladJ7P1aPs61M+loZYxM42/qSrBSMgE55
 gyX1Gsc+ro+nesjM/ZT9cyRFWWG/mR7WQNfDWu4jyIaZNuPzehuUE+fmlD7TALa9kBwL
 BtX6pDHwEcv9n7Zoi46R2HZRO9b2f8O6jGDGZPxFijwOn6v6Z0TLQ1K1FhblVMhvv+eW
 UZ9AQ76GYDy0FAwfoS/rJNbRFPqdLIBhlbVCn6gsCgILQEbUi1ceVcB6KmAXHPqalHhk
 3zeccWaRljh/HwITn6giFHW+pVg/Y06c+Uf3sRlpW9KZtZgEjpNPHg4MuFxJ+OSkOEdT
 MgXQ==
X-Gm-Message-State: AOAM5301IRb/RT2cqidfhAEDUvljxM64L2/tp5BgUTb6p3Eh9Z9QDINm
 1PQU619L+1lxSOVfatug1ga7YvDLwJY=
X-Google-Smtp-Source: ABdhPJxJnEkPnFFxRWd1eTb8q78v53IstMiMrcYfB6+QMQElj+dljGX33RcKCNygZb7RjyDz/dWS/g==
X-Received: by 2002:a05:620a:158e:: with SMTP id
 d14mr71000303qkk.358.1609782826800; 
 Mon, 04 Jan 2021 09:53:46 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.241])
 by smtp.gmail.com with ESMTPSA id w127sm36879836qkb.133.2021.01.04.09.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jan 2021 09:53:46 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: check the result of copy_from_user in secure
 display debugfs (v2)
Date: Mon,  4 Jan 2021 12:53:37 -0500
Message-Id: <20210104175337.636270-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make sure the copy succeeded.  Also fixes a warning.

v2: fix the error check

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 455978781380..b033344c5ce2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -101,7 +101,9 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		return -EINVAL;
 
 	memset(str,  0, sizeof(str));
-	copy_from_user(str, buf, size);
+	ret = copy_from_user(str, buf, size);
+	if (ret)
+		return -EFAULT;
 
 	ret = pm_runtime_get_sync(dev->dev);
 	if (ret < 0) {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
