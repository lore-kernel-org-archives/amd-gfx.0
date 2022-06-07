Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8997FC43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 18:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21DD610F5DA;
	Tue,  7 Jun 2022 18:36:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E59810F5B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 18:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ2QZQQ0H83v1EWADucqgZTE7sBonYsx2vtTvPQrow/OgKfHS1WPyWxd4RJB66MaHbgiszjLPVWkmMdL7uMWZ/LVJ8edGF+1wxlnk3iqDHcCldPx9AMvyVHj66275szOKkp++bIV30SDDuP2ltDQvg7chqtr/mPDSDmbcFixFHUbjt1KLP2pk/lgJFSBNQFvym/vjbNRF+Jwh+JImS6ZHSqU6vYpD6jaeHHXZ23gRUtX7Xi7+UKDraijEyjXPN+8OfqfCBol84TIkMXMf9ugxa6bOd/lw/qV3D6/fR4EUhjJdctL92CE8YhzrVr6fU4MwJN8XlY3/ieWOrK5+S/4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k9CBlBZip0clm2gyZQf7Q4hVbEVOGlXrchX1Ej5bK0=;
 b=lQVIGMsG40K4uFHU0LgYNIUjLOPt9ECCxKVjsuli8oZYsNfS2hFINdFJuj/8kLTaHf3UzNItGWsL82AU/FKy/oo3+EIHoXHzzEJNKurS6D57rJzMlLMBjtq+aHu7Q7KXYogv2EnkyQZa5qFFP/6Fthr9eE4MaXXNii+X87Nt5JlPvrTZG/Ofka1pInjrFaYQDXyg4XIFkfj4hYqRqaiZAixGLJhtz4ok8s2MJZNTFBijU2bWkAzukKMmPHAxnxiW8ch0623owvEqdT8GqGtkaX2QJBJTu667yxExHIqkKm3N+agWq88xKkEdjWX2yVd5E/mx9AkxGemdmLMaYmNaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k9CBlBZip0clm2gyZQf7Q4hVbEVOGlXrchX1Ej5bK0=;
 b=kONbFRPQuJDkSOoBVzTBu4eLKJHvlYFsOi3UDd4RKZIuGDWhXBXzIhChfVqAGY9kblleckVjFGWluhbtnU1UfvRdQqNeVc9kfe89b0bzJw5K/0vdwWmm7xKh5OkqMpGS2JXBZ1Gzutha0zEX4W7D8EueGc8N/mC0Ic5BT9MxiDI=
