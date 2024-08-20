Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F780C5320E
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 06:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB6510E4C5;
	Tue, 20 Aug 2024 06:05:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mi8Vctit";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A7DC10E4C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 06:05:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2rbGvWR2Z6ANr9aK8/mYsk4ilJIDCVUOAkZaVhI0uMwbTUTSH/Es9tfFGk6rYBSscphfWdkstB7Cky1Hat/sYIg1cLALjZSVMgkp/ImFSTFhsIY6Jfmj3kV30/W0NbuB3+EAmunIPXns0NG4QyyMp+sV1ZAvIXft6hN+9prQd3hTU9TBPaaJhD6ef+RWnVQiJSlb1pyypUnrNv9C4HIVOTrdB/5IMYmN+eQxBJJehYhi7LbUuTu8G0TUtlqo3wTeUx3t9/1VwOlAdJU/kgZ5owgbO3zU6hhV1J7xEK12GmuiPYDJuAarfygHyIyqh7Xmdvqp0mhnbJ1jwj3HCueMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsgMQOBJem5zbALjg1PQpx0MfK2PcBEjlCiAraGLUcs=;
 b=VU1GGTm93qeB3pRdb6Z/T/8oZ0XoDPXTvIQfBeK7pdCp4Kpkq6B6dtvWFbKM/tHGNezhsR/Cn7mQRdSaH3gb/qapr+bXL+X68ygEWJGk6PKwZ+x3uvYnoM8ceVbC8fac2gsK6mI+ecY29VTb7Y8qMLAeTi9Z9Q9Eu1OSmxlT87goyiPYwJpE4tATH9MMb/UI0DcQE0iNUvvkzbhwT7pXQyu6EOHk5BagwvOzHlu7WF83pZpvwYjA9FIXdgsVd9npKnx+qY1U/+d4ZNd7b4JorJzXhiZOiDZ1S88GrJ0Bi5DEq/oD7jj85b7KYf/vxW85G6rtZNgxeO4/S+Tbk6e1LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsgMQOBJem5zbALjg1PQpx0MfK2PcBEjlCiAraGLUcs=;
 b=mi8VctitMLGhi78OIK+cjkFohAiV7tMw+wm8gsz9fZfLYmabppNz9Q9mDjNneYuUlurTR0klOvgi/MZKeAhzdCQtwT+XzemjIRBhOfFbLsdH0RA9tzlI9yn3cGLC/+OB5mI2qGkMRoUfs3yVFZsyzzUEnNEP8IkekS9BfVeMr6I=
