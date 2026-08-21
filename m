Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F52C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE4710E2AD;
	Fri, 21 Aug 2026 19:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bLmu9z59";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C267010E2AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWEv7z+lqRb7LtYviTInFKWrjkSnHtJsmVsqI1FwFpofHFwESAQDo/RMse87mG/G1/HAhs7BXftpCk6q7MaZaZTO9yvnKt+XEetGyJ+rbPVj1ljQUOGQm/LHVZXEV7/XdmA9s6DgAx1qX8fBc44tlbXO+oasdtHt8ZU5iSyqkZO6+b9yj5c02I1T+g+n0s+dAVNqOIwKeXiIXH/fLdV0Ia1XVm6H/ykXoKpffwGcPFQYABVbVRDaOSEk9HhknmtZ299TsubSgIGmf+dKgxEbAn17f//c9E8wi7iYLYuMKKM6T23I2rJktqJMSCmGC2CfY487TFCxYHArJixqHeSPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMDYnrAt1c5QaTvisXVeRtwY9oh88CX+D+9n1/ZI6rA=;
 b=qQChmvu6ELOB2kLfj28AXGmA1/mANQBJ71r1pQ7DshyOVL7Jzvg5RkOHTAlv1m9RyrId5vskVQCodD/0DnI9DFKZER0SARsnF+XCpQvNLaE4eTEsHoJLa58cOz1x4behw0Ljm2d28eDb8LQ6JUjSD9L2nBz5FPZ440GKBVfRKeGI6F3pmXImqrzfkoJJv03+yIrDxopCT7hyZIFtTCT+GEBKLw4icPim6DEmMDaNZDAnNOC9xlkjqDinl5+dfXuNplbi+SCjHDqk7zxC9MYLO17Ogk/xGUDlXX0mEIV/IzgjS6clEGyEc4HzRin70zgA3ttCZWBep2KhMRgStJAvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMDYnrAt1c5QaTvisXVeRtwY9oh88CX+D+9n1/ZI6rA=;
 b=bLmu9z59ezIf15Ns1+q5TMR/310pmg3Blmb+stuniW38pwsXzdhh5XliT6ANvpF1lG9VOODXTFbVoWtRr50w/mMhna382n+kza2WbQGbQaBn6eYxhC4S7V6Mp8VKVjpuqHIPdcq65Orzb6Q83+wo7Z1VXqndNHhHW/5lMJVBipw=
Received: from MW4PR04CA0046.namprd04.prod.outlook.com (2603:10b6:303:6a::21)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:34 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::91) by MW4PR04CA0046.outlook.office365.com
 (2603:10b6:303:6a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 19:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:23 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Gangliang Xie <ganglxie@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/95] drm/amdgpu: add handler for nHT error
Date: Fri, 21 Aug 2026 15:33:42 -0400
Message-ID: <20260821193458.808626-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 3333a610-0e4f-4f02-89e7-08deffbb5e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tY+hADHX34i9E1Esub88laHIGEHWg+3f4Ee2IFrvQQaDpeGJv/1yZzVQ7vfCO0BVoaTAof3sGKtBmEAFm4P621osiJDa3EWY8p6JuKzoEvB+wgqPT6NmVSvga0y/rprID3fGqccm8O2mrUiUBsKcgTa0/I95RGcmQocCkND5x1TPlKRyDREPlZwSScvSuE/hS8EmQiJ3QyvCWsWC8bCO0TxS6QbYN8eUrvCQYbD85+IpmhoqUdC91gk+O+sR6ZNmSujpHpd0Vx/rqt36kSP/BVqU/i7I4Av01zdrB57B3WhE+OJMBp51hogDM/HzU8NjtWowVgFBwL9v4V3g1QL0j7VFEub7JiADOZSBE6WEoPMfksQAizWCNdSVsHfw9df/ANWYDpzDvgrp1eRXh3Fnf5kF+2W6HbbJhgttImK2PDCmKLI6IOD6nz329K7+4TXROMA0ZHjgAYreaBtlfalw0OtKJQeDn52fqolgMbaUx6aTHW9s3YzStMXn7vEC5RQ5Bye34Dg4yzLDTTbxwY9oXzwLXPn25LXpIDyGDUCzgxrOuceGuCgbvBaEzX+llb/J9QXCCixZz9VGWA/QM18P3aowiQlC38EWatlQhlR2CbPOcX/acAyEZtvVMGkTVJ+hhweYiQ4xJgXwyjWORJJgMQ7fpfFc6yWAigMq9bGB+KxMQJF5hY8STpXA9bkqqZKkMxdKNc3y+ZSnjpsIoFhzfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: duf3j6QBmTyjVIC0x19I+Yb4QcOzpli/AnPEbueO3ya7CHZWtGKO8u6A62C8FfcX2pmDr3dzXW2i0Ztd1NWT4khlPwZpf3uJmQnxx1tz9fN+8zNtEMap0O3DswHUmJ9ltYSE2FC/uurcgyKtoW58IK7kZc2ue8rGYQfw8eUvV8EZRlYdbsC5B7HugGxzanL5jQ2vpWge3JwO1/fU2lx3gXTtdgQPOENdR8/AStLSuzhZbbAhZZORdvOJhAMoZmf9uCBOzVFuM6tG4ulIcjiuUZarJfsUt9mFbzqaUjDrthkobuiGAlyWWV8kI9O00pvmm/z8nexJBkp7HqLcuwANN/9vWkmWJrkiopmzg5hxya7PMY2RIB0V8POr+qFCXYIZwlNVFUYhFdCzYyolDq4GQOxAA7NWgVca3xwyQGaqVZRj7SJ+9cjeuUIhMvvcYNN9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:33.9327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3333a610-0e4f-4f02-89e7-08deffbb5e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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

