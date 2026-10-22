Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD44606A31B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HBDFCJva
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68ACD1123E0;
	Thu, 22 Oct 2026 08:20:57 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2940F1123DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQANmgWuZHsflKR7wkvqgER+sBRRJT4N/ZxjMcUUiFlt0xW/1oR+mE0rvimZ1nH2kI4dRuoAYB+dv0NJigQyugNx9NbHKdAX+kZa8o9+F/F86tqGAllJOWEoxehydMGOZOWAfXhFbw9HFKBnV8pZPm9UzFBisSBgWu8i6WW6K0I2xTNR+x1yjjRAKayCf9imapzqgyQoq74zRzF4WgWcG4A9Iy7Ut9CUNJNqynWXFhr9p9gdriSGrqlPmzxteIhzFsTbsNDIqfH3xkCkDkSLJZPaps1QzN2jv442KGqxVmnfm1GqNzDlP7pONVVoJ44cCg4jkAYBNyrbCZK/9XF5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKsEq1pQDc3657WEc5N1mQfG///XYrRavsNPKUglZus=;
 b=I/jQj1BoTieMiiGZtiyTLzuUGyNPFV6XZna2rEQTBu+lcJDF8cHlOLYGiTX5lECvR3mT6P+Tf1lrCATnOYXGaYQsc9AbSmy0L0BERfb6luobgrU9WOAC8uLxHgFQoK9Z6dO8lRblfu+W/PEwULnIAh6TrBckzz/cL6CNHv6A1R6j9DrxLWTpWxvEep7R9/hJeYcDyK+Yh/5u9v1+LiNOol3pCuDzzNdAcW2Vj1S0Zamywxvbw6ZBT9vTBQ7h0bGAcittR6cwBuitqG+eOxV+gB1CTN2wtCtdG0u63MsxUmOqDX8gwetYHMycD8aEzGA/Cq5WPnGuYAPOTxx+DnPUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKsEq1pQDc3657WEc5N1mQfG///XYrRavsNPKUglZus=;
 b=HBDFCJvaweRO/lh+M4F6ecW6CMzs1ZrTqkxtfF0pA+pMfLa5shgrzGvAv0DMkoFuu4np3fgQRm7JcN0Vkm35PYwfPFxg+5Yfh4Lp6JKGwS4BhTsGgTXIAqtOUR7y1hvxX+G4nfU29ZY/YJaui4yeTrgwcfv3tG5vcf759jPFPmA=
Received: from BN1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:408:e2::8)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:20:47 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::29) by BN1PR13CA0003.outlook.office365.com
 (2603:10b6:408:e2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:20:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:20:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:46 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:44 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 13/15] drm/amdgpu: add a debug_mask bit to disable the
 engine reset
Date: Thu, 22 Oct 2026 16:19:53 +0800
Message-ID: <20261022082011.331462-13-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 8664d22a-2683-48e6-2a1a-08df30156009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|22082099003|18002099003|261021121427099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: XvBH+//wsNESvksfXv6aJQA6CEGAjrUaBN2qG8fuvCEpxjX05Ab87OfXB87Oq8LFEIg948oKBuLXNzup8mUnsXrLjVYHY6OuzsSonwl732sD0jgqQWd9oU5S+sAUHI6tnFfkI7zModwJLQ4dKSWnJrKdt99zfxJnkhnkwnZacLDdHQw/I7y/1Nq00hNy/+A18HSH9axBUWluXhRj30082t6pKC3byR0lM5UHd+KKS6P8cOnoQV6OfOTgKlGuE4lVR7hHZmHzGDyGT3Z0eyv7W77PQyZ+qiafomM2KgWFQrWSBkmO/BdyaRcXl6bHmksrQwPsMRLZmYFcYrTc7oAAaHwy90q3kJfKsd5JxoF9TL1q8AuST7mgLVzYGAINr+XseXmJ8ggveXAGlPfd/A3ykHIbLPbxXg1Ncahld2npUiH/hKifRj8MWd/HhiF0y/CuADzyza+tNxIsYLtDQB4sZcTpj1fNtr+Ty+qAVGxGg2/7+w1Dpb0kehO3jjVQhVsJwhtCMacTJXcfcFoIcPCkM2+sDeWH6DRfoTN2qI5rrVqgZo+tpFIGNRR1FBfK4kRhY3RJkdx1HKyxjEdNaxWlL5KMbeRWnce1ehLNeGI0hXP1xh8qQQJER85n/Gl5sztDZdjJoDFc8d4kYgBEx/+/TRJ3i3rAPzUioylprrpkSwP1WpA0LsLqQwlk8CMoryHIvJ2921dZebV0rsljVF9SsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(261021121427099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aVudaLHrPhGMpSkjkLTjlzJHT8SLZjziEFFBS0++02zVn0vystDi8XiSYiv/jlVgbHjfj9kEdacXZ9EWKCfbfxwgq3WcFpMW23XLmoA+ZFtm39NNkuwbVEoeM/NWzrX0lyQDXtr/WyRiM/GU+3dnaeMgdyTcQylys/zYYqfoUTqGZ/n8YCzWHW23JMqbdZSmFLpS4vbpxb+ZKG49j79J9Ji800jFWxEiICr/FGX/5/XnItMrghaG9JJ26K3/gAKJLASn2Bep+xQzM3hElDJf9LlPKskTZf3AY75tm9X5Y5DwefkZgbI1ukq/mcu4uNiuZ8CiwGz2ULiXmlwz/s0jzDmQ8XPNcjJKTEyBAdAciiqhjlJXIrMSLCB3P+413KgJNDw6O/NvZr9TwRWHWXvk/kgrG0M2D5BA70j3naPcFix5k8nbFV/YZi6hWafjQl1P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:20:47.3158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8664d22a-2683-48e6-2a1a-08df30156009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add amdgpu.debug_mask=0x4000 to keep the IPs from reporting
AMDGPU_RESET_TYPE_PER_ENGINE, eg. to test the recovery without the
engine reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index da99fa2f1b87..69ad6be01ef3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -951,6 +951,7 @@ struct amdgpu_device {
 	bool                            debug_enable_ce_cs;
 	bool                            debug_hibernation_thaw_resume_gpu;
 	bool                            debug_disable_ip_block_soft_reset;
+	bool                            debug_disable_engine_reset;
 
 	/* Protection for the following isolation structure */
 	struct mutex                    enforce_isolation_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3e5634de077f..43d3e7b7ef03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -150,6 +150,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU = BIT(11),
 	AMDGPU_DEBUG_DISABLE_IP_BLOCK_SOFT_RESET = BIT(12),
 	AMDGPU_DEBUG_SDMA_RB_CMD = BIT(13),
+	AMDGPU_DEBUG_DISABLE_ENGINE_RESET = BIT(14),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2341,6 +2342,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		adev->debug_disable_ip_block_soft_reset = true;
 	}
 
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_DISABLE_ENGINE_RESET) {
+		pr_info("debug: engine reset disabled\n");
+		adev->debug_disable_engine_reset = true;
+	}
+
 	if (amdgpu_debug_mask & AMDGPU_DEBUG_SDMA_RB_CMD) {
 		pr_info("debug: enable SDMA RB command switch\n");
 		adev->sdma.sdma_debug = true;
-- 
2.50.1

