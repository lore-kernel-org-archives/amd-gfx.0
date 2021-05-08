Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA8DC43462
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B05761358
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B05761358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EE96E882;
	Sat,  8 May 2021 11:52:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4230D6E880
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 11:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acpJXG4UuEWAXGryL07hc3Zcg8do6Z+IMwJjOjcqlf+DYWESDHwT/LHdgA1hSUv91xMm3Qd0pHObXsFTDdOFoO7hf59Uaibxz8lMJDmw9RR1JxtxwZvtc0c8Cgta35vmb7MSIFWSktCv8+juN/d8642q4pfQb9Lf+D7n+P178f0tG3r+rqpgFEwLBii24g2IeHAU6Uw0KsK3+9Rix95y2dAsrzsBekn/pURFUYsyKjv0LsVHVAy1p/ohKVAj2mPjts1RMM5ske+lI9pwwRqWMqlVf/q1ir2mVHGheU99dQCD41NRFGNuCcoqfCK5/ARTpUaD/Nya9HJsPSt1MV8cTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpHQrcJBNw0klgG7/V4sWiVedVE2gp0Xlxtfh6Jpvmw=;
 b=jv5HeIU7auWr2y1Q53tWNS5nsa4k91O5KS+U46DXakI3HmKaodUkcFQpHPZoJb9RGIUlJRHwWNgWrmSKSQ6rfdQq78X+m3rJ/0fbIq6NbVNVykl/Hbc6gHlx2Dpupbp96vOnDxCNmDoBXU1oMo0/DVEUdT0TjZjgJz2IIlDodThweAgRq+Nu6fH62edvCSEToM57bM4VnokZoeeh2BKFjD8OhoukrvhCsgkAgesKONFeB4vUgVCgm4yOOf2o6034XFZn+nKp9wgLasRgbULfVmYZh+E/7Npl95KPI3dQn61vjHZCYRuNiGua26txzMe1ISSrNd0+8r4ySXMUBRI7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpHQrcJBNw0klgG7/V4sWiVedVE2gp0Xlxtfh6Jpvmw=;
 b=f8jI34XmiqN4VbpsaCPSGzg5qkfbPnpiSH6ZZy0iw2BiaACPsxrx4c0CmBq1N9qn1Egj6dJKA0jXvt+PCysyiQMyVEXEaQpPQMHzbB1DlhQtt+FJvrJPyS+y5ExAJwFUizULjL2qfyqka841oEqJP3x3JHJDT5VsmfAVV8q1TTo=
Received: from BN7PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:20::17)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Sat, 8 May
 2021 11:52:01 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::3c) by BN7PR02CA0004.outlook.office365.com
 (2603:10b6:408:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Sat, 8 May 2021 11:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 11:52:01 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:52:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 04:52:00 -0700
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Sat, 8 May 2021 06:51:59 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 07/13] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file amdgpu_gmc.c
Date: Sat, 8 May 2021 19:51:39 +0800
Message-ID: <20210508115145.758-7-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210508115145.758-1-PengJu.Zhou@amd.com>
References: <20210508115145.758-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97675c01-bc4e-458a-2867-08d91217b0ee
X-MS-TrafficTypeDiagnostic: SA0PR12MB4542:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4542EA0816550442514E08C9F8569@SA0PR12MB4542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLlg5pdr0IwOGrIpRLity1D/UkblShV2SYG6HXBkOWHpKMFWMAbYtj5FiFWOcU6sFaMfxDEU8NXBqpZAx6SogmfERGkPX2KHw6xoTvuKv4yllLDvt2l9f/MG1UrLJrj3QOCS6jFrSLT3m8NpBCNvjfP5NuvStXeTO+cWAuoLEkEEr6oTGTv360tb7kWS2iqoXDwjDLk42gHqUpcRGeSHWUHCdrTgpe610m4GwmwYDFR1JO0zC+vvResWI+zjyOlMLYLOvmnLZm0N6sZ87oBraxgL3E51yM/Z0Jl64anu0A14hn4VJVIQE1mQXzOT35liYnzAWhcevAyUPYbVoV5UVFL/A0z9IfpR/jQj7VBp7vhmb268VeVJjvWcgO5YLOdcgNBivifcFZI1MkjUwmzC1TOkRrKF0WFyWO+Ps3VPyBYVZRlNxZ+mazsYo6aOpFiyEysJPuN+/GCENjb7fITux/sa213ugV4gvPswivEf8NQIyr+msqg5QzlgpUVCHb8su/qEznhHBSFXHAQLRypCQI7wQ8bIfYBX+cVH0ryU7VcHZSWnmGvJw3VQnMz+/tV6HzjLqoEjxhOsPaAf6KOmcAk+rDlQCOLhAlUo1GzxZ03fKDQy0hiFlJSW+5n3ve74hNT0i/BTVWAETBt3ZxixQaWjZfT5pfW2wwWDUIU5xe4sBufC1AAZ2uHf5ACdyQOs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(5660300002)(2616005)(82310400003)(83380400001)(8676002)(8936002)(186003)(7696005)(336012)(6666004)(70206006)(426003)(1076003)(26005)(4326008)(36756003)(47076005)(6916009)(356005)(82740400003)(81166007)(36860700001)(86362001)(70586007)(2906002)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 11:52:01.1151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97675c01-bc4e-458a-2867-08d91217b0ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
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
