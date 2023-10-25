Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430AFC07545
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 20:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E64B410E71C;
	Wed, 25 Oct 2023 20:54:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7028510E71C
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 20:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMT/dj51hH9gNPFd99jAlTn/iOJnbb6rv8XWwtPHpQ8nefJW8IiPQZ3q+YTr0n40byFJevZfIhpzd6TALjtJhaTC9iR3YV4QU/ISa1QnU9CSEA3MqdK/N4bzhVz/dMMiL3evRzCVERlxZyz3/g5UaneA8VIeGd38s5IM/kBG54vaRZwevxaEq7jHHvZ1OSO6zc7RLdDYp86VeiGuIRAVQg06sVvLKfd7QMz5/MwYCQYK6QVQYkXEo9JTJ6fdraZOpk95oSHGBi4Dn6BykEGnXUUqL/8GfR/VBGm3jdRiKRdsJ7m9XNgvTR26AGoUUBthdMhrywa5ELlFvcElMz7TFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCf+ZprgcdzF/BAXNiDNuDxsZuhEbnCv4iSUj7hz0GI=;
 b=EdGoB8HsnDXfBVdcvMEKUnChjM7zNGrPuemxyKBThp/OjxD9GPCNWbfwRBcg/knhWCttyTjU7JgKvZHLTd5piFrjzcE2Zcv+WR9KWwWQeVQLqf3pWjcCiyQE408dU2WQMngmUDbGchpEPEzKUq3wzWmAW47YL2/xyutMtnPmcu1+0LiXnu/9h1KsjQJtAsUc92Wxw/BxzeO2pIEAYNAuqDjtaZfZYGqxTGfBP0sI22x65ltXFYc9EaEcka+IwnqqX5TQSWCrNOA8aedafeXk3fUUOLAsObABc0NiTX21pe4V504Bz+07EJbBR5KKx1s8zJVqxd2ukMzHq6d/H6WSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCf+ZprgcdzF/BAXNiDNuDxsZuhEbnCv4iSUj7hz0GI=;
 b=wu2YD9d3QflBlOjxcvnej8H38ANt6p6vaTQC0aqhxb1bHXuSv+ScUDhXIsSTP8egbTi7zyFL44EWx11FlMxhln3VIV2vxTHlHjwM5wTPbb5kWPUzfNIBG9dndzxFy1X00kOigWYcBQBml/9ZKZf3QoFPozJd0h2p+XwyCDOfj94=
Received: from CH2PR18CA0009.namprd18.prod.outlook.com (2603:10b6:610:4f::19)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 20:54:23 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::8d) by CH2PR18CA0009.outlook.office365.com
 (2603:10b6:610:4f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 20:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 20:54:23 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 15:54:21 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: Change WREG32_RLC to WREG32_SOC15_RLC where
 inst != 0
Date: Wed, 25 Oct 2023 16:52:42 -0400
Message-ID: <20231025205242.40490-5-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025205242.40490-1-victorchengchi.lu@amd.com>
References: <f68e701c-518d-9782-7da6-2f62f4aaa368@amd.com>
 <20231025205242.40490-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cba2eb-0185-43e4-e50a-08dbd59c9147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGloS5JQBD32LDLhuhJXfeGQn1TAUNxlhzpzFlO4eRXDid1dP6RVepAF+24cRffgxX67SDQqwk+LhAe6aZicdMTerfFXOnDJjULC4qi3qS6UX0Gw2hE46FHmmTFi5Qi1vSI3tzC7e2EOdamqPzu/mNKCxvCMTwCF29L3hHdPpMUciyURr7jUP3qej/ngzfBtpRgj5TEftlzO/APWlG0SwKmFFDyDkR/4Ghgp3Um2QoWaGIiIok7A8SDYvFmciGaxIonam4MqC5jNldDc9wzLR41KqYeTeNIYh4HRhDqKdPJDawCz3J1J57i0Mnhk6CWfHXA5TBRcFblHIDEbPIA3CVsyFr4cz9C0zF7mz7GOZGRAS8AN9/9hUWX1lxyvPIOyjK/y7BkUgUBE3t5L+Bi2h/VkpRGZ9gtZ7HlanKaG3DC4YL7u7jSrAS0CstudHbSnWSx1TAIoHrp3Q+9pSVoVtIuSuT1pz78bhOkxdEWVrzruGjSSJ2IHgrFeV94ypvmqPx+ebf/NImWs31M2tCC28WNplcPRd1MJF5mFjSUN818D3ijomihz2R/k6eSoc8j/4Vn5pjtWHrQgUeIpJRUEFxwreXkvbggjjvqW0jo/mYTLt2R39jgev5MrPrsXwi8HgkRFB6GODS2Tp26McQwOmPAY6Hw2J3dI/dGCtzqfc51yi2dMjNoSLCR850MkrIMGjTPR6TH1GpO50DBycLZdPb+WhGodRwB5vxMSD+yrDAuhUFuiUI4d6zSxnSYGmPFFy+Z2cWHPJBwRoHGBvJNrbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(83380400001)(40460700003)(40480700001)(54906003)(5660300002)(6666004)(70206006)(70586007)(41300700001)(86362001)(478600001)(6916009)(7696005)(316002)(2906002)(8936002)(4326008)(36756003)(8676002)(81166007)(36860700001)(336012)(426003)(356005)(16526019)(2616005)(1076003)(82740400003)(26005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 20:54:23.1298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cba2eb-0185-43e4-e50a-08dbd59c9147
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
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
should  be used instead when inst != 0.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 38 ++++++++----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 40 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |  2 +-
 3 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index c94df54e2657..cac6171528be 100644
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
+			AMDGPU_REGS_RLC, watch_address_high, inst);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+	WREG32_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regTCP_WATCH0_ADDR_L) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_low);
+			AMDGPU_REGS_RLC, watch_address_low, inst);
 
 	return watch_address_cntl;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 47c8c334c779..f5ef8f0543fd 100644
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