Received: from BN9PR03CA0596.namprd03.prod.outlook.com (2603:10b6:408:10d::31)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 18:36:49 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::ed) by BN9PR03CA0596.outlook.office365.com
 (2603:10b6:408:10d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 18:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 18:36:48 +0000
Received: from ruijing-ubuntu-pc.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 7 Jun 2022 13:36:47 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/vcn: support unified queue only in vcn4
Date: Tue, 7 Jun 2022 14:36:33 -0400
Message-ID: <20220607183633.27942-2-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607183633.27942-1-ruijing.dong@amd.com>
References: <20220607183633.27942-1-ruijing.dong@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fa28211-c387-48e4-4ee2-08da48b4aea1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4252:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB42521C36D8769D335290420695A59@DM6PR12MB4252.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xp3hzAuRltw6klXhJu3s+uVQjCPLlzfw+24nxCQuI3l/aRUGIL5OaSW9F09ZA0S3vr6Anv/1Wl7pq/NpnfxpqPQ1Ocb4Jwp+uSa1IM4me7cHTXyg87Uh3w+Fcd14F62GGyqi0knKAsyvzMIZ8UI3WCoj308ZOSl+tZl3RfQK1jG5hYx2mXJSZ3TKx3Xg98R+yjlyQe0f2StvIl8cuPFpjeup16UMh42YuxJ1x/sou+J3/X2bLo6UG5OlwX8lRlANDEFx+fTSn9r71mfyOh8fE4pRpgn5GXmqE9FUhjL/C3Nh32q6ANBc/ireQA1Sm8jGiKINs2tFJ7R9JC7Rx0b2jiRUBpBpKAl3zjN2McHjqAhH0ilNAesIWJq91ACG4IuiUCot7HYMrMAsKtwV5PfcawO9a+Ut+MhWtAWiTaEGArmGGMv/85iJm9c79D5XIWP8E5Ui+Rx+GIfNgCw6trjDaM9mGw9LVag99TqkyTYx1sofDt59ytpRpMGz/1zlEtkokXyRvc1Wds8dZl7Hiefrx+zO6jNRyme4rb5lS9ECqTxeOHWideaWsJhS+HzOy6bdgMjDoZFCWlAjfvhMGT+ctDKPy8kUo/O9cCHdDbW7dJMbok4tAjB4fL4rEUjxE8Y6Bf/pF7T9iqRaH/k95quMyNcAdOIodQSVJTC8/wgabHPt1PSqHRree/PjOH8qn0IDluUBEiSboSkXktily8dmrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(70206006)(82310400005)(47076005)(336012)(426003)(83380400001)(2906002)(81166007)(6666004)(2616005)(26005)(40460700003)(1076003)(54906003)(316002)(186003)(7696005)(16526019)(5660300002)(508600001)(70586007)(36860700001)(8936002)(4326008)(110136005)(36756003)(356005)(44832011)(30864003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 18:36:48.6841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa28211-c387-48e4-4ee2-08da48b4aea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
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
Cc: thong.thai@amd.com, sonny.jiang@amd.com, boyuan.zhang@amd.com,
 alexander.deucher@amd.com, ruijing.dong@amd.com, james.zhu@amd.com,
 leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- remove multiple queue support.
- add unified queue related functions.

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 563 +++++++-------------------
 1 file changed, 140 insertions(+), 423 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 9119e966ffff..d6f134ef9633 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -29,7 +29,6 @@
 #include "soc15d.h"
 #include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
-#include "vcn_sw_ring.h"
 
 #include "vcn/vcn_4_0_0_offset.h"
 #include "vcn/vcn_4_0_0_sh_mask.h"
@@ -45,15 +44,12 @@
 #define VCN_VID_SOC_ADDRESS_2_0							0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0						0x48300
 
-bool unifiedQ_enabled = false;
-
 static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN,
 	SOC15_IH_CLIENTID_VCN1
 };
 
-static void vcn_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev);
-static void vcn_v4_0_set_enc_ring_funcs(struct amdgpu_device *adev);
+static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_set_powergating_state(void *handle,
         enum amd_powergating_state state);
@@ -71,36 +67,15 @@ static int vcn_v4_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (unifiedQ_enabled) {
-		adev->vcn.num_vcn_inst = 1;
-		adev->vcn.num_enc_rings = 1;
-	} else {
-		adev->vcn.num_enc_rings = 2;
-	}
-
-	if (!unifiedQ_enabled)
-		vcn_v4_0_set_dec_ring_funcs(adev);
+	/* re-use enc ring as unified ring */
+	adev->vcn.num_enc_rings = 1;
 
-	vcn_v4_0_set_enc_ring_funcs(adev);
+	vcn_v4_0_set_unified_ring_funcs(adev);
 	vcn_v4_0_set_irq_funcs(adev);
 
 	return 0;
 }
 
