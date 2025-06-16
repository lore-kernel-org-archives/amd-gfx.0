Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ABCC7115A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 09:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD4D10E310;
	Mon, 16 Jun 2025 09:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ELb4rC19";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680DF10E311
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 09:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C95KDbU4F9Xn9oPBUElzLBKu3j8NyQH2T5dxIdPFpk7HRK8N/0OX19sZC/tu71hYJHOu5K1oo6sRw+EOahbbSCcwJK6a5sl3L97URbgQm2AooGqt/eaHUlEQCG+vC9VhDtbLbHe8j3M8Cjn9R7tP7fJKwo/tn7RZV4iIbHJ3gm0DC4az3lty6mEZX8+lTq2KQm4p5l0l52lYG9mfHTq/5LxM9qx6ndWj6TD0gIIrUNCN+2h3DILZf4Q/RmUwS8e3OzLHuABDg2qnBiZwRZIZcdO2+TWj1JTX5btdLCYVVmRd5w6y7y0mIfTEN8DnGKz0iCr0TtBGJQhF9CyUlhmlzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06DbpNUnqb88JEahwjPYkpPKvq61Rnhmt6WdaqylRFg=;
 b=tTvDr+J4jlhwHX3pYicRFg+zMzY9bkb01Vpjj6japna/1x19wztDMxyTMMFrj5Dcsf0VMWT30zDgzWWYmBKlfg6YbyPtfb2Ds4M3fRPbszNV8+rPMbcmjr7uW1olZCfgLckKZP0Gt22RoFVo10ir/g/63F0E1eQDsPnxIEDxJVeAWCQAME18Y9f5DZNx9LVqKPekjtJIpyH40IhmfcPo2I7RTmA2ZSs987oPFlD/36rLxRd+SKYX7qjj0fwgQ8F7wQnQpfmYbADM182G4akByIesY10Bhv56lpeFCZzBgN+Ic8xzbubyNYt+qTAxM5336KrPB4BRdlrG90cg5Lbe1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06DbpNUnqb88JEahwjPYkpPKvq61Rnhmt6WdaqylRFg=;
 b=ELb4rC19m2Kt+mitZva5sPC8zVZLT2ML5CyWQ7VGbRsa1IFmf47uzAv5I+IATMlTT/dKkErt4rZyjE4y1DxxNZzG3E9YtaCYmTlOX+D70w6r2Sa8KtfVw/KIXCJMTo1dFgs5OswgD7Sej1jlZeD93k7xUVyhIiVl7ozmaKzr6kY=
Received: from DM5PR07CA0109.namprd07.prod.outlook.com (2603:10b6:4:ae::38) by
 DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Mon, 16 Jun 2025 09:39:06 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::62) by DM5PR07CA0109.outlook.office365.com
 (2603:10b6:4:ae::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Mon,
 16 Jun 2025 09:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:39:06 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Jun 2025 04:39:01 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Le Ma
 <Le.Ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 04/10] drm/amdgpu: Convert update_partition_sched_list into a
 common helper v3
