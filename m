Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB92C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149BD6140C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149BD6140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A66046EDE5;
	Thu, 29 Apr 2021 10:27:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D086EDE7
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 10:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgpJS5LkB4T1h1TFxkabeJk7w2HxV4L1LBLYxxkC9UOoVyHb1c0NFkzmmhjJ8jAT8NXWdUkghmsMbIg2Yk0VAyUo/B/K2/f7Y2LIU3CL9BQn2mtvdGBgxHKW3d6n6+THjdCxgdGibHdyKBzsNPTkQTUpZAbwllzu+eLpTFvZ0WKNmTE51+cNorRu0mYWOiqRcMG5TBK5hiFtGMf4JBoKxIFw3EnZ+4Q/4mkdcKfauy3goVmTh5JwzJL4K8CNOIbaJaYDJzGZmxqJqQK9fDvMg7gaJ2sYICfVqBQ/bkp1fmvtiqtIo+DKrIAtQYnhZYNNrnX1XlhnXJPqg7Me7Vcjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfWCCtcnDmI0QPxA3y0TDZxSkGoE3jOyH62RpIp5R8c=;
 b=kLMdKdTK/3d86PnVc7mhNOLqqRc4/9MWrP1bsvrUaBDsP8tB1EvNj4xKRVC8xsQPIXTbT4G+vWz21jzMeSfO2bMjYFgjK+266t7wgH2IJrjs/RsxrJKoyq0JrIDibwb6SySofOtJL57D/cp2iE5TFDbtSEis9kNq1JSnrOOUb5JQBOxkZ1Mh1DVgBZ3Gn31T88/R861Upj2KH2ypJJfkia3kqqvtPhuazd5FyHb4/GVjbHU75kKWeGjFI1hWwOpYnOgmJZvXHzqNpver2l+oK4CPJVI3yFTFR0FCgmosBHY947EVGmnhDet/1tAy3H3iMxeToQ14jHbwBF3Sfbxy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfWCCtcnDmI0QPxA3y0TDZxSkGoE3jOyH62RpIp5R8c=;
 b=gWZF2Xrh0Mk+SZ8Qs7W0sTwpEG6kYq/xouY10D9qrNe1GNx/0XfPrSrw2XPTeA9+u1GSYdxCUJsgcQSYSA+WVwAn7l8vXN2F83bcFUqOj9T8wQogAIHnietrhHFa9fI2nFWO7L/XT+rcWYuJYfeRkK+nxXtABqxdvZKmdv4qfcU=
Received: from MWHPR15CA0045.namprd15.prod.outlook.com (2603:10b6:300:ad::31)
 by CY4PR12MB1815.namprd12.prod.outlook.com (2603:10b6:903:122::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 10:27:11 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::e) by MWHPR15CA0045.outlook.office365.com
 (2603:10b6:300:ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 10:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 10:27:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 05:27:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 05:27:09 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 05:27:08 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 07/12] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file amdgpu_gmc.c
Date: Thu, 29 Apr 2021 18:26:39 +0800
Message-ID: <20210429102644.31172-7-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429102644.31172-1-PengJu.Zhou@amd.com>
References: <20210429102644.31172-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64b770e6-be4a-4d76-af71-08d90af95920
X-MS-TrafficTypeDiagnostic: CY4PR12MB1815:
X-Microsoft-Antispam-PRVS: <CY4PR12MB181509F7D85E36B9577FBB10F85F9@CY4PR12MB1815.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /opvTIit7llFttzhLkNsHQGQvO1tCmJDG0fahysCHpaJIKJPFB5V7gbnyTGGx+V1EYpd2uFWUI+lJ2sY7BKUN95C8emWqO+U2QRZ0Qd1477R61RYZCZiZpSZeTU1ISAi7IGx/4wcRzY4T49eWGdkUe7csp0Qd+ffzRAnJdO79lq6cr5wNL4yahj/2bNj6I1AaIVzSQ5j7um3OGlgZHXi1kcbsFMGY6Mo3l33Pc8CIYyyVRzY01HjSRniS2nMMgQEInmPLkZHzZRfptqYqYz9bP2obxUnfpFtcuuRbm9ndCKX3Vh07njodGvme6jzadn6HXtY2jXKy9nABBKpAYvbnbASWlOS4lqKTPxPHVD7xX3y4P+axVmATWk4jB0DvyG61lrOqwD1bYsZMEBIWEfRUVpIv5ecO3dG44RVoTPKmRr7S31lbQaSLUt7ppRHyoQJB+u9YQ7wvkGdOcv3SQEg1jIOku+AY+L+rNroZDfUPrTSCYJiB3KTW7i8byr/12QtrW2kUpAx67GsPgvWi8YLkyRjC8FjgJpKyzGeb9REEihBY8ZiTlWzfbTRCObrxsCU+pmfLBAfOoZqnQivblbAqEwB111GkhHYOkucnISxAjjnh9XVSr7tWoTB/hi4Wd1PNIey2a6XDlCC1ek2fKDiSexOdi4JMNPycKw0Nephcd5ffx3K0nYpJvXdnEP3X3Fj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(36840700001)(46966006)(86362001)(4326008)(426003)(8936002)(186003)(7696005)(26005)(336012)(70206006)(2906002)(36756003)(8676002)(316002)(1076003)(356005)(36860700001)(5660300002)(83380400001)(82310400003)(47076005)(70586007)(2616005)(6666004)(81166007)(6916009)(478600001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 10:27:10.6505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b770e6-be4a-4d76-af71-08d90af95920
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1815
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
index dfa67c2255f2..06ca584c5d1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -618,13 +618,18 @@ void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
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
index 498b28a35f5b..c25541112663 100644
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
