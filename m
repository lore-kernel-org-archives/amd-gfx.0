Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06E0FC592C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 10:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4414810E8DC;
	Thu, 26 Feb 2026 10:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TWkA/Oab";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C9010E8DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 10:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVNKOtu6B7ngWPG3QQf4DEsuKQuz/c9l4Z/nJcMelBierryjXfbl7NaPsado4PUsIMoKL8Aa+/69ZTNkU5Nu0M2U0iT0VJz9iLVD8ouVrsiNDP61rj81fIwegcGIopwRcGQkIuS7vj5+4OHSKgcDg+k4vX1W9SC6ZyPfb/JD9ERxO1M/IlbY9cP5YFlQt03Pf6T+wBVw/P8TLymxK4CKkpAIy480HhQ04JUsz98Z/ut/p9oDaWWSwaGLhXJaoLEIwcxwkAWI+YFBrlPXj+7soBGYocm/EKpINnxuFyD5pi8XiroaVU8TFJP4mfYtoFVtTJWdKTjohvV9Orc+D6QxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCSWd4NHGbj7PaKl9tyiL+m5qVATtaK2C7PU5s7mWtc=;
 b=tZI4gIStLqD2SAgEXtrJHXFB5yMDLJVvtrtZCnmD0DG9P7hG9W0uV8eDJ4xhJAjl0cZmgiEotOWlLmFHznsEk6tgsPEL9p9LvEovTq5GkGit94QiVeMitOMFj6z2gfwN/1XeDWToHPLxWfVj5LKhWV9sU19Bg+mahxWLwPRMaiMFVzls3V2UxPJmk7LNFEdODcqRT1p3Oau+kK+lQXNa7SLWjQKPxc1T+TWITI+USdmBnY02uRQbdzH2C1jt4PkUGXC5AyDL64jeqWnLp4zddazVOdlcJ0L9zKrJsCXzo1sRjmjikEKAzwncdUmiHmOItuGbU6OagxWQNChD+j3rmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCSWd4NHGbj7PaKl9tyiL+m5qVATtaK2C7PU5s7mWtc=;
 b=TWkA/OabQ7xRR8oyAWpeU5svgsLou9S/w1k6mH04JR2fUhL+EiYg6cqTE/EVskuPKmLE7xTtKePb4qZKIumGKiuuW4amDpinWkZMUdpA7xZtj1WO0FhdjTGvsJnB8hBTxiKkj+3rV1pE2WZLstqCUuoOp55dFA+a41fCQ9g7S9o=
Received: from CH0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:b0::34)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:58:14 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::bd) by CH0PR03CA0029.outlook.office365.com
 (2603:10b6:610:b0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 10:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:58:13 +0000
Received: from suresh-X570-AORUS-ELITE-WIFI.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 26 Feb 2026 04:58:11 -0600
From: sguttula <suresh.guttula@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: sguttula <suresh.guttula@amd.com>
Subject: [PATCH] drm/amdgpu/psp: Use Indirect access address for GFX to PSP
 mailbox
Date: Thu, 26 Feb 2026 16:27:57 +0530
Message-ID: <20260226105757.883463-1-suresh.guttula@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: af8c9c5e-5bd8-400b-1d96-08de7525f022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|43062017; 
X-Microsoft-Antispam-Message-Info: K2NU+sz3LsKd8posvuhQyjI8G/hx2ySvLO4PDXkpOM4BMqBYFhIsYP7hH/iCA9TZdnW04Wuku2yoCEJokmCDrINt26m2mRmcMEm5TXX2slzjAhD+5Pub0EyfYU7Exv64sfCfvZPAxRc8xecAffTZpmsuel3bxE3oqS/32W7XEfUbDU3zeoX/BAq15wqae2sFG1qBv4sHL61e/oloHxhK5lRQiBdi8rjFBzklOossrZjo28/y0n/LPMYRRU4ZqaylstEn4UXkQ4vDSVh2vnjQksyA6Fzh8b/C3aW/poHh+ZoNJrbWLcaWPUKq3DPpfMOlMuAIFyv1GPjPwLxgyf4YQFw6uGcRbd0QgS8izUcEiQsTFZJTNKm4no0702jMaxMWlv2mONoxheoly801IC4gyHuoTyuZZMokytMfatiPlB7X0FraSSBuCfjkACCTtFdA9hLoomVmS0mFnRS6VWPZVurmgL4y6BtB18ovvLtJW0xpcPh94Z5bsHYW+9lO5yddvq1dV6AEghJ6rC2Jyb/hOctWP01wyPA03cuTYdU/KP3h2sfyOPOkcikGf5SpA4JJ9++uOzagt5C6fe8w3YYloQ4PryFLWoHnATXIfRRmBO+BjTFaawI+Ai42Ff6jqM9BI2h2OdvQVgOZgkeYtl1VbjMbTkv22JbZTg9kA39fPiCuiXU8h42Zky1cqfWYddRFh7Z8WiwFTr3sOTLaq3wgTUWhNZLQt8v1HgPlDGeJ7ib6Cx0oXCqLtzVBQMzAsb/jv58g0qtrALZoK3nJNw+RkOfP4X2KIN3Lsptpn0cWTdFpe5HxxCK6MRhDEN9a2LlsUEbbkWpe8nqctbnfQ2lfzeeQL5C4/pB6Zdzx1s0KaEI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6ym9bwn4dSkN1Yy51khoBhdZL/GRR7X848rDJGTMpMyXLAYaYKmohORJYND0ylNhXe04HgDJWQ4oorQsbVc8Xmgtgj0aC2bGeLoc0PEEjbJzK7HejqoKqZmTEld/DhSJvoIs+csmboXbOb76bRmuD7rpybjiAnpJOiXDMTCPz7KBZSGAuMx/oP0oJHuMtJIFUbjI4jYoovUrkJVwalJVFTzb/rQztkL1o8vfCr67TuFrltXtyPGswmVnHxDEwKyxu5LWSImEpMzrqKciQVbOyNTrnk27eiY/qKG3q0sqPCiEcGKSjgIyeTU8INCY3NS53kRM2yz567nnE9WOqCU9kpSmtUs8wOMSHdVaqqkOlny0voxj8HzKOuf+zp6TcnbpHN+QFPlT4pBWhxnEbi8L93aRtp664eMfLNYLs8E5jEK318Jc0n0TbCSwsaOXkRwP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:58:13.5642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af8c9c5e-5bd8-400b-1d96-08de7525f022
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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

The reason the RAP is not granting access to 0x58200 is that
a dedicated RSMU slot would have to be spent for this address range,
and MPASP is close to running out of RSMU slots.

This will help to fix PSP TOC load failure during secureboot.
GFX Driver Need to use indirect access for SMN address regs.

Signed-off-by: sguttula <suresh.guttula@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 20 +++++++++----------
 .../include/asic_reg/mp/mp_15_0_0_offset.h    | 18 +++++++++++++++++
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 723ddae17644..73a709773e85 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -69,12 +69,12 @@ static int psp_v15_0_0_ring_stop(struct psp_context *psp,
 				   0x80000000, 0x80000000, false);
 	} else {
 		/* Write the ring destroy command*/
-		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64,
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64,
 			     GFX_CTRL_CMD_ID_DESTROY_RINGS);
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
 				   0x80000000, 0x80000000, false);
 	}
 
