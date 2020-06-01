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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A618C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620532068D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvWOUP2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620532068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D45F96E2E2;
	Mon,  1 Jun 2020 18:20:00 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 166FA6E2E2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:20:00 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id s1so9982317qkf.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+BZ0o+e9EYocn6W5FfblmtxAK5Xdbtsw8rJCEyfcwS4=;
 b=MvWOUP2M0ycrmv7GkkbeumAFFYAPF43T+80hOXcoCg6ZKpY9+T8KeVnUG4ko630AsJ
 u+bMSu620yHXYwCImHrfkVWJ5fR4VJefE9m299hJONB85SUTlEKYCMseOD9rmyH8D3c1
 1JYG2s7KgPqQg/WqzGac2+CFHI+nGMT9DWq0uq/AAkHqzhun2st5snzQJ1eYHcRy82P7
 0xUT9kgcfvKmTk0BFljwN9ndMyIXuYi4UFlP4seW6KMKfLEw4ttChTinex5HztaFJvh4
 eslO/jN/1+3ZSa+8rk2XUZSD6PJqPYturpVS4Qcod7eUI8QVYAdtcTFIUuFJi0vauA1B
 yLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+BZ0o+e9EYocn6W5FfblmtxAK5Xdbtsw8rJCEyfcwS4=;
 b=d6SZwf/A67VfhMgX9eh/4Y0ybISfp9zBCAUU5Mj4ZBNX6yNenffMg3ZZDPY3UTibnK
 CP7S9VL/HsZ3qViRjppF0lrqON/CDVh3dB6MCj324q81sGCNY04s6HwhNKdh+3Or/4Qd
 zdGj3/O0Gs6I5uaw2ABuXSXfGspHN4Mn6gt7WEjNpnqIfwv55D97QJ+NItSvh8moWU/0
 9QTSVTAEDkuaStCpOnt802Wz/oc6wJxoj6qgD46Uatwiy1xQ53eF5jo5ctZojM9WlfqK
 Vlt+dAZUF4BXC7+aoE7wKuDO/IcgX84xPfElB/YlzhL9fwAFmXX0Llqbffb4T4mXGCHY
 rk9w==
X-Gm-Message-State: AOAM5331P0cqYoFvZ/5v0UtBKdYLCjy/gnzoG7n1QJo0HF9+KLKfoP5D
 ZriXBILr0ogLZTvRHG5e/1KpsQR1
X-Google-Smtp-Source: ABdhPJwAhP4/mH7ZxuCAIrhE5WVjWM3JFz6GMexJTWVqYYgoHVtTOi7eqxqmCQO8NgWklxqsHdNB5A==
X-Received: by 2002:a37:e205:: with SMTP id g5mr21640028qki.451.1591035599100; 
 Mon, 01 Jun 2020 11:19:59 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id r14sm15156760qke.62.2020.06.01.11.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:19:58 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 089/207] drm/amdgpu: enable JPEG3.0 PG and CG for
 Sienna_Cichlid
Date: Mon,  1 Jun 2020 14:19:49 -0400
Message-Id: <20200601181949.1267800-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601181949.1267800-1-alexander.deucher@amd.com>
References: <20200601181949.1267800-1-alexander.deucher@amd.com>
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

By setting up the flags to the ASIC

Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index a7a03706025a..81032b0d8512 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -712,8 +712,10 @@ static int nv_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0xa;
 		break;
 	case CHIP_SIENNA_CICHLID:
-		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG;
-		adev->pg_flags = AMD_PG_SUPPORT_VCN;
+		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x28;
 		break;
 	default:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
