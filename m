Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02FC103A9BD
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 14:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5085310E839;
	Wed, 25 Mar 2026 14:13:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4WsN28wx";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013004.outbound.protection.outlook.com
 [40.93.196.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EC010E7F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 14:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGZ80IsABMRCB9ES6IQzHzYeAm5sulcruzTbYXgj8V9nqm/XOV0dkczDZACZIXVYfshnd9nu63spHqhMlJHBCF7QYDbcArrtiWR+fWsUTp1Dv0FqYnoTEdTxcviNGYFnBbKLJOFGOEq0AkRX1AhNVCpjdqV1+MFyCUXgcviGRf27TCstRte3RRgatDwN8NDC/0OHyP9Y5JRaLMD2KysUvOiwqS7E1+zX604X4fqAgkAJ8FJqFSl+nFnQ54nGKZMRuPlsLPQQHRvglrf1rJ1SjHHA8wIlPS2d3AFGYjjszdVriugMRq6/E6tLd2hbGf72qwQbbfz5Ec4UR1cEfg1LbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sku7QbMrgPjUp7inGReYbvNi/12zhdDRnBD9t0GW3Nc=;
 b=su8bLXy4Cz6Wqeik/Afy56kY9g19Pd+KyiDWz5TmU4QvbH0tmUYdiSS+b0oWBs/A4z7VWEEVS3AumazERqGbcM9kuc/eTMCJ3eTdY/CW1BMFKk/JYpZXMilIw+tIZ/o4MHMRdaTKxw7SYVb91EcCllUi/OkFOsCQzbUr9t2c1V/ytQuW/8QtNZZq8S51QM+9MM46/kk6G6JOLc1Rx/a+YOZYrJL5vCtXVjBWf6IUSyxPkQuHpkOp9rVwNfxjtpPiaPZ1pRpmv8kyKpl+j35Zsb93n1M17f9MLwM660RVdxxyAQsOJ0iXgEI/defIev+D48/bsTr+dMxPpf215sD5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sku7QbMrgPjUp7inGReYbvNi/12zhdDRnBD9t0GW3Nc=;
 b=4WsN28wxXnk/+4CUQ+f30cO1GWKOCh6PdiF5GJ0ikrDvZHuojpshQzXWuOH8d0ExmDGYkjQgY3MED0fbcHMtQc3L2fBCVf9Rl+GZIATEfg7Hx35p6fznTt/thR8tJxEQ3uoXmB8VWPvNAdoTLVWyd2QiqNWaIwIX27c0Ko9vxnI=
Received: from SJ0PR03CA0376.namprd03.prod.outlook.com (2603:10b6:a03:3a1::21)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:12:54 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::da) by SJ0PR03CA0376.outlook.office365.com
 (2603:10b6:a03:3a1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 14:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 14:12:53 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 09:12:51 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 3/9] drm/amdgpu: Add extended stolen vga reserve-region
