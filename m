Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBD0C87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 18:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3926410E313;
	Wed,  6 Aug 2025 18:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yzlP1dUP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6C110E308
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 18:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/R8Nk5OdebndXYVabK7qepjlvm1bL8TLqP82uz0zA3ve8VVBbObdA/yRUDudYtarCcz315rLbDfxZp2Mo+/HVKpSaSZ6NXWFFSZ94IbdC992GofKBZgzd3Eq9PCr8s/MyQnFMchg0exTAehAy9Rlb+eV/uJ7uQUSTETry0LlDheId7cV8ae1EkNB1mQSP2jqNseozeRcNfYRfKv95h2c0Gq/Xwc0ahNRvIozy5nrLczXtSVLFZkKEd8Vl8IWQMiBGk9RavdG5gpYDbpMvDctPRjLb3BeOYq8ZWGU92UUOCBkD4bRgUxOCtGDKNZqDg1MDRbOKROjIGRW710Q5SaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+b8UzJuc6ZHuXwmF3p3etQTagkeCDUfPpVpE3uvbbs=;
 b=PaylBwRxdiZK6wSb1d6OXyXiROzTg7VFH8RscPOr8wlDch7eSApQtQKYbGG3BwbbvDiuCKnip/TEdoHA72Lbx02vOwiLRKJ43fttjMg4BvGm8ER8B9950a/3l+KrYbRegkyVw3exeM/iXJFme4raOTLHYsokPfw6aVvlRn0Gui2GZO2zBAd+NjdFgokenQtaOy78vmM/d6Jz6HQvTFi6oCYr+rYhlE30ubX8H6aIsPnVWB6rVoGlqhpNdZHGZB/oLOgdrMq35jCElO0x3wab2XhAWAzmAuiY3+X9j6+euEZd2RL33+ZxnI7Y3RCP1zp2Np3GGjdUAkdF/Bs+dPaC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+b8UzJuc6ZHuXwmF3p3etQTagkeCDUfPpVpE3uvbbs=;
 b=yzlP1dUPoNPA6lx22XwvICJN204a4rSlLhCpQS0nC7xW9pu08m1yTNmeK2XRNYpEO/2QIoFlpjV7xca4QI5AxFgYd3QQiSauBs1RqGMYlHHKmFRdJRaGZOwhterrR1KCiDIirg0G5XBYP2/NT/Dx4Oe80XK70CvejiQnQ7mAp5w=
