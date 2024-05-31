Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BED7C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7186210E65F;
	Fri, 31 May 2024 16:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XN7cd/qD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B64DA10E50D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igTK1Mw+REQuKW+XSbIZMqs7eZTRt0NLCztaS9AW2PScNPtgDbhMPRx0bzpqSkl5m/d1okF5zuA2zdcmbmMXpqzOFcz75XJqetGdAccl+duW00FqoRoZDqIv1zYvGPerrnWuDmxkB6MAFkB3C3+C1XN9gE0m6FVOIjvnCBwr8cXU31QrAyhdKk6DFTFJkcZtJut3B9eRWOK4hFe9FLROvfYhzgK6rSnaCo+W59n3ANh+ajj4+cW+GjFdeMK+68BWv9qX3opHd2vn4uq5ETgRCmKV38gnQYwG8+ZRyI3BKJQMwKnKiTyvyI/2FymIaFqIHz1LqIJcYVNTkPHWj8sUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31QFUhRMYfT3B6G1mBjRzJRvimL0iwaLzZC8GxCuKrc=;
 b=I+SOqJqDNWUZfVjP2OE4BK5yAljlXjRH4xX/s85SiNe+4r0JNHr6hAMCP++HrjyiWWgrS8+8vG71/43hXyhIao0B7sjPjJsty4fngMkoi4OsU2LvaiLzfwXYbLnsDG0PvFmCxNk1/qTFFLI6veFvbkYAxStZyNQe0HNBbBvJK4wZb2TsLsPCUqtTKo7Yh3sm2nH9chtWkIIkHvSj1/kumj0oR9Y6BzbkwFh3+OLRTK5xoR1Pmo3YdhvzvWpfEEn9q9MbI38wPWHtX8eDM0WIMjoEY5UySWXs2Lrjpj1iPkguYJeYsYwx0eyNzr+l6jqB3p3scfsJVe2R9aPW+02Xog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31QFUhRMYfT3B6G1mBjRzJRvimL0iwaLzZC8GxCuKrc=;
 b=XN7cd/qDt4c99m4TcRcQhk0myrfuGJfCsxLGIfJ3WV5sYGDb2cZccVLcAgU8SZr1NXYJ8yVAZ/0pkN/aPLOYnzgWgJTViCfIfYEKZNAmiEPfrRaw5drRzy/6gMm1+QZs17gMIq1yIBP6sHcfrujOxOqoBTJcvkX8JzgLRWs8N3s=
Received: from PH7PR10CA0001.namprd10.prod.outlook.com (2603:10b6:510:23d::23)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 16:52:50 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::4) by PH7PR10CA0001.outlook.office365.com
 (2603:10b6:510:23d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 16:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:49 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:46 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 27/32] drm/amd/display: Program DIG FE source select for DVI
 before PHY en
