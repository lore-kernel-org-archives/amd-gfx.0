Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A55C5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 09:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 809DD10F2CD;
	Fri, 21 Aug 2026 09:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OIaVU4UZ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF0BD10F2C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 09:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qmqlnjfkm42iblW3kZ+Qm7kmO7mtu6lDMon+7FlHbcqU72LPalpN6OrGeJ+XedA0+gLRklgdYnQWGgiTAEg7rb12JMKiEXRWm4tYYiiN2yJ7i9YHYSxzUNovSNG+fYm2g4+NKRl1rEKWvUt8zD0SgfO+ROLbRC9YLAIYwtoA4IaQiSh77q1fp6JQ6U0umJe19YQMY6YJv5nItmfsUtf/85wpGNu+h1h+DzV5fUBZefSmDDpVrCl4UKC5+4Dt4GIzjeoZvKvBBgVqlVjCOBcklXoqy2PEdBb+ZEA9FWKtXQ/2VpLcsCZF0fvROK+LmxyqAk0677UcQVgTU1dIr4UL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3tDjJiyRBYv+YnoIkPwgTePbATtRFYimtgdB+xches=;
 b=j+ytShbKJQg7+5EGqDZCASYuP/w/rnt5ZSaHmn4tYW0c8fDDyX2HZUo4nUIrS3qBGoeieUJucFeEnLw0TDT0ETH9syk9Ql891xy0NSnuqh2eThzsxoET0hjLGcaIzY0MC56aJEmzoXhL/P7JmnBCgKlUhDclsFXvoXoUTIqNCCwBbIu9AyEJrlYCL811hsiNAzZEDq/rFqmrcrHtxJ4PGcM8Sacz/0Ea6pzAvF6Er1bCKMejukRxFvjBC/HT8TintE91FWASDQntkp81wffp3l8fQot6gPh3JP2q9cxzoQ86jaEBwRpQBl6FttnuSP2Hyah0UYtrajCRqU6LeGDKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3tDjJiyRBYv+YnoIkPwgTePbATtRFYimtgdB+xches=;
 b=OIaVU4UZEPBmu3hmolCGBXwXy9lrfVMB6sRcaQMI/8/Ly2rbOvelHKcrSG4bcywvXQbtGfO7Y2nyDEfeskPN3uHVGDbEDkGyQikwASKQPeOVuCqWbc/MtX9JSJfJpr662BHOhrfAqg+1MZGYOchjfMVdF98hR+9sNaVCVYB1PT8=
Received: from BY5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:1d0::32)
 by DS4PR12MB9772.namprd12.prod.outlook.com (2603:10b6:8:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 09:54:39 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::40) by BY5PR04CA0022.outlook.office365.com
 (2603:10b6:a03:1d0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 09:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 09:54:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:38 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 04:54:37 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 07/10] drm/amdgpu/sdma7_1: implement update_mqd