Received: from BN9PR03CA0639.namprd03.prod.outlook.com (2603:10b6:408:13b::14)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 06:05:18 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::42) by BN9PR03CA0639.outlook.office365.com
 (2603:10b6:408:13b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Tue, 20 Aug 2024 06:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 06:05:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 01:05:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 01:05:17 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 01:05:16
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Shikang Fan <Shikang.Fan@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: Check int source id for utcl2 poison event
Date: Tue, 20 Aug 2024 14:05:07 +0800
Message-ID: <20240820060512.16061-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c54b385-f0c1-4255-998d-08dcc0de114c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HDCYTVZpfJuzUFFsSZpnQqBrMDwuY8lmNrYHp5oef4USGHzbbl+OiXXnOwcW?=
 =?us-ascii?Q?X2NdVX6eTAawRmKGO7oVxBZm7PIdy84AViM4ZfvNfVm0ph02rSIzjQM4P8/Q?=
 =?us-ascii?Q?dxnFR41Ga7bC5kw2SrAu0fnmOF/cZdsH1uRWCBGt5JRqn3lH+vznvLBrY084?=
 =?us-ascii?Q?uH9sumViFAhkc5guilhwkZFtuc3n+varfeHiLWbRCjIwKeP1et0tmvRI2bka?=
 =?us-ascii?Q?UQsn3SSp1d8r/P75OmB2qsuQhnLkh54bKb/OIwFYMMU4Ej5PEoVPd0/UVTwN?=
 =?us-ascii?Q?qsaihTuuQwxLSTR8KQMcVNIdpBexZ6rLwdP7kuu+rg4bwaRLOzclAOQ4TntC?=
 =?us-ascii?Q?E/oH7kmfICCFwzfSr3LPCYMRSzp4wN+O/MF834wv/NPirIQgZ5JjV8slQzNZ?=
 =?us-ascii?Q?wiWQJFvoDyXuEJ0VU+S6TJXJWray5xAKh+ua+oKo+3P+TFGfyZjYCpafVvXs?=
 =?us-ascii?Q?4N387Htrn0YKLSZW/bnthw65qj+NH0BVETa/qZD6uElcsVGUR/rFvBkMsins?=
 =?us-ascii?Q?ZHAuHF/M1CAUWGmXt/8tRvOoiB1JcQU77RGE9P5RLVCUawARmeVx4n3zdb+4?=
 =?us-ascii?Q?R+NuLx2z1DVl0Av3Ahn9GxVCUNeNgV63CrCM2Ja9hyu8pNG6GC363xcqqllt?=
 =?us-ascii?Q?tFJgkrLKaTh0YoHeQL5IS6b9Nlwa0czkZuYXdNVL4HYr/m+5t+9dWlnMKkhw?=
 =?us-ascii?Q?y/e1Hfwiy9V4a37X3FPPjDiZs8QHI4Vy/H3/d76LIst7QU9hLSG8mLXPB+5p?=
 =?us-ascii?Q?p8iVkWmPyG45pjadipaBDk6Zu5aui5qE4giEQPQOf6qD4yoxML26n/cRICrG?=
 =?us-ascii?Q?0klsLCvBeRdkc6io8PEJ9lEjquPo6t3MheGYpTpqJ8rpTBzVUotLNNZndJco?=
 =?us-ascii?Q?ad1x/gcnPL7xV+jQ1nocseU/PFvNwa60jFKQBLM1wh3Deu24sbi3facOtysD?=
 =?us-ascii?Q?hd1SITSA91kx4Ps9bxt4fPraHOaVlNSIVYGIHNe33QZd81q4k1FyxJ/B8eTi?=
 =?us-ascii?Q?aVa4GJx2fmPAGjredc2BU9zStOe88yB3YHij7JWOwWXP4sDOhbG/5NXYHe5G?=
 =?us-ascii?Q?rtzwgXPIggegDvfSwcdt3eKPRQY5p6jY1ApxODRDtr7WplE2te412E65QSbS?=
 =?us-ascii?Q?u0BMqI2ZAGB24uHwf4/jACWg/481kxn6bZUq07Qa1APR+u+oNJjvPo3soa6Q?=
 =?us-ascii?Q?FFW54iSm31a8SVxBb2p/9ZoSVGX0lFW/jF4JcRr3qH+DS62xv8pTuOoyj5Bm?=
 =?us-ascii?Q?d4bVFwY07+epyLt8TmRcGZDyPJUPv0MzDNDb1MEbftDYdeMbNaZYPUZwjPGv?=
 =?us-ascii?Q?j4Rg14lbxIoTUmiDyTH5pUjSrkCz1RonS73Sqb466ZdghHVe+l0HBVVBbx1S?=
 =?us-ascii?Q?3XBJanwiROlQnhh3dNoqoTcIcwkCqHOelLZ4wC2p6D2b2t+HjwfTUp7ruN+l?=
 =?us-ascii?Q?EV5MzSKYL8dLGnTT++uPdFim4dslCPsN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 06:05:18.4491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c54b385-f0c1-4255-998d-08dcc0de114c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
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

Traditional utcl2 fault_status polling does not
work in SRIOV environment. The polling of fault
status register from guest side will be dropped
by hardware.

Driver should switch to check utcl2 interrupt
source id to identify utcl2 poison event. It is
set to 1 when poisoned data interrupts are
signaled.

v2: drop the unused local variable (Tao)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c    | 18 +-----------------
 drivers/gpu/drm/amd/amdkfd/soc15_int.h         |  1 +
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index a9c3580be8c9..fecdbbab9894 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -431,25 +431,9 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 		   client_id == SOC15_IH_CLIENTID_UTCL2) {
 		struct kfd_vm_fault_info info = {0};
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
-		uint32_t node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
-		uint32_t vmid_type = SOC15_VMID_TYPE_FROM_IH_ENTRY(ih_ring_entry);
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
-		if (amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev,
-					hub_inst, vmid_type)) {
+		if (source_id == SOC15_INTSRC_VMC_UTCL2_POISON) {
 			event_interrupt_poison_consumption_v9(dev, pasid, client_id);
 			return;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
index 10138676f27f..e5c0205f2618 100644
--- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
+++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
@@ -29,6 +29,7 @@
 #define SOC15_INTSRC_CP_BAD_OPCODE	183
 #define SOC15_INTSRC_SQ_INTERRUPT_MSG	239
 #define SOC15_INTSRC_VMC_FAULT		0
+#define SOC15_INTSRC_VMC_UTCL2_POISON	1
 #define SOC15_INTSRC_SDMA_TRAP		224
 #define SOC15_INTSRC_SDMA_ECC		220
 #define SOC21_INTSRC_SDMA_TRAP		49
-- 
2.17.1

