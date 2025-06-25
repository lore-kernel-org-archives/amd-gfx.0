Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972BCC7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 22:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B0110E807;
	Wed, 25 Jun 2025 22:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NtX+aO3a";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D07E210E807
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 22:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLODXRUkQZkIzBmM6FP+JAvZjDDuqDhdxONZiu5uJdmcmC6EERyF492qlJFavwggX6Tj9Gfm2Moo0JoX8xUeTyZnrGER+gfP35kVhyRZxMd8W0KffJauq00dSIkc5Mn5x7hy2MIRi2/+Zy5WP2gdVSyDwyNm8Gbjlcj0O5UxJVQjplZGFDbEepHGbZ6QA+csvqjhZfiWodyVHf9vKc+6cJ+bnBdtazNpogNq2z8I4uWhwS6l9ZUiCBmjuZNtbhpWl8hP9U3a63yjoOY++VIiDyDOMiC7v+VB0cewZ6N2Oi1PKQ1emNXZrL3dsRBhshOJsb7R/AT21NncWI+7Gub+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ36yfxLcwRAA9BrxtWi7/3oV9M41YgMBzLjnZOnbV0=;
 b=MrfmAnIEB+FIQTKOL6H7V0uQDNwwirc5xJpTIlsf4WNvjZKDiJp1X6cnq08ryoatMHBcBChkw+WoSSpKNYfN0P6FmbjNZMl0sWxpLCcDd+1/SLI42VPgROT02KKpRlHmEAWfLRp8R9Y+CWApiJi7ZwxjndvUrury4vgh9LcOO0fverkUbYnu0OfGzYBp0sPVoUzf+Py0HmyL8uktyQrJfzxD1kDkHOoyAGWjCY+TuwBI/G/6htuJHCB9PVwkSl+RTuB2AnDMAi3R0+lBkkRJQhP47lYtqSlWKQKmlr6WBVRl4BDvHsLqzEuemCyYPWeA4VulOypVm0H9HeIdemUFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ36yfxLcwRAA9BrxtWi7/3oV9M41YgMBzLjnZOnbV0=;
 b=NtX+aO3ajKTmFctpwWWZoYdFsGRMpskOeftMkd0sW0TAYmO97styUHgTmvHu5zTPXm42DGngUssFs5nLgOkHgC9x0EAxI5gPl1vTuE0l6wRRJFxcGagsj3by2knywywKAFHrchadK7KF64TDDkRRMl+GNSxp1ffkydf5FdjS9pI=
