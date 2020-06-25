Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA33C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 22:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E63D20672
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 22:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6yEEwnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E63D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0351E6E372;
	Thu, 25 Jun 2020 22:05:03 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5FC6E372
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 22:05:02 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id c139so6984418qkg.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9Ru5zXb6dhwk7NxJvaDTpO7nEcBvy7koL3n00aficHg=;
 b=N6yEEwnUyCRWl2SyqlzD4mjZ1JZpeJiB4vg2em+Ee5qgzRkd2lD9DJrUM9vXWNWZdd
 kamu3PwOHPfirF8F0TWplkQJiemmxa+f/lYYpquZB7CXYBjJbl9IswN9p8CkApifdZ/2
 1OhCLZpFLJgGK65wzG1VFb02XI9+zdIHxj0b3p1fatmQL5wN6cu4tvGM0d2EUXKujL1d
 mGSfe1D3IMz5eeMAZcqV41hpumchlSX24Qnr89CquzQBVlpR4i1OWrCk61sRGbz6m2RZ
 wWTXltpLci0Q2kld5KwyGvZcYnr2nF4G4etXQlUOsgFGzbRm1wekUp3lAVOUVZQJgwK6
 +jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9Ru5zXb6dhwk7NxJvaDTpO7nEcBvy7koL3n00aficHg=;
 b=SJc44KrKh7QQqHu4jDd7ITWx2LvSKdZGDHiEonWJY61y212GjioZID9FLDTWt4xfnM
 X3snAF19GLuOFAdIWnGIJV5wdsU9X1/9B89tlpsN6QFKS9Ur8YryMO3vDld4mefAmJd+
 kaZBVikjR2cc8VFynfyVF7P7sq2rorkKE9c/5CRXY2Np/L4fObJPIJ2/h7VKtvs09zCY
 EVShD/P//gOdcrjp+cIX/xbDtUUmWhwGQEUtiSd+fG3kyIbMCN4rSEbYjicLZxjf3z5A
 JnEDe2drCxKRzzU7RhyPgCYBtl2A1/L8hynRHmKpSQd5Q5c0fQM+6W/mqWde6kJUfSj6
 PfRQ==
X-Gm-Message-State: AOAM5308ATDBrWknMkw3O4wDsvUcq4OyxaAuaOaH6ygD+N7sIK9Er84B
 8Js3G4a4TWrflqaDCKGboZJyOFEW
X-Google-Smtp-Source: ABdhPJytP3/o7uMpTWVehPK7JqOcFuh5gp5ttgDBcW/nIynJ59b5xXT82cZA/v1O5sxUGC+2eFGEtg==
X-Received: by 2002:a37:a758:: with SMTP id q85mr10276179qke.301.1593122701409; 
 Thu, 25 Jun 2020 15:05:01 -0700 (PDT)
Received: from localhost.localdomain ([71.219.51.205])
 by smtp.gmail.com with ESMTPSA id x197sm6670885qka.74.2020.06.25.15.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 15:05:00 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu/atomfirmware: fix vram_info fetching for renoir
Date: Thu, 25 Jun 2020 18:04:51 -0400
Message-Id: <20200625220453.1367084-1-alexander.deucher@amd.com>
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

Renoir uses integrated_system_info table v12.  The table
has the same layout as v11 with respect to this data.  Just
reuse the existing code for v12 for stable.

Fixes incorrectly reported vram info in the driver output.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index e249b22fef54..4b8aad1c0b51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -206,6 +206,7 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 				(mode_info->atom_context->bios + data_offset);
 			switch (crev) {
 			case 11:
+			case 12:
 				mem_channel_number = igp_info->v11.umachannelnumber;
 				/* channel width is 64 */
 				if (vram_width)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
