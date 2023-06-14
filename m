Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEFCEB64DB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 20:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DFB010E177;
	Wed, 14 Jun 2023 20:42:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E2910E177
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 20:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rko6AI/5A71sgsrnMEGaN+Yra4nvXklexsudDDBdVTSHM8Oflp85qPqLU65U1TEg2EDVQJ6PbBYsIC4xsHlbtEmJcxk9efZ0RMg3YfYrtQdqhKKiabEA2nBiJ1FxXy8OwsMtZyueeZ6dRWxxDWgZRU65B2UiJ7zsYBEHOwnnQY2dO/HrFu75AhWF6TumgU4O7qfGp+lLhhr+qtMUsxncN2hVsVJ/Wlqa8QLBuct5KA1FkdMn2dc93PCaBV245cjRu2zp+myMcdw2gSRPS7hC3rKuo7KMXLsBKkqpXN8V58hDfEG+lH4T6GZjtL4leBQFgtfUoJh5TX2Rb7rC4koMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLLUQN3BkgEvI+t8dUyTIwAUbuXXyDpbMffux7sD4Xs=;
 b=BAuhXlJKUEeNalzc2ha57uDqXuCMbFnv9Pg5diBX+WJQFV8SzxihVczn1PhvrCJiIxlZTuCvAp0z4Awr/3GcxV/PxRfbbetWMp5w5ZJYloaQPf83W7oY8xUKWLqcTW/SbQfhVdND+cAs67C2bmM6sEB3DaplprogAraVXObeY+eJqvjJWH45YZvoaa9JXbSKqwzdqp7D0TGlYp4jg9o6U4J7H4XJflGve6ow9D96cOubv86rOZ6tgqXlWAiIFfUcU0b5/lstaI0ZmVhViUOUktzYVJIMnJ8zAf20bwySizFxHQbpgluxfirzbfXQTVyWzXaM8n7SHoPnc4tR7IJ0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLLUQN3BkgEvI+t8dUyTIwAUbuXXyDpbMffux7sD4Xs=;
 b=jkVCgw7M/5hbyp2IMrZm6KxL/3ZnqWXgF0vdAjkx/NVUCgeqjptoEILspDseCGJVgqwYtOmPB6OyctZoMPNtrWXX9HogYngA6cp2CpumnqMbHXfspazgwder6XcCq7F+XT7TVWuRMsjxYIAmjmtp7u0Jk75fZPMjrEYpmgYhxcM=
Received: from BN0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:408:e5::11)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Wed, 14 Jun
 2023 20:42:51 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::9c) by BN0PR02CA0036.outlook.office365.com
 (2603:10b6:408:e5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 20:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 20:42:51 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 15:42:49 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: disable RCO for DCN314
Date: Wed, 14 Jun 2023 16:42:34 -0400
Message-ID: <20230614204234.145409-2-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614204234.145409-1-hamza.mahfooz@amd.com>
References: <20230614204234.145409-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: d157fa4c-7eed-45d5-265d-08db6d17ebd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TfIHNEEH3Dw+ygToS9f0LjBkiwY3F4Ikm9E0KvN1hg8SLWJU4lKZQAGPI8DSTU17Oq11bijuTCK81hA1d4Xm4Te+aiBt1WscoMVIMnuLy7C7CXLvTMHB0zwHz7UEOS7R12wYYZ09TkDklprHVua5ynyjf9ybHTH2i1Sc7a3cMCKRkfrQok62n6m4+CbnnEsPCd4Q3QlcHD3h8diuj5BGWQQX4b5JKGfCkkDV8DHYzoVAnn4H7B70J3ZdR/FJqlqt3TS6r9z2VHdH6ATW+Z277bzyUU00XJUk88dFS7BIcuHH+RuMxF59Z+tceKfzmgziRTulEAVXTcA4EPROo3LTefLwRHmOstdv0jF3vM6FgE/1E6O2hJTz0lkL+zERyHMv/m4ZVnjMgE0UsC6SyEZyhGVbhs7wDGoV1q1hTKCkCFa1h7S/HbNzdOqooPpI75wecMluRfNcbDu7/MF1HE3MOJvf8AqU/aCc2UVWdRHn23CDjnSSs3cHwIFcI3K6UxTE+LiVdHoD76F39PprdGHSRBJkRqgQMDvkqzHKlkYvmKJfYtvC4poAPRem7AFvALixK9R5zsanlLNxTqTzCmeBdn5J8ZF743FDg1CaSmpQ9iucIQ5LHEMiyqwlbvzkPHcAiN2S4ii6hjbWiR3AYHwfV/wdqwMVnneAYlmaZuhe4ZAL7EYva7vHFyQ9UQduqgYtXImlIuY3o6Q9/sDsUylI+8kZsW5JxqBtqyDgJHfknV4XdAreujT3ElIowZRi0E72zhdoHfpDd+vTuQm4Yi+hko8nRBCDkqvX3xH0feBX4fgQmUV2w9nYZgGmjmeyH8Z
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(478600001)(6666004)(83380400001)(36860700001)(2616005)(26005)(426003)(336012)(186003)(81166007)(82310400005)(86362001)(16526019)(36756003)(356005)(1076003)(82740400003)(40480700001)(47076005)(70206006)(70586007)(4326008)(6916009)(41300700001)(316002)(44832011)(2906002)(8936002)(8676002)(54906003)(5660300002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 20:42:51.0813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d157fa4c-7eed-45d5-265d-08db6d17ebd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why]
RCO is causing error messages on some DCN314 systems

[How]
Force disable RCO for DCN314

Fixes: 0e1961c93839 ("drm/amd/display: Enable dcn314 DPP RCO")
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index cf23d7bc560a..0746ed31d1d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -332,7 +332,7 @@ static void dccg314_dpp_root_clock_control(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (dccg->dpp_clock_gated[dpp_inst] == clock_on)
+	if (dccg->dpp_clock_gated[dpp_inst] != clock_on)
 		return;
 
 	if (clock_on) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index ef49b4d7742f..6a9024aa3285 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1908,6 +1908,9 @@ static bool dcn314_resource_construct(
 	dc->debug.disable_dpp_power_gate = true;
 	dc->debug.disable_hubp_power_gate = true;
 
+	/* Disable root clock optimization */
+	dc->debug.root_clock_optimization.u32All = 0;
+
 	// Init the vm_helper
 	if (dc->vm_helper)
 		vm_helper_init(dc->vm_helper, 16);
-- 
2.40.1

