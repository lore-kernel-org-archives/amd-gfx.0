Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307E2C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6408613CD
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6408613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6741A6EE1B;
	Fri, 14 May 2021 07:27:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4470B6EE1C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZiNBnckAQQGwXc5mG+CCRc2yDDfqBqUwuWqd9lrUf0txokrRLtFXo+GOOTdhcBsFTaR2/pzCyzolcMO+5A3TtVfpRoZ96gtlOvsHg9Sl7nRInsCzN5NbSEO1cBam0eXtBo9hrhhN5NFB6NNeSDWFKMtlbX+WdUu4Em0zglKqMlypoWb/HEQxoYAi/hf9gFOAnLQdADqT0osTPQ9yAZENrVzHGTGzGUtjr2v+5twIk1t6/A8762pA0Sq53mnrf7e9m1u8dXEaDAIw3QlASINydccKwYkwqHu86p/yOxzR4EtNEgn+qA1uHiPKYH6QNVh93KteQoT5QNB1NQ7wOP77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGnazp67wmWRFsEHAhtzaGZEwj/sbWR2RrTwLFs7Yrg=;
 b=MJkI5XRS9tbwYPQO/Bo6fj5GWxsPah17T0FkkSpufzoUo0Yo7HvmE2ap3C2n1NLwrHyppOEzLNq5cmFa7LijgMaTrYnkWQtSxofOVzfZCcOxLZeA19ZTSQQ4TVaVmVYf+pe9QBBb+e7s55rkNx/8LA1XrIduA/TW1PveC+7TyylnuZ7/6wFUAx9IrRV2dsHPTUsY86b1BtEOdy8B9P0QLBxH2d9z7tDo45kLmN7WNK32lOWznykW15rWtHsYL68vbnuMRChhncKQxRmHmJMrvrVmWJHRwWwZLaEeE9KFbz6WosmsXtpnn/8C/AN4vWLw5t6crz/WUcHyzYT1unh/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGnazp67wmWRFsEHAhtzaGZEwj/sbWR2RrTwLFs7Yrg=;
 b=YI0oE95uNgVdZK8bn7/ajzgwN2nFwA9eKvlnq+kON16xJDSoUQbrsu5ZUX2wvWm39sHUcQQUUOl7vpCDkGYiNvmudBWxCT1LA+hPkgy2tc/vNRcK2pa4Z3kpOGrb4+fKyjBGWPCc7QDn0e4j5IAnsAD/ZsGKDuj3jm7Py16fQpQ=
Received: from CO2PR04CA0129.namprd04.prod.outlook.com (2603:10b6:104:7::31)
 by BN6PR1201MB0114.namprd12.prod.outlook.com (2603:10b6:405:4d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 07:27:18 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::74) by CO2PR04CA0129.outlook.office365.com
 (2603:10b6:104:7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 07:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:27:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:16 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 02:27:15 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 03/16] drm/amdgpu: Indirect register access for Navi12
 sriov - RLC interface
Date: Fri, 14 May 2021 15:26:53 +0800
Message-ID: <20210514072706.4264-3-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514072706.4264-1-PengJu.Zhou@amd.com>
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7a4fb0d-3be3-4f47-953f-08d916a9b438
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0114:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01147E09C5D4042D73C112E3F8509@BN6PR1201MB0114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWXQVR0PecTzbSfcSadECWMxpb/h6XeQPG2M/SOK/Lh+M2dKDqZG766dwsBgG1/VnTLRsno53xUBY2FZYoO0x2SIMWkLplJg3jD178eS666tS+q5saBY1pQOltWAtkvqoHZKndvFan8xyqdZkvImqiODh4HEBTgTem92cZ28KX6i9uBY8BkmS4kofFNcv/6hK6YKmAA3ff4BVcijjAjF7tDmtRXS5SfRvSeflOkApSJLKrHHOB5ki8Da2UUfDCY4pECnhP2mwdsaoW65dX02WzfsHt+GuaN5vwDqBsPALU7z0/JSs2fSBZnovv/8MHg9VTZqxBNjAXn1LQ3KE+imvkXBS/+5Gsh65RREqs0lj/U1THZIyB26NxoIcQNWY2R/CbbKwXKChpvJHMVDXnQdqhEdhVd8yzAxt1n2M1J/FE47iXnQdzltJ0F6Tpq0yFtcDwYJnpHbaBC7UExt+EDyy4C8Rv26r284gk7EnB1wfgP4TfQfQSnko9Xs5mtMJA7emI3ldOcWdlxoliMog25l2vVbPE8h5pnZ+h4/tUV1Cu8fsTa1wjY0/TQ3QeWY5JxvTaML0WcDGgczbl63vYthYmGQJxVKIsw9d398I9QmHdhTA1t37XlQr1YBmsarSjzo0n/Hy4gNaKu1MxAswdycyxG5YJD7bD6oA39ISQFBf5ci6ZenFFWfPhbArJpZ7zWz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(1076003)(70586007)(6916009)(47076005)(5660300002)(4326008)(2616005)(8936002)(36860700001)(356005)(316002)(83380400001)(6666004)(82740400003)(426003)(336012)(8676002)(478600001)(2906002)(186003)(81166007)(70206006)(36756003)(7696005)(82310400003)(86362001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:27:17.6957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a4fb0d-3be3-4f47-953f-08d916a9b438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0114
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change RLCG/SOC15 register access interface to triage
GC/MMHUB access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 46 ++++++++++-------------
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 125b25a5ce5b..c3c75c1f628f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1144,6 +1144,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
  * Registers read & write functions.
  */
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
+#define AMDGPU_REGS_RLC	(1<<2)
 
 #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
 #define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 1c4262dc94e8..c781808e4dc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -100,12 +100,7 @@
 })
 
 #define WREG32_RLC(reg, value) \
