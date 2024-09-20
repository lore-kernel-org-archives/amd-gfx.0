Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220BFCF9C68
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 21:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CACC10E302;
	Fri, 20 Sep 2024 21:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ep9EKKI";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD3710E302
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 21:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFnXkRm156UBwELT9I+vlPF1qGzsWTx21CTeWBk1mRWolh5F8zhuYQyw56Cn2LuKp0G+vfwwAFWepCg1PbyW8g4H/fZ4saJenQKPvrhwZ3Xc2mBVcCIaPYniAUBz6YcH/ggHrrusZBB/zKAR+JwaQa1OqWBin0kGPnRrGmYYeH4yJqYh2P+yXMFPuIDP1c/2GjoW5YQqjkcIWfGVxUOblGjd/UKKJRI9SvxnTvU2fIg2ejiuFZ1h0tzcL7J864E0cM2LWdf8kS+GhJ2il4xrIfZf4hoFSqiLT6LOyGJJzMnBPZeO4qM2Pj+++cuOPb/hE2ZCzNvs+zkqZi4a5BEZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11YkEorj1TAmXSJM4Srv2lEAjuhE+/Ljb15tevoMv/k=;
 b=q0O+siapaBOF1e9uz2HgQTrG6ib/MJ+6oq8kLBpv2+2tHBtWWPZB5OJbCeGEyHaVxtCtktpm/7L9rVdDP7FhwMfxRVds7fTTXQgoVTL28xHtk5BAZVwKlbMycryBxeRc70H7FDO/CkGCDfJRfG5d1FdfYfIhbyNb8XB2qYWHlh+F1/Zq/wMkPD0m2D6hqLx3ARg1LTr8HHVFyJizy5e2R49OQm2MVfU2uvrV42+1itkpjhflr95/eiKluYbWtCKDg51ig7j0SBtuJSa900OkRiEiEDVBfN2bpQXEaGQ5beAKydExA4N5rHWViboeeFssoHu0UaE97Ji+pPj1DCu90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11YkEorj1TAmXSJM4Srv2lEAjuhE+/Ljb15tevoMv/k=;
 b=4ep9EKKIRXcmCIN9KxCkTWexhDbkXUnQFwF0tvSUrKC7HYhK/hFw52h8qdMTTTKdoNyqbAMO47RoV/uPfiIEgyegg+rRPblBQvrwspQg7DCGdnqvbqZbD/SRtQkZVrK62PX+lp9LUfmXBQTt22ZLh9mTmsHuOS9H4q9UWcbm37Y=
