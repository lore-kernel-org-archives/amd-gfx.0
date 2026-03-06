Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E38FCC04F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 17:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3631810E3E8;
	Fri,  6 Mar 2026 17:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mpJOiBFq";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42FF610E0E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 17:24:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DN0OCusAajSBb8hd60RclTR44brXtgBn9XUvitNjdkM27xe0H6s7EIlqM8VukuO2Zz+dzcZ5IbBArRY2wLKN/vjIUPS/5N9uE30DmRYOZe18kBQQjvIJX8rAVtP7IT6/5Q8BTYzpwCLiGAbUj03+r5VMLnG5HB0YOaXhHGf4tk2nZehl4ZLy++qtPtMTFUUvpiYKMf1OA/265VnHnEKKMbfXzL49T1A2cdXYMGGtKKHgtr63UmxChS+gBPAdgBpJXgMjBs/pa7BOVDCqCjomlaIbRl8xhP+v4gdbRcOR5O80kr17KxvXdTvPUyUZVMiezANr4vjnYg5rC+rHN+EIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU45nP/BAPCyRvxEMUHS9O+i26049xnfgzuvsWtNbTc=;
 b=sKycJHFodU2g1RxZBfp2adGprDaBE1MrYvzCk13sSBO4wrTAWlGwCfpm/jj079elzBfmKe0WxhNCZXz99VmbPsKOMfyc0/wAJBHenLu9FyD2BQbOwn2rW9tYw1EesUFozqSDmeUSkR1RgZQgWwjqI7An0ptq8LQVUoPUKrm+O0HTXx64mvWDiJHSKDmu3TP+NvsK/6njT2KxK1Yic3K+Xzj5TKHYcdCFjcLpjTjHYEXRDw+pRTP+3Y4Koc1gAaqdUQtVs08Ms5NdXH6yeI78IV7Tc/BE5zKRkhprcikX55rdSBwRmMKg/o5KSzsWZAfO2GFW4nyqar+dBiNNudd97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU45nP/BAPCyRvxEMUHS9O+i26049xnfgzuvsWtNbTc=;
 b=mpJOiBFqMZh303dSq6P6rZjoi9frtyuEc7BYK29LWKhtfVfVaOunIVQ9SPKORpdiZx9/LxepiUeRWn3/LmGaZ62jg/DMYK7mN1evdoJIar2Q/Po1zuUxj9QZg2zq+SXhu8979m/SlD+vP/4B8YOyHgBhz1j4nj6J8ge7StNV1IE=
Received: from MW3PR06CA0005.namprd06.prod.outlook.com (2603:10b6:303:2a::10)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Fri, 6 Mar
 2026 17:24:26 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::3f) by MW3PR06CA0005.outlook.office365.com
 (2603:10b6:303:2a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 17:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 17:24:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 6 Mar
 2026 11:24:25 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Mar
 2026 11:24:24 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 11:24:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/9] drm/amdgpu/cik_sdma: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Fri, 6 Mar 2026 12:24:10 -0500
Message-ID: <20260306172417.325169-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306172417.325169-1-alexander.deucher@amd.com>
References: <20260306172417.325169-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1e87b1-367c-4f91-0d39-08de7ba53710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: 3NVAJ78MbjUs02f5daZkFbU5HPeHI/wTW0XGTypHfkdml/7R0gW9W5OWqFwGQwQAsILP5dPIHWF1zmW5VqquAwbi+kVvXUDCTh4iQEnqqS5O2HWMbKw5CYfTPhyz7DoqGBeqltllAdOWK+KLDBRVteTpYqKUq32KiHSg6QD7Z8O/8ZbnsGGjzcOlL1ec6jZCTsg/EjEB/r6yxkUmVcXqzdbAlt9cLC6vRYtG3g+XMaOSaiqtHMzIayoyU5UjrVCvajvgq5Z0MT4uTxoIDR1rd+GT49+Y3wArwsxKUzydOE7idLHstphcDYllL2wCTm2DnnTuWHrzBaoj1VUBFLw48q8LoeBOTYeNM5dM+j1bSP6ddAcQQLdHQzfTT7xJSDsU8C8mvVr4rcziW7vkWcqAU1mYrme5CcMwMULqgGVyyQqZB5+RKdQQ+0XHBbffilROzcqzoqvgIfB/x4om9WgXGwPkZG/ZLu7MhYqPhoX+xCIVDqlwPOj+6umpKRWx+dYPmVnQw475Uq5qgyFzYLdF+GOEGJy93WYY5n4pTEOvwrsroDBppwyMiQiBMyEp1DvPUu+s5K8aLcaqu9stTT0ImAmMw3rGmRUDqRmzg7Tgful+DNmR/QfufBUFykASfece56RSYCFMIRJwzMiUkX+p+Ce35b0qwiGmCEm9rCJnWuraB0Ov6fSRM4M5R7c4cjpcjtg75w+7CJjgQ2aFw0Tsnbe6yBFEHvxqkl87neRyC94Lf/+FShpO2P+cUWy6aDnSWGIk1iN7k+lgx7CQ7slRiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 04FUxN/aaD6Fx6dKEHlyRSiM52cps4JYYpsBE9ztCKT/4blhhWQMlFO00+aZ8OyASoweByWvWruQneh4xDfkhA/unczJX4w4s8fSdFMNC3iHSyBoM1dj/0NvBdN7GqC3PrXH0sfW5dppAUuJO3RuUrfznInI0YyRImc6PNAkBCi8dC3EwHoP+X0i1ct+kahwjiD+uyUbDiSz6tslQEwG1bZe/2ubUTasO+KDxqcHbDFNh2mqoyBwFd9lE8rGPLDA1ZXVOSrfUlqMECjNi/Hr9ZCwhg2d3R4KLzL4zANM67SdpixZIOV4xbd3arZwAT2yIWes9GI11i8FiW79o20MYJ+OpDj7TnUDVGELrqF7WSDNt3ExfHQii202RTG3MvvepiDqYs6bJiejxjELNonGNeC8iVxW+v6WX+S0g7PAvoMp4YJLvoV2EMJWB3YB/Plk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 17:24:25.5468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1e87b1-367c-4f91-0d39-08de7ba53710
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 22780c09177d8..849fc68aebd47 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -447,7 +447,7 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
 		       adev->gfx.config.gb_addr_config & 0x70);
 
 		WREG32(mmSDMA0_SEM_INCOMPLETE_TIMER_CNTL + sdma_offsets[i], 0);
-		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 0);
+		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 10);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

