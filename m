Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AEFC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 07:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D4EC113E78;
	Wed, 18 May 2022 07:50:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C424A113E76
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 07:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtJuvrMMDL+3tqtQnExYYQIGYwbJ928U9p5UBZ5lCh+ZKOfT+bbrzdySaux7t4QLCVE7uw484ODBxWhAoORuzwJz2DHfUrmFxJ4slj1dm8oFfGer+3xonoOGNHKpJYGVZNSo1zzQSTWOAmfccS2BG3qlyhYdDG8H5xJPOdHvBelOGtMYEcyNParlR6oZEN5bmgYmjFJ9JrsiY6MAWE4jnh/bq7FNW8oBXWif6TBMdozcwljcmpYU8DSOZA4/AYMeMiJZyioykto+YdGosHdKRWRiOyF+TBqrJThCdM8du6+JvFNuC1VUxyh43Z59ZpHAuUiO4IzGnnD2NvoT0kL1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX8447bIryQtLsp6BpgTIzLlwvbojeT5k4iFfrl8bv0=;
 b=atsnYgh7rubpwHwGM8kpR6E8mtFW/Y8ZHOESdnM1O8NMRZvkX92hiYVgKLBOa4oepilTNWZt4gl8se7gCtRtowpe+/gFp36RP52aDx17vCbBHTrtAXab9n4cSamlZ+FQ1cx5MwUr4GmK2GCr7R1EZmNBTfFb73wZhzwTkOtwuOhUXoA8PzS4FLqLvxqEduLvfNrI4+66Tf2z7HZEl6BXBKTx2uPmKkoNOQFj20H+/lr7T3ek5yNJQzt8Xc8VF40HYhmwIUGoXeyElGwzvx47c1ii2bEoRi0sEwTis92Mu2XOa1OthaAL1DA1I4UObbt2n6yY+WBIqv2ZIT9SKOIWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX8447bIryQtLsp6BpgTIzLlwvbojeT5k4iFfrl8bv0=;
 b=IPgvL7UyXlQOyIRwa6H+xmpbOziUHV4rs0bnRSUa+TOoAlPib6znNLeO6RZ83Rdf0G7utC8g1Z7UjNPU4JqtasnCWPdt171QNViGEIq+fQBLtW+RVkQ1ftB0OSR9dTBNOGPzpQ+TSTKLPuPrZLrdsfaaaPkMYzblKheTVRndL0o=
Received: from DM6PR21CA0019.namprd21.prod.outlook.com (2603:10b6:5:174::29)
 by DM6PR12MB3994.namprd12.prod.outlook.com (2603:10b6:5:1cd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 07:49:58 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::7a) by DM6PR21CA0019.outlook.office365.com
 (2603:10b6:5:174::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.6 via Frontend
 Transport; Wed, 18 May 2022 07:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 07:49:57 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 02:49:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 00:49:56 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 18 May 2022 02:49:55 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] dc: Add HDMI_ACP_SEND register
Date: Wed, 18 May 2022 15:49:42 +0800
Message-ID: <20220518074942.1519871-1-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 656de895-646a-41e4-a2c8-08da38a30161
X-MS-TrafficTypeDiagnostic: DM6PR12MB3994:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3994E50657581054D74C3086F5D19@DM6PR12MB3994.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxxk3tJXXX9fjzWRV7P4sHtnTCVL9wb7NkvV8mBBewghK9PkhHi/p363y0WoUa2ybV/8FTqK/1VhFSv7ls5ez13dW/1GQBIsLXtbF8gKtd74XUQ9H2c/1l0xPzbBLQtLFR6/J/82eMWfnPr1fY/y2e9jG0gQK7rSioPXLlAWHETazYWIVwOgCF/eRBMkDrta5CoRYDULqsY8lx5fgRvbqXSujDm4tIXXLJAp8+Tp+qVLCs/VMdQfdHZjGEQwWXIfmWP9VIgeDpix/wpOnFWwbVO4nApc6rccYJ5S7HQ8hha+uo3DXOjAqgFiKrIPmFX+INDiB44JT8xNDySfmbxY4eFYeuNAF2rC3LrDV1wquNNHMJD3mkHYFVChLN2ezlInEcqsN7ApD7QGQiowyCykA/hQs/lQyNuYCLSWc9FpGsIUSrA2nKAlD74b+oY7Z9dQZpTIxqwQH99z8Byql4e2H6bpsxX2sqXVq3rrZULQgXYCCzQl8nRD8jDa8hfd/4L0PBLzKoSt3V2aF4j16JWIjH/9npB0tLioHf+8uGwplm9kX5Bpx/o+h7p+orThGwgo1ZkBmNAq1/Qql8uAOLrfG8SjuDxybQ+ToCJjHe2kD7WP93NsR9truPdqjd8A01aMCswnyzI+tgARadjK26KDkCUv1G3wq0kgvuACwbZSL0J47HpggnYra5gn624WRo7+V6+L8bksGk8XWD3IijCEcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70586007)(70206006)(26005)(36756003)(8676002)(4326008)(316002)(36860700001)(81166007)(356005)(82310400005)(7696005)(426003)(2906002)(6916009)(86362001)(2616005)(1076003)(5660300002)(8936002)(6666004)(30864003)(508600001)(54906003)(47076005)(336012)(186003)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 07:49:57.9253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 656de895-646a-41e4-a2c8-08da38a30161
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3994
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
Cc: Alan Liu <HaoPing.Liu@amd.com>, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Define HDMI_ACP_SEND register shift/mask.

Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_10_0_sh_mask.h  | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h  | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_sh_mask.h  | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_sh_mask.h  | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_sh_mask.h   | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h   | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h | 4 ++--
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h | 2 ++
 9 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_10_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_10_0_sh_mask.h
