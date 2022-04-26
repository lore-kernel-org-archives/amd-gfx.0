Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BC2C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1084510F0C6;
	Tue, 26 Apr 2022 18:27:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBEA10EF97
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbk0YP1f040wlty4Dsv76sV6z0bUgLr+p/Lsw1cEl9MdR1/58tjtIJQNUgzZ01hkqGY8YHJAuZ455yfUIpXN/lA3sBDgvIvityCkwQ49oC1/sWdozFDWsC4VIMeM6ZKiJA0YYrjgNe4LrppF6Zk48uns3MhV8LfXBYoAY+AdnM89yXDvUdUx+PuzGmgeQ8zhWsEjXVvZAaEiLU088NjeCPt7NBdU+67jOjvq/D+aaOkyt1OKGwl0W5YHzLQ44frTH+ewudZ6PsH0gBUGbAvpoPMLNuPe0oGdQchsGR2V0ocReeAnW29+EidSThPHRoRvKyHrKf6pb3rfzePojLo/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZr+D8oysf3Y9GT3teC5x+mutPOjkOKfyTQl3z/Sk0I=;
 b=HT707g0BKThl501MsaQRQJ2pxBkbd0J6wkfuMJ7c1jOfKxtGYj3JOjcgzFdihVNpbCJ8/G8N5u/DNzi0Exr0Ne2mg6ci+1JaBN3bkoBm8R464lBmg2GrcrYFp63TVL16FDvddB1nA66u/QJYXTJonH/s/IDYm4Ne/4kkIbP1yxV6XMgVKlwxjr3rjYY6sJEqmc4gvrWenMvHze6jbb1li/stL3Wwb6u5m4i9SrmvCx0wc8+eXg5mAPPMgN+KvUh+a+R2DDKACDgYaMXRpouPpC7toIteLyDn83QhfRrUm7k5DRCEGcG/uvFt40Ze5Gop3TVZ2lAFMXcACh4Phl/Oug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZr+D8oysf3Y9GT3teC5x+mutPOjkOKfyTQl3z/Sk0I=;
 b=yKir0HBIEjUvnTAoOCSVA7zMnuHtCqMy1rhDbtXfR/tfV4JYCjmPcv/98xdr6+r6vutIUSRtOC7jf6dSVt69f6yGlZvoQWXTB9a0PQm+0Cbi709BUYgwreCSZ5S0aGAZGYMPyopiC+LK+hnRzo35Ch1ez+woyN7OuThEIRVePHA=
Received: from BN9PR03CA0732.namprd03.prod.outlook.com (2603:10b6:408:110::17)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 18:27:41 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::28) by BN9PR03CA0732.outlook.office365.com
 (2603:10b6:408:110::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 26 Apr 2022 18:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:27:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:27:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/11] drm/amdgpu: update latest IP discovery table structures
Date: Tue, 26 Apr 2022 14:27:18 -0400
Message-ID: <20220426182728.3006737-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f8f6630-3b95-40dc-1707-08da27b27310
X-MS-TrafficTypeDiagnostic: LV2PR12MB5800:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5800ED91B0F2CDF7D5EA23D8F7FB9@LV2PR12MB5800.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HaLlW7Tk+zS7+NPyNvG0oI+16aHMhPIlbevMzLDCwLOMessWsiZj/oERe2A+ht7mKvumB8jhZeUjA2UT3YmCT0fFlZXzuIXrDpapVF1ewN+Hq97qj3z7U890pTm9FjOCICvFG3n+VAcVslSHfpZfabU8Y5M6qNYM8k78oLaMqW1KcMrChyClAvOLJFOA3u8+5d4rJKvHxs8xay9Ug5jaznRlqjKeTOsL0V5h664H1NMQ20c3HwRLdHAExp6+GcUBLTFr/XQ15JjQ9pNOC5bOMH2PrHdVIaFkHM9LPVoOZ0S/2pruxKdnjrsxzAQfIw+Uox8bR6RcdTYqBNcXy0BPyk38ZUsrkQ8UGVCqR2HG97z9BBqciyX+ekyWCpGBCDdFUZtCd85OegD8zjbAhNrAbZkZ+Plii/feraGr1GmB/NeOagDCbZ+t4wlFdJuUbmEX/tKRrh5rOv/hyFVZDwpsuLxDBicSy7rk19mxrgPk8KlBGT63+uRJa98dM4t5290XY8ngOONyMr27cLmKBpFoM8ELGvGKD2mTa8OuJjsxpR4DCOCMqLiHnIFxaXAECS87M9taJU4tlGr47tTxZfo0QvPJSXuUTjvLeH/XsfbO0pdFUB3c4qhNFvkcecxfOl7yjtweICkx0c2GalYdpO3sdnh3EGmk6JUjA7IDR/xIE+9THkx941ZhzXT8Nacl/4zavSlSmh1YyLZK63O2zk8Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(5660300002)(82310400005)(7696005)(70206006)(36860700001)(6666004)(4326008)(70586007)(2616005)(36756003)(316002)(2906002)(508600001)(8676002)(356005)(1076003)(336012)(83380400001)(40460700003)(186003)(16526019)(6916009)(47076005)(26005)(8936002)(426003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:27:41.3817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8f6630-3b95-40dc-1707-08da27b27310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add new tables.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/discovery.h | 114 +++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index b25026c3ec96..f150404ffc68 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -27,15 +27,19 @@
 #define PSP_HEADER_SIZE                 256
 #define BINARY_SIGNATURE                0x28211407
 #define DISCOVERY_TABLE_SIGNATURE       0x53445049
+#define GC_TABLE_ID                     0x4347
+#define HARVEST_TABLE_SIGNATURE         0x56524148
+#define VCN_INFO_TABLE_ID               0x004E4356
+#define MALL_INFO_TABLE_ID              0x4D414C4C
 
 typedef enum
 {
 	IP_DISCOVERY = 0,
 	GC,
 	HARVEST_INFO,
-	TABLE_4,
+	VCN_INFO,
+	MALL_INFO,
 	RESERVED_1,
-	RESERVED_2,
 	TOTAL_TABLES = 6
 } table;
 
@@ -96,6 +100,24 @@ typedef struct ip
 	uint32_t base_address[]; /* variable number of Addresses */
 } ip;
 
