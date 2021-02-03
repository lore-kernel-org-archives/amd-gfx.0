Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572AAC433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 19:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68A664F2C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 19:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68A664F2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A62D89DA8;
	Wed,  3 Feb 2021 19:06:59 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 119AD89D9B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 19:06:58 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id v126so779987qkd.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Feb 2021 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5urpi0LjW7Q9lIHXXG0E4+9xyGMjh7EkegNI6AqlSBY=;
 b=AwsZ7JaZhq7wfl3naaAlEhAoedv6Fd7Kk5/PaKhgWROmsH9P+MOFtE6CL27Nq/8u8g
 +4i48zLmy5QCGvwRohSK1lonfI59W73SP2Ph83jrFRfksY5Kvlupq7zZOlj66xXFgp44
 tc7yGfrG09IuURmzBfO/wmRZQO8VKgQ/rFsihojTXmnDt9LEFlHPfb1Y/4HaOGoRnF8M
 cK2Pm0hwcVWqJ1vvnRpGh+G6uc88Rwhr9wfg+kbhCvArn08dAl6zEZdHUZUjYQTEhtV3
 pJBAy3Bpn/OF/O6mZvyKoP1lSmZ54ZyN0F9DPFnCkxyFOVyUSajakPIFLLv9IdW7Knjv
 sohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5urpi0LjW7Q9lIHXXG0E4+9xyGMjh7EkegNI6AqlSBY=;
 b=K1nONp1U3loWtQAA6n0yfZ3rL89mRhDZHcQv2BklvWMciS7a+Naeu9u2bDBkMTcFPQ
 nKxBkl0qrO2/VHioudljXmLmHB9xWckScRosrmSKEJTSDh4Ig2Qj8kbivicoxG3zkdyR
 7V1Nj/8DqSvfTCckn33xZTM2jMiHcrFaB9Mwtvf+HgVQbx6jy457I3qtlsNf43iBhfNS
 0YCc1YWh2PglmiSSU0gwsPUna15RcvyWVmCRF0qlsmevBFjCWrhfWrdvp/rYmUVIYeea
 6gllAuYw/2ujlcBqM6kRzrxSDQbN7Dmv1k4so7K8wvLWnvQu4PO/i0U/QBEg7BxfjMOo
 flUg==
X-Gm-Message-State: AOAM530givZCF8cstJXS1xp/gv7rzsBkNsmwbmi4iGGGzeFUzev6wjIU
 iz5/iUX7YhXfx8dvsDoFmbGGK30MNvM=
X-Google-Smtp-Source: ABdhPJx80MTiKvj1zei8dCUdrYDYWtDsxIVC8u4wqqZuK2dl604i5xGZnGsDXfCXLkt0d5kvVnywRQ==
X-Received: by 2002:a37:c03:: with SMTP id 3mr4145471qkm.367.1612379217125;
 Wed, 03 Feb 2021 11:06:57 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id r4sm2530434qkf.112.2021.02.03.11.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 11:06:56 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amd/display: Update NV1x SR latency values"
Date: Wed,  3 Feb 2021 14:06:46 -0500
Message-Id: <20210203190646.2024787-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 4a3dea8932d3b1199680d2056dd91d31d94d70b7.

This causes blank screens for some users.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1388
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Jun Lei <Jun.Lei@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 064f158ce671..d94a1b3ac1fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -297,8 +297,8 @@ static struct _vcs_dpi_soc_bounding_box_st dcn2_0_soc = {
 			},
 		},
 	.num_states = 5,
-	.sr_exit_time_us = 11.6,
-	.sr_enter_plus_exit_time_us = 13.9,
+	.sr_exit_time_us = 8.6,
+	.sr_enter_plus_exit_time_us = 10.9,
 	.urgent_latency_us = 4.0,
 	.urgent_latency_pixel_data_only_us = 4.0,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
