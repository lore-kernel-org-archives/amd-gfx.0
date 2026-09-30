Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DE6CA5FAD
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 02:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BF310F145;
	Wed, 30 Sep 2026 02:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iKEFPy1u";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40BA310F145
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 02:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p44RjQVSB5ilSiizAwwqvADYGNTaXtdZpJAAvYUbzmtNd9Ub8AABAsagpOsM8/myqS51xOUkd50yKPwRkrwVwz2/YqF2DIGrdf6CoEAqTBs+6Utcm4uNDbgVItXim1iGCszbXilkSW7y/DoWTm7dR7U46A/PGz161AJPAiz/CZtkI+YmuVlGa92vIlOs+NDe2GokZ8Tuamn+TScTXLFBj3k08cLcB1gQ7fPdqIICptFC4JDnspDZ6ia8RLauWTLm7jNxCDeGwqtS00UzQD1sGYbwJtAgWqkEfHsOX5EfwZxRtJVMEw660j6oHyFPBMpqTV5L5hh4r5Ckxn40y222PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2VV2p8h5sgdliO55AemWMU8CUeBTe2/HjaKDLsExEI=;
 b=cXScVifR1J6Gsweh9V+MNc1arIzuFrmoG8EaTBPMfZ+/DzK3O78REUwEG126JfdZXVaWwQJBPBYSNNdGJSGH06OtBSMlukGZputb4HdkuxOhl5amUdm3EVr9b5JRRt1BcTC4NyiEmTS436Fw/H2M4Q6zH4VI64Y2d+v9nv7rICVr7EHiL7tyK/UmIt6i5pMUPTEfWYkSnezLatHWAl6v9e40qzh8VdVD8Ibb4JqKRICFK53U5RiDn1KEH1i9jNRiQL3HEtPExxVr0+qde/7pMFLawuE6XgsvLRRyDv+0GEaJ3VM83NI9BOfqM1pmhsgMO77nHZe8nGPT4FAQQrJtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2VV2p8h5sgdliO55AemWMU8CUeBTe2/HjaKDLsExEI=;
 b=iKEFPy1ukZKrWPzc6IBNqm0CQ3rXmKEWZ5ge1GsmhByxvsKYFnK/4z0FadLfbAFxYXVzN8rfDo9yIf4DBKFyk+uCLMTu7gpVh5es1rwzIGmQf1WvxAPvbOeK/rBKACoeMSwNXpzO+TowPPgzbfs1yAq6a1Y+h44HCYiN0AN5L04=
