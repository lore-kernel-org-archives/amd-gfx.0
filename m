Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E0DC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 07:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A29B10E6AB;
	Thu, 20 Jun 2024 07:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="INHmVX/O";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D121A10E6FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 07:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKdq6fVGNKGAuRHvRpF7oBoHMLQ59PV/DvyJfI0/jgi01T5yP52gz2fi6X8YR8DQv67pr829woICBCcT73+ipfJ0tJghQn8F49z15IBDSBVMZFGZvp3617bcw8WcxOpYwr6fDU7mz5RFVYe06N2bqvCUa7+omoe+KsaMQdBh+1REjp3+N0zFC8/pNEIwl+QjboRGCUw+1EekwZIrbe6FddkTC756wj3TaXy94zEC0oTnFW+Rx9+YzmaYqjT5ktD7PdGr0aY4kC8pYoW1lWnKW1XD/9FHp27tgm/u6m/4H9qc6ufykW3GLnBSoaSkBBpsX6T9v5cfmmI8h5MisY7bzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCeKWaswz360OmFPFx7LZjhDst22hTtG0nV+ZI88pY4=;
 b=cxyJtrz8fmixvnIr4wDBPvavavA4MCjc236RwONvbNxm5TJiQ5+Ve8Ek+T+zSDenyqPjNm8xGAGrPVZx+lydXmastFRtsp7kWNrI4HOmGy2aWCKjwAW/Klxx5z4dNIcUkrSSBOSTiBIc4oHOPHHVr2UHHzCBusECQcmKuGNgm4Xh73GSaIFaEM5bd5nxXYYgtBkdSazqQynEB3UTbFLigM8HDjh+tczi7dI8dPPtAAMpZ3GMNTXCxamzXF1wcb1uszBrtc5kl70jLEnnD1r67qIBvr4CdfLaLeMCwPKPmuVmLMm+TTflVShWlPcjjQ7r4DSTsX4Aa5Zoxcio79XwhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCeKWaswz360OmFPFx7LZjhDst22hTtG0nV+ZI88pY4=;
 b=INHmVX/O6IRZuvtZRPRwC/8LCiRsT0qK0dEgzn0bs1wgrR/DZ46rAziDqFwvdbcLjJ/KNHm87V6VKDzaz12JsofpLwJiL7qniOJMtPM7PZbd9YS9D/aymO4kWKgpLr4rkPKkuNmNL6RHXXsyGnxNpDwW2zkm49qHMDUAjLYwBGA=
