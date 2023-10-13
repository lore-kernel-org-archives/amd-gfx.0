Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6524ACDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 15:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CC510E193;
	Fri, 13 Oct 2023 15:33:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9AC710E193
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 15:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BobZm3oSZ3p9w/oURq8IcX7IsJbJX5xcqM87KGt3Nnpqm7Hw5P1Zbexo27eZl2Yz3akaHP5oHC5kTrR4OeR/EsMJbbIxrSHGWYnaEVmlfrewtIQR7V3b/5My8YoH41Hwfyw6YVHcRKheG+yHPN7af6sNV+UtoPBe6rkBZJD3xcVda7NVOuAAl6ZZQwxdPQmME4JInd6iLfb7d0X69IdH0cAt/JvN2v8XJrOtLwQZpjBnWV2MedLGZL3/4g4w9Z2YWvEnSDpP9RXswumTWrGE5DSu+5GN7vc0VS3/MpK0jFGL1LYfRtRlP0fbTY8SyhmJEdTP5dmm78UYtDOo+g1OZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn/2+iqoz0zXa/XB03nPACJMzOIw8XcgjEUrXRjV4bM=;
 b=hy2mOOOuukacRjO9DwN5Lwq3CKfzcSr0ZO1d9i3yxoLpvcs0ygVzQluRnDszjx8/5n0gNBfNxohSbDDERGuo5b3VVN1T5xaId68YbS/qjiRBOylnOxT+lDNN1xOaCSKS58B96fc29LjBy7X+ez7Fg65+k/urPPzSUxlvFvWiCDPrLkf+JXTvGGkHxHqrAUaHOE6dlh1NHYzL1GLyh1IRB8JvWD+l89uDvN9hHrCkWxWOsvIie/crfIXKC4ti9peqGcQCFAI+FBDic81OsypwGi+005+pPTRF0AqcEgFvCPi2n+uqFYw3hOKjxpFfyWr1nMHPXsqoNzyIKkCuutBOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn/2+iqoz0zXa/XB03nPACJMzOIw8XcgjEUrXRjV4bM=;
 b=n8qTrnKAXwx2Npa87dj2+uQU2Bd/VzrxjKRXL8kQFNCW7a3hvneZcx7uGsTJnZFbxp0MU5VABX0nCP5NTAfm39QLhzNKir1kf2D+ZJsB3B/dt4kNKeYQiQN+KZ2uRWlrVaamu2vjDDYWB3Rvg+3z+33yPUt8Q4pQ/P5+TdhYL+0=
