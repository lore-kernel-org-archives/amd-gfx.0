Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60988D5B866
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9309C10E4C7;
	Mon, 15 Dec 2025 18:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AlQB6+5J";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013059.outbound.protection.outlook.com
 [40.93.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366A510E4BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFAX64g7mlVoEzFFeCqdLf2XaOoR8bfiqbfEvmugpwO3X8nF6q9/M33x5Q0QgfJ0GUDrsSW2DFHnK64AJ1de0Ihc13Huz6+qjjsKQelxwUCtFfylhBoILK3SJfpiYMaJrZ5TYUwRYricsMj78TgCwRk7JuSd9m7+K7BV3tfDzziAnAHTXtJo9YyKJmKwCcXoP8R4sC10kDoUeFwp3HdaAwAZcgJeghyYisLL31XCMChwm865vL+6MsDniW9n29OLolBNpAsAV9B/d7r9kNZuU+Wj8xKp0GNSaa0PolgEpCYgsoaV2a1yYpDIE0a0ncoSnb73Zy4w/Hp0aHXp2EGZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcW1WhSeoy0c2MBUPmltZ+fXCjmK2lbO21Kpq1UmxDA=;
 b=XkjffXIUE2HWWUI/U0udn0Y1deZ0kO7PJm4aVWbuSENEfhauHqOYLyg/NB3g4vEaw/fGL7ZxTcQU3279munIDDe6MBUdsdSjxg6vrQGzeOOzWHoyZsvpD42lV9h94Idcz4WFwF4BLbIlf2S5eV4Z5+cVI428AdzPKhl2PU43Rgm3swwwSfAnhOxcazgFibk9IZ+RoSNbjLP0FlnteRVk6DjkF+2p3lGZqWWCw3iomi8SWQkK77XYJ2WJqOP+6fJP/MASNEeYmSsVOFAGcc1G63fa9kVIfKeEbxBSLtTMj2jEJglJmVPGiRa8Dq32FaBuPCnIULjdQK4u9GQWTQB8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcW1WhSeoy0c2MBUPmltZ+fXCjmK2lbO21Kpq1UmxDA=;
 b=AlQB6+5JGA3MXXduds0pWVvkOy1yOX+ANuB8CIFIKvS8sHtxQdHSv8WcKf8BJz/OoDazC9ZofWm0ekWCGrG9exEl/EeCN2784PXDq72c2hfZoBex8QnO8nc4ifuPMXfQZxygKRVYdOUtXJ1ht0z3Gcnfl29DJSS5Z1z12pJMbS8=
Received: from BL1PR13CA0239.namprd13.prod.outlook.com (2603:10b6:208:2bf::34)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:27 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::17) by BL1PR13CA0239.outlook.office365.com
 (2603:10b6:208:2bf::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:27 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 Michael Chen <michael.chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Use correct MES pipe in non-SPX mode on GFX 12.1
Date: Mon, 15 Dec 2025 13:15:57 -0500
Message-ID: <20251215181607.29132-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d07f8a-cda4-4483-bdd5-08de3c061057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WYhZtAqjoLzAp5tixgKMa47E6WNn8afShT10KFfX4nse5nfP/7UoAx+KUL+E?=
 =?us-ascii?Q?d5OtFj0NkhW1VD/7mFRgOEAI/xxUvZ4HaejZEqu5kiS0RDPrwkhr1cAKD5JS?=
 =?us-ascii?Q?g9rsqRqlJhsQglFiKCsXkJXejSuiVmKWrRgyhsgmOEK8mzXOEdvLYWTZdEki?=
 =?us-ascii?Q?wMYN9UJkwTmmX3RiGDhSTHUbCbfGjvgb1Bh1dQWjekQHMMnFqn6G8Bwk7fv1?=
 =?us-ascii?Q?oqxB8F/6Myt63oBNTCgDJUiH3yyBPkCvdA+sbziMg7Dt4f82tqP1vF7D9ImX?=
 =?us-ascii?Q?46usuLFt8Da/dFf6wbkzTxjvwJscqHbEgzT6B4o5X/gH1brRCOdT/INv3GAE?=
 =?us-ascii?Q?UgS+cjqrc1A64B2YEnLTn4cfoRWuZA0yj9GWZMOg0bKf31y6V/8kFYz4fYad?=
 =?us-ascii?Q?XhMyb7bVcKmReMS6B9eS0bYdrrL+QiI90DvF7djl+vTp3en3ysPdvymITJSC?=
 =?us-ascii?Q?WDVd9gM7w+pSCe8veSqNt2/oK3MomHOWAYsqkrOiN0weHiBbZ0IfuEVqexSx?=
 =?us-ascii?Q?hOelL17q2X7rP12Y1I+7yu+mE56gUekX6a7WMnPeln3HpeVYBOiYSHBYs69j?=
 =?us-ascii?Q?+ko4aZlsj2WKe7Ev8tEGP5AXsq5fVBxsmkdYKD5cjW6pruXpumCtKb4IK20g?=
 =?us-ascii?Q?7EpOxc5qBj6bixQxxvTUU1X1dvN3jD3SXkffcxNCWg34mQlXD52CIPTUZTWd?=
 =?us-ascii?Q?3OMJd7G7DWpdGuZKcwpTWGx9Cq0BzfuyloD9b/4tegYv64CsjpTIF1+BqhTI?=
 =?us-ascii?Q?xL9Z63JAPmOWZGmkhfPIi6fik9hpxJIq8oPSbq+Ddbzvm2qTeHVmXeIbvI1k?=
 =?us-ascii?Q?Fz79XqgETpzFatGUY9JYPAPtBMJfVF9ZASAwjPIxcvxEtS40+4OWW8i5qlmx?=
 =?us-ascii?Q?UYOkjyDQW+1yS6v+Af1wCEkAS/2DqfBrEmqx4IpxvfStMUFa6U68+L8EVSsd?=
 =?us-ascii?Q?ZfopdOmOVANVY7BlBZGv1ADz4ck/WNSFxjnO+WToS/iSUmMFwDbAepOcBzP3?=
 =?us-ascii?Q?wx4oHJMpPnRVmxZc1SYBzX9UmBjAkqnncUtb7+dBLXiKgtBf8mGBYy34U5Fj?=
 =?us-ascii?Q?YKu7fNuVxnnzzXX4XI3dsFoInqRJ9Sy6ocdFqYHvz13weai3xlGo3bkAghcW?=
 =?us-ascii?Q?d0ZrfQeD+RYnqPoL0axnCn10lq3JP9uaQmxn15/FvgROp21bIttlddNhjMfo?=
 =?us-ascii?Q?LrtfNFeUV2kYkHRKcnsoc9ov8Y9+88BHp3qa61zCre+pdtZ2QXIGx5/nAO8X?=
 =?us-ascii?Q?uuB6GR0xiluMqcpC+Gsj/GWUqbDzOfsUewMHx4rgL8RjUueaqVS+nDTHkll+?=
 =?us-ascii?Q?r8fGI53cF0a/a4VEl4y+VKXF157vVGGtKu5y+0JVwF4dNNP8Ef+rfFipmlNt?=
 =?us-ascii?Q?sLCGCySX6q+nx7DsiSl5peGjPrg9Seq0QmIf+nOdE4Q6BGEAMm5buKTiTFS/?=
 =?us-ascii?Q?sRX2W8rmF2HZAqUQ0x7pGcxfiCmTRrzLgNwhY91cXRacfuM6BS8mSb9Smmxj?=
 =?us-ascii?Q?Saf5WE9sfDw8yUMxSLDcE2wq/k91dMHC3xzd+154ye9kxrPFrRIrWZYfZQci?=
 =?us-ascii?Q?bUTK5+A3gtwpBAQaZ6U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:27.4403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d07f8a-cda4-4483-bdd5-08de3c061057
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
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

From: Mukul Joshi <mukul.joshi@amd.com>

On GFX 12.1, use the correct MES pipe instance for readiness before
sending MES commands on that pipe. Additionally, send the TLB requests
on the correct MES pipe in non-SPX modes.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index cd4acc6adc9e1..a6feecd0d6120 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -859,7 +859,7 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 	unsigned long flags;
 	uint32_t seq;
 
-	if (adev->mes.ring[0].sched.ready) {
+	if (adev->mes.ring[MES_PIPE_INST(xcc_inst, 0)].sched.ready) {
 		amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
 					      ref, mask, xcc_inst);
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index d68e5a2377b63..86c0846780935 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -317,10 +317,18 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 				    uint32_t vmhub, uint32_t flush_type)
 {
+	u32 inst;
+
+	if (vmhub >= AMDGPU_MMHUB0(0))
+		inst = 0;
+	else
+		inst = vmhub;
+
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
 	 */
-	if (((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring[0].sched.ready) &&
+	if (((adev->gfx.kiq[inst].ring.sched.ready ||
+	      adev->mes.ring[MES_PIPE_INST(inst, 0)].sched.ready) &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)))) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
@@ -329,7 +337,7 @@ static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid, 0);
+				1 << vmid, inst);
 		return;
 	}
 
-- 
2.52.0

