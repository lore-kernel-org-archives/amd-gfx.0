Return-Path: <SRS0=fmWI=3S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19131C35240
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 18:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC71206D4
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 18:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB5P+D+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC71206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A680C89DD3;
	Wed, 29 Jan 2020 18:01:41 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 496C289DD3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2020 18:01:40 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id x1so76318qkl.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2020 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HHGsJVy0aIuVeX829/X0tfm0LXHWk6riR+aVGLO4gq0=;
 b=HB5P+D+RVvQ5qin6jbK+Z6Oan2UT8TmfEakvOhvT6NbWTGim2p0KPFMZLUXy2xKh6K
 yAwFq65sBfzcfTaCQ/bFLjnuUHEwxJN0AwE1kV8KeCHazCzrm3PgsvsvvJ0blu5KNQQ3
 vhNPUfwmHBsWsvC3SWy8VveGNK0pfvLdRT6t+q1PZ3owl7brH9ofxtcgcc9rJl0ZBRip
 X3zmBooJjr9x/BFLfVnnmKLiUadOGYxKJPGwWMtuyqn3vWQR4XaDgH+1msUG1P/sLs+D
 4yOCOxgaZ/T5OQzD0FqEtSBtQyTBzroKnEg0Smg4zOU4s70XyBepsPKE86SQ+VgPBQb6
 4SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HHGsJVy0aIuVeX829/X0tfm0LXHWk6riR+aVGLO4gq0=;
 b=E+k7bpOwonTiaF84VwEuVO6ZF22zD/DvCWCgZwA6NeMi/vZoB0dOPWx2EB6tvILWsz
 FLBooS1WN3G3PICNALQqGNvzaFSaXmSOS+JR0wtjblzsM8G9FBB+GIN+WXQnAQ4W7hwi
 4LVjGi/4bseRcXz7TyN6Uf8lcY/+APVULpNsPfyL+MmHYJIzBh4KU1gViAnU27JaE0Ck
 c6LpxUu1EUXuI2OPRCe7oEPjR42kKGOO+XOWfYpGmOH/kGT1Q6HNVUYpAKBgYtaxYKzH
 /CYoz7mmWRJzN0YMeTCFnKgxWU+EwX4T169jie3oWVna3TU9fT8olDer2nQaTcef7KGb
 ZVwQ==
X-Gm-Message-State: APjAAAUibCvw6Gqe+G+sBRo7V2lTLIVOuaq1NSWZ4TR991EyuinZkzLM
 Wq+ci2xwwaFyf6/qmpxxvEzvrsic
X-Google-Smtp-Source: APXvYqwUBp4290SKWy5rucHRKAmZAfL6pxakGGNgZ58MjsgdhT5nEkd/h2Saz4qLkUfEDzjHuwIdbQ==
X-Received: by 2002:a37:7d01:: with SMTP id y1mr955917qkc.452.1580320899107;
 Wed, 29 Jan 2020 10:01:39 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id f5sm1322648qke.109.2020.01.29.10.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 10:01:38 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu/display: handle multiple numbers of fclks in
 dcn_calcs.c (v2)
Date: Wed, 29 Jan 2020 13:01:28 -0500
Message-Id: <20200129180130.585870-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We might get different numbers of clocks from powerplay depending
on what the OEM has populated.

v2: add assert for at least one level

Bug: https://gitlab.freedesktop.org/drm/amd/issues/963
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  | 34 +++++++++++++------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index a27d84ca15a5..1a37550731de 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -1435,6 +1435,7 @@ void dcn_bw_update_from_pplib(struct dc *dc)
 	struct dc_context *ctx = dc->ctx;
 	struct dm_pp_clock_levels_with_voltage fclks = {0}, dcfclks = {0};
 	bool res;
+	unsigned vmin0p65_idx, vmid0p72_idx, vnom0p8_idx, vmax0p9_idx;
 
 	/* TODO: This is not the proper way to obtain fabric_and_dram_bandwidth, should be min(fclk, memclk) */
 	res = dm_pp_get_clock_levels_by_type_with_voltage(
@@ -1446,17 +1447,28 @@ void dcn_bw_update_from_pplib(struct dc *dc)
 		res = verify_clock_values(&fclks);
 
 	if (res) {
-		ASSERT(fclks.num_levels >= 3);
-		dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 32 * (fclks.data[0].clocks_in_khz / 1000.0) / 1000.0;
-		dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = dc->dcn_soc->number_of_channels *
-				(fclks.data[fclks.num_levels - (fclks.num_levels > 2 ? 3 : 2)].clocks_in_khz / 1000.0)
-				* ddr4_dram_factor_single_Channel / 1000.0;
-		dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = dc->dcn_soc->number_of_channels *
-				(fclks.data[fclks.num_levels - 2].clocks_in_khz / 1000.0)
-				* ddr4_dram_factor_single_Channel / 1000.0;
-		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = dc->dcn_soc->number_of_channels *
-				(fclks.data[fclks.num_levels - 1].clocks_in_khz / 1000.0)
-				* ddr4_dram_factor_single_Channel / 1000.0;
+		ASSERT(fclks.num_levels);
+
+		vmin0p65_idx = 0;
+		vmid0p72_idx = fclks.num_levels -
+			(fclks.num_levels > 2 ? 3 : (fclks.num_levels > 1 ? 2 : 1));
+		vnom0p8_idx = fclks.num_levels - (fclks.num_levels > 1 ? 2 : 1);
+		vmax0p9_idx = fclks.num_levels - 1;
+
+		dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 =
+			32 * (fclks.data[vmin0p65_idx].clocks_in_khz / 1000.0) / 1000.0;
+		dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 =
+			dc->dcn_soc->number_of_channels *
+			(fclks.data[vmid0p72_idx].clocks_in_khz / 1000.0)
+			* ddr4_dram_factor_single_Channel / 1000.0;
+		dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 =
+			dc->dcn_soc->number_of_channels *
+			(fclks.data[vnom0p8_idx].clocks_in_khz / 1000.0)
+			* ddr4_dram_factor_single_Channel / 1000.0;
+		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 =
+			dc->dcn_soc->number_of_channels *
+			(fclks.data[vmax0p9_idx].clocks_in_khz / 1000.0)
+			* ddr4_dram_factor_single_Channel / 1000.0;
 	} else
 		BREAK_TO_DEBUGGER();
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