Date: Fri, 31 May 2024 12:51:40 -0400
Message-ID: <20240531165145.1874966-28-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: d69ae664-b8f0-444e-ea6d-08dc81921ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bSoePdjOtZ39cNpN4qVf4JZCIQBXIyLdWV8b4hXOyybu2oD7SRrQ6EYVk19P?=
 =?us-ascii?Q?ManusRGqpljYf58IIX6pV+Xg32MYTER/yMYMSy+8PIPFtMC1IDTNT12doWfP?=
 =?us-ascii?Q?APBHrqcJ+/6AT5/V1NbNCvExwXTbhTLkzbntLQEphqEpw9xCL+e8lt8qgEGh?=
 =?us-ascii?Q?DwNarT/iosmY6hl8pq2XRREdlwPB7UYAzEyPHvgFkwb3F0SJwJQvXYHljupz?=
 =?us-ascii?Q?NZnBkjkVln22PuYCa0tb+U6EV6a8oJjYT/YQl2m9FdxvN4pzKLihrkMn7Oej?=
 =?us-ascii?Q?YU89OO02fZRwtKB7oPVI7Tv2IqShE0jl9G5kthVc9WSBbr5clmqU5stpZspc?=
 =?us-ascii?Q?otbnFiWn40xccVUF2BUC++uCpeqJeSPFI+W5qxIoEtS1cZGQ1w+Vjg30aRJR?=
 =?us-ascii?Q?xYn9RJZHo9t+DOfxgnIET2DC1aHZbjl5sgFu6C8FO+Gv1T3FHvuz4vr5XONf?=
 =?us-ascii?Q?gi4qZPPGMYvu5tGmzgMSQhNNlnitYkCK3yMFpIMZTu5YnBfWcgI8cwHOW6B7?=
 =?us-ascii?Q?jEk/zthHof9YDHmkHE7RvMSsNKeEyhrnH1QgeEvqz6fTAXkgfjt68eLbBBaE?=
 =?us-ascii?Q?N4GbHX6WA6cuXbTyKMEbM1AKGW1MwMux+y+hZq4chAzIxx52RKOwxCS2KObE?=
 =?us-ascii?Q?tFDw0oDkYfYcSGRrnYhpz26+2z4wtvBk9c0FllshmZfwKFJKb0T5MQB+jfh1?=
 =?us-ascii?Q?K2Cj8Q+de84rwwW1U+p8iQsp0JD53xGdJDUHgSr3lzQncAX0UZhXv3eW0wxM?=
 =?us-ascii?Q?965a72tFVDfCDTOkBBGB/DETkeH7/sTjfS4euLMvcu/6YZGhpXbGk41cEmLI?=
 =?us-ascii?Q?24Y8DmiN1q/jlNYhmjzcwutnzqjxmpzOR89/TNXpjEJuQvUXP04Q0gP0s3X7?=
 =?us-ascii?Q?LfySX86UuxHbnvD9ZTzpZeelfREhjHgfrQlM3JlZVpdaylmyaZFmnDwVNBMY?=
 =?us-ascii?Q?zbMwiF+0GPadSFksejFAoLOgohm/dmGaiDRJn3M4XRy0sHHGRt4qu1j2qwWU?=
 =?us-ascii?Q?SESf/B9iy6s6sNYMF/qaG2ousho0F/50cb06IquGluKnyylXfMDbOeXbOGKT?=
 =?us-ascii?Q?Qiyqg4hD5EHJxM9/WsM2s/s+P6iG7fPr/0qGME4IAtLivmNpAYE6bcFMNbKx?=
 =?us-ascii?Q?ahOoSYSnqUZ7EMP0kbbmq/2D6SJdUupqoSbt5aufjY+I1Z99KhLOf/jBVir9?=
 =?us-ascii?Q?OaNnn1VP2nJ7Bo217+y/vSzE+MMz38X/uCnYvqkD6IteCANU+RTYEmtJCt+Q?=
 =?us-ascii?Q?EG4GwDlx25yfhgA8f40td1cCQbojIgq/NtsoNBo4KURLCzUy9FiH1t1sGLrg?=
 =?us-ascii?Q?fyRcBwtQN5HhuhH6+OWQWrGreMxqBsQcaKfYrsnnljNBWPmt3ViSupMX93cT?=
 =?us-ascii?Q?mxslGLwT5KDmBvyNw0vmQcqgPUgu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:49.3085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d69ae664-b8f0-444e-ea6d-08dc81921ac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
In newer DCN's the programming of SYMCLK_FE_SRC_SEL depends on
the value of DIG_FE_SOURCE_SELECT. If DIG_FE_SOURCE_SELECT is not
already programmed at the time of PHY / DIG enable then the FW
sequence will program an incorrect SYMCLK source. Ensure that we
program DIG_FE_SOURCE_SELECT for all DIO scenarios (DVI in this
particular case) before going through the PHY / DIG enable sequence.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index a9ddbe12142f..65607589495f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1976,7 +1976,7 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 	/* We need to enable stream encoder for TMDS first to apply 1/4 TMDS
 	 * character clock in case that beyond 340MHz.
 	 */
-	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
+	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) || dc_is_dvi_signal(pipe_ctx->stream->signal))
 		link_hwss->setup_stream_encoder(pipe_ctx);
 
 	dc->hwss.enable_tmds_link_output(
-- 
2.34.1