-static void amdgpu_vcn_setup_unified_queue_ucode(struct amdgpu_device *adev)
-{
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		const struct common_firmware_header *hdr;
-
-		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-		DRM_INFO("PSP loading VCN firmware\n");
-	}
-}
-
 /**
  * vcn_v4_0_sw_init - sw init for VCN block
  *
@@ -111,17 +86,14 @@ static void amdgpu_vcn_setup_unified_queue_ucode(struct amdgpu_device *adev)
 static int vcn_v4_0_sw_init(void *handle)
 {
 	struct amdgpu_ring *ring;
-	int i, j, r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i, r;
 
 	r = amdgpu_vcn_sw_init(adev);
 	if (r)
 		return r;
 
-	if (unifiedQ_enabled)
-		amdgpu_vcn_setup_unified_queue_ucode(adev);
-	else
-		amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev);
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
@@ -129,81 +101,40 @@ static int vcn_v4_0_sw_init(void *handle)
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-		/* VCN DEC TRAP */
+
+		atomic_set(&adev->vcn.inst[i].sched_score, 0);
+
+		/* VCN UNIFIED TRAP */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				VCN_4_0__SRCID__UVD_TRAP, &adev->vcn.inst[i].irq);
+				VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
 		if (r)
 			return r;
 
-		atomic_set(&adev->vcn.inst[i].sched_score, 0);
-		if (!unifiedQ_enabled) {
-			ring = &adev->vcn.inst[i].ring_dec;
-			ring->use_doorbell = true;
-
-			/* VCN4 doorbell layout
-			 * 1: VCN_JPEG_DB_CTRL UVD_JRBC_RB_WPTR; (jpeg)
-			 * 2: VCN_RB1_DB_CTRL  UVD_RB_WPTR; (decode/encode for unified queue)
-			 * 3: VCN_RB2_DB_CTRL  UVD_RB_WPTR2; (encode only for swqueue)
-			 * 4: VCN_RB3_DB_CTRL  UVD_RB_WPTR3; (Reserved)
-			 * 5: VCN_RB4_DB_CTRL  UVD_RB_WPTR4; (decode only for swqueue)
-			 */
-
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1)
-						+ 5 + 8 * i;
-
-			sprintf(ring->name, "vcn_dec_%d", i);
-			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-					     AMDGPU_RING_PRIO_DEFAULT,
-					     &adev->vcn.inst[i].sched_score);
-			if (r)
-				return r;
-		}
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-			/* VCN ENC TRAP */
-			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				j + VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
-			if (r)
-				return r;
-
-			ring = &adev->vcn.inst[i].ring_enc[j];
-			ring->use_doorbell = true;
-
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
-
-			if (unifiedQ_enabled) {
-				sprintf(ring->name, "vcn_unified%d", i);
-				r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
-			} else {
-				enum amdgpu_ring_priority_level hw_prio;
+		ring = &adev->vcn.inst[i].ring_enc[0];
+		ring->use_doorbell = true;
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * i;
 
-				hw_prio = amdgpu_vcn_get_enc_ring_prio(j);
-				sprintf(ring->name, "vcn_enc_%d.%d", i, j);
-				r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-					     hw_prio, &adev->vcn.inst[i].sched_score);
-			}
-			if (r)
-				return r;
-		}
+		sprintf(ring->name, "vcn_unified_%d", i);
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 = 0;
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
+				  AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
+		if (r)
+			return r;
 
-		if (unifiedQ_enabled) {
-			fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
-			fw_shared->sq.is_enabled = 1;
-		}
+		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
+		fw_shared->sq.is_enabled = 1;
 
 		if (amdgpu_vcnfw_log)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
-	if (!unifiedQ_enabled) {
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-			adev->vcn.pause_dpg_mode = vcn_v4_0_pause_dpg_mode;
-	}
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		adev->vcn.pause_dpg_mode = vcn_v4_0_pause_dpg_mode;
+
 	return 0;
 }
 
@@ -220,19 +151,19 @@ static int vcn_v4_0_sw_fini(void *handle)
 	int i, r, idx;
 
 	if (drm_dev_enter(&adev->ddev, &idx)) {
-                for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-                        volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
-                        if (adev->vcn.harvest_config & (1 << i))
-                                continue;
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
 
-                        fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-                        fw_shared->present_flag_0 = 0;
-                        fw_shared->sq.is_enabled = 0;
-                }
+			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+			fw_shared->present_flag_0 = 0;
+			fw_shared->sq.is_enabled = 0;
+		}
 
