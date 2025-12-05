Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6F9D374B3
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19CB110EBCB;
	Fri,  5 Dec 2025 21:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HKYb4ZwJ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF9110EBC9
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQRZjWAnNg2Exl47w8Cc57hZkhGqagS4NfeERtpdB7tVtSuI9Nn1DzScacduFFSE0idVWyDJ/eqJIwGZbOk4T4qyItOHRJ0dLAZV8vpDVVcyoPmAa68gu8tOaFFSamTexD385BrqMZgoyBLAjX25afqR4OCcPntvOUuyNwXoPhoLMLtRO6xSVkRLXUBNB03MMNKfBBtopNgP6fY1lhxygxUzCimLX0p6TxbUZSNtHGKo0t4jGfC7LBl6nuStoXs09AgdRmsFRnMItH1Nk2tXjQIeMsSiIHZl4ZGsuOja0GvtO8v26kj+dhFz1MFjJVd8kY8G/mzFEc3O+QSeRRZ6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gp6LtubB49E0wDIRdEHvzhTUH22tR2UIidVhXXn0HOc=;
 b=reqkXdK9D+QNMyCbHhexA5zONx6scTnKC2R09fKONe0WbZCQP5eOME5SEjwCz+OxM4yyH0KleoU2JYIscxVbfJrT2L1QvbAREKljgoOCMLXbuGpr2YBhC6AHPt/xzNo3P/FkEMbN4gFXVoZpqJ2bRi/IBNan/uLaFbTFvyG46JVPIMw1zITECCg1I6V6YOMwARLQmt4gzaNXL9mQqenlcMHRzuPeMC8pNYWabn+RKOfzRjAbeeRgvM8A966zy3OdYZAXuweW20JyJUA30Fuw53KX8j5tDOcrQKsBhdtJTynMF7nS3G9/8WcaMEoN1BOdjiBFKTnyrJM6m5LlSRhveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp6LtubB49E0wDIRdEHvzhTUH22tR2UIidVhXXn0HOc=;
 b=HKYb4ZwJSxEo8Ng6NWGElAULY1fEnwhs4XQWmPLlw6TwQHT2wu+nI+9/VQIkMQH+Y3ZTng1KfzuUHkOQ+AOP5VlUhsAccNiiYHZ1W8GfkYhHPDyQu2+dPmTVU3ixD77roqJA7KUopQ35CXZiLSUy1wA33T/FVSUuiR1TR9ccmhM=
