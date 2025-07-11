Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9699DC83F25
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357C810EAF0;
	Fri, 11 Jul 2025 22:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h/s1vyJv";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA1710EAE5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMFnykKIsnNam4vRaLwgrwx8ALcZb/EdB7P2C9sDlpoEW444jasrHirotB1JXJmlTLreAQHVVh6+aXuaUMQtVuBudLbV4LBKBewDB1LquIwMYRWhT+3nrgng+zkGt6j2lZkBSZS65qiT1DERwkuB+2WLnB4RaACeWIFl6s42aNWy/19cynk6hQD7jlqyr0yY48T3oiRyg01khk0aZ9vASAitY4qiQhmPr2sN5xn1BggI/njf59q45jOen/J7uCUe9YdBvBt1uFRva/N2Vi+fWPZol8gnHqjMuztByI7+FMsIS2T5AIAuIyxKGqe0fZcSgBH8in/+uYdWyLQDEec8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MbE4iN7b5FjNxzE6F/ds1XanFex2GxHgR5Ht18CPbo=;
 b=GGWcA70zTKZOs24Xq7hIibA9QrCii3Zf8y9r2/FNEodq8HijlCLTSiOI+I8mON+XyytxMmedXFTQywaXviRsvaID9zq5VVNCYb0PPGflMrHI5YIERoFkmIut/4GkWS/5c/Cn5HVElaqM5yH8/uaP5JCl4XlFMox29fW7HFJwZv5EBwMAUA1XoSc8zJcotbTHKfJ8zX619PxR0Ev5+vpPuhSybQdg4nz2G83bCQG2jzgDq41Ta0BFc3k97NVdlW7hGIBduvFfo0PFHMgS1m97qphUg+nbdNQOzD/yIVYhLPZ0xjOtgV6aXsA0teabrZ9yiRxj1dcAiR+Q2TuDzpMEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MbE4iN7b5FjNxzE6F/ds1XanFex2GxHgR5Ht18CPbo=;
 b=h/s1vyJvsn6fCtYaTBsDRJiupXP3bf1g4zpYflPG9wz9lMgT+X49kd9hZBS3+tf6C9xhcftXyFp6eSGuUvf3efzsD87IYNoDOKZcDDObU+VADLMaJykTVsArV21WCn0MALuOEHeh4yxrLNn25iL5KA/Gxd1m65Ata6JReU+nO/k=
Received: from BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17) by
 DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.23; Fri, 11 Jul 2025 22:41:02 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::4c) by BYAPR01CA0040.outlook.office365.com
 (2603:10b6:a03:94::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:41:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 33/33] drm/amdgpu/vcn3: implement ring reset
