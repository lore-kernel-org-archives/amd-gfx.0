Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277BFC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A198011395D;
	Wed, 24 Apr 2024 08:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sCi0Hk4e";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA32F11395C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldZxk7R5cDzAqXfXSVawcGvCw/+WzcRIPxCqGiWn6ocnTTTeI2jJA+9r3E+48ZpFtOu6ojzzLCz2DHxBexTyYPtybGI6IeodLmAUpivSF3zGD3D0ngFPdqIsGzEQ/y2XFc0eMjhsYaaA66ko3yVT+L9+RFOEpstEA3X2lWG7HcM3Xoa6TXA+idKCbnQ31HcBRQiITvKCxUbSFbzcEh0nhEhAyDvHO6lBOIlKwf92TxkP/YuEm08TQxyETZHVKAPlnxLxU3IKT/ZlgrSyp9nUN+U3eWlY3JtI8vumCv105E2XGhmDECUfNnctHHQdfOe+MLMgfPDLEzkRc5frce2P9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F2UwGXmCDet6vTac2W69I+kyMxgbfF3b/JXjwua6SA=;
 b=ay/WXxBIRj50LsbqEo8JEj4kRNMs93Tf8Er02hCYfa6niXOtg6ZQtV0cw27t0d8nqi3ThVanWhBLRFk+3ZeKuwe6POxnGeZ7tJMJpuJNU3SJVEWwefSkwxhM7EuRC/AvpdKscCp/IcF1rFw1v8AHOwbiKLdNcS3+wjEs50PZsMIY/DGkph0DWVCNFcWV3gaN8slLBwbp4/IeExIm+Fp5PmOsKtH6TG6h3p7RY8DTZvxHa/S1XWQggAnXmIg++G9d1rmdtwAW6BdTB6IWla5mkX1JXww6t2G7FSon7NqbXqj7Q193oq8KPkPZHamgeuZC1ABDEf6ZTlE7frB3vPdGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F2UwGXmCDet6vTac2W69I+kyMxgbfF3b/JXjwua6SA=;
 b=sCi0Hk4e9g0TYo3RsnZ1NAundJb/iUPIV4tC1cQzV+XtzjAW6196aoibQ8kptITg3xJ799Ml5jPJw2UVm1iHbv4Dv7M3WtW7blxl6nYAlnjPQWn+CkVwUIkCE1R/fJytzkCf2h3qzmrCCv5fg6B6Ap7RkMsYsuzHqk7NfgrT/uM=
Received: from BN0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:e7::10)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Wed, 24 Apr 2024 08:51:45 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::b9) by BN0PR03CA0035.outlook.office365.com
 (2603:10b6:408:e7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Wed, 24 Apr 2024 08:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:51:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:51:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:51:45 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:51:41 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 13/46] drm/amd/display: Adjust codestyle for dcn31 and hdcp_msg
