Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372D6C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D671610E447;
	Wed,  7 Aug 2024 07:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kbp4iWD7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C8DA10E447
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYdUvNyCnrcOlhfeLvHDbNW8nAINGm9Wf8fgHnq3mRv/aWPG+XiHTaT47T0zx6WHs7bZgg3qqdxtE0Xd97idTgMpPwfoiBrNAQOtT+7IsGqPonBJPAqHyREg7mWRcjbpPKPmemXsOJOgk17uvaDdNsRhnnFpCbTefFQBldtpgq0A/SQ9v/nuAckreVigEUxSauYYJ0Of4WNYufdRRH2Rz4iEC+5vGuE9QYbWt+QIhRgCd4uvM5ttKzsWVpSaaKPh1fd0it6PM4q4oifKkbH86H+8hQq09UAvo5f2yvFeAW3EOaqHfOXWEffZw8IdzbmIfmSgZ/wBbmtpSzhOnWLlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyQBXPjSpigSb2vnMU4qLmax91ZGowj4s77P98IyeHo=;
 b=EsH8FL6NKL5UMIZx6ZAM58TM3mW8dSttKee7Ki+QGDaEufXcwaqFHX5FPJwZLbYNKhmoWxsyyhpOYeN0XDChkIGR0hP7CMNcFLEKox5LKBL2ieIVk4l3Yb+oz02c5Qxk0kpbWiEH3K6aIOcw6bA3Xt0ab3Bnp192iPr+VsFuxkQ/iFFILWJN7fLViPmc65WcWLMNit50JP4/K2NJnIyT8CUWJDJX4AsFwRUnZDLmVPGgoekse2UTRXhsP6ufIqwRQchOo69qoL17DTnWiyzhUYexWrCsf8j2h81XeaMVMN64RKlrUolneJ8RHEbKDkHB/7lPNOPQoWdAp4pQRckQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyQBXPjSpigSb2vnMU4qLmax91ZGowj4s77P98IyeHo=;
 b=Kbp4iWD7yCB2a8X42EDNWrgeMp1187z9XAy7In61Xd4THnGZieNrhXZ1UVJjj47QMMmFIjXmXWUyvxT9teLpe50XKzl8+HN8e1KzE6fMfZi4zuMuJ0Yt9KCiqq86OdOPSyQ+1t0B1kKhlKe7ZzPbQ27wH40rS1UeRTlQRxbgK5k=
Received: from BLAPR03CA0082.namprd03.prod.outlook.com (2603:10b6:208:329::27)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 07:57:21 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::26) by BLAPR03CA0082.outlook.office365.com
 (2603:10b6:208:329::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 07:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:57:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:17 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:57:14 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Loan Chen <lo-an.chen@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 18/24] drm/amd/display: Enable otg synchronization logic for
 DCN321
