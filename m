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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E283CC41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB912064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpppCUL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB912064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79E16E0F7;
	Wed,  7 Oct 2020 16:32:38 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E10696E0E7
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:36 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id c62so3505174qke.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6xvUSBOJ92115+VN/pduTwAkfkfSNwcl1Y5DT3q5Eho=;
 b=rpppCUL7cdYw577/okE2bwJDqEQSdVb8+RR4bslxTv1RXolCJDwpczLI92GZLfA/yf
 EAyoe5tHvDha3LJa9x7aOaM7MAdHwqTXMRFJc3iR73GuLy2zbr26npjAL9zMDCoed1Xe
 ZhWtwFgbMyXxSJkB8VcfW9bvU3mn2rnLwk+jFndLgL5J2Hw8s9Bjg+3+oJdCmdP+6zTI
 OLW2Mra/H0eEcfrz6ZtuRz9x5zFvYwY1w1HihPB8vEivnHtSQqfcCQp3CcUdIVZFx8wZ
 O64Mji3Dncm260EnWK7j0ax6EzrD1GCd+fN42Ag+/TMbYGjhRacBkKFgamY1WcSkaZgN
 Cxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6xvUSBOJ92115+VN/pduTwAkfkfSNwcl1Y5DT3q5Eho=;
 b=WUEalIX+Sv3HpLKuobe1aq9JQQB87jTVmdIwpjuoqqu98hsmKpn4kcgITBH/TcFahc
 7SvRMc+wXLzwPYKLD+UMLas4MfJ2HX6nSIOFXnL8Un0TNKM+G+9ObEJTzMuIZwi01NWR
 LDltcjS3LfCmHN8BMdbhnuCcbTY1QO5L7LFifO+6I4KPOPVt7E9eXcFR7hUAOG9nGDS7
 A575cWdDALlgUwEYxp5KvGd+QIi7vbCy1Qwfdcc909hng3Rp05x2uXy2enD09tJB5eC+
 P/x8L6WnC3fbXHhld+gUFybUnMOp/YUGwand0B3EX0G/FEgYbnCfzaThvT65D0pSM0T8
 KgEA==
X-Gm-Message-State: AOAM532S5l1uYaWL5sNCvl5SHaqGJh19BFAY1Chj9pOdMCb84JhriXad
 dlnlIBnys3Jkeai1rqkPb/OVdt79rB4=
X-Google-Smtp-Source: ABdhPJyTNSVqS8/pZ2EAbeFueSZaJKsbMo6PumheYlVbSXiEmTDVud1236CJplRgLNINn7N1Dp6prw==
X-Received: by 2002:a37:9b09:: with SMTP id d9mr3595325qke.393.1602088355871; 
 Wed, 07 Oct 2020 09:32:35 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:35 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/50] drm/amdgpu: enable front door loading for
 dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:18 -0400
Message-Id: <20201007163135.1944186-34-alexander.deucher@amd.com>
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Support both back and front door loading for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index d068bffed742..07fb40ab0fc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -392,12 +392,11 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		if (!load_type)
 			return AMDGPU_FW_LOAD_DIRECT;
 		else
 			return AMDGPU_FW_LOAD_PSP;
-	case CHIP_DIMGREY_CAVEFISH:
-		return AMDGPU_FW_LOAD_DIRECT;
 	default:
 		DRM_ERROR("Unknown firmware load type\n");
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
