Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E53C5ACB3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 07:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE14010E262;
	Tue, 21 Nov 2023 07:34:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001C610E262
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 07:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTjbJMzylmu2KrsD3wj24PHH0q5cxxBMXiI+YX2nmZoCKJPIWLqN3wIWQCQyNqfGpIOn2KsLEna77MwlBgD8sHRWXQJoN/n0GmJNEbbIWR9Rr085x4AWlEGj+VicWU0pJ34zzR/QztiyJRO9CNKHhaPaTxSei2t4A6Y6hfT7u2k+YWJBi0p8WwwhkynC/qGKN7mbdT9nLdCPAb8L+VlfvV1zHU/qtN9ogZysf6GAIsDgeZZzzS0R5dlmgqGnsyZwktRCFxpWZyHA4exWBHyFut1vAYGVuVEjQRtCbTMPPZqCGsKBCekovV39LZbupo+udX478TTY17ykcV6dYgsSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw7NkSmKhPWWyqXUzq+HpT2PDz/+GuPQ07wtNEWQOkM=;
 b=XpOc7ltdo+rAVKJ6xY8DO5Im95MPOMgYKbU+Hb0uqanbutVDYCRu8YI/g7uNQHtOcf36jNLJFLia62L4falUQ07yloSapa6m/GmuuEa2XWPcm3FJG8jNFB6CO01ftlGtEME1b9xAw1kheOXZqnDuHjkQraGR/v6c7nhn5ZBzYZbStgzw+a40uYr7GXCU4LCddhpmxSTiKPNLPLNJhAs4d1SSYWGR/u5ggN3fIWBnC5cscgZTO6FZdLB/FJ2UnTDXDJFz1w9n/WpDc7drsgr1urrieOlVI6Vc5UpH2VA+iUOfeJ5uSbUJSStqhvTfpsTG3mVr7aqDwAHvnA0hvvP0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw7NkSmKhPWWyqXUzq+HpT2PDz/+GuPQ07wtNEWQOkM=;
 b=s0MRE1wN/uAxbpQ4h5+bQFF1zViF6PvoBMEMzqbBck72wlzTnh7Qul/vTcbvmmu5ildlaHWDfW3H2dH8sSXk4c2Gm25FdE0nFpJYHDJoMnel3DfN+Qe0DpFRz3rv+JBafE2yKKftmoWwVio12XG4aG/O3u42FtSxSdgnXAlSx1Q=
Received: from BLAPR03CA0170.namprd03.prod.outlook.com (2603:10b6:208:32f::17)
 by SA3PR12MB8810.namprd12.prod.outlook.com (2603:10b6:806:31f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 07:34:01 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::24) by BLAPR03CA0170.outlook.office365.com
 (2603:10b6:208:32f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 07:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 07:34:01 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 01:33:27 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/6] drm/amdgpu: update lsdma headers
