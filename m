Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B3EC83F21
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34DFB10EAFF;
	Fri, 11 Jul 2025 22:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XFZRWkny";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D32010EAE5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7tCabrcsez3j4WFeXsmcb3NChasWKe3KZIwZcfBfyP0jGCKDHRGatsuPleeunS6YS/xBw1CGtsJvlte4s5MIu0Tq7vgP4RprMAy3KsqBZin97d8/QrvBGQhW4wXWpkU2XKlOgjh7fnMzvUTszMaoOz590PLEvjVNzSw91WQSVZOpDGd2hf53pHMPM3iMouAXMpEnX5tl+XPlhp0wE9hNBrbo8Wkh9HDIMI0c+ecPCDd1hxsLbGtHEOj4Pgw/znMFpaSjt4oEYTZi4XE8922rAGjVSKRJrVpcQJ2Y8EyWB5+idxBUgmRGujxNMjmfDKs21u3xLue+CvER1owTPlnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BxsyK6LD5fvwvZAHjkriPiWnfTcTHEkILwQ5hWsZj0=;
 b=iHqWnlyZJm4XnHy4XK15o1OerxT9eAaUsHFbTN5ChTeWqKDi1NXevW5tgiBxfrzf+r+tDOyM1XNLCQnhpAyLqSUPN0c+LVGPaRVjPZo55LYzSJFRQjiZPacPywNc9lgHaktUgiTjRCcVCtaujEGVSRIJvQoW2/3n7oyDLHqObXdtiNYxZzXNPpbD6aYaeoPuL2AntCCAIxe72SlG6cCNfxD6DfTQsJu6WfW+kKUJgIHVSLjpE2RURWoQB9LsYbtFk4cazTsNNp5Q/IOzUdIY3l5PCzzw+SSOIJzat9RPedyRbhdIAgFl3pA3ykaR4X27GBYhZd45L7mq3fR6HjWXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BxsyK6LD5fvwvZAHjkriPiWnfTcTHEkILwQ5hWsZj0=;
 b=XFZRWknyqqX3A0kBYH/jtEu2WBT3ZoaLjYubz8DaZ+Lw8AngEhNzrKiHDw+QRQzgmhLOK+V839HZzcyTj0TT/uyex1M2fhDbC9v1AiiIlVcBZOBleh4zg57qiMBkd8n8S4gpNo27qeXLXkMaoYrJ8mYWtTTkCDFaOT+hQd6l1yQ=
Received: from BYAPR01CA0059.prod.exchangelabs.com (2603:10b6:a03:94::36) by
 IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 11 Jul
 2025 22:41:00 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::47) by BYAPR01CA0059.outlook.office365.com
 (2603:10b6:a03:94::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:41:22 +0000
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
 2025 17:40:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 31/33] drm/amdgpu/vcn2: implement ring reset
