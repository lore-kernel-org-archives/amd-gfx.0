Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DC9C4450D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C4210EAB8;
	Mon, 13 Jul 2026 18:27:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gF4b62d0";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0894910E64E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4wy3PjE4mpxEwysIW0xt8z6pXZ5PBFvopLKLIzN4uTvbX+6UYfux68iyMbb0bOV82MJUSyXCy/pQQymy8gsWVTl8YFGRZAB+IBh0d8z4AF3QTgEsEjmkWYQeDhcuiVH9KLG4ojDDrAhLm3dBcc8TddhbXOD5VRYeFpChB9KKFPKj+u986wIhXnb1V0TH8nmVxVKZUxP/6h2WGooCZfzitx5UHtWIgQPcNlp2WLq8nj/JyKxfm8PAfnz78C4ZL7ar256vTmBZpOgdTGrI1A0wwBlODtA3J/gtiu8FCsMcIYDI/M0NiwafFwLqxtwRBEuAyDj9S6mDGdFj7ntPlj+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsA7fa4SJmJ0l0PB9fSKMAf4QzybrGhcLeUI2KTg5g8=;
 b=selxPsSFOFmSmYaXu0vPxEgN3cVMjdbM77Ks7zwEqBFHyARlmAzzdxVHRqKhuEbh1Iek3c0d87DEyvXx1759URcyWGLEWow14fPIEN1kmii3wk9G4kXo/1cAhRKyfuw+mWTkjpRGfvhLcDRx2qe2OEqdZikQwiG6K0LxYiRjyIGpa+5k/VZ48viK7l/P1O0Zl5Is+DF38ODAOv0uT5E9nL8HYENlJxtIUCmAb88YGElwobJM+E8vlouO3B2RpuW9uCYgp91wtiw5dRX+K9AAwYxBwwrvPkdNCz/U6/LiSfuMV7tt/DA93xy34IGZ86MOkaI5wx5xaMGx7lywjVWiDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsA7fa4SJmJ0l0PB9fSKMAf4QzybrGhcLeUI2KTg5g8=;
 b=gF4b62d0dj4+imQXQMZc6BBe9WW2XBgN3s7pb/ZFlJZ/0/RmKbb9tFXhQ7h/yn7sps77O9nhhiGHuz42VR5GM/YBwJGVKNAuj5xI4wgdIVxshraU0qi9c5hK4SfKsFj/nfk91Q2xPR9bclWgt7nvmcSGUzcxazN8ZnJjJz4K9UY=
Received: from SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::22)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:27:47 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::25) by SJ0P220CA0014.outlook.office365.com
 (2603:10b6:a03:41b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 18:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:27:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:27:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/14] drm/amdgpu/sdma5.0: add tlb invalidation buffer func
 callback
