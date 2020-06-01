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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC2FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B0A206E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za/IgVgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B0A206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2AB46E2D8;
	Mon,  1 Jun 2020 18:04:40 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4736E2D1
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:40 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id i16so1790550qtr.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4/55hOm9VLHBjkVlFvwH561bNVkWjthLwbp3UOtBX+4=;
 b=Za/IgVgIynkWcQOISKQ+j4P62TIEwrE9sz9y0Dora7N/m5uNY+PaCwF+rsCVP55UFr
 gihg86HPIzMXPoFoyq+en96YylLgxs0uUO2xurp/pxIQVZ0KdQlgoSWiFasbJiTTY7Xn
 KyW9SXeBV6TucyS4s//3/IwZ1HRbcjJqCybd3xqoVwXw0LtaWXQKX/uTg3IIKT3ZB8ev
 GnCxub+/bmPg5WkJhGh9ITu+ONIAjG3EU6KmQCfqdahDtdTLwiOo7J6Y6UoVZjRAk4pg
 rExgX2duOtz7tR6WtKuJ2GXmjGnXTEKvj2dG8NUXRsqjoBUYHFg4Sj3/lA1738G7zgWh
 v2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4/55hOm9VLHBjkVlFvwH561bNVkWjthLwbp3UOtBX+4=;
 b=gcIRg8hC4whzOIx3nxJjvpX7wxxtcm0dccPgzCl8B5IFqsvvhTfIOjLhkc4P4kF7L3
 f1Vbbo5dMcpekcV2siA+vrxeaxDmBkw5GQL9UuDrwsMjkUz6RxQSmoXllTiAjw9Wk1+S
 4c9ohNKWqHEwc6Z2ICVbBzyXehfzFRBkHcenVmZjpZHkr072pCQng/PUlc6ByENqCxAg
 LKq3MkT/52AuE3Ij0kJw9JO+SPoD7anH7NAYCJoK9cX4q3alTi34oBJGN+kghjkPAgnB
 o6jutJyTLHK07mxb1L+RrP8aahQkg3AJPYMTqbvhABfNOboFcYDJRfac74KsHgChKiKU
 6G/A==
X-Gm-Message-State: AOAM533MmlkqN8Du7x0FcRE5rRPQTjippWiFiAVZAtNaui9gvGBpxVTy
 sbjbFGPh4zLxXk2I+3zRuIjIKoWS
X-Google-Smtp-Source: ABdhPJxFpwMj4xpAY4zgPABoaVf+r2jEA9Qho20rpchr+P31fuPIGIXxPd/lxKgL4VWz4BK3qfQ9YQ==
X-Received: by 2002:aed:2542:: with SMTP id w2mr23913159qtc.43.1591034679252; 
 Mon, 01 Jun 2020 11:04:39 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:38 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 079/207] drm/amdgpu: add mes block to sienna_cichlid
Date: Mon,  1 Jun 2020 14:00:31 -0400
Message-Id: <20200601180239.1267430-76-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Add mes block support to sienna_cichlid.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index cad66cb1b6c2..587d0b6821f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -497,6 +497,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
+		if (adev->enable_mes)
+			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
