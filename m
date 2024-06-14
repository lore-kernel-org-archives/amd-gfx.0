Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB50FC27C6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 11:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3208510ED07;
	Fri, 14 Jun 2024 11:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0IYZJKjY";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B521F10ED0F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 11:10:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQc/2HXuv+5J3MzHLmj8BHgR/yFaY3h5IhfWgrjG1RUHv9vrfvnXTnFcSJkeI0FfLKrkX2hQVBYUIMkNFxatLHgPik8a8Ltsf2FXPwHZVMjtpPdX4/JJSUkzEnaAwLX/fw5+TGlkPqbGlODNO+0X8xYpv5wSl996uRFfRAbGvSKz33BsBPN5Rfz+fsGrIdBgXdX4vlrtLuRmRUGBFBz8f+gTSm7tpDq7idGsqVerAPqwDyq5hx1dPE2hvOwP2uaddW6OSyF/pKXQnv5af7RMNbIJfTY36rzeBfqwCgcuXEqT/gO/jBr1X8gFP1yM+rIj2G4UKY8vEALKsRrX2d73Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUE3C/yvHEFImJ8tqFeAIea1kxwi11qYchgybM1hXls=;
 b=SYH8QV7FcgV4UehqtEGrT2jXGZjRCVg0cSD099byalMREjWGA+jVkEuHkchS1vB8UiI0UVp5ODCdDnq91KpzSiOszmiqpfdxaAoJi2cY3YzmMckcaMMigFh7XXBGe+VptD1DCOHiEBpofy1VMX9rXjdnYwCQoarmQ6vxUg9eiFkAjsR/LvU6+Xi2uSXMUNnszky8F1a0FQxBHd5FXQW2CVbQPKtcUUV5ABD6zyvuQcYlYfZ/RxYgw3Epc0xnSLDuhudakEU4a9goq8Mk1ttU4Ih5hpwb2I5+SFQm2xtQ0ZjDt68KYbNLbN2b8VkGH5YGasYWxQ2tNpXCUS/+7jbEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUE3C/yvHEFImJ8tqFeAIea1kxwi11qYchgybM1hXls=;
 b=0IYZJKjY9RSqsRgoycoVIdhR7prW9cwqG+lF0Hj+Sqpj7+98Z6VqlGjZxwymliQPaRNqX0GGHZkJnUmOU+wZYdMZmHVFMKaJQX2pyoXaB6/y9pofFK8EWU08rQbdbInyiomLW/TVLrMGgQ+TCimtOLztIO2Nqp0kUtzk9to0cL4=
