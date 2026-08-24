Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679AFC61DC2
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ACCD10E875;
	Mon, 24 Aug 2026 22:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lKggJZdb";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012034.outbound.protection.outlook.com
 [40.93.195.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5EB610E86F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rqn8thNOX+HfRqUbCAOUFVfTMkjCEx31+dsgx2+LWmzbINtW5lL5VJTvNbozOrrOBIBEQDJA29qD7ndfstqwssCv0Ktkc51M9NnuKrmpEplUFwIhlS9mx+gier7JaNUzaI4+ZnuUq5g6pzbtxwbKyKl7WDfG4kVR2L/a6ZNCfORhRPchACpCMoxc71Q8cSFt8NRyLhs52afMmTdqsAy6dTZmT69bK5KoKMFRYUQYAdvIwjvey/RkSDKgfTyKY+xWaw4WBKprMN1u2LBXDWj+MKa+dRf/R+NsFJNlddD0u82N3DW1/MmNA/00UEgkutqajUBK1EhWmIc4ble/3pJBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHbtdImXLTnInaSdVmWa+i9DUhd6N53xKkBOSoL4J0w=;
 b=CAFNjQfdYW8v5flJyynBB1FxFJtR5lGQ/YgjVRGMcVJL26ZFY4C2mlWvLXmNflct83FbFMtheNm+fT44CmqLU5LugcUVD+JKjomx7DryWbNCDCIClU4JtQD11vWcJEyMCL48OPvMz5jjnwmaJCWKhHgOEKV9HdPlN6TJjBzeAYZe1EOPi6r4rHpd8AsaiwmZERRnYXysBSygis+lxUUciciAQ/YWqmD7UfPWaEfjh9Ekz2Vu0h30+anlbneJpVqLuVVM+xXo2Mx4SlA/jLpmCsp6SaFE6B0fKdHRlIKpNTPLHSUzolq+eyh7NNVGQL1ENxJjoIZktJ1UKI2GvKk9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHbtdImXLTnInaSdVmWa+i9DUhd6N53xKkBOSoL4J0w=;
 b=lKggJZdbwdS4RwB2eXu0FMLzJg7ETeAJZBUdgRyN5SkW//TYwOo7R7Nkdz17LrXs97K8P9FeQhJWHNT2curugmJ1kuH0kFefUumGFvBXKcBMRx5Hl4R+U79qtnEAfviI4ok6O9EkC/wzdt8ZVQtvbQQHFYWpoqBy8NnxsSXRRPU=
Received: from BL1P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::26)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Mon, 24 Aug
 2026 22:14:21 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::38) by BL1P221CA0014.outlook.office365.com
 (2603:10b6:208:2c5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:20 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/30] drm/amdgpu/gmc12: drop MES tlb inv in gmc callbacks
Date: Mon, 24 Aug 2026 18:13:51 -0400
Message-ID: <20260824221352.1793542-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 9971d601-b984-4259-2aa1-08df022d0c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: n8J7coX2Yq20KTntQ/47jcROxlSxpRoQPIDAMTZVL2c6CpMLjBh5xTABeJMQnxfxJEgzq9JJHKvsZ/t1kmZRQYlEEqKbuojho1Sl0Og/XYpamhwilsPYXxN3uO1KAQeJYgbtrAL+TJeELKa5GN/naBQUM98CRpCj54ai/5HzyDxI0H1KJp5E3TAzLK2wimsj9VdbT1mBAYJGdfu3rr199C/vSXwtAOXCFJqvaTcZW9HJYW9PHWrCsz7rOpLLL8hcFBtEiJo4sy6l+kduwstIXIytPt2RAOAgACZvt/LcJU6eUFMEJ+GqpY0lR2yBYr9E0G5blWJ5HPWEQvF7MkBxecjl6kX2r4fRV1PwAD2RGitqzSxPtnOgZ6n+Bm0XXhAMws73izYkvNFo469i7LrHX0J4WxQygMUaVCV6UQET+CndiRwHT7lzX8dwAMaCtx94TBfoMGEpMgVjNx10sN2zzpeV12I3oZfhF7SUNP7ald4+nFdB46n4yQIgzFhJ8B6/jWPW+rZiKa8EqNjG3AuFyEGybyaoZRavjISLGgahESYUf52rGMsXBZl23U3aveJLdpTBOUs/fz7QAwmqJs15HDvopElhcWpRM8MePuc8mXH5V9oku9VBx0TE8JsoADvjZ4LHBhGLKHqiB4y8A5+HqaXieetajCLGYCYm+asutZqGHfW0BNRRv85aVPmv1E2FXuK1AejCqDUfFdX0aKN0BA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U4t5dsiMRtWI7SmKx73ofbnf2ROOZJm2M7VKQSnzVvfuQyqw7Lgd/ZleCMKgpAQ12RIqFz62+v9dpm3ABTc57l3UeqHVUDjxxZ24GjtM68e0AtPoYolNTjy0X6LufFZ7o5xOFgjG0AauZpqX1mIXTTjqSljjC2myvqnUHwvt3kc+Szuu12rKHOI22xHbf/moH2Cy42J3xUtqLzIL+zsLksYJsWEnT8spH+DvVH6nSdPlqc4GLljYSUAHSPm07DI2Z0o4tQ1HI0acw8tUcsFnbfRm58LZj0zygsPLFhQuhKbb+vhMM9ooIJ+iFwZiAkGg3Rgmp+N5qaPMwK0FWw91ljD/rsASoW9iUeigBgKnid0MlOf9KSDIjJOvGxLpS+4jD8X3bHADz/RaFtHuYH2sQVM1nUN7KXuM4AHpYHv5LWMVMcADxESJLaTNbILnpttY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:21.2031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9971d601-b984-4259-2aa1-08df022d0c43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461
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

It's now handled directly in the front end functions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 16 ---------------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 28 --------------------------
 2 files changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 67eb1b595abe0..4bb8c1e4f335b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -356,22 +356,6 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
-	if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready &&
-	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x84) {
-		struct mes_inv_tlbs_pasid_input input = {0};
-		input.pasid = pasid;
-		input.flush_type = flush_type;
-		input.hub_id = AMDGPU_GFXHUB(0);
-		/* MES will invalidate all gc_hub for the device from master */
-		adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-		if (all_hub) {
-			/* Only need to invalidate mm_hub now, gfx12 only support one mmhub */
-			input.hub_id = AMDGPU_MMHUB0(0);
-			adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-		}
-		return;
-	}
-
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index d6be7c092a22d..2c980dc02c262 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -411,34 +411,6 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
-	if (adev->enable_uni_mes && adev->mes.ring[0].sched.ready &&
-	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x6f) {
-		struct mes_inv_tlbs_pasid_input input = {0};
-		input.xcc_id = inst;
-		input.pasid = pasid;
-		input.flush_type = flush_type;
-
-		/* MES will invalidate hubs for the device(including slave xcc) from master, ignore request from slave */
-		if (!amdgpu_gfx_is_master_xcc(adev, inst))
-			return;
-
-		input.hub_id = AMDGPU_GFXHUB(0);
-		adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-
-		if (all_hub) {
-			/* invalidate mm_hub */
-			if (test_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask)) {
-				input.hub_id = AMDGPU_MMHUB0(0);
-				adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-			}
-			if (test_bit(AMDGPU_MMHUB1(0), adev->vmhubs_mask)) {
-				input.hub_id = AMDGPU_MMHUB1(0);
-				adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-			}
-		}
-		return;
-	}
-
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
-- 
2.55.0

