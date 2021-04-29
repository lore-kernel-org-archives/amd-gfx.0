Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD81C4363E
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36F861450
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36F861450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012D96EDA7;
	Thu, 29 Apr 2021 08:14:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2386EDA6
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhKRL+qPdK/aW9NaaA36cO8JcuoIUTknAJK2bm/NdS1XFyhrYTYGgFTU3APoPsuZVBl9bYpslm2r1pGsgNFSImsaQZTtJ+RMmxtmwn3jxJda1foFOfoJ5GMXbbrtcuNUvtueIwLlSl0UZD1W0KJTGkwFs4icnRf5dGE7vqbdSNjjf40zkyGac1WnRlcTx3D92Gl04K0zAy/LIvov9VQQNMBil/+rIQCZ+5BmdYrC2dysgZoZEOWDWHwN8Ptu2yYyPmqaHzfY9keb4FBXbQg3enaDKfWFmgAHBtCQuT64x3tYqvuI6g8hfDjnRqrvAudMC78BCmyauQS5OGaybXJaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bq4dRY/lmqmHcO6qvI+NbNbtVGQE5Ex6aOB9vEWy58=;
 b=QAl/iCQ0TXQg41VsQAuuVBxCBuTP6969CdODzVl6XSiqj5mPCdSXWXJNBPlvwwhq/WcZOyRovICE5OM9/HioYB9Kapgy8qOhYqmtObG0WgfMrPpZaGJtjrncK1lR3fV8BByh9RW35hwzth2b2mRAYKPTZohTieLRIkMvpdPx9P8odbg8MZmRFI5btYw5y77gq3rNN0l7yrDvlUHSHeCgfBLPJw/30HlLa61NikV1uDSSrqdakqyusLW6iGLADtKdVP3P0SaSSH3y1hdsCLOxheaBeMBQW5bzwS4ZmziGk2485q8QMw1SuNnSjRvoQ1dz6UIVxsZqaTok+lFMdrorBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bq4dRY/lmqmHcO6qvI+NbNbtVGQE5Ex6aOB9vEWy58=;
 b=cFJAS4SSVQwUhltV3FOTyaFiQvl/dRisgqQdj1XkL/ndK47jqHS79N3YF+zgrxlLVHnZJAElOSDiCOOVKbRvlnbN7pRMe/TosYRimOvgGUJmKUTaZreP6ZX4Our/Q7T30/tM9YeJgx0V2kcRTi/nDfMjHaSHgdW5Lsg0iOUU1yY=
Received: from DM5PR07CA0138.namprd07.prod.outlook.com (2603:10b6:3:13e::28)
 by DM5PR1201MB0044.namprd12.prod.outlook.com (2603:10b6:4:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 08:14:11 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::dc) by DM5PR07CA0138.outlook.office365.com
 (2603:10b6:3:13e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 08:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 08:14:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:10 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 03:14:10 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amdgpu: Modify GC register access from MMIO to RLCG
 in file amdgpu_gmc.c
Date: Thu, 29 Apr 2021 16:13:40 +0800
Message-ID: <20210429081345.24217-7-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429081345.24217-1-PengJu.Zhou@amd.com>
References: <20210429081345.24217-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4bff6cb-53c9-4371-9e89-08d90ae6c546
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0044:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0044C34E4205D7B834E27EBAF85F9@DM5PR1201MB0044.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/zqKTgEENIomDHIVp8Hud+GlUPSzR4vq6EBZot+q2apJgEfW/uDiCw26LAS4zPGhOOUr8g9M3Z3/MNUNmph2SRCyVRmnR8W+JzxfyZsPQdnRyj/a+w2IwCTx1jVWFTrJdAO4x/VCPNUTg7B6cxeQqzoSmaZCPemEsZkFCtcQ94G+TmFnfHkW5yIKW4v/tbJsKGyXxEF7qsOazKFWDJuiFruZhaudP1JtAY8EpounYU58p4iucg8Uu+g0GRlNyaTVSrkFisHTWHWY3rTJ/m2mB0D4uPFGDvxl22gxhScYIDslAxm0HoG4K8pNFP/MwJKQwuBi5EHF0WORVcHAiFqj7jkQSGCJ9UUZ5xcWZ3gV1kEPBWBjPJPneypwX9V4iqEV86JdjTWxBghEHQEPzYFn11awADZ+PLO7YrGJ2QDQbfheF4V32YZlk9ioXlSQXb/DCRtrs+31w001rQt1KmtIAXIpfNV/cKf74tR7THXH9CHx7gKOwVYNmL9DcT8/K7MVETpr5lxpwoyVtMAWdzj4FD828ZHznmpKTDGq0RWnsXNFNKcgL7gfIg+/J7vMA/lQN7RiNfPlYDtAGtrXARJXqZC42v3H/5jTRxJcsdPcAZIqwsIU/+an1ZsruyjNBG+wEYvlRv6Gm619QmoviGoZTswKXT1QsFdCYFQ1mmOa2VUq3NZ8D6daHTk+TsIz3LS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(426003)(70586007)(1076003)(7696005)(8676002)(82310400003)(83380400001)(2906002)(70206006)(36756003)(356005)(6916009)(47076005)(81166007)(86362001)(4326008)(8936002)(2616005)(186003)(316002)(336012)(5660300002)(36860700001)(478600001)(6666004)(82740400003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 08:14:11.7161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bff6cb-53c9-4371-9e89-08d90ae6c546
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0044
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
index 4d32233cde92..f1e04b9872e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -578,13 +578,18 @@ void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
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
index 2bfd620576f2..59e4022bda8a 100644
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
