Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146B6C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D622661CDE
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D622661CDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B2D6E9A5;
	Mon, 17 May 2021 14:39:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 199366E99B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 14:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEKlHIyat0ch3yjZ0VTnHy6PC8FPBohC0cyrknpI21+BDfqsmXeaf4iggMAqBeBP7mAE31R0kAf5nFnk12jxNp/jvkQjoY3hACKKZfGPjBF2JcSco3Jq+9b0biPgVL5dSCXsSiOPloJBmGzmbwuPX5PBoXtravgyjPjoa+Z1E1XbjPeHiovplfLid43LalN/Z+yLyjXXVmZ3MyeypoIIwBt0/U+0GghCKojfqKi7336VCgXR/TURwV+/esbXO1TN17u9Uh6Dnx/ZlfXU0UoktdrDhkbgydMtwiAkBgtcrEFmNRZTm+TgoucUXACPbPEoD1mbHtCwJmpi4kVqB6W1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbjy8o3Hjh55j3obmPnbbYIwvUTPkhFucPj81PD5JnE=;
 b=JhkTBRqa+7RHpvikFbX3EewLCAAUnJDz4DCJg3hcjhJpfDDG4rDfg09iZWEDfpCC4Cb3FEqS/qvFyR4ga/oTHI2b/eIi6oRYTPKJgLNnYXdwgTYk+48GOPVPETjvOksOAOeO6a34SHx58gEbrFvC91yd8r6wH9kgJ94oI61xz7/bF6gTZJjXz05ohgmkbzMY9Lfedqya0spv6fqHOT1f3R6dq/tq83mUkDCuYMx9sx+MRVhVYIfFM5GKdLOehY/Ut0MnIKAIRqQ8mbpnn+MHyrlLNG+JkImTrKTyLg2c973DFfSAmITTJ3ntHaFuRQk8wnJ98VHLdbeLRctue/BeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbjy8o3Hjh55j3obmPnbbYIwvUTPkhFucPj81PD5JnE=;
 b=Leqcik6mCynEVRiAZaooYE8ZncoQYIl0jw1q54VA5A66y3XqxTVL37dnzO/nO+InO3ZRGeZnVFOnYbvPTHnDjzT1TDBEXSWwJ8jhqa2oPDMsSHTtm9vrfj0l7joz0L4Pu4cZjkPkukFGvtiF7bbUz6SN3VgSQnrA/w1IMG0W4vI=
Received: from DM6PR06CA0044.namprd06.prod.outlook.com (2603:10b6:5:54::21) by
 CY4PR12MB1686.namprd12.prod.outlook.com (2603:10b6:910:c::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.31; Mon, 17 May 2021 14:39:26 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::a3) by DM6PR06CA0044.outlook.office365.com
 (2603:10b6:5:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 14:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 14:39:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 09:39:25 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Mon, 17 May 2021 09:39:25 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 07/10] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file amdgpu_gmc.c