From: Gangliang Xie <ganglxie@amd.com>

add handler for nHT error

v2:
	add EA ill op check

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 44 +++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6722213db8f01..f5fb2e585e8ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -478,6 +478,7 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		sq_irq;
 	struct amdgpu_irq_src		rlc_gc_fed_irq;
 	struct amdgpu_irq_src		rlc_poison_irq;
+	struct amdgpu_irq_src		pmr_ea_irq;
 	struct sq_work			sq_work;
 
 	/* gfx status */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 4f34a963acf34..b4570bb276d1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1495,6 +1495,13 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	/* pmr ea error */
+	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_GFX,
+				GFX_12_1_0__SRCID__PMR_EA_ERROR_INTERRUPT,
+				&adev->gfx.pmr_ea_irq);
+	if (r)
+		return r;
+
 	adev->gfx.gfx_current_status = AMDGPU_GFX_NORMAL_MODE;
 
 	r = gfx_v12_1_rlc_init(adev);
@@ -4055,6 +4062,36 @@ static int gfx_v12_1_rlc_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v12_1_pmr_ea_irq(struct amdgpu_device *adev,
+				  struct amdgpu_irq_src *source,
+				  struct amdgpu_iv_entry *entry)
+{
+	uint32_t ras_blk = RAS_BLOCK_ID__GFX;
+	struct ras_ih_info ih_info = {0};
+	uint32_t ctx_id = entry->src_data[0];
+	int i, num_xcc;
+
+	if (ctx_id & 0x1) {
+		/* request RLC MCA logging here
+		 * nHT CTO status clearing is handled by RLC firmware
+		 */
+
+		ih_info.block = ras_blk;
+		ih_info.reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		amdgpu_ras_mgr_dispatch_interrupt(adev, &ih_info);
+	}
+
+	if (ctx_id & 0x2) {
+		num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+		/* ea_ill_op_status will be cleared in a future update */
+		for (i = 0; i < num_xcc; i++)
+			dev_warn(adev->dev,
+				"an EA illegal-op is detected and need to clear ea_ill_op_status\n");
+	}
+
+	return 0;
+}
+
 static void gfx_v12_1_emit_mem_sync(struct amdgpu_ring *ring)
 {
 	const unsigned int gcr_cntl =
@@ -4183,6 +4220,10 @@ static const struct amdgpu_irq_src_funcs gfx_v12_1_rlc_poison_irq_funcs = {
 	.process = gfx_v12_1_rlc_poison_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v12_1_pmr_ea_irq_funcs = {
+	.process = gfx_v12_1_pmr_ea_irq,
+};
+
 static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
@@ -4196,6 +4237,9 @@ static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev)
 
 	adev->gfx.rlc_poison_irq.num_types = 1;
 	adev->gfx.rlc_poison_irq.funcs = &gfx_v12_1_rlc_poison_irq_funcs;
+
+	adev->gfx.pmr_ea_irq.num_types = 1;
+	adev->gfx.pmr_ea_irq.funcs = &gfx_v12_1_pmr_ea_irq_funcs;
 }
 
 static void gfx_v12_1_set_imu_funcs(struct amdgpu_device *adev)
-- 
2.55.0

