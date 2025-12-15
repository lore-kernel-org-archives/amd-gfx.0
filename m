Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC1BD5B865
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A7110E4DA;
	Mon, 15 Dec 2025 18:16:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d6dbPiXK";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F5F10E4C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfiEyxPEn/r1H8Vjp6WFjrLRTcAMRVCmWHm2SoOJ2L21cs6jAChe8H5VE2YhMnlTwjk1sjnWXi2QBhjWOlpqyIzMBTxj9tq6u39MNqAuJNRHiVShE8pyXvyu7/K0PpCFwQayjYRwYhH/bn9zb8zKTQrwY9IKBBTcX47n75MdE//fpVLsUtiPJIF0LOp9pwJ5zrd3U/69Lt3eqTPf+OkWf3NPykDH5HKpPRxdkDTmfmkxsOmr9uoCD9mEAoVc5ZHIeBQx1ywJUWFyTZwEe1Hvj9JT8T8RjcaLIBDivMh2e2BSoeaz6kOieEoCpDR6ovqVWxARgMnxTGApW7Atq5a7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJ6ZIYxiSGk1l7VZ4eG7JH1GIoRpyyTnZZHYNIAoQwM=;
 b=C3MPfBrT1UegbHgEePCh2rHsn9Ulvus2fRqeRjhDZo20lRuv1EPuhtK+7d2dxUetWcCJZYFat83F8HIsOPu6orvCGE4JGyrwBqWUP1LWaGy5v3ZzchdlX/tD75fAEilExF0GQTZ62Cv2RZF8Bk0KtEr/c5dIGOWMfMb9zCUhHFqhggARnmOOaPP6qQDu0Wxs7Eav6gzSyAf9qN1Dx0OkvUsfOhwq7x9xaghxyPrWHSIqDo20so0t4TDOQE68f7A+UiZ098L6z0bxHzRYfj/8EVwGGTsMZV4OdZHyLvAvmmOhzjmKDnqA15kRpNXNVA1i3gYch74y69CnxpS6AnnYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ6ZIYxiSGk1l7VZ4eG7JH1GIoRpyyTnZZHYNIAoQwM=;
 b=d6dbPiXKOYpDn9eL8NX6U3I4SIQ4snHzuaND81sI1P+FgflIt7vujSCUot03QuXeHpdt11JXsM7IB+K0t+KgPTRtMtBMIgBuA8h+sORusJabcESPetTJFsPNR58xoiV42kLZw1CPiqtfpXdEeiSAbmaGRbBAAqeIS58nC5P0Ey0=
