Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BDAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 19:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8169B61A7D
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 19:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8169B61A7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530096F3B5;
	Fri,  1 Oct 2021 19:48:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0C36F3A9
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 19:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gr1m5mVYSdFJULMp9608xZVOoa3aUUjVqqmrK5JQccrKULKv2JoDR0crnmHpWtiY5TuEudBgVecO6leSNW/6xAIyPskLcGQvggeQlgst4KhF0xTu6lki9ludDP+gh4JbRm07Onn6SF2L498T8bCX/MTts6YDQcoiBuhQEY4iikDx38wLGpwAlIzOY6EJ4cIUt9PI7dlsIVWCsUkJ3H4a/fN9e9EMLwiCAsHtYT2CW7AwH/RLFNnR1BJ4WKy/HchRfxWzbFinOI0BgOnHD5G5hDx3ijNH4J5vatq9eog4EmkM16EWlECJ0zd9mAtYdzQKqttCB4JtYXjsmv2Qp1SbrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMaqWYLSoQqkl53vd1Cy4dzDCFLEsAODsAvmuLPGez4=;
 b=ZBUe/gNZx7RFsyQO5Azzmtq3PJNk4SUqK+ciphcBGhky1aCJdG+NMgWwBjeb0mhSoFYa+vzZCLCx15fk75z5ym58ThN9vkAZq2oxNhIkKKOEw5xDWYklNWV2vDhO1a6xhFi+rdMhuFKwtN876t51SHsFhVkSen4gkesNKW2WMtpN51StBx6u7Pqxft2SFS0nJW0qs+ShjFwyPxd6dr34lPASAbF4ywAWj2pp0wjAWbEcy7dvbGJv0gz73bT6+C9YMUIC4A0rDn/07JRugS55zBpA/n53k/B74sGC8LFEl3h4IglhRvdgW36dqdrG2fhudQ2GAXTq6dRnq7i7ag8NUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMaqWYLSoQqkl53vd1Cy4dzDCFLEsAODsAvmuLPGez4=;
 b=qYUUB97hBgk7/rJUbB+GaH5AUzl1E8qE3tsV2ZDrlfet4L548qvb6M+9frKX8hcXuL1IOgMybjqV5SuP0a6p5ZFtoZBa+joV/mD8VgDmeNay/NNsxaRlGQQBi+pX8xtXN5YmCsqQyZoFT7tB7mB/nIdDipcIK0VNRaMWAtpDQrk=