Received: from BY5PR17CA0053.namprd17.prod.outlook.com (2603:10b6:a03:167::30)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 21:07:34 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::ea) by BY5PR17CA0053.outlook.office365.com
 (2603:10b6:a03:167::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25 via Frontend
 Transport; Fri, 20 Sep 2024 21:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 21:07:34 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Sep
 2024 16:07:32 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Fix CU occupancy for GFX 9.4.3
Date: Fri, 20 Sep 2024 17:07:15 -0400
Message-ID: <20240920210715.64118-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240920210715.64118-1-mukul.joshi@amd.com>
References: <20240920210715.64118-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f45de16-e77c-4e30-cc63-08dcd9b83fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4iCylpQVHo9qlonk03bVdhFYyxePk+8ltpuBD78zl9daonBNr3GPtfz85JXk?=
 =?us-ascii?Q?zrZ2SWSDEKrhsZN6ihplVMspvHuedH5uhEiOVhRsxNZAS6q7bbd9g5v8m4Ds?=
 =?us-ascii?Q?kjMtMpySKHccs7zDfV2DRZeuH5dT60fXNlDE2XWfnqbf9xSjTer5kNComC+G?=
 =?us-ascii?Q?13i9IjcX6aFgpBmeLQ7rfp9zCqUDai8crCADYoqsCmlc52QX6FfFYSkTsLVC?=
 =?us-ascii?Q?wmuA3KT3PBnHE3byfNy1BkgpvGMMptwZtqKE1xStdbEC/59ouu8NKdKZ8Sax?=
 =?us-ascii?Q?A/b3A/4/uBQjL/9wETBxfD8Ob/rZk7ttgKsnAov4PQ9AjOS7cx6KrRzZ356H?=
 =?us-ascii?Q?nclfbISfjH1p5kh4q0klSiHOfGAvjKquu9Q5jRRtUCsZMFkSbYCyMu+62sTJ?=
 =?us-ascii?Q?XJCk3YcdGL3HeWH4qwYONfvYj5C3UEiO8OusnwSRoCntWjSiVMAyTuXIvOcB?=
 =?us-ascii?Q?fz0YNg1sCIcK/irRqtnbDjvVKNW2pfKxieZI1ESBy5ncXL4PZLmhWJo48A9Z?=
 =?us-ascii?Q?4j5SAJ2sP21Z/0tvcki5MipjDBMwQpOC9OwhHw/dA4PzqxxRov2cEk9rh3E3?=
 =?us-ascii?Q?iuPiVQLYAdVPZVX+yjsfxx1rCOytsjTuzlwFajqQdBBn5Lb3ABdzlPeHcR4v?=
 =?us-ascii?Q?6x6889T4OV3SWxSimq7amACS6oO2/U4mqqdRwu6B+i5PQd9oZH2Pzirea8iJ?=
 =?us-ascii?Q?ZiwVIBMXvvbfu9eX5PPzcUm/6XEHC3m0yyrMMm9uxQz/ERA4uKeJ8fXj24tr?=
 =?us-ascii?Q?dNA8qKtKlE9vUkUUVw1rnJed720BZQGf0q+aq+WdD7HcSTjWpTsx7ScPfS5f?=
 =?us-ascii?Q?LA99BLeSsJEz0WDbQJA1YXMfvOh1IcolzRxWwz752HqjICNlNaETtSGzMRO0?=
 =?us-ascii?Q?JFGFGYwj4073wB/gK6hZHGAifwrcjWWS2KXNAyEKIIzwFSxS0HyY5All5CNc?=
 =?us-ascii?Q?sC7F222bLwbM56sL5g+5xBLIwUQNKnpUnIAYDW12qGgjxLLAhTi5+SApCqcl?=
 =?us-ascii?Q?4D8WGqPiG8JjgmJY5Qlwpf3VNOUEGT0ST+G3sOc0LaC5qae+uZahF9XCHE/W?=
 =?us-ascii?Q?xftwBViXfhTkFvKVq2kT3HvmdosysjxABsobR4gCrCp+fMTQYvk2Nao1AUOr?=
 =?us-ascii?Q?XtqKe0ay68POtYDObD9DM5GZM0oEfEL9kqqSEUu/NiSet+qJt0H8cCTwo9i+?=
 =?us-ascii?Q?KDCS7SHl/9OeU05mV3mjlpKuhk/oxzAwvGjuOq5E7L/bx06Eq4lMtbO62h+m?=
 =?us-ascii?Q?VR/iho1R53PBw75X1HZBOsFtSvpTYofJ20lyaQUAuhIR/mwCy7PQ/yruWG5x?=
 =?us-ascii?Q?+Ij8/CxpvZ0iocS6+2XjnI2u/UB4ahBVRWD+B9Axdp/gwZKN/Bsok44X/WRa?=
 =?us-ascii?Q?ln6wCcWf8HupdALRDJEmOiq3Hx/R/DSZ16gR/ohSgM+gMZrjfqxAyr9Qeqxk?=
 =?us-ascii?Q?ovZOtp/LjXL28ZTOGbxiG/ijtiueYRJP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 21:07:34.5095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f45de16-e77c-4e30-cc63-08dcd9b83fc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662
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

Make CU occupancy calculations work on GFX 9.4.3 by
updating the logic to handle multiple XCCs correctly.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Break into 2 patches, one for the generic change
  and the other for GFX v9.4.3.
- Incorporate Harish's comments.

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 12 ++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c          | 10 +++++++++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index fe8a8e7e9a9a..e6bc808d9c59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -963,14 +963,14 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
 	 */
 	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
 	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
-	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, inst);
-	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst,
+	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, GET_INST(GC, inst));
+	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 				  mmSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot);
 	wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
 	if (wave_cnt != 0) {
 		queue_cnt->wave_cnt += wave_cnt;
 		queue_cnt->doorbell_off =
-			(RREG32_SOC15(GC, inst, mmCP_HQD_PQ_DOORBELL_CONTROL) &
+			(RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_DOORBELL_CONTROL) &
 			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
 			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
 	}
@@ -1034,7 +1034,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
 	DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
 
 	lock_spi_csq_mutexes(adev);
-	soc15_grbm_select(adev, 1, 0, 0, 0, inst);
+	soc15_grbm_select(adev, 1, 0, 0, 0, GET_INST(GC, inst));
 
 	/*
 	 * Iterate through the shader engines and arrays of the device
@@ -1047,7 +1047,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
 	se_cnt = adev->gfx.config.max_shader_engines;
 	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
 		amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
-		queue_map = RREG32_SOC15(GC, inst, mmSPI_CSQ_WF_ACTIVE_STATUS);
+		queue_map = RREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_CSQ_WF_ACTIVE_STATUS);
 
 		/*
 		 * Assumption: queue map encodes following schema: four
@@ -1072,7 +1072,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
 	}
 
 	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, inst);
-	soc15_grbm_select(adev, 0, 0, 0, 0, inst);
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, inst));
 	unlock_spi_csq_mutexes(adev);
 
 	/* Update the output parameters and return */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d73841268c9b..831e0e92bd23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -292,8 +292,13 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	wave_cnt = 0;
 	max_waves_per_cu = 0;
 
+	/*
+	 * For GFX9.4.3, fetch the CU occupancy from the first XCC in the partition.
+	 * Later we multiply the wave count by number of XCCs in the partition to get
+	 * the total wave counts across all XCCs in the partition.
+	 */
 	dev->kfd2kgd->get_cu_occupancy(dev->adev, cu_occupancy,
-			&max_waves_per_cu, 0);
+			&max_waves_per_cu, ffs(dev->xcc_mask) - 1);
 
 	for (i = 0; i < AMDGPU_MAX_QUEUES; i++) {
 		if (cu_occupancy[i].wave_cnt != 0 &&
@@ -302,6 +307,9 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 			wave_cnt += cu_occupancy[i].wave_cnt;
 	}
 
+	/* Update wave_cnt for the number of XCCs in the partition */
+	wave_cnt *= NUM_XCC(dev->xcc_mask);
+
 	/* Translate wave count to number of compute units */
 	cu_cnt = (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
 	return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
-- 
2.35.1

