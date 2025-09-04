Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3F5CA1014
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 03:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E6410E406;
	Thu,  4 Sep 2025 03:13:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pp8uUN+p";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE6810E406
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 03:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRqPjuhJfSm1t3rKUro4Qr/jomzGp0NW5yPZnT15NWjOYXSxO/8o/SnLgiC00sPDTCO+cRSs/xRboxooCuAn0Baa1+voCHECBakXJHdJRBG8QZz5k33yK0eHSpT2WGU/0bfK+9Ri5j47oAdTrgXulmEos/WEy7FpxRRvIeupik0SCZPOaBrwZ8565wr+i3GfNa10ng0+iLZ9FXLix8DDaHEh2o4hmCu/JX4yHqUV8zMgQeojsMRu8pUhv+JM0luLc4+lzDqK4jClZjD5hVPRUterLzVU3z3/RaGAFYOtYbJfkhTER71EzR2GFk8NcNMxboq1/Gt+A1XI3mPUNabTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MA0AaSVdpgrL4NPUrm3IB9OwdC0DI8l7H+v2QItPf/U=;
 b=ZIi1WsLiH2arqKe/hRp3x1rVyRHsQNZSq1bFrWJwTv6aBqEDvpvSaI46skUyvYNOs0xY5Wuj7hmaTHXimd90+5Iuf80gehQxG1sEsmGZriEhDoq1jBI5GrPya8LqmQX5ZSXCxYPAh/n+zRj/tRVa7cEMK1qIecaluLvRoyaTGo9OxlfwYavBic9Zx41cHSCJw3n3FqzZj5Id2l08Ntq1KZLxGIl49iM4zP9Z2/St6GlLgvhftO87FaY+0GvBna7IQExWx7CGVvL3yYrl22qTH0uv9B2ENLpuADBrhcFQFgZTU8RJAVjnQ/4iM6Txho++Dnvo87khycb7tZNHdY1Y2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MA0AaSVdpgrL4NPUrm3IB9OwdC0DI8l7H+v2QItPf/U=;
 b=Pp8uUN+p7mwQJSpD93ec53U6EMiMBlF4ycGZh7rCycFoCo8MMHRJ36Xf1vSpxbjRI85IcgZiYlhv9e278Mc1YJTZKuh5i63EDfXi04fJA0DQlsFjNs/TADXP0Ndxvghch80vZMkabXiZHylmu9cCAgPTr8pSjuoalPxNNhNrkIY=
Received: from CH5P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::18)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Thu, 4 Sep
 2025 03:13:31 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::3d) by CH5P220CA0020.outlook.office365.com
 (2603:10b6:610:1ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 03:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 4 Sep 2025 03:13:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 22:13:30 -0500
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 20:13:29 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH 4/5] drm/amd/pm: unified smu feature cap for sdma reset
Date: Thu, 4 Sep 2025 11:13:08 +0800
Message-ID: <20250904031309.2035678-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904031309.2035678-1-kevinyang.wang@amd.com>
References: <20250904031309.2035678-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f7c9d7-74e8-4f2f-3a1c-08ddeb610697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wXZQtoMWaosvZ8BO608Jtu3em+M4L8NUrrmmut3WDiS8h9EZhsjAVBMgGgMQ?=
 =?us-ascii?Q?YC/Wtqf5LOKkdsxIPsih4ToILwdFHlJBI+2KM5rukgLuAZ3pKBiDj5bTOnhy?=
 =?us-ascii?Q?R+A53MXRjE3PZFBRuIqprIZE9A8n7InILDOghSR2N1WTvCZCcrbEoRKCfjun?=
 =?us-ascii?Q?yFvyOV8n5/+ez4mTyw8pnS9KI3kHt4YROZaoe+SHuHASPP6QLQHRUNkLmS7i?=
 =?us-ascii?Q?No2Z0YEYwpfeJ+coeCIDos2PF8APiU58QtEgIHe6+h9CudRXFZqT5TitbacV?=
 =?us-ascii?Q?tWPQUU4gnXobGT0DgOsL3k52A2I4BW+Oc9LUeqo8Ke0gAU+DMWZckN/kM0BO?=
 =?us-ascii?Q?UtrFkUrAcYl0q0GZpuxJRbEuBcRflRi6tj3Lt3VUq2VRC/47VXU7Y1xqINgq?=
 =?us-ascii?Q?ILUdkuFS/LnSuqAvvl5ssCuy018T01/uuOPQvjCHqJEnLsiSok6XQYLUv1RK?=
 =?us-ascii?Q?30RpdbV9wZrSjcUBl8vFXwUAbv56DMtFu5++PldsBn5S0k92RJqKwepm9sEO?=
 =?us-ascii?Q?E1pDoTDSyxOm/F7qDc6pUGFNXS8eoTGfCOp883O/2bo+MlEEEa7L/hTrgF8R?=
 =?us-ascii?Q?FX9MihcxscL4liLFmeRL7GpckRgf9YtSYRKE8Vl2Ec6/dEvH+0enBIhfZZw8?=
 =?us-ascii?Q?Ug8KGSQyrTVpXE3g2GX/dbotLCZVefPa3odlaUrhZMh6B+BTbv8QDxSBAqt0?=
 =?us-ascii?Q?xWPBYOjVJ5iAKanLGbQwnFcySA4csmDc9F/4gyczlY9c7U7LRZf9WeS8ajTi?=
 =?us-ascii?Q?l3ucbmFeZQKs6p8PXIK4CFIWppPuByEyLfFc1rjYUXJRBlm2pKi7BZAcTu6u?=
 =?us-ascii?Q?kEC6EStxnFZbQTuPfPUz0BzgwOCBsvoC3d3t4OreoJl8LhPu3D/EMe36YQ5j?=
 =?us-ascii?Q?tlFpB76LIEKNG1MFtU7oFZZta2onewaARa7QKtR8hZgVXsQk8Iu3S+XDeOUm?=
 =?us-ascii?Q?fogR2BNAliEQIB4wKMW01eSy7SPg0ddqPGGko1ZimxZNL/gWCk1qUIZotAnR?=
 =?us-ascii?Q?9qFg2zlwjjKgHTP0FBbfVXfcr7JEKPvC83YT7nFypHOHn5UfiUeqSpppsf/n?=
 =?us-ascii?Q?A94u9GkdNLQ0kr2H7/4jUQm7LqqBLa8q3BAom2/MxR0oO63A9Iucx8MV1CmF?=
 =?us-ascii?Q?m4xBQhpMXVmccHzUJu2PUBduIviNnm2yELGHc6YD7F6i6NuL7wvgYZoBaL99?=
 =?us-ascii?Q?qeCbhM3T7QKKGaAxkBaWwuHkldo2luYpbhOrAB//iQOELfNfDrcH5JkQstoF?=
 =?us-ascii?Q?/GAeHKuJ9UcIVBCJiuiFVVCxqf0I+zT8fqKxzk82FqeTKCIKJHjSBE9SDgh0?=
 =?us-ascii?Q?EzZR7pIMQpX4k+LmFHDs7Rn9eJQ6IM1KAa/iLc10Ckl8r8bJJohQZnCt82G1?=
 =?us-ascii?Q?iy+lB4+5OnHdxFSeHSPrZxxqjFbx8tgKmCMnrALcbGi6GShBYsd9V3AZfE0U?=
 =?us-ascii?Q?r0+V7ktaH7xJ5xWMCRaBWqfY0kjbLKewpcG+je6H9U4pCzzFzCix7sN7RGMv?=
 =?us-ascii?Q?BMpV/DLYqIrsWLuhW7vuoyZgsvcBX5rpqahK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 03:13:31.0859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f7c9d7-74e8-4f2f-3a1c-08ddeb610697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
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

