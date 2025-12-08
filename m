Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D493D3B7EA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA4910E4A9;
	Mon,  8 Dec 2025 17:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mIHkVwht";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81CBA10E4A8
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmArpT9zi1eyvrd3R7UkCBxL4xDKdQepAXzLk6Li82cOuxVIfH3bvC8x67E/bJHmigvEbpjMH5llgHBduGtBujdBFjvCs+5QkccMYmfGK1v0mYsUaVSwxZf6J4QlhVBKI2VxHYHLfqvvdSfKD3J4R+pCq7ClK39ej9jYUd3VRnN7fZJ97hg0i+m3r0UTEoekFfXpMVFRipRVzgrriVz1muGLsOG69X3Kz5QIboDV8nBqRytKeshl3Tvf1gsHzVFI1W8SNbH7FDYMQZZ33X45zqf0YAnIenh5+NVXIYSzKLAUjb8BQSKgJEApAK/QFlVorNrmUBT9feovqBXWMWBQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaofGQXC+0xRosjmumTJ3vjiX/pJ370316nf6Kae9xE=;
 b=e82p4IgXeIFpsguaHzAbWvXHuaOwB6Dcw5bTEuRBXI4XzrtZsMv2DcVWIKWLaDNkOkxhoVv7RrFibmbAP7rGcqL2YxkAc1RRycEqWAIdbHWnaJaY9F+WVt6YJuRzDhGz9Yv4fakmcg1EbJy/YtbRHfNQQJJs/FIl14y0GcHeT22biYCIz3f7jsFUBMSZTGL3FDRsuKOA0usL+Eo9A+Af/HA0rehaYxMkxEUEdMhIuiek2Eac1NYHFlO34xxVsR2sx0gi72HI6wWjsgyUmDdJyunNTvFiKSp7jKG885zIhICqc3zmsUaFJ97TRP6UsqXG1gRselc9sOZFpbp2NZbVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaofGQXC+0xRosjmumTJ3vjiX/pJ370316nf6Kae9xE=;
 b=mIHkVwhtmMtb8KXQTXBifW5ptIfIBm2w07UzqTh4pi95ET3ZROl+G7o0xMmHe0u57pCfSGisoQMbevfghdL5kLJgK8daVTnBwPOY7f1mx765E7tsYApZCHsD9cM+FrE3TH08KBg+SOjevE93xXhs23usv3cm5DVIAyfsM2KakSU=