Received: from BN0PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:e8::21)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 02:47:13 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::f) by BN0PR04CA0046.outlook.office365.com
 (2603:10b6:408:e8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 02:47:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 02:47:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 21:47:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 21:47:12 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Tue, 29 Sep 2026 21:47:11 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx12: read xccs-per-xcp from RLC_IMU_AID_CONFIG
 for VFI
Date: Wed, 30 Sep 2026 10:47:11 +0800
Message-ID: <20260930024711.70728-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b17f6f4-c5f7-46eb-0aae-08df1e9d21ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 1SDtl3xPAWxJimnv5F/RaDJd8juzYAOekgJX+pJn+iSHHmllTaYm6sCB85r56F0ygEgJT44Px5Ck9EhQgKHEYVSIfhR/w26h/faD6+TCBTNIyReNqY4ZpgM4Jv4M6z3Fw+Or6+CricyghBHgQOGCruaPcNFnukkvlYQbZ55PV+Qd9ir4JkjTfqWLQI7P61CT21b5voyLrO2PyjgMRJ9FobX1EeTC+leuafjpF9mJIfWE04yqzg+QPMqHHbeZEAfXbYT/SJwMxRWZ+Jf17zLMmTPhW0810T/CRs2uL42JI1HB1s82fh0Sa4Te9wQwZhR4sCwBmgMkBePqaZe8m4urSApxlu13D1JCOFti4eaY5k54C5ztgT8Hob2TQtUuOLcE2o6v+6bwdRGB01iZIj37PcTEj41i4G94BjOtTSETDJEXSwBFLH2c8wgv3BBkEYN2pUw6NQFQpacVklb9Co1ny58h6kX6FaB5Mpx/IgPZ7V7UUhSYOOqUQsLoPSP2/+/KwY80epmBbRGDZHmc5M5eQcmflPR3SjgUE/hI4taOF51ZeEsnu7J3bRRv6wXgWRj0DE/bAEFc8ePWlLoGL3Efg8CtE1u0q4RvK1DAQ6gQkpPxrXfQNNUXB7y72h3t8cKnkIqaHTEbUAfBwvgZn9jgDnMq/hcBL8bUc4y7LIQaSvf9jEcl7vl2bbX//JHQ8ZLKP92TmcljOXZu644rlYcPjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wQRvzXEthXIzLD/O5iEKH5ICs7/TXCfW55+Y9cTL9XGsLrvLW4myDw2J/wbAF/Z3sPp1YywIZUUiqp46eK83qfwNTUIyq3c8muxPImEXcSyOgGEkUOe4upGiwIJyzHAG0KBA1ryW5qSil+2NbmIQXFINIr0aeK2T7+I550UTBkT3IvZVX7qa/7dycN0Sx1o+38fGzELXAZzyN/wIbofgpCpHd3XJ02puSplDM56kEJK0Ygrt48vpoftoQT7X9zaGLTWyUpR80HPJjuRtE6tTi1CMwVNDLUk/fPINnyX9YKU7iaJvbaweNqarzRo8LoYAw2j8haNEt2gQo8vkMolbKXWIdWXYY40Z9QqeRINgBSlQree6BYGBivbhkS2VbID9UezbROcusajxg6myFPttzO3lnv98YgSgkCwUxdsKTJfk1W8Apdo53wlDESDlw+M4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 02:47:13.3107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b17f6f4-c5f7-46eb-0aae-08df1e9d21ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
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

gfx_v12_1_get_xccs_per_xcp() supplies the compute partition layout that
gfx_v12_1_cp_resume() needs on a VF. Once VFI is enabled the VF reaches
registers through RLCG, which cannot access the GFX_IMU registers, so the
GFX_IMU_PARTITION_SWITCH read stops working. Take the same field from
RLC_IMU_AID_CONFIG instead, and read it with a direct MMIO access rather
than RREG32_SOC15, which would route back into the RLCG path.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c              | 13 +++++++++++++
 .../drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h  |  2 ++
 .../drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h |  4 ++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 1cf175aac4de..4498e253846f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -703,6 +703,19 @@ static int gfx_v12_1_get_xccs_per_xcp(struct amdgpu_device *adev)
 	u32 reg_data;
 
 	/* the register data is expected to be the same on all instances */
+	if (amdgpu_sriov_vf(adev)) {
+		/*
+		 * RLCG cannot access the GFX_IMU registers, so take the field
+		 * from RLC_IMU_AID_CONFIG and read it without going through
+		 * the RLCG path.
+		 */
+		reg_data = RREG32_NO_KIQ(SOC15_REG_OFFSET(GC, GET_INST(GC, 0),
+							 regRLC_IMU_AID_CONFIG));
+
+		return REG_GET_FIELD(reg_data, RLC_IMU_AID_CONFIG,
+				     TOTAL_XCCS_IN_XCP);
+	}
+
 	reg_data = RREG32_SOC15(GC, GET_INST(GC, 0),
 				regGFX_IMU_PARTITION_SWITCH_SHADOW);
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
index dbd497d9fac1..249ffb38c05a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
@@ -6649,6 +6649,8 @@
 #define regRLC_IMU_MISC_BASE_IDX                                                                        1
 #define regRLC_IMU_RESET_VECTOR                                                                         0x4e17
 #define regRLC_IMU_RESET_VECTOR_BASE_IDX                                                                1
+#define regRLC_IMU_AID_CONFIG                                                                           0x4e18
+#define regRLC_IMU_AID_CONFIG_BASE_IDX                                                                  1
 
 
 // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_cpwd_rlcsdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
index 68dfafd8d027..f4a21a8c4e1b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
@@ -20866,6 +20866,10 @@
 #define RLC_IMU_RESET_VECTOR__VECTOR_MASK                                                                     0x000000FCL
 #define RLC_IMU_RESET_VECTOR__RESERVED_MASK                                                                   0xFFFFFF00L
 
+//RLC_IMU_AID_CONFIG
+#define RLC_IMU_AID_CONFIG__TOTAL_XCCS_IN_XCP__SHIFT                                                          0x2
+#define RLC_IMU_AID_CONFIG__TOTAL_XCCS_IN_XCP_MASK                                                            0x0000003CL
+
 
 // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_cpwd_rlcsdec
 //RLC_RLCS_DEC_START
-- 
2.34.1