unified sdma reset smu feature cap

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 7 +------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h        | 5 +----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 58ba21ad635e..f5db055d96a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -4125,12 +4125,7 @@ int smu_send_rma_reason(struct smu_context *smu)
  */
 bool smu_reset_sdma_is_supported(struct smu_context *smu)
 {
-	bool ret = false;
-
-	if (smu->ppt_funcs && smu->ppt_funcs->reset_sdma_is_supported)
-		ret = smu->ppt_funcs->reset_sdma_is_supported(smu);
-
-	return ret;
+	return smu_feature_cap_test(smu, SMU_FEATURE_CAP_ID__SDMA_RESET);
 }
 
 int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index fb3e0ad41e35..d4ba1f87a0a7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -530,6 +530,7 @@ enum smu_fw_status {
 enum smu_feature_cap_id {
 	SMU_FEATURE_CAP_ID__MODE1_RESET = 0,
 	SMU_FEATURE_CAP_ID__LINK_RESET,
+	SMU_FEATURE_CAP_ID__SDMA_RESET,
 	SMU_FEATURE_CAP_ID__COUNT,
 };
 
@@ -1427,10 +1428,6 @@ struct pptable_funcs {
 	 * @reset_sdma: message SMU to soft reset sdma instance.
 	 */
 	int (*reset_sdma)(struct smu_context *smu, uint32_t inst_mask);
-	/**
-	 * @reset_sdma_is_supported: Check if support resets the SDMA engine.
-	 */
-	bool (*reset_sdma_is_supported)(struct smu_context *smu);
 
 	/**
 	 * @reset_vcn: message SMU to soft reset vcn instance.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c12268ad6289..89360e345c25 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3221,6 +3221,9 @@ static int smu_v13_0_6_post_init(struct smu_context *smu)
 	if (smu_v13_0_6_is_link_reset_supported(smu))
 		smu_feature_cap_set(smu, SMU_FEATURE_CAP_ID__LINK_RESET);
 
+	if (smu_v13_0_6_reset_sdma_is_supported(smu))
+		smu_feature_cap_set(smu, SMU_FEATURE_CAP_ID__SDMA_RESET);
+
 	return 0;
 }
 
@@ -3895,7 +3898,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
 	.send_rma_reason = smu_v13_0_6_send_rma_reason,
 	.reset_sdma = smu_v13_0_6_reset_sdma,
-	.reset_sdma_is_supported = smu_v13_0_6_reset_sdma_is_supported,
 	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
 	.reset_vcn_is_supported = smu_v13_0_6_reset_vcn_is_supported,
 	.post_init = smu_v13_0_6_post_init,
-- 
2.34.1

