Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75E1C433E5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34CB21D91
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uBKHwg1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34CB21D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724DB6E899;
	Tue, 14 Jul 2020 02:47:19 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750051.outbound.protection.outlook.com [40.107.75.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02B5A6E899
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 02:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dR6MkE50vMTMSXQJaRjx6IhBnstvsLHWW2ppxAVO1dElcLeYuPer8jeudo+nvr2Sv3Su6iDA2KtUe/PfBdBEKOAxa3hDjz6+BdgJc/yWp2++qKRVyitc3aH9G2TyWBVo0DykIe8po6vABL5J/BYzyH+cX7iQihGzCT2sMiFRO82YO1W2SJMJs06xysuYcPoGswuvIT64LEMAIta8hRsIeaI2pPSuoCX3bZNiOhvSqpb7v0iMv9W9/w/CDq4+wdgrDBXFeBY66r/D0UO7f8R0s+ujOQFAzxhvUPyNOHsJXU7f2HtWGHoxreaGJdx6sck0eidbajqKotxJ0jjRKyNPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4POBalidgjT3Ci3eiz6nv89vFZZpEEpE5PXOJLQO8o=;
 b=JoPFrAipV/jNGEDNWbn3YACJGI7BX13/a8Gbj+755WIC/RJTNVaFi2SIlQpV4YP61gnyA2gZNCMeWkdQpMIBg4DIzHQxfOv8ThnYmV29rzXb4p71OLYP1a/rT30hEZ8jb0X+zWQ13th7BCuDbw6ud8kNtuLfteAJurFot3AvjY1VkFum6KAZvFM5iDOMV8TEABl/Vn9XsfYWqROpAUeGEisNAG7L0PLWcmp61cutLfAOFCCaq+yaAQ7gD8E5jUo7B1itEZ9KG+aWGAl/RyPn/86jJ6onQWIGcDTUq7bwiCItKU+sHbe88jdAJs8QoffBH9om1wQMYBxeT4Bhg7QbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4POBalidgjT3Ci3eiz6nv89vFZZpEEpE5PXOJLQO8o=;
 b=uBKHwg1zJZuc/SaaoHhl/MahjCDPkQeMKLOb6HTi2ayQ0zyI4M7KawKboUEIBGH9BEjy4O5EPCqstxSe7sUJlIhYuD6SF8+NBgWHHBWEPmS/C3uoKtVvVlwr+xjh3Kht/GRWgOqxXhSmQpBSz/12qx4XW5Ae2EhRdnrniffNIWs=
Received: from DM5PR07CA0074.namprd07.prod.outlook.com (2603:10b6:4:ad::39) by
 DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 02:47:15 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::ec) by DM5PR07CA0074.outlook.office365.com
 (2603:10b6:4:ad::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Tue, 14 Jul 2020 02:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 02:47:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jul
 2020 21:47:15 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jul
 2020 21:47:14 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 13 Jul 2020 21:47:13 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amd/sriov porting sriov cap to vcn3.0
Date: Tue, 14 Jul 2020 10:47:01 +0800
Message-ID: <1594694821-7747-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966005)(83380400001)(4326008)(36756003)(86362001)(426003)(8676002)(5660300002)(6916009)(2616005)(82740400003)(8936002)(7696005)(26005)(30864003)(186003)(336012)(81166007)(6666004)(478600001)(356005)(82310400002)(54906003)(316002)(47076004)(70586007)(2906002)(70206006);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe5d6ca2-11b3-4781-2a7c-08d827a037ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB4330:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43301E57447A90CEF90683CDBB610@DM6PR12MB4330.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Cl945K2aumJ1x/CEaLBcrUYTRxOuBHyUgSeQXHpWxOj+c9rtKK4kEWPipqCrL6F7IF/5hx3EIf8POv13Uy7koJNtfUx1y316fTRiPxUM3NxjQkl3KDdk7KBSfrxADLg7FopZodNHKCYX6u8Dbn/jiJOq/ejvTnHUOREJ6vk4rmg0qOota9grt9dhIKCXDXeW4neByMJmbLd5Wcxsq//EQWbLI2AZDGvVo3xUjhzqUMyT652AsfLmhOD3pqcptwuplE6TuBhUcjpcThqPNsj/U4u2glm9UVHCoCKI7EjoJJhcOPIUrgkMuLwiN3sM56BPgn3JQ0zBkcZp2MCI6iAE9EUvd2JsrAPuNjxYMhGz8zLil/cXOp/bSrPfkW05NWsXCyUFXnbck2TuC5Arz2Y+Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 02:47:15.6322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5d6ca2-11b3-4781-2a7c-08d827a037ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
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
Cc: Jack.Zhang1@amd.com, Leo.Liu@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.In early_init and for sriov, hardcode
  harvest_config=0, enc_num=1

