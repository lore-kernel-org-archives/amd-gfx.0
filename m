Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B21C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 21:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3042075A
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 21:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV4s8j7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3042075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1911E6E91C;
	Mon, 22 Jun 2020 21:41:24 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33AE36E91C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 21:41:23 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id z63so4951108qkb.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DkXB2V4ogcP+9ukF//eFEa30Qb9tOpSiiuUpuQIL5io=;
 b=XV4s8j7+aJz/tz2HtNuw7wAXF6M9awAKCFT+zKXrLiY8dMFIMhn3zaokKUDLrLSQhu
 TgpgPsO7B1BD+niUczvTpBMrBf9OtGD4phwgjWrAZUoN8AkSvrGlxuvd9BcIxvpMRnn0
 6bHDiGlSlpUIf3budiMn9G7dyOUPAqaTOVm9Ews8QDr3yE6NCTjS5pu6ms+VSsl2hcQy
 eAjH9NLJFbQjY/ioVWm0LvzNQRA3Pk9vQpXW0AbfIjoha3Ii6oHr0s1Y/7DWogYA9X+D
 30VbJnZlAmw0sVgZvIhK2iUMklvkbMeuF8yPncpJ7FD1wYRQ5byhS+neEr3GxClYl13d
 +H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DkXB2V4ogcP+9ukF//eFEa30Qb9tOpSiiuUpuQIL5io=;
 b=B/XLQ4XCUQI3ynJV3E86Ip6z9xs/2dpXbvSeYHmbO//h+1ccyvk7yesDrQcGVmyuUC
 /PSHswmONVoWY19Wqc/rH5BxFqF464sLLEpYbxDZOoCuvvHk0NkZl8A+UhxSqRowmsSX
 467aOcKvuiwjoWpBK3fFDCEyrCvmTGgudGuNO82aa5C+AR/eXYUxF7/gr6WQ5brTbadE
 MRJLcsf9KYxkvM3dclxEAN4VM7kVvzFMVLa3H7HUKxaNayH6TbJH/C1Jt+NSe5Rz1Yue
 d9Zw7qGs0OungXyGbxeKdEXjAQQM2T25TiJfQ5jRKmE/s1TXdDuUVqRtOKVnnEz/JQ3a
 HHpQ==
X-Gm-Message-State: AOAM532aI8cbPFM9BgNPjG5R/HRDmnth6qya/yVX8tGeci0j1vcLpS62
 vumuSKzBFfO/YlVUu4DknL7ukmwy
X-Google-Smtp-Source: ABdhPJwSlA9DbOT1B5Lun2bzB27thRQnpYATGXSKBpxqZRlwenjpgUgsVCmlFdeFs4fb+NITzPYW2A==
X-Received: by 2002:a37:2d43:: with SMTP id t64mr5861662qkh.81.1592862082178; 
 Mon, 22 Jun 2020 14:41:22 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id a14sm13809101qkn.16.2020.06.22.14.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 14:41:21 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: make sure to reserve tmr region on all asics
 which support it
Date: Mon, 22 Jun 2020 17:41:13 -0400
Message-Id: <20200622214113.969491-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This includes older APUs like renoir.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index f1855a8323b2..7d51768684dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1974,7 +1974,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * If IP discovery enabled, a block of memory should be
 	 * reserved for IP discovey.
 	 */
-	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_discovery) {
+	if (adev->discovery_bin) {
 		r = amdgpu_ttm_reserve_tmr(adev);
 		if (r)
 			return r;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
