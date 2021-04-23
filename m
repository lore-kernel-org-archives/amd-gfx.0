Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11630C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 21:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D3B61409
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 21:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D3B61409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D0C26E0C1;
	Fri, 23 Apr 2021 21:20:28 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B56E76E19A;
 Fri, 23 Apr 2021 20:56:55 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id c3so16047857pfo.3;
 Fri, 23 Apr 2021 13:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=xC8clke3UM2mIx9JGjB0xLMHhnD9lAyHPoIkVfVmf7k=;
 b=UORleTQPlx//sA16AmZyNLDCyyT6yx4snwp1FzP4HvVAy1iDD1Ic7kri3Qcw3uhMD+
 xpgrMrKWQaNluZw0SPUjkfFiidjjQlmpIVcR/zzQHmKgnVp7FMBeR82Wu0rWCmpgK2UY
 0PbiLnAayVV0WXAUKOV1xr1WXhIXAzZJumDEPQnnLagOWQ2KazSvEZ4z0B3tgSefqEuX
 Bu7PUSyqKAmBIhUvX0zjXsVHdf1xyicGu3wrj9iWNgzoS2xIKtg/liwCMvLxy6FnoENF
 tB/onb2lv6kYgMAtvgdAQH2Juy+c0oZyDP9V3cWtjBPBvcYQoPdM3gZQKK4dq9MM5pjV
 vgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=xC8clke3UM2mIx9JGjB0xLMHhnD9lAyHPoIkVfVmf7k=;
 b=SOFB9qplxpme4Q6bD3wVTCVvBEQMkZ1dGk8wG6a6Dno7dYIeLTn+7weMK3SRRsWOrZ
 Lp54iodbTxlhEMfDaQxAgb2ARTnR41IUjmQVe2799ckVUfAs6VBw3cngJmGuaSRpgAp5
 Z8QvW+gKq/W874irzUgq3I1LsdARRSynTUdJuqiV315YoI/iBW5m16jcL2rRvv6565SF
 QEwLBRgVDEFYwhMYOrWgF3rCtbTkeRRFk6KzYEA0s0pSqH04UhbUVGBiafWm9qWKDzBz
 o1TBkA1wcOcQHif4FIod4Wsa2cqcV9RzkrbWrRbPyS6xt4l4POcGvKT7zVZ6h1WnvD2m
 D/rA==
X-Gm-Message-State: AOAM533WMqRQ68NV2zAjZB+m824CZUTCp147+lJKxpW6HVB5jRv64wNg
 JXEmPYHZtZzvp5sqsj9NUxe8tAq+yCqPEovF
X-Google-Smtp-Source: ABdhPJzL0RqFTXQzlWUn3TBLPE8uRtZmzcDmCmxaOZU1fHE1r7/T8vCM+UJ+PGA1xeCtwGogUkk4pQ==
X-Received: by 2002:a63:fe12:: with SMTP id p18mr5519203pgh.425.1619211415366; 
 Fri, 23 Apr 2021 13:56:55 -0700 (PDT)
Received: from localhost.localdomain ([49.37.83.174])
 by smtp.gmail.com with ESMTPSA id g21sm5679013pjl.28.2021.04.23.13.56.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Apr 2021 13:56:54 -0700 (PDT)
From: Souptick Joarder <jrdr.linux@gmail.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 mikita.lipski@amd.com, eryk.brol@amd.com, aurabindo.pillai@amd.com,
 Nicholas.Kazlauskas@amd.com, stylon.wang@amd.com, Wayne.Lin@amd.com,
 nirmoy.das@amd.com, bhanuprakash.modem@intel.com
Subject: [PATCH] drm/amd/display: Remove condition which is always set to True
Date: Sat, 24 Apr 2021 02:26:44 +0530
Message-Id: <1619211404-5022-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
X-Mailman-Approved-At: Fri, 23 Apr 2021 21:20:27 +0000
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
Cc: Souptick Joarder <jrdr.linux@gmail.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Kernel test robot throws below warning ->

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:3015:53:
>> warning: address of 'aconnector->mst_port->mst_mgr' will always
>> evaluate to 'true' [-Wpointer-bool-conversion]
                           if (!(aconnector->port &&
&aconnector->mst_port->mst_mgr))
                                                  ~~
~~~~~~~~~~~~~~~~~~~~~~^~~~~~~

Remove the condition which is always set to True.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 9a13f47..8f7df11 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3012,7 +3012,7 @@ static int trigger_hpd_mst_set(void *data, u64 val)
 			if (!aconnector->dc_link)
 				continue;
 
-			if (!(aconnector->port && &aconnector->mst_port->mst_mgr))
+			if (!aconnector->port)
 				continue;
 
 			link = aconnector->dc_link;
-- 
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
