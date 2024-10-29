Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A40DD3A682
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A34210E6D2;
	Tue, 29 Oct 2024 17:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZTKjSwBJ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B019810E6B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuBXinCwWHa+NhcbQh7J5oBScuo77K2OcnzIvGM9kPLOfPDhWkEpmRWSXfLJKVJFb3lXSWNEEyA7E+ZUbCwx7/fDuiLz1qu416frkv1U2sYbZPF+gNHbAUCi0AqnubkjOyS6LkYFLqSPhh4Erl0dZVCTnPIBZ0bM5gkt6/gU3VXX5a+M5GA7h7o8yT/hlpcQdr1rw1sv1PzvE1szbV8c07TyAPtH0DGlbAAZlI6N89s2+h+klG/jqjCqgX0loUMbvAxFN2rgkYW59ZvExjsWdhdSU7E4AetTVl6T3pF4AnT0RYkPZBywSZvaG/v/Zu6rkYFaLFBPFkME+meak13eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8mstovdGgPjj498vbSzvZ0YnogDMAW747R0qOK90G4=;
 b=zWP7eSU7VWNTCdRbJnJbVtubSQrm6rMSJBx969Jfdx86T6qOtezkvzo9GkyVc9MpP8GH2r9q0PrwqmMvAjCLqPAXAXzvLtFyFPbGkHtDZNnVEtFdKYM122HDpfi3bT5d7D1xcDUE5fih8nSb6GhhnqR0vuPUvB2IFkRWjP7RompBhrFNyhqt5yIFkrosrOEAB/8UuE3cFtgRkcITDz1cfLg9XD07IOvNNSthj1E0C82WLqj+N94mPXAHt+dn5RbM2WHnbRFdO9kmnPyI7LhrmdFU1xJifViL6seWO4Vdc2qwv60AyGCEcxwEmbjm6UBKmTZ1Ay4ptD7QEIeU0ZRyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8mstovdGgPjj498vbSzvZ0YnogDMAW747R0qOK90G4=;
 b=ZTKjSwBJc5wRN65MmVt6xHT4Puri9EheYrDWQLdj6m54P/i5MUlRuvn8NqmOmk/91d29dJR2D1low+7+wXHJdp4Vy5DxKOBZHCTu6Npqk5d3Oyc9YdDizCuM0fExO2damzvPnsrgwktTbukUQ/ZUfxX8QKBOVpMkbdbp/6AvsGY=
Received: from SN6PR16CA0038.namprd16.prod.outlook.com (2603:10b6:805:ca::15)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 17:43:09 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::3c) by SN6PR16CA0038.outlook.office365.com
 (2603:10b6:805:ca::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:43:09 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:43:03 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 25/29] drm/amdgpu: resume for each vcn instance
Date: Tue, 29 Oct 2024 13:42:36 -0400
Message-ID: <20241029174240.682928-26-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 463181ad-e3c3-4b8b-81a4-08dcf8412765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KN1NiXd+oDPBMCmEoJb25yPVSIYjtlwb26PEZeiyCNSK6ZpbU4u5NboVT42B?=
 =?us-ascii?Q?Ih1CXBRo2rhMUROLOV94sPxogG5DQsorj6fQautmrC/3MpjHl06Es/97qbvT?=
 =?us-ascii?Q?LPBoaJXIOT+sCMfIrcUe1JzB9DyLad+jHEakG1bu7sCKNOOZs1j3z1efjcyn?=
 =?us-ascii?Q?B1LAiqEAv/WYv1pLyECBQBsGLltmc48wj0TH+YxcMQrLI4YNH99qDy/CszaN?=
 =?us-ascii?Q?dINCqvfVTPPf+xpshkS2G17YbNSX/2lm/gFh29iHAalT3l5SRo6BnWYPHLQ0?=
 =?us-ascii?Q?fxS9fgYWMKIYRDqtG5bk6p07JY+MZVEDoF72/1jQPMO1cSfJr4aqeUvETO9B?=
 =?us-ascii?Q?BtAE2zCmzqXvQR/71bT+J33BDyBCLWnUkVAUNspBfI0TpcRIfq9/YOBR6YKn?=
 =?us-ascii?Q?WyOYgKrzILupmRtWGqHDzBn8LxtLab2j14mRzlVNNVNfLlHAeiWQ67BCU/C9?=
 =?us-ascii?Q?NNoQwL/TAQHucAGxDUELo0sFlZldOhOOrxcScwj4NETtuZIRaufmHhWbhj5L?=
 =?us-ascii?Q?c4K4abIuwPqs/bu6mNSFhbcHca7va2G0mNXwTvrmmncn4U5RZrLcdquOxmCz?=
 =?us-ascii?Q?r03hCtAQIP/nxjc+MPFwr1mtsT4OeUoH+PpDOsBJWH2AQqphZaZTP6Vc9cIp?=
 =?us-ascii?Q?8FQHRqLBtlkYAKtn9kIz0Yjk7V1I5KlsSRFWTTPTYlXZMep+ryMhPqXjATNP?=
 =?us-ascii?Q?YlK5cEScJdslndiY+4ywSLjU8n43kbZBpcHzT6W7Z9YNsMmGp6S9qK6MoKLJ?=
 =?us-ascii?Q?tg7UWmHpUKyQeymtC7t9vyDdrwwoTyrJyAezh6T63iZeMwrbVTgkBEhgdGF6?=
 =?us-ascii?Q?Huvy5Kf13imMShIzGmSJL+KrmBXrOnPHOw5/p6VASnnKCOvxM+eSeFxPB1mB?=
 =?us-ascii?Q?xofqQP0tdnRSKut+pVmsiNffMBGeWT1R3VwHrpAPYVNrASsfgHehb3+1/6Jx?=
 =?us-ascii?Q?TJ9szyeA4dOmUBeyyHrQZpeMmVb8cNjt7g++aDfU3TqmmGwjsAkasvFJv1yo?=
 =?us-ascii?Q?dWBbWIzMiiHWEjvDoDtey5lBYb3LWPgzw98m14x6sx/R8qz7Pi6hLOn0QxFU?=
 =?us-ascii?Q?ydJwcytv2MJvlW/42D+fYx6mNECRr+VjzNuksAhKwHAEmD996EYxfI0CMNf6?=
 =?us-ascii?Q?pZX1HiB9rPiLoTnhjo8hFIdt+rcOu56vrnUrXgNMtuJw9wUAQB3JvmQiN27J?=
 =?us-ascii?Q?EILDdSANAUghGYIUbZqftKvYuSYisOQhM1V+KmkzJ/uDk5qs33X1byqSzRmL?=
 =?us-ascii?Q?uXQWLTPLnUIl+YjeZ4mvuB9MpRjeL0v+HLE3rxuU6fspKYW0SOKNET6U07m6?=
 =?us-ascii?Q?ol0wFZ6QW2bnqqso73+DmH7Vswzf6IaLKqV9l0n89wJ3vyFfsB7Urr1S24ZA?=
 =?us-ascii?Q?5VUBpD2CtD0HevFG+gZ8NtFLANiGkglBVfA5ECStOLyi30G4Hg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:09.6513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463181ad-e3c3-4b8b-81a4-08dcf8412765
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_resume(), and perform
resume ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 60 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  4 +-
 10 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 50047c636904..c4e1283aa9a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -335,47 +335,47 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst)
 	return amdgpu_vcn_save_vcpu_bo(adev, inst);
 }
 
