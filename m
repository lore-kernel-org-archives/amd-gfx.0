Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2B0CD1296
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBDAC10FA1C;
	Wed, 10 Apr 2024 21:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y0d9rymm";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D011C10F948
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du6AYi6fgNecMuFoBji0UYdxMYIq4j/IQovcXX1HIBFyvzQPWVKOaGBQSEzPjgd3uc/P2W5xxWXeByMarAlt5hYpAjbColNV9EfUZLZI4/JTgqg8XKtmKZ/t37RHXUEF5m/vsD/2vlEMdEefrxJxT7C9HGCDwXaYhv8zhbAUyRVjaAnK7R1lAfoHMrn0GDjo6ulwifKsY/85TlEJ+domUby32Nj50444U7pAhzVxsnOdWdcLAKswkb/xlNnCL+bA69l3XcvOaFh6GQF3Al5mjuNkarlRTqHdJfgvWl2um36ajeDz1VcsFIQDhiJ/33OG+JF8D72rS+RPy/wU8Nae8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2OFvl+YdFY6nVAe0yVe/zyGnky4zPutx6e5GUN3FIc=;
 b=AKr4E2sDM2D1P11uF2NU1n6GE3GS1CEAG5bQohYe16nP/eOQP2tMxTPRgzA0kpN8ukKzT2nVg9H9wcacfQTIm5h2ZkCiRupUGEBkowkYnYY8UZBAjp0Gu3ws6f3e71WUlRSyaiSI4ezcEpAcwHQQqK/ZOpa/BOIGAMUQcvI5L4vPPLO3mMZesy5h9mSFz9PhEClHt5C7+xnuF/Uz2+GnaiyjBnGgtJmVJ1YZKChcxwFmCFTfEWPPhXVztZRV6kOVqLK/U5+ihDbWH93VNmWUg7L8cumBVsIyCk8am5rMrVKQ4UW1aSZ53j2Vr3EcV8i4dPiyWonjtXVfnf+cueYcMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2OFvl+YdFY6nVAe0yVe/zyGnky4zPutx6e5GUN3FIc=;
 b=Y0d9rymmGDE/wx2welrAOvbLeFyeVSN3Ke5ZQxSNi9g/Lgb30pWEDMWoeFcfnlWxRGm/+QOWwRPJzhAt5y27xcV2WpOO9zZGHDtlWhJQuQWimAciO1bKmgsGinpNbQhJbvLbRlcXyKD/5Ksx4rp3UbG5IoYbcyrPaBCfGJAXTaw=
Received: from BN9PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:fb::15)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:28:17 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::ac) by BN9PR03CA0040.outlook.office365.com
 (2603:10b6:408:fb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:17 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:13 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 15/25] drm/amd/display: Group scl_data together in
 resource_build_scaling_params
Date: Wed, 10 Apr 2024 15:26:04 -0600
Message-ID: <20240410212726.1312989-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: b276f85e-e46a-498c-3c5d-08dc59a52369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33CNCgyvXfSj2gMe5+8lNba9LxlHzMgg3uMnc3fpHW3GEO0o22zDI/2o79Vk4ZMwUO5xse+blOpJglq98rIs8PH39ZX9tH7qGzREFSfLZyd3L8hbUMHxovRE1EhmbvIFI4hyMrASDKN/jHzmaXhw2cwzpatvFIN82FIkR2lT6w2Da3BgHXqCLe2uNJE5ZHhKax/SNnMRlHWrA+0QDwOVELzEOszMx7dSRSnP9bIoD978Pl1MavRd5r0xV6cp9HQYmP45p9kcYde6IXRN9WUcZiD7do3DdM9FvEt0xfOblbuSZzHNx3I8V+Oh206TeZn73lWKE7AbJc2yQbvEHKU2R5m+QayBxGgwuR+RLAWpYBuKq3vxLegHwwI8VdBtlyraTU62NVELLm8sNY0J6pmepnb2TZyid/kY7nwHu3p5dBwF2sI6gQ2aYtm0ZMdr6HbhV4Kx7p29Nr1/vrAWE9aNjVIrwicmswbOTXoaXZtnLWVzFtzODD1Db9ySSYGXnWd89fiizmOvAHwSiUYXwgqVZgTJ0I5cPuM5UjqZ9QtfLyfVmOSuQrH4bodzyxam55RZ2E855LoPiJtQ+yQLIE0nybfxn1W24HbLMQllPCEPMW/YDD+wdTvv7I68dMFmtUzKp/f6cdX/3iN1kM7tgmqpKGecYwHnKwlUroQLxKQftEjs/HQAIpCz8ddDRSZ4DeMhWedS6+gg40ThXS6sIjucnUnad5B2exSoxUQjFdkjX/MBceXuC1xl7CZ7KkmBUuW3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:17.6936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b276f85e-e46a-498c-3c5d-08dc59a52369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597
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

Move the scl_data.format to be close to other similar parts.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 2633e481234f..876b0e5eda95 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1500,9 +1500,6 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 		return false;
 	}
 
-	pipe_ctx->plane_res.scl_data.format = convert_pixel_format_to_dalsurface(
-			pipe_ctx->plane_state->format);
-
 	/* Timing borders are part of vactive that we are also supposed to skip in addition
 	 * to any stream dst offset. Since dm logic assumes dst is in addressable
 	 * space we need to add the left and top borders to dst offsets temporarily.
@@ -1514,6 +1511,8 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	/* Calculate H and V active size */
 	pipe_ctx->plane_res.scl_data.h_active = odm_slice_rec.width;
 	pipe_ctx->plane_res.scl_data.v_active = odm_slice_rec.height;
+	pipe_ctx->plane_res.scl_data.format = convert_pixel_format_to_dalsurface(
+			pipe_ctx->plane_state->format);
 
 	/* depends on h_active */
 	calculate_recout(pipe_ctx);
-- 
2.43.0