Date: Mon, 17 May 2021 22:39:07 +0800
Message-ID: <20210517143910.2125-7-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517143910.2125-1-PengJu.Zhou@amd.com>
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f65228bd-3ec3-47f8-3015-08d91941925a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1686:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1686282FEDA4E2EC8CD3B845F82D9@CY4PR12MB1686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7zYXXTmF1e5wyvDfH7W6gkbhmXbzfuYroe1BPvNsZNUWJV0GSopH0+iEr+8qDP2ZpAE7GzwryX/hMG0tpMI7Vajofsti5NfK96g9suBG71rcEW/DbyKXwKBhnZ8QGW6PnA4F/u3VtGAxDp9ptiGEiXxC7fWJvgMRJv1uEdrWD85MdUu9X0FvOz8TdDo512zeTowNuF6+bFAtDth9bawGTh5eLwYOPrve2GmIFvGcnBSmCf6N38pn4ZvOOkHqxk9jLVsKx4SsZ0c/mijW1ZWQoAp4oAheeGTH6AGv8KN24Tcfde5ahZDCUDzAsxPsTxUD2OG/x6tBZ2ijNAggQIZuDtrGZFlCgU1qPlDvhaOgbiOH6FdxDRoCwmqgWYTy2A7sM7B4olNtoLMVL7MaB9k5kb3+lxPzyo23opdNgqLOtg950loSrDsJ6oBG78xwFTU6HQWhvr22qy+dLSAqYdZPwKePigzVT15M3aot28WaIkywhfwwVFd/iES6ek7jQoGyIEczpJgnUn760hzSkVvwEjsNWgvqSkeu/UFJsRzeDVkZA7sJjY7Aahc5DpIVUKVX1d9WRiGBLcPpZP/hNm61F1F+LMHKUr70pB8fiAeaNcoXWIGcDy7VSI2GYXaP6PltWru+qTtb7EW4azYsUKrJd0Z3GNvUzEmo3FXJhR0OfXpniNfXnhVEjJSwnH4SDDr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39850400004)(396003)(46966006)(36840700001)(8936002)(7696005)(47076005)(426003)(36756003)(5660300002)(4326008)(186003)(70206006)(36860700001)(8676002)(70586007)(82310400003)(26005)(82740400003)(1076003)(6666004)(316002)(6916009)(356005)(336012)(86362001)(2906002)(83380400001)(2616005)(81166007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:39:26.7579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f65228bd-3ec3-47f8-3015-08d91941925a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1686
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 25 +++++++++++++++++--------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a129ecc73869..3313d43bb94a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -629,13 +629,18 @@ void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 	for (i = 0; i < 16; i++) {
 		reg = hub->vm_context0_cntl + hub->ctx_distance * i;
 
-		tmp = RREG32(reg);
+		tmp = (hub_type == AMDGPU_GFXHUB_0) ?
+			RREG32_SOC15_IP(GC, reg) :
+			RREG32_SOC15_IP(MMHUB, reg);
+
 		if (enable)
 			tmp |= hub->vm_cntx_cntl_vm_fault;
 		else
 			tmp &= ~hub->vm_cntx_cntl_vm_fault;
 
-		WREG32(reg, tmp);
+		(hub_type == AMDGPU_GFXHUB_0) ?
+			WREG32_SOC15_IP(GC, reg, tmp) :
+			WREG32_SOC15_IP(MMHUB, reg, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index c134af6b0ca0..52eba885289d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -229,6 +229,10 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	/* Use register 17 for GART */
 	const unsigned eng = 17;
 	unsigned int i;
+	unsigned char hub_ip = 0;
+
+	hub_ip = (vmhub == AMDGPU_GFXHUB_0) ?
+		   GC_HWIP : MMHUB_HWIP;
 
 	spin_lock(&adev->gmc.invalidate_lock);
 	/*
@@ -242,8 +246,9 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	if (use_semaphore) {
 		for (i = 0; i < adev->usec_timeout; i++) {
 			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem +
-					    hub->eng_distance * eng);
+			tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
+					 hub->eng_distance * eng, hub_ip);
+
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -253,7 +258,9 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	WREG32_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
+			  hub->eng_distance * eng,
+			  inv_req, hub_ip);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to be cleared
@@ -261,12 +268,14 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if ((vmhub == AMDGPU_GFXHUB_0) &&
 	    (adev->asic_type < CHIP_SIENNA_CICHLID))
-		RREG32_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng);
+		RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
+				  hub->eng_distance * eng, hub_ip);
 
 	/* Wait for ACK with a delay.*/
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_ack +
-				    hub->eng_distance * eng);
+		tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
+				  hub->eng_distance * eng, hub_ip);
+
 		tmp &= 1 << vmid;
 		if (tmp)
 			break;
@@ -280,8 +289,8 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
 		 */
-		WREG32_NO_KIQ(hub->vm_inv_eng0_sem +
-			      hub->eng_distance * eng, 0);
+		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
+				  hub->eng_distance * eng, 0, hub_ip);
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
