Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0716D116EA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Nov 2025 07:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BEEE10E0C5;
	Fri, 28 Nov 2025 07:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gHlCNa3z";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B4810E00C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Nov 2025 07:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mke6YXfKpy22r4nbq2MBnSt0WVgCghCT5RTtc/Aqe3uKBdarmtu6GLBG46wx8zyeHszvSklolK3tbbL5ic+7CUW+cKZ1il233/D3Dpl4swjEl6rWiTrfgDC3WqFISviIfGnlQu1Tb0MtecavLwUxljLkVOWnBCxBq9pfy1WIAAMGa3bKeBBdvNZpg3576YJ/yMZmhpPRBYmbxa/Ex8bsJZAKie9NP1JgF6JAg2Y2jCTJmJ2v12B+HTp50ipVlB8jts4tjj2YlEDOPnUUz0U+yxfjPFoRsa8irqmOwX4c8GNB72I+AifcS1SPkgog8EkGlSvOOZZOQ3IMfve0gtX9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMU1neCyvvxIWiNYCLZZ2Xuq5KwjFHVZ1nj0MH8S0MU=;
 b=uyRMbBdTwZngCxAFa+elWTSP8lXIUGcOMI4xxDBz/dzvMfuLluVQDLRuB6nq97Nvb/q11fgjaJwVxalEb9TbPr8jHTBurGKggFWtz7TRkwSu4J0Ld7OCzqYGI9gL3qpeOg6VLNS2u8kkRm+E1vGGx/K8I2fqIVludmviPy8egF53SjeUunjI6zHItC8tp9YUdcEQ5zZrqtxiJ2vBoegU1bJQRAnzWGGw5rUH5qxpX24SJqnLgX0SdTRDlCxFnbQzos2BHTIlsgalPb84FJYYhtApH7vgzIW7c6M9/08vB8qXP7oA72SWjN3A9tV9zc6iZ6PP69aVSapjgL7afXRTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMU1neCyvvxIWiNYCLZZ2Xuq5KwjFHVZ1nj0MH8S0MU=;
 b=gHlCNa3zGlcZmgCs9GpnO8qq2Sg9U9+X3tZ/lNUXMVPC7CWcEIfsCz+l2RpyKrWAAl1faSvBbmjX6GwuRiOGLI58XIVkxd0FfGy5uqZYF5o9QsmGItmSm2irHegOVi+bg4gMLfmIvUV4VBPoPFXFxwP5xJ9uBRj0HE42qWfhQRM=
