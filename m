Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204A0C54756
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 18:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F56310E3AF;
	Mon, 19 May 2025 18:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p0lVJDhE";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5392710E3B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 18:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJe4xZTiFh7ewMkMX6IrwgeMZiOaXSrytPOvCvJJtG0A8vrCNFicx9WM6i3IJDejiJTt1GvC6+BEU8efOSw9PnoAwacNmb790VylG0oMR4VA/tRT9GfuqUkWWQKngMREStetksBAwMJ8F4yjvJNbENaCz03dLseaUfkbIShVC3BHiIn6c+HwDvwX6dHk6fQ3j0CkYcwDDj++FaIdvRCMh8clgi+66Hu91JAsvoCC+cnP82K+F1gr4BjCDnjPqTvxi+6ozTa/29/yVaJPaWpP2WVtHsoEaKt1CqEc9sfFhBcib0hgleITkEKhmvb1NAqxUjD5a/cCMmFolFEvUBMEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/qLdnsf0dLxbRll+rCn7F5HqCLxKQH2LXPLeKpUsIQ=;
 b=IqmnQm2fX5pyCmfqF0HQxrjOnrCeq5Yba4Pt7D1zWkMOfTSZiDMzJcWimrWINtMgyYjp82Jhfdi8QzaWYMeTZpQS/8qzwsNszCXAgCjR1oPPShvdDrB0F12S+Rd+ZS6fuE7KxprPVCEwbMEcKkQCKo8H2aJbZNjQADfMJEOGdkp/yDEJoRFss7NjJVwlDlf8wz6eCAGTaj2QNmVzicyAx9wpCEjETiD9EzYXd7XntCvOZ4FMLbhrqazEnTr59cpJTnoewHIs+VU8/NujdpYGfRTdIAMD0nycKZ74MoodcpROsuN4DPgUsQUJaawdGx9locYPDwT/qnC8oI1CJMCIvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/qLdnsf0dLxbRll+rCn7F5HqCLxKQH2LXPLeKpUsIQ=;
 b=p0lVJDhEZKqKUCncefsaLzBVdxhmc+0KHvmdpklFmySl6xmHpn6+MNT/wnQ7WrAZ/9L6VBDWT7pO81mrq3NtMYCQsJAngygM9CiIZcrkZ8/0IEEjTvZ1NG1ivCzn8kK15hD3m4Dukw7E6upOESTN9u4koEVFSS2hhXJj6iQKNuw=