Date: Wed, 25 Mar 2026 19:42:20 +0530
Message-ID: <20260325141226.1173216-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260325141226.1173216-1-lijo.lazar@amd.com>
References: <20260325141226.1173216-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: cba1052e-9032-4230-8523-08de8a789b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: lfBKWBnjn5B5mtY/msAfdcCSoFPHKc6OR9suFD3PvNYoFu2o7WOenclX9WiDISgDMgc4H7e01iPeNPRsgV9Artltae8d/NmLGhiJtLaf9gowiDQgglLRzZlh3etEWtF6greZtqQQ+cJj5rf5WSESTyTaD35o3TtAKRuu72w3rthVmz1yxrvz4iZ33o+VoHY5ESkD/xHwwvNONTiE7CkoT/p42EnQNjujkvI8YWcqcTt4CcZOQvBgIhzGwMzlZ7+X6vZDYglpp6ZUmmE++4MdZ7j7KEmj7ZavM+2COd2cZt9ca50ZccAtT/R4r0X+zuwnFpatYHNAQWGrupxM9rEt0hehIUAkap/fcJTIX+/dXvMA1fL5B7714/i/3HmNwxCCGPbIcw7pFEcxP73StkcnXIrlLDvDubGTExk7MHGNRsaxuDCJu84PJljN2Shwytv4dIN21Sq/AWarifaR/UiOhBVw/Gy/p9tJJWKgqxFXdPHisNnFjb2adDPi/TX2i3tKM8Xx39vTkOe+7ViK3IJNu701TDP940ZhraTmQwU1xPCL0G4idOEPor1jB+6wHVGHPkbRjiHBxefnumJ2wcdJE7Yzo77QGtDmNQk4Pst7bNIdXmalTmNOiJIFjmHaZavLgmhYTU05Qc8BPxMOTtuLd/0qsou4p8qmYKgxvs+xTUmDM1YtUqckgDhSh5MymiLH5NW3p8Ul5Ogf+nYmpnVSk4LtOiI22kcr+bKCS7HZOksAxYmMXDZjMzair12TIIOL73StW3EzjyRcMt1Znie/dQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0LnWIaknzr8LAroY4Asi80mr/ov2gMM7MtbbclJIo/7RtkoPVwJf+1UX/ebvTloZe4OnNScLMuVpVu5G1/tSilIqt8A9xJFlYRPt0SkKnp5UZL3WdMEitZiZeSbA0J/PbY07frfgoG3ZHoUwr45JD2+dzfbWUvuBMK0rCOxg0lPY3S3KL2cA8jrAFzf8FwuTspSbgmuLWt53aggBiwRf6UHAtJLgAVlsXyFnySQJFCdb9wp0mGQd+Y9aoaAbiK5vnCx2Gg6WfExEQb+v+1oKVlxVFqZOY5lzpBdRgevHAqyUwdxUDDqY3CGT3MJ+m0T00raTw0S/S6lkbByr0r5MQvcgISiPuU+g4tT/5LAide/s87FDsGtmv/2u2C/fAiC6vhFinL0bI8zGBXVeI+/zFjOKVZRCkmSWuX+W4jRxxbqQpXxIPb/HKwMCh/9I9NuP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:12:53.7020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cba1052e-9032-4230-8523-08de8a789b3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
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

Use reserve region helpers for initializing/reserving extended stolen
vga region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c           | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c           | 9 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h           | 2 --
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c40ae1073017..61e8d71dfed5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1100,11 +1100,12 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	if (size > AMDGPU_VBIOS_VGA_ALLOCATION) {
 		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_STOLEN_VGA,
 					  0, AMDGPU_VBIOS_VGA_ALLOCATION, false);
-		adev->mman.stolen_extended_size = size - AMDGPU_VBIOS_VGA_ALLOCATION;
+		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_STOLEN_EXTENDED,
+					  AMDGPU_VBIOS_VGA_ALLOCATION,
+					  size - AMDGPU_VBIOS_VGA_ALLOCATION, false);
 	} else {
 		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_STOLEN_VGA,
 					  0, size, false);
-		adev->mman.stolen_extended_size = 0;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 84c482cc653f..3c1c4548d280 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2217,12 +2217,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		r = amdgpu_bo_create_kernel_at(adev,
-					       adev->mman.resv_region[AMDGPU_RESV_STOLEN_VGA].size,
-					       adev->mman.stolen_extended_size,
-					       &adev->mman.stolen_extended_memory,
-					       NULL);
-
+		r = amdgpu_ttm_reserve_vram(adev, AMDGPU_RESV_STOLEN_EXTENDED);
 		if (r)
 			return r;
 
@@ -2348,7 +2343,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	/* return the stolen vga memory back to VRAM */
 	if (!adev->gmc.is_app_apu) {
 		amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_STOLEN_VGA);
-		amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
+		amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_STOLEN_EXTENDED);
 		/* return the FW reserved memory back to VRAM */
 		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL,
 				      NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index d973c96f0ebb..08c0bf0893d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -99,8 +99,6 @@ struct amdgpu_mman {
 	struct amdgpu_gtt_mgr gtt_mgr;
 	struct ttm_resource_manager preempt_mgr;
 
-	uint64_t		stolen_extended_size;
-	struct amdgpu_bo	*stolen_extended_memory;
 	bool			keep_stolen_vga_memory;
 
 	struct amdgpu_bo	*stolen_reserved_memory;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 30521e270d71..e28d49a7e042 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11154,7 +11154,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		/* return the stolen vga memory back to VRAM */
 		if (!adev->mman.keep_stolen_vga_memory)
 			amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_STOLEN_VGA);
-		amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
+		amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_STOLEN_EXTENDED);
 	}
 
 	/*
-- 
2.49.0

