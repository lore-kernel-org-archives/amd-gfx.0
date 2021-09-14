Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05628C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 23:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A0861184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 23:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5A0861184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=froggi.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128E36E857;
	Tue, 14 Sep 2021 23:59:54 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E4686E856
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 23:59:52 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id g16so946770wrb.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 16:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iyM/eWya5TXfoYKKCUoktyELxXnG3DZTINgRKCyeolk=;
 b=YJrJlcLrhwsp5xTEcNe5GQ2VmxbqMZQvBoeBjE80NAOg8BNfTOUAB1gzDhr8zeJlIW
 ayzg32K5cOl8c89DQnUxZxUYEO0DLr6XUd85JcdJ81XYYm4Um/cQ65Trtzuuognn6pBu
 MQjkzNd8GAzTSsoqIAUBss0v10/R80pS1Xln964wsaFqjlHpS6pOSWT+SDVi9CwNsfGk
 gr3zbXDkzHd65UWCb5qw0IO0LJoEeImcL1eRl67fpiX/P8NPqvN6zUG+TU8BqkKTW8mi
 Nbby+rhe7z78QSKcfzCyUOCPYnVUOjmZeQD67OFO8LDBO6ycMyWw/xfp2WSQ/Lj6u+N2
 zHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iyM/eWya5TXfoYKKCUoktyELxXnG3DZTINgRKCyeolk=;
 b=DP1w5DJ+F1AyTs2nUbRsPv2BzEPXaF5tCG4TMJNz+H7eb3J0ucIGZHuvB4sBI7OXq3
 8IlDPtiq70nWZkQMkRjH6pAvsxxkVTQr6bhExtOVhKFIhmfVoUKQsZ1vHFRx5MqJiQFj
 4Kj3G1k8gdxqAjjE2khcO+ih0kVbcKsETwpcYiltFq/5z9iMpd85bmT9JvF2B2nasDJC
 tgUK/Ig1+Lp12RWRkcGMW7YkIgfDgp/tyi2g9G9/hR1C/v3z/NvwvO6yteGCZedLAmRf
 N4ipcAAqbYCepfo/OjpJW5p8EGYU8/vbrGm+PRCBruzviDzqOJYNrm2x2s5NafwvJyza
 C4zQ==
X-Gm-Message-State: AOAM531lSa7ZffBZMHh3o5Epcvkf0EqceDkdisFvuU3m26i1Ra48umUm
 R6K+VtVw4w9qsbdppOLfDUZ0poJMSGT11b3+cQc=
X-Google-Smtp-Source: ABdhPJwFlJhzU4H1Z4bp3nOOZglcubiFSsM2cjyYx7AtIPwhMo6kmzdut/GPLUlQ8oEdRaQhk/a+hg==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr1775282wrq.140.1631663990784; 
 Tue, 14 Sep 2021 16:59:50 -0700 (PDT)
Received: from localhost.localdomain
 (cpc89720-darl9-2-0-cust754.11-2.cable.virginm.net. [86.2.110.243])
 by smtp.gmail.com with ESMTPSA id m29sm12571637wrb.89.2021.09.14.16.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Sep 2021 16:59:50 -0700 (PDT)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Cc: Joshua Ashton <joshua@froggi.es>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 1/3] drm/amd/display: Use dcc_ind_blk value to set register
 directly
Date: Wed, 15 Sep 2021 00:59:46 +0100
Message-Id: <20210914235948.893422-1-joshua@froggi.es>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We don't need to do this workaround if we start setting this value when we fill the plane attributes.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c | 6 ------
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8837259215d9..9c6f2863ba96 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4914,10 +4914,15 @@ fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
 
 	if (modifier_has_dcc(modifier) && !force_disable_dcc) {
 		uint64_t dcc_address = afb->address + afb->base.offsets[1];
+		bool independent_64b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_64B, modifier);
 
 		dcc->enable = 1;
 		dcc->meta_pitch = afb->base.pitches[1];
-		dcc->independent_64b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_64B, modifier);
+		dcc->independent_64b_blks = independent_64b_blks;
+		if (independent_64b_blks)
+			dcc->dcc_ind_blk = hubp_ind_block_64b;
+		else
+			dcc->dcc_ind_blk = hubp_ind_block_unconstrained;
 
 		address->grph.meta_addr.low_part = lower_32_bits(dcc_address);
 		address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f58d3956f3e2..da360691e655 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2008,7 +2008,7 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 	}
 
 	if (u->plane_info->dcc.enable != u->surface->dcc.enable
-			|| u->plane_info->dcc.independent_64b_blks != u->surface->dcc.independent_64b_blks
+			|| u->plane_info->dcc.dcc_ind_blk != u->surface->dcc.dcc_ind_blk
 			|| u->plane_info->dcc.meta_pitch != u->surface->dcc.meta_pitch) {
 		/* During DCC on/off, stutter period is calculated before
 		 * DCC has fully transitioned. This results in incorrect
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
index f24612523248..eac08926b574 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
@@ -356,12 +356,6 @@ void hubp3_dcc_control_sienna_cichlid(struct hubp *hubp,
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
-	/*Workaround until UMD fix the new dcc_ind_blk interface */
-	if (dcc->independent_64b_blks && dcc->dcc_ind_blk == 0)
-		dcc->dcc_ind_blk = 1;
-	if (dcc->independent_64b_blks_c && dcc->dcc_ind_blk_c == 0)
-		dcc->dcc_ind_blk_c = 1;
-
 	REG_UPDATE_6(DCSURF_SURFACE_CONTROL,
 		PRIMARY_SURFACE_DCC_EN, dcc->enable,
 		PRIMARY_SURFACE_DCC_IND_BLK, dcc->dcc_ind_blk,
-- 
2.33.0