Received: from BL1PR13CA0240.namprd13.prod.outlook.com (2603:10b6:208:2bf::35)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::623) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Mon, 15 Dec
 2025 18:16:27 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::49) by BL1PR13CA0240.outlook.office365.com
 (2603:10b6:208:2bf::35) with Microsoft SMTP Server (version=TLS1_3,
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
CC: Likun Gao <Likun.Gao@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: adjust xcc_id program logic for sdma v7_1
Date: Mon, 15 Dec 2025 13:15:56 -0500
Message-ID: <20251215181607.29132-9-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bc2b1a-e08e-4703-7073-08de3c061019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LTHz7qc7O4ZxyaK09OsN6b7KiNPU/ufMrKfsf7bJLlOf2+ZQAJ9qehzpbX9F?=
 =?us-ascii?Q?fmI7tfr+KsyIUTEwpef7K+s3kni3Gpku0gTofo/GtAfINs8bifCOzu3DSBI9?=
 =?us-ascii?Q?u6kc8qp+xKPuJ07xzBJ0ynLZN9onepLFS4NCXSGFnh+h0aaslpsjFFAN1rZO?=
 =?us-ascii?Q?OnTnB+dShPUoh8P1WVDKcpGPDkt8/D5nMy5HRrruhN2hGsYATenINXSzcHcL?=
 =?us-ascii?Q?VOaAasFGxY7jBxSnw04RQHQ8rEVRajzlXscNloxo9ssVYUuWLET0/k3yTVZt?=
 =?us-ascii?Q?Vt+NmZEGG+1wo6Z3UGr/601LOkf2k29m0RHJVssAHpChR1nPDnyUsqlsHCaY?=
 =?us-ascii?Q?zM3NCzyVPgcxum3f1dyce7QELRhzapn+HpH1u0FeOpTVZobJXG6w3JRLmVIL?=
 =?us-ascii?Q?dhVY+p1PXBW90uatAqvCO5/+9XgJeV2QjSDdHGshnMSn/xUHID1FtRl64rFw?=
 =?us-ascii?Q?4LfIE3DMYocEv5wqMZ1vgjVHOG2Xa55E0VVHIqpWMfvrMCXCbzPYOriGlRff?=
 =?us-ascii?Q?peSOFxm77SGxJidk3GZYqLBMoolXANGacbAMGAxjMyDBf8hsgjNqg/pcdflL?=
 =?us-ascii?Q?sUzdhb6rOqBlf+F8IRPJuWY2VBaIlYCRzs8+XkFkCGaJ/uXEdXUP+a223aAa?=
 =?us-ascii?Q?G/EQs392l63AgOn975Haq+tXbFdMZAOvD1uUnlAZN/teRJdALlZaLMwPBsmB?=
 =?us-ascii?Q?nGq8EHtBUFa/x9ipi7z/qcrTPB/NJRyIrz9WQRK62EGen8KzhKFT9s/fyCiR?=
 =?us-ascii?Q?vRlbq1y1zqgheK6S5HK6QGE7NoQngfrgtpCbQ/YFzMxlyr3YwsTuJhbIH6OA?=
 =?us-ascii?Q?FmBY3KsAbTNkHRZjFso2fsHmK+MJVDquL4D9vIosRloHa3Ick4V7Z3b6Fr/+?=
 =?us-ascii?Q?1WP20AeQt9db20xHUz+Bkastb3J6ftXmP43XMhctxR1FDMtl9TxpUARCyNYG?=
 =?us-ascii?Q?iOUa6qsjOioK1q0ILrkn0T6zhLdOgAi2nkywO+aWnO/kv8vnUgYMfjx9nj0F?=
 =?us-ascii?Q?+algizi+v3rrYafKNIBlE5NzsroCwVr/Vc3jkekvDq7URFXkc71uQ/rWAgjL?=
 =?us-ascii?Q?GqDU9u00Z9djDm/OO+mUC6kc7IIJln6y15ICZGjn1vrAg5Sa/7uoiikk0LLO?=
 =?us-ascii?Q?E3U183Qr3MqP7MBWVWdZSAZpANtwmg7b3IprilTz5izhLjr9gMUeYJlufFnL?=
 =?us-ascii?Q?sh0b9hiSD+hguYIZkIiBFjScLXRDCYGhm8DJ2UIxzQ531GgA49gfDOYb/M+c?=
 =?us-ascii?Q?SK2yKnGyKbaAtrg6ntIDfO29o5WZTsHUWiKITIfClmmiKYFZqXlMEhHQb19u?=
 =?us-ascii?Q?KtK2Ju6+pCMFTLwjphRTBGL0ZSMyKJxzDBcGXHb106Foiz3vDjo9iR/UI/SR?=
 =?us-ascii?Q?pxZ/NX4EqgEKnIGLkqGfdqHDgIqShYyrM8mdaD2dltsePIcLK5QRJNv6x2DU?=
 =?us-ascii?Q?nSKFczZ3NPHA2KQM04DZ1vdG6n1g/4BYObEcmuvUojHGIC0f+w3i7QgyXwjo?=
 =?us-ascii?Q?w49LSHC1Og4LLIodpcvpkjaNUzyqkhBQIzqEUI4sH0/ZursGBOi54oLXHyvV?=
 =?us-ascii?Q?DZO3mhoYCSjd6kcqc94=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:27.0307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bc2b1a-e08e-4703-7073-08de3c061019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1
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

From: Likun Gao <Likun.Gao@amd.com>

Adjust program logic for sdam v7_1, only use physical xcc_id
when program register to support compute partition.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index fe0e84b45cf4b..6ffe05cc1d1eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -369,7 +369,7 @@ static void sdma_v7_1_inst_gfx_stop(struct amdgpu_device *adev,
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	for (i = 0; i < NUM_XCC(inst_mask); i++) {
+	for_each_inst(i, inst_mask) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_ENABLE, 0);
 		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_CNTL), rb_cntl);
