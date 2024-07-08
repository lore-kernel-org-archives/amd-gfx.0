Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F111C3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 17:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20EA810E0C2;
	Mon,  8 Jul 2024 17:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jVdpyoqQ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD2E10E0C2
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 17:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kW2SKX34bayFhiMaadcJ5F5/H77O+IrblGNTJUlM42TQJRXM8X75mk+0iEWJgodoqrwbhmpiJLqkYVFebsbrsmncTdbLfbmQZqWrLJXNldzvkn4CWHDJGNvoCBS5g/geK9mCqumFu8cOq5GW6mBmZrio1Y6u+yW1KIPEUljtvz/tqb7gW1yJEMl15NLZB1/JxpjI6jhFuet5MYoBI2oDyQ/jU3o8IRne/V5oo8UrtscB5imxliZJr0cP5nbprcxNCnNlyGIia4Uhcun2KPSlEh12Usq/diXZKP/ZAJZXqjzrKw/Plla/GLhvGdavkrx8OhEnGszjxt/LZLXBSXJdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nr3eVebY+Ofl4H44lFYpHekovMOIQ+q2S7Xq3IwGeT8=;
 b=RejcBsB3JWyYAhCvsu0l7nxD6N8I0KV1ciepc9/fT9Suw+LbUSVzSl/fV1G3HhR5kcKOvdYUemhKTQQmW5l/jo8GWQ00dXXAEasWquN7L9zuiMHV7/S046ExiNAqpuHjp/nUlakHBCEapw7JyOGbJANWuDAv9++NfZWqLsRqVolrOpRzEiPyP+SfEofZHWGcjT3hGASzr6PxmKGdhep6iuDZT1xK7NQxsoyoBaVcUHlYjpAM7W2E0nDBWG666RdHc2CK5+NL+CBVDQVhzt+t63Bjx7x9OPaOrvDMY1TpCqgbHXC/V3j2HnSr+5BeNS+JmzOvOJuQwOF1Ti8npqTfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nr3eVebY+Ofl4H44lFYpHekovMOIQ+q2S7Xq3IwGeT8=;
 b=jVdpyoqQGDzMz8w/uqJ/8xu5m8IxgnUkyI+fdxWyQtaC6lMfoaVHTrmbNWJEnZar1sbBzH8UuoIPGPImVUiwdjCFMxUiwOwCKF6TbS2ORy3FkLRQfHWeJZBJsbYgci8KVRWksDZFP6Lo2Y2bSUUXTgjtLMtjGOqQ9ShWNkoWTqg=
