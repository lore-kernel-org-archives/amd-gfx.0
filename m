Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CABCD5BA0
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 09:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005A610E7BF;
	Thu,  5 Sep 2024 09:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qfna7TVo";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B538D10E7BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 09:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKSlZdMFU1zKtgdR/mPLB+y7xK30kKd5eB5AZf4xY0ns8qyiMm/9OX4VXUh0oVJXJcug+tbTICg+fQs0+8DdyJb4kcfJYMJnIhhrp0l4uUU024VzIecDxTEWd3ckTc4fC2j4QiVt8njsiqjrWRtMFirBwpGwB+diZ7flR9fZ76yjxZtFMYZcjbsm1exOQbHxLEBqrWissb7b7EQRJcuSzDHFRWMzXejOZsdhosEClcKxoUhz7XJsyGTdAyscW86u9wuXzyXfi1rnCfTsO2OxE8YcIt42uYZHqgCL0I46P+zy/Hq4Sn4zewd2/Wf6NlmHIFenFVdUdhianm5LM7rvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+PWcAMB9qpDMd5LE4kYUvISwN8NEiaylDTJLBd45gw=;
 b=Giw5ycf3l+DNGfWu6xY00r6d1IZxjX0dQNJkOX/WxgPvxqyrFc5vyGQ15l9uqn9JfFcT2bw4Qv0AyU/E5LaMoiGD2W9YrflRaCDp7VIg1l0nJCyBoFNbsH5TU9B8f0nj6acqOzVlVOKcogWgDZHclIJ3t5/msk0ZXTGRWw/2JMK5YOJU5e1EJVhFpofZWn+KNbzUnR2d6JX1Xpb8Jn+jLM+miDpARyVkNMikcXD9EhA2r01k/i8BTwk5ihzHhyMY2cqH/tjMDGzkY2sNRSLUu6tdgEZSqcocZBmokWVnsiSfMb4IUDtjItFHeTxMOnWPY1TX3NS88ypXdziwYaPzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+PWcAMB9qpDMd5LE4kYUvISwN8NEiaylDTJLBd45gw=;
 b=qfna7TVohaH8V9pRTl1QPslusHbSOIkH1GK6VgQn+6csBGzpJ7KZclcrjxfVmpRNVhSHTb8X23pSt4EzCLh59ppyylqh27HM1PPh+B8embSfoIJ2KRlrdo0ikFx93FC78WdZJpEpNPiya25iSiGoe65UdGISAaDkcjAGZPjszzQ=