Received: from SJ0PR13CA0078.namprd13.prod.outlook.com (2603:10b6:a03:2c4::23)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 15:33:41 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::98) by SJ0PR13CA0078.outlook.office365.com
 (2603:10b6:a03:2c4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Fri, 13 Oct 2023 15:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:33:40 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 13 Oct 2023 10:33:39 -0500
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/amdgpu/vcn: Add RB decouple feature under SRIOV
Date: Fri, 13 Oct 2023 11:33:00 -0400
Message-ID: <20231013153259.4787-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|DM4PR12MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a76119-5a85-4c2f-2337-08dbcc01c6b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfokoIdTIP/pbkfBqxfKeFn6QYmnBGN7Lq5MP3Ald+I+I3+4Kj1+Chhdqv/r05uN4s+vpsN7r+ji7cb3mi+EldoxOuNGFjKjtD+45FvL1ZgTv22Kp49tVdKtutTojadXg6NQwNOISpSg4f7qnymjhUJa5Cq01ddU5VBeVFfGLxwFm6GvTKJCBRPTbd9gYGwoorhbOVskitZ1Vsvdv2lhQszusQRlhkliy5Nm3oBF3rrCSuMmom5GiwJ36SJB9/dV9MlGmHxrFNeLBfblMxLqdGSqO0MDFrDS2AqxwzPCrLXBQEywnr66OmUBmmhzYizfRiMGCnUzJAjvNqgeUPMzEbZFa2t8zdFDLeW/hTzkRt9R8muQovMoG5WD2Uh69tycT4zRQ4KuKazSyry+YwzgrnAx7sDSDXYrR/vxJTLl+YZYGb87FSPmBnhW4wOZRvtfyx1SDPku+p62hgAHxRbGknaXm7vYA1zGgBWv8ldtgJCIN1F9hZTWm1t8MYiduP8ke1fNPBdCDNUSGYebWsKyGhDuPjLheHlg5hbxO/hlfw5w0ChD3GLrVhtTiebBteSPdO4pPgVUUt+aesfECw7whSeN48IaKOn1VxbC21W8aeNe6dVUtaJJrhWd9KXxx+kywJJqAHN1wmYhwEdBnI5iaqNdqjXHFcRde/fXPhEkB9Y0vtSfVKTHyi9qiy4TxWSmqhIDTxXp2gG9IBdHmBupK2jZtFM6P51CBvU1ml3N8k9fwTxSxAVVrocshn85AoqDf7psozeKQigj9HwIi0y8rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(186009)(82310400011)(1800799009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(16526019)(47076005)(426003)(26005)(336012)(82740400003)(41300700001)(36756003)(83380400001)(2616005)(81166007)(1076003)(356005)(86362001)(36860700001)(6666004)(7696005)(2906002)(5660300002)(44832011)(40480700001)(6916009)(70586007)(70206006)(316002)(40460700003)(4326008)(478600001)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:33:40.2182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a76119-5a85-4c2f-2337-08dbcc01c6b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
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

- Add code to enable RB decouple feature.
  This feature is controlled by SRIOV host.
  Once enabled, it allows VCN0's job to be remapped to
  VCN1 at hardware level and improves VCN availability

Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h     | 52 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       | 71 ++++++++++++++++-----
 5 files changed, 110 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f4963330c772..7e8c2dbb34fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -204,6 +204,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		adev->vcn.inst[i].fw_shared.gpu_addr = adev->vcn.inst[i].gpu_addr +
 				bo_size - fw_shared_size;
 
+		/* clean up fw share */
+		memset(adev->vcn.inst[i].fw_shared.cpu_addr, 0, fw_shared_size);
+
 		adev->vcn.inst[i].fw_shared.mem_size = fw_shared_size;
 
 		if (amdgpu_vcnfw_log) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 0815c5a97564..6935ab74f481 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -169,6 +169,9 @@
 #define AMDGPU_VCN_SMU_VERSION_INFO_FLAG (1 << 11)
 #define AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG (1 << 11)
 #define AMDGPU_VCN_VF_RB_SETUP_FLAG (1 << 14)
+#define AMDGPU_VCN_VF_RB_DECOUPLE_FLAG (1 << 15)
+
+#define MAX_NUM_VCN_RB_SETUP 4
 
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
@@ -335,22 +338,46 @@ struct amdgpu_fw_shared {
 	struct amdgpu_fw_shared_smu_interface_info smu_interface_info;
 };
 
+struct amdgpu_vcn_rb_setup_info
+{
+    uint32_t  rb_addr_lo;
+    uint32_t  rb_addr_hi;
+    uint32_t  rb_size;
+};
+
 struct amdgpu_fw_shared_rb_setup {
 	uint32_t is_rb_enabled_flags;
-	uint32_t rb_addr_lo;
-	uint32_t rb_addr_hi;
-	uint32_t  rb_size;
-	uint32_t  rb4_addr_lo;
-	uint32_t  rb4_addr_hi;
-	uint32_t  rb4_size;
-	uint32_t  reserved[6];
+
+	union {
+		// 12 DWords
+		struct {
+			uint32_t rb_addr_lo;
+			uint32_t rb_addr_hi;
+			uint32_t  rb_size;
+			uint32_t  rb4_addr_lo;
+			uint32_t  rb4_addr_hi;
+			uint32_t  rb4_size;
+			uint32_t  reserved[6];
+		};
+
+		// 12 DWords
+		struct {
+			struct amdgpu_vcn_rb_setup_info rb_info[MAX_NUM_VCN_RB_SETUP];
+		};
+	};
 };
 
+
 struct amdgpu_fw_shared_drm_key_wa {
 	uint8_t  method;
 	uint8_t  reserved[3];
 };
 
+struct amdgpu_fw_shared_queue_decouple {
+    uint8_t  is_enabled;
+    uint8_t  reserved[7];
+};
+
 struct amdgpu_vcn4_fw_shared {
 	uint32_t present_flag_0;
 	uint8_t pad[12];
@@ -361,6 +388,8 @@ struct amdgpu_vcn4_fw_shared {
 	struct amdgpu_fw_shared_rb_setup rb_setup;
 	struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
 	struct amdgpu_fw_shared_drm_key_wa drm_key_wa;
+	uint8_t pad3[9];
+	struct amdgpu_fw_shared_queue_decouple decouple;
 };
 
 struct amdgpu_vcn_fwlog {
@@ -378,6 +407,15 @@ struct amdgpu_vcn_decode_buffer {
 	uint32_t pad[30];
 };
 
+struct amdgpu_vcn_rb_metadata {
+	uint32_t size;
+	uint32_t present_flag_0;
+
+	uint8_t version;
+	uint8_t ring_id;
+	uint8_t pad[26];
+};
+
 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
 #define VCN_BLOCK_DECODE_DISABLE_MASK 0x40
 #define VCN_BLOCK_QUEUE_DISABLE_MASK 0xC0
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index fabb83e9d9ae..858ef21ae515 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -126,6 +126,8 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_INDIRECT_REG_ACCESS = (1 << 5),
 	/* AV1 Support MODE*/
 	AMDGIM_FEATURE_AV1_SUPPORT = (1 << 6),
+	/* VCN RB decouple */
+	AMDGIM_FEATURE_VCN_RB_DECOUPLE = (1 << 7),
 };
 
 enum AMDGIM_REG_ACCESS_FLAG {
@@ -326,6 +328,8 @@ static inline bool is_virtual_machine(void)
 	((!amdgpu_in_reset(adev)) && (!adev->virt.tdr_debug))
 #define amdgpu_sriov_is_av1_support(adev) \
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_AV1_SUPPORT)
+#define amdgpu_sriov_is_vcn_rb_decouple(adev) \
+	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 104a5ad8397d..51a14f6d93bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -90,10 +90,11 @@ union amd_sriov_msg_feature_flags {
 		uint32_t host_load_ucodes  : 1;
 		uint32_t host_flr_vramlost : 1;
 		uint32_t mm_bw_management  : 1;
-		uint32_t pp_one_vf_mode	   : 1;
+		uint32_t pp_one_vf_mode    : 1;
 		uint32_t reg_indirect_acc  : 1;
 		uint32_t av1_support       : 1;
-		uint32_t reserved	   : 25;
+		uint32_t vcn_rb_decouple   : 1;
+		uint32_t reserved          : 24;
 	} flags;
 	uint32_t all;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 88e17f5e20b2..b1c1907b12f7 100644
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
+			memset(&rb_setup->rb_info, 0, sizeof(struct amdgpu_vcn_rb_setup_info) * MAX_NUM_VCN_RB_SETUP);
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

