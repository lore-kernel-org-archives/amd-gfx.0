Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A791E77190
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D1410F082;
	Fri, 20 Dec 2024 21:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W/l3rkTw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD9E10F07B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uzq1U4cZxBM2VV2j45jHE57Bbn/wFoQsWQ/jYHhamguuuYp2FPpV9HEILlFWYl2vscSftbgnWSxPnrL4zHGVLsa6DHM+SxfTFDvfwUaHGnKgrOYwLJDSvSL6YTcRbd2QboHfmfmPgeNrZMV1g1gGfGUSEp7jtRyJ/PKBtEieiljOXMHOdFrR2mpHwwFtU4ph0fAzUmAJUh+H8Y34zOVQNIMfwnl16qA93etLZxvkX7dbuXuRwT8JEI/93SfIThjJbHNFsnf4N3IB7OsDq+qEKVf/LMXo6qrZ3t44jeC/ApW4uFXyHQ65ByzT8gUY7xXvzyCPk6pbRI1J9+c/Zo1bTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Plk334cKfPuM0ydnLhR+p5N69QlH+qqjkpHGhyr/kNk=;
 b=LUSPbC8Vf6ZwAW/rl8AtFohjGhJgUHDEvCIy/On3k1i5i06uPsmlvuMcCRUQ3HUsADYNUqYXF+by6Bswi0sfOG7mec/A+L3nOKALzoL2+h+RAw2vUv6kyzPsHbFd1Fhg3QP5zM73GEJVD8JZDwCylWlFKSkFIBlcaxI9SAeZ1mnuPi3VFqp/I4eYb7dH5YhqO0c3POsJLxNctc77RExUpUbP6u3NqGwyDY6oZCQg96R1sCQTYLIksC0KW/6Cxs5NSzliTVR0APUxWGmCUaVPjMD5liOKUDlt6ATtIpeESKQL96MPkj6gYJDhar9Fz7HJ6Xo0zsq07JEKJ6xmraTv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Plk334cKfPuM0ydnLhR+p5N69QlH+qqjkpHGhyr/kNk=;
 b=W/l3rkTwhsOQIaMPQq43dr4dO9KNhiTpHZvXHicsDEHMwI2mhkgHtCJrYuodcukSfvdGnuSh06tDhwFWz7faAigmZ76U8KUJQu2qIO4tWZDysAWpoP8rhpSpgavc38f81nF+fgJu8T6IJ+THehg8DXu2lYo22lT7GuDQskEMuH8=
Received: from SJ0PR13CA0102.namprd13.prod.outlook.com (2603:10b6:a03:2c5::17)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Fri, 20 Dec
 2024 21:51:21 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::af) by SJ0PR13CA0102.outlook.office365.com
 (2603:10b6:a03:2c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Fri,
 20 Dec 2024 21:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:20 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:20 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:19 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, George Shen
 <george.shen@amd.com>, Michael Strauss <michael.strauss@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 20/28] drm/amd/display: Add HBlank reduction DPCD write to
 DPMS sequence