2.sw_init/fini
  alloc & free mm_table for sriov
  doorbell setting for sriov

3.hw_init/fini
  Under sriov, add start_sriov to config mmsch
  Skip ring_test to avoid mmio in VF, but need to initialize wptr for vcn rings.

4.Implementation for vcn_v3_0_start_sriov

V2:Clean-up some uneccessary funciton declaration.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 350 +++++++++++++++++++++++---
 1 file changed, 318 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 90fe95f345e3..0a0ca10bf55b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -28,6 +28,7 @@
 #include "soc15.h"
 #include "soc15d.h"
 #include "vcn_v2_0.h"
+#include "mmsch_v3_0.h"
 
 #include "vcn/vcn_3_0_0_offset.h"
 #include "vcn/vcn_3_0_0_sh_mask.h"
@@ -48,6 +49,17 @@
 
 #define VCN_INSTANCES_SIENNA_CICHLID	 				2
 
+static int amdgpu_ih_clientid_vcns[] = {
+	SOC15_IH_CLIENTID_VCN,
+	SOC15_IH_CLIENTID_VCN1
+};
+
+static int amdgpu_ucode_id_vcns[] = {
+       AMDGPU_UCODE_ID_VCN,
+       AMDGPU_UCODE_ID_VCN1
+};
+
+static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
@@ -56,10 +68,8 @@ static int vcn_v3_0_set_powergating_state(void *handle,
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 			int inst_idx, struct dpg_pause_state *new_state);
 
-static int amdgpu_ih_clientid_vcns[] = {
-	SOC15_IH_CLIENTID_VCN,
-	SOC15_IH_CLIENTID_VCN1
-};
+static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
+static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
  * vcn_v3_0_early_init - set function pointers
@@ -71,25 +81,33 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v3_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	if (adev->asic_type == CHIP_SIENNA_CICHLID) {
-		u32 harvest;
-		int i;
 
+	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
-			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
-				adev->vcn.harvest_config |= 1 << i;
-		}
+		adev->vcn.harvest_config = 0;
+		adev->vcn.num_enc_rings = 1;
 
-		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
-			 AMDGPU_VCN_HARVEST_VCN1))
-			/* both instances are harvested, disable the block */
-			return -ENOENT;
-	} else
-		adev->vcn.num_vcn_inst = 1;
+	} else {
+		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
+			u32 harvest;
+			int i;
+
+			adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
+			for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+				harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
+				if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
+					adev->vcn.harvest_config |= 1 << i;
+			}
 
-	adev->vcn.num_enc_rings = 2;
+			if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
+						AMDGPU_VCN_HARVEST_VCN1))
+				/* both instances are harvested, disable the block */
+				return -ENOENT;
+		} else
+			adev->vcn.num_vcn_inst = 1;
+
+		adev->vcn.num_enc_rings = 2;
+	}
 
 	vcn_v3_0_set_dec_ring_funcs(adev);
 	vcn_v3_0_set_enc_ring_funcs(adev);
@@ -109,6 +127,7 @@ static int vcn_v3_0_sw_init(void *handle)
 {
 	struct amdgpu_ring *ring;
 	int i, j, r;
+	int vcn_doorbell_index = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	r = amdgpu_vcn_sw_init(adev);
@@ -136,6 +155,12 @@ static int vcn_v3_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	if (amdgpu_sriov_vf(adev)) {
+		vcn_doorbell_index = adev->doorbell_index.vcn.vcn_ring0_1;
+		/* get DWORD offset */
+		vcn_doorbell_index = vcn_doorbell_index << 1;
+	}
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
@@ -166,7 +191,13 @@ static int vcn_v3_0_sw_init(void *handle)
 
 		ring = &adev->vcn.inst[i].ring_dec;
 		ring->use_doorbell = true;
-		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
+		if (amdgpu_sriov_vf(adev)) {
+			ring->doorbell_index = vcn_doorbell_index;
+			/* NOTE: increment so next VCN engine use next DOORBELL DWORD */
+			vcn_doorbell_index++;
+		} else {
+			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
+		}
 		if (i != 0)
 			ring->no_scheduler = true;
 		sprintf(ring->name, "vcn_dec_%d", i);
@@ -184,7 +215,13 @@ static int vcn_v3_0_sw_init(void *handle)
 
 			ring = &adev->vcn.inst[i].ring_enc[j];
 			ring->use_doorbell = true;
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
+			if (amdgpu_sriov_vf(adev)) {
+				ring->doorbell_index = vcn_doorbell_index;
+				/* NOTE: increment so next VCN engine use next DOORBELL DWORD */
+				vcn_doorbell_index++;
+			} else {
+				ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
+			}
 			if (i != 1)
 				ring->no_scheduler = true;
 			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
@@ -195,6 +232,11 @@ static int vcn_v3_0_sw_init(void *handle)
 		}
 	}
 
