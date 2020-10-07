Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C55C47095
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23152064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKMnvT50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23152064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 968376E23D;
	Wed,  7 Oct 2020 16:32:30 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E5F6E966
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:28 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id b19so1478242qvm.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4mq2PGr4CFnLNyKLng+ucprL9xkZgNRKo/3b5udx/qs=;
 b=aKMnvT50lZNHkpkkNbCdsQETuLzXBkRvVf2tG6jGhTtB/+NM3AA+ni4jidjRe5IhIv
 6Ulp5O7nnqRm85El6VB4fDPpmNRaaEz6FA1X4xowbBFah8HCNNDP+tRH+TnvA8cP9jaA
 OCXlGiHLCIVZEA9RskIoIqjdo19qMRvHfr2P+N41wvByIsk+toWxXGYddw4dCW9LzNhD
 85abFsvvG+DUQwp3D3O5TPz5QOIF3wep/RdG3LnJ0yNXAHMFoDQL9UHQoOxZEwluZ+pu
 NRKAzWs9QAjWPW3+vwP35DsP1p4sGMWevXJ7Vjrk4R+x6J+28XPAXDjfAX6ERCqqjhbs
 ou4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4mq2PGr4CFnLNyKLng+ucprL9xkZgNRKo/3b5udx/qs=;
 b=f+tPXaays6L7TQ6renXcRaCjGV+/95oDE/fqq4DuaJisxVqSw4qlZfpOr61K/rOUrk
 vfRCCJFDMQGc3lgkCX+OXb2ll2JJAnoNmKuoeEWQ87IjUka2sqlKfUxT3O4PVzmZaBoc
 pYHQZx4j9NWVwRFzfAYrSlppwgeLs9biwHB2X0Ftnu5gkKCrTN+ZNlQDMciB+Tv9XM/u
 G7PUXZlSz9B2+3WbpzTav7NxppK16Usw2e/7gjqe8zVYK9/rdBVcXykhUG0vG+acXJNg
 kGCcj/Q76s6zUMAncXXQLO4AOpGd+tM5Cdh56OrdMIQxCMgifeB1uKkQS1SGMuLVZW6V
 OHTA==
X-Gm-Message-State: AOAM532b0J/+kyheOK/EwztvFT4m/hUndxmXYLKg8H2BaIvF0Mn0Rytk
 Hifm1yQ0JTQuDgAz6KQSW3ux5kF+/RY=
X-Google-Smtp-Source: ABdhPJwIE5Qd+XQ4oneo66IcaiQ2udHE3DvY+XeDh+OgFR4o6QFMlkC1urzI77+8Ze7sdwPerq7U6Q==
X-Received: by 2002:a0c:a482:: with SMTP id x2mr4031095qvx.56.1602088347372;
 Wed, 07 Oct 2020 09:32:27 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:26 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/50] drm/amdgpu: support cp_fw_write_wait for
 dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:12 -0400
Message-Id: <20201007163135.1944186-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Same as sienna_cichlid, dimgrey_cavefish supports WAIT_REG_MEM packet.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 352864d7d468..d4da6c647059 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3617,6 +3617,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		adev->gfx.cp_fw_write_wait = true;
 		break;
 	default:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