index c755f43aaaf8..7a2c6b12c249 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_10_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_10_0_sh_mask.h
@@ -6070,6 +6070,8 @@
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT 0x8
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK 0x200
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT 0x9
+#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK 0x1000
+#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT 0xc
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK 0x3f0000
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT 0x10
 #define HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK 0x1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h
index 14a3bacfcfd1..fa1f4374fafe 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_0_sh_mask.h
@@ -6058,6 +6058,8 @@
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT 0x8
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK 0x200
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT 0x9
+#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK 0x1000
+#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT 0xc
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK 0x3f0000
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT 0x10
 #define HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK 0x1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_sh_mask.h
index 106094ed0661..39f6fde6db1d 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_sh_mask.h
@@ -7142,6 +7142,8 @@
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT 0x8
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK 0x200
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT 0x9
+#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK 0x1000
+#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT 0xc
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK 0x3f0000
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT 0x10
 #define HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK 0x1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_sh_mask.h
index bcd190a3fcdd..c5f4afac3b39 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_sh_mask.h
@@ -37285,12 +37285,14 @@
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND_MASK                                                       0x00000010L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
 //DIG0_HDMI_INFOFRAME_CONTROL0
 #define DIG0_HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND__SHIFT                                               0x0
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_sh_mask.h
index 9b6825b74cc1..23580907663b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_sh_mask.h
@@ -5584,6 +5584,8 @@
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT 0x8
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK 0x200
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT 0x9
+#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK 0x1000
+#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT 0xc
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK 0x3f0000
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT 0x10
 #define HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK 0x1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h
index e7c0cad41081..a788ff3b68c0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h
@@ -30357,12 +30357,14 @@
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND_MASK                                                       0x00000010L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
 //DIG0_HDMI_INFOFRAME_CONTROL0
 #define DIG0_HDMI_INFOFRAME_CONTROL0__HDMI_AUDIO_INFO_SEND__SHIFT                                             0x4
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h
index dc8ce7aaa0cf..c70f7ba94d8f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h
@@ -39439,12 +39439,14 @@
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND_MASK                                                       0x00000010L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
 //DIG0_HDMI_INFOFRAME_CONTROL0
 #define DIG0_HDMI_INFOFRAME_CONTROL0__HDMI_AUDIO_INFO_SEND__SHIFT                                             0x4
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
index 91969554e36a..ca1e1eb39256 100755
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
@@ -16956,7 +16956,7 @@
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
-
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
 
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
@@ -16964,7 +16964,7 @@
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
-
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
 
 //DIG0_HDMI_INFOFRAME_CONTROL0
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h
index 2f780aefc722..6104ae304099 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h
@@ -35487,12 +35487,14 @@
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT__SHIFT                                                     0x5
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND__SHIFT                                                   0x8
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT                                                   0x9
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT                                                    0xc
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT                                                   0x10
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_NULL_SEND_MASK                                                     0x00000001L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND_MASK                                                       0x00000010L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_GC_CONT_MASK                                                       0x00000020L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK                                                     0x00000100L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK                                                     0x00000200L
+#define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK                                                      0x00001000L
 #define DIG0_HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK                                                     0x003F0000L
 //DIG0_HDMI_INFOFRAME_CONTROL0
 #define DIG0_HDMI_INFOFRAME_CONTROL0__HDMI_AUDIO_INFO_SEND__SHIFT                                             0x4
-- 
2.25.1

