Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133BCC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5FA613CD
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5FA613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544006EE27;
	Fri, 14 May 2021 07:27:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 077796EE20
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJBdF4ax7+frH0+Q7OETbwTC+XPvX134ublFr4jxuh5cQChiEcxgdufwVpAqBNLYqwRlZ+DNHEp7C8nHS3LnpFQtDBV1uprQhBblust1x7eGKwe8KrimUxMxSiizbzvIm0o+A3+umRzsCx+2wjNMcCZHDqWsKeEGN88i6ThsF34A2/Lvd24Vz5iKxi67ICzdcO7UApxPJaVn8VxoV0C1+2b8HV0gegzF+QCcf750PRTEqrsFFN+Om6jl1OSLjRcSVI8WR25Sr2mT90qu4Z/e7ZmWHJ0CyaqEaVh3j5MdwkTlrq6f8ptH4sLOEt5/uFWeGxvJWdO2x0871inIs1Z7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpHQrcJBNw0klgG7/V4sWiVedVE2gp0Xlxtfh6Jpvmw=;
 b=DuAeq9pho7NDdRArdBs11KoZ4b05KPm8wodJ4ZCex1v/mxatxrnB4CdGVuF6RDVXb0DUM6Ymmj7YWLm4niQOAJrr1CEHMyj4pY6amvmAP2bRLLWOre1Tywcnklit5y2kX+gEJ25bajZ9WGgk4mydclY0CUMijBWENY046C1pxV5s4MIQgl9of+cfhfqe8AOBCs/AbvFolxox3D3MZcBULPq2M8anu9o8o5M3P3LIQOo7py/KVlL5yMAC3vCcCUe8f1SgtDicDwdSBaSy1Tat/F07c/rtD9lDPGZfmEkotHxvywk5I289xAXZAQPUYf2bm89YFJirjksTxb0aMfAw3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpHQrcJBNw0klgG7/V4sWiVedVE2gp0Xlxtfh6Jpvmw=;
 b=iz/ts99UH98UaS/O/+l5e98CJlds8lmBNcTVndPQqGUnIb+bJvDaC0WRuM5Lx7b24iwjARtRphZ8mvv1CILNF5CBnR//MqFiMCRghgZpLW0Hxen5zeZfcNfBOULip/JUmcRBriCuPgcA6Pxs35kKSKqjkIlyz2eqM0lQkj2nNyM=
Received: from MW4PR04CA0100.namprd04.prod.outlook.com (2603:10b6:303:83::15)
 by BN6PR12MB1298.namprd12.prod.outlook.com (2603:10b6:404:17::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.28; Fri, 14 May
 2021 07:27:26 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::3f) by MW4PR04CA0100.outlook.office365.com
 (2603:10b6:303:83::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 07:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:27:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:24 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 02:27:24 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 10/16] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file amdgpu_gmc.c
Date: Fri, 14 May 2021 15:27:00 +0800
Message-ID: <20210514072706.4264-10-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514072706.4264-1-PengJu.Zhou@amd.com>
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d48c171c-d5c4-4f22-53e9-08d916a9b917
X-MS-TrafficTypeDiagnostic: BN6PR12MB1298:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1298EAE40AE02D27D2CE10D1F8509@BN6PR12MB1298.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klnq+qh+tXmK6OQdE3lyS5UDAN/p3ApDq7k839uN/crpewP8nUwnDuI8l0ad9GOqYPLCBkmmkylqQV8F4XY8eAnGpiGugzGiB/BPr7zhFuPKN/pXph8DQ5W0yl3vUjzNslsbiihor3qYybVlYiW+KF5Oy4/uNy+iMiHIMrH2TemAf1mBKTZDPdPvh9+Hpq4grub/3lJI5LMpxKbTzKATfMQl3R3pMeQzqwdKcffSnadFze7zNcAHbVBJyKlIZOhc/tOo7jOlUF94i+x/t3LgFSzZOp+THh3Fh+4kCpstj6Gf29szYyo20goTfE27rPwyaYYfZpvtOxf8x68PZcdJPPDvbGppLNjF5TCHC3icqraTFofGwhvQ/TibF/9m/UxSqvutqdUNnTBKyefz7dWrouSfFidoB4mhmUrfRi7FhRteLmXUlaT80xhChloegC87vWneXM/p6GJWq1LVvmVCOdBzlvGaVr2mcU6AVrdy8NnzM06D96QrituzCM+GKs9leq4ffLD++eJomkUC+l08yu+bhoNyQPtFDUaQpgoZIdmap1Z/hkh/6x3D//5OKyDvOf5UjY+DAScgzHytObSIp6vHQeANrVRrHXzJSgTNLsDoYI9xyFh33aibB8mkCA6gSQSgeGYaHa2Gfec6GRWlX60fX/BgSuwGgxQMXO705rQXKWPpIngUS1y1h4/vIhif
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(36840700001)(46966006)(336012)(86362001)(186003)(1076003)(4326008)(6916009)(316002)(6666004)(36860700001)(70206006)(426003)(2906002)(8936002)(70586007)(47076005)(8676002)(26005)(83380400001)(2616005)(478600001)(81166007)(36756003)(7696005)(82310400003)(82740400003)(5660300002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:27:25.8734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d48c171c-d5c4-4f22-53e9-08d916a9b917
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1298
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
