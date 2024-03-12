Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF03AC54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C6B112A5A;
	Tue, 12 Mar 2024 09:22:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fax6JdFb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93DAC112A5A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko+5UTQyjptym/Z/qnl6ShYjcO+oXTVDWDXA3e8GvP5/NM9OyAIV7mnBerqAxT9URCQx8FbExiN2l/vIMTvoFzfxuapUj2LC3MU58nrCp2c4UmOrcb/grprjqV0NZUG8/J+iCP+yErc2ez0d1nUwVXm/FZ1FDWWQM30A9C1cqH4y2Jmd1tww5MbyHbb5Ke40J7DqQYm9EuMhvOU5osjSeFjpkBgCVkH7LH/COIhGMUDwiPPARpTNa0GiqUTQ8rTHCrAOBBW/BgFzFvO9CPOYmmy8tPROJe1ShpOolvYKavyqc0GNI6im500iGl5QjuE641zstiEkee+ivTj3a8k19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwkN4RHEaaDo7c6cAxIvZG509zrULyZnct63E45+bQE=;
 b=cK+XJF8YT3uSb9IPFvOKS7pBbvM5b4F34nAyYsjVVEg6vpWWn8bjIxw4FR4HJxy3SMEcbiT+h6epOYsdUkD5IucyW8ehjch7MixTc26gSyIIvo60D22qO9+O2vH3mVkyTRsqCS8olSQqfgaGkmgnjtr0TcEqwrAHjLLaoxtYM5YdTqQjHzeYkY2+3+HS0R0yxiHfHLAMKEMofODMdNKRgu1bdKV1ipp3UGoiev9ZS16p56oCsc+FWkjm2vVPfMrArtXLAQBa4U+2kuo/OIVn6N4fifPqWz1gyvfwLWjOlYp+WXiyFabL6We5ub1FgN8SYc/Xys8BNHiFxfd1o3xA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwkN4RHEaaDo7c6cAxIvZG509zrULyZnct63E45+bQE=;
 b=Fax6JdFbvdpR92Hj44xn5/j2tahyMogRdYyWkUX2ataCwRUOr2NJhY7ayQSfJGrMLi6+GCjXOYfxd5tESv2cGupsxhTPwKIyssWdPiIOMZhgnXPkrxQt58MAtA5lWDfucEgpGWcWAiXYesjpknxu0q1j4vOz7HnYVD7DOx2Tu74=
Received: from MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::10)
 by CH3PR12MB8534.namprd12.prod.outlook.com (2603:10b6:610:15a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:22:01 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::3b) by MW4P221CA0005.outlook.office365.com
 (2603:10b6:303:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 09:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:22:00 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 02:21:58 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:21:54 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sherry Wang <Yao.Wang1@amd.com>
Subject: [PATCH 10/43] drm/amd/display: correct hostvm flag
Date: Tue, 12 Mar 2024 17:20:03 +0800
Message-ID: <20240312092036.3283319-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CH3PR12MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c215c8-79a9-4a5f-d8a9-08dc4275df97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/+qL+JqAvtG9s22lDZedLNn8eA/PfAJemA4+RXjulxOfq+6gifas9p/QvwCBYySwiPINm0zZr6jvlB2MWepLoU32cf1f5dIfpMKiQqrd6ZhU9Mf6zHIOKoRAcpsdPYOd3uJ9tNhJMgf9C0p1qwX+7nWie+dFDBZrM37BIF/9Sgj78kYme1758ctyLqFaWA2Kxu6Ag8Lm3z3fMB663eam20TgK9087mFmrfFAAc6hicYLsMVdXxS8I0Lv4RZoWcAH7yzOcIQVl4Fv+jvPKnYfuESDxKphIQd9e9/vjgv94CVUgQvZIrxyKF4/rA6gAzqw09JH5wTlvs5N1/ttYPQ3XE6F2d1MZJRRp6i8ovWUfm4u9sCYNcKiQM+TmNFU11PrxGfZW5Lvnpy9vL86LmVTnNrUCwuP/+6+LDwxsnKIDzNaTYqL6ZKVXrEreGR7/wYnxR59rMSeKzUOhPM4lMYartSDt7u4cVqU3xFst7F3YiTjf8yhafFe/Qgi8oRhaEGchXeiSloCgTU0oeraNMCd18fWjC8h73ABxTr8mhS8j3D1cyZ7lCfV/j2T0XnuGgbNHEEKznXqwtyvlr5IayjArHzYcNiZhSOV5yTmvRpoqpP1jLf3pEbHCHgXrwoOs3D/rtcBvArQ2Zc+P9YNEEU2mv/gPSfVB37YUHnR7t8ONnFWUeaxdhhaguLarWO1OZms5a1oiyzVkmnb6xYX3GkAWxwxAE2AaWcDPXr+GNw942lpAIZqOHWBHb88r2XTcBl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:22:00.8238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c215c8-79a9-4a5f-d8a9-08dc4275df97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8534
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

From: Sherry Wang <Yao.Wang1@amd.com>

[Why]
Hostvm should be enabled/disabled accordding to the status of
riommu_active, but hostvm always be disabled on DCN31 which causes
underflow

[How]
Set correct hostvm flag on DCN31

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Sherry Wang <Yao.Wang1@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 04d142f97474..2fb1d00ff965 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -892,7 +892,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = true,
 	.enable_legacy_fast_update = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
-	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
+	.dml_hostvm_override = DML_HOSTVM_NO_OVERRIDE,
 	.using_dml2 = false,
 };
 
-- 
2.37.3

