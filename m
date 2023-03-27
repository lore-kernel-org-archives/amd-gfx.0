Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB764C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 23:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E89C10E6D6;
	Mon, 27 Mar 2023 23:36:12 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C7910E6D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 23:36:10 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id bk5so7701036oib.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 16:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1679960170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMjKJJljMmxLa3Ljhxg1VmcGN3uGAZRfG7BjQI50ULI=;
 b=yZcXL9yyvDZKCVJzbqsl/6xiSdbujypjw3qnCm+WCPI+oYss4rXX79NJb6EhbtXhp5
 LYJdAEiuKIwajKd2vSdA8Vsn+SLgotaZnv312ScdaCXG6RSNfhjqzidGZ5FaTWmOddcu
 UqsdHJyw7JByhHBlwA+ANsEOdFyhKPDFuKMOTDQZxeEmDeFBVCSDD74RXqiDfE4TlQV+
 sTpfn15kjRl3szo+IakedBOdd3wUF6wP+o07P8dSqHEkdd5/zmw/xhwmhb9f3Jl9QUvJ
 nKqDWBehFY5QznZ12WccPFZIrMinZI+bzFXpCrPzOj+NO8w+KAs7YglMRg0fwMJgGOPy
 pFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679960170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMjKJJljMmxLa3Ljhxg1VmcGN3uGAZRfG7BjQI50ULI=;
 b=VB1cbokgep045kc2GBPf3QlPua09BYzMgc6eYEIHkhzHMLp8ruHa5HbvEKxnxZqc3S
 EM6ZGEDsiRoV5dwiiDJzjg24IFJFtExrQdD6BFBGSy95SQ8K9HR8ZGiX+6uw/BB+Er/I
 zMkAPjmy3PCHarELMzdURkFuyX+agOdaUFHwEWSP+dX84nntywbOGDReqPhm0b3GUkFQ
 EHeOIEt/x5/modFkW/rcQ18MxVTITk++coIk2G+RdjKErpWD2X3LDumDlC2sXG1ZyujR
 U+rG7Fb6/gKcaj5PHhabrGRA0I5c+wZlKrA0vYSfY7voHUtRqkoTua5Wsr1Ujs3L1r6k
 XWhA==
X-Gm-Message-State: AO0yUKVHYZJ3+BdWKU9u4VizdawVFsazfMb5PjurJOZUUcF95FerIADB
 uUw4PimlblXlAJbiY51KJg8iENLx3FMHU01DhBBKbQ==
X-Google-Smtp-Source: AK7set9oAz6sAJk9i+Yr1zEBONLpWWppxu2w98hCDmfDs6XKH+G2nHgnPlqdPGuqAbSZfcMHN2iseA==
X-Received: by 2002:a05:6808:7cf:b0:383:f04d:5d41 with SMTP id
 f15-20020a05680807cf00b00383f04d5d41mr5941639oij.59.1679960170022; 
 Mon, 27 Mar 2023 16:36:10 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
 by smtp.gmail.com with ESMTPSA id
 b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 16:36:09 -0700 (PDT)
From: Caio Novais <caionovais@usp.br>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] drm/amd/display: Remove two unused variables
 'result_write_min_hblank' and 'hblank_size'
Date: Mon, 27 Mar 2023 20:33:53 -0300
Message-Id: <20230327233353.64081-13-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327233353.64081-1-caionovais@usp.br>
References: <20230327233353.64081-1-caionovais@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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
Cc: Felipe Clark <felipe.clark@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Mario Limonciello <mario.limonciello@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 David Airlie <airlied@gmail.com>, Charlene Liu <Charlene.Liu@amd.com>,
 Gabe Teeger <gabe.teeger@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Taimur Hassan <Syed.Hassan@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 George Shen <George.Shen@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Chaitanya Dhere <chaitanya.dhere@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Alan Liu <HaoPing.Liu@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Jingwen Zhu <Jingwen.Zhu@amd.com>, Guo Zhengkui <guozhengkui@vivo.com>,
 Leo Li <sunpeng.li@amd.com>, Melissa Wen <mwen@igalia.com>,
 Le Ma <le.ma@amd.com>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Caio Novais <caionovais@usp.br>, Martin Leung <Martin.Leung@amd.com>,
 Ryan Lin <tsung-hua.lin@amd.com>, Brian Chang <Brian.Chang@amd.com>,
 Sung Joon Kim <sungjoon.kim@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Dillon Varone <Dillon.Varone@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Zhan Liu <zhan.liu@amd.com>, Roman Li <Roman.Li@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <wayne.lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Joshua Ashton <joshua@froggi.es>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Compiling AMD GPU drivers displays a warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c: In function ‘dpcd_set_source_specific_data’:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c:1290:32: warning: variable ‘result_write_min_hblank’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable 'result_write_min_hblank' and 'hblank_size'.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index d4370856f164..7392fcf17653 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1287,7 +1287,6 @@ void dc_link_overwrite_extended_receiver_cap(
 void dpcd_set_source_specific_data(struct dc_link *link)
 {
 	if (!link->dc->vendor_signature.is_valid) {
-		enum dc_status result_write_min_hblank = DC_NOT_SUPPORTED;
 		struct dpcd_amd_signature amd_signature = {0};
 		struct dpcd_amd_device_id amd_device_id = {0};
 
@@ -1324,16 +1323,10 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 		if (link->ctx->dce_version >= DCN_VERSION_2_0 &&
 			link->dc->caps.min_horizontal_blanking_period != 0) {
 
-			uint8_t hblank_size = (uint8_t)link->dc->caps.min_horizontal_blanking_period;
-
-			result_write_min_hblank = core_link_write_dpcd(link,
-				DP_SOURCE_MINIMUM_HBLANK_SUPPORTED, (uint8_t *)(&hblank_size),
-				sizeof(hblank_size));
 		}
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
 							WPP_BIT_FLAG_DC_DETECTION_DP_CAPS,
 							"result=%u link_index=%u enum dce_version=%d DPCD=0x%04X min_hblank=%u branch_dev_id=0x%x branch_dev_name='%c%c%c%c%c%c'",
-							result_write_min_hblank,
 							link->link_index,
 							link->ctx->dce_version,
 							DP_SOURCE_MINIMUM_HBLANK_SUPPORTED,
-- 
2.40.0

