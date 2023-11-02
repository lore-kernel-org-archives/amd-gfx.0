Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502E4C4167D
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 15:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D475410E8E3;
	Thu,  2 Nov 2023 15:04:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D8E10E8E3
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 15:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvuBZECweX1RLPgMRvz0ZEWc3C8OngdLcW1jxVUmbpLUlDR/QHvgYWpJNvrHz/5LOlx6TQY94a+hH7skrnXXwQ/Kj1EOM4dlQlhYb1PM0ged8mvDUAHAQQnd7+blKHR/UrA2fq6c76iXOuZyT/w2uCaDdNBXUkcqARcqxHrl2Xf3dDE3zoR+98dqX62LcCzngKeWuJz6O0KO62B3s41ib8YUEGFmTfwuBE0K20kzibCq9tiOvTGvEgG3x9/+Y89G5N+Z2PtKmvU7v5v6dVghRO8c22l8Zb1p1rEhKYvQJrOVBqAHb/kAFVcVtVqpCBvXFzdG3Qd1JoFZbmfbekFGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAgwp6N8jelTo/cW3kQR3ad5J56dyWI7odXWpgklgSQ=;
 b=j9yq7AE00Jxpe9pi5lvah/sU6XJpZTu5wGK53cttGRfKO55mJfkaG5VO/G0pctpRNj6vFEi348ap5zY3dH9svksmvcvUc7uWF5CPyPzDVVNug0t5xGUrVZeHS70SFRdJgSP+yqrve8PK7yzI5M/CB2Y31BlRWgsTeQOvAgVimRpT8yJKsXZslS6WkXAM9skpGTf0Wgf2V+o0l14PiD5rORM7Fim82zOFSIeHcx/7Lj5ZcqKdV1vtnPcqz307jk0sXyo/sMecw9LdzFgoIDXTvXsMkdlyUj2ebv3/SevFmL/qcGzr0mvqPzqrkxUtreB/XFEqHLD9O3eC6JnPJ9JrQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAgwp6N8jelTo/cW3kQR3ad5J56dyWI7odXWpgklgSQ=;
 b=m+ZZYokUZOMtoKyKfb/cEVkZ36OesdScHVQuJxEK6D7k+SP6tdxao+EKPISt3hQttCugjfzwiL65k91Ofreu+EpqLkCHrBBEsdkuTCYSGuElISMHD/X8ChjtlUxMgYts20/0pub+jm1CJPEEHlvx5p3rBsEU0RycSXWEEdvmmQk=
Received: from BL1PR13CA0331.namprd13.prod.outlook.com (2603:10b6:208:2c6::6)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 15:04:52 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::a0) by BL1PR13CA0331.outlook.office365.com
 (2603:10b6:208:2c6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Thu, 2 Nov 2023 15:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 15:04:52 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 10:04:51 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Change WREG32_RLC to WREG32_SOC15_RLC where
 inst != 0 (v2)
Date: Thu, 2 Nov 2023 11:04:27 -0400
Message-ID: <20231102150427.12978-4-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102150427.12978-1-victorchengchi.lu@amd.com>
References: <a69f99f0-881a-1b52-1e29-4cb6b2bc1994@amd.com>
 <20231102150427.12978-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: f27ee294-e8f1-4598-0e0b-08dbdbb51136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XnzIjEp4OmYCsNEdViYuvEPPCow8g0irhAhnmYfWm3CiVujc94KOmNH+JJrCJjNCq1YCboGRlke8gghi8Wa24wcOeo9srP/WZiqyAtMctJyEZ3vmjtQL2vh34kBi97yxKo9ZORzrZ5C/A+877rE68Z0O4WMKxZcr+AJ/zu/qEjTW1ZAGXZhtxuPeFz0+goQ8sAW/SVd1XE3JxudfzNTtYyYYZA01WXcsdkfJxslZB1uFAXm4eQ1WDVw7PjPrBAgySWj6JOmButFz/oJk7Rz197/AKvdBZwfhY++zY8jHgqm9eWnDTkVgxoLnZ1fFOmt+PShHJfuG5mshPxO+WQ6V4kKS+AS6s1NmJPaagb0JoVhcYkB57Buxh+lRmUXGPgaqD1YmgNA2BTy/UfmUTieXIkKRg2PtRpth08jS5yF0OQsPoS0Re26Qk6V7QqYqMN5S3drTkBMbbikjKHXY7TD8h/notImibFBFC3FAu91ztpbkp9ovOyxF9keO24llrSgo0I/0Bg3TxPk2gzdS3M5ZVCHzm9RcRX8oa+rv/f0rNKwEpfjY9HsS0BbKbEkvw7NbLboDfLtaMi8yM0wa34QrbFT0THkKq2LgAk04Hj3IzCg6dCG9ZhCD9+SSKJt1D4NOSi3j2SlBE5wcVL8piBw1mQfNBduugy88WYdqM20zI/PgfATmMpEX5C92IWGEf4j+MIYPL1ei3xeXpfbyywemO1PW35SZmttO399QikjkQdVubI3SQewpLOxjcMAej9y7/9NRuxAx//xQwCjA8Lp9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(83380400001)(47076005)(16526019)(26005)(1076003)(336012)(6916009)(81166007)(426003)(356005)(36860700001)(70206006)(70586007)(316002)(54906003)(5660300002)(8676002)(4326008)(8936002)(6666004)(2906002)(2616005)(41300700001)(478600001)(82740400003)(7696005)(86362001)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:04:52.5344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f27ee294-e8f1-4598-0e0b-08dbdbb51136
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W/RREG32_RLC is hardedcoded to use instance 0. W/RREG32_SOC15_RLC
should be used instead when inst != 0.

v2: rebase

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 38 ++++++++----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 40 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |  2 +-
 3 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 80309d39737a..f6598b9e4faa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -306,8 +306,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_DOORBELL_CONTROL),
