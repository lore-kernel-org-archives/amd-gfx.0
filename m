Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578F1C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 09:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57A1113106;
	Mon, 20 Dec 2021 09:02:10 +0000 (UTC)
Received: from mx6.ucr.edu (mx.ucr.edu [138.23.62.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2331710E8AD
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Dec 2021 04:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1639801369; x=1671337369;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HiC3hCK63Qa8Qb4loFRgdeRVld94u+OjjR3csxq5Wus=;
 b=t1CYNVZ19RsyuR3XE5TL/kOtOt4k0vEiF4B0Ltu1TBHBMSi+S6TK0t8I
 yTSXlcMSmsvUvfZx0tdj5fL+crfYAGJekgUyTy03K5LbUIR7uArMV/ye1
 c1CRKMeIidF6HPAluOMtwkjthkCRzImJnHbwdJH2hM8Omk0uMSMWiU+Sa
 TH/ShoE/1L5tAvBlgsud0nCrPZjwXUE2xgxTibKhctExmBw4qQZxRmy8D
 RYn97awX/u5HjtNmE06pcu2CTFLwkzrShOz3+XSt+C135ZLnAVqalK13w
 WBWlERispVd9WV32ZdTHQX6a3vU7lG7U10vNYQaOZpouDcGLoZoKzMZY3 g==;
IronPort-SDR: AIl+l0RFaNWBDcR1s/0bGdmUoKPNXxKNSbV0NNvsMgsCs2I8AG4y70xITStyj9iTj5IoCpqiRE
 fknS3l5tHZj0NKMH/9WA/K1ZFcmIte0LSphYZnHc+d4DTUP4ARIhONCbR6Vd3LnfYTqmS7WT8I
 hOqTQjLn1SRD/Wc+duMvcYp4zFvgiT5dOyaMbNEmGVlstbKml487ux2U1QO5wLuLhFn9P8JdN1
 FAhGWfTFwDIpczG/0eTq5M3lrhC8IgGNHvNpxJMDk7V2nqowpsmdK7VqGuVW94wDdUO3DUazpc
 rTmbLMElnWv0tO2WPRnumgfr
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; d="scan'208";a="267686070"
Received: from mail-qk1-f197.google.com ([209.85.222.197])
 by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 17 Dec 2021 20:22:34 -0800
Received: by mail-qk1-f197.google.com with SMTP id
 a10-20020a05620a066a00b0046742e40049so2348649qkh.14
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 20:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucr.edu; s=rmail;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uFquvFdIStXIJTsPn2k5rBU0qh7wG0l4oiCoU43pQg8=;
 b=bXlm2lS0L1cyH2tSCF4kf3SQ17o+srdPcNuSX0IN5fdxXx90fPQz8j0OTE/DIoDyNG
 NBLMGRGfhKW/vXeGz0RyOrwHJPODREbZxxtNpZqx1FHpckyz9EkMB+GVjII3tzO39jqR
 54F6vn74a8bEU6PVKdMbAqjnZHWPkSh7B94io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uFquvFdIStXIJTsPn2k5rBU0qh7wG0l4oiCoU43pQg8=;
 b=p9AdxEtaZQGP7KhulbVLkw/ERaHw5LYutkZ8Pm4gGlGUoSM14tVwb6N3HUvwwvhqIt
 N4pb3BE220a979b0A+8qmS+TOL+wG0Tc32BATIgxoLZR0YK9VrjQXDxi29E6rsAS+PIO
 6RJyHd+mLCFScQ0B5Go/rmPZcApfXCMblFOi90OxCoNQy2qkrRkh9mxTuV9ui9RoPCMC
 LE/jL1mgxnebq1/7qvL5gLGSBUeDNqCU8puyJaZojNRZQ9qioJZ/Ig9b9gqjvqPoAWh8
 EXBzw/jJfjITfDf/deluqOsaPCD1AiXF3dIWiMhJLUyS4ZfwETkr9yVQuTaCRGdWoUDI
 RP5A==
X-Gm-Message-State: AOAM530CoPezNoF6ioO9v/gEdH2GdjNO+TcMGv6vMu7ESjUBHKzAw7bK
 0IahDM01QokrolXYV0XfT9omJuc+pKyCUoOQZJSa4LaNVtuV3vrQ8VcQCMOfbqNKDvGHUk+rjXI
 LUjoD5o/lE/YYpgSl+yFfkUdLcXU=
X-Received: by 2002:a0c:edca:: with SMTP id i10mr5323752qvr.62.1639801351932; 
 Fri, 17 Dec 2021 20:22:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyE3Tagh5RgslGVJv/eRvjbgxu42RfzRLSIimsqstN4aB/aqSAgEsFtcF+iB7KjMXViNfFsrg==
X-Received: by 2002:a0c:edca:: with SMTP id i10mr5323738qvr.62.1639801351765; 
 Fri, 17 Dec 2021 20:22:31 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
 by smtp.googlemail.com with ESMTPSA id s20sm9081682qtc.75.2021.12.17.20.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Dec 2021 20:22:31 -0800 (PST)
From: Yizhuo Zhai <yzhai003@ucr.edu>
To: 
Subject: [PATCH] drm/amd/display: Fix the uninitialized variable in
 enable_stream_features()
Date: Fri, 17 Dec 2021 20:22:23 -0800
Message-Id: <20211218042226.2608212-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Dec 2021 09:02:04 +0000
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
Cc: David Airlie <airlied@linux.ie>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, dri-devel@lists.freedesktop.org,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Jun Lei <jun.lei@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Jimmy Kizito <Jimmy.Kizito@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 amd-gfx@lists.freedesktop.org, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, "Guo, Bing" <Bing.Guo@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Agustin Gutierrez <agustin.gutierrez@amd.com>,
 Mark Morra <MarkAlbert.Morra@amd.com>, Robin Singh <robin.singh@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Yizhuo Zhai <yzhai003@ucr.edu>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In function enable_stream_features(), the variable "old_downspread.raw"
could be uninitialized if core_link_read_dpcd() fails, however, it is
used in the later if statement, and further, core_link_write_dpcd()
may write random value, which is potentially unsafe.

Fixes: 6016cd9dba0f ("drm/amd/display: add helper for enabling mst stream features")
Cc: stable@vger.kernel.org
Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c8457babfdea..fd5a0e7eb029 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1844,6 +1844,8 @@ static void enable_stream_features(struct pipe_ctx *pipe_ctx)
 		union down_spread_ctrl old_downspread;
 		union down_spread_ctrl new_downspread;
 
+		memset(&old_downspread, 0, sizeof(old_downspread));
+
 		core_link_read_dpcd(link, DP_DOWNSPREAD_CTRL,
 				&old_downspread.raw, sizeof(old_downspread));
 
-- 
2.25.1