Date: Wed, 7 Aug 2024 15:55:40 +0800
Message-ID: <20240807075546.831208-19-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 451c0359-5b7a-4215-b885-08dcb6b6913d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r+nOAVLb3/tdmSSz+X7nF7eqVFFJ8C24U4/yqnjZEmJVst3e93PgxwQvgZul?=
 =?us-ascii?Q?GfOzCmAyJunz+0lMWLbncHjxQemJ4MlaOJ1GaDkEs+kKKrtqcX1pgzecgBt6?=
 =?us-ascii?Q?34Zd8dbmsGmvG6SVVyffqUsog6BAeUvpzR41gudVtm77Mbq/Nr5VgcrEEkX8?=
 =?us-ascii?Q?/5wdCqdXB9s4j5WU/LGRE4wnHPvNs6h47XhORX6zTPKrt+ueUdG0zBpjdnJS?=
 =?us-ascii?Q?rLLRyzyg1C+WFKIohPAqY6ticZ04a/s/Q12W/X+nrngAYfDwbMX8Yu/Hvs/L?=
 =?us-ascii?Q?axCic9eeNE2qmbYKUusINfUgWrPcdtfN+GVYnW7n39LcCcr9/zkzNYq33Uk3?=
 =?us-ascii?Q?hRgpqMrn+zf4Gw8jQSl/jfV1JcuRy6myrWd8hGsTIcqchtAYXFN93LVGnLzM?=
 =?us-ascii?Q?kRj7hJuHFf80cyGcWM6FbEZHqeoa3wc9dv6N6ba46APokPKKm/pzAS5bb59+?=
 =?us-ascii?Q?uef5gebta2vjqOFgrfEyRJTzqcb8Kgvll3GaVlR8DNGMsaJUDHpulGCi2usP?=
 =?us-ascii?Q?6CRSiojB3wvchYz3htGFOA1wMK5HKBosAhI5ANaLfRbRPaOm+5j9gl4J+YQO?=
 =?us-ascii?Q?xXTv/wb2EVwC0VsXjWpv4rxIJxS5c0XuFfOaj/WQDARQC3maBNhmk2VRPoW+?=
 =?us-ascii?Q?05N33Owy5hydVmMaHz6lnCwXwshPYCad3EMgKLCfpjT5e3R7rCz30UMwepUV?=
 =?us-ascii?Q?lEi0pIF9HZmFHc5NqEoivOmz7wz6sfXdhtuXxIAVyCEXth+IdzzX/jwk2hhX?=
 =?us-ascii?Q?m74u2Gd955HoCVEWxsILMm+q/eVJb/PDCG4RltkCfJSxv0s9MgaIBUgC2I25?=
 =?us-ascii?Q?J9ZILbleatYCvFZs2UyD+CDTnDQOl/ZW1rOROefPZrbb+41tO+RNwoH5NBWB?=
 =?us-ascii?Q?6p5x1yfHI7zKjA8SLeBrVWJWevZpG/jrLGmkRao9/zzsp+Uuu3uraW3LW/cg?=
 =?us-ascii?Q?v4/oivrRSnqrp+CGAxc72dkxSFuYId+6WwUVjNHVhtSSeJd8Tf6GNc9NYK8t?=
 =?us-ascii?Q?FL4TWMoSUiHeh2+yqGWDxftVJ2ul0kznPIm6HWHOFSZe3/tIMOpJ70HqgWte?=
 =?us-ascii?Q?Bny+1sD/MWuyf/uDOP3amtLBlw3pXXJMcfsmbNp8kfLaqihngawwBgThaIeB?=
 =?us-ascii?Q?NcNY5wPRQf2OeTsJidbGABsUW1UajV0J3ALDNaYszHHyRPOtG1AnXxmXZ/am?=
 =?us-ascii?Q?f1QSxQNqE7Di1h3uVfy1EjoZrrgYSkXdhaPQaQVcfwDRebyTxOe7tdIGaBCp?=
 =?us-ascii?Q?asyq8ziTE56V/LXN1fkZpH45xr7hydbAftJhmsEH00Xnb3NtwIfL6PkQDqcR?=
 =?us-ascii?Q?FSWuXmKGNvuXC82qAagD95EEFK9ySCTeGlLMaQ76/7rQrvqElXaBZPehNMeG?=
 =?us-ascii?Q?8pRB+d058XkSidlVCrsSM1ZDAT2AHvGVTAvETiLOluKO+HBIUZxU3s5fgHYO?=
 =?us-ascii?Q?B8dfrDGqICTFUXZODb0QE41TkQTbTj3j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:57:21.6187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 451c0359-5b7a-4215-b885-08dcb6b6913d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341
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

From: Loan Chen <lo-an.chen@amd.com>

[Why]
Tiled display cannot synchronize properly after S3.
The fix for commit 5f0c74915815 ("drm/amd/display: Fix for otg
synchronization logic") is not enable in DCN321, which causes
the otg is excluded from synchronization.

[How]
Enable otg synchronization logic in dcn321.

Fixes: 5f0c74915815 ("drm/amd/display: Fix for otg synchronization logic")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Loan Chen <lo-an.chen@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index a414ed60a724..827a94f84f10 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1778,6 +1778,9 @@ static bool dcn321_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	/* Use pipe context based otg sync logic */
+	dc->config.use_pipe_ctx_sync_logic = true;
+
 	dc->config.dc_mode_clk_limit_support = true;
 	dc->config.enable_windowed_mpo_odm = true;
 	dc->config.disable_hbr_audio_dp2 = true;
-- 
2.34.1

