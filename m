Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D0DC021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 19:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD31110E4D6;
	Mon, 24 Feb 2025 19:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P/ZX9t+e";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F43D10E4D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 19:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw5o2TwbsiPelCSxRVHhHD1FCXidtCOGO9AYBX8RdbIAk05sHvqoLFkVKK9YVnH1qU5vpE6MJbWVihB0agztalveCzeKra9CTyEHft7VfJCzD+1qnknVHcYqWTpSaV2Gw5ZVphp/HYP1IqtdYMWJWCXzz295AYM4F2xDG/Pqrdy8Teor2kAOR5yjH2Db8LOT5E24XMkDS3ullXiiiqarWM0fUgQx8uCywfxZ1yQMZdStoOX69PClyh/9Qgkdw7XJqaK/BRUE6op0mq+8NSYD9Ij/XcilMDMA3hZx9CthC+48Pub0pxJLMLmcRh+Ev/t3iTUuGMoxYbbOClTckC/VTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTbMozK2MaMSJWn5yP8v+8D2dLcYR7dGGPVwpYWXVm8=;
 b=ZxCMoEFg+/5z+J8R49E5jZEExwRbJu+VViAytmQ15tNfGW211kAbS/6/7p9AiTprpuhon9vMMjRbKd7ClRpziGxGZ/f8yWI+nivs3g21Ig/fwzlNxo+QFv00Q4wOBAvkCyXp3VSrkU5BTSAZVpl2dibN6t1/nIjDy2/Dtkh1UdGLNYJxL8DKDX6+5jxSwirryR3nlnSUZePIPtHUsn398JGju3pzzSHQZXlP7kNFAfnj7h+7iDY48iDJFRghZOATXDt5v8X1uBNLmtDmtW0H7RVKA71yfH9qQ566rbUkyiTC2XB4AELHV5avkE8DQ0u7HUwaghOY/FKcuhBqcR5Lgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTbMozK2MaMSJWn5yP8v+8D2dLcYR7dGGPVwpYWXVm8=;
 b=P/ZX9t+eVqGRke56a2EW+X/1FWTy5UekwEDgblcqx8TlHsXUajtdt9G+8jrK+XggJF3x8pdjb7mkWAj/xVDjfYC0vmfEZuAw4zUIyHB8OvUF9CKCvk/qqk1n2EoaCxUtESgurXEwnhsFmyHY5E2Yzn8Wxu2w/InXAhc+BNTOItY=
