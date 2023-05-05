Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712F1C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 05:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E835510E562;
	Fri,  5 May 2023 05:29:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D0110E562
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 05:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i901Hg4TwB4fODo5WNUWRvL8kd2waEyVYZA4HQyELGJFqgugQJRwRnMnppL0f+mW93qmLrOfGNvjVP7Lipi5dFl6xs5xiZeLTPSOFwoUsV7VQ+tLqgjDFO6NMKMcx3pVRu1SpXri7sCH3VeP1Kefy+/5p6lKVjnmvXIlHeRYUNTftCxuNbQtt9d92mSI1unvydAuRNOu066tBBea4E2etMh8mtUJUKApKlNaq6zY3uAtrkSvQkDJ0QqtJt4IvOMvZ4GRVgz4Cdpb4c2MqzVnuJ9LLnI55QNF67nhiDoOgumVXhh4mAJJLGpL2VzhMuy1LDSX9ndi3t/FZ+DuObZiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58tjsZtAwg0GU+4O18QoE1eap8i5BkiStY58kCBm3xA=;
 b=gm0NJ/YqIMU6C/+rBWAdHM4yg/NTBQNV8nR9yuXImQvacW3hNqcxconCUQB6t97iPKowHbKfmmz1w9VjKU34j9e1EiTbRtvkmVC9HjJP0lRIl0b1jXa3xsPZuCVs3ncOugz5iT3FOMZnE1Flf/Fj3UqsT6vYBGkNGhxj/I90RfR8RR6NQpcYHgq6SFmygHHNRSoEntH5hkI3OGK7GeiejxSQcGX16iiUnVQFb0iTO4L7c+9D3fo13ZANYM7U2St8Rg3py2YBo8G7QWtRvEOSCCsQYRfZ8BOftsAbEx2QnoRaHi4Yqczqx7Rg8tCqpdpedggAdWWfZBm47JuHZpOxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58tjsZtAwg0GU+4O18QoE1eap8i5BkiStY58kCBm3xA=;
 b=nawkbxvJ2sUALegKHFXjojMwobXiToOI3rWs0oMNA37Z3Z4A6++7+515qlENPtZGA8/1wZjVtXhHvY+RhTVL6PIiq4eDts6RMmAHzgciH+f1XbRoDYRbpGjAPAt78DeE2oPvF9CBWHYJo6ng6wpLNi5MN4h4Nri2Xuvs7CTY6LI=