Received: from MW4PR04CA0323.namprd04.prod.outlook.com (2603:10b6:303:82::28)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Wed, 6 Aug
 2025 18:32:31 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::40) by MW4PR04CA0323.outlook.office365.com
 (2603:10b6:303:82::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Wed,
 6 Aug 2025 18:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 18:32:31 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 13:32:22 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/amdgpu : Use the MES INV_TLBS API for tlb
 invalidation on gfx12
Date: Wed, 6 Aug 2025 14:32:10 -0400
Message-ID: <20250806183210.316953-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c6200a-a896-4e27-94ac-08ddd5179ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|3613699012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?39Zm6y3OjxnkE5jtnQ9V3wEgjNr119TwZ7r9qpeFeOmR83hR1RLZezbcxj2q?=
 =?us-ascii?Q?pKUEUsE01cycBqszR0odgfv5G8ecHhcykbfi1n1jkPUd3pMODXZeMDOrzcPD?=
 =?us-ascii?Q?VMYJQPHOr6BrOHhbGns8rzi00919AasHtd/9pmS2lUBzZ1kReRGoXK6z/64Y?=
 =?us-ascii?Q?Q+gRcPmHjLvZWHqK0r7cz/qfthN3b0AWcZMNs/SEOdEvQcgKNy4QAMGpZxEz?=
 =?us-ascii?Q?ewAU7tA8evdZf/2JlxLQemYVoVdixhave5BdyBYR9tK6DMKCXN+kiTqbxLtY?=
 =?us-ascii?Q?20GpahKECxv4n+xfBzLDCPlJKHObexsQCDnK94EPGfQYOOpvQomE7hgvHN7n?=
 =?us-ascii?Q?juY/yuiPX3/gsy+TMi8lUuDEY5PxJ3FYY00iG2fgx+zGcn4pRuIzjg2xXWFL?=
 =?us-ascii?Q?Db6moLOGFnyfSE+1QIBT0z+r1GC01z2pADNJ21gictv7jVAeqWOOhZHga7pA?=
 =?us-ascii?Q?phNi2c1Y5UV/qtLFNOrVwzAfeLEfBeTSSrSYmwzxh6HKe/x5gzPZNwZ6dwnC?=
 =?us-ascii?Q?H9M2VvTmaUSZPCGuA0w+OwEZhcB89FkBMjBUlU9NYPubXQJttC69iBGKW3jz?=
 =?us-ascii?Q?hkqKVRl2Qy/l8dsqgt7wXJK/ePEsRTbIswSdjxnqkwSVm4Rqo+lBWobbn9dO?=
 =?us-ascii?Q?h/XgVmAKeB0IWq9D+AUjd6IQQetrEGE1hILc23G1dRScxmkMmOUXk/i42Ppb?=
 =?us-ascii?Q?G4vzMx7PM9BAsGrvetY6m8CPdKlNq6oJVTmxY+rbXrMh3K9hcdKodEQhJVm+?=
 =?us-ascii?Q?DlOqvHdKFLO9Nc1iz/oKLjgHar9kuyEhWrunp+GWuMLdWzkG8f7vpvh+opRh?=
 =?us-ascii?Q?ER0oBkmPjwqULwVSu2jcEK/usTDGW4iKcx+zeDsv0rpiZVI83S4JdywXMEmV?=
 =?us-ascii?Q?My0TqMqadNfOsJggnjqnsbSYOhANbPCg4r4HWehXVV4BDuWIja061/Y1k/EN?=
 =?us-ascii?Q?7eKLtfpa/QMfrzw/OKIG2iwdvv42p7kUSJHTYZlIySS3qlWCc0lmOixac/XI?=
 =?us-ascii?Q?PQFT8/Unh82x5EEK1hHABFnDSNm13pQhaCxjSRJ6ncyvpkby81wNtPcHBH1N?=
 =?us-ascii?Q?HxDEpyn8ue3morGh/CngWxwUOF4ABJ6Zu6fnxIWd9fBXUp1HX5mzQRL6wCtn?=
 =?us-ascii?Q?92O/bHXRJOo1dlZhNW+278ayEjPIsmWOs2+BMDmefFYS+qsmeM7zFwj06/Ee?=
 =?us-ascii?Q?QS2sY+Peud8Zz6W2U4c+Mo2ilkVPabmD/K4MQ+GxcYLCyeteeWJc04PSEuR0?=
 =?us-ascii?Q?auz+EJTz8Mb110/1L3DXNEeXEmpZS5waXxD7Zs9D74e1yK3/Bnm0q/PTqOT9?=
 =?us-ascii?Q?EvCgiw+PkUsacjCNI4QU61vyxEQInk97vsfuzyIb462YoNpR001MTF6KHrZd?=
 =?us-ascii?Q?A8macs4oAfG8tzqNMSAIFnmiDkfgYOaxxiHBa7WbtFR1/pxk7ar9NHhqONuY?=
 =?us-ascii?Q?FCFhksALYGos3tsXc0vEQbWvDQF9oquqsXkfkk+5ZV36Kc71ge2IGVV1WFTx?=
 =?us-ascii?Q?5YmkZjDQHHyiL8em/cbsccWiqLpg7lLA85BNBaWQdCK3VIcSwQZcFVJqOv6e?=
 =?us-ascii?Q?PeSr6wT8oo1VPPZ8V4I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 18:32:31.4956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c6200a-a896-4e27-94ac-08ddd5179ae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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

From MES version 0x81, it provide the new API INV_TLBS that support
invalidate tlbs with PASID.

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 24 ++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index c0d2c195fe2e..489a4a0f0610 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -280,6 +280,13 @@ struct mes_reset_queue_input {
 	bool                               is_kq;
 };
 
+struct mes_inv_tlbs_pasid_input {
+	uint32_t        xcc_id;
+	uint16_t        pasid;
+	uint8_t         hub_id;
+	uint8_t         flush_type;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -367,6 +374,9 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_hw_queue)(struct amdgpu_mes *mes,
 			      struct mes_reset_queue_input *input);
+
+	int (*invalidate_tlbs_pasid)(struct amdgpu_mes *mes,
+			      struct mes_inv_tlbs_pasid_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index feb92e107af8..c65270f7097b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -339,6 +339,21 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
+	if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready &&
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x81) {
+
+		struct mes_inv_tlbs_pasid_input input = {0};
+		input.pasid = pasid;
+		input.flush_type = flush_type;
+		adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+		if (all_hub) {
+			/* hub_id = 1 means  for mm_hub*/
+			input.hub_id = 1;
+			adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+		}
+		return;
+	}
+
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..2e9191fffaf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -108,6 +108,7 @@ static const char *mes_v12_0_opcodes[] = {
 	"SET_SE_MODE",
 	"SET_GANG_SUBMIT",
 	"SET_HW_RSRC_1",
+	"INVALIDATE_TLBS",
 };
 
 static const char *mes_v12_0_misc_opcodes[] = {
@@ -879,6 +880,28 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v12_0_inv_tlbs_pasid(struct amdgpu_mes *mes,
+				    struct mes_inv_tlbs_pasid_input *input)
+{
+	union MESAPI__INV_TLBS mes_inv_tlbs;
+
+	memset(&mes_inv_tlbs, 0, sizeof(mes_inv_tlbs));
+
+	mes_inv_tlbs.header.type = MES_API_TYPE_SCHEDULER;
+	mes_inv_tlbs.header.opcode = MES_SCH_API_INV_TLBS;
+	mes_inv_tlbs.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_inv_tlbs.invalidate_tlbs.inv_sel = 0;
+	mes_inv_tlbs.invalidate_tlbs.flush_type = input->flush_type;
+	mes_inv_tlbs.invalidate_tlbs.inv_sel_id = input->pasid;
+	mes_inv_tlbs.invalidate_tlbs.hub_id = (uint32_t)input->hub_id;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_KIQ_PIPE,
+			&mes_inv_tlbs, sizeof(mes_inv_tlbs),
+			offsetof(union MESAPI__INV_TLBS, api_status));
+
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -888,6 +911,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.invalidate_tlbs_pasid = mes_v12_0_inv_tlbs_pasid,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.34.1