-                drm_dev_exit(idx);
-        }
+		drm_dev_exit(idx);
+	}
 
 	r = amdgpu_vcn_suspend(adev);
 	if (r)
@@ -254,15 +185,13 @@ static int vcn_v4_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring;
-	int i, j, r;
+	int i, r;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-		if (unifiedQ_enabled)
-			ring = &adev->vcn.inst[i].ring_enc[0];
-		else
-			ring = &adev->vcn.inst[i].ring_dec;
+
+		ring = &adev->vcn.inst[i].ring_enc[0];
 
 		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
@@ -270,13 +199,6 @@ static int vcn_v4_0_hw_init(void *handle)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			goto done;
-
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-			ring = &adev->vcn.inst[i].ring_enc[j];
-			r = amdgpu_ring_test_helper(ring);
-			if (r)
-				goto done;
-		}
 	}
 
 done:
@@ -464,7 +386,6 @@ static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, regUVD_VCPU_CACHE_OFFSET0),
 			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
-
 	}
 
 	if (!indirect)
@@ -888,7 +809,6 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
-	int i;
 
 	/* disable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 1,
@@ -974,74 +894,32 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
 				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
 
-	if (unifiedQ_enabled) {
-		ring = &adev->vcn.inst[inst_idx].ring_enc[0];
-		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
-	} else
-		ring = &adev->vcn.inst[inst_idx].ring_dec;
-
-	WREG32_SOC15(VCN, inst_idx, regVCN_RB4_DB_CTRL,
-		ring->doorbell_index << VCN_RB4_DB_CTRL__OFFSET__SHIFT |
-		VCN_RB4_DB_CTRL__EN_MASK);
-
-	/* program the RB_BASE for ring buffer */
-	WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_LO4,
-		lower_32_bits(ring->gpu_addr));
-	WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_HI4,
-		upper_32_bits(ring->gpu_addr));
+	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
-	WREG32_SOC15(VCN, inst_idx, regUVD_RB_SIZE4, ring->ring_size / sizeof(uint32_t));
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_LO, ring->gpu_addr);
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_SIZE, ring->ring_size / 4);
 
-	/* reseting ring, fw should not check RB ring */
 	tmp = RREG32_SOC15(VCN, inst_idx, regVCN_RB_ENABLE);
-	tmp &= ~(VCN_RB_ENABLE__RB4_EN_MASK);
+	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
 	WREG32_SOC15(VCN, inst_idx, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR, 0);
 
-	/* Initialize the ring buffer's read and write pointers */
-	tmp = RREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR4);
-	WREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR4, tmp);
-	ring->wptr = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR4);
+	tmp= RREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR);
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR, tmp);
+	ring->wptr = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR);
 
 	tmp = RREG32_SOC15(VCN, inst_idx, regVCN_RB_ENABLE);
-	tmp |= VCN_RB_ENABLE__RB4_EN_MASK;
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
 	WREG32_SOC15(VCN, inst_idx, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
-	WREG32_SOC15(VCN, inst_idx, regUVD_SCRATCH2, 0);
-
-	if (unifiedQ_enabled)
-		fw_shared->sq.queue_mode &= ~FW_QUEUE_RING_RESET;
-
-	for (i = 0; i < adev->vcn.num_enc_rings; i++) {
-		ring = &adev->vcn.inst[inst_idx].ring_enc[i];
-
-		if (i) {
-			ring = &adev->vcn.inst[inst_idx].ring_enc[1];
-
-			WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_LO2, ring->gpu_addr);
-			WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
-			WREG32_SOC15(VCN, inst_idx, regUVD_RB_SIZE2, ring->ring_size / 4);
-			tmp= RREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR2);
-			WREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR2, tmp);
-			ring->wptr = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR2);
-
-			WREG32_SOC15(VCN, inst_idx, regVCN_RB2_DB_CTRL,
-				ring->doorbell_index << VCN_RB2_DB_CTRL__OFFSET__SHIFT |
-				VCN_RB2_DB_CTRL__EN_MASK);
-		} else {
-			ring = &adev->vcn.inst[inst_idx].ring_enc[0];
-
-			WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_LO, ring->gpu_addr);
-			WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-			WREG32_SOC15(VCN, inst_idx, regUVD_RB_SIZE, ring->ring_size / 4);
-			tmp= RREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR);
-			WREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR, tmp);
-			ring->wptr = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR);
+	WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
+			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+			VCN_RB1_DB_CTRL__EN_MASK);
 
