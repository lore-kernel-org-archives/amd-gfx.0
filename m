Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F27ECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C11E10E074;
	Tue, 30 Aug 2022 18:42:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DACA10E382
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e40Zi2iIQ+9o4PNCFXFtifo0EckrYINSFZxB5MKVgMxur7eCm9I3nJfz3qJxW8HSgyTADfxLd+afFgT5+czCx+vuXZtKZEc6TzcccabBl14R81G/LhaOb1+2CwqkV6SP/vltBWEI0Jlj28u87vRhkDTJKfCXrXaxWI0eohpIfWlac4Y0YyiEhQeqvbEWHQ5zIfcAqsnGXNYEaA1loXFSR4uI1z374ON+E5iEl8FS78b5aWHLqVM2QjBUp8H9BVzd2rLLar8lcvDGNMsGytvrWspD0RadMY3kqgDxMv24IUMWUOyNlYLVWZcB0dY8EDbHEeQV2qC74P50AKMfGBG0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfF/LzExV0yvsV+hP7YV1KEVU/L0vbq5OR3/7XfEbwQ=;
 b=FcaHX9r/Kyu7M0YtG4sP0n8Jfq+hR0mMvkwKghGwkB/vnEyYhwWzlHdXK7yb7PNZa8ocWI1hPVRks/j7IhPcbHaYj7emAj1vGrink1w0/d4nrsRmY56i/XHguA9gaR6PhCPKziV7kMvSlksL1KPYe4C9UvZoCGdFCkKrHhJqBd0YE+aQdkSTEEBrGp1LSGW7wkdBvhqJPQ0xiyyeGTkQtVkIJuzyeAX0i2uHP/wUwgeBbgcwnKoFez85CwsxI2xwZwHSohb8dCqoa7V8PKkuTLEsw6Al/QztmylboN+uyLyUU4olXrPrVY4eFyfvP4YXdX1DD2C9UqDWNnc76WjJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfF/LzExV0yvsV+hP7YV1KEVU/L0vbq5OR3/7XfEbwQ=;
 b=SzGE5XiGRycqHiB0Km36fiM+g9MIeffks6ccBGtZUSUBEXjPUZSmTZhgCaTNNNK1H3Kxn/uQaM5tsD/QhH4kBacvv9eD6MNPEdul4DJtvwApGfdQ5yJgtzWvPnsMcluiFCmnLP9k2IHLyRJPFF/LDnNbDSACqFvw9AEClTP3AGA=
Received: from DM6PR02CA0088.namprd02.prod.outlook.com (2603:10b6:5:1f4::29)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 30 Aug
 2022 18:40:38 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::95) by DM6PR02CA0088.outlook.office365.com
 (2603:10b6:5:1f4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/19] drm/amdgpu/vcn: Add sriov VCN v4_0 unified queue support
