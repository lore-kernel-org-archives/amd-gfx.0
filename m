Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE1AC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 12:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8CC10E436;
	Tue, 23 May 2023 12:55:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE0C10E076
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684842582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ehkOIFzpHbRExxwyu097KqZWDTX7tEk3jO5IBFhFU3Y=;
 b=WHikG8kY2UHRbexUkCLzwsIbOrBPhvhWqBF51aoHUdr23LDsMdOWOkwAg1nTJ5kLJsPsZQ
 JIjCmmU+yj0veLfba3MHSboOE1sblBcIyjeG6A2eKIZ/G0gUHS7IKq8Faa14KSvuXGixGn
 lh12PcJ+IO4Z+ryzHTQpWoPb8MSHi5E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3--lpw5b1ZNrWwFx6DZ7b0sQ-1; Tue, 23 May 2023 07:49:41 -0400
X-MC-Unique: -lpw5b1ZNrWwFx6DZ7b0sQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-75af7f030a8so254341785a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 04:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684842581; x=1687434581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ehkOIFzpHbRExxwyu097KqZWDTX7tEk3jO5IBFhFU3Y=;
 b=WnUFf1JWaLdQjWKSKnSnah0oe0vWrPAlP70Dd3s1spiVAQmxNtd0OL6G4OW1rniiON
 72VWUXc8hzFCc7UQphhe6X+M5xG015swgXYsR3Dg8w7jkOtA0mdHVmzg5GRVgMsA5Hxl
 I7HXu7hZmi+jgf6CgAoGEK6iPZmfTNkv8LJHY/DpJZMz+EqVZkYH8GVZCRiQpwlC4rlF
 a9yD6Rxk2NMhbRYy/lpvfCElKmE9Gh2tMgE0lgy2zfoOmeO9HksnIqRg4RML5RIFc/d7
 4IBsuMYLPhC+nfVqpwSeUSdN9EtquujvQSc/mTDTgWWKWIUOFRl55f+7hMqHTwEY3yPf
 K07g==
X-Gm-Message-State: AC+VfDwZKzBGgvZ+2KzwSxnpCIQqpQV6WC5TVDWrZzvffLqT0Yn5TQ1V
 62kn1Nw0JuvUG9Tm/UgBsTkvRBmjAm5qbV6roPMbmqjjIXXoLhQ51YFY2Vo3TBwdg6nUEoRJuAS
 Z+y8GB6W1bVMA69UGU/hmyj7OZg==
X-Received: by 2002:a05:620a:4729:b0:75b:23a1:8e61 with SMTP id
 bs41-20020a05620a472900b0075b23a18e61mr4404079qkb.50.1684842581185; 
 Tue, 23 May 2023 04:49:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ454BiFvVGHW3X1aVYaT0byKBgm9wV3PxaMMK3SBnSdxglwCADjCPGSr4qskptcC3WGT6OipA==
X-Received: by 2002:a05:620a:4729:b0:75b:23a1:8e61 with SMTP id
 bs41-20020a05620a472900b0075b23a18e61mr4404055qkb.50.1684842580930; 
 Tue, 23 May 2023 04:49:40 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a37c249000000b0074e0e6aae1csm2451529qkm.36.2023.05.23.04.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 04:49:40 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, qingqing.zhuo@amd.com,
 wenjing.liu@amd.com, aurabindo.pillai@amd.com, Samson.Tam@amd.com,
 gpiccoli@igalia.com
Subject: [PATCH] drm/amd/display: remove unused variables
 res_create_maximus_funcs and debug_defaults_diags
Date: Tue, 23 May 2023 07:49:37 -0400
Message-Id: <20230523114937.1080767-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 May 2023 12:55:28 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gcc with W=1 reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:1069:43: error:
  ‘res_create_maximus_funcs’ defined but not used [-Werror=unused-const-variable=]
 1069 | static const struct resource_create_funcs res_create_maximus_funcs = {
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:727:38: error:
  ‘debug_defaults_diags’ defined but not used [-Werror=unused-const-variable=]
  727 | static const struct dc_debug_options debug_defaults_diags = {
      |                                      ^~~~~~~~~~~~~~~~~~~~

These variables are not used so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 7dcae3183e07..6ef7e2634991 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -724,22 +724,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 };
 
-static const struct dc_debug_options debug_defaults_diags = {
-		.disable_dmcu = false,
-		.force_abm_enable = false,
-		.timing_trace = true,
-		.clock_trace = true,
-		.disable_dpp_power_gate = true,
-		.disable_hubp_power_gate = true,
-		.disable_clock_gate = true,
-		.disable_pplib_clock_request = true,
-		.disable_pplib_wm_range = true,
-		.disable_stutter = true,
-		.scl_reset_length10 = true,
-		.underflow_assert_delay_us = 0xFFFFFFFF,
-		.enable_tri_buf = true,
-};
-
 void dcn20_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN20_DPP(*dpp));
@@ -1066,13 +1050,6 @@ static const struct resource_create_funcs res_create_funcs = {
 	.create_hwseq = dcn20_hwseq_create,
 };
 
-static const struct resource_create_funcs res_create_maximus_funcs = {
-	.read_dce_straps = NULL,
-	.create_audio = NULL,
-	.create_stream_encoder = NULL,
-	.create_hwseq = dcn20_hwseq_create,
-};
-
 static void dcn20_pp_smu_destroy(struct pp_smu_funcs **pp_smu);
 
 void dcn20_clock_source_destroy(struct clock_source **clk_src)
-- 
2.27.0

