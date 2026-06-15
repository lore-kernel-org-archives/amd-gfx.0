Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B7ACD98E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2995F10E70C;
	Mon, 15 Jun 2026 23:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q9o37CeH";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2402210E68E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQ+hdyM0sHFGnabTnRidHmZw/yFzlJzQIBw2ikcYhrcTYehIzFJBj8zKbeSaz1rx1qLo3FcBHzh6hKoi1WLmSBL9KrqKCvdozoPDnVrjn7qLHHAUX4vgL47FsGjGESJrnYpHBvf0EXERby3VlPXBumyKUpOoyCHqynzpySiHdQLL0WAEbhJ8GPGYpgAB17rg7qoYzG5V/+/GJAiaxAIDokmyT42Ki6LZechUZlR5Vm09cSSSgyCFUJYH2yvqwDok11NjvmgcFUzmhELSSg1ssPs0Ivr0sciQvF/0RB43fUIqltfL4DFaRybioAlwOjIq/B401vadNrGAA10xKYubYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naCs995RGyJjTvbDtpFM2xMSCZV5Or+YPJrn4Hnr6CU=;
 b=nLahv0n3uzIDEyP+ByTbSq5FUKGV+vFHLGcaaOP5owrshyXq7UZJ+qd6IJxYY5N+8L7Gi2k4OdGWirYsLMCdSJnO2K6awoMQamkC/Bd8NZ4Wycm0mNwwy+UhXamBL5Nk9/M+idkxFE0Zkr5TgzO6NM9a1J83Qd7+eDKS2ZJLxPtTR1ZrEhoUmf2h2okIPWOPgwSKOJeHJopOYvVOc02VOJ1kZlwzxRyORbKtVLPLa/Dkf3jF9YHZrLDQ2+9ia0N7WJi16uJ3seB/y+zHXcudHthAvbSunAWBzOISosRUFmBVNy9I9eGrts+i8AEzI3Q2j1Q3jf4+QO1lvd3ILCgvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naCs995RGyJjTvbDtpFM2xMSCZV5Or+YPJrn4Hnr6CU=;
 b=q9o37CeHxxrsyL0TTtcn+4AQ8ccElCz3wBHrPcL30OJHNFtkWyvE84bZ1TlzfjicullsxKbBDLxmmoh9UE1bj322hl7cROsrh5wLZQrr3YA7DqBS9IetCOM27ctRqPQirj13DrH5BAJzuS/J1Ky71tPSfLQylPXo8B2vT/Kg/O4=
Received: from CY5PR22CA0040.namprd22.prod.outlook.com (2603:10b6:930:1d::16)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:56:54 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:1d:cafe::36) by CY5PR22CA0040.outlook.office365.com
 (2603:10b6:930:1d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:56:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:53 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:56:53 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:56:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/43] drm/amdgpu/gfx9: replace BUG_ON() with WARN_ON()
Date: Mon, 15 Jun 2026 19:56:04 -0400
Message-ID: <20260615235645.737189-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: c005830b-ad1d-477a-f7e6-08decb39c6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: WwjkYXMmrmog9pRlxJXxKb3WDtHzF19g2M+NPaj6T2s2Q36widjT7PSHkf6kqcMY1JH4YLWu65wjV7qqDBJmTDkin4ZE99MK5wtH/l119NY1OFJR9892kPRNrcaYY8gx/mKCRvdMPSimt94ZvNw922Af14AxwLUZAO912Y+kaVkcuKDVcO7Khvr+2vRj7EJTYfrG4Je3nuuZpjaatYZz700QRA4kfh4vO0Voio1HOjVXorB1Du2ItztLASPppKMN7PPpzNNxJBcRy/KFPpiKpthO/8+RM9J53zZ8g6PcfdX754fMY9hdRbhr1JwKUr1WelDz4ImMRnfvLzTl8riucxVXIlR7HYnPnL2vS9+MW7l3G4M97pAe0102OJOcBYPeI/p8lwdYlVGFdJWNILuYb4H5G+a+vawzgT4FXlDAv2L8e/NDrIiIQjyQ5reZ2Zw9YabaC0QjiOZ/ujfT88blG3aFZMoTAz8Q/PNeJqaozK+pA1Pm0/M3cpblrLYABTDLEBL5n0iMTUhQd1qm6Y02vKZm52uYx3Xg9nlnSlWucGjITrcVj+K5aG7xv0k4BGHMLtbjK0wLbqNm95ZNt4DLhX6WJfQsr6W27yjlcKZ2bhBjremZLt/ReTxkPCStdyk2XOhtMe3jdHEfqb5gL6AmBMU5TrxAQQFsutlfNur9baLLp9HomzE+7m/hJM9cBD20tQPkPNYC/LauTdFWURZ5iN/WOj66tNioqXIiskUmJvk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PPadOezzYQaHYoMfoZYsl3+Pb2P+DwDTsoGrLKJqDERKJFkyDyzkJE0UTq8J1hTPid/raltKvRypZtJQTadnv3W/xmvmvT9fhotL2nGzhpXATdTI5QJE0FEuHsvbpBbqyPU8YdTSQ6zDpglyVb/pUrFol6dpOA+ECnWolgOhPX8UPc1rrbnRRKRXQHmBx11nPEmlWTgUbgVkjcyuoO2v72TwwEVNmVskZ3gbJugpMWwC405QnVEo8Va9YjlZr6rIrXHmQFgYFwD/abRrCY7IluX4nsDnrg6JmPPV2fF3k9qxwyJi4BS5pUMVsjoG4Fzyt+sr/ALrm5M3guwnex6rJQsYdtKr1PEHK4uqbvsUW3UiCbVPURtjFmoWP+wn6Y8R51UYeoXtgUp49Itmdts4t/mKobhGWQgKPbRtgcmjriC9zDzWuQSLNrviCy3pLYVA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:56:54.2124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c005830b-ad1d-477a-f7e6-08decb39c6d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 47721d0c37812..570dc90c187ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1183,7 +1183,7 @@ static void gfx_v9_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 				 WAIT_REG_MEM_ENGINE(eng_sel)));
 
 	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
+		WARN_ON(addr0 & 0x3); /* Dword align */
 	amdgpu_ring_write(ring, addr0);
 	amdgpu_ring_write(ring, addr1);
 	amdgpu_ring_write(ring, ref);
@@ -5435,7 +5435,7 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, header);
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 		(2 << 0) |
@@ -5531,7 +5531,7 @@ static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 				(2 << 0) |
@@ -5572,9 +5572,9 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	 * aligned if only send 32bit data low (discard data high)
 	 */
 	if (write64bit)
-		BUG_ON(addr & 0x7);
+		WARN_ON(addr & 0x7);
 	else
-		BUG_ON(addr & 0x3);
+		WARN_ON(addr & 0x3);
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
-- 
2.54.0