Received: from SJ0PR03CA0141.namprd03.prod.outlook.com (2603:10b6:a03:33c::26)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:17:57 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::2b) by SJ0PR03CA0141.outlook.office365.com
 (2603:10b6:a03:33c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 17:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:57 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:49 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Use AMDGPU_IS_GFXHUB to screen out GFXHUB for GMC
 v12.1
Date: Mon, 8 Dec 2025 12:17:16 -0500
Message-ID: <20251208171720.153355-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e13d48-b8da-4d2d-59ba-08de367dbb50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HkCRW3SivxSenY1xKDdGYjKnk018dWieaMwrrogF0lp4QtMNv5HCWaOWOzoT?=
 =?us-ascii?Q?Q2tk/ECS8irt1uzObCbZOy10F5b20c9uOtMhMFrYN7SQUP3q6E5QnQb2TR4R?=
 =?us-ascii?Q?IVGLdk7mU3SLfkp1aydMrWbqRuXdPxRqCiYY3vtBgdxjyMPjEtNWztoO3NbY?=
 =?us-ascii?Q?YxiiScRgte06lNQUGHgRWXXHihPOWNXht7PFxc7lgL5TugruuqL28dG4nzVS?=
 =?us-ascii?Q?9ZnbAay+yIQ5TLiwAbdwFuTdqRjQJxPR70wmzsUN3dG59y40d54T64cBULsB?=
 =?us-ascii?Q?mj03fpxQYEPzJ9tpDFvWa8E6zVacFPuh7mGkF3qC4LIne/JbnAmdKvzQ7bcW?=
 =?us-ascii?Q?phe15/jf5ZfCa8egDVpWmMeEC8efyxBU0tiLOQyULQX9Q3/UPGDa8KrMCt/h?=
 =?us-ascii?Q?UCOyy5TRPxJDTvcyY+n3f0q7vcaseyD1JbgDn7rXjZ7Y8EiSbzvOvrl057Y6?=
 =?us-ascii?Q?uat9No7WgleJZVgsQnJikoieRRTpOj/C4QTVaDJ3qiIBAMDWfVALJoA0Acpe?=
 =?us-ascii?Q?+pAQRnBBYnC/L+EMfbcyJ7eyF4cuSDQqKyZGGvDtXO+WTIOMFU/91AigjzM7?=
 =?us-ascii?Q?qZ03icGbonOjWCARiK2Z+aTcGsk+tgM/0JFouQOEJIG4c5MrM8scUZUhnx1+?=
 =?us-ascii?Q?aDF9DtXtXAHnvpeC/esuFYUcGWc7aR4hjxI2cFF2JBQA9cZCMGBAQXkdq++u?=
 =?us-ascii?Q?4M3Sob+vsG5FR7Za1HAv+kk4+befnv02BqX2R6bkP/dm+Xg6zOCxRn1HiwD3?=
 =?us-ascii?Q?Evm68WMGZy13VHORo5nZv0ISRVPjqk8yS6YwdNIa1/+IfQEOZF9kgwPvDLIk?=
 =?us-ascii?Q?LL7dl2hYjQxcen7LQxZlbPvWR1PfKugoCjjFJBWSZbPQTlTY9ohs7ux+I75O?=
 =?us-ascii?Q?AEVCYTcPN2Hu4JJ9/20oj8n7BhaE/nLklM+CQNf1B4xU8tWcr5D1tXcZfoN4?=
 =?us-ascii?Q?/xPOi7X4PpCECEHoE2WxGkFHefzAVFuQZKXP4ZBpG/4+wZZ4z35gcwLY8VHu?=
 =?us-ascii?Q?ZkN+JV4NpsS5xXNFPWLw6/bewWKcB8nl+vTPC2o5EiVA/wAaLQdmDuubpT0N?=
 =?us-ascii?Q?ykrtE96UVBn6qnkwRX5BASkfoUJYHMsz15oXsSeGxR6RmhcIfZmXXndxg+q+?=
 =?us-ascii?Q?T7jqDYjIJZpXoU6q+BH6HsVDUvvNIEih9JuuBv1d9DYP3R5U73/7vKNYE5ov?=
 =?us-ascii?Q?WC+nPK0LASTRpk28MGXMAJbUk1ctx6fU7Q4FTUFQ7pLFzcXf1U58IP/mibRU?=
 =?us-ascii?Q?41bn6rfePJofyJp9cZnoeFkrk0eUqoV5LEipZAlJ27lmdDqknGy8kGLKbBZi?=
 =?us-ascii?Q?NM2/G2rD6Vxkf20tb0se5SutjpBz0bx4DmZuDTxN8K+Hsqr881c0aof3q8OD?=
 =?us-ascii?Q?486ZdljgNEPGC2NlG32yu/13+h7qqnG1nUl+38JeeG2FA58607thAUQICEoq?=
 =?us-ascii?Q?Btw0duWNtnkdXLjhegbG7jkGVmSKEAS0f5LdAYO5UjN48AT+cZNhMqTOszI8?=
 =?us-ascii?Q?Y2Joy5LiIKo2bvFWvOVusx+TLM8cImaQXOVwE/Crn5Z0GtFoELxTq821aJli?=
 =?us-ascii?Q?DE5y7iqF9ni1FEgMN9U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:57.3275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e13d48-b8da-4d2d-59ba-08de367dbb50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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

From: Le Ma <le.ma@amd.com>

There're multiple gfxhubs on GMC v12.1

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index c54d2d10a8caf..e4b12b15bc943 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -255,7 +255,7 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	unsigned int i;
 	unsigned char hub_ip = 0;
 
-	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ?
+	hub_ip = (AMDGPU_IS_GFXHUB(vmhub)) ?
 		   GC_HWIP : MMHUB_HWIP;
 
 	spin_lock(&adev->gmc.invalidate_lock);
@@ -274,7 +274,7 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	/* Issue additional private vm invalidation to MMHUB */
-	if ((vmhub != AMDGPU_GFXHUB(0)) &&
+	if (!AMDGPU_IS_GFXHUB(vmhub) &&
 	    (hub->vm_l2_bank_select_reserved_cid2) &&
 		!amdgpu_sriov_vf(adev)) {
 		inv_req = RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
@@ -307,7 +307,7 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 				    uint32_t vmhub, uint32_t flush_type)
 {
-	if ((vmhub == AMDGPU_GFXHUB(0)) && !adev->gfx.is_poweron)
+	if (AMDGPU_IS_GFXHUB(vmhub) && !adev->gfx.is_poweron)
 		return;
 
 	/* This is necessary for SRIOV as well as for GFXOFF to function
-- 
2.51.1