Received: from SJ0PR05CA0077.namprd05.prod.outlook.com (2603:10b6:a03:332::22)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 07:38:01 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::8a) by SJ0PR05CA0077.outlook.office365.com
 (2603:10b6:a03:332::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.3 via Frontend Transport; Fri,
 28 Nov 2025 07:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 07:38:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 28 Nov
 2025 01:37:58 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amdgpu: Make pre_asic_init optional
Date: Fri, 28 Nov 2025 13:06:54 +0530
Message-ID: <20251128073733.3606297-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ce0d2f-1dd6-45fd-2f0c-08de2e510e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?srLL6kvmjPBKVq3g0fuTeonQSKP9PEDnV2HQ3eEb9kfxZQEWQFX6iAgsFZzL?=
 =?us-ascii?Q?7S3pgfZLjnFGWvWoH2Pn2UBMDjM3w8iFxkDgdryVqsvyJjwrZAhrsI48WUXM?=
 =?us-ascii?Q?foRiOeSCFnVjd2y8QiCWQue9wqThzE9kxGBloOlPWZiXl/T1EoXI9ip4nTC+?=
 =?us-ascii?Q?cJ/pbSvA3ugU7k19VHM037J4b31YiWYxhlFLWQzvYPWxzPccoZKiZVy7PjzC?=
 =?us-ascii?Q?innnced7SZjxzY9VK8Bvct91En3GtQw9BQahqHrsJFLpzo6Uqmwk6XMmaZ+d?=
 =?us-ascii?Q?kNmpwN2SvIv9ssgcQw0vMB/PZELCf0rfmGnnEyUs8DcG0xsOLarrc7cuc9l4?=
 =?us-ascii?Q?umXSYbX+X0/a2MNhSJp4+OnUwP3AbT++vDnvGwn80Uo0xpfIh+FwbxwLms+e?=
 =?us-ascii?Q?9zaTAY2Y9vej4IvjSeV2nLmEC2ACGFQ22q4CL85LBbsnyh9hk16ypiCGAQT9?=
 =?us-ascii?Q?WFCjvO2x96yklivlnmwWyEcQCiI6ieWXrpkOJHVU6pcWS+/t4Dqk9F1pvxJa?=
 =?us-ascii?Q?5yXyUcF3a5yUjo1ihElooTDpgtu/aP9JwwX9JkSHRwmf7kIhk/aD4nvt8Olo?=
 =?us-ascii?Q?h6m5faVz4SlPitQAXGSYj7Tbp0hqh1IsINNPR0Dc2PypoGkmvTtUa9V8lkxA?=
 =?us-ascii?Q?r/GO9OkAp4tfCVs3uKtbxjSss4cHCPCMRr2crGqtRoPnHR0jTcSTi4zYo3Vz?=
 =?us-ascii?Q?1tYCTiuNBkkeZ0e+FbIVKzMLCDroERI5YzpM/epwh8jEYgHIbGuGItBmNfgi?=
 =?us-ascii?Q?rIEeFf6UHhrMf1ujTa4094OhrLw+gg9SwRQnBIZ7oAITGSpobC7DsMS2+++P?=
 =?us-ascii?Q?hhirUIpCO2UBqp5nhykcY2itaSQi/l68UqJ1caNdJhLJKsOi7z0ae1n4IcI5?=
 =?us-ascii?Q?5rexAo4gSBnL5PylGzk5lZU50qERAki8mivh3LKG04ngaMd5x4QDa1o2i73b?=
 =?us-ascii?Q?bqPNQJF0Uss4euMdRQ5VIQ5aqSVFdZRbebk/ukYrHenYFPyORCJl1hqiPEVK?=
 =?us-ascii?Q?GzjHSWIxbmKsW+I6yC3CudnI+vFa0PEhEXTGs0JBxvV+QKBGer/JLHGSXRLk?=
 =?us-ascii?Q?86ukbqF280YkyoKN09Ph1pZZKZ1o237z+FAF3GhdoaMS9Y9yu89fxnbYi5c1?=
 =?us-ascii?Q?c+RW6X1UEKOdZGd65XV4+eYno/y2KyXMud+fkgbyaCIS46SZzZZuIzmCMHtK?=
 =?us-ascii?Q?RKzlnBlxU6D0+QTy4yV1c3nAaotppsDwvlhiKJJ9DWLu/SNVPKQxoI7pVNF+?=
 =?us-ascii?Q?5ez9h9fNKni4u5VWOmESkD4Hb/bdrqJgoyrx0KvA9i4Ahz5K9Cnia8NHmqmP?=
 =?us-ascii?Q?MiG2/GKzqM5rdo5GOhyxcaKqnepzNSEg7xjkIWKQBLgAnpDSfN2WM6kICaKv?=
 =?us-ascii?Q?YLoP6qNGasbVM8Fqsp1i2Vs4dUkw8hcR5seCmgx+1zf9H2sxP7dcqJD3wwUP?=
 =?us-ascii?Q?fjVNeRJSaWX3ussqrmsmoyQ5fd8QUs/IKTUMIBQbJ22EE/d4yGjHR16R7ARW?=
 =?us-ascii?Q?cU9dRidhK+0GwVHFaO1gdaGmdNT4jgTUa/jbPpPqk2x5cm38EPAO4WhUeKBj?=
 =?us-ascii?Q?hCvukVbUEytmUiBqClc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 07:38:00.3324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ce0d2f-1dd6-45fd-2f0c-08de2e510e8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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

pre_asic_init is not required for all SOCs. Make it optional and remove
empty implementations.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: pre_asic_init returns void, no need to use ternary operator

 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/cik.c    | 5 -----
 drivers/gpu/drm/amd/amdgpu/nv.c     | 5 -----
 drivers/gpu/drm/amd/amdgpu/si.c     | 5 -----
 drivers/gpu/drm/amd/amdgpu/soc15.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/soc21.c  | 5 -----
 drivers/gpu/drm/amd/amdgpu/soc24.c  | 5 -----
 drivers/gpu/drm/amd/amdgpu/vi.c     | 5 -----
 8 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 790e84fec949..fa71df36f4b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1549,7 +1549,11 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_pcie_replay_count((adev)))
 #define amdgpu_asic_supports_baco(adev) \
     ((adev)->asic_funcs->supports_baco ? (adev)->asic_funcs->supports_baco((adev)) : 0)
