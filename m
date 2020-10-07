Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECE4C41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C332064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiZuT3Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C332064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 119896E961;
	Wed,  7 Oct 2020 16:32:17 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8E66E962
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:16 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id ev17so1488980qvb.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OC0rZxPBATRf2AkdtK2phFZ9GJDJQ25VLnl99lKVSj8=;
 b=NiZuT3ZmpRxpPilzmqJvjDKoxSnTZE+A3/+LPIk4Lw4kfm9nKRIfCk5P8k0cTREM9J
 uHY8ZNA/9KDgVOkhJD8XWOrgour3Im/Wasq7Lb04KvGSkmCdq2xowGi6G+CXKQ/AoRhD
 vlOpAY5TFj/tha+CeRZkHOd3uDf7xqVTBs/cBFbnBCXzfYQ0VPDVqCh5c9XcEZuZCO+S
 G0zCTgwdbzSzrFG9g8aqWhcAkDjoIcjkH8UBo1XaG9Daim9IlyC2/JE2VpVcoB5z+y9m
 N5SBXNnQ4XChvWCCzaUmOe91dnk3Y/+xZh67/ovRIVpyBRTZBNtl783Xusug+MYuHfoe
 DPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OC0rZxPBATRf2AkdtK2phFZ9GJDJQ25VLnl99lKVSj8=;
 b=RvenSie/ReQ3zCPdU8TnsamJwuiMQ9RQFMiVGZS1PEMU/reSOFIhzeccG6hmrBj5/r
 Cb8bnAB0qwtc8y/ofHvAaQlPh9oPBnCsUsuPs0kO+eBLA/OGpE+kA4P0nWyGTD3aGBGZ
 YjkgHix/gjlw6+1hxHl5JlLq0LiI6ng+AlihMlkERjmsquxa32cJ0YfnFLrxqlseyBkZ
 MucEEBvyd5qChb52w6kLn8sYG7MGR+9ur/HWknyEl2fL8fDztPUki0m5sXbiGwF9uWdY
 SiQ/TRKhNBE+lWrynGsQYSHJjJ9hrsdksOANyMfLsA208WrA5aasSl3OEBh+oVsWJm9g
 p3YQ==
X-Gm-Message-State: AOAM5318lam4zHLGAYGKMJ6gG4M13UeELNLDdH182mAZrIETn+qog4Is
 2jLcB2bPGIB2PmJ/SjacpYpo9tBHv8Y=
X-Google-Smtp-Source: ABdhPJy7Nhq73DDEyyYVqbO6Y0nI0e4IdJ3gsqQXqfq0OcwynIpVtYYFqxf1CUuudIRH7w/43PIbNw==
X-Received: by 2002:a0c:cdc4:: with SMTP id a4mr4097109qvn.31.1602088335262;
 Wed, 07 Oct 2020 09:32:15 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:14 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/50] drm/amdgpu: force pa_sc_tile_steering_override to 0 for
 dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:03 -0400
Message-Id: <20201007163135.1944186-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

pa_sc_tile_steering_override is only programmable for gfx10.0/10.1/10.2, the same as sienna_cichlid.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 6ee25dcccafd..352864d7d468 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4642,6 +4642,7 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
 	 * pa_sc_tile_steering_override should be set to 0 */
 	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
 	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
+	    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
 	    adev->asic_type == CHIP_VANGOGH)
 		return 0;
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
