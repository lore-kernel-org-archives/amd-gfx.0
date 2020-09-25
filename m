Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54322C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E1423A31
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNXeihDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E1423A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A08A16ED7D;
	Fri, 25 Sep 2020 20:11:53 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE7C6ED7D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:52 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id a4so3106430qth.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n6U70RhiWGAVfkVFv/7BGojT7mQeLAksRoszgvULfq0=;
 b=hNXeihDiE5r/KeaKaah19wOuKT/UHbMsp/Cz4yllC+RncrJwjy6Y3vPkHJmawEuQy8
 3Uh4I7b0YX9u2bMKfV2uODgxSS/MOJAqNOLZNhG6s8OT/t22S5f+e0IrKNd2YgTKCoVt
 Uz/5zttz6jSehPBC0UGKqbdpG+v6JJl733ZuttZqJJdpBiyfliD/R2GyLjXJwF/eISUZ
 pCH1Ad3oR31g+xK7Ylw6R6w1d6sHGZu3DMQLcK0khzrJq0THBkNnBZ/jxi/QnEzOsEtv
 4Ct54XSw2/C27rrt2GX1ck5s/kq6EFQ/Nh4XD9eokPtFcpoh4hw+ysukp8UpxvHvw47h
 PBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n6U70RhiWGAVfkVFv/7BGojT7mQeLAksRoszgvULfq0=;
 b=KwdGPAuaeML6+MyNxgGvWb0V8tpKo0svb8+1GhFpvbAr2hr7F3PXKkKxAcbNHciDuF
 +taYNO0L0a27XL6iupp5AdJL9d8im2MbpfDNjMch4Pypxeqj7QWz6TxX3jWpjL8Z31Wu
 SLdYX0Ddm/1R81Kwf7wXDqDHn72PpRlpM/N7/5Ar7UPxoHFBUAGQkYo9Pl3ZuZavNy0f
 BCexUnsf/npkEam3uXkmrZUduV0l1L3WJy2ggxui5FCJhUpReHlXsgxQ9zUxiGIdyORR
 NW4alnOB6ChJsXyx8eZK5Lgb8wCW416o4v4VyyQw9F9gKvXSnpHuRioj9GTiRL+QPOfV
 r0eA==
X-Gm-Message-State: AOAM531ar9MgfH8duklbPETG7IbJjl69TAEIazISyq4y2C0UCwubZu30
 0L/OJjdeui/ze95IUbauVK8TherVVpo=
X-Google-Smtp-Source: ABdhPJzkvOEFoptDvpXr2a2mO72UujwvEHVSp1Dz/rFB73siKIRzaR2y5uKHIiAJlB4rclleS1E7Ig==
X-Received: by 2002:ac8:39a7:: with SMTP id v36mr1546256qte.140.1601064711912; 
 Fri, 25 Sep 2020 13:11:51 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:51 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 41/45] drm/amdgpu: add gfx power gating for gfx10
Date: Fri, 25 Sep 2020 16:10:25 -0400
Message-Id: <20200925201029.1738724-41-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

This patch is to add power gating handle for gfx10.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index fd29a6d7285b..f2849f180c91 100755
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7583,6 +7583,30 @@ static bool gfx_v10_0_is_rlcg_access_range(struct amdgpu_device *adev, u32 offse
 	return gfx_v10_0_check_rlcg_range(adev, offset, NULL, 0);
 }
 
+static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
+{
+	int data;
+
+	if (enable && (adev->cg_flags & AMD_PG_SUPPORT_GFX_PG)) {
+		data = RREG32_SOC15(GC, 0, mmRLC_PG_CNTL);
+		data |= RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
+		WREG32_SOC15(GC, 0, mmRLC_PG_CNTL, data);
+	} else {
+		data = RREG32_SOC15(GC, 0, mmRLC_PG_CNTL);
+		data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
+		WREG32_SOC15(GC, 0, mmRLC_PG_CNTL, data);
+	}
+}
+
+static void gfx_v10_cntl_pg(struct amdgpu_device *adev, bool enable)
+{
+	amdgpu_gfx_rlc_enter_safe_mode(adev);
+
+	gfx_v10_cntl_power_gating(adev, enable);
+
+	amdgpu_gfx_rlc_exit_safe_mode(adev);
+}
+
 static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
 	.is_rlc_enabled = gfx_v10_0_is_rlc_enabled,
 	.set_safe_mode = gfx_v10_0_set_safe_mode,
@@ -7630,6 +7654,9 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	case CHIP_NAVY_FLOUNDER:
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
+	case CHIP_VANGOGH:
+		gfx_v10_cntl_pg(adev, enable);
+		break;
 	default:
 		break;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