Received: from SA1PR05CA0001.namprd05.prod.outlook.com (2603:10b6:806:2d2::6)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Thu, 20 Jun
 2024 07:04:41 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::88) by SA1PR05CA0001.outlook.office365.com
 (2603:10b6:806:2d2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 07:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 07:04:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 02:04:40 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 02:04:38 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Tim.Huang@amd.com>,
 <jesse.zhang@amd.com>, <tao.zhou1@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Bob Zhou
 <bob.zhou@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the null pointer dereference for
 amdgpu_ras_reset_error_status
Date: Thu, 20 Jun 2024 15:04:32 +0800
Message-ID: <20240620070432.8455-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: bb79fca1-9932-4166-6922-08dc90f741ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|36860700010|376011|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0M78ZSEoTtBjiALYHeHSPmchXpwy6jaQQYGtM5bQuS5JYitUWAg6/7qRJZgL?=
 =?us-ascii?Q?QG3oEMDNB7cSV/K2YOGMVnX3IyjJUKTi7dPeHzCZUGMSB1AmLGpS2WuIG9F1?=
 =?us-ascii?Q?qL4Vzez1e7eh+XHGi6hgONRETbxVin0oSwNnH9UXGW2GB8HV9Vx2dL61fvfF?=
 =?us-ascii?Q?ZCIPd6yyDU9Z673nIq9LUKFvnmW/Fz1unQr9H5nY8yIlulgjTEeGn43I+gjU?=
 =?us-ascii?Q?1R/x6mJaFEwHJTNRZwqyibAj+omiVr+H4+o2Bfg6GXYi41tdJ1Ff4HCWT7wP?=
 =?us-ascii?Q?j7CXxn28kKoF8a9cTRyDTYAe5VN72N8sNfAOAEpl5cSLtCeDGWN+x04L1XDO?=
 =?us-ascii?Q?oozJ/hcexPNb6zSjqoS0B368u8+2dGO2dNBKHEaE3Rh/fEWMOPD687Ku3DVS?=
 =?us-ascii?Q?dsCDs8rx7K3l52i3L8jOlmOU9FedRZekFk/NrZ/hvXBNF957wyAhy0WYCNl5?=
 =?us-ascii?Q?uPYfZTezOHPfasmnt2OC81hKiW47agl07/LBwIy9O85DidtAK6p596vCUaRv?=
 =?us-ascii?Q?lzniqeGPVoiSiToihmQWK3DFhoIWzhsZK21pLfl7gPEEyHGb6ym0M5aOp6Mq?=
 =?us-ascii?Q?vkLtcU7+ee+wBt5Y1NXvutlwpvWrZbh92cUZ2rpe9v7/9xL+KUad1OmMWd4e?=
 =?us-ascii?Q?cQoeSSk3/rQC16lg0D+rJpGSFzChaimIloP4gp9NobULaD7kr7+GkdYDx/Fo?=
 =?us-ascii?Q?sxFIaIM77fvXH5F7kp4jDrK1wo/mkWcaj/ENgyfFdEC6udV7ldplu9ZZZozf?=
 =?us-ascii?Q?7+TGB2FckK64hyxzVMEvGUcn3dztmAK63y/+Gum7cNoS6DgJoh8vSek4+ajJ?=
 =?us-ascii?Q?k5GXhO9eSXyeN/Wf2vqOLdIPlmImv1AMguMyJasP/gfVeGbPoXvJhTGrlF8b?=
 =?us-ascii?Q?BLbsTK7YIwhDJNSpv05V4dVJklDjbX6U0Hau5uVHhMxliaNP/k/Yup98gLjl?=
 =?us-ascii?Q?6NP6Zi254G/YRo15BA1uufWe2ooORJ2qnsR6XP/O7NVOCZK0Y2RrFGCIqf+2?=
 =?us-ascii?Q?o/4+3nV2OrAs4sRcERMxzlyrZNjTfL7WU7ej+moQS6nRsml3q59Ort/6bZ59?=
 =?us-ascii?Q?+nWypdMr8SAXkFj/BZfQmEmiBuqPabjZG1GBBwavb97kPwW7cYwWmROnskiJ?=
 =?us-ascii?Q?0qAwYARyiX6ydshTJrdWv8bVrFWXJeM0UoHq2lDLWjwHdRxyWJVogPwuNXoq?=
 =?us-ascii?Q?YZ18Vh64DJ6bIIBOdIm2AwaX5TUE0KYcAT4o1ZIElnZee9fAibsKM3Uk5toB?=
 =?us-ascii?Q?RFF9rvDXWvHxOavKWNYVhCaQrHdrTV88KIY7PitlS1NQ1jWlpWi5++Pd9nyW?=
 =?us-ascii?Q?mMoJuxfbi2m0EpzDzja9QE+KG0I0tSqr/R8lHXZGVNMCyTsYHgiQ/reMqKw2?=
 =?us-ascii?Q?xiXTp1BI6gUTIzC17sDEFKWai+PtyqaUinQqwkS0QGoTjwB7RQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(36860700010)(376011)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 07:04:41.2101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb79fca1-9932-4166-6922-08dc90f741ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
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

Check return value and conduct null pointer handling to avoid null pointer dereference.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 68e9935028db..0ea836b376a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1442,6 +1442,9 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 	if (amdgpu_ras_reset_error_count(adev, block) == -EOPNOTSUPP)
 		return 0;
 
+	if (!block_obj || !block_obj->hw_ops)
+		return -EINVAL;
+
 	if ((block == AMDGPU_RAS_BLOCK__GFX) ||
 	    (block == AMDGPU_RAS_BLOCK__MMHUB)) {
 		if (block_obj->hw_ops->reset_ras_error_status)
-- 
2.34.1

