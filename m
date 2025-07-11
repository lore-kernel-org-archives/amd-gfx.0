Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F96C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B8CD10EAF4;
	Fri, 11 Jul 2025 22:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rXcB39xK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B50510EAFC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhGykD+AKmp/r5KMdVq1McOWqSSK8xzrJEezXwEcVyXAiW5rNt8Uhg9h7M3/+8Dv5eVfCfJfeET8FVvCnfxM+1CrzJ95nWmplxQyboowymBADGQ3s93fFlQ20NVrrNwNWGQKPJMxR3FYpKA9ylv/SYaj7qFqYKTZldiy/Dm+Xr4UI2UtQVqVytIUWiCiwm3/vK8tKlt2uJLKStI3izXP3bOd4j01HGBWOS+4BkFkXIJCxkMil66gKcjgWcqiKRW41tnXm2PGWC9Gspj0Z7D8w6YM4td0cSJGCJww6i/g79USjUvbIXwl87kAjacJg49lnAwPgYLAZYsieNAS/cU6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cez/Pg0Oa8MVrapOkH29BFRJgsh1vr4EFqELWbyWzNM=;
 b=VYxgmmYuk1TzaqCbIytyKp3AqFIFBtm2InxDZdGKk2EHkYW7tfyElKPXyt/lI062ueobGzMXlojRanxovmyoauWHxRnbeqmI/BBqGQjkpPKsx3z+hpp0p8xYuR5lJTSXOEPaDGMx0i/oeb9mO8KBBY+rDnTn+ePvf/ZRTNnpmgBVYxRK8NsSHFeRpuav9Yskg30Z7qJN/rVj2UoAhIyKGPi0NsPq+iiKGRxiQTAZwjH+lmIQ7x+BwrmYhwX/O/R8IImAUMOEo7QxDlg2jOJV2G2FTYks2po7iX+6DurmRnI5tMA3K++c+dJBRmh9+zB0OyI/S0Gb1tpBY2X3THLXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cez/Pg0Oa8MVrapOkH29BFRJgsh1vr4EFqELWbyWzNM=;
 b=rXcB39xKSghTy5j4NVLhvo7yVzYUI8WbywVqZpZy2OVAxV8emXzdm9qAx17nMOGIVXnRJs0GXblH/eVepdIRSKBT6DBWV90/dj20bpopw6EDNAeH/zsox0B6M9y6UYZDlIvV3HzUH+svIjs66unIcItl2/NSp0DFJML/yAQ3kV0=
Received: from BYAPR01CA0059.prod.exchangelabs.com (2603:10b6:a03:94::36) by
 IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 22:41:01 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::84) by BYAPR01CA0059.outlook.office365.com
 (2603:10b6:a03:94::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:41:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 32/33] drm/amdgpu/vcn2.5: implement ring reset
