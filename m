Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1EEC5DF87
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 10:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 515AB10E132;
	Thu, 20 Aug 2026 10:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tfzsfuQM";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843AB10E132
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 10:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tu5z7Y+OZRykv69wP0Gx1vGMwTMzKPn11u/+vvOAxQ6p8QGzAE+K/sm82vMFhqCbk7379oUACmic1W7NqTzb3NMjV0iEyvoIloefcrPYi95KcENDlpeDevq1ZDg8BZ1l0/MXGS4yfACmvDiP3HHxaw6pTpWX84BAUS7Lw+1LjqwO85A4ffKLVR1OzAWNHFl+cUeZa/aEzmQRnNxuw8iOKIeNen3CUlQK1ZvGRaWX/puSLgfpcNbFO1z4zphQGHYhwbYXqt50CEc8BctxrZngo3a3qn0FmLbXVeb2LcvboB0mrCQGguaPU6S5t3565C7vjDBbpBaFvX7smz9xB46QaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2wEKOX9yDaDPbfmK310qnS8qRigr3YKQq8ZIP+xAbQ=;
 b=YaM6ACh6DzG+dqv4XD0lqhEqnEJkEHrtQApE/6y0pqYCb2/ZR0IgVJ80b4ECcCVBhqri1IYRfFxvGF2SdWOmZy4P0N1+HhSdFKgCve9RUSCNQvIY2cJT3ZehIuj6fxAh3sr4Pjn8uAnn2fgimOUiYbIm3JsRPJIh3Et0GUoGdX7nXq3adZGYZlK2j4VBLs4DKTJkS0ldFXgKreroU5vqpSbcSB6rQMR0YBQ3zkePWXfW2ML0FejALCy9M37mvgZLMWaaOVrDLXqAbnkYc7fYvYWRnN79WxFOtDJM2avpzNGdiIQkQXZK/lUBKfL53/XhzEEELJgPneZx/Mi3C5+Esw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2wEKOX9yDaDPbfmK310qnS8qRigr3YKQq8ZIP+xAbQ=;
 b=tfzsfuQMi37jue1gtqYCYTRdQBQd4a4cgKHwO0PUEMs21pVvDgq66vfgk+45ESqe0bswufFdprSv2hPzY3wU3dvqK+K0KlQPuezw93+BUe6e2wafAdyLaKzwMNUSlO837whO1TFE505ktqDjYfMo/94QnzG0WYRkcl+1MxqfpFI=
Received: from PH7P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::14)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 10:00:31 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::1e) by PH7P221CA0004.outlook.office365.com
 (2603:10b6:510:32a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.9 via Frontend Transport; Thu, 20
 Aug 2026 10:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 10:00:30 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 05:00:27 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Roman Li
 <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Fix wrong bytes-per-pixel value for
 dml2_422_packed_10
Date: Thu, 20 Aug 2026 15:29:43 +0530
Message-ID: <20260820095943.3942404-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 52bdff26-2842-4a04-de2a-08defea1de3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: l1V3TbfpkBqlTbSNqC3hSWUVg86c0q7VPqDdTWhTgswIjzgFa/UinNSUl1dJY4X5L21S+TAZX3DBkEApiOTBfTCcSIqTdzJP9AGYEwv5j68Wh9pxJH3aU79XxKOtm0kd81/Q/WpJxZjnZDKIA1LcVLY4jfaQ9VtiKHtrnuiDiOMIpUc2B1/0WnawuzgnL8Q/81PegigEmkde9zf/q/PfeJ2YBJHxuvBMILcou/hrGFglHh+8VKGzYexQzF4unMxsLqIlfQnXj2lBLSVyvwMSGdZwrv6ouosnd6hUN4gikIseK/i2th5/XzRohOHwjkdl/YEyoce/Wgtg9t6gXCsO/6w82H9G9usWkW19jcOJLsUVRJ7iYJlYISC9/SrPA4HcpmsokPJzXgPFrV5nGAmiyE0seKvPd5LEK+JVnLBXPxVpiBYkcmNI8qWfcYcvL44s/E+75ZeHUpSYKTZ57Vi/ExbfnyeiG2gcD5d3sOOECm16VwZiriW6UnMlhKXSGBjFZezm13VOPEs35IDx0q3/jAP2Z7yXszhZMbvk9s6zAfNrOWLoupBisa0d5NSbDWedoervVzr9x0wEePzZjyVNyF9m9s8R6xvo9ZKMInbby3rhGB0WHkVQS0u91q6dgI4OQf8m/O4kr8MLgbsIS+O4FeHlg8SPRfyLHn1hVMQXCmauEVIPJdCJmVLCiaIyLSlb1mxArxv/kLCEEms3Nabqxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 69isMlZmn2w0SsAMQ7t7hySeMUQDXiGGOx7gxZ92dig/9rLVZ4maHyo2RlwHikBCWpgvEwkoZzyA8aQ6Tfb3F+2hkEodGNlOfar0jYZ6ZmvXSrQ90kRIajG/rQRQ/14Ieec1krzL/ZLAuymjNnoRpOBp86O8whVQCQNtiQDBw0sgfhSM19Ht2Qst7A1aJlMdCi7MTPPOnfDsUmxLs1s6KEkaQYPUaQSWM5s8oZvQ+JEGsej3PPwlhuD+86V2GHjzrAvqCj1W3AlV5eiZdrDJc9prv6T8v/Mw6aly2ZaD5XHdRjfcZkF0u/hncpd8U5IUIIQiIYPqS6Ap8zgkJPrmvurshyjwYLsJELjSEaDlZ2hHE1/Y1Zg5BoVufvfQN7RSssbn4tpiMWVB5zjle7jWTuoqLKIex/kjj9+YXL+eNMWd5GsX6uOIn7qYBUCQCnNJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 10:00:30.4444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bdff26-2842-4a04-de2a-08defea1de3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The pixel format dml2_422_packed_10 needs BytePerPixelDETY set to
8.0/3. But it was accidentally placed in the wrong group that sets it to
  4, so the correct value was never used.

This caused wrong DET buffer size and bandwidth calculations whenever
this format was used.

Fix it by moving dml2_422_packed_10 out of the wrong group so it gets
the correct value of 8.0/3.

Fixes: 04d9a88decbc ("drm/amd/display: Add new sources for DCN6")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c   | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
index 321a29d289b6..bd2494c976ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
@@ -74,7 +74,9 @@ void dcn5_calculate_byte_per_pixel_and_block_sizes(
 		*BytePerPixelDETC = 0;
 		*BytePerPixelY = 8;
 		*BytePerPixelC = 0;
-	} else if (SourcePixelFormat == dml2_444_32 || SourcePixelFormat == dml2_rgbe || SourcePixelFormat == dml2_422_packed_10 || SourcePixelFormat == dml2_422_packed_12) {
+	} else if (SourcePixelFormat == dml2_444_32 ||
+		   SourcePixelFormat == dml2_rgbe ||
+		   SourcePixelFormat == dml2_422_packed_12) {
 		*BytePerPixelDETY = 4;
 		*BytePerPixelDETC = 0;
 		*BytePerPixelY = 4;
-- 
2.34.1