Date: Tue, 30 Aug 2022 14:40:11 -0400
Message-ID: <20220830184012.1825313-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59556b53-fb47-45a3-02cd-08da8ab72209
X-MS-TrafficTypeDiagnostic: IA1PR12MB7616:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFUvxvLWTXG6r0r+eLzl34eAxGnEwpn6+M09FeT9pvfHUJF80dyzIS1tnRj3Z8iXbCK+SVcqXRTkoC6NiI0Mf2aHl8oltAKbuLesHPRPp67ARE88FNUs6p/oVSI2i2ZctxQhwFkbwSn8hI4mKYYPZvY94ZUq+pRs0dIbYRwIJD5Y/iPvbqXDeY0atvry1LCXyh4MLXuVlBlwSUtP8mnFv2Ntl4KcK8+fmqs+b2m63zQYpfa8Q1D70ZmQnJmqAVVXlttIycYxllQhJGCZQrmwsSBdYTnVPAt5b8voEtYLLII1Bp45SLYTD4cvdVdEa/Ke5D5Zzoq5VNecXsQ5HmS4o5hjapOMd76zOF5NRHf0B43ndogbwmo4DTrWOzZXgf/sULzj+1+l5oMk9Xt74cBx6jZt6aBfO9wytgX3GYma8w8PmQkgdMOE0ShXUx/qdK3aVXKAG7ApMUpu3/OtwwhNl4BgJQ4RRr9Dwof3wTklUjKhAmoM2HoZFlIc6PIatu8i20XIPVFLilPtJVoWHAYBUWw028AvV0Ov5GbtsFO2qX+Tn8oUMuQJv/h5LP0AxZ6dOl+IFHMGbnknplSsXQiOqpWd7qBWHxXBLnqdIhYqX2GpOudd0shw3iEobe3DxZtteuEmGTTeMF00TxOtuAqIftm8ffxHy1nE2U8ZwEGMaWbja6q5E7NEjy5XyxmVp9qZl1Frc0tPFMeXqcwug87zVJswBNBGpw396CTNndyJnMKaXKWOgh74gC3H44ZcuSOmXXVNF4U1tgu4737HduLt20/haXxczmodgqiat7LUHgs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(36840700001)(46966006)(40470700004)(36756003)(40460700003)(86362001)(70586007)(54906003)(316002)(70206006)(6916009)(36860700001)(81166007)(356005)(82740400003)(83380400001)(336012)(5660300002)(26005)(6666004)(478600001)(41300700001)(82310400005)(8676002)(7696005)(2906002)(30864003)(8936002)(4326008)(40480700001)(2616005)(16526019)(426003)(1076003)(186003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:38.0073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59556b53-fb47-45a3-02cd-08da8ab72209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Ruijing Dong <ruijing.dong@amd.com>,
 Jane Jian <Jane.Jian@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jane Jian <Jane.Jian@amd.com>

Enable unified queue support for sriov, abandon all previous
multi-queue settings

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  13 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 297 +++++++++++++++++-
 3 files changed, 300 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 06b2d1830091..9fa2a5ceb77d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1908,10 +1908,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(4, 0, 0):
 		case IP_VERSION(4, 0, 2):
 		case IP_VERSION(4, 0, 4):
-			if (!amdgpu_sriov_vf(adev)) {
-				amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
+			amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
+			if (!amdgpu_sriov_vf(adev))
 				amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
-			}
 			break;
 		default:
 			dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 60c608144480..80b7a6cfd026 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -161,6 +161,7 @@
 #define AMDGPU_VCN_SW_RING_FLAG		(1 << 9)
 #define AMDGPU_VCN_FW_LOGGING_FLAG	(1 << 10)
 #define AMDGPU_VCN_SMU_VERSION_INFO_FLAG (1 << 11)
+#define AMDGPU_VCN_VF_RB_SETUP_FLAG (1 << 12)
 
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
@@ -317,12 +318,24 @@ struct amdgpu_fw_shared {
 	struct amdgpu_fw_shared_smu_interface_info smu_interface_info;
 };
 
+struct amdgpu_fw_shared_rb_setup {
+	uint32_t is_rb_enabled_flags;
+	uint32_t rb_addr_lo;
+	uint32_t rb_addr_hi;
+	uint32_t  rb_size;
+	uint32_t  rb4_addr_lo;
+	uint32_t  rb4_addr_hi;
+	uint32_t  rb4_size;
+	uint32_t  reserved[6];
+};
+
 struct amdgpu_vcn4_fw_shared {
 	uint32_t present_flag_0;
 	uint8_t pad[12];
 	struct amdgpu_fw_shared_unified_queue_struct sq;
 	uint8_t pad1[8];
 	struct amdgpu_fw_shared_fw_logging fw_log;
+	struct amdgpu_fw_shared_rb_setup rb_setup;
 };
 
 struct amdgpu_vcn_fwlog {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index fb2d74f30448..09c89faa8c27 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -30,6 +30,7 @@
 #include "soc15d.h"
 #include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
+#include "mmsch_v4_0.h"
 
 #include "vcn/vcn_4_0_0_offset.h"
 #include "vcn/vcn_4_0_0_sh_mask.h"
@@ -45,6 +46,8 @@
 #define VCN_VID_SOC_ADDRESS_2_0							0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0						0x48300
 
+#define VCN_HARVEST_MMSCH								0
+
 #define RDECODE_MSG_CREATE							0x00000000
 #define RDECODE_MESSAGE_CREATE							0x00000001
 
@@ -53,12 +56,14 @@ static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN1
 };
 
+static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_set_powergating_state(void *handle,
         enum amd_powergating_state state);
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
         int inst_idx, struct dpg_pause_state *new_state);
+static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
  * vcn_v4_0_early_init - set function pointers
@@ -71,6 +76,9 @@ static int vcn_v4_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (amdgpu_sriov_vf(adev))
+		adev->vcn.harvest_config = VCN_HARVEST_MMSCH;
+
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
 
@@ -92,6 +100,7 @@ static int vcn_v4_0_sw_init(void *handle)
 	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i, r;
+	int vcn_doorbell_index = 0;
 
 	r = amdgpu_vcn_sw_init(adev);
 	if (r)
@@ -103,6 +112,12 @@ static int vcn_v4_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	if (amdgpu_sriov_vf(adev)) {
+		vcn_doorbell_index = adev->doorbell_index.vcn.vcn_ring0_1 - MMSCH_DOORBELL_OFFSET;
+		/* get DWORD offset */
+		vcn_doorbell_index = vcn_doorbell_index << 1;
+	}
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
@@ -119,7 +134,10 @@ static int vcn_v4_0_sw_init(void *handle)
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		ring->use_doorbell = true;
-		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * i;
+		if (amdgpu_sriov_vf(adev))
+			ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1) + 1;
+		else
+			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * i;
 
 		sprintf(ring->name, "vcn_unified_%d", i);
 
