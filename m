Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868A4CA0EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 04:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E9D10E69E;
	Wed, 13 Aug 2025 04:09:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rpf74eeV";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4B1010E69B
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 04:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgHfQTrisxQzEJAaU0zrVJNkKxXepWjv1isRmg2GmQu8IGjr6m1lxLMchSEcJaJeIrn2hNhPmLbGCrUJKoGl1gkHj05w9erLguuZbmkBMiDrZ9LKHtHN/+BWi2ZXLAnKtvMXxq/CVVxlurv0wn3ux0FklvdR9sT8VeWioRWU9y8C+nzqTzpZ5d4zbkEBVT8dmlz96jcDik4u7AfVEBuGNofuNd5KQaKLiCMX+2XH35EXaUYMa7UBOSK1CMoj1B4I1njQbq7hD110I5bhSdE0OSW3nJLdWhG1SFbbqcLqTwjhR8t3Lq3LRIr8w6lYdg8vPo5gdUUt+h3GYLRnmEUoug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk7kkDA91xTpVozTiIlbuGctQVky4cdwJGPn4EkoR4E=;
 b=TWvHATaa+ymbe1IrEm2pXtD5XnF0W+0bgpWey91KXOX38FicB6n9SnzzlK6ZIj9Uj8NS94JcAmbN7Akzttst3HVN86mCv9Vve11n8u69KjTmP9Qs8p5TYCZoUPcntPbK+aDPUmma6+6IJdx/VGQXK8Ny/ne2YY3KRdGWbL6Y2azLZ8UEj0pObqaaqeB2Mofl0nur3fZr+bvqVM2vzhb5ubXqwgwkhbtJ6x8yaqPp+lCUeKkzVoyeM4jqE3WkDeO/29DWbRSBVLFnrVlh8atCDKqMFQiyL7Dth4faz+AEgvJYoFBzRFO9sEBrl9vAm8d+ATEA/knnkgUI12OKEPGFtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk7kkDA91xTpVozTiIlbuGctQVky4cdwJGPn4EkoR4E=;
 b=rpf74eeVBi63yI9kY7z4yEOiScVNhuxkkAOumAYzYUm8/y+o1PvsLLOGCqFhqRcjzld+Xg/B3MefzJnzBXFjP6mmaCG1zncgj4HPIdqV/BaOkcxpNwAzCkwn6ihe+dq8ymigxINcjmsG7mAmGf4gKLB9CmC+51gMbB2qtVOl5XE=
Received: from CYXP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::14)
 by CH1PPF711010B62.namprd12.prod.outlook.com (2603:10b6:61f:fc00::614) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 04:09:14 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:ee:cafe::ea) by CYXP220CA0011.outlook.office365.com
 (2603:10b6:930:ee::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Wed,
 13 Aug 2025 04:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 04:09:14 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 23:09:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 12 Aug
 2025 21:09:13 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 12 Aug 2025 23:09:07 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v4 3/3] drm/amd/vcn: Add late_init callback for VCN v4.0.3 reset
 handling
