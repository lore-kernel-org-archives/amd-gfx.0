Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FE6CE79A8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDAA10E42F;
	Wed, 20 Sep 2023 03:20:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E230E10E42F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDU4goChAZFJzJz7h8E2wXBdxxPtbtSwLXjW4cHv3ua5fYpOVsiB5YpyjlWpGjQIy6lw3eOsdPyFVYpi3urrjtC9u88tWSnalGHTH6mqReJ52qzz4WG+U970Nch0SdZ57C701oJU5gqhrWl4KHWXW+tyJ8m1e3tYRYC4OOeRAXkri/x6/ObH6VD4dX0UV/P/0ZHfWxOsLyiMApxy3ImrMCy26iBf6vVhosuZwik2JIAonTqjALNk8kybJH2hza9MKgxTpslsUzHKjIh0xzbAFRplWgjLsKpYIT1aaiS4JQkXAxMFACEXXRXRNWB2R6cqNmARLdDvgZB6PWRqT4gsUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sgppkaCqTXQHd4R9sFJ8lmbkRXLXosNdr6lvHqd3Uc=;
 b=ZpRP+CVivUpq+I7mjUqWydmHKJwZ7kG6+TEKKlLvhWGPVB3Mi5hRHWQhYqrBKnVFpsgqIZ9BrHhNUNAaTgbA/+Dd69B8tk7j+5qZjTwLYshwrQvDAKglpe0sxASl8neS57R8SVFdTHTNes0Cy6aCPNbAkhaLPlXP8fEAFDZleo6X7/w9X18cu+dnOZcZiF/OGnngK56CfUqb+ZWWLfk9oROYDc3MIluLkfDuDRwGIp5/LvsX+IH8sv5hFb9hnf2Vbsrao+3JsbQcd3bFeLiPOGJ5bc7Q10DIfG7izWgGsFaIGq7gtE5oUITdmRllunfKzE/nBglOqIbBCA7QpJ364w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sgppkaCqTXQHd4R9sFJ8lmbkRXLXosNdr6lvHqd3Uc=;
 b=TUqICPrjg0vf4UolDpwpWxA55tzwKFHSd2dfTTyuQ4mtl6OeXG+2gHss0qIQqeKeQqEU/X5DnH1SpNczYEII0od4WI+ihSVj5UnY/Qb3NMqLcbvzrA2wcnXsc3SGoG7K4GLvkHhQGo+RoLC4XE2wDANgXrk2qWXoGmvMJNQl3Rc=
Received: from MN2PR08CA0015.namprd08.prod.outlook.com (2603:10b6:208:239::20)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 03:20:52 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::ff) by MN2PR08CA0015.outlook.office365.com
 (2603:10b6:208:239::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:20:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:20:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:20:20 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:20:15 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/19] drm/amd/display: augment display clock in dc_cap
 structure
Date: Wed, 20 Sep 2023 11:16:16 +0800
Message-ID: <20230920031624.3129206-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: ecefb6a4-6ad5-4654-2328-08dbb988980f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dO6GQyipfihOngrluSp1FRQyZtt37KUDL5JsJ2sBjF/+o2i77WvgGuyN1/y7Et7w4JYNwRvPlWXl9v3kCsoftk5FF2ZkUmwfbHaS6kJ0QeqOR+pvRN+vIJJxfhLLalKxv577fn96Z0+wIiPontNF0R6OFDClYXdKC84t0qOa/hIz7mluezyLr7pNj76XvVko2BGDmteweK6GwULevVmSXMNJOch24f3CkRFpO59InAwx6e01Ztz+fPNUdfaQxHgH3VfTeTrvX1lVcJNVpWNSueIxa1aKwvHOydRXFncCWBuelStuP+w0Gf5k4JiUc6G/wWDD06Db9xgQtyW1bKDQmOzmSOMoAusvBDcttB02gFlGxZs8OcXzB/ig1lHeA1alFGmKl/yqK5rycfFhwvOtUucjxGpagtDepLkTx+7BVk7SQr2ekYbFyJL6CbDtFsSIvAiOBpNvq0hXDHXvxwmlXC5iAV+IWBI75J+RxP9yC7OFlCAh4lwJJHuDwDc91DzWqEIeW1+Ptm47qmZVNyFd/37HX9yJwCKtzjqCRv4i+TpBp6ukYLRP1TDCZXMo/gfipddX0c8g140MFAg8UL+GqMscU5ltReYSmeLgOh15Mg6npB6zlOo897LxoBp6TBQJC8Tx74T3yltzREFwWLhD+Gf/H7ntjtrRx80lt2J1h19v5Dj2sPLcyg1I+9g3skgEU0ER80au3oAjHoO2elufL1T/vAC7jFBB720qQiSyVaO118uvE6cO4Vwf7yrx28xUWFPl5yR0kAt2Y2cKEihAwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(1800799009)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(356005)(26005)(1076003)(82740400003)(81166007)(2616005)(8676002)(8936002)(40460700003)(4326008)(83380400001)(36860700001)(2906002)(36756003)(336012)(426003)(47076005)(40480700001)(86362001)(7696005)(478600001)(5660300002)(6916009)(316002)(54906003)(70586007)(70206006)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:20:52.0408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecefb6a4-6ad5-4654-2328-08dbb988980f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Max Tseng <max.tseng@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Max Tseng <max.tseng@amd.com>

[Why]
Allow dc report maximum display clock possible at vmin

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Max Tseng <max.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c   | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index faf897ac75d8..4065bb061c85 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -270,6 +270,7 @@ struct dc_caps {
 	uint16_t subvp_vertical_int_margin_us;
 	bool seamless_odm;
 	uint32_t max_v_total;
+	uint32_t max_disp_clock_khz_at_vmin;
 	uint8_t subvp_drr_vblank_start_margin_us;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 4d0052ca742f..8b1691152f05 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1912,6 +1912,8 @@ static bool dcn314_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->caps.max_disp_clock_khz_at_vmin = 694000;
+
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 67ff19d4116d..10ae1b3da751 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -1832,6 +1832,8 @@ static bool dcn35_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->caps.max_disp_clock_khz_at_vmin = 669154;
+
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 	/* read VBIOS LTTPR caps */
-- 
2.37.3