-			WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
-				ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-				VCN_RB1_DB_CTRL__EN_MASK);
-		}
-	}
 	return 0;
 }
 
@@ -1064,6 +942,8 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 		amdgpu_dpm_enable_uvd(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
 			r = vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
 			continue;
@@ -1081,15 +961,15 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 
 		/* enable VCPU clock */
 		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+				UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
 
 		/* disable master interrupt */
 		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
+				~UVD_MASTINT_EN__VCPU_EN_MASK);
 
 		/* enable LMI MC and UMC channels */
 		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+				~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
 
 		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
 		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
@@ -1099,10 +979,10 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 		/* setup regUVD_LMI_CTRL */
 		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
 		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
-		UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
-		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+				UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+				UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+				UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+				UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
 
 		/* setup regUVD_MPC_CNTL */
 		tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
@@ -1112,37 +992,37 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 
 		/* setup UVD_MPC_SET_MUXA0 */
 		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
-			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+				((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+				 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+				 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+				 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
 
 		/* setup UVD_MPC_SET_MUXB0 */
 		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
-			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+				((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+				 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+				 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+				 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
 
 		/* setup UVD_MPC_SET_MUX */
 		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
-			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
-			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
+				((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+				 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+				 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
 		vcn_v4_0_mc_resume(adev, i);
 
 		/* VCN global tiling registers */
 		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
+				adev->gfx.config.gb_addr_config);
 
 		/* unblock VCPU register access */
 		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
 		/* release VCPU reset to boot */
 		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+				~UVD_VCPU_CNTL__BLK_RST_MASK);
 
 		for (j = 0; j < 10; ++j) {
 			uint32_t status;
@@ -1166,13 +1046,13 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 				if (status & 2)
 					break;
 
-				dev_err(adev->dev, "VCN[%d] decode not responding, trying to reset the VCPU!!!\n", i);
-					WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-					UVD_VCPU_CNTL__BLK_RST_MASK,
-					~UVD_VCPU_CNTL__BLK_RST_MASK);
+				dev_err(adev->dev, "VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
+				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
+						UVD_VCPU_CNTL__BLK_RST_MASK,
+						~UVD_VCPU_CNTL__BLK_RST_MASK);
 				mdelay(10);
 				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-					~UVD_VCPU_CNTL__BLK_RST_MASK);
+						~UVD_VCPU_CNTL__BLK_RST_MASK);
 
 				mdelay(10);
 				r = -1;
@@ -1180,78 +1060,43 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 		}
 
 		if (r) {
-			dev_err(adev->dev, "VCN[%d] decode not responding, giving up!!!\n", i);
+			dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
 			return r;
 		}
 
 		/* enable master interrupt */
 		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
-			UVD_MASTINT_EN__VCPU_EN_MASK,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
+				UVD_MASTINT_EN__VCPU_EN_MASK,
+				~UVD_MASTINT_EN__VCPU_EN_MASK);
 
 		/* clear the busy bit of VCN_STATUS */
 		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