Date: Wed, 24 Apr 2024 16:48:58 +0800
Message-ID: <20240424084931.2656128-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a149a1e-d5ee-431a-ee9d-08dc643bc573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HZYLX1OkZ9M5CYdjBOEY5HaLawG6KCHafkLCHJCjfbcr18+nWMeRYXZ8fQ9b?=
 =?us-ascii?Q?+6sL8i2dJ1Vlx8fp7Ku8Zlht0QAhrnI/iMLwSo78WTM7L0heFOa3PmyapWwD?=
 =?us-ascii?Q?2+d95g/0UT/76kstDFB5VSxh6rg4QA2OzPIqpVY2o58omV/p5hRae0YqKifr?=
 =?us-ascii?Q?RLffaEL3frAGhr4q/W9JUcX2E4ntKg/oaF3je21sPQ4vb0nDLG9dXPMY/hwk?=
 =?us-ascii?Q?YulhoZA+/OA2EuwvNrtKtPCVbr1SyfBhAF9I/23vfxbHlc/ODLL0D0B1y/sg?=
 =?us-ascii?Q?ggQNiNRnkZwr1hkQAW/+Gl+g0ZA0eBezHO/AhCuOc+1v8ftfxd4KY20bp6ye?=
 =?us-ascii?Q?AWuxnJjMcylxe6ti4wm6W2B4cyhiQQW9TKBMVU1Ewq41f4XYhPIfL1XH33x1?=
 =?us-ascii?Q?nN7vOWqLgckIYxHRiOfFxlNkxID37r6q+r89MLuQrRZ4Eod8HAoCuylJbcsD?=
 =?us-ascii?Q?uj3l+dHwlsn8t3E50BoBzD+rUvuRO6aLGsw1+3o6ZYPCQbbnQ7CwOv8e+lrm?=
 =?us-ascii?Q?mILrd2Hqk94neh/cEeg3esikderBfEqPvjIWbwE0aO37lMQ9y0nLg/Kq9fsE?=
 =?us-ascii?Q?KXGXe3Uwh09LSVbFXmdjGx8vVnjqAToYBDlg1C7nck+xK8ZWE15f1elfTlhe?=
 =?us-ascii?Q?RX7nlgno3mIaBg8EHFhl0kRf48GTvfL+Ho/zktVRUYplK8nfSspu2bsMQBUU?=
 =?us-ascii?Q?jN9B3NqHUogntuD2dKsjJmlOcJj4aq9ebAv84YA5sXO6ZeyRWbUbHafQB3Zl?=
 =?us-ascii?Q?NT4r3x44U5ILSWrA6roKTQBLdJDwJ8egYVgilrXatrIBdn52eMy8psTUPlEQ?=
 =?us-ascii?Q?1AnOUF811aMmpjaQhjITefJKRNbzYfl6SI6XJ+LXsVAgmOz1dgdxRRiv71uy?=
 =?us-ascii?Q?x3w0uCZuoae2WbdV9hXTt99vdOGLJBjehSVEIsoPdE90Q5UAwiQy7koYDoF5?=
 =?us-ascii?Q?TfaFntWHPF/MaqjOP4MsckArvL9oCWaCjsetBodY7mRXpvEnlEXJrtp8Litp?=
 =?us-ascii?Q?VmoYPNJblfl5ZfvJXmUjc4qNpl5uxlPlYz788Idh4+K3PQuZbDyWkZEnI06i?=
 =?us-ascii?Q?rz5pmabZmSYkEcE8A0LpHqMlP0HmyKv1MIChw0SX93JA6ee1t25/IROYwN0P?=
 =?us-ascii?Q?Dy4hpR4YcJczDs3BO0o1tc26oGX4T90v5P5e3Zw3/OkWIads8iWa/xJDenyi?=
 =?us-ascii?Q?zTVq4Cm/aFm2TOe1GrPi6nAtjyVH6tzG3PelaLL7drnhbeXGooxTWg7/m6Cr?=
 =?us-ascii?Q?NjKUCKtUEd0ztaIQp32CWXYYBwavEdHo69+wGDuiNqRy3xqGdmNKUsgiTTtn?=
 =?us-ascii?Q?tbl8tkv4wDkb/m1iocOn8qfE+6f6hJbWsjbDd/VY2DnaExICT9gIA+Woq4R7?=
 =?us-ascii?Q?0JHSK1ekI+t6Oi20llSSbxGdM2Jc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:51:45.7856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a149a1e-d5ee-431a-ee9d-08dc643bc573
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit just update the code style in two if conditions and in an
static array.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c | 8 ++++----
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c       | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 59a902313200..4407640c5f87 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -645,9 +645,9 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 			dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
 		s[i].phyclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
 	}
-	if (clk_table->num_entries) {
+
+	if (clk_table->num_entries)
 		dcn3_1_soc.num_states = clk_table->num_entries;
-	}
 
 	memcpy(dcn3_1_soc.clock_limits, s, sizeof(dcn3_1_soc.clock_limits));
 
@@ -797,9 +797,9 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 			dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
 		s[i].phyclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
 	}
-	if (clk_table->num_entries) {
+
+	if (clk_table->num_entries)
 		dcn3_16_soc.num_states = clk_table->num_entries;
-	}
 
 	memcpy(dcn3_16_soc.clock_limits, s, sizeof(dcn3_16_soc.clock_limits));
 
diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index 99e17c164ce7..076a829c2378 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -70,7 +70,7 @@ static const bool hdcp_cmd_is_read[HDCP_MESSAGE_ID_MAX] = {
 	[HDCP_MESSAGE_ID_WRITE_REPEATER_AUTH_STREAM_MANAGE] = false,
 	[HDCP_MESSAGE_ID_READ_REPEATER_AUTH_STREAM_READY] = true,
 	[HDCP_MESSAGE_ID_READ_RXSTATUS] = true,
-	[HDCP_MESSAGE_ID_WRITE_CONTENT_STREAM_TYPE] = false
+	[HDCP_MESSAGE_ID_WRITE_CONTENT_STREAM_TYPE] = false,
 };
 
 static const uint8_t hdcp_i2c_offsets[HDCP_MESSAGE_ID_MAX] = {
-- 
2.37.3