Date: Fri, 11 Jul 2025 18:40:23 -0400
Message-ID: <20250711224024.410506-33-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 09847812-3b17-4b7e-9d5b-08ddc0cc02e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IKxDMu3nyxfYYe/vjQ/PxHhYYfbdYL7J1zbFVDHYbJHapR7U5YCsk2ptq5pX?=
 =?us-ascii?Q?wTX0ReQo0/34siJoH2I0EMVq7OLO7ZkA9PBYUFti9vbC2NE14HKwEN2gp7q7?=
 =?us-ascii?Q?naF3P9T/eTyIKNXB7a/VvUpz+NNFKLKQK2WejwdgrLTrpn2usiwRbqdWDGv9?=
 =?us-ascii?Q?RMcMY+lgLvKCHJRLRYGKqU1F9HGdIdmFp+WX+iSFOrUEHjXL44AsgCRnrCgk?=
 =?us-ascii?Q?KCXEvXko8Jl9+xNLzQ6vFDvl/pPnCnGc87VYKEK5wIE00mtarX6JB1ode7XU?=
 =?us-ascii?Q?549NRHHdhCnc9cqSfUGyxNKFwLemEyQC+i48E/htCtg6hD0cucp/jlZh8w7/?=
 =?us-ascii?Q?HQibIENOnjjnRTbMyGC62S5vl3I15vlMgFw1TrmDk499RiFa2gHiEBrVTpG2?=
 =?us-ascii?Q?uLWNEUeYk+yOqTxEJMbY6jD7vs7yqV/IFEhDa/0wNizl0nv0SCbcOoKHTCTV?=
 =?us-ascii?Q?8qOEoPHpPpEGUaqsZwtITWoGR4lqQxsq4XFuPcP//C4hJ0sK102YH+/mNgFp?=
 =?us-ascii?Q?6B7nTf1MAbix3rZf/Hi3doGlN3TfR9laLolNtcA2DiUy2Ug3NYJnCgiHIZB0?=
 =?us-ascii?Q?tYoGXKiXlCBzgSJNREWQbXFkb4pVtPoNaU8l8tAl4iscjjMd3RLAtJ6pJgDq?=
 =?us-ascii?Q?k0JLmKaEKTE7pc6al0YNBdr05AJfzkaCn9q6iKXawvG+JICIvipOngChLBw7?=
 =?us-ascii?Q?HFLGifM2DxyaSpuVkJpQE46E2eEimdzxq8viioyCjOJMHVRCbxUZeoNMyG7H?=
 =?us-ascii?Q?7ev7WUAHAA3b/RRFuH9/yvVpDKEkzqDMbbpwB+xGCTSWGM3QyQO5MhQBIH/h?=
 =?us-ascii?Q?0yu7TheIgDJVwsn31NKizNWUQzeVg6q0q2KBIjGXCU5UGHl1VIg4mXzUpuxT?=
 =?us-ascii?Q?RbSLkVXGVXGp/a4WS89dtUoBIWDzfLZx5Mi2NrwCd3teAOggseT+XHl2Mh4d?=
 =?us-ascii?Q?il2uhNb0to2nlG3XT9mgwPrPycQcxagvFy8AnRK7wCedb0za3fAZDsUIZH2m?=
 =?us-ascii?Q?LqHbrDCdtN4Sa9DFXhJEHUY65o+oUV47NgABs9rWZPpvcA7bG46tkSxTgJ92?=
 =?us-ascii?Q?pKZjGRu7g6I44jgJCYJNkbWfadFve5jB1ENgLg4yiLQuwchxRylSNwqf3wt6?=
 =?us-ascii?Q?46utPVO7+kb/r4ocnbyVL7rYYfci0+oAgWnuL3SgoS0JhkSDjUGj/Oqe3E7K?=
 =?us-ascii?Q?WjnttakW89KZeIskMP0CyHq+u1Yj31C46ZWYFdb3Y0V4jq4a5l8teYREl9zc?=
 =?us-ascii?Q?Swuh/xPDztIgrZ+/XPIJHCC3hhk16eh8Qc31dZbqzWydH6t7811Fa5jGZUbG?=
 =?us-ascii?Q?Kbuy3wVKxs7eHGtTUoNUVC6Rrc9nbzMQQNCxk3wai+Nawq5dN3XzJiBvqrWK?=
 =?us-ascii?Q?6gu+eTjvX2LK2TAuyLmNTce8lbccuYQ6Dn9uQIzDJP64XIZms8d+nMmhqnCE?=
 =?us-ascii?Q?968X3dxO/VA3Jf9odlkKuK8ALHgoDU1rMeE6GpPf5XXWhV/0G/cXufN+d8u1?=
 =?us-ascii?Q?X0kMgiqiSwHwn86/c5RoEQawODPfY9wB7NbV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:41:00.9991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09847812-3b17-4b7e-9d5b-08ddc0cc02e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 58b527a6b795f..bc30a5326866c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -102,6 +102,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
 static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev);
+static int vcn_v2_5_reset(struct amdgpu_vcn_inst *vinst);
 
 static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN,
@@ -404,8 +405,14 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 			adev->vcn.inst[j].pause_dpg_mode = vcn_v2_5_pause_dpg_mode;
+		adev->vcn.inst[j].reset = vcn_v2_5_reset;
 	}
 
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+	if (!amdgpu_sriov_vf(adev))
+		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -425,6 +432,10 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -455,6 +466,8 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		r = amdgpu_vcn_suspend(adev, i);
 		if (r)
@@ -1816,6 +1829,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 /**
@@ -1914,6 +1928,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
@@ -1942,6 +1957,16 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static int vcn_v2_5_reset(struct amdgpu_vcn_inst *vinst)
+{
+	int r;
+
+	r = vcn_v2_5_stop(vinst);
+	if (r)
+		return r;
+	return vcn_v2_5_start(vinst);
+}
+
 static bool vcn_v2_5_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-- 
2.50.0

