Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB70C64E7A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 22:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C557720C56
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 22:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEAdhvBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C557720C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD3489D67;
	Tue,  1 Dec 2020 22:50:01 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 150C089D5B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 22:50:00 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id 62so1696479qva.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 14:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S46FJ87PQSBS+x1sijq7yOWo36eu6fT9SJqtRVPLzlw=;
 b=XEAdhvBx/6l82SDWk4SQfDOz4DPpq1tc16AeqtG6nXB1VC7uiJm+p+99P6UOsEMe4p
 O8OVhyFsZ8isysdmOFsPfq24dN0qOZRUwZFqcxvpOMJCP4a2goNAtDRh/qHgRV88U8AA
 K5NbzKDgCdgdglJ5BCXKscuA8UsBOtzLGllHQ8AgrX8GvKW6hsKAQOZ6lEXojm48XKvp
 38wzDyPRLOi1M2xsEoif/zvWY09vvJT80LH6ymLiHI/2mqkeClsY8HogMk77EG9bw2fv
 NnB+duVdOtMQKWvJUC87fg/2a+IIWO89f3DmSYwKxhTMWR2Yw9+nDseNDKbDlcbcSv3Z
 0Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S46FJ87PQSBS+x1sijq7yOWo36eu6fT9SJqtRVPLzlw=;
 b=L8UXNgFmetz3uohCTtPdzh2wUqiwjvkdZHaWB3ewPUueKhhjWwQ+HmDjZDdYh9YpqA
 JrqYBwSI7qnSVFo/Hz1gLu8nSEkY6N27pnSKJoKCwUJBFXzWx5ByFlRsnkn0+qRVFCLr
 Tedup1fwdNH7Uez2aqlIXO6LZ3SMeDbeiq4s/V0ZkMV4ErbCOn8U8zQP6Vp17YIyOC/W
 fPh/I/50/Nmdo5fbX/DHg0+fwgMUk9L4C2K91mAkBi7gszqfBQ3BihJKZF2eKd8RWdpz
 zDVW3PGoC70L89RPztAu69GWDS4IWk+PYKrT00meiT800hD+vvxX+cGL4FeiNniJR1/q
 DiRQ==
X-Gm-Message-State: AOAM533Kf3O31V6mSH+sz+MqQw6eSxiENrG4jsEYykLUkl14tc+B3SrK
 lGIPS1hAsgI8feD/XpoXa3sAxfnzPOs=
X-Google-Smtp-Source: ABdhPJySLtuHGXRgMuK+p78PGoAMENYKwhglxn0Cdq+FtmVD5XfwDk0czHq/jRL90FBfss57iFQS6g==
X-Received: by 2002:a0c:8149:: with SMTP id 67mr5739835qvc.52.1606862999050;
 Tue, 01 Dec 2020 14:49:59 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id k46sm1192268qtb.93.2020.12.01.14.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 14:49:58 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/powerplay: set the smu fan control cap for CI asics
Date: Tue,  1 Dec 2020 17:49:43 -0500
Message-Id: <20201201224943.1200069-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

The default should be to enable it, and then it could be cleared
depending on the board design.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=201539
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 48d550d26c6a..f116346525df 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1006,6 +1006,9 @@ static int init_thermal_controller(
 
 	hwmgr->thermal_controller.use_hw_fan_control = 1;
 
+	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
+		    PHM_PlatformCaps_MicrocodeFanControl);
+
 	return 0;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