Received: from DM6PR10CA0006.namprd10.prod.outlook.com (2603:10b6:5:60::19) by
 SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Fri, 14 Jun
 2024 11:10:26 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::99) by DM6PR10CA0006.outlook.office365.com
 (2603:10b6:5:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 11:10:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 11:10:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 06:10:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 06:10:24 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Jun 2024 06:10:23 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Haijun.Chang@amd.com>, <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under sriov
Date: Fri, 14 Jun 2024 19:10:22 +0800
Message-ID: <20240614111022.236072-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0c4265-5be2-4157-2367-08dc8c629791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fA3lMW1LIUuQo+eQS18Nita+zzoDSuluDg5Cw9IXp3ukxCLMSP+VV1PhgXo1?=
 =?us-ascii?Q?zxYEwUWpurTJl1VavLCtAPGMlmWLQwvjqMgqXn5RGGH4iFn+37uC5fv1yiuI?=
 =?us-ascii?Q?sd1UsPpCyHi50blGuTyjaPS4r2FWa540SOt6MuPDOLvewUQdZ6NbFgU09aRq?=
 =?us-ascii?Q?s/7ymwnlbmQFFUlXZpxem+HKOw+oCug/3wrc+jxuLcrzIXM+2lWPYDy3nUW+?=
 =?us-ascii?Q?55fyhiJ6H/r6IfkeQMIa5y9Noci3lE5sYRsezs8caBM67d3y+u3xF5aAp7Mb?=
 =?us-ascii?Q?odKJya5PQrPjD10q6fME7wIbSM0O12lmWheKCW2BgG/z6I0YgSHalCxhbC//?=
 =?us-ascii?Q?NavjmCBH5Mw19F0HQd6ETPe0Uoua2TSzTsgE9HvyESAHQaVG1TjMAc2hYF3b?=
 =?us-ascii?Q?ZEi24zst9lWAorulEUzSF3+uPdDnboPgBM7KmBiZbgu28u8wykBAEQIUQW06?=
 =?us-ascii?Q?WuhoMGT9F0htEtCkN//j2szJO42vHZ7abDvs0tR5PRaXFm7aZBp3NdM7yUe0?=
 =?us-ascii?Q?eF4fkrkdHt/gIOkbktxxIYD0k9retKaJTqJEkdessuwr/aF46CSLMO43VppG?=
 =?us-ascii?Q?t2conw82u8skAEcbHovdeQJaq4h8rB3iR13OSXSmPZtIzSpSQOA9RXESPRhf?=
 =?us-ascii?Q?IhCs3ZQU1DZ4DfsOXZ+xSua2uUr8LmJPFW0UUNh9QpB43A9nGJH+uJot/XYc?=
 =?us-ascii?Q?DlB58AL3F+R/vulj2Xwzh84gdYrDwLmEqcp3CeowBdXPAl5HvvJrMFsTA7vs?=
 =?us-ascii?Q?2a2pPsWUqM18d23a9mdB8ut0lldGomAs8/sO1RRCh6oWixvKi/60ijbgraLS?=
 =?us-ascii?Q?puLHObiQ9VwO9TV1/YZhxgvHUBk5cwbghm1CMFeXCkSzLq1iDteieP8IsSfF?=
 =?us-ascii?Q?r7PPIUz/OOrL/7CfIiIm5Q5/+h7NG4SlfB4EzWuLg+SxftuDuRacu/LkK+G4?=
 =?us-ascii?Q?4gfq4gcZPfZLquq2z74ayniuyCUoDl2BITgWfEtT8ZfteS7kyR5pryXe/Lqf?=
 =?us-ascii?Q?FYbJgvY6s4rK1ZvPCrGJLRdVTBRzNwMASmzl7Si0sEZiIbHTvDyOovq51J94?=
 =?us-ascii?Q?5oFlyPq7KX7dZFW0of8HUQg9GfC52svcngdcIYeI/V8wCnQccKPCBeDRFWp9?=
 =?us-ascii?Q?Bt12IQVAXm/6O4hpjf/dqCGiYdgFUkvsbMCH6GPA0ND3l7yJx+trcAkXYAL1?=
 =?us-ascii?Q?apmwHEuWJP5sfDsltm9Swbwtb51lVYaYrQQ/+J2t53BLykILMuxJjWIBtLZf?=
 =?us-ascii?Q?j6ATa2iOqFbBbhJlcYa6eqFpJdc3T4lDC9mXqS1ehA3Z4KE5IZLNtzP+BkpB?=
 =?us-ascii?Q?heOzwEu86duJXmqsdWProrNVkql0eafRVh7lvSN0mGJTspOMbJOAIjZAVdyX?=
 =?us-ascii?Q?T4DKK0DRdt046qjyJdXqS9tgav8gF6p2BASoJhGgcWEmKmr+iQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 11:10:25.4354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0c4265-5be2-4157-2367-08dc8c629791
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
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

[WHY]
sriov has the higher bit violation when flushing tlb

[HOW]
for sriov only init XCC0(lower 16-bit) for all XCCs to avoid higher bit violation
since kiq ring is always local, local address without XCC ID is enough to be sent to the XCC KIQ

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index e14acab5cceb..4e38a66a52f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -537,29 +537,36 @@ static void gfxhub_v1_2_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub;
 	int i;
+	uint32_t gc_index;
 
 	for_each_inst(i, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
 
+		/* for sriov only init XCC0(lower 16-bit) to avoid higher bit violation */
+		if (amdgpu_sriov_vf(adev))
+			gc_index = 0;
+		else
+			gc_index = GET_INST(GC, i);
+
 		hub->ctx0_ptb_addr_lo32 =
-			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
+			SOC15_REG_OFFSET(GC, gc_index,
 				regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
 		hub->ctx0_ptb_addr_hi32 =
-			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
+			SOC15_REG_OFFSET(GC, gc_index,
 				regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
 		hub->vm_inv_eng0_sem =
-			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALIDATE_ENG0_SEM);
+			SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG0_SEM);
 		hub->vm_inv_eng0_req =
-			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALIDATE_ENG0_REQ);
+			SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG0_REQ);
 		hub->vm_inv_eng0_ack =
-			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALIDATE_ENG0_ACK);
+			SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG0_ACK);
 		hub->vm_context0_cntl =
-			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_CONTEXT0_CNTL);
+			SOC15_REG_OFFSET(GC, gc_index, regVM_CONTEXT0_CNTL);
 		hub->vm_l2_pro_fault_status =
-			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
+			SOC15_REG_OFFSET(GC, gc_index,
 				regVM_L2_PROTECTION_FAULT_STATUS);
 		hub->vm_l2_pro_fault_cntl =
-			SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL);
+			SOC15_REG_OFFSET(GC, gc_index, regVM_L2_PROTECTION_FAULT_CNTL);
 
 		hub->ctx_distance = regVM_CONTEXT1_CNTL -
 				regVM_CONTEXT0_CNTL;
-- 
2.34.1

