Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C028C56202
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34F820B80
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSkU5TOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34F820B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 697666E7D5;
	Fri, 13 Nov 2020 20:40:51 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98996E7D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:40:48 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id 7so7721680qtp.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 12:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uf7YrE9DOJfgUTc4DkUiwUYNhP3cMOSTSOo+zl+Iw4U=;
 b=cSkU5TOLPny673YJGHn0MRGSqsuautG01ymb8p2iIxVueoN35d4erPje0AzP2fEbAz
 Z0bz/A94bqndKf5qOPtHKrK6ni/QjDNlPCc2GO1BJaVaXdhnoZR4Sz7LMJ7PnoucLpnL
 rtCEqYHrNkhrm5QwBbCsqWVfWoGhve+YCylo9+NzbVx+BLaqsRm/gapxPOlycQF4fcpq
 kWpF2nOJQ4SCHM1To/nkBTtfLqaOTsxDPXjSOgfG4b67wrlGibwo51bL4XJsP4TpjrhW
 I79QfjjB4kGqNszfLUBFdtAg5SR0OKhh5QI+7UvRe1CqcW1n3AY3OCFSdYYTVyuu+vba
 DBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uf7YrE9DOJfgUTc4DkUiwUYNhP3cMOSTSOo+zl+Iw4U=;
 b=DYGWmqjY/io72DtufOfjHvGA16KoxAUfNB/svFYwl2Kw/qX2Quq2Ueo6OyHvAArbSD
 CnagvM2KaKbpvLDIomFO1dCb3cXy+WTsJ5CebZWZdl0A4nidWEZ5ncWpMyjVaTiSvB/H
 74AymuTnKqa6Nug4ha2EhLwWro9pBKUDzlN7WLDZgTqXC7JG6wE7qqy3yBaAXyzIU8du
 8QdzEPCMPvpIz05jASX4WnVWn+lfXJf77T65L658bFqEp2qBqaQAA3Thz6tvY19wOA3N
 2nhZOe3gfU2BcLyTarRsgDrC2Vg7BK/v0mcMnM78KGABH+38QiGosuracXRwUrfTtAfI
 F4Eg==
X-Gm-Message-State: AOAM531JzLdvlqEyWhtT3YyoLRNzN3NrlnUV+XUoGzh10BtARGj3rIzq
 TOAxsXDkjH9B84F+3b2KU+O+0xKpTZg=
X-Google-Smtp-Source: ABdhPJwy3bQkUnT/rCWxamUbFoBjrPytXR1aGhzSyoaTqE7Kn4fil0a3iCxE3s96edBndMCsqOgPzg==
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr3772616qtv.56.1605300047907;
 Fri, 13 Nov 2020 12:40:47 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id y5sm4524026qth.53.2020.11.13.12.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 12:40:47 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/powerplay/smu10: drop unused variable
Date: Fri, 13 Nov 2020 15:40:37 -0500
Message-Id: <20201113204037.978207-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201113204037.978207-1-alexander.deucher@amd.com>
References: <20201113204037.978207-1-alexander.deucher@amd.com>
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

Never used so drop it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 50308a5573e4..04226b1544e4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1441,8 +1441,6 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 
 static int smu10_gfx_state_change(struct pp_hwmgr *hwmgr, uint32_t state)
 {
-	struct amdgpu_device *adev = hwmgr->adev;
-
 	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GpuChangeState, state, NULL);
 
 	return 0;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