Date: Mon, 16 Jun 2025 17:37:50 +0800
Message-ID: <20250616093756.16200-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250616093756.16200-1-Hawking.Zhang@amd.com>
References: <20250616093756.16200-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 200fcd10-aa64-4444-0197-08ddacb9a33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UH2XTKtUKULjItWghtw+UW5uU0dAG1rWb6D9FnWuNUEuSOz7dHzlZBFkTSeT?=
 =?us-ascii?Q?c3PmyKtwvUfHUCh92eMriBKkvDYabgN6hW4suD2qtlf2YnR1NTftGyUHV5dL?=
 =?us-ascii?Q?qPLDMyu1B7LIaObkm91la1UG0/pqPY+/86WTNlQ4svOTZBrKi1YnAPvgbDK2?=
 =?us-ascii?Q?rRBhOm+/ozq/l8Tsd3/J+E/P3su4mnAh1T1qaqH4KwaiQqd7RIwaeyj/xKSo?=
 =?us-ascii?Q?NfvPnEpQwxy+HQjacMubsEL3BLR4Umd81sdeGrjcOVSWzFtZc+TA32zH9BY6?=
 =?us-ascii?Q?2ctmfhhtB9fFhYg3isSBattOx9JbOmlgIWvNFrmVcwkbhwxBH9le6hh5oaHs?=
 =?us-ascii?Q?8j5rgyrrnDE7uU2++LzjBzRBXJaO8gugNx+cLeDLnSmU83oVARhQIWuEAQzy?=
 =?us-ascii?Q?HCTtw/l2D+Ykc1amtMVA3wMipI+HPQ3FQxLqIb1H5wpm96R7ad3dLnl1O8L5?=
 =?us-ascii?Q?2jb40f/FLfNuCOMU0Eq4mmX5a7zMsd4pE25sAvZ9lDZ2aVCSzNTDSU+DC3AJ?=
 =?us-ascii?Q?WSiZvtwJMze+z52J0lcBQSHCUNh6frzQweVZ/hXThWfUyvmzx+U4t24hg/Oe?=
 =?us-ascii?Q?um7QC5z+UfguRNCLN8C1j7VnWr1jSXMi4+OJVfj2FJ8Yt6o9rXmV2Lrs6ocA?=
 =?us-ascii?Q?WPEHSNKyaT0KT9SLxrZ/GoVm4XgFIOwUygLkIS4Z5QM8VIAsNRCNnqNxrZ2l?=
 =?us-ascii?Q?3rWIQwVCAm1h0KZ2E7FHI7uNFVJod6u2e/rLVH9XDUruU/t4N3nt7nS5+PI1?=
 =?us-ascii?Q?/V8PkOZ4Mth8k92m6lqbWeOyCdatN8EU9S50EyiIxu4FWyM07xYXJw5YW67e?=
 =?us-ascii?Q?RXT1IawEOdDGcYYQ4Tnmy9cznUWyFMiqGmDykeF8cFVJzEKdnIdDQ7HMUPjg?=
 =?us-ascii?Q?XTuLMl0TpCRuq02ejSpI0jjLYJ7sty/1HeH2H/KX0sj8Wgz0oddwLupfQPOa?=
 =?us-ascii?Q?vwSDodd7i66lh1KY4+t+dhEtoUI1TpTFCmQxVFfVF7fB6u+bLSfjNSfE1tYd?=
 =?us-ascii?Q?Z4K0L3qF+x/OJwT1jzvqCoLf8ta4Rkc6jLWwRpSsORmo75YQ9O75d0sGHvrU?=
 =?us-ascii?Q?fsdUU/mke2bEEqje0PVsv8vBpaqTs2qO9h4oO7WrgDXyQvHJNTYpptbGck5q?=
 =?us-ascii?Q?QwNsnxI7D9q4fnChi6DTU5bGVrAWFP4uiKgwYzw42xi6Djclmv5xuiQuH/Jm?=
 =?us-ascii?Q?kRjyNCruPPShsSX4us5xatRCREaainbceqYQQ9NNJG+cw8zjZFHB60Yvvl1O?=
 =?us-ascii?Q?G28fGSLnm5yL6Hwk7//Ce1ljGzUhWU0yGMJFJiptWGZZ+8rkDb+8Z9r/gZt7?=
 =?us-ascii?Q?Wbiwt2c8L3rfhp/y/wRvlL/fmFkn533bADdKBhf4CmCR2qSJfFa9WPDB2J1m?=
 =?us-ascii?Q?sYuSc2q/zOCiM3ZjBX18Vjpymaur26Q7hRNNCmwmRYCpPu5xBopgAVCIqoMN?=
 =?us-ascii?Q?5s/b0pnAgcvZK4eeFKjHdnoBqF5PjyHW++SvXPOMIJQX6OUm2npg7V9Lh1Po?=
 =?us-ascii?Q?DDF377oz4Ju2pMC9lDB5pS1OgluSv9nbPbDw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:39:06.3338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 200fcd10-aa64-4444-0197-08ddacb9a33e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285
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

