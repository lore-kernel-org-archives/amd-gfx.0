Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1294CDB474
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 16:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E80910E234;
	Mon, 16 Oct 2023 16:54:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 199C710E234
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 16:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+jwENbZvD+qSCXb2piSCZiaNO0F/TFc7gC7J5nXJzT0DBKk5XA6H7GP6e0FFRjGP1a8XIQjFcm7EuPdh9BKRNMFM1ntfw5YJpCiWuLqeJja33U5qNZYP1jniCBK2FimzgynsOqwcrOdUwBcivoL32dkzL5//m8wkhqxq1YkMNsrez9Fmdg4YNhsfj7+Zc8+oSOgAvtVSonXBsWzB0uEBlUpbkO1s7XQ/ufJbokWN/Dy0qQ4j0Wrseoogty44J8I7x8zZsr8rxEciAm2KiuVdIQzw8WHCv6fFUpgPwtHk81Iy9HN3za06BbU5i30mmv3f8R1wPVCrZdeRy/wfS7/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdceG9AdVkU/wOMf//R5kQOoT6t5IOsobLdkBf4mgW8=;
 b=i/3hFic2FKzFZj84vL25JJ0r2x1kxJf5xHFsnT5NDDJ8Ey3KEBU/YX8GiNV3itjQEbJH+FMOlFLW6U5ji/ui2dCTezi2iNGvD2I6/pHduJ6vyICrTvmde2vc0Zq000Gbx/HYYUJVTeuocws2oPRoO+EVVa0+yAVpPyi6//kKihWOPt2DkBw+BnRqSWYqWfyQhrycFGDoiVTo29pzefUpx48K/2DFrN3Wboghw3P61xeSFbAbV/yEm/hVp+3NpjwL31GmyisIImqeMRXtfv5+kaMlmB/kYbJ4ao8zU9qlvdnuoX3Zm5YYuLdC9YD3i4obxMFKNui0fLtCoMhzhjJS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdceG9AdVkU/wOMf//R5kQOoT6t5IOsobLdkBf4mgW8=;
 b=bq2ibBRtB+TAvyNO/PdcFr3alNBhSuR+o+gyQwJzYdXSEbEtQcHLSVvVmCjxenQ3KJ35He/7rjdU3qmL1WGLxf7BRm3GpxLAzJIXIQ4E4T6ziXdfrd9mTtcVe/sTaRoxCtOG3A+5OPrNTGq3L6kouocoERUssmDDBTmEWMPzvB0=
Received: from SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::24)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 16:54:31 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::32) by SJ0P220CA0012.outlook.office365.com
 (2603:10b6:a03:41b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Mon, 16 Oct 2023 16:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 16:54:31 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 16 Oct 2023 11:54:30 -0500
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 3/4] drm/amd/amdgpu/vcn: Add RB decouple feature under
 SRIOV - P3
Date: Mon, 16 Oct 2023 12:54:11 -0400
Message-ID: <20231016165410.2835-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 897dcce8-ac25-4c1c-1290-08dbce689195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U5dcfWXWt0jEzv1oRpM5FlR/bugvt30SNwH3zi2Q/F9vC88qhvsUoCanaN/wskF1XIl7WcCTgqOEj+OmJE6OGrIPdqFLiPgRyfRMwuW3r3xhaILoJSuAMtZK+A0HjTrxFdjSsQXCu3UQdAxA/g8qrnpmD6q14RsY/+x/YS16LPRpHpWgb89C+d7yZkQd8STbywhitDP5SAy2aKxyqTqznGoyTcTea0oharTOOAWp0hrYGkuDsS1AGO7KLE7luPOB28RBPgki4GO+c1BriXDS0jYYOBgS8TgBhhKzOsPGI1B8TPltxDggQEYKpAZXdWVkolN6nplmK+13TjCCIxr9NGu+/PAbVU1R8agRAideA1ZBligDT9Gqc8Akn3ioa8JrMr2LB+LzptRSErJuP/6ACusza8ReKJd+eOqjn4t9zKvixp653GdmHlzFlj8waQOdIY43ejstBAoUqiMiSIFOb81wqZtcecBk3LBOMTl5Pqz0kO7+nthMdWXbgwub8XlXof1DBC++22UsnfgAdROeJsqRGbUK5AbEnm8u36dOxLcubYOLNAtOybzNZ97q5+K5AKxThY2fOm8lWN7Bzvg2T6aCpmcQIKkoiEUu7XVhC0Wny2sSF7XBIG2jV7jhpIQi4wP7uw3bdDpXwWVWey6G5wTd6jSFiG8seZx0nA/MC9F82WogCYgPLH6NMSJdUcaDCOYfK3oNf0ffsmqwtvcwhCqCK0+fxYqr1QlKK9DrzGb5eC8jIX/aticweTsSbVGfCJLdWVtJQpvPWy6e6wxIZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(426003)(26005)(2616005)(1076003)(336012)(16526019)(83380400001)(40460700003)(36860700001)(86362001)(47076005)(40480700001)(478600001)(36756003)(5660300002)(70586007)(41300700001)(2906002)(8676002)(8936002)(4326008)(316002)(6916009)(44832011)(70206006)(7696005)(6666004)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 16:54:31.5881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 897dcce8-ac25-4c1c-1290-08dbce689195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466
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

- Update VCN header for RB decouple feature
- Add metadata struct, metadata will be placed after each RB

Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 50 +++++++++++++++++++++----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 0815c5a97564..0702ffc1d20e 100644
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
@@ -335,22 +338,44 @@ struct amdgpu_fw_shared {
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
@@ -361,6 +386,8 @@ struct amdgpu_vcn4_fw_shared {
 	struct amdgpu_fw_shared_rb_setup rb_setup;
 	struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
 	struct amdgpu_fw_shared_drm_key_wa drm_key_wa;
+	uint8_t pad3[9];
+	struct amdgpu_fw_shared_queue_decouple decouple;
 };
 
 struct amdgpu_vcn_fwlog {
@@ -378,6 +405,15 @@ struct amdgpu_vcn_decode_buffer {
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
-- 
2.34.1

