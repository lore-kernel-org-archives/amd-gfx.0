Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA29C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B3D10EF12;
	Tue,  1 Sep 2026 20:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EkhPSDQ1";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0DB10EF0E
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIId4iXepLwVKHjcOlBi9PW6B10QwcrGWNkA9GMPxmRUOJKA79A/xElJmZsNICLa+V+9mg+qUwdPAJjXRYLLRJSKL5vYSMDaCFsQ6Bfnuw/alKfAKyw/fNKGvuBnmzQaB5sGiGazRbs3WmZQLeodegeABoXbB3KIvWr3slI+x42hnF/+5YekipiniTwVK7YR8yKBo6jIoOZfjJatA0svIegmPAgDloipiRGCgGbjnwvZBgXDJLSJljQst39vHHeo9qT/JAVqdjLX8bkRNfdAlsyFfI5b7Zz/ndnKvgU03t9pE/jWPIwLa3x1zxBhMdGiy7mLSLsaWNvXYYm2s9xHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3io5ULk7CTslPpzZsn1U4nW9/c8SlJ39WvO2KGUoRPs=;
 b=XTjBfSwRAK5M+rCSo6VOcVMJNx97A0PhdHyT5vJG683biBfPBfDuulb16BKGkyaFOL4gL2gC98a77siNVGxqGfloFi9RA6mDKR9kZ157MT9BW3wNt7Kc/U4jGtewXtAS0S/w5dY42/a4eMG2jS0slYLiyC3fabUW8Md5Aer6Yz++Xa/cXHjybrS0FzwHAtSfF4JAJODZhrz9xw2wk9B5pKhKH5VJqlc0IhcgzD2Fwesy4TWmRzbOyjWwGM2N5IMUDYGVsFFc56ARsRQz3vASweZvE/4DwtfdBGfLG0pQQMaXuod9tHXX23Jl6JzTxju+z5JlYEUa+c+uXBsvfDQPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3io5ULk7CTslPpzZsn1U4nW9/c8SlJ39WvO2KGUoRPs=;
 b=EkhPSDQ17wmzJ4h+yP7ibPcESqn0EOWpEYGE1DZNF4lwA/OJ+pCs7NN6nKtZ0r8vGbdSPU7HMnTCK4NMdoVywWZhcjeORkJEc/mCOzft7kyQkmJg6U9eNfo7TfEykVXGRUmWashjCcLTbWbHzhddg9BNqXSCTCoLoM4be9KsHWY=
Received: from CH0PR13CA0043.namprd13.prod.outlook.com (2603:10b6:610:b2::18)
 by DSVPR12MB999262.namprd12.prod.outlook.com (2603:10b6:8:422::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 20:11:11 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::a8) by CH0PR13CA0043.outlook.office365.com
 (2603:10b6:610:b2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:11:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:11:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/31] drm/amdgpu/gmc11: use SDMA for pasid TLB invalidation
Date: Tue, 1 Sep 2026 16:10:31 -0400
Message-ID: <20260901201034.2960437-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DSVPR12MB999262:EE_
X-MS-Office365-Filtering-Correlation-Id: 1370bbeb-bff1-4c00-c832-08df08652a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|56012099006|18002099003|22082099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: dYX0LTWp0MEE7z+3bYBXE1B8NNGUBxhpz6RbvO/JnyrY4d2OmnYcx0VoPjYyKz+fHop0xTDEC0nxzRO/fiUStJK9trOgLkJhYm24Z7ttSF7MWTLmjk+ht2K0smCVb6BEBQk+YOkhqK7G7UulEsqg/VD+VyBmFhyvVKVtYVHHc7iPl6kMQhUX3ymL5HKKyhIG0V6jLGmBygFH9XXY6oBluD65vAMSOaTemUz7GtCovBV7Nvnmi4eSC0QwONjhofQ4G1GUCLw4F2cAyy6JNx3hX3nzqTs/UV4/V5prHA7JCU9uoPzAAX0EBorWpd6SY1H7nwSvGoVoXhKn+HCJtaaYRPCGmo+qIhc7SxOv3NdYad9znEbdRYPD4tEHXLRPF+vk5L27DCvvo7F3oNtjUYYSMGn2Hr6wX9OSA/wdXrWp0lIcNddbd+9J1oUMiq6Dw33ciU9DufvaUDUw3Tv48IWKArh7mAyMfcTbsa1TYqvBmUajPGHv2RRmZEe/uc/ZEH3xlMd98BNkyhwzN0gFGogMwEFQ3KAq0fmBeEmnDVLUYWYdPp2ctid+53I67Sg075iQqijf+E73wlNGGPG6ciR3pESsrMmrw3e1IA93Xn0wLKIl6WQ503Kw+x7us9YPnk2AZ9EtwezJkKu0lX57TT4/MPfU25dzfmzgdn6P/xHtrbyTuIDadlP9eSR2qVDVYsIQ9yt9roiveJROEvGdFWWWzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(56012099006)(18002099003)(22082099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BrlAQJX1Zrw1CGTJcKSBf935Dyo3wDOaoyTraUd4sHWuYrjkwO5DtGPWrNbKhmZU0I6mdCXktHSxtjcv448FCtseYdy2xerihJEFrdFaWYpnyagf8eSxwoOxITyVhE2cQmtKMGr2n8dKUjVYXyt6MjSklLOaCEGcsR18n6AaF6G/h3qCRhH9XqxZbJxJld9T25u/K5CkyL03naRHIKCBlOqpRCEiM4c7pMnGbypL4xWOzLqymOKjwIWF3Qjgw0e1ge/y6QWJa+uVAh+oAIPYYqROsbYKAwlHGbm/67f2P61/ejLoLbYEP2F81rQRHqXTwL2JfcoZN0BSQ+VD1cvrq/CmBVyMEBmPl1BfABgRVvgH6e34pOuRZGOYdI7/67paASIFhLRS/J5Y+E7PurGgMDgavsErPR7M/bK5WOTSuSxZB6Xzwaqx3MWa6fRa4Z8a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:10.2014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1370bbeb-bff1-4c00-c832-08df08652a30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999262
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

Use SDMA rather than MMIO.  The avoids the need to
disallow gfxoff when invalidating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 46e98fe66dd3e..8b95a1281886b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -950,8 +950,7 @@ static int gmc_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
-	if (adev->gmc.flush_pasid_uses_kiq)
-		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
-- 
2.55.0