Received: from DS7PR03CA0211.namprd03.prod.outlook.com (2603:10b6:5:3ba::6) by
 DM6PR12MB3098.namprd12.prod.outlook.com (2603:10b6:5:11c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Fri, 1 Oct 2021 19:48:39 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::cf) by DS7PR03CA0211.outlook.office365.com
 (2603:10b6:5:3ba::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Fri, 1 Oct 2021 19:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 19:48:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 14:48:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc9: convert to IP version checking
Date: Fri, 1 Oct 2021 15:48:20 -0400
Message-ID: <20211001194822.1818798-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 819ef70f-c7fc-407f-15db-08d985147737
X-MS-TrafficTypeDiagnostic: DM6PR12MB3098:
X-Microsoft-Antispam-PRVS: <DM6PR12MB309817839DD7363B9C3FEC89F7AB9@DM6PR12MB3098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91j4p4UlwAF+Zek+ZxljUmjtQRIKlL/oaeQ0IpwsWsYGNdwtZopyBgSL0M5TzAb+gdd/bHi2OzSEwaFudyg5UGz/ZxqknHGQntFe5TKJId0sKTZWm0l/AtCEW0FCLKrYb6QfO2R5Ak8N+5K2iVGDz7E8m3FrBCn6pcOU1LXJoc5Gj1jfnPIj3YKcQ/kXkFFfOmqbz29nI8Ykd210fVeiWr0kOy743+tuXDYHdpHIXXxke5C5nfkzBOzuiL9NbnP/zRl5zUh+Ei4LAUYfF5cg/5B4Rzja0UKZiUHyY/7Udcqce0ynwIngD2lPHN+d+yzQLma4eLCBTlVQGQUSTXmRbegUyvYRWr6gnk3W8KqTjscdHnNTbvY3FcZijfAxGmNEQlPN33e0D0BEGiQJXZbmUhismWUyOmAevAjB+ifq4K4rmKAPw4L/s2yAjwJ/4Xtfb4LrNab+QJy6ZSx9FIaj8WUb88lygCZbAS65jJKkXFOxO9cbiK1GnszbcsPuWxrTpmfjKKQiIAROHU3iumQJHIipUjok9/bHvPpbfnPPC7hHb7qPi7EvUEYk1gurlOp0WW8OqL6cVj6oPSsF1xrnSBlP6by3b7lOxmQDeCzB8nSWiwYLbUkP3lunNvNSethl9wxipjuZxvqerOvNj5a3bi8Qpn52u2D4g6/Wg74Ap+09jf1n0MC14/dvn6Ibi1ftfkvNEyGUuvju2HC0Ufe0fVDuPm0ETw7VAzHzhFe4Uiw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(70586007)(6916009)(70206006)(86362001)(426003)(8936002)(1076003)(36860700001)(2616005)(26005)(8676002)(316002)(47076005)(356005)(7696005)(30864003)(336012)(508600001)(6666004)(83380400001)(82310400003)(36756003)(2906002)(81166007)(5660300002)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 19:48:39.4766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 819ef70f-c7fc-407f-15db-08d985147737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3098
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 136 ++++++++++++++------------
 1 file changed, 71 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 5551359d5dfd..cb82404df534 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -579,7 +579,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	 * the new fast GRBM interface.
 	 */
 	if ((entry->vmid_src == AMDGPU_GFXHUB_0) &&
-	    (adev->asic_type < CHIP_ALDEBARAN))
+	    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
 		RREG32(hub->vm_l2_pro_fault_status);
 
 	status = RREG32(hub->vm_l2_pro_fault_status);
@@ -597,26 +597,28 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			gfxhub_client_ids[cid],
 			cid);
 	} else {
-		switch (adev->asic_type) {
-		case CHIP_VEGA10:
+		switch (adev->ip_versions[MMHUB_HWIP][0]) {
+		case IP_VERSION(9, 0, 0):
 			mmhub_cid = mmhub_client_ids_vega10[cid][rw];
 			break;
-		case CHIP_VEGA12:
+		case IP_VERSION(9, 3, 0):
 			mmhub_cid = mmhub_client_ids_vega12[cid][rw];
 			break;
-		case CHIP_VEGA20:
+		case IP_VERSION(9, 4, 0):
 			mmhub_cid = mmhub_client_ids_vega20[cid][rw];
 			break;
-		case CHIP_ARCTURUS:
+		case IP_VERSION(9, 4, 1):
 			mmhub_cid = mmhub_client_ids_arcturus[cid][rw];
 			break;
-		case CHIP_RAVEN:
+		case IP_VERSION(9, 1, 0):
+		case IP_VERSION(9, 2, 0):
 			mmhub_cid = mmhub_client_ids_raven[cid][rw];
 			break;
-		case CHIP_RENOIR:
+		case IP_VERSION(1, 5, 0):
+		case IP_VERSION(2, 4, 0):
 			mmhub_cid = mmhub_client_ids_renoir[cid][rw];
 			break;
-		case CHIP_ALDEBARAN:
+		case IP_VERSION(9, 4, 2):
 			mmhub_cid = mmhub_client_ids_aldebaran[cid][rw];
 			break;
 		default:
@@ -694,7 +696,7 @@ static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid,
 static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 				       uint32_t vmhub)
 {
-	if (adev->asic_type == CHIP_ALDEBARAN)
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
 		return false;
 
 	return ((vmhub == AMDGPU_MMHUB_0 ||
@@ -745,7 +747,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	hub = &adev->vmhub[vmhub];
 	if (adev->gmc.xgmi.num_physical_nodes &&
-	    adev->asic_type == CHIP_VEGA20) {
+	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0)) {
 		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
 		 * heavy-weight TLB flush (type 2), which flushes
 		 * both. Due to a race condition with concurrent
@@ -808,7 +810,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * GRBM interface.
 		 */
 		if ((vmhub == AMDGPU_GFXHUB_0) &&
-		    (adev->asic_type < CHIP_ALDEBARAN))
+		    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
 			RREG32_NO_KIQ(hub->vm_inv_eng0_req +
 				      hub->eng_distance * eng);
 
@@ -874,7 +876,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		 * still need a second TLB flush after this.
 		 */
 		bool vega20_xgmi_wa = (adev->gmc.xgmi.num_physical_nodes &&
-				       adev->asic_type == CHIP_VEGA20);
+				       adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0));
 		/* 2 dwords flush + 8 dwords fence */
 		unsigned int ndw = kiq->pmf->invalidate_tlbs_size + 8;
 
@@ -1088,13 +1090,13 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if ((adev->asic_type == CHIP_ARCTURUS ||
-	    adev->asic_type == CHIP_ALDEBARAN) &&
+	if ((adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1) ||
+	     adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) &&
 	    !(*flags & AMDGPU_PTE_SYSTEM) &&
 	    mapping->bo_va->is_xgmi)
 		*flags |= AMDGPU_PTE_SNOOPED;
 
-	if (adev->asic_type == CHIP_ALDEBARAN)
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
 		*flags |= mapping->flags & AMDGPU_PTE_SNOOPED;
 }
 
@@ -1108,9 +1110,10 @@ static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
 	} else {
 		u32 viewport;
 
-		switch (adev->asic_type) {
-		case CHIP_RAVEN:
-		case CHIP_RENOIR:
+		switch (adev->ip_versions[DCE_HWIP][0]) {
+		case IP_VERSION(1, 0, 0):
+		case IP_VERSION(1, 0, 1):
+		case IP_VERSION(2, 1, 0):
 			viewport = RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
 			size = (REG_GET_FIELD(viewport,
 					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
@@ -1118,9 +1121,6 @@ static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
 					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_WIDTH) *
 				4);
 			break;
-		case CHIP_VEGA10:
-		case CHIP_VEGA12:
-		case CHIP_VEGA20:
 		default:
 			viewport = RREG32_SOC15(DCE, 0, mmSCL0_VIEWPORT_SIZE);
 			size = (REG_GET_FIELD(viewport, SCL0_VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
@@ -1151,11 +1151,11 @@ static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev)
 
 static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
+	switch (adev->ip_versions[UMC_HWIP][0]) {
+	case IP_VERSION(6, 0, 0):
 		adev->umc.funcs = &umc_v6_0_funcs;
 		break;
-	case CHIP_VEGA20:
+	case IP_VERSION(6, 1, 1):
 		adev->umc.max_ras_err_cnt_per_query = UMC_V6_1_TOTAL_CHANNEL_NUM;
 		adev->umc.channel_inst_num = UMC_V6_1_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V6_1_UMC_INSTANCE_NUM;
@@ -1163,7 +1163,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_idx_tbl = &umc_v6_1_channel_idx_tbl[0][0];
 		adev->umc.ras_funcs = &umc_v6_1_ras_funcs;
 		break;
-	case CHIP_ARCTURUS:
+	case IP_VERSION(6, 1, 2):
 		adev->umc.max_ras_err_cnt_per_query = UMC_V6_1_TOTAL_CHANNEL_NUM;
 		adev->umc.channel_inst_num = UMC_V6_1_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V6_1_UMC_INSTANCE_NUM;
@@ -1171,7 +1171,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_idx_tbl = &umc_v6_1_channel_idx_tbl[0][0];
 		adev->umc.ras_funcs = &umc_v6_1_ras_funcs;
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(6, 7, 0):
 		adev->umc.max_ras_err_cnt_per_query = UMC_V6_7_TOTAL_CHANNEL_NUM;
 		adev->umc.channel_inst_num = UMC_V6_7_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V6_7_UMC_INSTANCE_NUM;
@@ -1190,11 +1190,11 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 
 static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
+	switch (adev->ip_versions[MMHUB_HWIP][0]) {
+	case IP_VERSION(9, 4, 1):
 		adev->mmhub.funcs = &mmhub_v9_4_funcs;
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(9, 4, 2):
 		adev->mmhub.funcs = &mmhub_v1_7_funcs;
 		break;
 	default:
@@ -1205,14 +1205,14 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
 
 static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_VEGA20:
+	switch (adev->ip_versions[MMHUB_HWIP][0]) {
+	case IP_VERSION(9, 4, 0):
 		adev->mmhub.ras_funcs = &mmhub_v1_0_ras_funcs;
 		break;
-	case CHIP_ARCTURUS:
+	case IP_VERSION(9, 4, 1):
 		adev->mmhub.ras_funcs = &mmhub_v9_4_ras_funcs;
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(9, 4, 2):
 		adev->mmhub.ras_funcs = &mmhub_v1_7_ras_funcs;
 		break;
 	default:
@@ -1233,8 +1233,9 @@ static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev)
 
 static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	/* is UMC the right IP to check for MCA?  Maybe DF? */
+	switch (adev->ip_versions[UMC_HWIP][0]) {
+	case IP_VERSION(6, 7, 0):
 		if (!adev->gmc.xgmi.connected_to_cpu)
 			adev->mca.funcs = &mca_v3_0_funcs;
 		break;
@@ -1247,11 +1248,12 @@ static int gmc_v9_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/* ARCT and VEGA20 don't have XGMI defined in their IP discovery tables */
 	if (adev->asic_type == CHIP_VEGA20 ||
 	    adev->asic_type == CHIP_ARCTURUS)
 		adev->gmc.xgmi.supported = true;
 
-	if (adev->asic_type == CHIP_ALDEBARAN) {
+	if (adev->ip_versions[XGMI_HWIP][0] == IP_VERSION(6, 1, 0)) {
 		adev->gmc.xgmi.supported = true;
 		adev->gmc.xgmi.connected_to_cpu =
 			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
@@ -1289,7 +1291,8 @@ static int gmc_v9_0_late_init(void *handle)
 	 * Workaround performance drop issue with VBIOS enables partial
 	 * writes, while disables HBM ECC for vega10.
 	 */
-	if (!amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
+	if (!amdgpu_sriov_vf(adev) &&
+	    (adev->ip_versions[UMC_HWIP][0] == IP_VERSION(6, 0, 0))) {
 		if (!(adev->ras_enabled & (1 << AMDGPU_RAS_BLOCK__UMC))) {
 			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
 				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
@@ -1393,17 +1396,18 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 
 	/* set the gart size */
 	if (amdgpu_gart_size == -1) {
-		switch (adev->asic_type) {
-		case CHIP_VEGA10:  /* all engines support GPUVM */
-		case CHIP_VEGA12:  /* all engines support GPUVM */
-		case CHIP_VEGA20:
-		case CHIP_ARCTURUS:
-		case CHIP_ALDEBARAN:
+		switch (adev->ip_versions[GC_HWIP][0]) {
+		case IP_VERSION(9, 0, 1):  /* all engines support GPUVM */
+		case IP_VERSION(9, 2, 1):  /* all engines support GPUVM */
+		case IP_VERSION(9, 4, 0):
+		case IP_VERSION(9, 4, 1):
+		case IP_VERSION(9, 4, 2):
 		default:
 			adev->gmc.gart_size = 512ULL << 20;
 			break;
-		case CHIP_RAVEN:   /* DCE SG support */
-		case CHIP_RENOIR:
+		case IP_VERSION(9, 1, 0):   /* DCE SG support */
+		case IP_VERSION(9, 2, 2):   /* DCE SG support */
+		case IP_VERSION(9, 3, 0):
 			adev->gmc.gart_size = 1024ULL << 20;
 			break;
 		}
@@ -1464,7 +1468,8 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
  */
 static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
 {
-	if (adev->asic_type == CHIP_RAVEN)
+	if ((adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 0)) ||
+	    (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 1)))
 		adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
 }
 
@@ -1507,8 +1512,9 @@ static int gmc_v9_0_sw_init(void *handle)
 
 	adev->gmc.vram_type = vram_type;
 	adev->gmc.vram_vendor = vram_vendor;
-	switch (adev->asic_type) {
-	case CHIP_RAVEN:
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 2):
 		adev->num_vmhubs = 2;
 
 		if (adev->rev_id == 0x0 || adev->rev_id == 0x1) {
@@ -1520,11 +1526,11 @@ static int gmc_v9_0_sw_init(void *handle)
 				adev->vm_manager.num_level > 1;
 		}
 		break;
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RENOIR:
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(9, 4, 2):
 		adev->num_vmhubs = 2;
 
 
@@ -1539,7 +1545,7 @@ static int gmc_v9_0_sw_init(void *handle)
 		else
 			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
 		break;
-	case CHIP_ARCTURUS:
+	case IP_VERSION(9, 4, 1):
 		adev->num_vmhubs = 3;
 
 		/* Keep the vm size same with Vega20 */
@@ -1555,7 +1561,7 @@ static int gmc_v9_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->asic_type == CHIP_ARCTURUS) {
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1)) {
 		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VMC1, VMC_1_0__SRCID__VM_FAULT,
 					&adev->gmc.vm_fault);
 		if (r)
@@ -1622,8 +1628,8 @@ static int gmc_v9_0_sw_init(void *handle)
 	 * for video processing.
 	 */
 	adev->vm_manager.first_kfd_vmid =
-		(adev->asic_type == CHIP_ARCTURUS ||
-		 adev->asic_type == CHIP_ALDEBARAN) ? 3 : 8;
+		(adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1) ||
+		 adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) ? 3 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
@@ -1649,12 +1655,12 @@ static int gmc_v9_0_sw_fini(void *handle)
 static void gmc_v9_0_init_golden_registers(struct amdgpu_device *adev)
 {
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
+	switch (adev->ip_versions[MMHUB_HWIP][0]) {
+	case IP_VERSION(9, 0, 0):
 		if (amdgpu_sriov_vf(adev))
 			break;
 		fallthrough;
-	case CHIP_VEGA20:
+	case IP_VERSION(9, 4, 0):
 		soc15_program_register_sequence(adev,
 						golden_settings_mmhub_1_0_0,
 						ARRAY_SIZE(golden_settings_mmhub_1_0_0));
@@ -1662,9 +1668,8 @@ static void gmc_v9_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_athub_1_0_0,
 						ARRAY_SIZE(golden_settings_athub_1_0_0));
 		break;
-	case CHIP_VEGA12:
-		break;
-	case CHIP_RAVEN:
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 0):
 		/* TODO for renoir */
 		soc15_program_register_sequence(adev,
 						golden_settings_athub_1_0_0,
@@ -1684,7 +1689,8 @@ static void gmc_v9_0_init_golden_registers(struct amdgpu_device *adev)
  */
 void gmc_v9_0_restore_registers(struct amdgpu_device *adev)
 {
-	if (adev->asic_type == CHIP_RAVEN) {
+	if ((adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 0)) ||
+	    (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 1))) {
 		WREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0, adev->gmc.sdpif_register);
 		WARN_ON(adev->gmc.sdpif_register !=
 			RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0));
-- 
2.31.1