Date: Wed, 13 Aug 2025 12:08:06 +0800
Message-ID: <20250813040851.3435890-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813040851.3435890-1-Jesse.Zhang@amd.com>
References: <20250813040851.3435890-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CH1PPF711010B62:EE_
X-MS-Office365-Filtering-Correlation-Id: 75dc7399-6ae9-42fb-eb09-08ddda1f2a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kSYURGek4bR7F8gSxUSqhchYkDvTQ2cO/W/HsfmSVvqqFEDY+AmXZsMB3K6c?=
 =?us-ascii?Q?xjtQ8zCrW1h0+Mvm1WViQz5p79ebbMwWJfAhUeQRII4GgI2lzkKvgKp0zK8g?=
 =?us-ascii?Q?U7wshSbOqD/f+Uk7e7CIjNLSsptZPORWvr2cqC1Sbttrk+RZ9JfxyVKUBGwE?=
 =?us-ascii?Q?WEIaWTFXr5Zx6kjvM1Y8vWmbwm7sl8qUOXDXVckUWrLow4Q0dD+ryEnD3/nX?=
 =?us-ascii?Q?R0FDcLtGrVN5CKvSag2hsFxWt3Sw55T3yf+ZadZU6+GGRIzym8yeWWBqxb5I?=
 =?us-ascii?Q?nnXrpxW+6mBxCQqJ3yom4pGFHBmoolGujQAT6u85lNRy2t8HyuF5iyibxEUp?=
 =?us-ascii?Q?9IosP9FX6DdNq9LxW1AiKEx/c6ktMSn4dMEMpVR69mxOi0ZqNFPj6nKwEaFC?=
 =?us-ascii?Q?r49xcyPD1iik6WB6CXfUe4A1uQKvq6Ai6B8t89oKdRjzTyIaKUFhE6+rXqgk?=
 =?us-ascii?Q?6Whp5R40kKno0AJa8u7FDFLKMEKY8THDIeAHAJfcBu1grSVxNLguFO3F26iP?=
 =?us-ascii?Q?bYXRCVaQHMP/QP2Kqm1mCtZ/zoieU0JImuX2Rx6/bs/jmk09tadippveVRUQ?=
 =?us-ascii?Q?13xeWt4Yd3ujvdW3A0cioy7dLcd4nIryISICsjhkc0PV8P06uY+cATYlAPfY?=
 =?us-ascii?Q?rq3OWvNws/WnWgFDbbNLwwMJbbDfGgXimOM/SRYrWn31TwvBQjGX/gNtMApE?=
 =?us-ascii?Q?//oSGSe0484XTNhsfrmt31NHOE7tSSmYFsn/4dj4L7OGzp1S1ryNaHn0A/7f?=
 =?us-ascii?Q?e0MijAfC6ef+nZWDVIT14HxC2JhP5oFTlz15AMhzl+aByPlXXhin2uKvS+4j?=
 =?us-ascii?Q?pp9ttqony4JuSxSR4UEW0y5MoUt10XC2RPKwve47a2cmFBIBkNflZrK3P8gA?=
 =?us-ascii?Q?7/NiTKUM9sPMjZcBqIOdpL0RmQb97KeqXdaaXTktthc2WhIPXKc/Bjy5erte?=
 =?us-ascii?Q?8hq1B+bvIUJSm1XzYViny47avuK7IsZPJZlMUmUkXFYzgbI3nIo5ZC5naxWb?=
 =?us-ascii?Q?LDXc/a6In2SfHYk2Rgr11pbg6qVrWiwyFGOSvPwR42EqV/XylugXFPlK1qOg?=
 =?us-ascii?Q?d5CKriG/sv+j+Lkz53UOEBNslFHOSAyOWY6hqoRKMKMLaVlJUoHPfcIETA5Q?=
 =?us-ascii?Q?/wG5TjEQpRyfMfV3B0LEjemw7NIyh2raVUNTYh/GoASzxloWgYBasmUQ6zC7?=
 =?us-ascii?Q?Y5YFBJIIrEqmg3jmvDIIM2vFC0d7uozMwxi6rWx2CbhHTWOdGtYNjbnEQ8oq?=
 =?us-ascii?Q?CDy2Y3hoH+hdQvemKdAs5ynO0id3yndGYB4JP90UHz83EAtUmsyrChcyMpBu?=
 =?us-ascii?Q?1sicsyDZEqMUUADtQCFTkiyslSG4BO/YGkIG9O6cTm6YCWRRMTOodVbKK+Xb?=
 =?us-ascii?Q?2l2VK91UaOeDb5++72kXiNROdBz4xw9XOp0k5oXIdSS7IiIx/tugca1z9d5n?=
 =?us-ascii?Q?NI0/8+eqIL5teawg4Mq/k983ENJlZye6Arw3TJD+zD2aufuFh6f5ZMI1cB4Y?=
 =?us-ascii?Q?QzIWFYXZdZM90vUZj3K/qsa3jjB9w8GLewUI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:09:14.7512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dc7399-6ae9-42fb-eb09-08ddda1f2a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF711010B62
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

This change reorganizes VCN reset capability detection by:

1. Moving reset mask configuration from sw_init to new late_init phase
2. Adding vcn_v4_0_3_late_init() to properly check for per-queue reset support
3. Only setting soft full reset mask as fallback when per-queue reset isn't supported
4. Removing TODO comment now that queue reset support is implemented

V2: Removed unrelated changes. Keep amdgpu_get_soft_full_reset_mask in place
    and remove TODO comment. (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 019bd362edb2..03fcd6833c26 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -134,6 +134,16 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (amdgpu_dpm_reset_vcn_is_supported(adev))
+		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
+	return 0;
+}
+
 static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
 {
 	struct amdgpu_vcn4_fw_shared *fw_shared;
@@ -211,7 +221,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
 
@@ -1871,6 +1880,7 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
 static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
 	.name = "vcn_v4_0_3",
 	.early_init = vcn_v4_0_3_early_init,
+	.late_init = vcn_v4_0_3_late_init,
 	.sw_init = vcn_v4_0_3_sw_init,
 	.sw_fini = vcn_v4_0_3_sw_fini,
 	.hw_init = vcn_v4_0_3_hw_init,
-- 
2.49.0

