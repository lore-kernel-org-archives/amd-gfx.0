Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A653AC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 21:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E3A810FB4D;
	Thu,  7 Jul 2022 21:21:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BF210F8BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 21:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lk0pT0t8dI/mpLi6MP56tCVD87QqwhGYtTNO4SAYddvBzFNru5O4LIhrPxHv2uZyk3lX+izDOXXHouqfgnuHBGJctSYrel8YpQw4v9hIJWXTZqy/NGNpLGcJy7YktLs+1PX4zzg+oyntR2M1jzHKkUijkbgMEVrO4E4uBCZgUUi05fNBhC2udTTB4RN0Zlp/3zBvxgGh2tZnJKy6VxoEWuMnxX8W15qW57fo7dtKgVc08AkOZb9v+pGtpuSs6vX4ChmQ4KZPNHBmx7QG2KXJZnx2YjQIPw1vvTBuZk7yF6/eTwFBuFdmbreqaPqess5Vk1eFTtTfVflVMzGOgNG2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnJarCJXx/rRvjSyV79mWNBGsAefwl+1gANJvKQqxu4=;
 b=QXoQjM2H6inA0GsyubObKqflCpGCl78dyQ3rt70XK8jmcBh7Cmd2/K2MSkPvHY7y3EDNI7B5pvMka1S54dUd7vJwYpdAWb02YNyPhs+Vstol/mvRBjJJBUv/6/UJ+93+1Cti66xiAdVOdsT/J7uj9lIpTgbcyt0oPPHe2g/Fpf7pOh/7MImkLqZDWB7UUDkXE5nHo/dBMyIPQ/SGy5mGXLo4HOONNh6hiWUrTrEWXDoer5h+crCGhz//OxI+DRIgPhlmrWr62Nh2fHYn81woDd6W35rCSuav6oDJluH9bgyk1s29cDeUs56ExMhJQf8YvYNA6ssuGOuuHsd+hzd7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnJarCJXx/rRvjSyV79mWNBGsAefwl+1gANJvKQqxu4=;
 b=U/uO7MLg5DPYMS/JSwk7ZuP5DP2T6ABzZHiM7odEB1ZLndyn9Sqx65Ot1fhqq2tPGRzWMRqJ09nINa33eCgJVV+hpmDIxm/GJqwQu1IwiTBV0cNmWaLH3Z494cvYbuHbt7SO0/l0GuHYYMsymZ+i27frX3b4cUZ2uIhEmEBDfiM=
Received: from DM6PR13CA0061.namprd13.prod.outlook.com (2603:10b6:5:134::38)
 by BN8PR12MB3332.namprd12.prod.outlook.com (2603:10b6:408:66::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 21:21:31 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::46) by DM6PR13CA0061.outlook.office365.com
 (2603:10b6:5:134::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.5 via Frontend
 Transport; Thu, 7 Jul 2022 21:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 21:21:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 16:21:30 -0500
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 7 Jul 2022 16:21:29 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Revert "drm/amd/display: disable idle
 optimizations"
Date: Thu, 7 Jul 2022 17:21:29 -0400
Message-ID: <20220707212129.1642908-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e885b9a7-30a1-4c3b-5b7f-08da605ea943
X-MS-TrafficTypeDiagnostic: BN8PR12MB3332:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKn5Hmgz7oUBvSlOvo89czKfTmU+7dmP6wMD03LhSF5HpcM0ndjDr491Xuda7J8EKJcgO4EbSZNj/EP3xlYOR0wNo3qbwEQ4pKz2/JTPkkUPVz00cT9xYceILv8KDAC7z5QFS2wjpbzya6h6PqxnRhYt30as0izgxvMOYDU8ziOEL/EPWhbw1Mz8axdM/6WNN+xDdLR3cHBpaDPd6W+SSTXtn5VXkeXc+gel8uFnTJhtaKg+zjixVnJOFA0QDmV/hDMMO+6yDQAERp0mD4IoHUYWVMAi2DX6IHikyCFXcXyhCSZcnA0KVBTMXvgVXnGlXBgeJFVL7H3i/Wbb9exoSOhuVmedLP4MV2W/LgAOTw7FC61Er9F6nBJ3r3UYIUUr0NiDzGmFYT38NQnwWeh10YoBVSQDMViNJt7E+2DlquhLowjCVmNme+4rM7ntllVNxjBdXiyQIJGFx08PWUVGdeINyDBflgtXvUEpB0AJcXogZuOXOSVFCL7/OEMIeEaJYXbCBLFUb/Mrj3Bj53z80T8rF8njJ/x+92/KXhMd24u0U74oGILVSquQsHvkmJbuCJEn88DO7ES/rikb/sU+kXh+ONHzxuUDW65tMuMsjrCjrQvlxZAaj+ZwNNMAdl7zCITCJdYNh1l28bp2yRSgRooGxPiZRo7IY4syxVLxdTpkP12AzK91fq505jwEvbjmofuTtXVzK8gaXl1f0GuP7f2+k+p0S9PVlX0C+sXByP1szJ/Xj7hqudkiqjCmJ0YKHx1n1IOYy4C/6JAQ02Pw6ymPVSJZhDnkkFD4oX7OM7B0vucn0iAbZGC3h2QP55O3SdbOSZ07wYQUyJQkuIeEa4IJ58wURcHI4SUYXCBiLX//KCAz5+WcAJk49J93aZ5C
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(136003)(39860400002)(346002)(36840700001)(46966006)(40470700004)(186003)(336012)(26005)(83380400001)(8676002)(4326008)(478600001)(82740400003)(70586007)(5660300002)(70206006)(47076005)(356005)(81166007)(44832011)(86362001)(8936002)(316002)(40460700003)(82310400005)(2906002)(2616005)(41300700001)(7696005)(34020700004)(40480700001)(36860700001)(426003)(6916009)(36756003)(1076003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 21:21:30.8208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e885b9a7-30a1-4c3b-5b7f-08da605ea943
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3332
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
Cc: alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
 aurabindo.pillai@amd.com, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit e7ef5569e71bf3fec01ea513c27c6081c0dbbc64.

Idle optimization was disabled due to SMU and firmware bugs. Enable it
back for DCN32. DCN321 has them enabled already

Fixes: e7ef5569e71b ("drm/amd/display: disable idle optimizations")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index b166ab187264..6e829001b53e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -972,7 +972,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.timing_trace = false,
 	.clock_trace = true,
 	.disable_pplib_clock_request = false,
-	.disable_idle_power_optimizations = true,
 	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
-- 
2.37.0

