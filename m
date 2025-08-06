Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D12C87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 14:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC4D610E78A;
	Wed,  6 Aug 2025 14:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OnzNVp6H";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14E2E10E78A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 14:50:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaK1AT9dWMMpfsmArRFN/zIaYqThw3ZLEUkNlD0wTiy8LDzf8yIF6CfZ0EFMa46KDk/JZPOCka8Jj+cwPMJLe0ChbjFZ7vRXfirgHSU7kcxb1SKaF0ax8LdM5gNXyrQOPEEq+5eIpPEyV5KRclccCOYXhrQaAaIbfUL3hWNx1lRVlXcDj0Bs8+C/bUZtKHcmpdEWdhueROECz88ildIEslJPUR4Y4Py8HI7H6PllmofofyXM2cdzqIBi0dK2GcJAISpTLICtKy+nAnxDFxENc5uWGcxasZKvwdzCUYtNmUF5AjIz7BdwqMqoA29MJKAzxPQbu/Drvqq/mMKPvebm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WQdgPB17LuouDHoSyhgZGN42kWQBY3yAmSqoX/pxpM=;
 b=uf9Fj3pRU6NpastHgOkV8PgbGOVYMlKuTRUkEZlQrr6RHgPvpeO2R2vGof+E2l/k4vC6O/Xt6GF420HkMLc+60LwY7MbvarHYj70qVmoGPqaVYLJzD/UFlpjQefsZJNQHDmtw7Ifo0LJNppcrYKzM5euBIgqhTAFsDasNBvsa3zOLyCzXFdSaDPf4E6WEDuWMICD7misTMYFlq98wouEFO+8f8M+9WkEpK7MaPJ/D11jdXLzalZ2nH0XphDqZ/kDFNWC2RmueIetvc1mMohLLHPVF5mHlQlSC2iL52PUH+eNsT3y92j2M+MQhxZ7xt7VIZPBX7jbIIUf+C8QvLUQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WQdgPB17LuouDHoSyhgZGN42kWQBY3yAmSqoX/pxpM=;
 b=OnzNVp6HMUhrRfHzbCsa5zRS34KBcL06Se7KegoegVdLiTzDbOj98Y/1QDJc5b+G8OiyEEAsA1L53C/boFPEKL1xEt2fUWea+BE1g0yA4QoW/RcQF0J1TEWeWPZigBz9eqo9tVS3C0AQSpSgYdNeGjsaLjMPQJq/O3ZPz5KdZAc=