+typedef struct ip_v3
+{
+	uint16_t hw_id;                         /* Hardware ID */
+	uint8_t instance_number;                /* Instance number for the IP */
+	uint8_t num_base_address;               /* Number of base addresses*/
+	uint8_t major;                          /* Hardware ID.major version */
+	uint8_t minor;                          /* Hardware ID.minor version */
+	uint8_t revision;                       /* Hardware ID.revision version */
+#if defined(__BIG_ENDIAN)
+	uint8_t variant : 4;                    /* HW variant */
+	uint8_t sub_revision : 4;               /* HCID Sub-Revision */
+#else
+	uint8_t sub_revision : 4;               /* HCID Sub-Revision */
+	uint8_t variant : 4;                    /* HW variant */
+#endif
+	uint32_t base_address[1];               /* Base Address list. Corresponds to the num_base_address field*/
+} ip_v3;
+
 typedef struct die_header
 {
 	uint16_t die_id;
@@ -108,7 +130,11 @@ typedef struct ip_structure
 	struct die
 	{
 		die_header *die_header;
-		ip *ip_list;
+		union
+		{
+			ip *ip_list;
+			ip_v3 *ip_v3_list;
+		};                                  /* IP list. Variable size*/
 	} die;
 } ip_structure;
 
@@ -170,6 +196,40 @@ struct gc_info_v1_1 {
 	uint32_t gc_num_tcps;
 };
 
+struct gc_info_v1_2 {
+	struct gpu_info_header header;
+	uint32_t gc_num_se;
+	uint32_t gc_num_wgp0_per_sa;
+	uint32_t gc_num_wgp1_per_sa;
+	uint32_t gc_num_rb_per_se;
+	uint32_t gc_num_gl2c;
+	uint32_t gc_num_gprs;
+	uint32_t gc_num_max_gs_thds;
+	uint32_t gc_gs_table_depth;
+	uint32_t gc_gsprim_buff_depth;
+	uint32_t gc_parameter_cache_depth;
+	uint32_t gc_double_offchip_lds_buffer;
+	uint32_t gc_wave_size;
+	uint32_t gc_max_waves_per_simd;
+	uint32_t gc_max_scratch_slots_per_cu;
+	uint32_t gc_lds_size;
+	uint32_t gc_num_sc_per_se;
+	uint32_t gc_num_sa_per_se;
+	uint32_t gc_num_packer_per_sc;
+	uint32_t gc_num_gl2a;
+	uint32_t gc_num_tcp_per_sa;
+	uint32_t gc_num_sdp_interface;
+	uint32_t gc_num_tcps;
+	uint32_t gc_num_tcp_per_wpg;
+	uint32_t gc_tcp_l1_size;
+	uint32_t gc_num_sqc_per_wgp;
+	uint32_t gc_l1_instruction_cache_size_per_sqc;
+	uint32_t gc_l1_data_cache_size_per_sqc;
+	uint32_t gc_gl1c_per_sa;
+	uint32_t gc_gl1c_size_per_instance;
+	uint32_t gc_gl2c_per_gpu;
+};
+
 struct gc_info_v2_0 {
 	struct gpu_info_header header;
 
@@ -208,6 +268,54 @@ typedef struct harvest_table {
 	harvest_info list[32];
 } harvest_table;
 
+struct mall_info_header {
+	uint32_t table_id; /* table ID */
+	uint16_t version_major; /* table version */
+	uint16_t version_minor; /* table version */
+	uint32_t size_bytes; /* size of the entire header+data in bytes */
+};
+
+struct mall_info_v1_0 {
+	struct mall_info_header header;
+	uint32_t mall_size_per_m;
+	uint32_t m_s_present;
+	uint32_t m_half_use;
+	uint32_t m_mall_config;
+	uint32_t reserved[5];
+};
+
+#define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4
+
+struct vcn_info_header {
+    uint32_t table_id; /* table ID */
+    uint16_t version_major; /* table version */
+    uint16_t version_minor; /* table version */
+    uint32_t size_bytes; /* size of the entire header+data in bytes */
+};
+
+struct vcn_instance_info_v1_0
+{
+	uint32_t instance_num; /* VCN IP instance number. 0 - VCN0; 1 - VCN1 etc*/
+	union _fuse_data {
+		struct {
+			uint32_t av1_disabled : 1;
+			uint32_t vp9_disabled : 1;
+			uint32_t hevc_disabled : 1;
+			uint32_t h264_disabled : 1;
+			uint32_t reserved : 28;
+		} bits;
+		uint32_t all_bits;
+	} fuse_data;
+	uint32_t reserved[2];
+};
+
+struct vcn_info_v1_0 {
+	struct vcn_info_header header;
+	uint32_t num_of_instances; /* number of entries used in instance_info below*/
+	struct vcn_instance_info_v1_0 instance_info[VCN_INFO_TABLE_MAX_NUM_INSTANCES];
+	uint32_t reserved[4];
+};
+
 #pragma pack()
 
 #endif
-- 
2.35.1