Date: Fri, 11 Jul 2025 18:40:22 -0400
Message-ID: <20250711224024.410506-32-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc4741b-2fe3-4702-3f83-08ddc0cc0253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NfosEgMfudld0zuknTJUTG/dAT52IB1Re+qydLLLLw18hbO+1+wmwXPqQs0N?=
 =?us-ascii?Q?rHseVYHTkx+1qr9JqR/HOOl4ZH/KxGuyUK40i/+ME7aQTd/KF/9PMUgj9cSu?=
 =?us-ascii?Q?Ns/dtstO2Y3qgv+uJ3SMizIfqvJXsafoOGIKHTh/o175T60+5nMtq3bOTxrG?=
 =?us-ascii?Q?V/FX7nzA3sqM7XlytRmznG97bklElkeuIYkQSW5q8JUIKWuO2nStdZPRCFrP?=
 =?us-ascii?Q?9nbWExbRj4aGqYZKrhxY6DnQT+NvziBRuadPamcZCrZBIQ6UP0F4whnkurTS?=
 =?us-ascii?Q?226I97C0txUUeVIIxeDtYJeK5zy8NWXphKNuh2lzVrKISpnYbUKd62TEkuwA?=
 =?us-ascii?Q?f+h2QMj+nY/TK9X5yt5Bf7Q7sBCh6ZDNZ9bpULNB1gY7AYNGlc/5ZSFJ0sPN?=
 =?us-ascii?Q?33VN56NnhLI1gmRc+SLJpq2mqDvIPJFf9rQY0XSNZI3MkAwpiufUmg54Y1xu?=
 =?us-ascii?Q?3gbuxZ6G2lxFjj+kQDmfm84kSNNBFXMqs+7JWQFr4pjlh932Ue8yG8aiq5dD?=
 =?us-ascii?Q?4UlXouqOBiKeyozz3legEazoOAdajTbJhlQMhWeX2t6h6fx4eSnZWoOGwiw5?=
 =?us-ascii?Q?CMdJcfZgY96COE/4OPzsjwByr2GGY+WzE5nzunUsiX0n/qjhJbxe8yJDGF5g?=
 =?us-ascii?Q?HXgy1xM9v37ys6JZupSvt73YD+GQ5dc3XIW18WisV1ZBvKhU1pFXFElLJpBx?=
 =?us-ascii?Q?UCFtmVR1/Q5xgF6VYT9IGhy1IMHnh/eL4Ahz+jJ9SoMdW9myNgPuq9l59v2D?=
 =?us-ascii?Q?dElOvYaIUyAF+EjbmamLVHgDt6VhvNI6gCvHh39Owxd2NHHBFSNUq3+NZQdS?=
 =?us-ascii?Q?qzR886SxqkVwqdpjO+12sV9pHbJSLjO1b4A0rmA+mg0XICVyIrNztm6hPJQ6?=
 =?us-ascii?Q?s0ePvBpcFVcj2YEINznt0e2ye9wJDrwetXEUwG/DlGvEdWdRdrUF0GsVOVQk?=
 =?us-ascii?Q?Z5n8aqPFq1V4uhkK9LlLobyKSnZ2bhLh1k/H21bLUx9RC6u3vFkqYzWyaxjC?=
 =?us-ascii?Q?10kWw26nEmzwBP+32nKKa4DkoQmpFjeBccrYd6cW9uvRmKwlQLlsyvwuCMd2?=
 =?us-ascii?Q?6Por3bhw1iVI1i4KPchxPyTZqlLbtDuzNeGki573TQdsxupC9sCnrn2JmO2b?=
 =?us-ascii?Q?6xcukLt44T8ekahVCNl6BrURVy+tRmeT62dqgmwsLk7M17w13Iu6J4GBKHd+?=
 =?us-ascii?Q?maszLs8PC7Y00MCMun7YoRRZwKeSUD3Ro12vJ1NT/n0VXUbTWX5JOf2FNTrW?=
 =?us-ascii?Q?axwfWG5Lbp1CZOE5WPm7ZlWgF2YXINTVn9+3feobVHemP7tBhahuyz0REfwX?=
 =?us-ascii?Q?utmOLM6/YfQ926eJZK2m06iFkcWR8wRajHfLZVSKZHRA23QhsxJq1UZsfiFf?=
 =?us-ascii?Q?5eq/X7cIT6wsXAGC5JbCOfO4N6e9T2lCqRlzn+IThiuqHfPE89IjBJl97MIr?=
 =?us-ascii?Q?JmHHYSGnoBr+Xs+F/KGEk4cEPg81H2WiQW0immqIGLXkMo203mbjl1bpVh4T?=
 =?us-ascii?Q?f+ZL2Iu/QbtA9AB15o0ubk/q9dpcjniD0BAH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:41:00.0469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc4741b-2fe3-4702-3f83-08ddc0cc0253
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 148b651be7ca7..68b4371df0f1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -98,6 +98,8 @@ static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst);
+
 /**
  * vcn_v2_0_early_init - set function pointers and load microcode
  *
@@ -213,6 +215,12 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	adev->vcn.inst[0].pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
+	adev->vcn.inst[0].reset = vcn_v2_0_reset;
+
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+	if (!amdgpu_sriov_vf(adev))
+		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	r = amdgpu_virt_alloc_mm_table(adev);
 	if (r)
@@ -233,6 +241,10 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -260,6 +272,8 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_vcn_sw_fini(adev, 0);
 
 	kfree(adev->vcn.ip_dump);
@@ -1355,6 +1369,16 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	return 0;
 }
 
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	int r;
+
+	r = vcn_v2_0_stop(vinst);
+	if (r)
+		return r;
+	return vcn_v2_0_start(vinst);
+}
+
 static bool vcn_v2_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2176,6 +2200,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
@@ -2205,6 +2230,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

