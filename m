Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB924C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 15:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE6523329
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 15:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE6523329
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D6056EAAF;
	Wed, 13 Jan 2021 15:24:21 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F30556EA66
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 15:24:17 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id 2so1285266qtt.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 07:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c38Z3i7wyqZ2AoBI7tMokj5G+FD83lVpzKyX+ujthQE=;
 b=FK2GjKpSfz0g7Vf79H4YtLu6Lbmp5KXq3ElRfpnYA3K3pD79Rm008OTv0sr2R7zdxD
 f4dVCpUo2L0BKcw/2Z/sOmL8ziLQFcuLN+NVkLeswOfva4jBPLrrk1DrEd0miCxFNNue
 wIk+Q7sFxYcIiUyyxg2rnTqYs5wvv1AOmwo8Xg2mpq/VegOj6ah/bhZNPm1aLG9aq3dD
 4mYYBhUE208bIAV8VxQLaBAVVQzEsxAiM9NVWYWKai/vNvcNfWlEjewAjE2O+CQqiECJ
 JlKFlkvhH8Ed7IeGJQZDi8ZpjTt9UO7crKN6sCVHtXKlw6OYeMfCXBCVbuUXHd/UobSu
 HoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c38Z3i7wyqZ2AoBI7tMokj5G+FD83lVpzKyX+ujthQE=;
 b=mO3uZkeaJK7iSQnrbVINIW9YWiqkt74rkM7Tq+ES6MpH9HnltaV+ATTOiN6K7RAaKD
 jmM6xCdXj3sj8uR95zghIK0NWGmxiAleD1Jl1KYTZ2Brc3Ny29aLuDK7TWJ58zDHjPkS
 6iU98/mI6ACdZJJMwAO/VXwAU86JA7zqZfQhuQnbUo4qfOnNt6rv49RJ9FcNu+h0U7b/
 vTBKJys5IbxuwAU83guc9NYiEnHGn5ZwNCi1DNv1J3HecYAa0UE2tQEL0stH5XrzT0hm
 AH/hrJBcM+20M/jl7UxkwM4MP09ByNKi3lVD916k1fxRUJ1IBPW3ekHS+/i4sXlhLXSu
 xQbA==
X-Gm-Message-State: AOAM530/gie7BlOaSSRNffhE0rJ1v/c4Wn0RtUppz2u5TGm+JmvNRZOH
 8BXdOZGIg1JlL8j13rV8Oamt1OLV9pw=
X-Google-Smtp-Source: ABdhPJxog0RY4/gPFi5VrfiXtsBLniSRb6PidBca+m21BM7BmqTgRdl+TKedjJGIlD2fLztsz/qYlA==
X-Received: by 2002:ac8:2a8f:: with SMTP id b15mr2685491qta.33.1610551456984; 
 Wed, 13 Jan 2021 07:24:16 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.241])
 by smtp.gmail.com with ESMTPSA id i3sm1159827qkd.119.2021.01.13.07.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 07:24:16 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: add new device id for Renior
Date: Wed, 13 Jan 2021 10:24:04 -0500
Message-Id: <20210113152404.1307212-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113152404.1307212-1-alexander.deucher@amd.com>
References: <20210113152404.1307212-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 stable@vger.kernel.org, mengwang <mengbing.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: mengwang <mengbing.wang@amd.com>

add DID 0x164C into pciidlist under CHIP_RENOIR family.

Signed-off-by: mengwang <mengbing.wang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 5.10.x
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6a402d8b5573..3f0f3ce2611c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1086,6 +1086,7 @@ static const struct pci_device_id pciidlist[] = {
 	/* Renoir */
 	{0x1002, 0x1636, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
 	{0x1002, 0x1638, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
+	{0x1002, 0x164C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
 
 	/* Navi12 */
 	{0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12},
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 9a25accd48a3..2396be16c28e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1204,7 +1204,8 @@ static int soc15_common_early_init(void *handle)
 		break;
 	case CHIP_RENOIR:
 		adev->asic_funcs = &soc15_asic_funcs;
-		if (adev->pdev->device == 0x1636)
+		if ((adev->pdev->device == 0x1636) ||
+		    (adev->pdev->device == 0x164c))
 			adev->apu_flags |= AMD_APU_IS_RENOIR;
 		else
 			adev->apu_flags |= AMD_APU_IS_GREEN_SARDINE;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