-			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
-
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		if (unifiedQ_enabled) {
-			ring = &adev->vcn.inst[i].ring_enc[0];
-			fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
-		} else {
-			ring = &adev->vcn.inst[i].ring_dec;
+				~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-			WREG32_SOC15(VCN, i, regVCN_RB4_DB_CTRL,
-				ring->doorbell_index << VCN_RB4_DB_CTRL__OFFSET__SHIFT |
-				VCN_RB4_DB_CTRL__EN_MASK);
-
-			/* program the RB_BASE for ring buffer */
-			WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO4,
-				lower_32_bits(ring->gpu_addr));
-			WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI4,
-				upper_32_bits(ring->gpu_addr));
-
-			WREG32_SOC15(VCN, i, regUVD_RB_SIZE4, ring->ring_size / sizeof(uint32_t));
-
-			/* resetting ring, fw should not check RB ring */
-			tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-			tmp &= ~(VCN_RB_ENABLE__RB4_EN_MASK);
-			WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
+		ring = &adev->vcn.inst[i].ring_enc[0];
+		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
+				ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+				VCN_RB1_DB_CTRL__EN_MASK);
 
-			/* Initialize the ring buffer's read and write pointers */
-			tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR4);
-			WREG32_SOC15(VCN, i, regUVD_RB_WPTR4, tmp);
-			ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR4);
+		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
+		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
 
-			tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-			tmp |= VCN_RB_ENABLE__RB4_EN_MASK;
-			WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
+		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+		tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
+		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
+		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
 
-			ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_RPTR4);
-		}
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
-			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-			VCN_RB1_DB_CTRL__EN_MASK);
 		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
 		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
 		ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
-		if (unifiedQ_enabled)
-			fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
-		else {
-			ring = &adev->vcn.inst[i].ring_enc[1];
-			WREG32_SOC15(VCN, i, regVCN_RB2_DB_CTRL,
-				ring->doorbell_index << VCN_RB2_DB_CTRL__OFFSET__SHIFT |
-				VCN_RB2_DB_CTRL__EN_MASK);
-			tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR2);
-			WREG32_SOC15(VCN, i, regUVD_RB_WPTR2, tmp);
-			ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR2);
-			WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO2, ring->gpu_addr);
-			WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
-			WREG32_SOC15(VCN, i, regUVD_RB_SIZE2, ring->ring_size / 4);
-		}
+
+		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
+		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 	}
 
 	return 0;
@@ -1277,12 +1122,6 @@ static int vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	tmp = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR);
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_RB_RPTR, tmp, 0xFFFFFFFF);
 
-	tmp = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR2);
-	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_RB_RPTR2, tmp, 0xFFFFFFFF);
-
-	tmp = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR4);
-	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_RB_RPTR4, tmp, 0xFFFFFFFF);
-
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
@@ -1301,10 +1140,14 @@ static int vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  */
 static int vcn_v4_0_stop(struct amdgpu_device *adev)
 {
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
 	int i, r = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
 			r = vcn_v4_0_stop_dpg_mode(adev, i);
 			continue;
@@ -1414,8 +1257,6 @@ static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
 			/* unpause dpg, no need to wait */
 			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
 			WREG32_SOC15(VCN, inst_idx, regUVD_DPG_PAUSE, reg_data);
-			SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 0x1,
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 		}
 		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
 	}
@@ -1424,165 +1265,72 @@ static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
 }
 
 /**
- * vcn_v4_0_dec_ring_get_rptr - get read pointer
+ * vcn_v4_0_unified_ring_get_rptr - get unified read pointer
  *
  * @ring: amdgpu_ring pointer
  *
- * Returns the current hardware read pointer
+ * Returns the current hardware unified read pointer
  */
-static uint64_t vcn_v4_0_dec_ring_get_rptr(struct amdgpu_ring *ring)
+static uint64_t vcn_v4_0_unified_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	return RREG32_SOC15(VCN, ring->me, regUVD_RB_RPTR4);
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
+	return RREG32_SOC15(VCN, ring->me, regUVD_RB_RPTR);
 }
 
 /**
- * vcn_v4_0_dec_ring_get_wptr - get write pointer
+ * vcn_v4_0_unified_ring_get_wptr - get unified write pointer
  *
  * @ring: amdgpu_ring pointer
  *
- * Returns the current hardware write pointer
+ * Returns the current hardware unified write pointer
  */