-#define amdgpu_asic_pre_asic_init(adev) (adev)->asic_funcs->pre_asic_init((adev))
+#define amdgpu_asic_pre_asic_init(adev)                                      \
+	{                                                                    \
+		if ((adev)->asic_funcs && (adev)->asic_funcs->pre_asic_init) \
+			(adev)->asic_funcs->pre_asic_init((adev));           \
+	}
 #define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
 	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
 #define amdgpu_asic_query_video_codecs(adev, e, c) (adev)->asic_funcs->query_video_codecs((adev), (e), (c))
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 9cd63b4177bf..fc0d2524b16f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1957,10 +1957,6 @@ static uint64_t cik_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
-static void cik_pre_asic_init(struct amdgpu_device *adev)
-{
-}
-
 static const struct amdgpu_asic_funcs cik_asic_funcs =
 {
 	.read_disabled_bios = &cik_read_disabled_bios,
@@ -1981,7 +1977,6 @@ static const struct amdgpu_asic_funcs cik_asic_funcs =
 	.need_reset_on_init = &cik_need_reset_on_init,
 	.get_pcie_replay_count = &cik_get_pcie_replay_count,
 	.supports_baco = &cik_asic_supports_baco,
-	.pre_asic_init = &cik_pre_asic_init,
 	.query_video_codecs = &cik_query_video_codecs,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 50e77d9b30af..f17c3839aea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -593,10 +593,6 @@ static void nv_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.sdma_doorbell_range = 20;
 }
 
-static void nv_pre_asic_init(struct amdgpu_device *adev)
-{
-}
-
 static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
 				       bool enter)
 {
@@ -630,7 +626,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs = {
 	.need_reset_on_init = &nv_need_reset_on_init,
 	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
-	.pre_asic_init = &nv_pre_asic_init,
 	.update_umd_stable_pstate = &nv_update_umd_stable_pstate,
 	.query_video_codecs = &nv_query_video_codecs,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index f7288372ee61..70e9ba9d927c 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2003,10 +2003,6 @@ static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 	return 0;
 }
 
-static void si_pre_asic_init(struct amdgpu_device *adev)
-{
-}
-
 static const struct amdgpu_asic_funcs si_asic_funcs =
 {
 	.read_disabled_bios = &si_read_disabled_bios,
@@ -2028,7 +2024,6 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
 	.need_reset_on_init = &si_need_reset_on_init,
 	.get_pcie_replay_count = &si_get_pcie_replay_count,
 	.supports_baco = &si_asic_supports_baco,
-	.pre_asic_init = &si_pre_asic_init,
 	.query_video_codecs = &si_query_video_codecs,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 42f5d9c0e3af..54b14751fd7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -951,7 +951,6 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.need_reset_on_init = &soc15_need_reset_on_init,
 	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
-	.pre_asic_init = &soc15_pre_asic_init,
 	.query_video_codecs = &soc15_query_video_codecs,
 	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
 	.get_reg_state = &aqua_vanjaram_get_reg_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index ad36c96478a8..55c3781fc730 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -513,10 +513,6 @@ static void soc21_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.sdma_doorbell_range = 20;
 }
 
-static void soc21_pre_asic_init(struct amdgpu_device *adev)
-{
-}
-
 static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,
 					  bool enter)
 {
@@ -546,7 +542,6 @@ static const struct amdgpu_asic_funcs soc21_asic_funcs = {
 	.need_reset_on_init = &soc21_need_reset_on_init,
 	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
-	.pre_asic_init = &soc21_pre_asic_init,
 	.query_video_codecs = &soc21_query_video_codecs,
 	.update_umd_stable_pstate = &soc21_update_umd_stable_pstate,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 972b449ab89f..ecb6c3fcfbd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -327,10 +327,6 @@ static void soc24_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.sdma_doorbell_range = 20;
 }
 
-static void soc24_pre_asic_init(struct amdgpu_device *adev)
-{
-}
-
 static int soc24_update_umd_stable_pstate(struct amdgpu_device *adev,
 					  bool enter)
 {
@@ -357,7 +353,6 @@ static const struct amdgpu_asic_funcs soc24_asic_funcs = {
 	.need_reset_on_init = &soc24_need_reset_on_init,
 	.get_pcie_replay_count = &soc24_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
-	.pre_asic_init = &soc24_pre_asic_init,
 	.query_video_codecs = &soc24_query_video_codecs,
 	.update_umd_stable_pstate = &soc24_update_umd_stable_pstate,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a611a7345125..6a574b6c8e63 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1424,10 +1424,6 @@ static bool vi_need_reset_on_init(struct amdgpu_device *adev)
 	return false;
 }
 
-static void vi_pre_asic_init(struct amdgpu_device *adev)
-{
-}
-
 static const struct amdgpu_asic_funcs vi_asic_funcs =
 {
 	.read_disabled_bios = &vi_read_disabled_bios,
@@ -1447,7 +1443,6 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
 	.need_reset_on_init = &vi_need_reset_on_init,
 	.get_pcie_replay_count = &vi_get_pcie_replay_count,
 	.supports_baco = &vi_asic_supports_baco,
-	.pre_asic_init = &vi_pre_asic_init,
 	.query_video_codecs = &vi_query_video_codecs,
 };
 
-- 
2.49.0

