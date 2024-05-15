Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBFDC25B78
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 19:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB6910E0A9;
	Wed, 15 May 2024 19:20:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ntcYiy/E";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7053510E0A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 19:20:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GF+IpDr93Oh1Ckg3GaQnA0gGqRnMkyy+1eT1s2BX07CBDPTsCB+zmATI507ZY76th1MHWTsuxMa/nqEiK2r97kSNG5+0QP4ZgBu8xJ1NPRbCN7bEq9xM5/MY50gidt9flhwwdV+TuMSjBI4VPUeVA4YB86UjSfY2z0X2iPfAw15UpSZnfve5W4EEjd6I963MuqakkBfTdsJLaf1SuiO7UYwQU7M3jpKHFGo0A7mDI6Ws9w4u5sW8xCeGX1gvQ8fus72ZqI4E41tnO75NJhJHN8i+sKEWbOghJeSh3PakOXZrGYvHf5i1B+eYpqti+zCUjXBEJPpYqZXCYiwBJtjcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yW9Mp8rfG+egUXslVApqU8z/EuFt7TU4ivgC42uibfY=;
 b=oRO0MqMmRV9RoAFJmwFj6YcdpSrJ4r0gfn7a3pZNMRQxpknactdOuL8r4rTO/QG53bkYgKKTdtUMHspCGQg/G0u5B5fM+XUfj/1BBleUofzR5WthuHNs8ZPdL1u0ZKza4Y22TC1yswswOooZzDjDrtXzwtlEWFuomUkvjWjdJ/e3vDNpSrkoT6bjzWUBgVpYxJaIpsrQQ+Iej+CFJHfU7QKzrdg/R822G4BbPqYEP/hYdlbflra41m//bkC3ZMwC4UNoi1nJB3vNlYZ6y7QL1CrikRQuq8Fu1RcULIkMrGnsbnCon0pisFzxy4JzvfUU7IjezNt32QpzBzdELPUvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yW9Mp8rfG+egUXslVApqU8z/EuFt7TU4ivgC42uibfY=;
 b=ntcYiy/EwqIXrKJRwZ5E4V4C/wbdFaUlKsm66AQRvem3o7uzDYDKY7aTlLH9wEySL3t2LX6W/nvbGRHfPtcAx8x2KLtDx1Rcgh+VpIyOr23KnHrookXBeVanKpjZPxkqWz97hLY65sV9i1b0GcWjkgGaJDS5pf75DQBXMqsZ0mg=