@@ -436,7 +436,7 @@ static void sdma_v7_1_inst_enable(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	for (i = 0; i < NUM_XCC(inst_mask); i++) {
+	for_each_inst(i, inst_mask) {
 		mcu_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_MCU_CNTL));
 		mcu_cntl = REG_SET_FIELD(mcu_cntl, SDMA0_SDMA_MCU_CNTL, HALT, enable ? 0 : 1);
 		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_MCU_CNTL), mcu_cntl);
@@ -617,7 +617,7 @@ static int sdma_v7_1_inst_gfx_resume(struct amdgpu_device *adev,
 {
 	int i, r;
 
-	for (i = 0; i < NUM_XCC(inst_mask); i++) {
+	for_each_inst(i, inst_mask) {
 		r = sdma_v7_1_gfx_resume_instance(adev, i, false);
 		if (r)
 			return r;
@@ -647,7 +647,7 @@ static void sdma_v7_1_inst_free_ucode_buffer(struct amdgpu_device *adev,
 {
 	int i;
 
-	for (i = 0; i < NUM_XCC(inst_mask); i++) {
+	for_each_inst(i, inst_mask) {
 		amdgpu_bo_free_kernel(&adev->sdma.instance[i].sdma_fw_obj,
 				      &adev->sdma.instance[i].sdma_fw_gpu_addr,
 				      (void **)&adev->sdma.instance[i].sdma_fw_ptr);
@@ -686,7 +686,7 @@ static int sdma_v7_1_inst_load_microcode(struct amdgpu_device *adev,
 			le32_to_cpu(hdr->ucode_offset_bytes));
 	fw_size = le32_to_cpu(hdr->ucode_size_bytes);
 
-	for (i = 0; i < NUM_XCC(inst_mask); i++) {
+	for_each_inst(i, inst_mask) {
 		r = amdgpu_bo_create_reserved(adev, fw_size,
 					      PAGE_SIZE,
 					      AMDGPU_GEM_DOMAIN_VRAM,
@@ -744,10 +744,10 @@ static int sdma_v7_1_soft_reset(struct amdgpu_ip_block *ip_block)
 	u32 tmp;
 	int i;
 
-	inst_mask = adev->sdma.sdma_mask;
+	inst_mask = GENMASK(NUM_XCC(adev->sdma.sdma_mask) - 1, 0);
 	sdma_v7_1_inst_gfx_stop(adev, inst_mask);
 
-	for (i = 0; i < NUM_XCC(inst_mask); i++) {
+	for_each_inst(i, inst_mask) {
 		//tmp = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_FREEZE));
 		//tmp |= SDMA0_SDMA_FREEZE__FREEZE_MASK;
 		//WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_FREEZE), tmp);
@@ -1357,8 +1357,11 @@ static int sdma_v7_1_sw_fini(struct amdgpu_ip_block *ip_block)
 static int sdma_v7_1_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	uint32_t inst_mask;
 
-	return sdma_v7_1_inst_start(adev, adev->sdma.sdma_mask);
+	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
+
+	return sdma_v7_1_inst_start(adev, inst_mask);
 }
 
 static int sdma_v7_1_hw_fini(struct amdgpu_ip_block *ip_block)
-- 
2.52.0

