Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21FCC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 04:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F3DF10E319;
	Fri,  6 Jun 2025 04:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kzX+2P4k";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF16B10E319
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 04:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsDdsHZtwIktyoxr6P5RXFm8qOsg/0uY40sdcvaO5IhJ633CdzX/ZMrxBZdcmyRFFExxSnHnwgqoD++ktIeQcy/tQooSMueGWc/Aaa6qNUhZW8vwS50B4QawfrS8wjHYfu1QU5YAHe2FoEednoMOoGOtbdLo5N3LGO9VC+/4sO88xpzgZWGA3KPXyWHWqwhbGGAG8mGc7jWRL6iJd4Kyg0S38W/BlpxS5t+PuFLh+h8en4XpiQ18258ydtmkruSEfy78Tkw52N1MJuIKp8isz59l9BmGODY69q8e4sjM26f19ypJh2azSUkSpikyEwz/ceU1nmK6QPIqQIgJJnlsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjMtzmnOVyDCJKm97VHACwFzPIXWKdnlPCi2E7CuLXk=;
 b=r5sUN0d50KoOQmkEK+XtyPc7UUpBgKhk2x2R7egVdTTSwEH1O/s8aWjMObV+6HSojj2TYklipS3Vcw1FsHEfCAnYZkToCKRETaCCy+SnWTX/V3+zK/htzUT2I3N7Jr5D8vAvjqrRxJ5/PLvOPzNndQnn9jsU3L/OR9SkBwYTfPRgOIqqYHe6WUOh/2YksSm2jfPbd9CkzKjvO0XyPz5hwkACPGJCh/URW4pkv6hIvLzul+TkgnAdUsG51x9An98ewlOiGl5DL2Itg93k3L422kyhpXjSNnHasXVR6F+4ARUJbjbeg+VybWWs+81t//51oP/n+w7SC7KMuv+k8ICzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjMtzmnOVyDCJKm97VHACwFzPIXWKdnlPCi2E7CuLXk=;
 b=kzX+2P4kyRJPyneZcSGuLhj/QwYBuFcHlenb1AgcIjvw+i2iLlnM/hVwf9yXz4dINCBD7lhycRsQZJPtER8lNr0pRwUzU2BeMSAVcaQ7d2ghlIZde1zg950XKYmgXVcLjJoZmOpmREP347wIhIScGXy4wlE5ob5ItVxkugWZP34=