Date: Tue, 21 Nov 2023 15:30:11 +0800
Message-ID: <20231121073014.2984557-4-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231121073014.2984557-1-yifan1.zhang@amd.com>
References: <20231121073014.2984557-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SA3PR12MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: e726daac-be94-440a-1620-08dbea643b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBNQGUnl1/b3DmBexp9MWJs4m/MivBgMAG8JDMXL4Wq3AUBvGNs8TZetCw6C3yn4ucOWGHi7jWrUEhryjewZUYn37MWF/AObybVB/eJcNtjkWNEi/uWCCmU3X3ZJra7b0v7yAINJi9rhtTf6A0CgRmFYOrjC9i2SH08p2kFu8vCb0lm8kdbKCATQqhYO4xsAcW9aNVwS8TfMhObL2HA4yx0tof4RRInv9xWTSnsQEpLwV/r+uMKFWtzJkkElE4cOv47+o7jbAcwd7VBoTKPrm5NveVaNqwjoe/L9eMP5t3wrGaqQFkdBWE3sQpmm/zhhbdsbyVII1vpTHoRiwo9TnY5JrOPtdGWXKZunYCivSdeefKaiQNpx4advWt+r0wAOoV7UNoOhSYwG+sZNjpEoJhstjb0oMD1OYJgTA+cyozc/cRW1Hik6IYRkqx1JQOuXqSiw1myksj6LEtr1BQyFkz89z32LUH+1ADS1sntMgKLb1rOvlGnS63qJu2i6XkpgsN6fCM7fLUzG+1kbFwetvkt5i+yddlDHGN2rDofdSyNpwhzfCeg7wAfyxQi9aED59vaNgcowu0hjRcbasktB2QiyVXaWUr1X8OQZU565VbLBF7B1q7YsHRpI/tMdMwCeYIyMeUe6Z+NU4+3d+cAwkA62ady0fGM9wi0x+kKGBmpzS16xzQYUVeo2xBkSfy0uoUFers84GK1j1kbsY7IT0fDtTtdwEf6AwZgDcoMXAVBC80LGk1xz0+AvyeKC1406YOkxDeyiWKysBYS6O7KLJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(70586007)(70206006)(6916009)(54906003)(316002)(478600001)(40460700003)(6666004)(15650500001)(5660300002)(86362001)(41300700001)(36756003)(2906002)(4326008)(8936002)(8676002)(2616005)(1076003)(26005)(16526019)(81166007)(83380400001)(40480700001)(47076005)(36860700001)(356005)(82740400003)(336012)(426003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:34:01.0930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e726daac-be94-440a-1620-08dbea643b0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8810
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Alexander.Deucher@amd.com, Lang Yu <lang.yu@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to update lsdma headers.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Lang Yu <lang.yu@amd.com>
---
 .../drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h    | 2 ++
 .../drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h   | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h
index af560359e340..977997d27c32 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h
@@ -57,6 +57,8 @@
 #define regLSDMA_HBM_PAGE_CONFIG_BASE_IDX                                                               0
 #define regLSDMA_UCODE_CHECKSUM                                                                         0x0029
 #define regLSDMA_UCODE_CHECKSUM_BASE_IDX                                                                0
+#define regLSDMA_F32_CNTL                                                                               0x002a
+#define regLSDMA_F32_CNTL_BASE_IDX                                                                      0
 #define regLSDMA_FREEZE                                                                                 0x002b
 #define regLSDMA_FREEZE_BASE_IDX                                                                        0
 #define regLSDMA_PF_PIO_STATUS                                                                          0x002c
diff --git a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h
index d1324239b751..d0d3a1c90ecc 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h
@@ -216,6 +216,11 @@
 //LSDMA_UCODE_CHECKSUM
 #define LSDMA_UCODE_CHECKSUM__DATA__SHIFT                                                                     0x0
 #define LSDMA_UCODE_CHECKSUM__DATA_MASK                                                                       0xFFFFFFFFL
+//LSDMA_F32_CNTL
+#define LSDMA_F32_CNTL__HALT__SHIFT                                                                           0x0
+#define LSDMA_F32_CNTL__RESET__SHIFT                                                                          0x8
+#define LSDMA_F32_CNTL__HALT_MASK                                                                             0x00000001L
+#define LSDMA_F32_CNTL__RESET_MASK                                                                            0x00000100L
 //LSDMA_FREEZE
 #define LSDMA_FREEZE__PREEMPT__SHIFT                                                                          0x0
 #define LSDMA_FREEZE__FREEZE__SHIFT                                                                           0x4
@@ -1034,6 +1039,7 @@
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT                                                    0xc
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE__SHIFT                                               0xd
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT                                                     0x10
+#define LSDMA_QUEUE0_RB_CNTL__RB_PRIV__SHIFT                                                                  0x17
 #define LSDMA_QUEUE0_RB_CNTL__RB_VMID__SHIFT                                                                  0x18
 #define LSDMA_QUEUE0_RB_CNTL__RB_ENABLE_MASK                                                                  0x00000001L
 #define LSDMA_QUEUE0_RB_CNTL__RB_SIZE_MASK                                                                    0x0000003EL
@@ -1041,6 +1047,7 @@
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK                                                      0x00001000L
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK                                                 0x00002000L
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER_MASK                                                       0x001F0000L
+#define LSDMA_QUEUE0_RB_CNTL__RB_PRIV_MASK                                                                    0x00800000L
 #define LSDMA_QUEUE0_RB_CNTL__RB_VMID_MASK                                                                    0x0F000000L
 //LSDMA_QUEUE0_RB_BASE
 #define LSDMA_QUEUE0_RB_BASE__ADDR__SHIFT                                                                     0x0
-- 
2.37.3