@@ -132,10 +150,19 @@ static int vcn_v4_0_sw_init(void *handle)
 		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
 		fw_shared->sq.is_enabled = 1;
 
+		if (amdgpu_sriov_vf(adev))
+			fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
+
 		if (amdgpu_vcnfw_log)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	if (amdgpu_sriov_vf(adev)) {
+		r = amdgpu_virt_alloc_mm_table(adev);
+		if (r)
+			return r;
+	}
+
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v4_0_pause_dpg_mode;
 
@@ -169,6 +196,9 @@ static int vcn_v4_0_sw_fini(void *handle)
 		drm_dev_exit(idx);
 	}
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_free_mm_table(adev);
+
 	r = amdgpu_vcn_suspend(adev);
 	if (r)
 		return r;
@@ -191,18 +221,42 @@ static int vcn_v4_0_hw_init(void *handle)
 	struct amdgpu_ring *ring;
 	int i, r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (amdgpu_sriov_vf(adev)) {
+		r = vcn_v4_0_start_sriov(adev);
+		if (r)
+			goto done;
 
-		ring = &adev->vcn.inst[i].ring_enc[0];
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
 
-		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
+			ring = &adev->vcn.inst[i].ring_enc[0];
+			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
+				ring->sched.ready = false;
+				ring->no_scheduler = true;
+				dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
+			} else {
+				ring->wptr = 0;
+				ring->wptr_old = 0;
+				vcn_v4_0_unified_ring_set_wptr(ring);
+				ring->sched.ready = true;
+			}
+		}
+	} else {
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
 
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			goto done;
+			ring = &adev->vcn.inst[i].ring_enc[0];
+
+			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+					((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
+
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				goto done;
+
+		}
 	}
 
 done:
@@ -230,12 +284,14 @@ static int vcn_v4_0_hw_fini(void *handle)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-
-		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+		if (!amdgpu_sriov_vf(adev)) {
+			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
                         (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
                                 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
                         vcn_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+			}
 		}
+
 	}
 
 	return 0;