Received: from DM6PR03CA0031.namprd03.prod.outlook.com (2603:10b6:5:40::44) by
 SA1PR12MB999085.namprd12.prod.outlook.com (2603:10b6:806:4a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 21:49:49 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::7) by DM6PR03CA0031.outlook.office365.com
 (2603:10b6:5:40::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:49 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add soc_v1_0_xcp_funcs
Date: Fri, 5 Dec 2025 16:49:24 -0500
Message-ID: <20251205214926.146844-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205214926.146844-1-alexander.deucher@amd.com>
References: <20251205214926.146844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SA1PR12MB999085:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fa8fd5-d108-443c-5530-08de344836af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sXlyDHJ/7mRtxZndf9PpDbrCG/M2j3/aYDJWvh6v+yNm499dQRI7iJ3vSQgh?=
 =?us-ascii?Q?72q62t7TBaAlJemMqFflM6Tty9+lCoUKj2qQMPUjjTN1Hse7/R4ap90AuiiT?=
 =?us-ascii?Q?SbwXUPt7Wj3rPfOfLiyhfui5gaTGtQRbc9CteQLjWBV3sS+SiKRJsA26GA6c?=
 =?us-ascii?Q?keVzpPhDV989pkop9eBUpiprZ/fot1u92gZHLRhaeAoZDLcM+AxLOXWU+e3E?=
 =?us-ascii?Q?GNWFmC/FYx2Y33fb1p5f8tr2WnzPE1W7NIneY/jo/yXncW6BsEThvpiAAyMk?=
 =?us-ascii?Q?p20nC3rTkZwzc+t/dCqMRYP4A3ACkLPgxIaeXMiICr1NnKSey8t0WeEIXPXM?=
 =?us-ascii?Q?l5yzs9Pj9TiDgf98SknMJclPCgDL/+2Nhcyy0pN4N5+uJ2U0Y68CUJYSICHE?=
 =?us-ascii?Q?PPiqHzTzDraf1xEDvxCFF5YXgs3Ax2x9ebjUiVHTCUb0AmN23x1dOMXZ7ljB?=
 =?us-ascii?Q?aZCygWerat8D5/931a5dJ47YyO+9DlG6CAKdGlA/fEubx+jKOtx4usJxlphC?=
 =?us-ascii?Q?ZqSfSq+F671z0+Wi+j8BIig/GWq7hsut5pSX32uysLB5vcxCltvFL9snUb1Y?=
 =?us-ascii?Q?IvA7DhKndAdYlQTx8vTDKVtt2zh1woT/778hKB7T5fKwx2xibw9rz0BhMr7k?=
 =?us-ascii?Q?x1YoXJ4m5MO+FyN8ZTtMmrvughVmVL03clFpc0J7tb/2TB91XKx+GZtORZar?=
 =?us-ascii?Q?+c7Jtt2RP1lQUBzerBiGDmCAIjTTMhvf3gOQpJaPu++1JsPKUg3lMjBJJa/A?=
 =?us-ascii?Q?dAXNWLysLreMjn+ULIrUrIibVnOuR0rkv4wsCfMEAHU0b/qrO1z/f4OJ3PhO?=
 =?us-ascii?Q?2iXVSKrKQxhhTV1l6IJ8NSWrJZKpRgVmQerZARZ7GmxnhbFmcktaNzUQyAob?=
 =?us-ascii?Q?crVejMr05tPqn+aZDKgtX6xJ2auQrgA8xYfG7JGLQAVtkAfXF0ZJ02cWYkcH?=
 =?us-ascii?Q?gCsyWdcY6npoBUtfs1nX3Uxv+AHNiZj8/NPm8n+JSw5yPRVmPMXIAeDhOq4l?=
 =?us-ascii?Q?23rMBhkMzmqD0Kpv9cO0Et1kBhoJ3QBDXXx523Dk58aQrtty/4eNYY+YDaTE?=
 =?us-ascii?Q?xDO/dE1jTvE9eT5wEsvuH3KQqodyAzAmNqzZSAiGst9d7BrHVPuMJH1HHmRh?=
 =?us-ascii?Q?cNM8GMrpHJ9P0Vvm1Vz0EZiQyze8/Uf+zCh1EKjSkZcrUXzyEb5Lyl52eJEP?=
 =?us-ascii?Q?igpDvDdfhnv3hekBUOgSeVgVj5uDV7sr38gPFmqPXk8YvWxRlzKMNB0T9Y8D?=
 =?us-ascii?Q?jYJjujZTFXo9Sbh7VHjEczqiPxp0AszXe0gUp5CdJQk4uI/MsnbYt0yFV+sv?=
 =?us-ascii?Q?f/3hUKwvel4erKdL9zsurKdtPP38M2gknSGUnPi0e7GeRqMAN7oQmvyXN9t9?=
 =?us-ascii?Q?AR1AE2U0sCda3QqYpfStRUPE4shigo/1Ew163uQIDuIpIRqoyjy0cV9eptYx?=
 =?us-ascii?Q?K8n9tiCuDKrwknTUkxtDOWcDHboob1SEyCntO7ZaEjM/bFgCj8pxq+XcbHFk?=
 =?us-ascii?Q?FL5tt7Lzu7cgWYaOd4Q+EauYDVincrWXJ1KvOLXUi2wesTfKjI/GHB+KbZcv?=
 =?us-ascii?Q?bMfg1kYhtF6qW3akQcA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:49.2149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fa8fd5-d108-443c-5530-08de344836af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999085
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Implement xcp mgr callbacks for soc v1_0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 411 ++++++++++++++++++++++++++
 1 file changed, 411 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 0ede5e22e905f..803732c11d3f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -25,6 +25,10 @@
 #include "soc15_common.h"
 #include "soc_v1_0.h"
 #include "amdgpu_ip.h"
+#include "amdgpu_imu.h"
+#include "gfxhub_v12_1.h"
+#include "sdma_v7_1.h"
+#include "gfx_v12_1.h"
 
 #include "gc/gc_12_1_0_offset.h"
 #include "gc/gc_12_1_0_sh_mask.h"
@@ -336,6 +340,413 @@ const struct amdgpu_ip_block_version soc_v1_0_common_ip_block = {
 	.funcs = &soc_v1_0_common_ip_funcs,
 };
 
+static enum amdgpu_gfx_partition __soc_v1_0_calc_xcp_mode(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	struct amdgpu_device *adev = xcp_mgr->adev;
+	int num_xcc, num_xcc_per_xcp = 0, mode = 0;
+
+	num_xcc = NUM_XCC(xcp_mgr->adev->gfx.xcc_mask);
+	if (adev->gfx.imu.funcs &&
+	    adev->gfx.imu.funcs->get_xccs_per_xcp)
+		num_xcc_per_xcp = adev->gfx.imu.funcs->get_xccs_per_xcp(adev);
+	if ((num_xcc_per_xcp) && (num_xcc % num_xcc_per_xcp == 0))
+		mode = num_xcc / num_xcc_per_xcp;
+
+	if (num_xcc_per_xcp == 1)
+		return AMDGPU_CPX_PARTITION_MODE;
+
+	switch (mode) {
+	case 1:
+		return AMDGPU_SPX_PARTITION_MODE;
+	case 2:
+		return AMDGPU_DPX_PARTITION_MODE;
+	case 3:
+		return AMDGPU_TPX_PARTITION_MODE;
+	case 4:
+		return AMDGPU_QPX_PARTITION_MODE;
+	default:
+		return AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+	}
+
+	return AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+}
+
+static int soc_v1_0_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	enum amdgpu_gfx_partition derv_mode, mode;
+	struct amdgpu_device *adev = xcp_mgr->adev;
+
+	mode = AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+	derv_mode = __soc_v1_0_calc_xcp_mode(xcp_mgr);
+
+	if (amdgpu_sriov_vf(adev))
+		return derv_mode;
+
+	if (adev->nbio.funcs &&
+	    adev->nbio.funcs->get_compute_partition_mode) {
+		mode = adev->nbio.funcs->get_compute_partition_mode(adev);
+		if (mode != derv_mode)
+			dev_warn(adev->dev,
+				 "Mismatch in compute partition mode - reported : %d derived : %d",
+				 mode, derv_mode);
+	}
+
+	return mode;
+}
+
+static int __soc_v1_0_get_xcc_per_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
+{
+	int num_xcc, num_xcc_per_xcp = 0;
+
+	num_xcc = NUM_XCC(xcp_mgr->adev->gfx.xcc_mask);
+
+	switch (mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+		num_xcc_per_xcp = num_xcc;
+		break;
+	case AMDGPU_DPX_PARTITION_MODE:
+		num_xcc_per_xcp = num_xcc / 2;
+		break;
+	case AMDGPU_TPX_PARTITION_MODE:
+		num_xcc_per_xcp = num_xcc / 3;
+		break;
+	case AMDGPU_QPX_PARTITION_MODE:
+		num_xcc_per_xcp = num_xcc / 4;
+		break;
+	case AMDGPU_CPX_PARTITION_MODE:
+		num_xcc_per_xcp = 1;
+		break;
+	}
+
+	return num_xcc_per_xcp;
+}
+
+static int __soc_v1_0_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
+				      enum AMDGPU_XCP_IP_BLOCK ip_id,
+				      struct amdgpu_xcp_ip *ip)
+{
+	struct amdgpu_device *adev = xcp_mgr->adev;
+	int num_sdma, num_vcn, num_shared_vcn, num_xcp;
+	int num_xcc_xcp, num_sdma_xcp, num_vcn_xcp;
+
+	num_sdma = adev->sdma.num_instances;
+	num_vcn = adev->vcn.num_vcn_inst;
+	num_shared_vcn = 1;
+
+	num_xcc_xcp = adev->gfx.num_xcc_per_xcp;
+	num_xcp = NUM_XCC(adev->gfx.xcc_mask) / num_xcc_xcp;
+
+	switch (xcp_mgr->mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+	case AMDGPU_DPX_PARTITION_MODE:
+	case AMDGPU_TPX_PARTITION_MODE:
+	case AMDGPU_QPX_PARTITION_MODE:
+	case AMDGPU_CPX_PARTITION_MODE:
+		num_sdma_xcp = DIV_ROUND_UP(num_sdma, num_xcp);
+		num_vcn_xcp = DIV_ROUND_UP(num_vcn, num_xcp);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (num_vcn && num_xcp > num_vcn)
+		num_shared_vcn = num_xcp / num_vcn;
+
+	switch (ip_id) {
+	case AMDGPU_XCP_GFXHUB:
+		ip->inst_mask = XCP_INST_MASK(num_xcc_xcp, xcp_id);
+		ip->ip_funcs = &gfxhub_v12_1_xcp_funcs;
+		break;
+	case AMDGPU_XCP_GFX:
+		ip->inst_mask = XCP_INST_MASK(num_xcc_xcp, xcp_id);
+		ip->ip_funcs = &gfx_v12_1_xcp_funcs;
+		break;
+	case AMDGPU_XCP_SDMA:
+		ip->inst_mask = XCP_INST_MASK(num_sdma_xcp, xcp_id);
+		ip->ip_funcs = &sdma_v7_1_xcp_funcs;
+		break;
+	case AMDGPU_XCP_VCN:
+		ip->inst_mask =
+			XCP_INST_MASK(num_vcn_xcp, xcp_id / num_shared_vcn);
+		/* TODO : Assign IP funcs */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ip->ip_id = ip_id;
+
+	return 0;
+}
+
+static int soc_v1_0_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
+				     int mode,
+				     struct amdgpu_xcp_cfg *xcp_cfg)
+{
+	struct amdgpu_device *adev = xcp_mgr->adev;
+	int max_res[AMDGPU_XCP_RES_MAX] = {};
+	bool res_lt_xcp;
+	int num_xcp, i;
+	u16 nps_modes;
+
+	if (!(xcp_mgr->supp_xcp_modes & BIT(mode)))
+		return -EINVAL;
+
+	max_res[AMDGPU_XCP_RES_XCC] = NUM_XCC(adev->gfx.xcc_mask);
+	max_res[AMDGPU_XCP_RES_DMA] = adev->sdma.num_instances;
+	max_res[AMDGPU_XCP_RES_DEC] = adev->vcn.num_vcn_inst;
+	max_res[AMDGPU_XCP_RES_JPEG] = adev->jpeg.num_jpeg_inst;
+
+	switch (mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+		num_xcp = 1;
+		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE);
+		break;
+	case AMDGPU_DPX_PARTITION_MODE:
+		num_xcp = 2;
+		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE);
+		break;
+	case AMDGPU_TPX_PARTITION_MODE:
+		num_xcp = 3;
+		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			    BIT(AMDGPU_NPS4_PARTITION_MODE);
+		break;
+	case AMDGPU_QPX_PARTITION_MODE:
+		num_xcp = 4;
+		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			    BIT(AMDGPU_NPS4_PARTITION_MODE);
+		break;
+	case AMDGPU_CPX_PARTITION_MODE:
+		num_xcp = NUM_XCC(adev->gfx.xcc_mask);
+		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			    BIT(AMDGPU_NPS4_PARTITION_MODE);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	xcp_cfg->compatible_nps_modes =
+		(adev->gmc.supported_nps_modes & nps_modes);
+	xcp_cfg->num_res = ARRAY_SIZE(max_res);
+
+	for (i = 0; i < xcp_cfg->num_res; i++) {
+		res_lt_xcp = max_res[i] < num_xcp;
+		xcp_cfg->xcp_res[i].id = i;
+		xcp_cfg->xcp_res[i].num_inst =
+			res_lt_xcp ? 1 : max_res[i] / num_xcp;
+		xcp_cfg->xcp_res[i].num_inst =
+			i == AMDGPU_XCP_RES_JPEG ?
+			xcp_cfg->xcp_res[i].num_inst *
+			adev->jpeg.num_jpeg_rings : xcp_cfg->xcp_res[i].num_inst;
+		xcp_cfg->xcp_res[i].num_shared =
+			res_lt_xcp ? num_xcp / max_res[i] : 1;
+	}
+
+	return 0;
+}
+
+static enum amdgpu_gfx_partition __soc_v1_0_get_auto_mode(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	struct amdgpu_device *adev = xcp_mgr->adev;
+	int num_xcc;
+
+	num_xcc = NUM_XCC(xcp_mgr->adev->gfx.xcc_mask);
+
+	if (adev->gmc.num_mem_partitions == 1)
+		return AMDGPU_SPX_PARTITION_MODE;
+
+	if (adev->gmc.num_mem_partitions == num_xcc)
+		return AMDGPU_CPX_PARTITION_MODE;
+
+	if (adev->gmc.num_mem_partitions == 2)
+		return AMDGPU_DPX_PARTITION_MODE;
+
+	return AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+}
+
+static bool __soc_v1_0_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
+				     enum amdgpu_gfx_partition mode)
+{
+	struct amdgpu_device *adev = xcp_mgr->adev;
+	int num_xcc, num_xccs_per_xcp;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	switch (mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+		return adev->gmc.num_mem_partitions == 1 && num_xcc > 0;
+	case AMDGPU_DPX_PARTITION_MODE:
+		return adev->gmc.num_mem_partitions <= 2 && (num_xcc % 4) == 0;
+	case AMDGPU_TPX_PARTITION_MODE:
+		return (adev->gmc.num_mem_partitions == 1 ||
+			adev->gmc.num_mem_partitions == 3) &&
+		       ((num_xcc % 3) == 0);
+	case AMDGPU_QPX_PARTITION_MODE:
+		num_xccs_per_xcp = num_xcc / 4;
+		return (adev->gmc.num_mem_partitions == 1 ||
+			adev->gmc.num_mem_partitions == 4) &&
+		       (num_xccs_per_xcp >= 2);
+	case AMDGPU_CPX_PARTITION_MODE:
+		/* (num_xcc > 1) because 1 XCC is considered SPX, not CPX.
+		 * (num_xcc % adev->gmc.num_mem_partitions) == 0 because
+		 * num_compute_partitions can't be less than num_mem_partitions
+		 */
+		return ((num_xcc > 1) &&
+		       (num_xcc % adev->gmc.num_mem_partitions) == 0);
+	default:
+		return false;
+	}
+
+	return false;
+}
+
+static void __soc_v1_0_update_available_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	int mode;
+
+	xcp_mgr->avail_xcp_modes = 0;
+
+	for_each_inst(mode, xcp_mgr->supp_xcp_modes) {
+		if (__soc_v1_0_is_valid_mode(xcp_mgr, mode))
+			xcp_mgr->avail_xcp_modes |= BIT(mode);
+	}
+}
+
+static int soc_v1_0_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
+					  int mode, int *num_xcps)
+{
+	int num_xcc_per_xcp, num_xcc, ret;
+	struct amdgpu_device *adev;
+	u32 flags = 0;
+
+	adev = xcp_mgr->adev;
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
+	if (mode == AMDGPU_AUTO_COMPUTE_PARTITION_MODE) {
+		mode = __soc_v1_0_get_auto_mode(xcp_mgr);
+		if (mode == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) {
+			dev_err(adev->dev,
+				"Invalid config, no compatible compute partition mode found, available memory partitions: %d",
+				adev->gmc.num_mem_partitions);
+			return -EINVAL;
+		}
+	} else if (!__soc_v1_0_is_valid_mode(xcp_mgr, mode)) {
+		dev_err(adev->dev,
+			"Invalid compute partition mode requested, requested: %s, available memory partitions: %d",
+			amdgpu_gfx_compute_mode_desc(mode), adev->gmc.num_mem_partitions);
+		return -EINVAL;
+	}
+
+	if (adev->kfd.init_complete && !amdgpu_in_reset(adev))
+		flags |= AMDGPU_XCP_OPS_KFD;
+
+	if (flags & AMDGPU_XCP_OPS_KFD) {
+		ret = amdgpu_amdkfd_check_and_lock_kfd(adev);
+		if (ret)
+			goto out;
+	}
+
+	ret = amdgpu_xcp_pre_partition_switch(xcp_mgr, flags);
+	if (ret)
+		goto unlock;
+
+	num_xcc_per_xcp = __soc_v1_0_get_xcc_per_xcp(xcp_mgr, mode);
+	if (adev->gfx.imu.funcs &&
+	    adev->gfx.imu.funcs->switch_compute_partition)
+		adev->gfx.imu.funcs->switch_compute_partition(xcp_mgr->adev, num_xcc_per_xcp);
+
+	/* Init info about new xcps */
+	*num_xcps = num_xcc / num_xcc_per_xcp;
+	amdgpu_xcp_init(xcp_mgr, *num_xcps, mode);
+
+	ret = amdgpu_xcp_post_partition_switch(xcp_mgr, flags);
+	if (!ret)
+		__soc_v1_0_update_available_partition_mode(xcp_mgr);
+unlock:
+	if (flags & AMDGPU_XCP_OPS_KFD)
+		amdgpu_amdkfd_unlock_kfd(adev);
+out:
+	return ret;
+}
+
+#ifdef HAVE_ACPI_DEV_GET_FIRST_MATCH_DEV
+static int __soc_v1_0_get_xcp_mem_id(struct amdgpu_device *adev,
+				     int xcc_id, uint8_t *mem_id)
+{
+	/* memory/spatial modes validation check is already done */
+	*mem_id = xcc_id / adev->gfx.num_xcc_per_xcp;
+	*mem_id /= adev->xcp_mgr->num_xcp_per_mem_partition;
+
+	return 0;
+}
+
+static int soc_v1_0_get_xcp_mem_id(struct amdgpu_xcp_mgr *xcp_mgr,
+				   struct amdgpu_xcp *xcp, uint8_t *mem_id)
+{
+	struct amdgpu_numa_info numa_info;
+	struct amdgpu_device *adev;
+	uint32_t xcc_mask;
+	int r, i, xcc_id;
+
+	adev = xcp_mgr->adev;
+	/* TODO: BIOS is not returning the right info now
+	 * Check on this later
+	 */
+	/*
+	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
+		mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+	*/
+	if (adev->gmc.num_mem_partitions == 1) {
+		/* Only one range */
+		*mem_id = 0;
+		return 0;
+	}
+
+	r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &xcc_mask);
+	if (r || !xcc_mask)
+		return -EINVAL;
+
+	xcc_id = ffs(xcc_mask) - 1;
+	if (!adev->gmc.is_app_apu)
+		return __soc_v1_0_get_xcp_mem_id(adev, xcc_id, mem_id);
+
+	r = amdgpu_acpi_get_mem_info(adev, xcc_id, &numa_info);
+
+	if (r)
+		return r;
+
+	r = -EINVAL;
+	for (i = 0; i < adev->gmc.num_mem_partitions; ++i) {
+		if (adev->gmc.mem_partitions[i].numa.node == numa_info.nid) {
+			*mem_id = i;
+			r = 0;
+			break;
+		}
+	}
+
+	return r;
+}
+#endif
+
+static int soc_v1_0_get_xcp_ip_details(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
+				       enum AMDGPU_XCP_IP_BLOCK ip_id,
+				       struct amdgpu_xcp_ip *ip)
+{
+	if (!ip)
+		return -EINVAL;
+
+	return __soc_v1_0_get_xcp_ip_info(xcp_mgr, xcp_id, ip_id, ip);
+}
+
+struct amdgpu_xcp_mgr_funcs soc_v1_0_xcp_funcs = {
+	.switch_partition_mode = &soc_v1_0_switch_partition_mode,
+	.query_partition_mode = &soc_v1_0_query_partition_mode,
+	.get_ip_details = &soc_v1_0_get_xcp_ip_details,
+	.get_xcp_res_info = &soc_v1_0_get_xcp_res_info,
+#ifdef HAVE_ACPI_DEV_GET_FIRST_MATCH_DEV
+	.get_xcp_mem_id = &soc_v1_0_get_xcp_mem_id,
+#endif
+};
+
 int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 {
 	adev->sdma.num_inst_per_xcc = 2;
-- 
2.51.1

