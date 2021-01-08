Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7635CC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3038C23A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3038C23A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083EB6E85B;
	Fri,  8 Jan 2021 21:59:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EC796E85B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610143140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rY5ZPZc+UpoVk06JLNrDEFfoZnlAUfsw6zwHWZ87dfE=;
 b=LpwCU7be2zrxz6UPu3uslW09NzPMOBdHdbxdYLAf0LH6vZH56Qksxti4BFyJKH8niVHV3i
 tiTTgFhXv3ZVTCV35DvkooZ5te24X1dG1kO4zloSFYfTcuIi8WmNK418YiUAKCF95Dtwyi
 w78gk07ad9ntKW5rg1tQeEB+iH3wi3M=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-i-S2FEeZN2madiEDXDAE9A-1; Fri, 08 Jan 2021 16:58:56 -0500
X-MC-Unique: i-S2FEeZN2madiEDXDAE9A-1
Received: by mail-io1-f71.google.com with SMTP id 191so8935195iob.15
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 13:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rY5ZPZc+UpoVk06JLNrDEFfoZnlAUfsw6zwHWZ87dfE=;
 b=Ed11q0EF/haW3YY8oY3zoPINjX80aL/Pm/fdqvidfM0CmIkGXHNgJyTws3QfVHGfoI
 +TZHeMtIu6+URKwfJopiK68gBphK0FwPgftjfY/4GvX1goRVAVTvDE1PoKdubjrr/3HW
 2YUSgPbaZW8jTQO25ooeExysfZPgGRm5urysChKA+ZGdgTB6WB++nCYvPpa5D5fvcGc1
 ivRA9paLiYtTUPXY7Iuv+/3suqJWShNv2XpqNHU3h0b67efTKrFJ8oVw1UWqMOWvyfTL
 Uf5AC9dzZYK2Su3HNSDnbxGX8S3wkPNqwAzEJ4H0ZvFIUGaFv/wrDx3NtKfXUMP9510X
 BzkQ==
X-Gm-Message-State: AOAM530XUJieCVlFfvc9GBZB9tQkPF1l6/heRNPVo/StTt19vj2W7x3l
 dzVupufOl5EgzeuUHDRYGPlk3m/S1PMSnHUuYQBr7tayw93sznmK6/SJSGq0o855lGfs6DLJibD
 U1Hx5cGeYqjzODINv70bQvrIhJQ==
X-Received: by 2002:a6b:1454:: with SMTP id 81mr7014766iou.96.1610143135590;
 Fri, 08 Jan 2021 13:58:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcL32QS4piiA/+xZFlxxD2vJ8+gVoEA1QeikN8eAe85m5gz3Phc/CaInN+y9uuwjkvaGhbYw==
X-Received: by 2002:a6b:1454:: with SMTP id 81mr7014752iou.96.1610143135364;
 Fri, 08 Jan 2021 13:58:55 -0800 (PST)
Received: from dev.jcline.org ([2605:a601:a63a:4d01:c440:5c61:43ba:350c])
 by smtp.gmail.com with ESMTPSA id h18sm5961873ioh.30.2021.01.08.13.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 13:58:54 -0800 (PST)
From: Jeremy Cline <jcline@redhat.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] amdgpu: Avoid sleeping during FPU critical sections
Date: Fri,  8 Jan 2021 16:58:38 -0500
Message-Id: <20210108215838.470637-1-jcline@redhat.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jcline@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Jeremy Cline <jcline@redhat.com>,
 Timothy Pearson <tpearson@raptorengineering.com>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dcn20_resource_construct() includes a number of kzalloc(GFP_KERNEL)
calls which can sleep, but kernel_fpu_begin() disables preemption and
sleeping in this context is invalid.

The only places the FPU appears to be required is in the
init_soc_bounding_box() function and when calculating the
{min,max}_fill_clk_mhz. Narrow the scope to just these two parts to
avoid sleeping while using the FPU.

Fixes: 7a8a3430be15 ("amdgpu: Wrap FPU dependent functions in dc20")
Cc: Timothy Pearson <tpearson@raptorengineering.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index e04ecf0fc0db..a4fa5bf016c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3622,6 +3622,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 	if (bb && ASICREV_IS_NAVI12_P(dc->ctx->asic_id.hw_internal_rev)) {
 		int i;
 
+		DC_FP_START();
 		dcn2_0_nv12_soc.sr_exit_time_us =
 				fixed16_to_double_to_cpu(bb->sr_exit_time_us);
 		dcn2_0_nv12_soc.sr_enter_plus_exit_time_us =
@@ -3721,6 +3722,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 			dcn2_0_nv12_soc.clock_limits[i].dram_speed_mts =
 					fixed16_to_double_to_cpu(bb->clock_limits[i].dram_speed_mts);
 		}
+		DC_FP_END();
 	}
 
 	if (pool->base.pp_smu) {
@@ -3777,8 +3779,6 @@ static bool dcn20_resource_construct(
 	enum dml_project dml_project_version =
 			get_dml_project_version(ctx->asic_id.hw_internal_rev);
 
-	DC_FP_START();
-
 	ctx->dc_bios->regs = &bios_regs;
 	pool->base.funcs = &dcn20_res_pool_funcs;
 
@@ -3959,8 +3959,10 @@ static bool dcn20_resource_construct(
 				ranges.reader_wm_sets[i].wm_inst = i;
 				ranges.reader_wm_sets[i].min_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
 				ranges.reader_wm_sets[i].max_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
+				DC_FP_START();
 				ranges.reader_wm_sets[i].min_fill_clk_mhz = (i > 0) ? (loaded_bb->clock_limits[i - 1].dram_speed_mts / 16) + 1 : 0;
 				ranges.reader_wm_sets[i].max_fill_clk_mhz = loaded_bb->clock_limits[i].dram_speed_mts / 16;
+				DC_FP_END();
 
 				ranges.num_reader_wm_sets = i + 1;
 			}
@@ -4125,12 +4127,10 @@ static bool dcn20_resource_construct(
 		pool->base.oem_device = NULL;
 	}
 
-	DC_FP_END();
 	return true;
 
 create_fail:
 
-	DC_FP_END();
 	dcn20_resource_destruct(pool);
 
 	return false;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