Received: from CH0P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::17)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 04:10:59 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::ac) by CH0P223CA0027.outlook.office365.com
 (2603:10b6:610:116::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.27 via Frontend Transport; Fri,
 6 Jun 2025 04:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 04:10:59 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Jun
 2025 23:10:58 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Add debug mask to disable CE logs
Date: Fri, 6 Jun 2025 12:10:41 +0800
Message-ID: <20250606041041.57630-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: c75031c9-c006-4286-7bba-08dda4b024d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ESfxSnEzIdUVs8y7CZaSq/dZP0vVOguYd/UKcr2WhmZb/OdC91pBJl6Nvhz?=
 =?us-ascii?Q?skKMsWCQ+k6J8pWbdoueO1sgBbUWevcHGkENVHlIIDzkLeoaGf/avXLpY2yq?=
 =?us-ascii?Q?gsa3oyBTFbh0SPAjSz+WJ3j+28+IZ0u84Ess2VBpoZfpc3MFGq3pdyAYoUld?=
 =?us-ascii?Q?QBGlyZLTrDJoZiRbLQunerDqmaK21mmOQCstlO+MMlf3Gk36wdYBjFJ5TkMW?=
 =?us-ascii?Q?JDyNmujU+vCtbrLLXwHXEIil2dL+iiiOFI9vOpH+ahz+p/6xNal7pNofoCua?=
 =?us-ascii?Q?HeBsJTBuQGF05PvQmUorSHYItLwJuEIy7TeH9VhAtwxp6IGVZm5yChEVQ23R?=
 =?us-ascii?Q?KmaeUmwzqZsgTGpwNh0oVrTk2ckDci1Cyx+2xMkb+BDHuT8GGD0SiNW2UjTq?=
 =?us-ascii?Q?dkCjRebfkyuZgKBLaLejNYt9F6W2OVsGyE8ylIPZv5zsDht1oT37eCdF+E3a?=
 =?us-ascii?Q?a1DhhK9KQTQ5RKnjfCqzGDogt6dK5oIj0hhQY7DpxKyaHc3Pyj4MsrrPIdxV?=
 =?us-ascii?Q?veJVhKpiRE0DBu+6cpZkADMBTxS1IEKnz8wjBVyTTpoG/QLkDRSXpJw7a0cW?=
 =?us-ascii?Q?zbRpC+S8vQ7vvf7acovWDghUnDVgO+5Sd6COulV7dK3NiA7MgWxT/+e1tjbU?=
 =?us-ascii?Q?33pVhDtwYNRlnNw5gkvfgQHOilNG+bXJvCnQ9xT9yPfJMqe3hUBVIkQnk5yQ?=
 =?us-ascii?Q?YVrCT/twnxXC06AhhFBtI0tybYKAzCVut1ItjYYAQoeBSx1J1+24gBzcrp6S?=
 =?us-ascii?Q?N76u/Cg2HOueH2fvJyQpaeL68bQhQfPYKx17qqOO5A6LEJaGs+pkomljjOBj?=
 =?us-ascii?Q?fgoOv32xn0mA9A6+fGxvZkvVxY+X/pu8UTQ31RlnHO3KbXCCb9rMKeafuSyo?=
 =?us-ascii?Q?lyq7q2xA2KSkcf7GIFvvv+n72jgAeGznY6g59tyqNl6CPFKYPuCrpcHbRsXR?=
 =?us-ascii?Q?4C7apfXFt25QYN2ggtS6vJNGxjttNLCq4Dc4BXeabCmILYu48KjrJOVr0X0b?=
 =?us-ascii?Q?HX0AVnpkL16hPO0Mb+/EKDuOVvgynZY0o+yWTS68bMU+HZaqYebTzqk9FWRX?=
 =?us-ascii?Q?eyIB8FBkhUylyngWHTYir2+rc/b2KUB5YzpUbklOc6GB1nL8CPI5e64a7CF0?=
 =?us-ascii?Q?oPwvWkrJK9wkAcXZ6n4VIfCZzx5JH33kJVOrJ4AnSGuDs0qrZcVAxUr5SEyB?=
 =?us-ascii?Q?xi3eOzMObnQ//rLpEyGWKIdx6vozKC8A/UWcN4X+Ih6KDgPsqnO+amfGAPl9?=
 =?us-ascii?Q?YKKSWX62PKYEUHTdTruTEjUg6NB1RvV1MdPWPihpL8aU+2OmjGMPGvYRE2CJ?=
 =?us-ascii?Q?gQjdtW3N2Dj0PXhUFmKAIMHqn+Pmkq0UoZ8aX8kxBePlfzsBgb+aW+mm1AQx?=
 =?us-ascii?Q?S8w9jY0IZf6OhxIc5lvtO07Y8pM2wo407KADZyuqR56J2ffF6FyyQ2c4/ftF?=
 =?us-ascii?Q?T6mbmkDeVgeeMpoY0rTMlydjL0Lyf7WBr71Ego6o8sgDK1GATkqx0WeHnChc?=
 =?us-ascii?Q?VIbehAN59uStb/T4ZRjlW0lupPTBaQ8TutNb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 04:10:59.5304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75031c9-c006-4286-7bba-08dda4b024d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121
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

Add debug mask to disable kernel logs of RAS correctable errors,
including both ACA and CE error counter kernel messages.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 4 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9f7284ab5ab6..d0982dbce31a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1309,6 +1309,7 @@ struct amdgpu_device {
 	bool                            debug_exp_resets;
 	bool                            debug_disable_gpu_ring_reset;
 	bool                            debug_vm_userptr;
+	bool                            debug_disable_ce_logs;
 
 	/* Protection for the following isolation structure */
 	struct mutex                    enforce_isolation_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 3835f2592914..cbc40cad581b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -115,6 +115,11 @@ static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int total, st
 	u64 event_id = qctx ? qctx->evid.event_id : RAS_EVENT_INVALID_ID;
 	int i;
 
+	if (adev->debug_disable_ce_logs &&
+	    bank->smu_err_type == ACA_SMU_TYPE_CE &&
+	    !ACA_BANK_ERR_IS_DEFFERED(bank))
+		return;
+
 	RAS_EVENT_LOG(adev, event_id, HW_ERR "Accelerator Check Architecture events logged\n");
 	/* plus 1 for output format, e.g: ACA[08/08]: xxxx */
 	for (i = 0; i < ARRAY_SIZE(aca_regs); i++)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7249f815feaa..fbd0e3a030de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -144,6 +144,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_DISABLE_GPU_RING_RESET = BIT(6),
 	AMDGPU_DEBUG_SMU_POOL = BIT(7),
 	AMDGPU_DEBUG_VM_USERPTR = BIT(8),
+	AMDGPU_DEBUG_DISABLE_RAS_CE_LOG = BIT(9)
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2302,6 +2303,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: VM mode debug for userptr is enabled\n");
 		adev->debug_vm_userptr = true;
 	}
+
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_DISABLE_RAS_CE_LOG) {
+		pr_info("debug: disable kernel logs of correctalbe errors\n");
+		adev->debug_disable_ce_logs = true;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6565dc7ff9cd..505850f415ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1107,6 +1107,9 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 					      err_info->de_count, blk_name);
 			}
 		} else {
+			if (adev->debug_disable_ce_logs)
+				return;
+
 			for_each_ras_error(err_node, err_data) {
 				err_info = &err_node->err_info;
 				mcm_info = &err_info->mcm_info;
-- 
2.34.1