Received: from BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 09:20:43 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::58) by BN0PR03CA0030.outlook.office365.com
 (2603:10b6:408:e6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Thu, 5 Sep 2024 09:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 09:20:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 04:20:42 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 5 Sep 2024 04:20:41 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdkfd: clean up code for interrupt v10
Date: Thu, 5 Sep 2024 17:20:40 +0800
Message-ID: <20240905092040.1054873-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: ef592ceb-85d5-4e35-3308-08dccd8c0486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/tT2FlX0rs1Arp6Puoijgx6eCgMZnDqInYzZcZZwIYNU2xGmyyeHgcWBcgYV?=
 =?us-ascii?Q?pDj4O1eCHZag5v4M7LSMUIpog7+Mbr2yMeg8xsP7W5oQDceyi/SbQLLjcgde?=
 =?us-ascii?Q?KWsk0M6YqoLHs6UTvglify9b/Uni6eeJr222QTMSdATqGDGDVCCzkxjISfzZ?=
 =?us-ascii?Q?5Xl61HWcPqWFX7ZYsSeOHlKXd4RGTql9xVwo5yoJi13bwrWkmsnuqGevxfg8?=
 =?us-ascii?Q?X9iQt4X87PDBTwkSe33rG2+UH59Ts69VUbMyQUUWq7MC4hrGST6IBQB0+lCq?=
 =?us-ascii?Q?SwDy2wUMNtiXBQQ8pc3pSzS2mCf74xXqKDfT7vG60j8FzlAozOb1ghikUDmT?=
 =?us-ascii?Q?x8a4jD4nqzehwtUyZ1XkvQZaeTqWRKZ8mm/os7D0Q6xOKFP2zAZoTRU6ue4z?=
 =?us-ascii?Q?+hL6yjc2aBbQYi9lT4AVcG/JTXHKo9v8GL0B3yJC97DuwgpxhpdsykAFO9eT?=
 =?us-ascii?Q?RhTOzVfxvGbzEriyK1DDcqsbqcdBR0VbDGiJU4cT/rQ8wYqGlXvlc8MIwkrM?=
 =?us-ascii?Q?LTDAxg58WtO1jlp9+yjXUsOHg1QbuCNQYvtY/kr/PV4Ie/O7eNPnODKZqeLg?=
 =?us-ascii?Q?QDfKxN7U+nCVbuKr7+13FZ4I0ELWW9hdGSRX5rhpI8zncnqOsFJqBo1gGmSk?=
 =?us-ascii?Q?U742SmNBphwBrfk5n3iOdlKDuzLFzaqH3vvINoVmitRW2ZZKzpubKABS/40z?=
 =?us-ascii?Q?eJglcGRhC6T5nbpJUkG+orjxd5XYlQWitjvD3e/XlOqrLBotTIVgkeCA+P6f?=
 =?us-ascii?Q?MGQqzUFxBUJNVoiERrh+E7t4t7yjsGel3O310oH4YzF1ddXwtI8WuuRGVg/k?=
 =?us-ascii?Q?jqmdHN1eCNYppgsZC8a8O2CfvoYEERqGXt3X2oZVOp1QbTTXGePOyXiVyz77?=
 =?us-ascii?Q?CY4QdqJ5aJhYb9PXpjHOy28W6tntC8EtyeXQOvp/+1gg/MGQraaMyW0Av93O?=
 =?us-ascii?Q?Ti63MRv/7SbeKBRnLOuTphVWfhCTJ3797kl6hxy0yPDmIIyFZk9dXufs5vIa?=
 =?us-ascii?Q?p68wex1N+6BPbFAmLTlyjo/UNvbX+ds37EXY2JzJQlO4yDLpOA2PAuWBhPYp?=
 =?us-ascii?Q?+4RL+mBqo4W+9hwLSMaxJfaPlo/7pG+Jg1Pq+O2gXJ6thqqtzjOz8UIozILw?=
 =?us-ascii?Q?44N9oKcoW6fwVGRjRHvqc55wf9c6yG+3dvnxsJa0KR4D+IWqK0X7dd2Wa/kT?=
 =?us-ascii?Q?EvlYC+EW+6DEDptpM7xg9Kme3uCVuPMQIkJ1UPQka9rNYsGZQUSBl7gd1uBp?=
 =?us-ascii?Q?C40ce6lLRSRFqOlWc4wvXp6iLa6PvMkmkzem+Fewe/Ayl5vlDvTxgoRM16in?=
 =?us-ascii?Q?0KHqocY19UMOIaNIOBZCeaVKGwb+aHnEmdcp3uj/XudjFG0MTN05zZ3Ojbpj?=
 =?us-ascii?Q?pWFbEtxmTdlOw84Lrv1YHLkYjsN3zPhXjU1QyTfSSj8e0w+2rthiyiYlQ4Gw?=
 =?us-ascii?Q?huRiMgJ81bLnszyWFBW8nBKRw7QvJE6T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 09:20:43.4005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef592ceb-85d5-4e35-3308-08dccd8c0486
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071
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

Variable hub_inst is unused.
Related the commit "bde7ae79ca40":
"drm/amdkfd: Drop poison hanlding from gfx v10"

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index bb8cbfc39b90..2db824e87c8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -308,21 +308,8 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
 		uint32_t node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
 		uint32_t vmid_type = SOC15_VMID_TYPE_FROM_IH_ENTRY(ih_ring_entry);
-		int hub_inst = 0;
 		struct kfd_hsa_memory_exception_data exception_data;
 
-		/* gfxhub */
-		if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
-			hub_inst = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
-				node_id);
-			if (hub_inst < 0)
-				hub_inst = 0;
-		}
-
-		/* mmhub */
-		if (vmid_type && client_id == SOC15_IH_CLIENTID_VMC)
-			hub_inst = node_id / 4;
-
 		info.vmid = vmid;
 		info.mc_id = client_id;
 		info.page_addr = ih_ring_entry[4] |
-- 
2.25.1

