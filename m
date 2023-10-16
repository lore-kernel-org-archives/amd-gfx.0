Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0DFCDB465
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 16:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C498010E228;
	Mon, 16 Oct 2023 16:55:19 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA5610E225
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 16:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhnGGkfCpHGw21KpBd1SQCy4fHdASkJPgQcKx5IIiH4r4KdzXzl5orGXAd4uJgJB+Up/fOa67bLTwRJ0oIWy2+tBcPICy7toFQR1s1rjAtLML4ul/+wsbKWX5L2w+YT8reXA0aBpUwyKJ28tQ6/UPVrNJs7Nb8W1QJpaS6kKBfSjivGl1sSwqTSi9f0McSqbqA45PFdfuoQ97AObSBGnoJpwwbf35Mdr/Ei7GKUBGmXuiIwPZW3X+G2iln3BK+79yVMFIL80GlI3iDwC3dM2klW4t8dZujQhShRwOaRaUjL/Bj8OI76ZGYXj/PRJnQYU6XO6iEGxmBgslFXBYyla5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3WO38zpoS3djp3QStGAUmhhsM3SCtsaAL4YiUhk7lU=;
 b=C2jyhzFXGk7/u4viOz+9NWK2/YlMeVB7roXqGbZQDTNVK46w8H7mR+l/o1RZSrrKcjFhigWSDNAsKWdkq8RLVT/rJQyNXmXfdiAAbIpP41btYJSSoQTch+5A7Ue1Hs6RYAzsCdf6FEh9PdfC7qgAkN1U62Q1r2yjkqQzWQ2/67/ezECSzo6lrFJChnffy812MWBwTuMSjrsRsTyejZL+BDkTqkPYFyvrSBCHwy5fCcjIRmuJDjpuNX1KxYVIRJpO/k8f7QJnzK00HTzolMV2LgEGmp6XEXD5NSfuyOZ6OlBqxfn0MGy5dOWhnsabvy9y5eI4B6msB3U4ErWqJxlZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3WO38zpoS3djp3QStGAUmhhsM3SCtsaAL4YiUhk7lU=;
 b=u3Kek1FIfjHtmtOlmLPjSG2q9ItdXHqjg/R9gykgSZ67ztp1ZkfbayKD3mkSKKNW5RXhgvBSaTANnOO+1BUdzhfpz4bv8b8AGeA7vNQXAK+GmBoQnODftVtyfRb2zOoUi2n9IX2S9D0yVWj3Nj9O8lMTxiVIvzQsyp6Tj/O9AZ0=
Received: from MW4PR04CA0059.namprd04.prod.outlook.com (2603:10b6:303:6a::34)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 16:55:15 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::97) by MW4PR04CA0059.outlook.office365.com
 (2603:10b6:303:6a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 16:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 16:55:14 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 16 Oct 2023 11:55:13 -0500
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 4/4] drm/amd/amdgpu/vcn: Add RB decouple feature under
 SRIOV - P4
Date: Mon, 16 Oct 2023 12:54:38 -0400
Message-ID: <20231016165437.2865-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: e88f8bca-fce8-4dae-4a41-08dbce68ab31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CERDQfZ6Nf2adtsTtMKVQJyF+deUryQ+zCYRcaMsV34b6ykL2vzGcYBfAUcNZe9CsJh2+1kUzqZi/vgP35uy3sTDh5gUSeaFjHi9jfdMxdu3YrEfZABCv1oH9Y9s1oSZ5VkH9M1v1rpJYdDOJHk+gtMVbq7QdpsT6DAquo7AuTmo36VJcX657zzMDvQzKGavlfgSpNC8/cg6ctNYX/95LtD16AZ9r0dHxhX1uT8gDiLgEWYrpzrM/kZiQ+LhikwQv3Ry5usvLjmpX+YkOxRzWHpsLkAvuiimKy7uocMolDb3CR/PwfomeyBtA6cVqFQCakKfhBv2KJOGZI1UsPSU2yIyR9DaUEtGf8CMYm0tnZKLMT4ApjeAJSi/OIsaq9I8oTsjIUeqmzBY40SgVoL4WKbTTaP92ptJWDTdcdCt50HSRULQEWb1SSBXEu6uQ/DMrlv1tvdeRZxhwKbIF3W9ADs4iVqYA7/hlxC2nRiZrnNDuMzmosioLmO6ZAIfgcGmSSKfjogxyi5eqNbv4juCldInNEzldZKqpT9NhCblrTbu66h/Jzgw5P42AtrgBD2mRY8ZIU6vZ7P6HVOPV5FJ0SGBlUBCXavhMJ7xKFlqaNMmxQp2I6/lXtspZtSCIJcQlRGzTudDFSbGPs9nq0zzFTeWisyd90F7t5+AiBgLCI2A+ge4cgEBaRN6QW8d3RdEbBEmPgeslafD2XGV2aBRnbZopQb9ISGy3DcyUo2Q+jrXVxnx7XZqqL2rYToplg1O0lfh0OcMOx99LpR9h4NmOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(478600001)(6666004)(70586007)(70206006)(6916009)(356005)(83380400001)(47076005)(36860700001)(86362001)(1076003)(82740400003)(336012)(316002)(426003)(16526019)(26005)(7696005)(2616005)(36756003)(44832011)(41300700001)(81166007)(5660300002)(8936002)(8676002)(4326008)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 16:55:14.5705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e88f8bca-fce8-4dae-4a41-08dbce68ab31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
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
Cc: Bokun Zhang <bokun.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- In VCN 4 SRIOV code path, add code to enable RB decouple feature

Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 71 +++++++++++++++++++++------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 88e17f5e20b2..bf07aa200030 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -176,9 +176,6 @@ static int vcn_v4_0_sw_init(void *handle)
 				AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD_HANDSHAKING;
 		}
 