Date: Fri, 21 Aug 2026 17:52:16 +0800
Message-ID: <20260821095427.2361126-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
References: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|DS4PR12MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: d81eb09c-0ade-407e-92a4-08deff6a3737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 6+HQAdwmSzyvp1YHowl+rfXGxTPsqRnaXiEXR+bPMh1i/Mx+AR5MeoiXhDZPZjaKVf8vUPs5KgYyAC1P2vNgoGALjLrh23GeK4EDtWiJB18e6RRBIebj+fad3r0+lsypYhFcQ81HhCWnyVnXUtWLUU86qsRIg3IFbjUSwcQOEkCAjdwJjQzKzqXrQLVnTqaanVkfX6s5wSSHSEWXu5VwK8xDY9P1V/tgfxV7aiNE4pIwW3N3wmTqJ8MbzPDefTdeivYsZJaw22KbBX7yhD4rm+C5XK0cggvKZA8uQw3BFjsYop6J+fNC1J1es1p4WzPVZ/BtVT77HiwYBG/r2k0GjQnIcjb/XWhlHmm8C3HUcJ4qdOUfRyTXiXqQcMh7+7SX5ZmE76USl4H/hmRTlCo10i+nczQtH4f09lnlEzesWDGf5DNJk2hUp/7LtflTBiQmfLCdL7rwqkVrWKMKzKfWRAzXMNh/Wo9t17bk7fgiD015zqQyL4wNhv+OTA+wOBMCC07jR2qbTUk/rN/4HHVjAHvHrDgNLW84wOiook7A+9jBn0tTUVRYSybpUbR+P7IRu+kJtUyK04LgkYjelZtiCUIkRSxBJI+6lX55FQS+5v1WntNJ8M8PLi3FtqW0QD/VeLw1jmIbIWEx9HonklVEYdOzJNTUr3cGUW2TnohJ0hpOIjRJdFLI7Qtbae0t9OZM4x91KYWDXC76b0kt9RN6eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a0mjQ+3S3LtbLrroDpumOzlgd8YYrOiyaM3vyL1j3Q/W12fpqkm4msmWI2tfyKKkzy9ly8YxROC9kNlcFD719jQAP0ArtPHYqrXSR60gzTytwOuJIXEn5NRpRJCDAd0XQ5MqY7998C4mNFxTR0Hfsz+OptQKne531Gc9CQrDRHCsEHqRdolriqNiVtW0Dwl6kbMdgh0wsY1lwmENSgf3kSBb/QyHENOmuWkSYrsrHout0UMZSQmesFbMtHOuioOouSdxqlHmkTmEUj1t+vPdnP29km7oTP/wpywbgAiOzrkDBFygBLPA1o2/T8Ji06vZHmiUn+9usu+adiQd7/tlHU48mCDEriuNjInTh3pyCV1r0rZRcYi/CJRL/HUlr+ZZx1vMRSCKPOKlrM9gDtsyqax1VNU+5USSaI9TNdlX9gz9sX4qurx7FEi/GkHmf57L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 09:54:39.0542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d81eb09c-0ade-407e-92a4-08deff6a3737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9772
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement the update_mqd callback for sdma_v7_1 user queues. SDMA init_mqd
leaves the ring rptr/wptr alone, so re-run it to rebuild the HQD, then
restore the saved read pointer and forward the user write pointer. Force
IB_ENABLE on, since init_mqd seeds ib_cntl from the live IB_CNTL register
which reads back IB_ENABLE=0 on a stopped queue.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index e9a3bcfd7775..e74ab8112d50 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -889,10 +889,39 @@ static int sdma_v7_1_mqd_init(struct amdgpu_device *adev, void *mqd,
 	return 0;
 }
 
+/*
+ * SDMA update_mqd: init_mqd leaves the ring rptr/wptr alone, so re-run it to
+ * rebuild the HQD, then restore the saved rptr and forward the user wptr.
+ */
+static int sdma_v7_1_mqd_update(struct amdgpu_device *adev, void *mqd,
+				struct amdgpu_mqd_prop *prop, u64 user_wptr)
+{
+	struct v12_sdma_mqd *m = mqd;
+	u32 saved_rptr = m->sdmax_rlcx_rb_rptr;
+	u32 saved_rptr_hi = m->sdmax_rlcx_rb_rptr_hi;
+
+	sdma_v7_1_mqd_init(adev, mqd, prop);
+
+	m->sdmax_rlcx_rb_rptr = saved_rptr;
+	m->sdmax_rlcx_rb_rptr_hi = saved_rptr_hi;
+	m->sdmax_rlcx_rb_wptr = lower_32_bits(user_wptr);
+	m->sdmax_rlcx_rb_wptr_hi = upper_32_bits(user_wptr);
+
+	/*
+	 * init_mqd seeds ib_cntl from the live IB_CNTL register, which reads
+	 * back IB_ENABLE=0 on a stopped queue; the re-mapped engine would then
+	 * drain the ring without executing the IBs. Force IB_ENABLE on.
+	 */
+	m->sdmax_rlcx_ib_cntl |= SDMA0_SDMA_QUEUE0_IB_CNTL__IB_ENABLE_MASK;
+
+	return 0;
+}
+
 static void sdma_v7_1_set_mqd_funcs(struct amdgpu_device *adev)
 {
 	adev->mqds[AMDGPU_HW_IP_DMA].mqd_size = sizeof(struct v12_sdma_mqd);
 	adev->mqds[AMDGPU_HW_IP_DMA].init_mqd = sdma_v7_1_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_DMA].update_mqd = sdma_v7_1_mqd_update;
 }
 
 /**
-- 
2.49.0