Date: Fri, 20 Dec 2024 16:48:47 -0500
Message-ID: <20241220214855.2608618-21-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc71a31-c9e1-473b-ed9a-08dd214070a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZLAbxVUCHwkWX/J5U3sPB5moJ2GvWnUU/DmRLnXtlydvH13Pxm4KWmAguz+v?=
 =?us-ascii?Q?5fSa6nKaJkEe3I9+pQMvqbrxp9EL3yDg7IsiZDVpl3IknaOZ8s7peNc23l3o?=
 =?us-ascii?Q?zBzDyzkeij6AMpPfhmqKg/AAt6Y1l/F7D4kx+4anjyl1Up4u+fLOd6SE0WpC?=
 =?us-ascii?Q?PKEnxJ6gsWrz8CY8U0LEG4OvT4QAY9hhKabKMQh3Xok+2BLtKv69YN/J9zcq?=
 =?us-ascii?Q?uoRCjn6qWWlUXPlNQUXDtdGpEeq4vkh5dmsayNQ2w6OsyWwNmH5NWXaXmT0N?=
 =?us-ascii?Q?M+3UiR3Rp/mzqLLHWpNpNatgQ2WYbes9h1I7aEe6TNiX8trtwUjamHsm8uDx?=
 =?us-ascii?Q?/ZgSGq43z4wEZlpOdefKgVh7fwpjj9PH1SIflByzK6BawyJcNcozDg4GytPM?=
 =?us-ascii?Q?mYplMXM7fIBTF1MLmw90z5g8PDGFl6n7NFcfQD4cT28tTOANj1XZOMz+3r7a?=
 =?us-ascii?Q?hZdSZNRLhsM67WFKz+raYmc5y83tSSIUuE1J4nNPCmjCzzH1jx3IUl3LLocw?=
 =?us-ascii?Q?qqzLTrr7FTVF43UM1hcdJHy/hUqI2VRZ3ScU+rni1G16ZFECfdKgG0yL+rDf?=
 =?us-ascii?Q?uH12Ax4XGpbO5Mm7U2DYYrQ4SgcdZ2raO6qM5Pe1yUMt2zaSlbMmjurcQx8g?=
 =?us-ascii?Q?z5YlumzjqkGfFo7HxOt8rlSuc1ILkFDGaqpdiJwSZrUPIFqw6KLcUmUC7JG+?=
 =?us-ascii?Q?s6v1Unsi8mqDg7Vzll2a+pAglsuX5uGDQH72BMVunI3j3P3D3f78CKR7ffQ4?=
 =?us-ascii?Q?Ux0RsyYwxsWEhws980OV6jbybcaM+1bnEBvIknaWHwiVDF4DpgOH799H49mq?=
 =?us-ascii?Q?QXAg2onByBi0Dqon7623/zVmoECM3sMcZYUypFmDDljtze7IR2ifKnvFwl4+?=
 =?us-ascii?Q?VG75whHqKfH/J+cesFo2y7uoSFNN3icqqp/+JVBhwxSr8FBT2DcYuTZ4J71n?=
 =?us-ascii?Q?4Zc4ULoG4cllNkbsVXuMF9o7r86xVI9BsVRiD4oNX2uQ1JArBOIcxY3jHUsn?=
 =?us-ascii?Q?5x/QEk8/AgMNJuHHcqefu8xHBbUf/en3QdDdZg8FC92skT24W7VaNbHwnFZk?=
 =?us-ascii?Q?YljhyBpHsVzkB6TXWQAB3+QR3/iyIYW4WJHzlyOKPBQ2TibYY58Hc/s4mtTZ?=
 =?us-ascii?Q?JVxQsj6hcBgCmCuWML1UG/oDFfcau8JG7qI+o+BBVe8FW6uw0u8oFaXxof04?=
 =?us-ascii?Q?pRDxFl5Bi/abMU7rDfkBxItve2PoLPwatyNIlyRxyqztRttTRNTrTe5qCmSz?=
 =?us-ascii?Q?u4Gie0tsPheGUOsqYSqRzyAvJtum5SBTPdZyO6w1Xw8afwvq3xztmktjzcX9?=
 =?us-ascii?Q?KlvRifFeWlVXJHuzFahHkvRlBuEMXis3nJtKSd9QuYjKSfzLAI9npjb3fTDK?=
 =?us-ascii?Q?CM0SxSzK3qaFG2ZOB6qDgKzSL0kWAv9K7h+E1/EiqNmeTTN2qM1vWR1EmY9l?=
 =?us-ascii?Q?I2Oc+R0UvTd6wYwRy+LTiazk7IoFA9XdLTjhGxnGF6F+BsdC3jSEYTt/ujXa?=
 =?us-ascii?Q?JMflaifLDpbRPcA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:20.6436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc71a31-c9e1-473b-ed9a-08dd214070a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529
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

From: George Shen <george.shen@amd.com>

[Why]
Certain small HBlank timings may not have a large enough HBlank to
support audio when low bpp DSC is enabled. HBlank expansion by the
source can solve this problem, but requires the branch/sink to support
HBlank reduction.

[How]
Update DPMS sequence to call DM to perform DPCD write to enable HBlank
reduction on the branch/sink. Add stub in dm_helpers to be implemented
later.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c   |  6 ++++++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h     |  5 +++++
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 17 +++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6cbbb71d752b..fbd80d8545a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -885,6 +885,12 @@ bool dm_helpers_dp_write_dsc_enable(
 	return ret;
 }
 
+bool dm_helpers_dp_write_hblank_reduction(struct dc_context *ctx, const struct dc_stream_state *stream)
+{
+	// TODO
+	return false;
+}
+
 bool dm_helpers_is_dp_sink_present(struct dc_link *link)
 {
 	bool dp_sink_present;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 2e4a46f1b499..5efddd48d5c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -158,6 +158,11 @@ bool dm_helpers_dp_write_dsc_enable(
 		const struct dc_stream_state *stream,
 		bool enable
 );
+
+bool dm_helpers_dp_write_hblank_reduction(
+		struct dc_context *ctx,
+		const struct dc_stream_state *stream);
+
 bool dm_helpers_is_dp_sink_present(
 		struct dc_link *link);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 6f3e7e182145..ae79dc213901 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -772,6 +772,20 @@ static bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
 	return result;
 }
 
+static bool dp_set_hblank_reduction_on_rx(struct pipe_ctx *pipe_ctx)
+{
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	bool result = false;
+
+	if (dc_is_virtual_signal(stream->signal))
+		result = true;
+	else
+		result = dm_helpers_dp_write_hblank_reduction(dc->ctx, stream);
+	return result;
+}
+
+
 /* The stream with these settings can be sent (unblanked) only after DSC was enabled on RX first,
  * i.e. after dp_enable_dsc_on_rx() had been called
  */
@@ -2599,6 +2613,9 @@ void link_set_dpms_on(
 		}
 	}
 
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		dp_set_hblank_reduction_on_rx(pipe_ctx);
+
 	if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
 		allocate_usb4_bandwidth(pipe_ctx->stream);
 
-- 
2.34.1

