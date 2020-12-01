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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80172C64E8A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 17:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 147962222C
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 17:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd5JMLlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147962222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329E26E82F;
	Tue,  1 Dec 2020 17:44:25 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A6B86E842
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 17:44:23 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id p12so1207446qvj.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 09:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HVMRAHUqsKb9uDw0g/NrWfGl0MSQq1tp3VhJIDiC98Q=;
 b=Pd5JMLlbwqlhYCijhUnRii0QAeOKSnOFjxAoDh8gYb42iKe+0l6omhbrT1j2TqV4ZG
 WhyFp98dAXOo2rgZfvQKHCjpA/RlNzagXTHzVFIMf9Wr/uZGgw8qpDGQbX9HZ7lW8+XK
 z+sUCQC4lViMNDvHpkteVNh/Sh371Q+bofCVfuq9iPzLzSVk6lGfiMRq8Ryyeuprz2Pw
 Fc6h5nOkkri1MYiNWR+zeE8srb20yQBnLHe457Czc2HWhq/ZIGRFcrDj2ku0nAnBaFh7
 XG3qMlb3pZV2nVMFtIpzoTRCRm+3iNRdmvZOtp3hyfYM336Kg8SB2J0SxJvngBq3LNlq
 286g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HVMRAHUqsKb9uDw0g/NrWfGl0MSQq1tp3VhJIDiC98Q=;
 b=rCuTLSHJ7T44B16RANiv5PnRjJ3dBFWnS2cSkUB8cWMiX1tlHM4fmnpI9wquGGYrk5
 2hRAQwErKahqOPEMhRmujeS8zlCsvTxDM2A3nP+GqoqARNVvXeJi9u2w726M1bCfmkyy
 v0QxEgqQOX3iAttDGdf3GvISlGNDcwShZYYKlk0pnsb4XwMw9GhIOTyR2ai9c2R9RM1y
 93ViKjr0hTk5//xmeAsxFj9rZU/28JyoClnAIBGXr/p2476UQ4ngUlDS+wXBljAARuzp
 1wUwvh5Qiy63iLGfd/qVuyxwko4h8nmcP3caFg2b0QeZ6ylaVeig4w69ZlZbyW8OAsVt
 LjFA==
X-Gm-Message-State: AOAM532YV5izPrqoNA95o/BYAsP1CXZD8ffaAfGpVjdCP8dMWGMAAh8+
 R2Mv3EFgZEpXDZo8KzjHEjHxH0kGEeo=
X-Google-Smtp-Source: ABdhPJxbPXafAbzeD6q+wGVdOi1nwbpo3CV/rjPyJWuH8iU7A/y+iOR6N7dCddLwWiKKADMfqWAdTg==
X-Received: by 2002:a0c:b59a:: with SMTP id g26mr4047934qve.26.1606844662523; 
 Tue, 01 Dec 2020 09:44:22 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id o9sm302170qko.53.2020.12.01.09.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 09:44:22 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu/powerplay/psm: return an error in power state
 init
Date: Tue,  1 Dec 2020 12:44:10 -0500
Message-Id: <20201201174413.643254-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201201174413.643254-1-alexander.deucher@amd.com>
References: <20201201174413.643254-1-alexander.deucher@amd.com>
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

Rather than just silently dropping it.  Also fixes a set but
unused variable warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
index 31a32a79cfc2..67d7da0b6fed 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
@@ -74,6 +74,13 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 
 	for (i = 0; i < table_entries; i++) {
 		result = hwmgr->hwmgr_func->get_pp_table_entry(hwmgr, i, state);
+		if (result) {
+			kfree(hwmgr->request_ps);
+			kfree(hwmgr->ps);
+			hwmgr->request_ps = NULL;
+			hwmgr->ps = NULL;
+			return -EINVAL;
+		}
 
 		if (state->classification.flags & PP_StateClassificationFlag_Boot) {
 			hwmgr->boot_ps = state;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
