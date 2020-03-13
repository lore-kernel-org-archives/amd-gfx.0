Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3F3C4CECE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 12:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E4F206FA
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 12:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo+QyJs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E4F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A3A6EBCF;
	Fri, 13 Mar 2020 12:01:32 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 460E96EBCD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 12:01:30 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a132so9637052wme.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qMb31hzZAr0s7hBIY7QpABBOd3HiIGBIAvYBqRL+g7o=;
 b=bo+QyJs4OX6SC/RAWZHFYscQA2EC8uMnE37gKhz8DGYxRGm369FqdR8Vai35U7BPdf
 /ZSLZqY9PGqIjBTYnFJgvQAm4FCOsIJ6J30LSmWe6Ps4+IBtF+ao3dcqAkZs65xOMglq
 ec/VtBKM+1g1d7wfJfdkfulNvA1bmmz8uGnhPut4+xgjDQE56baHgUuA//7ccbgQkYGh
 VCn+gaHfrUWo9coXvtWVAltkDy0euXstQ9LpGsPiDMpN1xtQxnqZGqhFnavzr8Aimk+6
 HCN5LZPggYoB9rMpJroAA6vtdfsTNGMTNMrwaOl0RcjvLYN/yRYd/UZIgf0+B0h5ebHX
 ceIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qMb31hzZAr0s7hBIY7QpABBOd3HiIGBIAvYBqRL+g7o=;
 b=nxUVrg7+tbGniWWPWdUI6WZYZvDQl0eEEcbU6YuXBdzegMf0N96mGK0C/vVbINtsFr
 m/FcMZX8op6HB7KM9JwFEcObWwaU+jh0A/ZDfKQy/dvOiUYinDOkGNBfqFkx3zd4KO4/
 JJcfynBrVSX1BDISkW+6KNsAkJS3gpIPi2Hc+Ijxdb3yQz9QiSsshqyU+tqNR70VhBXL
 Z0EdqGtykvo4Cm6Gzm9+00n10U9YWmUFuhhOG2DBXrhnZB/eMwRMaED10uDycb0YC6Kh
 udC5HfrykKIVfZz8cxFRkhjGk7jhLljGhKYi8V81rJWaFSbXy7PKospWAdYEhfoh9yh3
 qW0g==
X-Gm-Message-State: ANhLgQ2lvCXmB5foRQha1wLqSG120xhrQ9HsVUUCdtzFADf+Mb2RyeAN
 Nja5Ly9Id25ajBYn0ITAHyBuNiFMrJILrjw8
X-Google-Smtp-Source: ADFU+vtUw0ST6BN6oXrJ8cmIdoqW9Gapa1Gsn7detnjoExm4LV7POxSRzLImEdF1J89/cQ8KV9mnyA==
X-Received: by 2002:a1c:b7c2:: with SMTP id h185mr10823531wmf.67.1584100888477; 
 Fri, 13 Mar 2020 05:01:28 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F29A900DB158106D933A960.dip0.t-ipconnect.de.
 [2003:c5:8f29:a900:db15:8106:d933:a960])
 by smtp.gmail.com with ESMTPSA id c23sm17058428wme.39.2020.03.13.05.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 05:01:27 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: disable gpu_sched load balancer for vcn jobs
Date: Fri, 13 Mar 2020 13:05:08 +0100
Message-Id: <20200313120508.36004-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200313120508.36004-1-nirmoy.das@amd.com>
References: <20200313120508.36004-1-nirmoy.das@amd.com>
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
Cc: Boyuan.Zhang@amd.com, nirmoy.das@amd.com, alexander.deucher@amd.com,
 James.Zhu@amd.com, Leo.Liu@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VCN HW doesn't support dynamic load balance on multiple instances
for a context. This patch initializes VNC entities with only one
drm_gpu_scheduler picked by drm_sched_pick_best(). Picking a
drm_gpu_scheduler using drm_sched_pick_best() ensures that we
do load balance among multiple contexts but not among multiple
jobs in a context.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index fa575bdc03c8..8f1e3c05812e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -121,12 +121,17 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
 			num_scheds = 1;
 			break;
 		case AMDGPU_HW_IP_VCN_DEC:
-			scheds = adev->vcn.vcn_dec_sched;
 			num_scheds =  adev->vcn.num_vcn_dec_sched;
+			sched = drm_sched_pick_best(adev->vcn.vcn_dec_sched,
+						    num_scheds);
+			scheds = &sched;
 			break;
 		case AMDGPU_HW_IP_VCN_ENC:
 			scheds = adev->vcn.vcn_enc_sched;
 			num_scheds =  adev->vcn.num_vcn_enc_sched;
+			sched = drm_sched_pick_best(adev->vcn.vcn_enc_sched,
+						    num_scheds);
+			scheds = &sched;
 			break;
 		case AMDGPU_HW_IP_VCN_JPEG:
 			scheds = adev->jpeg.jpeg_sched;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