Received: from CH0PR03CA0376.namprd03.prod.outlook.com (2603:10b6:610:119::23)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 15 May
 2024 19:20:12 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::8) by CH0PR03CA0376.outlook.office365.com
 (2603:10b6:610:119::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Wed, 15 May 2024 19:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 19:20:12 +0000
Received: from ruijing-dev0.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 14:20:11 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <ruijing.dong@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: update vcn5 enc/dec capabilities
Date: Wed, 15 May 2024 15:19:54 -0400
Message-ID: <20240515191954.2605211-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.44.0.326.g07fa98e8e8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f604bb2-7913-4dda-3c35-08dc75140b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bCoB+aJIzWbiUbrdhnKPxo2b5yVslykiNpunEQejFo8H5nFAFtG6WopyphtW?=
 =?us-ascii?Q?5yH+YmqzLkBZHMm+0Hkivb6mn6yfT9PLb//s+MABNL1oshFBZ1IXmJYi+W3n?=
 =?us-ascii?Q?w/RbxMzb/Et9uM/XKDJRTSeDm5z6xqmVR5MXk2USsyD64DzU73Y7o/jQ6rPt?=
 =?us-ascii?Q?h5F7Bup0xkAhNOr60iW+WsLid0eHliF6pHiOU/24mZUNy5tAnYbvWIhrbzjt?=
 =?us-ascii?Q?IP98HoTDsny6ux4TXM7qB2/y0pG0taEaot51HteDGLhbWn24MvIDamrYCQs4?=
 =?us-ascii?Q?OgiSLTiKtd6mvcs0jjOXIz46iyGajPPZeVZFqvJch+ciQpJH1rUGTe5gY0Mx?=
 =?us-ascii?Q?TchI1SvcQOsH5Tgaq7q4aXlzghu2j9h6q3BRQtojM436vvT+o0ja6tVEwLfU?=
 =?us-ascii?Q?KixVOuyan8xtCUCnIlT4d2LkxnvJBY5UuOFnmPknNGgf8WANHtmjLy16ZYru?=
 =?us-ascii?Q?Rf62wOU1iw8r96MVuWUTTeD4l2zfLP2PsNtp81apoVAPLSw4SwFhnuH2wemJ?=
 =?us-ascii?Q?c7lpt+gfjsIuPFQamlWiIdkL1hAVPHo6GBTyTTunaIZU23LFlSESaXZQj/A6?=
 =?us-ascii?Q?vqW90NsHbe+RWUau0ZwMYuMvWwiiy19zB5Exb3g76J2iWpRAQAZ12GDzMCEU?=
 =?us-ascii?Q?RLQdSfUNLAB8C6RWEPCx9UbRT6pYO4UejywKXH60hImVatxwS+k08X3g2pkW?=
 =?us-ascii?Q?yxNOfAnKjfQ9wF2nqOzWKJz66dDURl9AbpiviDEOx40go4ePw9RRp1a6CO+0?=
 =?us-ascii?Q?57AG1csT+l+zgzaDBYQ9rOG4fR4WzJhbVQ/jouGgNRk9iaPPCYUUoXK493o+?=
 =?us-ascii?Q?E5M5zRrRbHp34e1YGUOSGZ44G23A8WnzPvB5XS3S8njTp/WMnSTE3viSUDfu?=
 =?us-ascii?Q?/R1Qv+eb8dCB12OOqw0A4OQkRr7+P/gPQrQXyT2ejkgSqW5k4fPCHw1G1EtA?=
 =?us-ascii?Q?9aeieGVc/Hybe6+QBaoD/EF0ujPxhH2zBUJ9lPNqTx5s1ODCESGBRosOYmXo?=
 =?us-ascii?Q?ivEH/V0/gru3pgc2VXwCbgLTC5thrOY6xlXGEHpa4Lhqm/sZLFPSAxFuhIC1?=
 =?us-ascii?Q?4jnpwSc73n1yNNfq/KnFvJ0cvk+KeafgEBZTlNcibDUBIsin6+SPMjjl6YPB?=
 =?us-ascii?Q?rwkjVAoNZxICuxVXPIbvxkYK8QSpM5PZuXQzOOtyt0ruP0QQrnT5vuBRrE6/?=
 =?us-ascii?Q?QkQ6rqHJimQedPi1KKSD7IxuZnyYCl2w8IS7EWZBY5a+ohSfJp5OylObcR5e?=
 =?us-ascii?Q?8tyWo6zazn1gaJk8YfOfO1yEl4KCjnI3RS3OzgQSXWcOG94hfxY259WGGu2W?=
 =?us-ascii?Q?YYaqaLuCb83K4ZHjT7Rpi7yvyICMtnjhlkpHptnX4DZ4KUyvLXlCvi1x46vd?=
 =?us-ascii?Q?ZGz8svNPDHuhvsEbLVmlSjGFesCD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 19:20:12.6059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f604bb2-7913-4dda-3c35-08dc75140b27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
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

Update the capabilities for supporting 8k encoding/decoding.

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index b2b9e0f83bdf..d065649c7c78 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -48,9 +48,9 @@
 static const struct amd_ip_funcs soc24_common_ip_funcs;
 
 static const struct amdgpu_video_codec_info vcn_5_0_0_video_codecs_encode_array_vcn0[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 3840, 2160, 0)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 7680, 4320, 0)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 7680, 4320, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
 static const struct amdgpu_video_codecs vcn_5_0_0_video_codecs_encode_vcn0 = {
@@ -59,8 +59,8 @@ static const struct amdgpu_video_codecs vcn_5_0_0_video_codecs_encode_vcn0 = {
 };
 
 static const struct amdgpu_video_codec_info vcn_5_0_0_video_codecs_decode_array_vcn0[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2160, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4320, 183)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
-- 
2.44.0.326.g07fa98e8e8

