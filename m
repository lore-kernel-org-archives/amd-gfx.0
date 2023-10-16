Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EB1CDB465
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 18:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84FC10E0BB;
	Mon, 16 Oct 2023 18:11:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 194E710E0BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 18:11:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZzeNzkw/AGAKxFoQtq1Zabub0/0bgZFSOj9XdW2sX/KziPkH0Vf4o/5hFfvDR6Olb40KZ4XVVj/RfLNEtYxNm7IQBfWqxwh0P2NVU8uskCZYMSw7oRvC3PlkjH9L1r6PbgZS36opKLcJxXwF8uM7HrwXgFwCY2Eh0DvKSIzlQUpOcLZVOSvHwxhqrnk2GybxLBE5qKJ8FuX8HMT+LT5gG0kkdR7dWAIJ+YRKAwZlAquVGOAZ7tRf/DgDFdOIcC9gYmTOfwUgV4y0k0r9DWBBjUcV8CtOcshqW4tS1kWaumqWdCcETs/5QqrZmBayEXqrRwEVD3u+K5y9D5MeFCiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJ1IuMG5iI5+V6GGOkIqEQQR/5tY8rhQxZaJBvnOJAA=;
 b=M7tHWL7212CyhROYodMK/e8qFPwS0RnsEddWgwiEVBPI9NqtsqhhohwUID/fifyKijgHq887OYnayqBEpyMyJWult2Jc+srCCr3RxtH8E+fF7VrNJklTaP/zEDQsUB0rGbvGmSbv7VYglNaXmg7wLVg56h1OoIfzkl5nFr6+JrX7DiBPxHOiLlQ25OmmrLoAaG8hhx+3HhNGSkuOdE81kR5FlKxNpOlnUCxwPnVngnwOC3hfYvU6TL1U2ltBIZ/FME5ntGZda55vx5+0wnG+lMjwE/hL1egYd4WHzGIUNz/KSrMc+vs00BrspqMxqhn5EQijvi+mfjRCgyHQXkopMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJ1IuMG5iI5+V6GGOkIqEQQR/5tY8rhQxZaJBvnOJAA=;
 b=Rfyf75P+TrCNl5EbeOXIPFJpYCOqNIxgcYR+/qByXrusL50Fu8U1D0YI2s4uRm4iWvvQJgnux9JTORqHWGFO2dx+OPgyAHTUi6V3iVds9SqNU6xZ1UmLwIW67dhlb+wzotk94mhESlknxspwqMefeDpNox6ukSv0tuPz7hSfIoI=
