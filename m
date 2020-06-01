Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFB4C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0628620872
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX4XoN16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0628620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4146E2DF;
	Mon,  1 Jun 2020 18:04:51 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5437F6E2DF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:50 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id s1so9930539qkf.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+jcaegCd4tsuLytS7h55Zb9LscmQu/1lkJ53Lv7BT3A=;
 b=IX4XoN16vnGva5trYUgGeum9iNhv/87KAOSPsN1psGw8TNrWvodOhx+tO2n0AQM038
 JehA4GtX/YVYsdQ4qYSrZCjCz5V1dX4IT/GvgKV8M3+kFYJSpCbxFjr+eJrPMiqgJLu/
 bsv8gPm19+8Yp4Jo+7kA5AZ480Ejzx0yFkVAwhA3Xz4rEmkVFLpEwDAUw4mJRQGJudTf
 XIQmf/lIX+ZVfPz9dufsRzRhVirTUjTcVOez3dTD3ER4y0C30bGF2Xi0n2sDPVuKATRI
 maJydg9GyIu3SIt3mjwFZ2+G10Ouysn51Gq+EMmHVkqhJ35G/b9L2FzM2OZu0CQ7d9rS
 /ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+jcaegCd4tsuLytS7h55Zb9LscmQu/1lkJ53Lv7BT3A=;
 b=TrL0G8AH88E+AiUabXVWrLxy7l5f+Tv/ZymCKfvG9c1RZCV23EgWyvDL43cIzBDasX
 lxO1g+hOwP5cR1jv6WxfKiMiQFaPCe8TvKPimIKsjyGPz/KkGAMQZVVSTM3LGHJFA1YI
 k1B+xhJJzjhNoL3NJbH6UMZe/mQE+Q/o9wWHLZZ6d2LsYox4pFJ5P/RmpziyGRZj8gB1
 JDal/IPobSHnMyJWAsKhrlQAsOiDpJ+CX2n/jSfcPR2yldw7N6cEM/kvn0R/QEzo0Rvk
 8EoPx7gBtb+u9IT66PT/p/TP2bptgG5Wl35pjTKm9uR59rr99qh8o5UcDpVTL3iJAHKs
 SBBw==
X-Gm-Message-State: AOAM532zaOhtX508y60GZ36GkpEu3A6elsJUJYcpftJZ2u9RkL30o6vp
 12aAlo8TQelqHulv/SGZ9Nb/djMb
X-Google-Smtp-Source: ABdhPJxCAOaUX5njmwGLR8+m4aBJL4udC5odSOWUsRe9CsTtZ85fEWK58Y+0zKvl41mIvUO9nOKCAg==
X-Received: by 2002:a37:bc07:: with SMTP id m7mr7789911qkf.93.1591034689258;
 Mon, 01 Jun 2020 11:04:49 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:48 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 086/207] drm/amdgpu: enable VCN3.0 for Sienna_Cichlid
Date: Mon,  1 Jun 2020 14:00:38 -0400
Message-Id: <20200601180239.1267430-83-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Liu <leo.liu@amd.com>

By adding VCN HW block to Sienna_Cichlid

Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 80428ae470c1..a7a03706025a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -56,6 +56,7 @@
 #include "sdma_v5_2.h"
 #include "vcn_v2_0.h"
 #include "jpeg_v2_0.h"
+#include "vcn_v3_0.h"
 #include "dce_virtual.h"
 #include "mes_v10_1.h"
 #include "mxgpu_nv.h"
@@ -497,6 +498,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
+		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 		if (adev->enable_mes)
 			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