-		if (amdgpu_sriov_vf(adev))
-			fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
-
 		if (amdgpu_vcnfw_log)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
@@ -1209,6 +1206,24 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int vcn_v4_0_init_ring_metadata(struct amdgpu_device *adev, uint32_t vcn_inst, struct amdgpu_ring *ring_enc)
+{
+	struct amdgpu_vcn_rb_metadata *rb_metadata = NULL;
+	uint8_t *rb_ptr = (uint8_t *)ring_enc->ring;
+
+	rb_ptr += ring_enc->ring_size;
+	rb_metadata = (struct amdgpu_vcn_rb_metadata *)rb_ptr;
+
+	memset(rb_metadata, 0, sizeof(struct amdgpu_vcn_rb_metadata));
+	rb_metadata->size = sizeof(struct amdgpu_vcn_rb_metadata);
+	rb_metadata->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
+	rb_metadata->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_DECOUPLE_FLAG);
+	rb_metadata->version = 1;
+	rb_metadata->ring_id = vcn_inst & 0xFF;
+
+	return 0;
+}
+
 static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 {
 	int i;
@@ -1334,11 +1349,30 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 		rb_enc_addr = ring_enc->gpu_addr;
 
 		rb_setup->is_rb_enabled_flags |= RB_ENABLED;
-		rb_setup->rb_addr_lo = lower_32_bits(rb_enc_addr);
-		rb_setup->rb_addr_hi = upper_32_bits(rb_enc_addr);
-		rb_setup->rb_size = ring_enc->ring_size / 4;
 		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
 
+		if (amdgpu_sriov_is_vcn_rb_decouple(adev)) {
+			vcn_v4_0_init_ring_metadata(adev, i, ring_enc);
+
+			memset((void *)&rb_setup->rb_info, 0, sizeof(struct amdgpu_vcn_rb_setup_info) * MAX_NUM_VCN_RB_SETUP);
+			if (!(adev->vcn.harvest_config & (1 << 0))) {
+				rb_setup->rb_info[0].rb_addr_lo = lower_32_bits(adev->vcn.inst[0].ring_enc[0].gpu_addr);
+				rb_setup->rb_info[0].rb_addr_hi = upper_32_bits(adev->vcn.inst[0].ring_enc[0].gpu_addr);
+				rb_setup->rb_info[0].rb_size = adev->vcn.inst[0].ring_enc[0].ring_size / 4;
+			}
+			if (!(adev->vcn.harvest_config & (1 << 1))) {
+				rb_setup->rb_info[2].rb_addr_lo = lower_32_bits(adev->vcn.inst[1].ring_enc[0].gpu_addr);
+				rb_setup->rb_info[2].rb_addr_hi = upper_32_bits(adev->vcn.inst[1].ring_enc[0].gpu_addr);
+				rb_setup->rb_info[2].rb_size = adev->vcn.inst[1].ring_enc[0].ring_size / 4;
+			}
+			fw_shared->decouple.is_enabled = 1;
+			fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_DECOUPLE_FLAG);
+		} else {
+			rb_setup->rb_addr_lo = lower_32_bits(rb_enc_addr);
+			rb_setup->rb_addr_hi = upper_32_bits(rb_enc_addr);
+			rb_setup->rb_size = ring_enc->ring_size / 4;
+		}
+
 		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
 			regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
@@ -1810,6 +1844,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.extra_dw = sizeof(struct amdgpu_vcn_rb_metadata),
 	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
 	.set_wptr = vcn_v4_0_unified_ring_set_wptr,
@@ -2023,16 +2058,20 @@ static int vcn_v4_0_process_interrupt(struct amdgpu_device *adev, struct amdgpu_
 {
 	uint32_t ip_instance;
 
-	switch (entry->client_id) {
-	case SOC15_IH_CLIENTID_VCN:
-		ip_instance = 0;
-		break;
-	case SOC15_IH_CLIENTID_VCN1:
-		ip_instance = 1;
-		break;
-	default:
-		DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
-		return 0;
+	if (amdgpu_sriov_is_vcn_rb_decouple(adev)) {
+		ip_instance = entry->ring_id;
+	} else {
+		switch (entry->client_id) {
+		case SOC15_IH_CLIENTID_VCN:
+			ip_instance = 0;
+			break;
+		case SOC15_IH_CLIENTID_VCN1:
+			ip_instance = 1;
+			break;
+		default:
+			DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
+			return 0;
+		}
 	}
 
 	DRM_DEBUG("IH: VCN TRAP\n");
-- 
2.34.1