The update_partition_sched_list function does not
need to remain as a soc specific callback. It can
be reused for future products.

v2: bypass the function if xcp_mgr is not available (Likun)

v3: Let caller check the availability of xcp_mgr (Lijo)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 111 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |   7 +-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 119 ---------------------
 4 files changed, 114 insertions(+), 126 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7c15bd2c8a9c..c401f27a06fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3012,7 +3012,8 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 		}
 	}
 
-	amdgpu_xcp_update_partition_sched_list(adev);
+	if (adev->xcp_mgr)
+		amdgpu_xcp_update_partition_sched_list(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 5530166f1b23..f056c6cf7faf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -483,6 +483,117 @@ int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void amdgpu_set_xcp_id(struct amdgpu_device *adev,
+			      uint32_t inst_idx,
+			      struct amdgpu_ring *ring)
+{
+	int xcp_id;
+	enum AMDGPU_XCP_IP_BLOCK ip_blk;
+	uint32_t inst_mask;
+
+	ring->xcp_id = AMDGPU_XCP_NO_PARTITION;
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)
+		adev->gfx.enforce_isolation[0].xcp_id = ring->xcp_id;
+	if ((adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE) ||
+	    (ring->funcs->type == AMDGPU_RING_TYPE_CPER))
+		return;
+
+	inst_mask = 1 << inst_idx;
+
+	switch (ring->funcs->type) {
+	case AMDGPU_HW_IP_GFX:
+	case AMDGPU_RING_TYPE_COMPUTE:
+	case AMDGPU_RING_TYPE_KIQ:
+		ip_blk = AMDGPU_XCP_GFX;
+		break;
+	case AMDGPU_RING_TYPE_SDMA:
+		ip_blk = AMDGPU_XCP_SDMA;
+		break;
+	case AMDGPU_RING_TYPE_VCN_ENC:
+	case AMDGPU_RING_TYPE_VCN_JPEG:
+		ip_blk = AMDGPU_XCP_VCN;
+		break;
+	default:
+		dev_err(adev->dev, "Not support ring type %d!", ring->funcs->type);
+		return;
+	}
+
+	for (xcp_id = 0; xcp_id < adev->xcp_mgr->num_xcps; xcp_id++) {
+		if (adev->xcp_mgr->xcp[xcp_id].ip[ip_blk].inst_mask & inst_mask) {
+			ring->xcp_id = xcp_id;
+			dev_dbg(adev->dev, "ring:%s xcp_id :%u", ring->name,
+				ring->xcp_id);
+			if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)
+				adev->gfx.enforce_isolation[xcp_id].xcp_id = xcp_id;
+			break;
+		}
+	}
+}
+
+static void amdgpu_xcp_gpu_sched_update(struct amdgpu_device *adev,
+					struct amdgpu_ring *ring,
+					unsigned int sel_xcp_id)
+{
+	unsigned int *num_gpu_sched;
+
+	num_gpu_sched = &adev->xcp_mgr->xcp[sel_xcp_id]
+			.gpu_sched[ring->funcs->type][ring->hw_prio].num_scheds;
+	adev->xcp_mgr->xcp[sel_xcp_id].gpu_sched[ring->funcs->type][ring->hw_prio]
+			.sched[(*num_gpu_sched)++] = &ring->sched;
+	dev_dbg(adev->dev, "%s :[%d] gpu_sched[%d][%d] = %d",
+		ring->name, sel_xcp_id, ring->funcs->type,
+		ring->hw_prio, *num_gpu_sched);
+}
+
+static int amdgpu_xcp_sched_list_update(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+	int i;
+
+	for (i = 0; i < MAX_XCP; i++) {
+		atomic_set(&adev->xcp_mgr->xcp[i].ref_cnt, 0);
+		memset(adev->xcp_mgr->xcp[i].gpu_sched, 0, sizeof(adev->xcp_mgr->xcp->gpu_sched));
+	}
+
+	if (adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
+		return 0;
+
+	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
+		ring = adev->rings[i];
+		if (!ring || !ring->sched.ready || ring->no_scheduler)
+			continue;
+
+		amdgpu_xcp_gpu_sched_update(adev, ring, ring->xcp_id);
+
+		/* VCN may be shared by two partitions under CPX MODE in certain
+		 * configs.
+		 */
+		if ((ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC ||
+		     ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG) &&
+		    (adev->xcp_mgr->num_xcps > adev->vcn.num_vcn_inst))
+			amdgpu_xcp_gpu_sched_update(adev, ring, ring->xcp_id + 1);
+	}
+
+	return 0;
+}
+
+int amdgpu_xcp_update_partition_sched_list(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->num_rings; i++) {
+		struct amdgpu_ring *ring = adev->rings[i];
+
+		if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+			ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
+			amdgpu_set_xcp_id(adev, ring->xcc_id, ring);
+		else
+			amdgpu_set_xcp_id(adev, ring->me, ring);
+	}
+
+	return amdgpu_xcp_sched_list_update(adev);
+}
+
 /*====================== xcp sysfs - configuration ======================*/
 #define XCP_CFG_SYSFS_RES_ATTR_SHOW(_name)                         \
 	static ssize_t amdgpu_xcp_res_sysfs_##_name##_show(        \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 0ae4f14293bb..5845dce6b804 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -144,7 +144,6 @@ struct amdgpu_xcp_mgr_funcs {
 	int (*suspend)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
 	int (*prepare_resume)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
 	int (*resume)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