@@ -1107,6 +1163,214 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
+{
+	int i;
+	struct amdgpu_ring *ring_enc;
+	uint64_t cache_addr;
+	uint64_t rb_enc_addr;
+	uint64_t ctx_addr;
+	uint32_t param, resp, expected;
+	uint32_t offset, cache_size;
+	uint32_t tmp, timeout;
+
+	struct amdgpu_mm_table *table = &adev->virt.mm_table;
+	uint32_t *table_loc;
+	uint32_t table_size;
+	uint32_t size, size_dw;
+	uint32_t init_status;
+	uint32_t enabled_vcn;
+
+	struct mmsch_v4_0_cmd_direct_write
+		direct_wt = { {0} };
+	struct mmsch_v4_0_cmd_direct_read_modify_write
+		direct_rd_mod_wt = { {0} };
+	struct mmsch_v4_0_cmd_end end = { {0} };
+	struct mmsch_v4_0_init_header header;
+
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	volatile struct amdgpu_fw_shared_rb_setup *rb_setup;
+
+	direct_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_WRITE;
+	direct_rd_mod_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
+	end.cmd_header.command_type =
+		MMSCH_COMMAND__END;
+
+	header.version = MMSCH_VERSION;
+	header.total_size = sizeof(struct mmsch_v4_0_init_header) >> 2;
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
+		MMSCH_V4_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VCN, i,
+			regUVD_STATUS),
+			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
+
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo);
+			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi);
+			offset = 0;
+			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				regUVD_VCPU_CACHE_OFFSET0),
+				0);
+		} else {
+			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				lower_32_bits(adev->vcn.inst[i].gpu_addr));
+			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				upper_32_bits(adev->vcn.inst[i].gpu_addr));
+			offset = cache_size;
+			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+				regUVD_VCPU_CACHE_OFFSET0),
+				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
+		}
+
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			regUVD_VCPU_CACHE_SIZE0),
+			cache_size);
+
+		cache_addr = adev->vcn.inst[i].gpu_addr + offset;
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+			lower_32_bits(cache_addr));
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+			upper_32_bits(cache_addr));
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			regUVD_VCPU_CACHE_OFFSET1),
+			0);
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			regUVD_VCPU_CACHE_SIZE1),
+			AMDGPU_VCN_STACK_SIZE);
+
+		cache_addr = adev->vcn.inst[i].gpu_addr + offset +
+			AMDGPU_VCN_STACK_SIZE;
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+			lower_32_bits(cache_addr));
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+			upper_32_bits(cache_addr));
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			regUVD_VCPU_CACHE_OFFSET2),
+			0);
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			regUVD_VCPU_CACHE_SIZE2),
+			AMDGPU_VCN_CONTEXT_SIZE);
+
+		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+		rb_setup = &fw_shared->rb_setup;
+
+		ring_enc = &adev->vcn.inst[i].ring_enc[0];
+		ring_enc->wptr = 0;
+		rb_enc_addr = ring_enc->gpu_addr;
+
+		rb_setup->is_rb_enabled_flags |= RB_ENABLED;
+		rb_setup->rb_addr_lo = lower_32_bits(rb_enc_addr);
+		rb_setup->rb_addr_hi = upper_32_bits(rb_enc_addr);
+		rb_setup->rb_size = ring_enc->ring_size / 4;
+		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
+
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
+		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
+			regUVD_VCPU_NONCACHE_SIZE0),
+			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)));
+
+		/* add end packet */
+		MMSCH_V4_0_INSERT_END();
+
+		/* refine header */
+		header.inst[i].init_status = 0;
+		header.inst[i].table_offset = header.total_size;
+		header.inst[i].table_size = table_size;
+		header.total_size += table_size;
+	}
+
+	/* Update init table header in memory */
+	size = sizeof(struct mmsch_v4_0_init_header);
+	table_loc = (uint32_t *)table->cpu_addr;
+	memcpy((void *)table_loc, &header, size);
+
+	/* message MMSCH (in VCN[0]) to initialize this client
+	 * 1, write to mmsch_vf_ctx_addr_lo/hi register with GPU mc addr
+	 * of memory descriptor location
+	 */
+	ctx_addr = table->gpu_addr;
+	WREG32_SOC15(VCN, 0, regMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
+	WREG32_SOC15(VCN, 0, regMMSCH_VF_CTX_ADDR_HI, upper_32_bits(ctx_addr));
+
+	/* 2, update vmid of descriptor */
+	tmp = RREG32_SOC15(VCN, 0, regMMSCH_VF_VMID);
+	tmp &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
+	/* use domain0 for MM scheduler */
+	tmp |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
+	WREG32_SOC15(VCN, 0, regMMSCH_VF_VMID, tmp);
+
+	/* 3, notify mmsch about the size of this descriptor */
+	size = header.total_size;
+	WREG32_SOC15(VCN, 0, regMMSCH_VF_CTX_SIZE, size);
+
+	/* 4, set resp to zero */
+	WREG32_SOC15(VCN, 0, regMMSCH_VF_MAILBOX_RESP, 0);
+
+	/* 5, kick off the initialization and wait until
+	 * MMSCH_VF_MAILBOX_RESP becomes non-zero
+	 */
+	param = 0x00000001;
+	WREG32_SOC15(VCN, 0, regMMSCH_VF_MAILBOX_HOST, param);
+	tmp = 0;
+	timeout = 1000;
+	resp = 0;
+	expected = MMSCH_VF_MAILBOX_RESP__OK;
+	while (resp != expected) {
+		resp = RREG32_SOC15(VCN, 0, regMMSCH_VF_MAILBOX_RESP);
+		if (resp != 0)
+			break;
+
+		udelay(10);
+		tmp = tmp + 10;
+		if (tmp >= timeout) {
+			DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
+				" waiting for regMMSCH_VF_MAILBOX_RESP "\
+				"(expected=0x%08x, readback=0x%08x)\n",
+				tmp, expected, resp);
+			return -EBUSY;
+		}
+	}
+	enabled_vcn = amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, 0) ? 1 : 0;
+	init_status = ((struct mmsch_v4_0_init_header *)(table_loc))->inst[enabled_vcn].init_status;
+	if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE
+	&& init_status != MMSCH_VF_ENGINE_STATUS__PASS)
+		DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init "\
+			"status for VCN%x: 0x%x\n", resp, enabled_vcn, init_status);
+
+	return 0;
+}
+
 /**
  * vcn_v4_0_stop_dpg_mode - VCN stop with dpg mode
  *
@@ -1596,6 +1860,15 @@ static int vcn_v4_0_set_powergating_state(void *handle, enum amd_powergating_sta
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
 
+	/* for SRIOV, guest should not control VCN Power-gating
+	 * MMSCH FW should control Power-gating and clock-gating
+	 * guest should avoid touching CGC and PG
+	 */
+	if (amdgpu_sriov_vf(adev)) {
+		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
 	if(state == adev->vcn.cur_state)
 		return 0;
 
-- 
2.37.1

