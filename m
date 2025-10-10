Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A637CCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 21:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D8210EC83;
	Fri, 10 Oct 2025 21:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DvhExM6X";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6B810E188
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 21:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0zlEkiwkRwgNBL4r5xGfvuYMofg4VcbCZVB14DMxzIIyMU9sjWkMSDtfw9ciX/lZPIkEAfR1lZp90/0JXLfvEv9xw804n78YJDs2Oh7KpWRobcYtJ0lg+eZfhU/qyFA6hSVz2X2YmyPUdjJVhcF1CpB0/ptY1OsOmFAaYW4lzgr+zJJgueXj0hVMEZL8ya6GT9qEZIZh76Atq2FFBpvUsTYxr3baGYRaiCnZSDEiySIsYO2L0y9aLVMWG5wlfp8/YDqx1GMAxFrdI+ePpfV9iu8eWIaKWbJkGrgowOGtpVGEMKvkehrvdvD1EMV0BPVDqFAyCP6TL8CBP8xdjuaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZVcmoD5n/r2Dm2FyNp9vt90YWGx1SMtWSGt8TmAWLs=;
 b=EzHTah/bDEEWxYe3QIgFM05U8hVFYBkVBV9QPfM5r5X+YywuvA00nshwquVKIyNVfFL/MgnI7AbvDgm/iv+iFFcIyQzlwE1j3K1Ag75IWpkiuKP4PAoThbXI9fiqL6ZSXhuqc4B2c26TRj11rVjNeEHOaNWIjA3OJwqc1h8qeRKd29uc8TnkdE9eIgMCSRiNG2tlXmtJt3EX/UqN5r0Qsm7DjiniqqUGdTQZyRUlU/kQ9/TYL+iVlfAhaFCiCS5QJX2GNzW6iV8+Ju8/SMoNW/MU33niixT11wV3dKYbQUXE7RnTQeBmo5AGfvOxWetxbo2uekMCR+mJdlaxvm/KDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZVcmoD5n/r2Dm2FyNp9vt90YWGx1SMtWSGt8TmAWLs=;
 b=DvhExM6Xtr7yek5p846W7WzpogStsajS98M7SLaCQYVin7cv28JtluNF5liNYLHj/GhqqgixY8GUOJ5sX/7DTdJsAAHcssiPBU53ORWswMozR+LHgRMPPMnUz2KoR4Cks4qFwJmCvUGwBpb1ab9Ik+u7n6uYtt1PYllrCEtMuSk=