Received: from CH0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:76::35)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Mon, 16 Oct
 2023 18:11:39 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::8d) by CH0PR04CA0030.outlook.office365.com
 (2603:10b6:610:76::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Mon, 16 Oct 2023 18:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 18:11:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 13:11:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update to the latest GC 11.5 headers
Date: Mon, 16 Oct 2023 14:11:24 -0400
Message-ID: <20231016181124.2235387-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 920fbbbb-c212-414b-5d4a-08dbce7357a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3JAiADpzKkgF7ziMHgvRjnnSXNlvv9RQek6TYOH6mzmRaJELs1D005W/BroCGkoFDPm03f71QFL1+wvIAz2EkzYoP2xVUlIkxn8l0B2CAsw/cBgDvM1LPPysm7lEEvwZ9QTe48l0OJifqTHUHWzobOd48RMeoxbE1llxG87D99Iwd9u7/NWuBoEbDW8bYhaIloLc/OHKQLgjfQwvHfxQoJAw7WHQXKtZl9VUWdaZqw8YJKHBoncQSCvT6YTFX0fJE+dSTqw1CQg/0LsQFE/0Mn5pyJXBGugbWzir9ZYtoa9/BBcoleipr4iZsFeoNNt1+xl0Jd1nNWzl7ejo5odFsIseFFBCMre9BUhlFAzGji/N9rMiWE8ICPa2pMRpgnwGweWAfk+9ADfnD4HFBzbKc2eoKgfE29/DhNQwE7OEDAWwwwkhJSp1vo7A5++ZE5u1bcYrtZo/Z5iDtSqRGhqiZ/0JLW8WrxZT0Y1blL+UqZfnIdWFpoBHfRWfR0D+jFLUpMdf47hmGNJo/YQ7dcbjbItRi4Lq+R1DyCX7jBsGWCo3YPnquxryo2ZRqIU5+JVSej/bNyhSDBadj1iZTyGBP59v6U8Nf/mEW/QoF1k7LXCStVK2uiPsiIk45IpT+rQR78yplFTzPB316eL8WNzFnw903P2W1qzB0kiW/ldStpdMhHWfBhjVlsjjDGrlvYC8b8Y17nPMw+R6WZypU23NPvp5lQWKUPQ8PIcE/LwzEk0G+d7/r2PtUUmEQyXL7qq3exl7lcrX3R+XB1E7Q4LAig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(478600001)(70206006)(70586007)(6916009)(6666004)(83380400001)(47076005)(36860700001)(82740400003)(86362001)(316002)(7696005)(2616005)(26005)(426003)(336012)(16526019)(1076003)(36756003)(5660300002)(2906002)(356005)(8936002)(30864003)(41300700001)(4326008)(81166007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 18:11:38.8873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 920fbbbb-c212-414b-5d4a-08dbce7357a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
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

Add some additional bitfields.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/gc/gc_11_5_0_sh_mask.h   | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_sh_mask.h
index 3404bf10428d..f10e5d1f592b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_sh_mask.h
@@ -19227,6 +19227,9 @@
 #define CB_COLOR0_FDCC_CONTROL__FDCC_ENABLE__SHIFT                                                            0x16
 #define CB_COLOR0_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT                                                   0x17
 #define CB_COLOR0_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT                                              0x18
+#define CB_COLOR0_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT                                     0x19
+#define CB_COLOR0_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT                                          0x1a
+#define CB_COLOR0_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                                                         0x1b
 #define CB_COLOR0_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK                                              0x00000001L
 #define CB_COLOR0_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK                                            0x00000002L
 #define CB_COLOR0_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK                                              0x0000000CL
@@ -19241,6 +19244,9 @@
 #define CB_COLOR0_FDCC_CONTROL__FDCC_ENABLE_MASK                                                              0x00400000L
 #define CB_COLOR0_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                                                     0x00800000L
 #define CB_COLOR0_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK                                                0x01000000L
+#define CB_COLOR0_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK                                       0x02000000L
+#define CB_COLOR0_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK                                            0x04000000L
+#define CB_COLOR0_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                                                           0x38000000L
 //CB_COLOR0_DCC_BASE
 #define CB_COLOR0_DCC_BASE__BASE_256B__SHIFT                                                                  0x0
 #define CB_COLOR0_DCC_BASE__BASE_256B_MASK                                                                    0xFFFFFFFFL
@@ -19301,6 +19307,9 @@
 #define CB_COLOR1_FDCC_CONTROL__FDCC_ENABLE__SHIFT                                                            0x16
 #define CB_COLOR1_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT                                                   0x17
 #define CB_COLOR1_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT                                              0x18
+#define CB_COLOR1_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT                                     0x19
+#define CB_COLOR1_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT                                          0x1a
+#define CB_COLOR1_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                                                         0x1b
 #define CB_COLOR1_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK                                              0x00000001L
 #define CB_COLOR1_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK                                            0x00000002L
 #define CB_COLOR1_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK                                              0x0000000CL
@@ -19315,6 +19324,9 @@
 #define CB_COLOR1_FDCC_CONTROL__FDCC_ENABLE_MASK                                                              0x00400000L
 #define CB_COLOR1_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                                                     0x00800000L
 #define CB_COLOR1_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK                                                0x01000000L
+#define CB_COLOR1_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK                                       0x02000000L
+#define CB_COLOR1_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK                                            0x04000000L
+#define CB_COLOR1_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                                                           0x38000000L
 //CB_COLOR1_DCC_BASE
 #define CB_COLOR1_DCC_BASE__BASE_256B__SHIFT                                                                  0x0
 #define CB_COLOR1_DCC_BASE__BASE_256B_MASK                                                                    0xFFFFFFFFL
@@ -19375,6 +19387,9 @@
 #define CB_COLOR2_FDCC_CONTROL__FDCC_ENABLE__SHIFT                                                            0x16
 #define CB_COLOR2_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT                                                   0x17
 #define CB_COLOR2_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT                                              0x18
+#define CB_COLOR2_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT                                     0x19
+#define CB_COLOR2_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT                                          0x1a
+#define CB_COLOR2_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                                                         0x1b
 #define CB_COLOR2_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK                                              0x00000001L
 #define CB_COLOR2_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK                                            0x00000002L
 #define CB_COLOR2_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK                                              0x0000000CL
@@ -19389,6 +19404,9 @@
 #define CB_COLOR2_FDCC_CONTROL__FDCC_ENABLE_MASK                                                              0x00400000L
 #define CB_COLOR2_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                                                     0x00800000L
 #define CB_COLOR2_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK                                                0x01000000L
+#define CB_COLOR2_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK                                       0x02000000L
+#define CB_COLOR2_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK                                            0x04000000L
+#define CB_COLOR2_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                                                           0x38000000L
 //CB_COLOR2_DCC_BASE
 #define CB_COLOR2_DCC_BASE__BASE_256B__SHIFT                                                                  0x0
 #define CB_COLOR2_DCC_BASE__BASE_256B_MASK                                                                    0xFFFFFFFFL
@@ -19449,6 +19467,9 @@
 #define CB_COLOR3_FDCC_CONTROL__FDCC_ENABLE__SHIFT                                                            0x16
 #define CB_COLOR3_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT                                                   0x17
 #define CB_COLOR3_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT                                              0x18
+#define CB_COLOR3_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT                                     0x19
+#define CB_COLOR3_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT                                          0x1a
+#define CB_COLOR3_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                                                         0x1b
 #define CB_COLOR3_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK                                              0x00000001L
 #define CB_COLOR3_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK                                            0x00000002L
 #define CB_COLOR3_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK                                              0x0000000CL
@@ -19463,6 +19484,9 @@
 #define CB_COLOR3_FDCC_CONTROL__FDCC_ENABLE_MASK                                                              0x00400000L
 #define CB_COLOR3_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                                                     0x00800000L
 #define CB_COLOR3_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK                                                0x01000000L
+#define CB_COLOR3_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK                                       0x02000000L
+#define CB_COLOR3_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK                                            0x04000000L
+#define CB_COLOR3_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                                                           0x38000000L
 //CB_COLOR3_DCC_BASE
 #define CB_COLOR3_DCC_BASE__BASE_256B__SHIFT                                                                  0x0
 #define CB_COLOR3_DCC_BASE__BASE_256B_MASK                                                                    0xFFFFFFFFL
@@ -19523,6 +19547,9 @@
 #define CB_COLOR4_FDCC_CONTROL__FDCC_ENABLE__SHIFT                                                            0x16
 #define CB_COLOR4_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT                                                   0x17
 #define CB_COLOR4_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT                                              0x18
+#define CB_COLOR4_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT                                     0x19
+#define CB_COLOR4_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT                                          0x1a
+#define CB_COLOR4_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                                                         0x1b
 #define CB_COLOR4_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK                                              0x00000001L
 #define CB_COLOR4_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK                                            0x00000002L
 #define CB_COLOR4_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK                                              0x0000000CL
@@ -19537,6 +19564,9 @@
 #define CB_COLOR4_FDCC_CONTROL__FDCC_ENABLE_MASK                                                              0x00400000L
 #define CB_COLOR4_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                                                     0x00800000L
 #define CB_COLOR4_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK                                                0x01000000L
+#define CB_COLOR4_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK                                       0x02000000L
+#define CB_COLOR4_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK                                            0x04000000L
+#define CB_COLOR4_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                                                           0x38000000L
 //CB_COLOR4_DCC_BASE
 #define CB_COLOR4_DCC_BASE__BASE_256B__SHIFT                                                                  0x0
 #define CB_COLOR4_DCC_BASE__BASE_256B_MASK                                                                    0xFFFFFFFFL
@@ -19597,6 +19627,9 @@
 #define CB_COLOR5_FDCC_CONTROL__FDCC_ENABLE__SHIFT                                                            0x16
 #define CB_COLOR5_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT                                                   0x17
 #define CB_COLOR5_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT                                              0x18
+#define CB_COLOR5_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT                                     0x19
+#define CB_COLOR5_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT                                          0x1a
+#define CB_COLOR5_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                                                         0x1b
 #define CB_COLOR5_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK                                              0x00000001L
 #define CB_COLOR5_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK                                            0x00000002L
 #define CB_COLOR5_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK                                              0x0000000CL
@@ -19611,6 +19644,9 @@
 #define CB_COLOR5_FDCC_CONTROL__FDCC_ENABLE_MASK                                                              0x00400000L
 #define CB_COLOR5_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                                                     0x00800000L
 #define CB_COLOR5_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK                                                0x01000000L
+#define CB_COLOR5_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK                                       0x02000000L
+#define CB_COLOR5_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK                                            0x04000000L
+#define CB_COLOR5_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                                                           0x38000000L
 //CB_COLOR5_DCC_BASE
 #define CB_COLOR5_DCC_BASE__BASE_256B__SHIFT                                                                  0x0
 #define CB_COLOR5_DCC_BASE__BASE_256B_MASK                                                                    0xFFFFFFFFL
@@ -19671,6 +19707,9 @@
 #define CB_COLOR6_FDCC_CONTROL__FDCC_ENABLE__SHIFT                                                            0x16
 #define CB_COLOR6_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT                                                   0x17
 #define CB_COLOR6_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT                                              0x18
+#define CB_COLOR6_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT                                     0x19
+#define CB_COLOR6_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT                                          0x1a
+#define CB_COLOR6_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                                                         0x1b
 #define CB_COLOR6_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK                                              0x00000001L
 #define CB_COLOR6_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK                                            0x00000002L
 #define CB_COLOR6_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK                                              0x0000000CL
@@ -19685,6 +19724,9 @@
 #define CB_COLOR6_FDCC_CONTROL__FDCC_ENABLE_MASK                                                              0x00400000L
 #define CB_COLOR6_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                                                     0x00800000L
 #define CB_COLOR6_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK                                                0x01000000L
+#define CB_COLOR6_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK                                       0x02000000L
+#define CB_COLOR6_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK                                            0x04000000L
+#define CB_COLOR6_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                                                           0x38000000L
 //CB_COLOR6_DCC_BASE
 #define CB_COLOR6_DCC_BASE__BASE_256B__SHIFT                                                                  0x0
 #define CB_COLOR6_DCC_BASE__BASE_256B_MASK                                                                    0xFFFFFFFFL
@@ -19745,6 +19787,9 @@
 #define CB_COLOR7_FDCC_CONTROL__FDCC_ENABLE__SHIFT                                                            0x16
 #define CB_COLOR7_FDCC_CONTROL__DCC_COMPRESS_DISABLE__SHIFT                                                   0x17
 #define CB_COLOR7_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE__SHIFT                                              0x18
+#define CB_COLOR7_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS__SHIFT                                     0x19
+#define CB_COLOR7_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE__SHIFT                                          0x1a
+#define CB_COLOR7_FDCC_CONTROL__MAX_COMP_FRAGS__SHIFT                                                         0x1b
 #define CB_COLOR7_FDCC_CONTROL__SAMPLE_MASK_TRACKER_DISABLE_MASK                                              0x00000001L
 #define CB_COLOR7_FDCC_CONTROL__SAMPLE_MASK_TRACKER_FEA_FORCE_MASK                                            0x00000002L
 #define CB_COLOR7_FDCC_CONTROL__MAX_UNCOMPRESSED_BLOCK_SIZE_MASK                                              0x0000000CL
@@ -19759,6 +19804,9 @@
 #define CB_COLOR7_FDCC_CONTROL__FDCC_ENABLE_MASK                                                              0x00400000L
 #define CB_COLOR7_FDCC_CONTROL__DCC_COMPRESS_DISABLE_MASK                                                     0x00800000L
 #define CB_COLOR7_FDCC_CONTROL__FRAGMENT_COMPRESS_DISABLE_MASK                                                0x01000000L
+#define CB_COLOR7_FDCC_CONTROL__DISABLE_OVERRIDE_INCONSISTENT_KEYS_MASK                                       0x02000000L
+#define CB_COLOR7_FDCC_CONTROL__ENABLE_MAX_COMP_FRAG_OVERRIDE_MASK                                            0x04000000L
+#define CB_COLOR7_FDCC_CONTROL__MAX_COMP_FRAGS_MASK                                                           0x38000000L
 //CB_COLOR7_DCC_BASE
 #define CB_COLOR7_DCC_BASE__BASE_256B__SHIFT                                                                  0x0
 #define CB_COLOR7_DCC_BASE__BASE_256B_MASK                                                                    0xFFFFFFFFL
-- 
2.41.0