@@ -116,7 +116,7 @@ static int psp_v15_0_0_ring_create(struct psp_context *psp,
 
 	} else {
 		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
 				   0x80000000, 0x80000000, false);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
@@ -125,23 +125,23 @@ static int psp_v15_0_0_ring_create(struct psp_context *psp,
 
 		/* Write low address of the ring to C2PMSG_69 */
 		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
-		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_69, psp_ring_reg);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_69, psp_ring_reg);
 		/* Write high address of the ring to C2PMSG_70 */
 		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
-		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_70, psp_ring_reg);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_70, psp_ring_reg);
 		/* Write size of ring to C2PMSG_71 */
 		psp_ring_reg = ring->ring_size;
-		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_71, psp_ring_reg);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_71, psp_ring_reg);
 		/* Write the ring initialization command to C2PMSG_64 */
 		psp_ring_reg = ring_type;
 		psp_ring_reg = psp_ring_reg << 16;
-		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64, psp_ring_reg);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64, psp_ring_reg);
 
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
 				   0x80000000, 0x8000FFFF, false);
 	}
 
@@ -174,7 +174,7 @@ static uint32_t psp_v15_0_0_ring_get_wptr(struct psp_context *psp)
 	if (amdgpu_sriov_vf(adev))
 		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102);
 	else
-		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67);
+		data = RREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67);
 
 	return data;
 }
@@ -188,7 +188,7 @@ static void psp_v15_0_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
 			     GFX_CTRL_CMD_ID_CONSUME_CMD);
 	} else
-		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67, value);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67, value);
 }
 
 static const struct psp_funcs psp_v15_0_0_funcs = {
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_0_offset.h
index 0e4c195297a4..fe97943b9b97 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_0_offset.h
@@ -82,6 +82,24 @@
 #define regMPASP_SMN_IH_SW_INT_CTRL                                                                     0x0142
 #define regMPASP_SMN_IH_SW_INT_CTRL_BASE_IDX                                                            0
 
+// addressBlock: mp_SmuMpASPPub_PcruDec
+// base address: 0x3800000
+#define regMPASP_PCRU1_MPASP_C2PMSG_64                                                   0x4280
+#define regMPASP_PCRU1_MPASP_C2PMSG_64_BASE_IDX                                          3
+#define regMPASP_PCRU1_MPASP_C2PMSG_65                                                   0x4281
+#define regMPASP_PCRU1_MPASP_C2PMSG_65_BASE_IDX                                          3
+#define regMPASP_PCRU1_MPASP_C2PMSG_66                                                   0x4282
+#define regMPASP_PCRU1_MPASP_C2PMSG_66_BASE_IDX                                          3
+#define regMPASP_PCRU1_MPASP_C2PMSG_67                                                   0x4283
+#define regMPASP_PCRU1_MPASP_C2PMSG_67_BASE_IDX                                          3
+#define regMPASP_PCRU1_MPASP_C2PMSG_68                                                   0x4284
+#define regMPASP_PCRU1_MPASP_C2PMSG_68_BASE_IDX                                          3
+#define regMPASP_PCRU1_MPASP_C2PMSG_69                                                   0x4285
+#define regMPASP_PCRU1_MPASP_C2PMSG_69_BASE_IDX                                          3
+#define regMPASP_PCRU1_MPASP_C2PMSG_70                                                   0x4286
+#define regMPASP_PCRU1_MPASP_C2PMSG_70_BASE_IDX                                          3
+#define regMPASP_PCRU1_MPASP_C2PMSG_71                                                   0x4287
+#define regMPASP_PCRU1_MPASP_C2PMSG_71_BASE_IDX                                          3
 
 // addressBlock: mp_SmuMp1_SmnDec
 // base address: 0x0
-- 
2.43.0