Received: from BN9P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::29)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 21:15:39 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::3a) by BN9P223CA0024.outlook.office365.com
 (2603:10b6:408:10b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Fri,
 10 Oct 2025 21:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 21:15:39 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 14:15:35 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amdgpu/userq: fix SDMA and compute validation
Date: Fri, 10 Oct 2025 17:15:05 -0400
Message-ID: <20251010211510.1528572-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010211510.1528572-1-alexander.deucher@amd.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: c76d100d-b8b3-46ad-62ac-08de0842299f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xlQ5fUFb1apTqRRyUFNCUgjVFps1Cz/G6U6TepkneGKXIBLon632//H+H6M2?=
 =?us-ascii?Q?Y1aqXCLP9k8nWxrwPt7hIO4x7uj/3FnOj+PIUuqMHCwUSEiftfZ3NkvqLN6u?=
 =?us-ascii?Q?vND97plOWqr/tcMkTct//vPea5//1lmRIkEyfQ/PhKgUx6SDpkvl2WCLq8Hl?=
 =?us-ascii?Q?qZWqnIrTW1hma9CrrlouXyipWqJcxHdXjT8tgwOXn4p+zbdUHh4wKVxiAlZf?=
 =?us-ascii?Q?wSEs29Y4qaOIRvuxuK5Ocjgb2IMix3hQrXzW3/gUL+iq0oreFsiU+mh9As+p?=
 =?us-ascii?Q?ppN0k15HFipe6Bq8Bee5Et7utBYfdfGJpgddLSl3GRaXYpxXDls9xJruzBwu?=
 =?us-ascii?Q?xRumF8TT81Kun009NqxWoj6YAMDLxbLUA0ijWJojhV8NKjIr0iT2096UY78V?=
 =?us-ascii?Q?ii2dcizFUtllg1bivgI0S3Ol6Kk7ZIj4IboxoV8jdSUKaU8+OoGHmIKoz1fd?=
 =?us-ascii?Q?sY6/Ps+e/J/1r/8EJumpwAEOtVjnDbErgOy3QK80D3ym6Ci9+sSkFWPbqvFq?=
 =?us-ascii?Q?e37jyPYS7KJiQ5mpiX3/kzuCV+G7mERnDMrzbkHjBY0mSBRn1nsXpi8IqltR?=
 =?us-ascii?Q?B3toIo9CkdZxBDPnD9tN4rO2cZQMtnu7+6hd2M+Yz0N/+3ktPcrwQW7GuuMd?=
 =?us-ascii?Q?Oveli34M6c2Whpz5MOuUcVj5kLr3xcpl4p1qrgXUCSKq2sl5+uRyE4KkXQWh?=
 =?us-ascii?Q?VRN3f8wTQ1OxwqttxrFskGjiMpXc2i5hf1BrVMnHcFF1tWyl2CSGGYcnNJNY?=
 =?us-ascii?Q?UdDh+kT2J/rVKy72Sr3cLdl0zrh2niNzU2oWZSN4afKbxeEYfoqJNUTls99w?=
 =?us-ascii?Q?Akv1QO8v2folKCQ+J+AsXwmIe6ih4oqaBmOSOnPRMz/UfDiPne40rPpzoRfg?=
 =?us-ascii?Q?ulaZX2S3gtG7UhWSMhJk6kuT9viyPnEMblNuZGVCHu2Eor/GCO5JHyHubopv?=
 =?us-ascii?Q?Kfe0yGY4PwAOTxzA4HWMP66i1BIdxeOVahM7hqMXnsqoece+5XlKhPO3b3hz?=
 =?us-ascii?Q?y5jDE2YwfNAKWnWk6Rj1XZoHRqPgbe91dXnJUFCPYdslO7J42dNuz5k/h0qF?=
 =?us-ascii?Q?7BDWA63FUBggRjCrYNqzIQz24dYvI43a1yK3vkpaMBRCAQ+ICkmKfUttROQ0?=
 =?us-ascii?Q?0ssx/Z/8oClB/qOf+vXGIYIwZIynfiywzhsGGxL1RAsn67FFHqlArxksmCoW?=
 =?us-ascii?Q?OY1HUnmz0X/oMVvS7a6RPlfibV2C1z00xbiPl1RUVS3OiwPRDYD7WxFOLCvm?=
 =?us-ascii?Q?/W9Gk8K5rfBNBBGKk0chQ2/c14ZkA5CzEPOhj5NTjXbvokAbCfLkwpuBIKJE?=
 =?us-ascii?Q?a71oBe5zctK8SJhG3MDPmr61d6PIIOhwBvf2XVyt0G/VNkGmHud9OMqkbcxS?=
 =?us-ascii?Q?yC6D1IyjR3yeIxccM9ykQYbg7vYENiFbTVqxnZ8Naipn9G0ovTD9CxI4ljYU?=
 =?us-ascii?Q?sljkxnIrIU1zSqM5ThwTQ1sEIw9qT6YLhA/ojO3SeZ39lnpEqlbwJW3oKvdG?=
 =?us-ascii?Q?DkzsPdf1fDvNhz3uAR4tOdCfks1n9+Na0wlW9Tmwsu4wG6pf6RnYQASi8AdJ?=
 =?us-ascii?Q?Z7mcoYotGcLwQtrempQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 21:15:39.1915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76d100d-b8b3-46ad-62ac-08de0842299f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
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

The CSA and EOP buffers have different alignement requirements.
Hardcode them for now as a bug fix.  A proper query will be added in
a subsequent patch.

Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address and size")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 0370ef719a6aa..ab392de2a2388 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -254,7 +254,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
 	struct drm_amdgpu_userq_in *mqd_user = args_in;
 	struct amdgpu_mqd_prop *userq_props;
-	struct amdgpu_gfx_shadow_info shadow_info;
 	int r;
 
 	/* Structure to initialize MQD for userqueue using generic MQD init function */
@@ -280,8 +279,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props->doorbell_index = queue->doorbell_index;
 	userq_props->fence_address = queue->fence_drv->gpu_addr;
 
-	if (adev->gfx.funcs->get_gfx_shadow_info)
-		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
 
@@ -299,7 +296,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		}
 
 		r = amdgpu_userq_input_va_validate(queue, compute_mqd->eop_va,
-						   max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE));
+						   2048);
 		if (r)
 			goto free_mqd;
 
@@ -312,6 +309,9 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
+		struct amdgpu_gfx_shadow_info shadow_info;
+
+		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
 
 		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
 			DRM_ERROR("Invalid GFX MQD\n");
@@ -335,6 +335,10 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 						   shadow_info.shadow_size);
 		if (r)
 			goto free_mqd;
+		r = amdgpu_userq_input_va_validate(queue, mqd_gfx_v11->csa_va,
+						   shadow_info.csa_size);
+		if (r)
+			goto free_mqd;
 
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
@@ -353,7 +357,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 		r = amdgpu_userq_input_va_validate(queue, mqd_sdma_v11->csa_va,
-						   shadow_info.csa_size);
+						   32);
 		if (r)
 			goto free_mqd;
 
-- 
2.51.0