+	if (amdgpu_sriov_vf(adev)) {
+		r = amdgpu_virt_alloc_mm_table(adev);
+		if (r)
+			return r;
+	}
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
 
@@ -213,6 +255,9 @@ static int vcn_v3_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_free_mm_table(adev);
+
 	r = amdgpu_vcn_suspend(adev);
 	if (r)
 		return r;
@@ -235,24 +280,50 @@ static int vcn_v3_0_hw_init(void *handle)
 	struct amdgpu_ring *ring;
 	int i, j, r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (amdgpu_sriov_vf(adev)) {
+		r = vcn_v3_0_start_sriov(adev);
+		if (r)
+			goto done;
 
-		ring = &adev->vcn.inst[i].ring_dec;
+		/* initialize VCN dec and enc ring buffers */
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
+
+			ring = &adev->vcn.inst[i].ring_dec;
+			ring->wptr = 0;
+			ring->wptr_old = 0;
+			vcn_v3_0_dec_ring_set_wptr(ring);
+			ring->sched.ready = true;
+
+			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+				ring = &adev->vcn.inst[i].ring_enc[j];
+				ring->wptr = 0;
+				ring->wptr_old = 0;
+				vcn_v3_0_enc_ring_set_wptr(ring);
+				ring->sched.ready = true;
+			}
+		}
+	} else {
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
 
-		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-						     ring->doorbell_index, i);
+			ring = &adev->vcn.inst[i].ring_dec;
 
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			goto done;
+			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+						     ring->doorbell_index, i);
 
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-			ring = &adev->vcn.inst[i].ring_enc[j];
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
 				goto done;
+
+			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+				ring = &adev->vcn.inst[i].ring_enc[j];
+				r = amdgpu_ring_test_helper(ring);
+				if (r)
+					goto done;
+			}
 		}
 	}
 