Received: from DM6PR01CA0021.prod.exchangelabs.com (2603:10b6:5:296::26) by
 PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 05:29:25 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::11) by DM6PR01CA0021.outlook.office365.com
 (2603:10b6:5:296::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Fri, 5 May 2023 05:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.27 via Frontend Transport; Fri, 5 May 2023 05:29:24 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 5 May
 2023 00:29:21 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: add bitmask to iterate vmhubs
Date: Fri, 5 May 2023 13:28:43 +0800
Message-ID: <20230505052846.1489935-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT058:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c29d6b6-e2cb-4afb-37cf-08db4d29b01f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W75RwkB3B/Qz6IhjEOkeNC043nbc+ErMQoROB8rlmK2SnDWtOCNTHbQei0X6C5XpcdbLvjVKfRSCaIRfHG6XQuW7R2u0LcD+hKUkCVhjjws1/yoQHAnwv3vgRgBZll5MUU98MZFoHTjQCAtZbbCmp1xBap5gY3E/klvUPgy92TDgiSYJAOR1giCmU3eyCgMrJuUG1wrf2t+8W/jKrx4G8jIWrky/osesIH+LLDh/q3w2KHEbaz4GyZL8GCQYkfy2Z2rglpDXTlZFwUhLSqXBXxviz/3vaA3f9M4d/j6J68wHYH475RZvg7H9NKsidwstGBhIiNWbRkd1woNKvonRFLohsLS0jzlbxJ9nMPlHYUL7WHM8XehCPuUqKuX1tKpFTdcqEH1Po0OShfKiJEt+gAjV6oKPCQPGkhAu9Ju2Req/BegjKIB6rC95Gn5o5iSF1tK/92smOhI94k+5kst7axdLRUC/t0jLqGpohlS0vtr2Ig20zMoiBAE3y4uavcZlxuBSehru0qDmtz8Ruj28C6RIyVoJ9Q6Bx13leAN71OyRHbx7FJnHo/GIZLS+WfeNxZBKNFC0pOMG4fK6TDu8bYTfFLDYY7hB3o1IVMMD97UyPmmmwRrBUKuzPBKUAsQ4CYD2Dde1B54ZD9TWuK8R1cy6k0i6PbVCPm1Lnv+1dVrr9q96onE+s2myZlgbGVRJJwbG9dImLHD8+Og6viHIHr7TPAMW6F32KNYALRBlahU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(7696005)(6916009)(4326008)(70586007)(70206006)(6666004)(478600001)(316002)(54906003)(36756003)(86362001)(47076005)(426003)(336012)(83380400001)(2616005)(1076003)(26005)(36860700001)(8936002)(5660300002)(8676002)(2906002)(41300700001)(82310400005)(40480700001)(82740400003)(356005)(16526019)(186003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 05:29:24.6109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c29d6b6-e2cb-4afb-37cf-08db4d29b01f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Lijo.Lazar@amd.com, le.ma@amd.com,
 Alexander.Deucher@amd.com, christian.koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

As the layout of VMHUB definition has been changed to cover multiple
XCD/AID case, the original num_vmhubs is not appropriate to do vmhub
iteration any more.

Drop num_vmhubs and introduce vmhubs_mask instead.

v2: switch to the new VMHUB layout
v3: use DECLARE_BITMAP to define vmhubs_mask

Change-Id: I3028c4cb607759253861cb10bf62f2fd13791e03
Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 22 +++++++++++++---------
 8 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5ded5a90dc68..9ac7ea452dee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -848,7 +848,7 @@ struct amdgpu_device {
 	dma_addr_t			dummy_page_addr;
 	struct amdgpu_vm_manager	vm_manager;
 	struct amdgpu_vmhub             vmhub[AMDGPU_MAX_VMHUBS];
-	unsigned			num_vmhubs;
+	DECLARE_BITMAP(vmhubs_mask, AMDGPU_MAX_VMHUBS);
 
 	/* memory management */
 	struct amdgpu_mman		mman;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index f0a136d35279..5afbcc390d89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -733,7 +733,7 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
 	if (adev->family == AMDGPU_FAMILY_AI) {
 		int i;
 
-		for (i = 0; i < adev->num_vmhubs; i++)
+		for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 			amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
 	} else {
 		amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0), 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 01cb89ffbd56..6b12f4a75fc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -182,7 +182,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	}
 	mb();
 	amdgpu_device_flush_hdp(adev, NULL);
-	for (i = 0; i < adev->num_vmhubs; i++)
+	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
 
 	drm_dev_exit(idx);
@@ -264,7 +264,7 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
 
 	mb();
 	amdgpu_device_flush_hdp(adev, NULL);
-	for (i = 0; i < adev->num_vmhubs; i++)
+	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ea2a448147e3..ff96f11c2adf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -460,7 +460,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 				&queried_pasid);
 		if (ret	&& queried_pasid == pasid) {
 			if (all_hub) {
-				for (i = 0; i < adev->num_vmhubs; i++)
+				for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 					gmc_v10_0_flush_gpu_tlb(adev, vmid,
 							i, flush_type);
 			} else {
@@ -928,7 +928,8 @@ static int gmc_v10_0_sw_init(void *handle)
 	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
-		adev->num_vmhubs = 2;
+		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
+		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
 		 * To fulfill 4-level page support,
 		 * vm size is 256TB (48bit), maximum size of Navi10/Navi14/Navi12,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index b7dad4e67813..aa754c95a0b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -808,7 +808,7 @@ static int gmc_v6_0_sw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->num_vmhubs = 1;
+	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
 	if (adev->flags & AMD_IS_APU) {
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 402960b0174e..81609a2b226f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -977,7 +977,7 @@ static int gmc_v7_0_sw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->num_vmhubs = 1;
+	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
 	if (adev->flags & AMD_IS_APU) {
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 504c1b34dab7..d48e33738a88 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1093,7 +1093,7 @@ static int gmc_v8_0_sw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->num_vmhubs = 1;
+	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
 	if (adev->flags & AMD_IS_APU) {
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 193ba4d912a6..53ae82e497cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -481,7 +481,7 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		for (j = 0; j < adev->num_vmhubs; j++) {
+		for_each_set_bit(j, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
 			hub = &adev->vmhub[j];
 			for (i = 0; i < 16; i++) {
 				reg = hub->vm_context0_cntl + i;
@@ -509,7 +509,7 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 		}
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		for (j = 0; j < adev->num_vmhubs; j++) {
+		for_each_set_bit(j, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
 			hub = &adev->vmhub[j];
 			for (i = 0; i < 16; i++) {
 				reg = hub->vm_context0_cntl + i;
@@ -803,7 +803,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	u32 j, inv_req, inv_req2, tmp;
 	struct amdgpu_vmhub *hub;
 
-	BUG_ON(vmhub >= adev->num_vmhubs);
+	BUG_ON(vmhub >= AMDGPU_MAX_VMHUBS);
 
 	hub = &adev->vmhub[vmhub];
 	if (adev->gmc.xgmi.num_physical_nodes &&
@@ -987,7 +987,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 				&queried_pasid);
 		if (ret && queried_pasid == pasid) {
 			if (all_hub) {
-				for (i = 0; i < adev->num_vmhubs; i++)
+				for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 					gmc_v9_0_flush_gpu_tlb(adev, vmid,
 							i, flush_type);
 			} else {
@@ -1684,7 +1684,8 @@ static int gmc_v9_0_sw_init(void *handle)
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 1, 0):
 	case IP_VERSION(9, 2, 2):
-		adev->num_vmhubs = 2;
+		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
+		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 
 		if (adev->rev_id == 0x0 || adev->rev_id == 0x1) {
 			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
@@ -1701,8 +1702,8 @@ static int gmc_v9_0_sw_init(void *handle)
 	case IP_VERSION(9, 3, 0):
 	case IP_VERSION(9, 4, 2):
 	case IP_VERSION(9, 4, 3):
-		adev->num_vmhubs = 2;
-
+		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
+		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 
 		/*
 		 * To fulfill 4-level page support,
@@ -1718,7 +1719,9 @@ static int gmc_v9_0_sw_init(void *handle)
 			adev->gmc.translate_further = adev->vm_manager.num_level > 1;
 		break;
 	case IP_VERSION(9, 4, 1):
-		adev->num_vmhubs = 3;
+		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
+		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
+		set_bit(AMDGPU_MMHUB1(0), adev->vmhubs_mask);
 
 		/* Keep the vm size same with Vega20 */
 		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
@@ -1944,7 +1947,8 @@ static int gmc_v9_0_hw_init(void *handle)
 			adev->gfxhub.funcs->set_fault_enable_default(adev, value);
 		adev->mmhub.funcs->set_fault_enable_default(adev, value);
 	}
-	for (i = 0; i < adev->num_vmhubs; ++i) {
+
+	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS){
 		if (adev->in_s0ix && (i == AMDGPU_GFXHUB(0)))
 			continue;
 		gmc_v9_0_flush_gpu_tlb(adev, 0, i, 0);
-- 
2.37.3