-static uint64_t vcn_v4_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
+static uint64_t vcn_v4_0_unified_ring_get_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
 	if (ring->use_doorbell)
 		return *ring->wptr_cpu_addr;
 	else
-		return RREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR4);
+		return RREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR);
 }
 
 /**
- * vcn_v4_0_dec_ring_set_wptr - set write pointer
+ * vcn_v4_0_unified_ring_set_wptr - set enc write pointer
  *
  * @ring: amdgpu_ring pointer
  *
- * Commits the write pointer to the hardware
+ * Commits the enc write pointer to the hardware
  */
-static void vcn_v4_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
+static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-		WREG32_SOC15(VCN, ring->me, regUVD_SCRATCH2,
-			lower_32_bits(ring->wptr));
-	}
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell) {
 		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
-		WREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR4, lower_32_bits(ring->wptr));
-	}
-}
-
-static const struct amdgpu_ring_funcs vcn_v4_0_dec_sw_ring_vm_funcs = {
-	.type = AMDGPU_RING_TYPE_VCN_DEC,
-	.align_mask = 0x3f,
-	.nop = VCN_DEC_SW_CMD_NO_OP,
-	.vmhub = AMDGPU_MMHUB_0,
-	.get_rptr = vcn_v4_0_dec_ring_get_rptr,
-	.get_wptr = vcn_v4_0_dec_ring_get_wptr,
-	.set_wptr = vcn_v4_0_dec_ring_set_wptr,
-	.emit_frame_size =
-		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
-		VCN_SW_RING_EMIT_FRAME_SIZE,
-	.emit_ib_size = 5, /* vcn_dec_sw_ring_emit_ib */
-	.emit_ib = vcn_dec_sw_ring_emit_ib,
-	.emit_fence = vcn_dec_sw_ring_emit_fence,
-	.emit_vm_flush = vcn_dec_sw_ring_emit_vm_flush,
-	.test_ring = amdgpu_vcn_dec_sw_ring_test_ring,
-	.test_ib = amdgpu_vcn_dec_sw_ring_test_ib,
-	.insert_nop = amdgpu_ring_insert_nop,
-	.insert_end = vcn_dec_sw_ring_insert_end,
-	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.begin_use = amdgpu_vcn_ring_begin_use,
-	.end_use = amdgpu_vcn_ring_end_use,
-	.emit_wreg = vcn_dec_sw_ring_emit_wreg,
-	.emit_reg_wait = vcn_dec_sw_ring_emit_reg_wait,
-	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-};
-
-/**
- * vcn_v4_0_enc_ring_get_rptr - get enc read pointer
- *
- * @ring: amdgpu_ring pointer
- *
- * Returns the current hardware enc read pointer
- */
-static uint64_t vcn_v4_0_enc_ring_get_rptr(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	if (ring == &adev->vcn.inst[ring->me].ring_enc[0])
-		return RREG32_SOC15(VCN, ring->me, regUVD_RB_RPTR);
-	else
-		return RREG32_SOC15(VCN, ring->me, regUVD_RB_RPTR2);
-}
-
-/**
- * vcn_v4_0_enc_ring_get_wptr - get enc write pointer
- *
- * @ring: amdgpu_ring pointer
- *
- * Returns the current hardware enc write pointer
- */
-static uint64_t vcn_v4_0_enc_ring_get_wptr(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	if (ring == &adev->vcn.inst[ring->me].ring_enc[0]) {
-		if (ring->use_doorbell)
-			return *ring->wptr_cpu_addr;
-		else
-			return RREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR);
-	} else {
-		if (ring->use_doorbell)
-			return *ring->wptr_cpu_addr;
-		else
-			return RREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR2);
-	}
-}
-
-/**
- * vcn_v4_0_enc_ring_set_wptr - set enc write pointer
- *
- * @ring: amdgpu_ring pointer
- *
- * Commits the enc write pointer to the hardware
- */
-static void vcn_v4_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	if (ring == &adev->vcn.inst[ring->me].ring_enc[0]) {
-		if (ring->use_doorbell) {
-			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
-			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
-		} else {
-			WREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR, lower_32_bits(ring->wptr));
-		}
-	} else {
-		if (ring->use_doorbell) {
-			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
-			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
-		} else {
-			WREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR2, lower_32_bits(ring->wptr));
-		}
+		WREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR, lower_32_bits(ring->wptr));
 	}
 }
 