@@ -1137,6 +1208,221 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
+{
+	int i, j;
+	struct amdgpu_ring *ring;
+	uint64_t cache_addr;
+	uint64_t rb_addr;
+	uint64_t ctx_addr;
+	uint32_t param, resp, expected;
+	uint32_t offset, cache_size;
+	uint32_t tmp, timeout;
+	uint32_t id;
+
+	struct amdgpu_mm_table *table = &adev->virt.mm_table;
+	uint32_t *table_loc;
+	uint32_t table_size;
+	uint32_t size, size_dw;
+
+	struct mmsch_v3_0_cmd_direct_write
+		direct_wt = { {0} };
+	struct mmsch_v3_0_cmd_direct_read_modify_write
+		direct_rd_mod_wt = { {0} };
+	struct mmsch_v3_0_cmd_direct_polling
+		direct_poll = { {0} };
+	struct mmsch_v3_0_cmd_end end = { {0} };
+	struct mmsch_v3_0_init_header header;
+
+	direct_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_WRITE;
+	direct_rd_mod_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
+	direct_poll.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_POLLING;
+	end.cmd_header.command_type =
+		MMSCH_COMMAND__END;
+
+	header.version = MMSCH_VERSION;
+	header.total_size = sizeof(struct mmsch_v3_0_init_header) >> 2;
+	for (i = 0; i < AMDGPU_MAX_VCN_INSTANCES; i++) {
+		header.inst[i].init_status = 0;
+		header.inst[i].table_offset = 0;
+		header.inst[i].table_size = 0;
+	}
+
+	table_loc = (uint32_t *)table->cpu_addr;
+	table_loc += header.total_size;
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		table_size = 0;
+
+		MMSCH_V3_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VCN, i,
+			mmUVD_STATUS),
+			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
+
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+			id = amdgpu_ucode_id_vcns[i];
+			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				adev->firmware.ucode[id].tmr_mc_addr_lo);
+			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				adev->firmware.ucode[id].tmr_mc_addr_hi);
+			offset = 0;
+			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				mmUVD_VCPU_CACHE_OFFSET0),
+				0);
+		} else {
+			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				lower_32_bits(adev->vcn.inst[i].gpu_addr));
+			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				upper_32_bits(adev->vcn.inst[i].gpu_addr));
+			offset = cache_size;
+			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				mmUVD_VCPU_CACHE_OFFSET0),
+				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
+		}
+
+		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			mmUVD_VCPU_CACHE_SIZE0),
+			cache_size);
+
+		cache_addr = adev->vcn.inst[i].gpu_addr + offset;
+		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+			lower_32_bits(cache_addr));
+		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+			upper_32_bits(cache_addr));
+		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			mmUVD_VCPU_CACHE_OFFSET1),
+			0);
+		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			mmUVD_VCPU_CACHE_SIZE1),
+			AMDGPU_VCN_STACK_SIZE);
+
+		cache_addr = adev->vcn.inst[i].gpu_addr + offset +
+			AMDGPU_VCN_STACK_SIZE;
+		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+			lower_32_bits(cache_addr));
+		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+			upper_32_bits(cache_addr));
+		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			mmUVD_VCPU_CACHE_OFFSET2),
+			0);
+		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			mmUVD_VCPU_CACHE_SIZE2),
+			AMDGPU_VCN_CONTEXT_SIZE);
+
+		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+			ring = &adev->vcn.inst[i].ring_enc[j];
+			ring->wptr = 0;
+			rb_addr = ring->gpu_addr;
+			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				mmUVD_RB_BASE_LO),
+				lower_32_bits(rb_addr));
+			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				mmUVD_RB_BASE_HI),
+				upper_32_bits(rb_addr));
+			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				mmUVD_RB_SIZE),
+				ring->ring_size / 4);
+		}
+
+		ring = &adev->vcn.inst[i].ring_dec;
+		ring->wptr = 0;
+		rb_addr = ring->gpu_addr;
+		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			mmUVD_LMI_RBC_RB_64BIT_BAR_LOW),
+			lower_32_bits(rb_addr));
+		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH),
+			upper_32_bits(rb_addr));
+		/* force RBC into idle state */
+		tmp = order_base_2(ring->ring_size);
+		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, tmp);
+		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			mmUVD_RBC_RB_CNTL),
+			tmp);
+
+		/* add end packet */
+		MMSCH_V3_0_INSERT_END();
+
+		/* refine header */
+		header.inst[i].init_status = 1;
+		header.inst[i].table_offset = header.total_size;
+		header.inst[i].table_size = table_size;
+		header.total_size += table_size;
+	}
+
+	/* Update init table header in memory */
+        size = sizeof(struct mmsch_v3_0_init_header);
+	table_loc = (uint32_t *)table->cpu_addr;
+	memcpy((void *)table_loc, &header, size);
+
+	/* message MMSCH (in VCN[0]) to initialize this client
+	 * 1, write to mmsch_vf_ctx_addr_lo/hi register with GPU mc addr
+	 * of memory descriptor location
+	 */
+	ctx_addr = table->gpu_addr;
+	WREG32_SOC15(VCN, 0, mmMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
+	WREG32_SOC15(VCN, 0, mmMMSCH_VF_CTX_ADDR_HI, upper_32_bits(ctx_addr));
+
+	/* 2, update vmid of descriptor */
+	tmp = RREG32_SOC15(VCN, 0, mmMMSCH_VF_VMID);
+	tmp &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
+	/* use domain0 for MM scheduler */
+	tmp |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
+	WREG32_SOC15(VCN, 0, mmMMSCH_VF_VMID, tmp);
+
+	/* 3, notify mmsch about the size of this descriptor */
+	size = header.total_size;
+	WREG32_SOC15(VCN, 0, mmMMSCH_VF_CTX_SIZE, size);
+
+	/* 4, set resp to zero */
+	WREG32_SOC15(VCN, 0, mmMMSCH_VF_MAILBOX_RESP, 0);
+
+	/* 5, kick off the initialization and wait until
+	 * MMSCH_VF_MAILBOX_RESP becomes non-zero
+	 */
+	param = 0x10000001;
+	WREG32_SOC15(VCN, 0, mmMMSCH_VF_MAILBOX_HOST, param);
+	tmp = 0;
+	timeout = 1000;
+	resp = 0;
+	expected = param + 1;
+	while (resp != expected) {
+		resp = RREG32_SOC15(VCN, 0, mmMMSCH_VF_MAILBOX_RESP);
+		if (resp == expected)
+			break;
+
+		udelay(10);
+		tmp = tmp + 10;
+		if (tmp >= timeout) {
+			DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
+				" waiting for mmMMSCH_VF_MAILBOX_RESP "\
+				"(expected=0x%08x, readback=0x%08x)\n",
+				tmp, expected, resp);
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
 static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 {
 	uint32_t tmp;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