Date: Mon, 13 Jul 2026 14:27:24 -0400
Message-ID: <20260713182732.630947-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182732.630947-1-alexander.deucher@amd.com>
References: <20260713182732.630947-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: c22f3d97-bcfd-4afe-d400-08dee10c703a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|18002099003|6133799003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: 0HMk+1bRqxMg77zA7hvt0FyXapGuna7OHxD6zw5MyTEE4xQqY+OK1eVMqej0UR72mJxlGi5eH/DBInC1FMkt5TGMMkYl5xVfkt3VESwODzP50w/d+pLdquNBguyxEMEUbsrJB6upXDZnZ7pz4AiPD7z3S8njzDrgPhPOmwU159BFtgmCKmWofpRAs9Gqpjz1u+F1HhXvQ6OpA29tLsIjhDGpcn/egE9WD7o255O2UlWbJE/Zdeujs95sz/I2tJul0w7BsBhCQb6HXViPfkT2C/II+aJEe9m8OITEE880L55xGVZKXWDC+v2YD5huWaZkplRkn0smKghwuHSGTrwAzxV9/GZlpg/dDrzrDM1pULiVsor9Es9rYYjM8fBPOu6oJwmj1wHMMeFUq4tB6+cH/XB9DogiwJkGob9WlP/ER4Ff/JD3BJLY3exuaEEuvpFqoFEBoPl8aySUYFUqqf+NfL41yHMXPQk45aBol8lKjl6/1XN/I+Tt+fOz6y8DaWjkmU8nj/EaLfY3p1v/ybrHwK0qcDZkNciB+7nzO/8EPI2xQw+GnXdJOzEN/Pj6AtLCIkR609XxxQh6VO3yWUMABWiKsrUeCE3KDh+0C/DsY0ExAO2EgGAV+oeyhdCdV+ssfCuXfhpuEf0PG89x8zu8zpl3C6ZUMJ7TnbdcXzeeIGDNAnYRRR/32hDCcxki58fXAIc/fvX21sLMbnbPBgwhNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(6133799003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jEwmpcYKk9NuuzYQiWYewPVXzHGrjneeWL8zlcRLiWtGprkmBXCkXp324pf5/4OYX/KmsGVhtGQ6IMRJ5QHWO5K7WxYz5wBjxraNdEfevpAsh9xblkHQc5OYITjmwLTJqjUrL64bBK+vBY7FCCy41xyz4wjYApdKXIOA5TyAfpt7ArW4/jIjS4U7y2+uqAYZ/kelCcOWJqtfTLwFZdtc432xKK2iR54Ndciu4bbCZE/HV1EHX7Hzzm/Nahqco8O8Gtby7hB1G1f0VxaXrLRAwPatITcPlumG0v5mD7vn09pnWlnVp7aC7HWVQUDQ5oMNbubCncaq9EWR8MFrBgMySE3CWR5GIiaSkMljZqaGgAKfnMy/DkmcSAk4cTlFg/wthOm5O1NDLLbPj10PHMyZaNkUEP0zfCF7QgOlAx8c6/NcG2UCetJOqhtPZgvuthLN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:47.0612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c22f3d97-bcfd-4afe-d400-08dee10c703a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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

Will be used for TLB invalidation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index dc59039ffe000..9828cd5eb7cfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -2045,6 +2045,52 @@ static void sdma_v5_0_emit_fill_buffer(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 }
 
+/**
+ * sdma_v5_0_emit_tlb_inv - Invalidate TLB using the sDMA engine
+ *
+ * @adev: amdgpu device structure
+ * @ib: indirect buffer to fill
+ * @vmid: vmid to target
+ * @vmhub: vmhub to target
+ * @eng: invalidation engine to use
+ * @flush_type: type of flush (lightweight, heavyweight)
+ * @xcc_inst: XCC to target
+ *
+ * Invalidate TLB using the DMA engine.
+ */
+static void sdma_v5_0_emit_tlb_inv(struct amdgpu_device *adev,
+				   struct amdgpu_ib *ib,
+				   unsigned int vmid,
+				   u32 vmhub,
+				   u32 eng,
+				   u32 flush_type,
+				   u32 xcc_inst)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
+	u32 mmhub_eng, gfxhub_eng;
+
+	if (AMDGPU_IS_GFXHUB(vmhub)) {
+		mmhub_eng = 0x1f;
+		gfxhub_eng = eng;
+	} else {
+		mmhub_eng = eng;
+		gfxhub_eng = 0x1f;
+	}
+
+	/* Trigger invalidation. */
+	ib->ptr[ib->length_dw++] =
+		(SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATION) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(gfxhub_eng) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(mmhub_eng));
+	ib->ptr[ib->length_dw++] = inv_req;
+	ib->ptr[ib->length_dw++] = 0xFFFFFFFF;
+	ib->ptr[ib->length_dw++] =
+		(SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 << vmid) |
+		 SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1F));
+}
+
 static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
 	.copy_max_bytes = 0x400000,
 	.copy_num_dw = 7,
@@ -2053,6 +2099,9 @@ static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
 	.fill_max_bytes = 0x400000,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v5_0_emit_fill_buffer,
+
+	.tlb_inv_num_dw = 4,
+	.emit_tlb_inv = sdma_v5_0_emit_tlb_inv,
 };
 
 static void sdma_v5_0_set_buffer_funcs(struct amdgpu_device *adev)
-- 
2.55.0