Received: from MW4PR03CA0304.namprd03.prod.outlook.com (2603:10b6:303:dd::9)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 18:22:26 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::73) by MW4PR03CA0304.outlook.office365.com
 (2603:10b6:303:dd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Mon,
 19 May 2025 18:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 18:22:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 13:22:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: rework gfx7 queue reset
Date: Mon, 19 May 2025 14:22:05 -0400
Message-ID: <20250519182209.18273-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519182209.18273-1-alexander.deucher@amd.com>
References: <20250519182209.18273-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eed1068-59a8-4583-dbd9-08dd97021b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWREcGluRmwrVkl2WFF6SFI0eVdPalhIb21jblhqbHRKUWZ4SEVzWWtTekF6?=
 =?utf-8?B?UTZCWnp6R2l4RWxRMDhpOHkzSG52NlVMTm9IQnlWcjlSV2R6cjJ4WWE1aGY2?=
 =?utf-8?B?aHM4eW5PREMvTGNOQWxvSi9ZNnNIRlk5NjhoWGVub01FR0pUUGJiNGpHL25J?=
 =?utf-8?B?bEZxLzZadU9yVFZDV0ZFSjI1eTlaK3lZL0tDb0VveUgySWpQZDV2T3FOS3JQ?=
 =?utf-8?B?ZnR1bElUeUJmRTV2ZDVZYWZoTXhZalhLNVc0bjdNeXlzVVVoUmttQnMyelBE?=
 =?utf-8?B?TXlZQmliTFFBSzR6c2tBRWExZUJhd1I5NEl5OWFKcTlkQU42a2diVVJhYmxE?=
 =?utf-8?B?Y09jVkQ2eVZlRUl0SkYyckNZcHhtTkM5eFUyaFQxZEFVam9BMUNnaUtZZ2tF?=
 =?utf-8?B?b0ZCRjVTNVNtcTZCTzRjNi9CMGFxc1AycVNRNmZGNVgvL1ByenI3MDVoaDVM?=
 =?utf-8?B?ZDFOc2lqM2I0aG14QURKNFdCbmpvR240TFhRRjc1ckpXQ2pjdkwxZ0t2WjJ6?=
 =?utf-8?B?YWt6YVloeHhybFJEVWFxK2sza1RsOFZGd2FUcTBkcXFOZDR2dkFaSlVQS0xj?=
 =?utf-8?B?SE5HV2x1Slhab0RxNzlNTmt2R25LMUlLOS8wYzBJbHlzS0pFc3F2V2w0b2dS?=
 =?utf-8?B?eFNYd3ovT21BMC9sUTNMN0hqbUgyQXJkSEVBWnhiY3ZMVlhKY0VFZGUzanpL?=
 =?utf-8?B?Z3AwK0QycHhqY3UyVWJKNkdkL2t1ZndCbFlNa09INVNDeGNIQW9zdDJvUk0z?=
 =?utf-8?B?dFdDK3Zqam5YYm9NOFpEMS92RDg2bHhwM0RJdXFjWTRkMy9TdXk0eGppeTls?=
 =?utf-8?B?TzZIMDViMVRMVEF5ODVsWGo1MU05cVd2dHg2MGoxU3dsRVgrUHRVMlV0TWx1?=
 =?utf-8?B?alpGMElFWkRPQ1l4UDNBalVZNmtVeFJHODZidEI2eExmMTZ0RGFZZ2krZDRS?=
 =?utf-8?B?cWhxNlFzUlNzUlpRVWxKUFhkYms3OEc4ZVc0Yllmb0FoQlJwWlBram83TjZM?=
 =?utf-8?B?b0VqYlV2TGxHa0IzL1hpVnNzR2dpUUhXTklTRkJtU2YzMFRMOTJtQ1RheXRp?=
 =?utf-8?B?RXF2MGhZZzFGUFpKOXZBTjR6ellqOEswYzlqZDNROW1JTXdoWDNNaUUrSkZT?=
 =?utf-8?B?VjVyUzZUcHl4c3hvdW41bTJOdndPZG5JL2VUbW9JbjJGQVE1SUcrdzZ0SEZu?=
 =?utf-8?B?VCtkUmlJRmd4UXNVTGV5R0FNUUlsSTdvN0t1ZVVVS1Y5Yktld0JFNmtYUjlF?=
 =?utf-8?B?MUZwVmVVWmZ1Z2ZtU2pLNExQcUo1UGpacW9Kek1LeWFZbThTMm43LzJ3bVFj?=
 =?utf-8?B?cW5hdHJSMGNyREEwOXJ1dTlHdEw0QzlCdHR4ay9OT2ZZbCszalZZM2hFMjZS?=
 =?utf-8?B?TC9JMFpyNXhMRmREWnlvWWx0ZzAxbE9oSTVnYk1ENUx5QjBZSmM5bUg3R2NG?=
 =?utf-8?B?L2lOTDdidGdLc2JycFVYUTlKK0djZHdvVTI0SVU0cFVyaTF6L1lsUG42bWlK?=
 =?utf-8?B?am93Sy9FOHpkRUM4K3daMXVCOEhpYWMwMTh6Y1hsMWgxWFQyUStFTDgrZmRa?=
 =?utf-8?B?U3hHYzBiaUV1bDhXb1daWUcyMThuZE9Jbm92ZXcyU0hLd25VWE0zNEEvbm5E?=
 =?utf-8?B?MkJkRkdjcUlJMGpmV01GWTBWZDlQZnB5eGJKTUg0dUZSMVBFNFBDdll2djVi?=
 =?utf-8?B?OENWTHZ6L0xtaStJdmRnblk4VjJab0VTT2xOWXNoZWQrREpsbW1BQndyeXlj?=
 =?utf-8?B?TWIvOHgxN3NLdlpoRHlqazJuN002SEd4NGZhdmQ1ZVlEVXhicWs0dlRvRFRl?=
 =?utf-8?B?MUlyYTZ5MnVQSnBOZVZERWNDVFQ3WERHZUxqdTZGS3NqOG1nWmRHRHE4d2pG?=
 =?utf-8?B?L0NpRGg2VUI2Tk9lQmZQMEJjUkhEbzJBNjdRcXZUbGdNMUxldVZxWkJzeTM1?=
 =?utf-8?B?UkplbjM4cE9rUTAxc1NlVlNRYldYSlh6WUs0eHEraktzQmI2L2haNmhUcnZX?=
 =?utf-8?B?djZmUHl2UUZqelRSL3BhbDljb25yL2NCMzFrTW0rU1hwSDFKRk9MWFBaYzhL?=
 =?utf-8?Q?kEy/rs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 18:22:25.9842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eed1068-59a8-4583-dbd9-08dd97021b5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Apply the same changes to gfx7 as done to gfx9.

Untested and probably needs some more work.

v2: fix up pipeline_sync count, only emit vmid reset on gfx (Alex)

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 89 ++++++++++++---------------
 1 file changed, 40 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index da0534ff1271a..fc2f1fc26a3d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3095,6 +3095,33 @@ static int gfx_v7_0_cp_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void gfx_v7_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
+				  int mem_space, int opt, uint32_t addr0,
+				  uint32_t addr1, uint32_t ref, uint32_t mask,
+				  uint32_t inv)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
+	amdgpu_ring_write(ring,
+			  /* memory (1) or register (0) */
+			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
+			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
+			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
+			   WAIT_REG_MEM_ENGINE(eng_sel)));
+
+	WARN_ON(mem_space && addr0 & 0x3); /* Dword align */
+	amdgpu_ring_write(ring, addr0);
+	amdgpu_ring_write(ring, addr1);
+	amdgpu_ring_write(ring, ref);
+	amdgpu_ring_write(ring, mask);
+	amdgpu_ring_write(ring, inv); /* poll interval */
+}
+
+static void gfx_v7_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+					uint32_t val, uint32_t mask)
+{
+	gfx_v7_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
+}
+
 /**
  * gfx_v7_0_ring_emit_pipeline_sync - cik vm flush using the CP
  *
@@ -3109,6 +3136,13 @@ static void gfx_v7_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
+	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
+		gfx_v7_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
+		amdgpu_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
+		amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+				       ring->fence_drv.sync_seq,
+				       AMDGPU_FENCE_FLAG_EXEC);
+	}
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring, (WAIT_REG_MEM_MEM_SPACE(1) | /* memory */
 				 WAIT_REG_MEM_FUNCTION(3) | /* equal */