Received: from BYAPR03CA0016.namprd03.prod.outlook.com (2603:10b6:a02:a8::29)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 14:50:46 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::61) by BYAPR03CA0016.outlook.office365.com
 (2603:10b6:a02:a8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Wed,
 6 Aug 2025 14:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 14:50:45 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 09:50:44 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/amdgpu : Use the MES INV_TLBS API for tlb
 invalidation on gfx12
Date: Wed, 6 Aug 2025 10:50:32 -0400
Message-ID: <20250806145032.293332-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b9084c-550d-45ec-92ca-08ddd4f89fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|3613699012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2wl6L8HBbuBJ8JYL7zVd7UzOm+5ehz+MV/0VNy8q3S1K3TFOfiXSLJCTV8pO?=
 =?us-ascii?Q?1YIaQn1iwIEIrlywzrHjz3e3mSSknRqvlhSDJ2RNncGFfDnTI3FGsqkSdksr?=
 =?us-ascii?Q?QKeUhzy7893qGzTcE6o4uV+l0HMhraiPEHGBxQ9s0u0UvpzeaPWPMxV8g8mR?=
 =?us-ascii?Q?ZVtL736BRaIGejQws1qvS97EP7sH/Z928kAUW2qcxnhzk2j2+lz3+ahQizeu?=
 =?us-ascii?Q?x/AvfOcYYCMasFtvMcLfVuKcmCxzaieC0Pg0VRBef9IkVHDVw50wp9B/AA1x?=
 =?us-ascii?Q?a6zLp2A7pDYotczD2rWlxwJ0b052+L3Q3lG6upAjxrD9fzXkf4NooRGiYV7i?=
 =?us-ascii?Q?ldBl4X8VSs7NskPdZPDVYmfDSr5oChwxaj3mE7qERpH7fcdQNS7QKWMYZ5tG?=
 =?us-ascii?Q?hVU/kn+RSgnsGOXi83fMfYsWA0tcS4LM3XIUFmRtc+G9P14f8DurB3FVQRAC?=
 =?us-ascii?Q?WRaePyOxF32ibtdXFlAX5mb+hCFsOcZwaMnIozW8K2bpQhwvzbIZ2Lp9EuPP?=
 =?us-ascii?Q?sWXRInI2que2ksl2wPt+hvlFWRaUEDUxi7j1roFOl5Uvv4mAw0uCYuMeBYaS?=
 =?us-ascii?Q?gLr+44U6VVvW/mmQ/LRkuB5Stfl3rlRB+z0RSwglkVk7gV1DJrSZWBCwKWMc?=
 =?us-ascii?Q?AkPX/onSx1GqjjAIMhP+C33W1SeMGu/diJPXXjuMTHtr9DP0f7gvuwLMre+F?=
 =?us-ascii?Q?jFut9AMSnLSD91dGfvSCIosUbZHNhk9QCf4I8lrhCyIQKrCt2dcWnNJLgPlr?=
 =?us-ascii?Q?3tLvPSBKLVwwJB1vx5/rjRcyut0grVjcFZSwZIxqOWaPvWa5tfIYusmIXhY5?=
 =?us-ascii?Q?Y6iW+Sot38LFHkVDo8bpSSgkXsMeK6GU5PzhkbSY2XSKi5pNdSrdCOZ892Ls?=
 =?us-ascii?Q?FG7lgIoWwib8JZlXR7G6B3sXeKqOYg/0arCdulPxlaeTBnL67fw5ZgJKvqKJ?=
 =?us-ascii?Q?/Vnm2hpepRkHILJ87GUKJ24/r5qyLCHSgDr4Fb3r+ydUm/txG9IZP6sS1LEo?=
 =?us-ascii?Q?gz6JKL6rtCdL0p5cRoNo7fXM/gDtqU4iHkpPOpBgu3Ea7Q85UBc0pkc0Cril?=
 =?us-ascii?Q?AeA009OyXzg6SFVuqbqsuJZPADEgGg6MKy3xNeZ6S1CrBEQXXW1D87hyW6uP?=
 =?us-ascii?Q?84yRV+eouuQFttSzfHeel9TZzLCsymz6ti7PdCN//JIMRe9QhNivsRFxndCv?=
 =?us-ascii?Q?bKChmpO4vHAKsS3/t8bE1QJM67QfJFjQU/yfG6ncPMs1IAfFBaDRidzZ7+CK?=
 =?us-ascii?Q?IA1xUw76UmeCS6ufAMcmN7pC3WMD4OAvpm4Zrl/4T2cN6c/kp9X5lktjajCe?=
 =?us-ascii?Q?sHEbGoYb9z1tMK/EgkGBCFEdUAfNPdfJed2GkLUs70pYFgBuItINs/Bh8RGD?=
 =?us-ascii?Q?A9wWGGCGKJzdpPbCgsnEImxc94CxWAkcnzDBSq15K26jLXAGij3MXWdiMbF2?=
 =?us-ascii?Q?aJqVr1HINN4cJQ7FJYKGcIHmi/UceOuBJahY8V7B3ui6QULPVvKILaZFAuPI?=
 =?us-ascii?Q?SDVTexMA9ov13jZSv84+b8cDh2wGe8GJaaqLg2eAtK93qV40FrDvpRIhrmP9?=
 =?us-ascii?Q?YUj5TpXqIf9b2D+S8U0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 14:50:45.4683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b9084c-550d-45ec-92ca-08ddd4f89fdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398
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
index c0d2c195fe2e..de3c9c335a2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -280,6 +280,13 @@ struct mes_reset_queue_input {
 	bool                               is_kq;
 };
 
+struct mes_inv_tlbs_pasid_input {
+	uint32_t 	xcc_id;
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
index feb92e107af8..323ec04094ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -339,6 +339,21 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
+	if (adev->enable_uni_mes && adev->mes.ring[0].sched.ready &&
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