-	do { \
-		if (adev->gfx.rlc.funcs->rlcg_wreg) \
-			adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, 0); \
-		else \
-			WREG32(reg, value);	\
-	} while (0)
+	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP)
 
 #define WREG32_RLC_EX(prefix, reg, value) \
 	do {							\
@@ -131,24 +126,19 @@
 		}	\
 	} while (0)
 
+/* shadow the registers in the callback function */
 #define WREG32_SOC15_RLC_SHADOW(ip, inst, reg, value) \
-	WREG32_RLC((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value)
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value, AMDGPU_REGS_RLC, GC_HWIP)
 
+/* for GC only */
 #define RREG32_RLC(reg) \
-	(adev->gfx.rlc.funcs->rlcg_rreg ? \
-		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, 0) : RREG32(reg))
-
-#define WREG32_RLC_NO_KIQ(reg, value) \
-	do { \
-		if (adev->gfx.rlc.funcs->rlcg_wreg) \
-			adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, AMDGPU_REGS_NO_KIQ); \
-		else \
-			WREG32_NO_KIQ(reg, value);	\
-	} while (0)
+	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP)
+
+#define WREG32_RLC_NO_KIQ(reg, value, hwip) \
+	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip)
 
-#define RREG32_RLC_NO_KIQ(reg) \
-	(adev->gfx.rlc.funcs->rlcg_rreg ? \
-		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, AMDGPU_REGS_NO_KIQ) : RREG32_NO_KIQ(reg))
+#define RREG32_RLC_NO_KIQ(reg, hwip) \
+	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip)
 
 #define WREG32_SOC15_RLC_SHADOW_EX(prefix, ip, inst, reg, value) \
 	do {							\
@@ -169,12 +159,12 @@
 	} while (0)
 
 #define RREG32_SOC15_RLC(ip, inst, reg) \
-	RREG32_RLC(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
+	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, AMDGPU_REGS_RLC, ip##_HWIP)
 
 #define WREG32_SOC15_RLC(ip, inst, reg, value) \
 	do {							\
 		uint32_t target_reg = adev->reg_offset[ip##_HWIP][0][reg##_BASE_IDX] + reg;\
-		WREG32_RLC(target_reg, value); \
+		__WREG32_SOC15_RLC__(target_reg, value, AMDGPU_REGS_RLC, ip##_HWIP); \
 	} while (0)
 
 #define WREG32_SOC15_RLC_EX(prefix, ip, inst, reg, value) \
@@ -184,14 +174,16 @@
 	} while (0)
 
 #define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
-	WREG32_RLC((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
-	(RREG32_RLC(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg) \
-	& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
+			     (__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
+						   AMDGPU_REGS_RLC, ip##_HWIP) & \
+			      ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field), \
+			     AMDGPU_REGS_RLC, ip##_HWIP)
 
 #define WREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset, value) \
-	WREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset), value)
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, value, AMDGPU_REGS_RLC, ip##_HWIP)
 
 #define RREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset) \
-	RREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset))
+	__RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, AMDGPU_REGS_RLC, ip##_HWIP)
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