@@ -3998,18 +4032,6 @@ static void gfx_v7_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, (1 << (oa_size + oa_base)) - (1 << oa_base));
 }
 
-static void gfx_v7_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	WREG32(mmSQ_CMD, value);
-}
-
 static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t address)
 {
 	WREG32(mmSQ_IND_INDEX,
@@ -4884,34 +4906,6 @@ static void gfx_v7_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
 }
 
-static void gfx_v7_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
-				  int mem_space, int opt, uint32_t addr0,
-				  uint32_t addr1, uint32_t ref, uint32_t mask,
-				  uint32_t inv)
-{
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
-	amdgpu_ring_write(ring,
-			  /* memory (1) or register (0) */
-			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
-			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
-			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
-			   WAIT_REG_MEM_ENGINE(eng_sel)));
-
-	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
-	amdgpu_ring_write(ring, addr0);
-	amdgpu_ring_write(ring, addr1);
-	amdgpu_ring_write(ring, ref);
-	amdgpu_ring_write(ring, mask);
-	amdgpu_ring_write(ring, inv); /* poll interval */
-}
-
-static void gfx_v7_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-					uint32_t val, uint32_t mask)
-{
-	gfx_v7_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
-}
-
 static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -4944,14 +4938,13 @@ static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
+	if (amdgpu_ring_alloc(ring, 7 + 12 + 5 + 7 + 4))
 		return -ENOMEM;
-	gfx_v7_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
-				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v7_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
-	gfx_v7_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
 
-	return amdgpu_ring_test_ring(ring);
+	gfx_v7_0_ring_emit_pipeline_sync(ring);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v7_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static const struct amd_ip_funcs gfx_v7_0_ip_funcs = {
@@ -4984,7 +4977,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 		7 + /* gfx_v7_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
 		12 + 12 + 12 + /* gfx_v7_0_ring_emit_fence_gfx x3 for user fence, vm fence */
-		7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
+		7 + 12 + 5 + 7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
 		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* gfx_v7_0_ring_emit_vm_flush */
 		3 + 4 + /* gfx_v7_ring_emit_cntxcntl including vgt flush*/
 		5, /* SURFACE_SYNC */
@@ -5001,7 +4994,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_cntxcntl = gfx_v7_ring_emit_cntxcntl,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
-	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync,
 	.reset = gfx_v7_0_reset_kgq,
 };
@@ -5034,7 +5026,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
-	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync_compute,
 };
 
-- 
2.49.0