-int amdgpu_vcn_resume(struct amdgpu_device *adev)
+int amdgpu_vcn_resume(struct amdgpu_device *adev, int inst)
 {
 	unsigned int size;
 	void *ptr;
-	int i, idx;
+	int idx;
+
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->vcn.inst[i].vcpu_bo == NULL)
-			return -EINVAL;
+	if (adev->vcn.inst[inst].vcpu_bo == NULL)
+		return -EINVAL;
+
+	size = amdgpu_bo_size(adev->vcn.inst[inst].vcpu_bo);
+	ptr = adev->vcn.inst[inst].cpu_addr;
 
-		size = amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
-		ptr = adev->vcn.inst[i].cpu_addr;
+	if (adev->vcn.inst[inst].saved_bo != NULL) {
+		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+			memcpy_toio(ptr, adev->vcn.inst[inst].saved_bo, size);
+			drm_dev_exit(idx);
+		}
+		kvfree(adev->vcn.inst[inst].saved_bo);
+		adev->vcn.inst[inst].saved_bo = NULL;
+	} else {
+		const struct common_firmware_header *hdr;
+		unsigned int offset;
 
-		if (adev->vcn.inst[i].saved_bo != NULL) {
+		hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
+		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
+			offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
 			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-				memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
+				memcpy_toio(adev->vcn.inst[inst].cpu_addr,
+						adev->vcn.inst[inst].fw->data + offset,
+						le32_to_cpu(hdr->ucode_size_bytes));
 				drm_dev_exit(idx);
 			}
-			kvfree(adev->vcn.inst[i].saved_bo);
-			adev->vcn.inst[i].saved_bo = NULL;
-		} else {
-			const struct common_firmware_header *hdr;
-			unsigned int offset;
-
-			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
-			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
-				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-					memcpy_toio(adev->vcn.inst[i].cpu_addr,
-						    adev->vcn.inst[i].fw->data + offset,
-						    le32_to_cpu(hdr->ucode_size_bytes));
-					drm_dev_exit(idx);
-				}
-				size -= le32_to_cpu(hdr->ucode_size_bytes);
-				ptr += le32_to_cpu(hdr->ucode_size_bytes);
-			}
-			memset_io(ptr, 0, size);
+			size -= le32_to_cpu(hdr->ucode_size_bytes);
+			ptr += le32_to_cpu(hdr->ucode_size_bytes);
 		}
+		memset_io(ptr, 0, size);
 	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index be681bcab184..75cfdb770672 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -487,7 +487,7 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_resume(struct amdgpu_device *adev);
+int amdgpu_vcn_resume(struct amdgpu_device *adev, int inst);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index a3845e7747b0..77f9f34eaca8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -156,7 +156,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -331,7 +331,7 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8e943d1fae17..87293bb777d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -161,7 +161,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -359,7 +359,7 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 9ca07e56b052..62266db72531 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -191,7 +191,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -436,7 +436,7 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index a25d2b9784be..d29c49d061d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -174,7 +174,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -468,7 +468,7 @@ static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index fcf7b23cca90..509dc6b5f43b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -182,7 +182,7 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -396,7 +396,7 @@ static int vcn_v4_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ece9b1df2743..070cf516f365 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -139,7 +139,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -355,7 +355,7 @@ static int vcn_v4_0_3_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f1ec632a9eb8..ad9e67d9134d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -144,7 +144,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -347,7 +347,7 @@ static int vcn_v4_0_5_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index fdfb3084d54e..9999c8094920 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -128,7 +128,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -311,7 +311,7 @@ static int vcn_v5_0_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
-- 
2.34.1

