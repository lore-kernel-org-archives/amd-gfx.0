Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05326CDB482
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 15:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BEBA10E191;
	Fri, 13 Oct 2023 15:30:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B74CF10E191
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 15:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eW/WLdGNjdBb+BBC+Y0IS7VqFkyxST0icZWM+G5c0GOwyRvCo8q55bq/gtXh091e5CDB1MjB2QuERoBDlRiST1bpeR1scvCkam9utDFN2Zp2BCUsLeELCXP2P6kDlnHauQTsfytvrQbXa3JzFHipUvigK5qtHvXy5KnWfzu2W0sUGP01QjHw7PD41bTQRh6V2H1r419bBvt7YDiCDloUCkp7ZFz8qRyhqShgv6VMfC47QEIEmMnKqbBo23aKZAP2PHWrX1I5xNHRvg7HtO2Tyy9REw6VPeYpyyC0dDo6f92MeIK2gXH54rNVUSatP58t3sIjmtkmgx/YzgxM1GF7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsjKTEsJbiBi7rKn7x52buUSKHYIETJ7uL9KG0MEbpc=;
 b=U9GUzm9j28EZR0R1T/lfoB2M5M17HF9LMn/fAaB+hRSTkFKO5uF23utVQXdV3ZNIARaK1f0wiGCMp7PlC5moqOONxdJFsBoARFyTVPQjMMT2UiBbv7aBBDq4DFfseUmQNu+iEuIgy6t8Kiqp+Qx0nsyTsvOz1b/HLL8Zu12ROgw3L/jcYicg2GLFpht/5AItoca+/Qo2+DHPA0UR7nlvTZ+V+Toe+8wcQtEBwwSAq4TAMYYK6p7OoZHdenNe/wWfnxKf8n+Wj8ObkR8rP9Ee8vkJb2gCEkHfI1/VzMdK4Kjev+U2cZw31z7vWMysogSMlqlSEkIGTi6b4nzf5PEXEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsjKTEsJbiBi7rKn7x52buUSKHYIETJ7uL9KG0MEbpc=;
 b=5CKA678GiLi7Cdrj5QQ5Mcs033lgWsRlMUyW4IlA9jRd6DLk6v83p5JPeLrIFx7sa7H7+D9vUKIwYNWTH9+4HKe59XL/wfQXEKyqZUFgwZ997lQWX7L6kkIg0Ncj8Dc1MSNYZSo5Wyen37cMF1ifnym+9gxWEv/SGljhX+Q9KME=
Received: from DM6PR07CA0094.namprd07.prod.outlook.com (2603:10b6:5:337::27)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 15:30:35 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::df) by DM6PR07CA0094.outlook.office365.com
 (2603:10b6:5:337::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 15:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:30:34 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 13 Oct 2023 10:30:29 -0500
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu/vcn: Add RB decouple feature under SRIOV
Date: Fri, 13 Oct 2023 11:30:05 -0400
Message-ID: <20231013153005.4711-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edf95ea-4ec0-4c50-fd85-08dbcc015832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjEMyUX3a5Swz6d5ygk15bZyImVWKZ+tcMRANa9WWAMqXTB+JazLlmoFsAhSErGiqasCkj7J+2evR2B4NTvc7gtFXA5IX2D9Cr0pz3q/ae9Q2Fjwu7QXZ7fyNeBFdU0JaOZpCji+LulnxA5QMrk91mvB7W8oRsg/2875Bx2aH5qdz4hziEHWSxsyzMs94efGViiXiJ8hvCwoE8mnUzX2tw0diz+eIGfE5OI3jD37aZELn/IG6dSGTey6Lz4lacO+1Sj1lrrHobZWhXrg96bO8uilDOlYquoy4YAo4KRwhs/rWQW56ByZVXhbIo646eYNXtTzguRkxhS95asMlOQXoE1+UfMRlLPjIVEMa2qT5r3wLwDs39wG08PgGOkQvc/wDBxMPeoMI7OtEtz6xm7jsZk/veUeYprJb9lxdZ9OpyB/2O1+tjsXkmeugKp2nZufEX3jM36Q550Oo7zJeSGlZOtrf/8s+RX3EofX+7kFgUATIfQQsQJdS+knDBuBNYrxGqWv2CJ2XRg3nVhcaiU5Auj2SV6N+ifs6lplOHl35oArPO+es6vyQh+DEF9OjH9zkJWc22POl0EI8dg8Zj8jC+jFuT7G0/X2XOGGOjGY1j3YDXhJkmrxQ0T4O6w/TdWyIvx8nXz6QNM5jj8km84a1J3cpKFCqTTK9/jILUf4tuPXZq2gfmBIDVwRFxmKcN7Gzzf9a32WO90J7E0evrDUjQ3FHc0jcBp5EGzYIvSltxk1VXd9j84DH//qs1Y8J0BM6j/rgKtFHLve11C/OF7hrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(16526019)(26005)(426003)(336012)(82740400003)(44832011)(70586007)(40480700001)(316002)(6916009)(36756003)(83380400001)(7696005)(70206006)(2616005)(86362001)(356005)(1076003)(47076005)(81166007)(36860700001)(40460700003)(478600001)(2906002)(6666004)(5660300002)(4326008)(8676002)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:30:34.8733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edf95ea-4ec0-4c50-fd85-08dbcc015832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
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
Change-Id: I3af7e126308e8fe4d2dc207c74e7671520037e65
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