-static const struct amdgpu_ring_funcs vcn_v4_0_enc_ring_vm_funcs = {
+static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
 	.vmhub = AMDGPU_MMHUB_0,
-	.get_rptr = vcn_v4_0_enc_ring_get_rptr,
-	.get_wptr = vcn_v4_0_enc_ring_get_wptr,
-	.set_wptr = vcn_v4_0_enc_ring_set_wptr,
+	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
+	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
+	.set_wptr = vcn_v4_0_unified_ring_set_wptr,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
@@ -1594,7 +1342,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_enc_ring_vm_funcs = {
 	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
 	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
 	.test_ring = amdgpu_vcn_enc_ring_test_ring,
-	.test_ib = amdgpu_vcn_enc_ring_test_ib,
+	.test_ib = amdgpu_vcn_unified_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
 	.insert_end = vcn_v2_0_enc_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
@@ -1606,13 +1354,13 @@ static const struct amdgpu_ring_funcs vcn_v4_0_enc_ring_vm_funcs = {
 };
 
 /**
- * vcn_v4_0_set_dec_ring_funcs - set dec ring functions
+ * vcn_v4_0_set_unified_ring_funcs - set unified ring functions
  *
  * @adev: amdgpu_device pointer
  *
- * Set decode ring functions
+ * Set unified ring functions
  */
-static void vcn_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev)
+static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
 
@@ -1620,32 +1368,10 @@ static void vcn_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		adev->vcn.inst[i].ring_dec.funcs = &vcn_v4_0_dec_sw_ring_vm_funcs;
-		adev->vcn.inst[i].ring_dec.me = i;
-		DRM_INFO("VCN(%d) decode software ring is enabled in VM mode\n", i);
-	}
-}
-
-/**
- * vcn_v4_0_set_enc_ring_funcs - set enc ring functions
- *
- * @adev: amdgpu_device pointer
- *
- * Set encode ring functions
- */
-static void vcn_v4_0_set_enc_ring_funcs(struct amdgpu_device *adev)
-{
-	int i, j;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_unified_ring_vm_funcs;
+		adev->vcn.inst[i].ring_enc[0].me = i;
 
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-			adev->vcn.inst[i].ring_enc[j].funcs = &vcn_v4_0_enc_ring_vm_funcs;
-			adev->vcn.inst[i].ring_enc[j].me = i;
-		}
-		DRM_INFO("VCN(%d) encode is enabled in VM mode\n", i);
+		DRM_INFO("VCN(%d) encode/decode are enabled in VM mode\n", i);
 	}
 }
 
@@ -1798,18 +1524,9 @@ static int vcn_v4_0_process_interrupt(struct amdgpu_device *adev, struct amdgpu_
 	DRM_DEBUG("IH: VCN TRAP\n");
 
 	switch (entry->src_id) {
-	case VCN_4_0__SRCID__UVD_TRAP:
-		if (!unifiedQ_enabled) {
-			amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_dec);
-			break;
-		}
-		break;
 	case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
 		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[0]);
 		break;
-	case VCN_4_0__SRCID__UVD_ENC_LOW_LATENCY:
-		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[1]);
-		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
-- 
2.25.1

