Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221AEC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 16:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACC420848
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 16:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyIhhuDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACC420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEDB06EE21;
	Fri, 16 Oct 2020 16:50:16 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0336E15A
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 16:50:15 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id s14so2402019qkg.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u+rM5TZRcRSSI5huzk4XO7hQg/8qWuHsv0UVLeSxmJ0=;
 b=gyIhhuDkgStxou2qOHwLueGFPcKyeXTF2kK9Nr8DyaPmDDtm4xJzU84/WuevSbQpyA
 vhD6Lf0xk68YlhJG3/G1WeMsA8Qypw2hYYDIkhB26Sh0juQt4f8jptxIYWejEw4+XhE6
 8Bdh0hd0edt1P8oQdpLGUzg2KTiiVdcnfoklp95lYu9lOq/29NKs6aUmJoub+8tG9/oL
 733hitXAf39ecwBI69Tfu/iSugjZmHEwLsYLr3tQPTTEthknK5e5rkN9H6SZYG51awvn
 4ntRT47wq7nZdSUmMok6vdB26PfoP6u0EIQPwlHh6jUXgbgVlhk7iaDdLFy5VF+m6SGt
 r+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u+rM5TZRcRSSI5huzk4XO7hQg/8qWuHsv0UVLeSxmJ0=;
 b=sKuONEwCcdAhbX+0TT+RRhKY6XUzGAi3UpVhrKK7wWEMxV6M3gepHTPnvhQocIbsrK
 +49csPbbq8PZL0b30zQiHK21mxOWX+m8sZk0RcAx2mbN2JCojh8Glq/FvX4Ya8wUde1R
 96k9ttuG2HSD0dHpXyDLe0Gj5iNWkaWmJZXbWNLy/54z1NhJtMIjweKkqEOlx8qT4gP3
 r8YT3MsIKMlf3Ru+I5fB3Hd5fU+VNhs9sQbfMp+Iue73SBpgp5XAvLsK0aHHSjoYgh+q
 49RLfv+U8zQNdbmtaO43wZayr1kxIHbGbceEhX4X3ZC9QEL+Ty2KWvK5niDRAXXrxwws
 AykQ==
X-Gm-Message-State: AOAM5330wYSBTjRAfyrPW9kpv+F5TMB5gKcdDznXnk7gIdXDj1hF7LHD
 T30D3dWTgBCw5WjH9pTXjRsW3lViO+Y=
X-Google-Smtp-Source: ABdhPJxFsGOBHpNlUGl5HWs2iW8AUVI36l3nDH6SDrT1ocRdlgB2N3fnrpBWqO736JrUECJP+Llr/Q==
X-Received: by 2002:ae9:e20b:: with SMTP id c11mr4473715qkc.137.1602867014343; 
 Fri, 16 Oct 2020 09:50:14 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id q9sm1193726qta.70.2020.10.16.09.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 09:50:13 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: drop CONFIG_DRM_AMD_DC_DCN3_01 from
 atomfirmware.h
Date: Fri, 16 Oct 2020 12:50:03 -0400
Message-Id: <20201016165004.1218352-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201016165004.1218352-1-alexander.deucher@amd.com>
References: <20201016165004.1218352-1-alexander.deucher@amd.com>
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

Not needed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 4eb578b1baef..6139d10f4289 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1309,9 +1309,6 @@ struct atom_integrated_system_info_v1_12
   uint32_t  reserved[63];
 };
 
-
-#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
-
 struct edp_info_table
 {
         uint16_t edp_backlight_pwm_hz;
@@ -1367,7 +1364,6 @@ struct atom_integrated_system_info_v2_1
         uint32_t reserved7[32];
 
 };
-#endif
 
 // system_config
 enum atom_system_vbiosmisc_def{
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