Date: Fri, 11 Jul 2025 18:40:24 -0400
Message-ID: <20250711224024.410506-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d47230-0b89-46d6-f780-08ddc0cc0374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CUgJg3G050B4dtCXysPYzC8zz0Xvo3BeHc9Kz2AYXjlaxUlzVktoL2wQ68BS?=
 =?us-ascii?Q?9atscjhXG7ohFnw0FJ7TUsitVwCypZZSLAs3bkAQscigCpW+RaYy0OiqlUx+?=
 =?us-ascii?Q?DL4YtgJ56BBENOxZL58XV6XVVe07AdKki2koeGmS85QLVCsDsCE4H/pE6PCx?=
 =?us-ascii?Q?P/M7b0Ja/+4TvjWcwIZyDF2C3QSWLX4ls+VOBLfBybSz3ASJJiS/t6ikb5E+?=
 =?us-ascii?Q?2C/X5ZHgIgpkRDIUQn4OiUXMXRPCZhiixzruee+k89UgtmNN/0CMc8gbkyah?=
 =?us-ascii?Q?fpT08aEKcwzj7CuJS9VVsjD+0L2WE69a+0rsfok+xXqFKUgMg2HumO+kpMW3?=
 =?us-ascii?Q?5IIrqQ58vHJWdRYRgPN3Jzl2jlklLxemVEHeTFqBYxwQj5dK4hNJWkzEAdzs?=
 =?us-ascii?Q?WbgrcDA713oYu7djBzSIC/UK08qhJIUn7CzOk2keVVqitA4rLq1NMQAn4LPo?=
 =?us-ascii?Q?ngUMl6EUSwjDxYnL09PWGvFh4GAlf+78KzRHOr+Fyc/cny5prgVdGeRvGAMB?=
 =?us-ascii?Q?lEqU7G+81NMKbuAzUVbuIZFmyu+BXBfNonbSxcu/4N44CpBTgvUp1cB+bhpt?=
 =?us-ascii?Q?VNmqyoqiNKk6wAhYTs/W5tqdeNhEyh3580+lG7gVChlaVz2dMGNyNEK5q4DA?=
 =?us-ascii?Q?hFH4Jj7c9IU74b+yMYMuzX+vya/Kp4afLtmHx32EaaLgqw7Ppp9Yqi3ZajbU?=
 =?us-ascii?Q?N8wdLRl6Ljig6sm8VgnBdcREbvh6ERbVQmJCmt4N8/3SQRbeIs5SVT5GQOFW?=
 =?us-ascii?Q?cZBLLcMdg7pPo6RhTl2q8YYOcv4jCC9nzA991XJx1PJ/KDRTRdVsbd+AoQSe?=
 =?us-ascii?Q?fsLnZFPWYph6uR440MfkJX65zf0RoHGVhrPfyH0TPxsdWIf+0yX2MTHj4+4Q?=
 =?us-ascii?Q?e3/v8FIW6KLd2Z6SKBVHxSKnLA3vo0nTSTxS+4GqtdTkCrqw01YrQCe9/QQK?=
 =?us-ascii?Q?F7nW5rFLmfMmUUCo+TUzzuNK66AAuD5t7wYK0Ti8rftsfOUVAL2LvQY5G1Ba?=
 =?us-ascii?Q?AAWQA0JtutzfiI/PskvLOB6jWQZCYd5LB1jaCsI7BdC4WNIxiRJlS9gn+6S7?=
 =?us-ascii?Q?wxZwlLdC45WL6MWSjSnoFGXGZ1vJJQsbCNL46uBtxozWcreObRkxNlVBmtM4?=
 =?us-ascii?Q?aBxYSTdWEnZPnq4BNznSa4Hhwxh0wTxSet6hqZ/1/L9KZsLB1D5CvPsvNkme?=
 =?us-ascii?Q?C9ycJAHb3nURLfeDOJklB3IRyRKtop7aiICc6Utn13zddumIfW+5VuVHWQ9b?=
 =?us-ascii?Q?2E8W9zXVj9RHxFMl7WKy5gxzxHvQKZoY/jdUiKcXfrTe9Xcp2z7Ox78D2HRH?=
 =?us-ascii?Q?KnY/jCWD2NmtA6wNW314GQfvPQ1oTFPEWUiVpa2kI1Fd5H48RjwQmT8AcBWT?=
 =?us-ascii?Q?iAMvmFuYEwOpm9NbuerBZHvnOoOjbHg4Wtq4CZTD5U1dFwHhSJqgln1DtqdZ?=
 =?us-ascii?Q?JnSew8lOYs6VlOUlA7+NycUcoMplNuzntvK+I9JC0obGBCORY+4CDqfv53Tt?=
 =?us-ascii?Q?Lo1M8H9VVJPvyeHlNJ1u9TotYzmDzsQ7oOc2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:41:01.9452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d47230-0b89-46d6-f780-08ddc0cc0374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557
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

Use the new helpers to handle engine resets for VCN.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9fb0d53805892..4b8f4407047fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -110,6 +110,7 @@ static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
+static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst);
 
 static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
@@ -289,8 +290,14 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
+		adev->vcn.inst[i].reset = vcn_v3_0_reset;
 	}
 
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+	if (!amdgpu_sriov_vf(adev))
+		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -306,6 +313,10 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -338,6 +349,8 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		r = amdgpu_vcn_suspend(adev, i);
 		if (r)
@@ -2033,6 +2046,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 /**
@@ -2131,6 +2145,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
@@ -2164,6 +2179,18 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	int r;
+
+	r = vcn_v3_0_stop(vinst);
+	if (r)
+		return r;
+	vcn_v3_0_enable_clock_gating(vinst);
+	vcn_v3_0_enable_static_power_gating(vinst);
+	return vcn_v3_0_start(vinst);
+}
+
 static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-- 
2.50.0