-				data);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_PQ_DOORBELL_CONTROL, data);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user
@@ -336,27 +335,24 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_LO),
-		       lower_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_HI),
-		       upper_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_POLL_ADDR),
-		       lower_32_bits((uintptr_t)wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
-			regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_LO,
+			lower_32_bits(guessed_wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_HI,
+			upper_32_bits(guessed_wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_POLL_ADDR,
+			lower_32_bits((uintptr_t)wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_POLL_ADDR_HI,
 			upper_32_bits((uintptr_t)wptr));
-		WREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_PQ_WPTR_POLL_CNTL1),
-		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id,
-			       queue_id));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_PQ_WPTR_POLL_CNTL1,
+			(uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id));
 	}
 
 	/* Start the EOP fetcher */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_EOP_RPTR),
-	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
-			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_EOP_RPTR,
+	       REG_SET_FIELD(m->cp_hqd_eop_rptr, CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_ACTIVE), data);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_ACTIVE, data);
 
 	kgd_gfx_v9_release_queue(adev, inst);
 
@@ -494,15 +490,15 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
 			VALID,
 			1);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+	WREG32_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_high);
+			watch_address_high, inst);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+	WREG32_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regTCP_WATCH0_ADDR_L) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_low);
+			watch_address_low, inst);
 
 	return watch_address_cntl;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 9285789b3a42..00fbc0f44c92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -91,8 +91,8 @@ void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
 {
 	kgd_gfx_v9_lock_srbm(adev, 0, 0, 0, vmid, inst);
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_CONFIG), sh_mem_config);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_BASES), sh_mem_bases);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmSH_MEM_CONFIG, sh_mem_config);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmSH_MEM_BASES, sh_mem_bases);
 	/* APE1 no longer exists on GFX9 */
 
 	kgd_gfx_v9_unlock_srbm(adev, inst);
@@ -245,8 +245,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_DOORBELL_CONTROL),
-					data);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_PQ_DOORBELL_CONTROL, data);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user
@@ -275,25 +274,24 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_LO),
-		       lower_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI),
-		       upper_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR),
-		       lower_32_bits((uintptr_t)wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
-		       upper_32_bits((uintptr_t)wptr));
-		WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_PQ_WPTR_POLL_CNTL1,
-		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_LO,
+			lower_32_bits(guessed_wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI,
+			upper_32_bits(guessed_wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR,
+			lower_32_bits((uintptr_t)wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
+			upper_32_bits((uintptr_t)wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_PQ_WPTR_POLL_CNTL1,
+			(uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id));
 	}
 
 	/* Start the EOP fetcher */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_EOP_RPTR),
-	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
-			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_EOP_RPTR,
+	       REG_SET_FIELD(m->cp_hqd_eop_rptr, CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE), data);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE, data);
 
 	kgd_gfx_v9_release_queue(adev, inst);
 
@@ -556,7 +554,7 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 		break;
 	}
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_DEQUEUE_REQUEST), type);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_DEQUEUE_REQUEST, type);
 
 	end_jiffies = (utimeout * HZ / 1000) + jiffies;
 	while (true) {
@@ -908,8 +906,8 @@ void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
 					uint32_t inst)
 
 {
-	*wait_times = RREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
-			mmCP_IQ_WAIT_TIME2));
+	*wait_times = RREG32_SOC15_RLC(GC, GET_INST(GC, inst),
+			mmCP_IQ_WAIT_TIME2);
 }
 
 void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index c75e9cd5c98b..4607df23fe27 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -140,7 +140,7 @@
 
 /* for GC only */
 #define RREG32_RLC(reg) \
-	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP)
+	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP, 0)
 
 #define WREG32_RLC_NO_KIQ(reg, value, hwip) \
 	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip, 0)
-- 
2.34.1

