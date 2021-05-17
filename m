Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FD6C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D37361CDD
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D37361CDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EEF06E9A2;
	Mon, 17 May 2021 14:39:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6966E99B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 14:39:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxznqykbKMhzCdfFAlAULvnEyzz0F470A9pcLzHNo2WIDDjYaXxykULRDYxvR2e6EOljmUrQIjTgXCFGmzULg/MOhN+CNwGDekJ/yALZrO5KM9mqjr800UxC9yHjSfOikitVoyHfRkfWQQ5dm4hp4RgEvjS7Y4LSWzQawBhMp6hjh0+i9ltCoX+ZO1CibTlDk7JoZrbrpRn1Jb9hq0M996Fsyv8yuQ96QL8ypXsozFrOOxCcFnfm+UtOMeY/fekAkr5PNaIBwCrl8bOwJoNKMBhXWQPiq/sZFn5ucMgmiBKaIoqDx5P3Z4/uze4lfHusn+JFZosX3dAzLsj9j7sxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaqCH4YteqdVLcn78lmllSvO+oVO8MeraKe40r1E4UQ=;
 b=Vz5XLDrrsIS0sZQntrYXs/putsk8vPrLETHLjwpo4JdzjMOb2ZApCPwmgsZxnzhUJf5Eg4y+ygbgDYfDQhWzQOSH4670V7SU6q+1BRbXW3p4XiB4atx3f2Alu2LEds9PDXztkhbDWJkDmj57Z9jJQ9GKB6DXG0/fQXg4k5DBOsD+NfFdJOWkchBZNcSr1BDvjb6S5WWZOfAr18C5Bfb1ynYHenaBtVZytk10lKyGPLHfQOXcZdZz/XjG+OxLA7ntWnqsThi19KrC5ZKyf9yE+GhQQX1X9x0SMK/Mw/wnUluPd/mF9t04PcAwqIQWD/vrtYYb2h7wI88YXQElP4hxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaqCH4YteqdVLcn78lmllSvO+oVO8MeraKe40r1E4UQ=;
 b=CjCjzoigCwsWdK0XoVkCqeLlC+gsweNHqXEM67lMS2Oe9VEml8luRnROrUj/Ekm4pvRMllwVU0aAWsaeG34YtEcmmvc3LBs2Gg/G+VRW3wVuEECsUfTeI/cNMxEFNXyD6UVWMswspx4t2aWWDHlm4z7o000BAAwyoDhmvyhoCbw=
Received: from DM5PR22CA0011.namprd22.prod.outlook.com (2603:10b6:3:101::21)
 by DM5PR12MB1913.namprd12.prod.outlook.com (2603:10b6:3:10d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 14:39:21 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::a7) by DM5PR22CA0011.outlook.office365.com
 (2603:10b6:3:101::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 14:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 14:39:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 09:39:19 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Mon, 17 May 2021 09:39:18 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 02/10] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file gfx_v10*
