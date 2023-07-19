Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C81AC001DE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DACB710E4EA;
	Wed, 19 Jul 2023 18:35:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BAED10E4E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFfQxPkvqYnEx8PHfY9dtoDi4UdLiYuLJVSpcA5D+fxc/fGbsFlwfHThLgg50eQmaWxmfidAkGVVF36PSkbTgc9/6Eaf3unRoDXBCyE9hS5rjyEj1nNRGaAw7FwosX2AKlngLR/Wsrixpk+6dDFPZunNvnmZUGDdeau8voyHYwdqCSPNQzggWoln3kCcmao+DpnzaUGapfAOuTqmWw+KWRss8d36GD/zpmfrm6zggxvwjj1KpoxGL6rhj/+Sak4kswVvS/7fnp5OatltIFfeP/+lrET67sriCji26NF2oBUt+xwHZwPcg5I69YZjjur13uF/+cuh09bAAVOtIOs52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nDdUqfa+pDgcvvojPZ/vK96Xmc6FYVrA/7N01Bd9xw=;
 b=Y+t69o/UDUa4WlI7j1ypREDMd2ycwzkWjipEyrFd48DlsSctprQVErA2AECGx2Cn552xL0N7YGJxwgyBN+y+iYheuMB5UJeK6O17BpXEroxUKTfAfb7wIWm5xoNKrNN1RMLLKU1IdmHrQSjrbGVQenNSdzAFC/8FuzVHGP2XjNaqOmTxq+HRfb5dsfVsxaFNRuRpWMVdfoxCE0inEkA5Od0wLMKdmW+axUuH4HRgwmMmse55afgI3XMz3g/mY/kfspFdiU5Pth/aSHLwfxnDe1eSoQ3VEhnIqwT8c41ESkHJ8hIMP0FP5GweuQrIThfRZZewFAkbhfrUS7qYZm3CkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nDdUqfa+pDgcvvojPZ/vK96Xmc6FYVrA/7N01Bd9xw=;
 b=GW1Yum4V5aNMxp/R7e24y744pryB4Z4xifioedNDINOy1QoDVs8XJNnUHyuDQnyH7B0QwNaAyYuAegsfnoosGrtCYj2+QcOE7fW2DwkAJskx9ntgfAiIy3LJdwHNdRJFMv9mTNe8vPSbl8es7Cxau4XfkJVtlIAyHHWeu85OTHk=
Received: from BN9P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::34)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 18:35:51 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::ac) by BN9P220CA0029.outlook.office365.com
 (2603:10b6:408:13e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 18:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 18:35:51 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:35:49 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amd/display: Rearrange dmub_cmd defs order
Date: Wed, 19 Jul 2023 12:28:03 -0600
Message-ID: <20230719183211.153690-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 092f520e-6903-43be-02c4-08db8886faaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUYRfqU/Pp/4PARl3sPYoBsUDU+kczRiJmSBySPQXhn/bfqgnF+fQY/3JeAVJIf6zRA1xChnJeHTN8RtMXSE9AaF3/S4IDlNYiujKGvC+juXQIvL4UzoClz9gzpqyp0A1v6TJZII2+pNbjTxfEZL41CfwPtROIs8knapd1G2G9aGhNSFXJL8HYqVdocfJXtWfC71J3sH3UwBCjGwBCcf4XSg6OlCjzAg25MSWbO54AEb3yajHANBJPzBlxuN+kxx1xB+jsXzAA3aGNIVlo0OLg/AhR2l1VoP005Kr6/hYNaA7YpQq2BRTINTxp1IE6RpS8OQotU9nyIuVj54xBlXm0UncEzUCYYOEjuszN8QwVTVnqFrvh3kVsjoUg2wZUlPhcuS7F4b2dDES4z3MhplMtqg4edUoxM7sFGm79GSsIMkxrTcoP9EoNtxtwF+ysORa8TX/qcCX9Gq4ra2icTbAseBe4CO8ubtNB6qG+caeResP7WcLvbvWnh1mGcbHJ+hpyJj13UGi74G+SA++rv+XBgQgDJTunQdU5JE68b1adNsMgdPyJ/pD6Ox5ITHKOTGfi4G7/ts+bQMbx5NT3pLh3nCbc3FVOH0/x828KzA2zIHNb3wyDtSdJbUqtxP3ZQsidO+fjfICXoT+j2SxHcNrmctehjaeY4yccoDfL9hL37IPbMPNhOFxorzYGl7slvBRYY7s4cA2TPs7exF6tXji0GcNGnp3K+OMc2q/7LagvXhw3TQz5kIjybUw+0GGfOKf5ALm9mXeAmrK4fi8zHDQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(36756003)(54906003)(478600001)(7696005)(6666004)(40480700001)(1076003)(336012)(186003)(16526019)(26005)(40460700003)(86362001)(356005)(41300700001)(6916009)(4326008)(316002)(70206006)(70586007)(8936002)(44832011)(8676002)(82740400003)(5660300002)(2616005)(47076005)(426003)(2906002)(81166007)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:35:51.5357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 092f520e-6903-43be-02c4-08db8886faaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
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
Cc: stylon.wang@amd.com, Anthony Koo <anthony.koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

 - Rearranged defs order

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 54 +++++++++----------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a81c8f7215bb..adde1d84d773 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -144,6 +144,32 @@
 #define PHYSICAL_ADDRESS_LOC union large_integer
 #endif
 
+/**
+ * OS/FW agnostic memcpy
+ */
+#ifndef dmub_memcpy
+#define dmub_memcpy(dest, source, bytes) memcpy((dest), (source), (bytes))
+#endif
+
+/**
+ * OS/FW agnostic memset
+ */
+#ifndef dmub_memset
+#define dmub_memset(dest, val, bytes) memset((dest), (val), (bytes))
+#endif
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+/**
+ * OS/FW agnostic udelay
+ */
+#ifndef dmub_udelay
+#define dmub_udelay(microseconds) udelay(microseconds)
+#endif
+
+#pragma pack(push, 1)
 #define ABM_NUM_OF_ACE_SEGMENTS         5
 
 union abm_flags {
@@ -233,34 +259,6 @@ struct abm_save_restore {
 
 };
 
-
-
-/**
- * OS/FW agnostic memcpy
- */
-#ifndef dmub_memcpy
-#define dmub_memcpy(dest, source, bytes) memcpy((dest), (source), (bytes))
-#endif
-
-/**
- * OS/FW agnostic memset
- */
-#ifndef dmub_memset
-#define dmub_memset(dest, val, bytes) memset((dest), (val), (bytes))
-#endif
-
-#if defined(__cplusplus)
-extern "C" {
-#endif
-
-/**
- * OS/FW agnostic udelay
- */
-#ifndef dmub_udelay
-#define dmub_udelay(microseconds) udelay(microseconds)
-#endif
-
-#pragma pack(push, 1)
 /**
  * union dmub_addr - DMUB physical/virtual 64-bit address.
  */
-- 
2.41.0

