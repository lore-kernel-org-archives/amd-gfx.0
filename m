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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F3BC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C76206B7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E97x1XlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C76206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3754A6EBDD;
	Fri, 13 Mar 2020 14:31:05 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1AAF8986D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 14:31:03 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id 25so10202737wmk.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QnHQlyymIloxeODGBnlXuCsawGfH6QPNNiyddqlNxD8=;
 b=E97x1XlSYDeSEWWvKjgKao+lAkQGRmIjjlkkR533SWk2JVEYcb3ht2Aup8JqeU56Vj
 bg+FFJqMya9Y1B8FFWWrxtRdXdnJIu3nqiWUTO125StFh4hb1AKN6pHcO8zHeVCZEb2b
 onbZ30VaKQ99CMr5NRSa52u4fLs0SI2uE6/BvQzLypDTtnSax6FOXLWYo2KBbqaFHJTn
 17A5pKj4NxR7G8MUrHWgPmLUd5g6EAUGY2vwFMCztqvs9i+xTd4mNLzRO0jppwT/O9zt
 QFQqhNX+deOwiaPn9ea4Rgwk3KdhjaHqSGtLOSSFro4jn0CVQRj1IJQjUrMAc3DFSRoM
 aT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QnHQlyymIloxeODGBnlXuCsawGfH6QPNNiyddqlNxD8=;
 b=of979cxJzsSyjj28aFS2iM7VUnw/dzCDnBYg/m23CkOHZxOFYwev5koZZnzBG2eyiu
 lbSkBVad+Izz6iBaSeUBK2ytu/VUcPqS74HsEK4LanxiVCsAwaMeQbH2UBg5VCmN0ihQ
 Tgw6UGaFentIom4iZaDSN0YFUKbdel9LWpFq88nsudQnGAnuLPhtgywt3PIJHeWHnWwz
 0T4Ij5NTG0bVoz2RuvXQSa1ZHRPBQTCB+9tnY2BOac+4WVM8gG6H6UjH00d5Vlk/F619
 U4GWPw63lfbICeKA/lNFtYt/dTlR8sK217G8FMs4utjE+Dd8+p+9kw22wJt6NdXFab1u
 ehdg==
X-Gm-Message-State: ANhLgQ2sj4emPQSlEC/0TrelirweVTbPq9Uw8zEuASbS6AaXGisEOqvT
 6lU/0KoQ5ub8/VKw0rlUHVcXBd8dL9EkSmA7
X-Google-Smtp-Source: ADFU+vvx5MNwOL+qd6iWfTHT7Zf/MmTOf9zUAx7f6ZBW9Ymn8iSfOsenY/TRABnHh+znf+7Hro7wEA==
X-Received: by 2002:a1c:5443:: with SMTP id p3mr10619403wmi.149.1584109859826; 
 Fri, 13 Mar 2020 07:30:59 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F29A900DB158106D933A960.dip0.t-ipconnect.de.
 [2003:c5:8f29:a900:db15:8106:d933:a960])
 by smtp.gmail.com with ESMTPSA id x17sm41638298wrt.31.2020.03.13.07.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 07:30:59 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: fix switch-case indentation
Date: Fri, 13 Mar 2020 15:34:31 +0100
Message-Id: <20200313143433.114437-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
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

Fix switch-case indentation in amdgpu_ctx_init_entity()

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 82 ++++++++++++-------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index fa575bdc03c8..74c795a5e187 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -91,47 +91,47 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
 	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
 				ctx->init_priority : ctx->override_priority;
 	switch (hw_ip) {
-		case AMDGPU_HW_IP_GFX:
-			sched = &adev->gfx.gfx_ring[0].sched;
-			scheds = &sched;
-			num_scheds = 1;
-			break;
-		case AMDGPU_HW_IP_COMPUTE:
-			hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
-			scheds = adev->gfx.compute_prio_sched[hw_prio];
-			num_scheds = adev->gfx.num_compute_sched[hw_prio];
-			break;
-		case AMDGPU_HW_IP_DMA:
-			scheds = adev->sdma.sdma_sched;
-			num_scheds = adev->sdma.num_sdma_sched;
-			break;
-		case AMDGPU_HW_IP_UVD:
-			sched = &adev->uvd.inst[0].ring.sched;
-			scheds = &sched;
-			num_scheds = 1;
-			break;
-		case AMDGPU_HW_IP_VCE:
-			sched = &adev->vce.ring[0].sched;
-			scheds = &sched;
-			num_scheds = 1;
-			break;
-		case AMDGPU_HW_IP_UVD_ENC:
-			sched = &adev->uvd.inst[0].ring_enc[0].sched;
-			scheds = &sched;
-			num_scheds = 1;
-			break;
-		case AMDGPU_HW_IP_VCN_DEC:
-			scheds = adev->vcn.vcn_dec_sched;
-			num_scheds =  adev->vcn.num_vcn_dec_sched;
-			break;
-		case AMDGPU_HW_IP_VCN_ENC:
-			scheds = adev->vcn.vcn_enc_sched;
-			num_scheds =  adev->vcn.num_vcn_enc_sched;
-			break;
-		case AMDGPU_HW_IP_VCN_JPEG:
-			scheds = adev->jpeg.jpeg_sched;
-			num_scheds =  adev->jpeg.num_jpeg_sched;
-			break;
+	case AMDGPU_HW_IP_GFX:
+		sched = &adev->gfx.gfx_ring[0].sched;
+		scheds = &sched;
+		num_scheds = 1;
+		break;
+	case AMDGPU_HW_IP_COMPUTE:
+		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
+		scheds = adev->gfx.compute_prio_sched[hw_prio];
+		num_scheds = adev->gfx.num_compute_sched[hw_prio];
+		break;
+	case AMDGPU_HW_IP_DMA:
+		scheds = adev->sdma.sdma_sched;
+		num_scheds = adev->sdma.num_sdma_sched;
+		break;
+	case AMDGPU_HW_IP_UVD:
+		sched = &adev->uvd.inst[0].ring.sched;
+		scheds = &sched;
+		num_scheds = 1;
+		break;
+	case AMDGPU_HW_IP_VCE:
+		sched = &adev->vce.ring[0].sched;
+		scheds = &sched;
+		num_scheds = 1;
+		break;
+	case AMDGPU_HW_IP_UVD_ENC:
+		sched = &adev->uvd.inst[0].ring_enc[0].sched;
+		scheds = &sched;
+		num_scheds = 1;
+		break;
+	case AMDGPU_HW_IP_VCN_DEC:
+		scheds = adev->vcn.vcn_dec_sched;
+		num_scheds =  adev->vcn.num_vcn_dec_sched;
+		break;
+	case AMDGPU_HW_IP_VCN_ENC:
+		scheds = adev->vcn.vcn_enc_sched;
+		num_scheds =  adev->vcn.num_vcn_enc_sched;
+		break;
+	case AMDGPU_HW_IP_VCN_JPEG:
+		scheds = adev->jpeg.jpeg_sched;
+		num_scheds =  adev->jpeg.num_jpeg_sched;
+		break;
 	}
 
 	r = drm_sched_entity_init(&entity->entity, priority, scheds, num_scheds,
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