Date: Mon, 17 May 2021 22:39:02 +0800
Message-ID: <20210517143910.2125-2-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517143910.2125-1-PengJu.Zhou@amd.com>
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0951e613-15ba-40b3-1de6-08d919418ec6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1913:
X-Microsoft-Antispam-PRVS: <DM5PR12MB19131ECCDB6B8FA9E6151825F82D9@DM5PR12MB1913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvkAgyquBSGNaOLB2wvvLvqYg+NwRWUWD3Nka4WKWNuRhwIQQPEM/jw9slHQCy5tkyNwYWrir6goHvarrGEt8R2zZiqB1vhx862czWeld6szoP3v+nrRouVIzGXKgkCayQFJO4MvuRIhIYea07tJQrudPRTB1F+PNRBrMkB0p6vvLn/wtbwSQ2tvAwWlVz0D1P9K7CBLnbzl6TWIwF6wFvCZvTj4Qm2dSkVse5ZG+p63vcaSiBefYmwHKML0cQ03bp4Jxzh3hIYVJNLgbCkj8d9cd7bIb2omqc4NkeYKRdpRHgPDfJXmpbDAb+o+M2eNfGRxaBQcWFiKobS/7Y+eBVoCwUU6h8hua/Cd9psW+DLF1zh9UyPOeDU7sZa45b7N0p1A2FscPQJ3nFdv6vMgIftUsQl5KsNd73sEDSbjCPhpV3qIdM5ogG9mtEP4Dpvx9HRjNaI7wLfDBPq4djmhuuLuLfaBYOs1qholdP/wttvBCIHAOvkHkVALG3StmLIxmV1BgKrLMGH8D1r8Nt5u3SJ7g8JLkF/gA7tLQrgwLhMz7IENTFmhruDKrAUtAzFK7Qi265+1PpXY5Xauy68ddLkDmnYo5Lrk/z9ehJ3AdHW8sHIPY4ETs8X/vqj1IJ5MkAnTSWQ8jGxiZixSifsvSXZwDSTMcWFd6ZJJnYdGmUAaRk5vv1O+yrUc2RzHZIw3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39850400004)(136003)(46966006)(36840700001)(81166007)(47076005)(6916009)(336012)(8676002)(6666004)(26005)(4326008)(186003)(36756003)(1076003)(36860700001)(8936002)(426003)(83380400001)(70206006)(70586007)(86362001)(82310400003)(356005)(82740400003)(2616005)(7696005)(5660300002)(478600001)(2906002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:39:20.6793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0951e613-15ba-40b3-1de6-08d919418ec6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1913
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

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 32 +++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7c5c1ff7d97e..952a2f0f2f4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5178,10 +5178,10 @@ static void gfx_v10_0_rlc_enable_srm(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	/* enable Save Restore Machine */
-	tmp = RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_SRM_CNTL));
+	tmp = RREG32_SOC15(GC, 0, mmRLC_SRM_CNTL);
 	tmp |= RLC_SRM_CNTL__AUTO_INCR_ADDR_MASK;
 	tmp |= RLC_SRM_CNTL__SRM_ENABLE_MASK;
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_SRM_CNTL), tmp);
+	WREG32_SOC15(GC, 0, mmRLC_SRM_CNTL, tmp);
 }
 
 static int gfx_v10_0_rlc_load_microcode(struct amdgpu_device *adev)
@@ -7876,12 +7876,12 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 {
 	u32 reg, data;
-
+	/* not for *_SOC15 */
 	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
 	else
-		data = RREG32(reg);
+		data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
 
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
@@ -8621,16 +8621,16 @@ gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		cp_int_cntl = RREG32(cp_int_cntl_reg);
+		cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
 		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
 					    TIME_STAMP_INT_ENABLE, 0);
-		WREG32(cp_int_cntl_reg, cp_int_cntl);
+		WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		cp_int_cntl = RREG32(cp_int_cntl_reg);
+		cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
 		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
 					    TIME_STAMP_INT_ENABLE, 1);
-		WREG32(cp_int_cntl_reg, cp_int_cntl);
+		WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
 		break;
 	default:
 		break;
@@ -8674,16 +8674,16 @@ static void gfx_v10_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_SOC15_IP(GC, mec_int_cntl_reg);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 0);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_SOC15_IP(GC, mec_int_cntl_reg);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 1);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
 		break;
 	default:
 		break;
@@ -8879,20 +8879,20 @@ static int gfx_v10_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 					    GENERIC2_INT_ENABLE, 0);
 			WREG32_SOC15(GC, 0, mmCPC_INT_CNTL, tmp);
 
-			tmp = RREG32(target);
+			tmp = RREG32_SOC15_IP(GC, target);
 			tmp = REG_SET_FIELD(tmp, CP_ME2_PIPE0_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 0);
-			WREG32(target, tmp);
+			WREG32_SOC15_IP(GC, target, tmp);
 		} else {
 			tmp = RREG32_SOC15(GC, 0, mmCPC_INT_CNTL);
 			tmp = REG_SET_FIELD(tmp, CPC_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 1);
 			WREG32_SOC15(GC, 0, mmCPC_INT_CNTL, tmp);
 
-			tmp = RREG32(target);
+			tmp = RREG32_SOC15_IP(GC, target);
 			tmp = REG_SET_FIELD(tmp, CP_ME2_PIPE0_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 1);
-			WREG32(target, tmp);
+			WREG32_SOC15_IP(GC, target, tmp);
 		}
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