-	int (*update_partition_sched_list)(struct amdgpu_device *adev);
 };
 
 int amdgpu_xcp_prepare_suspend(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
@@ -178,14 +177,10 @@ int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
                              struct amdgpu_fpriv *fpriv,
                              unsigned int *num_scheds,
                              struct drm_gpu_scheduler ***scheds);
+int amdgpu_xcp_update_partition_sched_list(struct amdgpu_device *adev);
 void amdgpu_xcp_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_xcp_sysfs_fini(struct amdgpu_device *adev);
 
-#define amdgpu_xcp_update_partition_sched_list(adev) \
-	((adev)->xcp_mgr && (adev)->xcp_mgr->funcs && \
-	(adev)->xcp_mgr->funcs->update_partition_sched_list ? \
-	(adev)->xcp_mgr->funcs->update_partition_sched_list(adev) : 0)
-
 static inline int amdgpu_xcp_get_num_xcp(struct amdgpu_xcp_mgr *xcp_mgr)
 {
 	if (!xcp_mgr)
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 8a74b954855e..86f0eaae5274 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -63,123 +63,6 @@ void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 	adev->doorbell_index.max_assignment = AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT << 1;
 }
 
-static bool aqua_vanjaram_xcp_vcn_shared(struct amdgpu_device *adev)
-{
-	return (adev->xcp_mgr->num_xcps > adev->vcn.num_vcn_inst);
-}
-
-static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
-			     uint32_t inst_idx, struct amdgpu_ring *ring)
-{
-	int xcp_id;
-	enum AMDGPU_XCP_IP_BLOCK ip_blk;
-	uint32_t inst_mask;
-
-	ring->xcp_id = AMDGPU_XCP_NO_PARTITION;
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)
-		adev->gfx.enforce_isolation[0].xcp_id = ring->xcp_id;
-	if ((adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE) ||
-	    (ring->funcs->type == AMDGPU_RING_TYPE_CPER))
-		return;
-
-	inst_mask = 1 << inst_idx;
-
-	switch (ring->funcs->type) {
-	case AMDGPU_HW_IP_GFX:
-	case AMDGPU_RING_TYPE_COMPUTE:
-	case AMDGPU_RING_TYPE_KIQ:
-		ip_blk = AMDGPU_XCP_GFX;
-		break;
-	case AMDGPU_RING_TYPE_SDMA:
-		ip_blk = AMDGPU_XCP_SDMA;
-		break;
-	case AMDGPU_RING_TYPE_VCN_ENC:
-	case AMDGPU_RING_TYPE_VCN_JPEG:
-		ip_blk = AMDGPU_XCP_VCN;
-		break;
-	default:
-		DRM_ERROR("Not support ring type %d!", ring->funcs->type);
-		return;
-	}
-
-	for (xcp_id = 0; xcp_id < adev->xcp_mgr->num_xcps; xcp_id++) {
-		if (adev->xcp_mgr->xcp[xcp_id].ip[ip_blk].inst_mask & inst_mask) {
-			ring->xcp_id = xcp_id;
-			dev_dbg(adev->dev, "ring:%s xcp_id :%u", ring->name,
-				ring->xcp_id);
-			if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)
-				adev->gfx.enforce_isolation[xcp_id].xcp_id = xcp_id;
-			break;
-		}
-	}
-}
-
-static void aqua_vanjaram_xcp_gpu_sched_update(
-		struct amdgpu_device *adev,
-		struct amdgpu_ring *ring,
-		unsigned int sel_xcp_id)
-{
-	unsigned int *num_gpu_sched;
-
-	num_gpu_sched = &adev->xcp_mgr->xcp[sel_xcp_id]
-			.gpu_sched[ring->funcs->type][ring->hw_prio].num_scheds;
-	adev->xcp_mgr->xcp[sel_xcp_id].gpu_sched[ring->funcs->type][ring->hw_prio]
-			.sched[(*num_gpu_sched)++] = &ring->sched;
-	DRM_DEBUG("%s :[%d] gpu_sched[%d][%d] = %d", ring->name,
-			sel_xcp_id, ring->funcs->type,
-			ring->hw_prio, *num_gpu_sched);
-}
-
-static int aqua_vanjaram_xcp_sched_list_update(
-		struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *ring;
-	int i;
-
-	for (i = 0; i < MAX_XCP; i++) {
-		atomic_set(&adev->xcp_mgr->xcp[i].ref_cnt, 0);
-		memset(adev->xcp_mgr->xcp[i].gpu_sched, 0, sizeof(adev->xcp_mgr->xcp->gpu_sched));
-	}
-
-	if (adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
-		return 0;
-
-	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
-		ring = adev->rings[i];
-		if (!ring || !ring->sched.ready || ring->no_scheduler)
-			continue;
-
-		aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id);
-
-		/* VCN may be shared by two partitions under CPX MODE in certain
-		 * configs.
-		 */
-		if ((ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC ||
-		     ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG) &&
-		    aqua_vanjaram_xcp_vcn_shared(adev))
-			aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id + 1);
-	}
-
-	return 0;
-}
-
-static int aqua_vanjaram_update_partition_sched_list(struct amdgpu_device *adev)
-{
-	int i;
-
-	for (i = 0; i < adev->num_rings; i++) {
-		struct amdgpu_ring *ring = adev->rings[i];
-
-		if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
-			ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
-			aqua_vanjaram_set_xcp_id(adev, ring->xcc_id, ring);
-		else
-			aqua_vanjaram_set_xcp_id(adev, ring->me, ring);
-	}
-
-	return aqua_vanjaram_xcp_sched_list_update(adev);
-}
-
 /* Fixed pattern for smn addressing on different AIDs:
  *   bit[34]: indicate cross AID access
  *   bit[33:32]: indicate target AID id
@@ -691,8 +574,6 @@ struct amdgpu_xcp_mgr_funcs aqua_vanjaram_xcp_funcs = {
 	.get_ip_details = &aqua_vanjaram_get_xcp_ip_details,
 	.get_xcp_res_info = &aqua_vanjaram_get_xcp_res_info,
 	.get_xcp_mem_id = &aqua_vanjaram_get_xcp_mem_id,
-	.update_partition_sched_list =
-		&aqua_vanjaram_update_partition_sched_list
 };
 
 static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
-- 
2.17.1