Received: from PH7P220CA0091.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::10)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 19:01:29 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::a) by PH7P220CA0091.outlook.office365.com
 (2603:10b6:510:32d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 19:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 19:01:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 13:01:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Boyuan Zhang
 <boyuan.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/vcn2.5: fix VCN stop logic
Date: Mon, 24 Feb 2025 14:01:10 -0500
Message-ID: <20250224190110.645062-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: fd892285-af4c-4a6d-526c-08dd5505a499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jsdMSpsl3JEcuPRYqvEmc8VaSiWkLPxRocAZHeWVbnywFljRolr7SqgoL0fA?=
 =?us-ascii?Q?nmYCGVey9dqvPWn92RLOoEc3oCM7PBgRHvz0YykaIUfwTqjVQ2Naj8HxBmR9?=
 =?us-ascii?Q?PBd+FpOffXooIT//E/SaYbcbO5BcGPFF3OaFdG8vC6g43ffJLjo7CuvUuGMA?=
 =?us-ascii?Q?Etj+9+9BWoDrUcOYbBzPL6H3AsZkHITRE4T5V2mU+lVgDuUFOnA859h70yQH?=
 =?us-ascii?Q?5LQ+A1bmAyviA7eefGMl/Vye8A7b2BTwmPMykmxQKDIgvtlMJrqxl2Si8Xfn?=
 =?us-ascii?Q?5p3kaoU7m55yhHupy9eY+7hzQ5LhIXFH/TJ34OG2KiBdhzQL5SRv+kxh+h+Z?=
 =?us-ascii?Q?oTDivJFtz8mq/YaYDnEMSaXtuSaZAz5txUIlBVqEUxiIevz0Jc/FwwbSkVEB?=
 =?us-ascii?Q?RsFKZU2O7iQA6AVqM2I37f2FhC431YXwBodOhS+EjY0dvdP4/QC6761JIR8+?=
 =?us-ascii?Q?0iTBRp1xM3u28hA6+T9PphB9GoYG/gDAOOIIcQyKcYN6oS4Xiy0DqpRNsE3E?=
 =?us-ascii?Q?WOeK1Qipv627cTkZe+jl0V4tg9BMdvLEwF3cktp+2t1mGBqlM1bvbopZgQhT?=
 =?us-ascii?Q?W8i71LL0UokYfd2rOb77epdmUHNFxm9PQ8+9OkT0gJxNSWHR+k6zPmC6Nux1?=
 =?us-ascii?Q?NoYJklOM4iaufHw0UXD+Jb1Tz3zaSx//xuf679+wdN/dHobYNczvMyJHJ0je?=
 =?us-ascii?Q?PheCbJL+qUZwJTVckT+bEPtRYU81Fdmo7IlbB/XF76YZJfWGJTsXzYVLMIna?=
 =?us-ascii?Q?N29/vwfXfORKs+NyQie95d27vqsZxMKDgkPI++8uJjwM5yAtGHbZmGPbVpaj?=
 =?us-ascii?Q?Ai1qsF83TM5MMkkFnroV91GhghHSHCCa1ot320hei2UPEOZ2sIwE3tosLfFt?=
 =?us-ascii?Q?QgFQNXMSxGVD6DJxpjzFHRF9/7AXo3UEo6vh0Rjmx+rJdDd/3crk/j0FyHN7?=
 =?us-ascii?Q?V/LtYuamgjj2ZBQhGeWaMBcrXqG9rkLn6YNkTeqxvz+GmZ72kpw9e4PoqNq9?=
 =?us-ascii?Q?SUPa49MytW8/8unYHUv+47qZIivcWUi+XfiOiA+9GFeCV6fs5ojI0Y3LTq5J?=
 =?us-ascii?Q?QOCwdmobceUV8TcEsrLGd/KiM8WvEipBTS0rM943gSV1aO7g2e5vtok17jGl?=
 =?us-ascii?Q?4qkx6X6QY/RFn3s+GuZXi9gvn4xxkQaYGrHvL2fdGA2o8ZazwsK+HN7SmgGn?=
 =?us-ascii?Q?JG1IlPURbOG7rWfeGwQ7LnAwGj9TYNeGIu2Vcn6JplBlzHtjKrkR08Tv3+HD?=
 =?us-ascii?Q?OJCQU1LDDniyhxuKL22SDa0AF1FO70BR246B+9pOnnDGJVIQ7tZXi7xWtsEJ?=
 =?us-ascii?Q?dj04zhc0vSnQ3vL624L7AlgvQnqncTZP+5+2hwBdnAZIKrQu0kMwHr06ZEfm?=
 =?us-ascii?Q?nhP8e/nm0h6kduF3/bkntMuANxDbmYCC9bS7IPVjBYkpTAf93getEMqV+N2L?=
 =?us-ascii?Q?cMVVUf3Hx7VuTF+B8HT4pYWerpO3GfUm86G2zQfEywlRYKwn0vWUZLKykEBi?=
 =?us-ascii?Q?ozoRArGTD/YssAY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:01:28.0249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd892285-af4c-4a6d-526c-08dd5505a499
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
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

Need to make sure we call amdgpu_dpm_enable_vcn()
in vcn_v2_5_stop() at the end if there are errors
or DPG is enabled.

Fixes: ebc25499de12 ("drm/amdgpu/vcn2.5: split code along instances")
Suggested-by: Boyuan Zhang <boyuan.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index a6726afcf89cb..e36e2a5676df9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1414,13 +1414,15 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
 
 	if (adev->vcn.harvest_config & (1 << i))
 		return 0;
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v2_5_stop_dpg_mode(adev, i);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		r = vcn_v2_5_stop_dpg_mode(adev, i);
+		goto done;
+	}
 
 	/* wait for vcn idle */
 	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
 	if (r)
-		return r;
+		goto done;
 
 	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
 		UVD_LMI_STATUS__READ_CLEAN_MASK |
@@ -1428,7 +1430,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
 		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
 	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
 	if (r)
-		return r;
+		goto done;
 
 	/* block LMI UMC channel */
 	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
@@ -1439,7 +1441,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
 		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
 	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
 	if (r)
-		return r;
+		goto done;
 
 	/* block VCPU register access */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
@@ -1465,10 +1467,11 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
 		 UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
 		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
+done:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
 
-	return 0;
+	return r;
 }
 
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
-- 
2.48.1

