Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D24C77B7A
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Jun 2023 14:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C7C510E049;
	Sat,  3 Jun 2023 14:28:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD2B10E049
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Jun 2023 14:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9r6F3CuL/hNaeVxFb2kHIiUnOTB862P8IOITu8HyfMyUp4vMbevLZ3RDY8CFH0uikvDYOy+NpFY3ZguYhKBokHFtrkIl8yDvNMgJ5qwmOT1aXKKNyGldrAurq4RcTv0FW8gydy13K9Ac0Gx2rZeCDrQpqfL1bl1wQlqijp9w7yY9IclDxWzwoCzXXxnhXHhVoNO3ZrQakvIZU2drNnjYpla/Hhd4fxK6kD8PTC9h0ICgZBtq+WfSoxP0nqZMnWlaq8YfoYo6C1ZXzJzfAH2+ekgaqwhElTx2HUXx7H52CjbQ0QCE/6EEfyd25UVOV+hwF894/8g8TK8MXYIZgBA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8ZmCsU9uQGPyNJsl1MRKnhGV/M+PFvV9RH318hKUJU=;
 b=hSQZqW/s9AjAVt9kL3OxwoUVKNT4fVP/kkRBJR58bifGKjKjqpru/tGk6Ylo8AiJQzPYTxFp+tiKPwf8AseEQl3eo1JIY5tt6i9iQ4CA+5qZpFkDEVcmvtJnRb9lU79iLyMGbcFvVyFtuHWhzX3zyKFzPFGtzGD5E7Y43qAEHR6ynZ5Y0b497yC3wMa3mp546cUfTbygAZsLROsJkTD5PEagkRsoEpeK1z3EVvcsmFRcmCHGuuLhvh/nXiYp17L1WfeObLVcB+seKYiHUV081QDa01SS62eEsF9qDe99739tGiEykUmAPJ3kNROI/mrmHRZfsyLI2eQRPU5TZNQTPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8ZmCsU9uQGPyNJsl1MRKnhGV/M+PFvV9RH318hKUJU=;
 b=sDEXO6qrSqxM5MOx7vMRM028BqKJcAr9KfLeAFsA5K158KNx7Ma9DGhV8pLcjvPS4vy14Id9ROHuUAKXjaBj2WXSPUTFzaTQW3rFqXL8bYej6uZMCgfPCdJ6V5W/82MTwkvbLALnwGteo/9A862liJ4k1yd/krwGSu8CWpfw5E8=
Received: from BN6PR17CA0047.namprd17.prod.outlook.com (2603:10b6:405:75::36)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 14:28:39 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::a4) by BN6PR17CA0047.outlook.office365.com
 (2603:10b6:405:75::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28 via Frontend
 Transport; Sat, 3 Jun 2023 14:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.28 via Frontend Transport; Sat, 3 Jun 2023 14:28:39 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 3 Jun
 2023 09:28:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Provide function name for
 'optc32_enable_crtc()'
Date: Sat, 3 Jun 2023 19:58:23 +0530
Message-ID: <20230603142823.1930299-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: b969445d-c2af-40a0-b7ff-08db643ed2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aymlhyZ6TrzhaF9HBl7RH47ZufVVUxbDeVQjkGatECKCrODBpGH6VqdNMcDBCMhrtCz8acPhE/5y1kqNNX/30ByiCzSBdrAV61NYkCax0dZjK76VHzq3t+C/u8cBSDGB+EhXFod0p0MDIjMHcoWBUnqtQ0GQRbhgHDzBtJAEdTFVWrrs5LG6B7DRmqx+jGlt6AeA1S6VtvcCRx8blR5trD4fKiVdQLTMSOGPkmOP3hIanOxhVcgR4VDer/3EkUlUMEwKcm8Ohh332Y7w/yIH9iV4JaKbXAyRzHN3/625xFX7BrRdr+IerUwAe1v6PC6PVuQRKLjbRDDlMNtxalx9vnjI5HaYWkKrueaZGIrNRNavm8nXS/OWN2pBM+CHNeFQlQVnEW0ZVJPA7gfNKsuW75wClCPFa5VvlU+p+mBBlJoDOUv3EQmn/5Y9kQ4NP5tL55AV9/wrfp9cdoCTLuc6H4G5lLSI/84obsMbNfodlOTVtJ2Yb72rjQ6YsnQ7PdYUH6vT4pyUFuqltFeREx+MFs/VwUBzzFpicZr/55t9OZU759mmsxa2e1lakJ3c/fKkFVNaF82zwsuKlzVYSv5jbBE6dfB24OndM+iFuY6RDEI+bsRVDVm3X85QayrWMxoQrX4gudrg6qc5H1KeZSXL5MLJW5lmvmMSdNlqcyRbCQ9v5PnpJTP5pc/dJ2eJ7fad1i5B6f52QDyUjzKtdyaAKP/KdO6OeVnDTDFTLZuuZW6ThfBbvbtXU0507p5OcM19Zbu2IzF4otEapi6PpFEHeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(47076005)(1076003)(26005)(2616005)(83380400001)(41300700001)(6666004)(7696005)(186003)(16526019)(36860700001)(336012)(426003)(40460700003)(478600001)(110136005)(54906003)(4326008)(6636002)(82310400005)(70206006)(40480700001)(356005)(316002)(70586007)(82740400003)(81166007)(8936002)(5660300002)(8676002)(44832011)(2906002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 14:28:39.2001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b969445d-c2af-40a0-b7ff-08db643ed2eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following W=1 kernel build warning(s):

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_optc.c:109: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Enable CRTC

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index 2cffedea2df5..8abb94f60078 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -106,8 +106,11 @@ void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool man
 			OTG_H_TIMING_DIV_MODE_MANUAL, manual_mode ? 1 : 0);
 }
 /**
- * Enable CRTC
- * Enable CRTC - call ASIC Control Object to enable Timing generator.
+ * optc32_enable_crtc() - Enable CRTC - call ASIC Control Object to enable Timing generator.
+ *
+ * @optc: timing_generator instance.
+ *
+ * Return: If CRTC is enabled, return true.
  */
 static bool optc32_enable_crtc(struct timing_generator *optc)
 {
-- 
2.25.1

