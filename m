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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185DAC4CECE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DDB206B7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROztcGN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DDB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B07C86E9CD;
	Fri, 13 Mar 2020 13:56:14 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5FE6E9C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 13:56:13 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id t2so2154090wrx.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qMb31hzZAr0s7hBIY7QpABBOd3HiIGBIAvYBqRL+g7o=;
 b=ROztcGN7GaB2RHECbcy81/icvZCgCFLKwQuPegnxAFUx6pHD5hk1YnVs2mWXfLQRVf
 /1omMmrvjjPc1Ivsf1zPcbtvsFxZJBE3OFDzBjU+NrA/0eMMIwX0YWWGB6ix19tusbbR
 pjFz+eTyuW/Q43eaygFpOnXdfRNdTLbUTlu36D9f3DDWJ+z5F9L/9KUWj5CmP0m0/pS5
 ututwBv4dNn2p67dvutPzTqFqC560nxlgd5F2s8/RkQuqwCxhLI42wHRn/JDn34vw5nk
 ycIGxfN51rws3qlZFzC1EtEFuOPT2KA8rK7oGE/t+30Uj/E5243cne73MDYQddrPe/M6
 9CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qMb31hzZAr0s7hBIY7QpABBOd3HiIGBIAvYBqRL+g7o=;
 b=TYJnSjooxftCeNlrYx5axy2oFv/vtWyeo/eFWRH/XTIfVgeSykgm+c1kV1iwdWQyRl
 aGPgYCXRrCG9d2qBO3zm1zNCu9rrPw16/gmw3EJUmIwKvd7qSrpJps8KbI/tZ1CEnByR
 r8xggqCRRW3dRhi0Vm1eWrt7joZMYYbOV2nFrorNMZELRfdHGA1IirTQ4hNac/HJK6Bq
 u7+1KSg/1HDKEttvc9U/h2h2akmp7wUe8ATiebDz+KNIB/JZX24ROntvbdX1zxp6sg8X
 kv63yWjDcK3i+NPRylM5Gd/NKya0bMli4rvlDRCNsBJPCakkC98Qs5mNSrLDwFv36+zo
 /nCg==
X-Gm-Message-State: ANhLgQ3g0y0p66rdeWt8fT/LKcsRcD7UKH4lOFU48+gXPLu5GaBOu/Hk
 f60YRhzAwCUKJ3rn5TTUaWXXYdnctVZ0IO7c
X-Google-Smtp-Source: ADFU+vu3k2NdGZmNvkyV2WVZ4QHedpiC5HGNXBrt/+CjzPbIj4WNqug0s8zyhLDubahdDxnupCGBdw==
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr18116499wrr.415.1584107771622; 
 Fri, 13 Mar 2020 06:56:11 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F29A900DB158106D933A960.dip0.t-ipconnect.de.
 [2003:c5:8f29:a900:db15:8106:d933:a960])
 by smtp.gmail.com with ESMTPSA id v10sm7309467wmh.17.2020.03.13.06.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 06:56:10 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: disable gpu_sched load balancer for vcn jobs
Date: Fri, 13 Mar 2020 14:59:53 +0100
Message-Id: <20200313135953.68418-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200313135953.68418-1-nirmoy.das@amd.com>
References: <20200313135953.68418-1-nirmoy.das@amd.com>
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