Received: from MW4PR04CA0122.namprd04.prod.outlook.com (2603:10b6:303:84::7)
 by DS4PR12MB9587.namprd12.prod.outlook.com (2603:10b6:8:282::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 22:23:28 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::24) by MW4PR04CA0122.outlook.office365.com
 (2603:10b6:303:84::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 22:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 22:23:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 17:23:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>, Johl Brown <johlbrown@gmail.com>
Subject: [PATCH] drm/amdkfd: add hqd_sdma_get_doorbell callbacks for gfx7/8
Date: Wed, 25 Jun 2025 18:23:12 -0400
Message-ID: <20250625222312.439685-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DS4PR12MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: a647cfff-0f50-46b5-6472-08ddb436e889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XEaRwVTPt/lvnp2rJdTLfrfJrKk6nBDTL+HofSHwSk/IjBsfj7rcqzD2vqJx?=
 =?us-ascii?Q?j92xoHdkUvupuCpcOLs5/9JRxnf8lJkNqC8O0fMZSemXcJB9Wv+D/gfJW1DF?=
 =?us-ascii?Q?bsg22/+Y9gOk+DPkTCqu4UvCW97k9+cPhTwDi5bn4CCTi+DGEncYz+M35vqc?=
 =?us-ascii?Q?ksDxm26D5EW/3UQxF4nIaue34dnLIeAgbZGfq5ap5j+ZmUQt+bOqfTl+i2iN?=
 =?us-ascii?Q?H/LCHeJnWNRDnsymE/oG2qoPmwClqNyRB1qhKNS8VNgPJoVWyd2rE2XPb5Xf?=
 =?us-ascii?Q?lJR9K8EvAiNXj+APBQnXfYtoJ9F6NUXf3jb6Os3dO2JStMXa5Q79vNNJXg4a?=
 =?us-ascii?Q?gP1bVUuvlrz8UIoRK4ihrdSbna7Zih+6gIh67pZxLmbmag7gq8nH7qBz5t3N?=
 =?us-ascii?Q?kYIU99TZT0XtG3r41ENkDc8RB6Hcb5r+98qnMw4ZtrHVGLl06qREecSTINAP?=
 =?us-ascii?Q?dp6wCZVATBpdnPAY8uyqqW72y6w4lT+8lnVQ9tlcKNOmFBx2joDT7RtpwgQD?=
 =?us-ascii?Q?kkqKeZ+J9A1T7qtyo9dAPutW3zuXYYh5N3omrmmsj6NK+W5E6XnSEMkQ2Jd+?=
 =?us-ascii?Q?K/8UGLj3pbxgou7XbdQ+TqRsSykz5S6OGyl40UtNhbKqIox9akGanvpUmcN3?=
 =?us-ascii?Q?wcxOzz+pdu+/gzqR0atEMEbebpzJP3NCrJhCGynbHRk6w4vVZ1Mj+YSiXtef?=
 =?us-ascii?Q?qRrU60HJU4DBP5mECyaz4SS2/QPrxqXFRnhUI7XE2PCWpCXKs823z6ojzD3Z?=
 =?us-ascii?Q?p1sgyejh8zJA+yTypRg+7K+NFq2C0oZhK2hfPVtRmfKUZQdeZLq1yUDMaHmd?=
 =?us-ascii?Q?yXj8sI7ImWyVHH2kcMWi+2pl9TODMpOUU6zRdxsVSUkZ3E36Mj6u8Veu8goE?=
 =?us-ascii?Q?+P05ilxw2Bb+X/j5cEnVfhaTyU5B/N2iZkXff1TQ5t/6ixy7mz+uMH5cUQM6?=
 =?us-ascii?Q?2h/JzATKeIYHMHST9FNuySiXgc6SP76WWCvzDML1M1t+2s59VoKnll790pH8?=
 =?us-ascii?Q?3F192zteyyy0DZjte5OjQXZZxaHE4uz7TSsnEDNQQ2c+LprXVapfs1TAkU2f?=
 =?us-ascii?Q?Z3lUXJj5me09u4oJ4dMIl5/kr4lORC1eD4BcVdmyN3oW1hze77atjidHpFLd?=
 =?us-ascii?Q?ziz0ts8Zv41ohP5H8Vlr1MeWI2gGVIozIOsHji7+0MV0kDSivRt5UaPkiuU0?=
 =?us-ascii?Q?I6UFIm8m7moTHDDI3KmzoP5tCSRWcF353AYTFwHox9AFTG5eNchM124EAEcw?=
 =?us-ascii?Q?rY/j4siXtaQe3xtqgnkFw2+85SUSFaIUzHDWvAcKI1utDr9GXnkLMNkCErFU?=
 =?us-ascii?Q?PRTbFP405F4j+InIEBRW7jOnPoZ5GY3pEIvsm0p0tHtnhf3jMWjyUlXoC7uM?=
 =?us-ascii?Q?0mTbmj7/qJUWHhvNhKteLGSXzbQLBUm5OoqFqrBLAH1CZSP+ZeN/2mVtl0E6?=
 =?us-ascii?Q?cHlXs/6mmA1TfxMs5lQU9e+m1Nb/Ggs2TeDGUGPvHqsrdEdMViqPUzpkChTQ?=
 =?us-ascii?Q?4Id1t4cSf1knSBe14dU/VAOcGGeScFIApCft?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 22:23:27.7680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a647cfff-0f50-46b5-6472-08ddb436e889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9587
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

These were missed when support was added for other generations.
The callbacks are called unconditionally so we need to make
sure all generations have them.

Fixes: bac38ca8c475 ("drm/amdkfd: implement per queue sdma reset for gfx 9.4+")
Cc: Jonathan Kim <jonathan.kim@amd.com>
Reported-by: Johl Brown <johlbrown@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index ca4a6b82817f5..df77558e03ef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -561,6 +561,13 @@ static uint32_t read_vmid_from_vmfault_reg(struct amdgpu_device *adev)
 	return REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS, VMID);
 }
 
+static uint32_t kgd_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
+					  int engine, int queue)
+
+{
+	return 0;
+}
+
 const struct kfd2kgd_calls gfx_v7_kfd2kgd = {
 	.program_sh_mem_settings = kgd_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
@@ -578,4 +585,5 @@ const struct kfd2kgd_calls gfx_v7_kfd2kgd = {
 	.set_scratch_backing_va = set_scratch_backing_va,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
 	.read_vmid_from_vmfault_reg = read_vmid_from_vmfault_reg,
+	.hqd_sdma_get_doorbell = kgd_hqd_sdma_get_doorbell,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index 0f3e2944edd7e..e68c0fa8d7513 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -582,6 +582,13 @@ static void set_vm_context_page_table_base(struct amdgpu_device *adev,
 			lower_32_bits(page_table_base));
 }
 
+static uint32_t kgd_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
+					  int engine, int queue)
+
+{
+	return 0;
+}
+
 const struct kfd2kgd_calls gfx_v8_kfd2kgd = {
 	.program_sh_mem_settings = kgd_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
@@ -599,4 +606,5 @@ const struct kfd2kgd_calls gfx_v8_kfd2kgd = {
 			get_atc_vmid_pasid_mapping_info,
 	.set_scratch_backing_va = set_scratch_backing_va,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
+	.hqd_sdma_get_doorbell = kgd_hqd_sdma_get_doorbell,
 };
-- 
2.50.0