Received: from SJ0PR05CA0166.namprd05.prod.outlook.com (2603:10b6:a03:339::21)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Mon, 8 Jul
 2024 17:21:00 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:339:cafe::11) by SJ0PR05CA0166.outlook.office365.com
 (2603:10b6:a03:339::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18 via Frontend
 Transport; Mon, 8 Jul 2024 17:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.1 via Frontend Transport; Mon, 8 Jul 2024 17:21:00 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 12:20:57 -0500
From: Gavin Wan <Gavin.Wan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Gavin Wan <Gavin.Wan@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID <-> req mapping.
Date: Mon, 8 Jul 2024 17:20:24 +0000
Message-ID: <20240708172024.1951-1-Gavin.Wan@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8c2023-93d0-4b76-4a11-08dc9f725670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cE0kMd5Y6mp06iyM6j9Wv++uNEq6AMVVBmhYnZPhlva8ThCyeknNH00krfX+?=
 =?us-ascii?Q?zF1Dn+j5cHv3fRJFNL6i809h5x53eGtCIDGSlMefBy34oPsh5YkYTexXmIn4?=
 =?us-ascii?Q?D31Z44fhpPY+RbxnOc4yEAikncrcpt/Q5zc7NOxnTWZ5k4w5KW9o3T0DSMul?=
 =?us-ascii?Q?seOXWup7cXYYpN7nQAJraIceAdW8andEgh7U0F05nGEUhP926SnGeBtDIZzj?=
 =?us-ascii?Q?JmjTi8d1TnaDq7Rmu7aYK41iFxtL3v4809Ssa+r2Dh08iTt4/mosnQWDSxxd?=
 =?us-ascii?Q?AcJr2RzDiUGgqn7UCHrBnN5uT7MLmIWGTB8Zhi+Na1Wb9v2zInsk3zkIhS1U?=
 =?us-ascii?Q?/CfQxA/Ce0Prwu75q66rOYf+MH58erT83VxeLFD05KldHRsEkDTOd2Y3VlkU?=
 =?us-ascii?Q?wYq0PObklrqCW+3uzJZdEkkUmFjUWRx7eUQgoF+8O2AtUm6dwAh3gyfwgFR6?=
 =?us-ascii?Q?BW8Q0R+oOUidzJPFIdY6QnKaw6iBrnkxQE91Tht0vqtVrm/GmO1VEgy+ZXd0?=
 =?us-ascii?Q?fjKl6iaL/J7GkAmx6oP57JB/WlP19by9qT23o8m9ScKAfslRMIQGx/rOHood?=
 =?us-ascii?Q?EI2msNq91TCa9IHFCJXmWhhSWNExcTJcBBfOTPWC4e0wF19V2z+Q+wWg/BKm?=
 =?us-ascii?Q?Dmj0u6FvqXEY+Omakn32IetdEzz77QtE3le8M4/pW2x7UyvKzv7y/tAtQOvP?=
 =?us-ascii?Q?3CI3uoslHU/owUFW+lMPH2b//SQoHXYDblurF18xygr28OIVxOlGkkwlsoLY?=
 =?us-ascii?Q?8QOtFD0ZdC3sh7bbow9RCViC38u2T6CIOkpqe79Fx421fCGZsgXiXoY5Y62M?=
 =?us-ascii?Q?UulMxt/CFNcAAM8cvwpBkzX52fCaCbSwIHvrhfvc88BdtoizVsMsDFnPP+4f?=
 =?us-ascii?Q?rlNlRcIsRh4+gWFxAri2AHWTAtwx/X/TIPhlfj+xFc/oajkwwJeP92rxuqU0?=
 =?us-ascii?Q?6lf4J6HgjnbT31hhqaxQUsAqvc0O0SIN5IuYvil4QIepbTIU75RMqZEto2X2?=
 =?us-ascii?Q?bszqvkasAw/qn19DLHK3DPMTKFIagponjxzjBwz8tonBYmlCt7WkeFi0KKkc?=
 =?us-ascii?Q?lE3qUGgGyYro//0n7RC6MsWJp09Gd1dZBUwSjTVtylbpDE6Jqh/AyG1M5HUU?=
 =?us-ascii?Q?H5iJUyF5M1roRg/QN7Om/Ec4FyalxImy7gdjlMEOI2ZcLRTUNNJDzj6BOPEg?=
 =?us-ascii?Q?TsZT9FAE3yqhqBXQB/JYgMiclhEqZ+EsTt+HBtjM1TI/sDBKQt2W3K2p59yW?=
 =?us-ascii?Q?OeX0Hk5h7dUKUL1DFHSGE7dApZKphHwVQ3cC0389tQ+iJE5zYR/sOtYlIxDc?=
 =?us-ascii?Q?zY5xgFPxaCb2r9iNmGI2MTSv3QjRh+M51L3uCCajS6bT+YPp2I4+1lgQrKfY?=
 =?us-ascii?Q?xmGSwbPGEbZ3mc+ZNN7XLfZeVPK+biDesBt6A7hBEZAaAx+1Xw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:21:00.2086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8c2023-93d0-4b76-4a11-08dc9f725670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
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

sdma has 2 instances in SRIOV cpx mode. Odd numbered VFs have
sdma0/sdma1 instances. Even numbered vfs have sdma2/sdma3. For
Even numbered vfs, the sdma2 & sdma3 (irq srouce id
CLIENTID_SDMA2 and CLIENTID_SDMA2) shoud map to irq seq 0 & 1.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Change-Id: Ie850114932ca98ea3c9176370dde5dd393ddf7e7
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fec5a3d1c4bc..4516cb0b3ae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -82,7 +82,7 @@ static unsigned sdma_v4_4_2_seq_to_irq_id(int seq_num)
 	}
 }
 
-static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
+static int sdma_v4_4_2_irq_id_to_seq(struct amdgpu_device *adev, unsigned client_id)
 {
 	switch (client_id) {
 	case SOC15_IH_CLIENTID_SDMA0:
@@ -90,9 +90,15 @@ static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
 	case SOC15_IH_CLIENTID_SDMA1:
 		return 1;
 	case SOC15_IH_CLIENTID_SDMA2:
-		return 2;
+		if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask == 0x1))
+			return 0;
+		else
+			return 2;
 	case SOC15_IH_CLIENTID_SDMA3:
-		return 3;
+		if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask == 0x1))
+			return 1;
+		else
+			return 3;
 	default:
 		return -EINVAL;
 	}
@@ -1541,7 +1547,7 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu_device *adev,
 	uint32_t instance, i;
 
 	DRM_DEBUG("IH: SDMA trap\n");
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 
 	/* Client id gives the SDMA instance in AID. To know the exact SDMA
 	 * instance, interrupt entry gives the node id which corresponds to the AID instance.
@@ -1584,7 +1590,7 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amdgpu_device *adev,
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA))
 		goto out;
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0)
 		goto out;
 
@@ -1603,7 +1609,7 @@ static int sdma_v4_4_2_process_illegal_inst_irq(struct amdgpu_device *adev,
 
 	DRM_ERROR("Illegal instruction in SDMA command stream\n");
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0)
 		return 0;
 
@@ -1647,7 +1653,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 	struct amdgpu_task_info task_info;
 	u64 addr;
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
 		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
 		return -EINVAL;
-- 
2.40.1

