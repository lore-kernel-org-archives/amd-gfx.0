Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E09C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 23:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B238161184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 23:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B238161184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=froggi.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 328B76E856;
	Tue, 14 Sep 2021 23:59:53 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEACB6E856
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 23:59:52 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 c8-20020a7bc008000000b002e6e462e95fso3425439wmb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 16:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qeCMw3RvpplpdDPL+c0dVenmmpl9grVi+/hSk2A6oqc=;
 b=IEiMzcqejHemt5p7tE01QGBjjHOvCxv74iujsdcsXR47The4Z+7lS6lyAKaR+nhHqc
 xNlLzfJSZffP3c3EoOiznt62DMPztIjJ1QrXE90bxsM1SiA4vkbAFvaXHCETIeJpQuXl
 tXqVn8GIByilJhQRl9yn8BEeEANRwMAV7iPLbltJJ4DOZPok2QR/VRYRd/8LrySNV3mR
 pst/CpmzZipmtLUNXRQ+2exM3T7QvtrXfuK8dJXLn/UHhiaFxgc85XxzMJVdt0LgJZ4+
 Dg3yZn2NgMJcfccYxluU5f5e984vlhzx4Zi3Cmu9Dq4CF7mxSpfK0c+T6OKxwytOvRhq
 CI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qeCMw3RvpplpdDPL+c0dVenmmpl9grVi+/hSk2A6oqc=;
 b=URKfW858oEiaFqsHOi6+AhhVKY4B9gjpGnSoM4W/YxuZhC4ZtSHbnM3OAsBR3GfDyI
 ZQ0pzayAvDRN+OsgNMDDLwt+8Kd2X5lSL+rSfWD8DdLDJJPU8yBuOr1mSskDHRK1GGFO
 APkb0H4PiDnkrqiDcqY59UJKu8yS5+cHsx/i4n4Zmp7tLfXchG0u1XvJakHQ0bOamrtA
 MBjuZeoh1f/tTqMVhzg8IYKiKoRivEmc9CBygbXqTyymrZE5MGsMOq7CxO99sdeRvbC9
 Dg6RUFhd4sS1swHru4+fWaB6kxmE9u453Ea9rgQLqLktYacIiZC6TuziVfAWk1uAx+rD
 QhPg==
X-Gm-Message-State: AOAM531F1q1Lg2gUV2ZFhSkOT4MmDmmdjslyFBWPHl+YzdPnk9iaQt1b
 FIHRmyEwvTxAuE+plpYJIITd06TB2xn3ghsG7nk=
X-Google-Smtp-Source: ABdhPJzAAC3izCvOUwa6rWJ9014BicD+/H/+nS4LCOgNETFFWPbCv4k1Fh9bczAxtQHgoxL0LQ2e+w==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr1508576wmj.110.1631663991304; 
 Tue, 14 Sep 2021 16:59:51 -0700 (PDT)
Received: from localhost.localdomain
 (cpc89720-darl9-2-0-cust754.11-2.cable.virginm.net. [86.2.110.243])
 by smtp.gmail.com with ESMTPSA id m29sm12571637wrb.89.2021.09.14.16.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Sep 2021 16:59:51 -0700 (PDT)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Cc: Joshua Ashton <joshua@froggi.es>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 2/3] drm/amd/display: Handle GFX10_RBPLUS modifiers for
 dcc_ind_blk
Date: Wed, 15 Sep 2021 00:59:47 +0100
Message-Id: <20210914235948.893422-2-joshua@froggi.es>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914235948.893422-1-joshua@froggi.es>
References: <20210914235948.893422-1-joshua@froggi.es>
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

Adds the missing logic to set the correct value of dcc_ind_blk for this tiling version.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9c6f2863ba96..2a24e43623cb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4915,14 +4915,26 @@ fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
 	if (modifier_has_dcc(modifier) && !force_disable_dcc) {
 		uint64_t dcc_address = afb->address + afb->base.offsets[1];
 		bool independent_64b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_64B, modifier);
+		bool independent_128b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_128B, modifier);
 
 		dcc->enable = 1;
 		dcc->meta_pitch = afb->base.pitches[1];
 		dcc->independent_64b_blks = independent_64b_blks;
-		if (independent_64b_blks)
-			dcc->dcc_ind_blk = hubp_ind_block_64b;
-		else
-			dcc->dcc_ind_blk = hubp_ind_block_unconstrained;
+		if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) {
+			if (independent_64b_blks && independent_128b_blks)
+				dcc->dcc_ind_blk = hubp_ind_block_64b;
+			else if (independent_128b_blks)
+				dcc->dcc_ind_blk = hubp_ind_block_128b;
+			else if (independent_64b_blks && !independent_128b_blks)
+				dcc->dcc_ind_blk = hubp_ind_block_64b_no_128bcl;
+			else
+				dcc->dcc_ind_blk = hubp_ind_block_unconstrained;
+		} else {
+			if (independent_64b_blks)
+				dcc->dcc_ind_blk = hubp_ind_block_64b;
+			else
+				dcc->dcc_ind_blk = hubp_ind_block_unconstrained;
+		}
 
 		address->grph.meta_addr.low_part = lower_32_bits(dcc_address);
 		address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
-- 
2.33.0

