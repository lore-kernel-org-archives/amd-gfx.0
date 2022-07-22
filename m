Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC285C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761E792F8A;
	Fri, 22 Jul 2022 20:44:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A7492F8A
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bug1qnZDfFfOTK84us6/kE5/T186HC/KgIQ4xy07uo0Z2LQ3ugwvXPIuoDEYSFjXNOhPJ4pTglr0tbE3iXriqdl2l100hwXyO43oR2M4bsWjDpXq5fqg/y72HLzUaim3k0s8ecXfm16dSJkxE1oZ8UtCJLrgP7puksOwmKrUJsjnNZotsgRwzUqBbMVp3DBuQ3KnB67jleWR5Mfg1mlcllOhuxSC6DDi8qdmmh4qJx/+UY+vi5wXm65wd4Oas9ysnkObuzzkOHsge8uU2/kJ3v1TQsHqnGi+bbWFfsOT3FFcs/yW1JFMu81B69TCR3DMMEQY91prpBB6WWt9gGiR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTdcu0lbb0rUbRZx4hfTKxlRqnHNPbSRhSkoljkfHBE=;
 b=VuWPcS009I1NZVGwQggOTjmgycTrpwBD2lqavbFVeKAU10gRh0A0RlDsSFynbL8Em46E3hHfK0ubuY76bxVWBORZjakzP0fVvNRP6P5PoVjGhwzLHkXUanbyWeoQyIXsVsqCBB0kmcyRzm6ymvZGbcybnjuHXe7LN9nYCnxo484RAmxpY8J4rYfu0bbqToRl6a39zDYnmbmwrRJzSXtwUpzAgE00H06bYnfGhpQxTEMy42Ne1qrQdm6Bp/VzOnrG2gY0hE3T1y453NnosOZHttXNe4qYvIhhAwUek/1UAaCH6bNHv2CkHUWQqpHuVR3wSSfIezpFJssBazdS9ln5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTdcu0lbb0rUbRZx4hfTKxlRqnHNPbSRhSkoljkfHBE=;
 b=FDU9xUiBZkP/85ADB9boFAcckhIfAaSsMoyMJ+0QEMjvdScBM841MUr0iS47IMsAYtA3Mt1AvKPaWdFcX4c6pXxWUl5ZBHds299UF2N9PhuBfidv3rAu6gE5JwZdP0z8rWIEWKDx1XWzAnjdVdKoNaJNmpUADl6FJfxUempb/do=
Received: from MW4PR03CA0203.namprd03.prod.outlook.com (2603:10b6:303:b8::28)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:43:58 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::86) by MW4PR03CA0203.outlook.office365.com
 (2603:10b6:303:b8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Fri, 22 Jul 2022 20:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:43:57 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:43:54 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/31] drm/amd/display: Add debug option for idle
 optimizations on cursor updates
Date: Fri, 22 Jul 2022 14:31:35 -0600
Message-ID: <20220722203137.4043516-30-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99e7c194-6f8c-4fc0-c5fc-08da6c22e67f
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8KezXDYVcCCjg+LFhM4XMqLVrMFIYkhHgdBRNOyS/N9aQFccRS/tJYoJz+CfJKVB1E4GJ7LTuKXzzTIHfpN2oSAPZEKteg66XMvT/2UTmxccp6P5I4fpk14TBveKG47zpVJl0tadsIgS6xjSSDuPEV29JGNkQU6an5rc8GH1k1cLUDqDaUVLNVvKaI3VRA59yZV3Hra+TPoBycRSlc4ADo9tTOLyCiHZ5rndwXyiaQk4/N+ZPszxMyNSgQ3DnqTncchSu2hPRsG5txxrUTHOTidzQlaiDRq4FsbOXQeYvgtinuymgB6W0MgIBmU1l0mUjdo/fbAw3Fh/X55tAp8uURjGPuAZXgMWfxxqCwnkxTNnVNaR+WHlV1M5xR4tExjsQEPwllPr9jgmLs+Zl4L5vLIotyR7NxntjzRy9ENHuts3fe70SwcXF5qqwbsIqznEJ+XCeu3e52i05zw9jPtNqsuaJ0rKTULzwGzS96MiynkkMX29/xmsGg6YsxLRHiAA6DkqKRqUMrArwn9ns9zqnOIWGorSqeA6H4lLPzftLln/+wME2mmvskd8ts6igQlP81ziskEwM63bLmu3NFLYR1E33k/XQoPpk23KTLCUXjKKP+yfyI7nrTVvJ4oZH2EK5jTm/XGmPMiWHLUgEpO/cUtk06AwYWqMOb0bJJJbLyoL//KkWe1HCXxOBi9E7sqDdZ48J05NNk0gJ8H1gOGialZmcBp1MfEsKNrLzajqrttFXH2w73hNBNPFdoq9q43NBOLOZTDL8ynj3VBNdiiVm9Nezs5uSGx+g+3pxNMTZWt/45C7kmjExmz8MGP+3mDkDV3fxUQyIsIU/gfAcp4l2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(40470700004)(46966006)(36840700001)(70206006)(70586007)(478600001)(4326008)(8676002)(316002)(1076003)(40460700003)(82310400005)(54906003)(6916009)(40480700001)(8936002)(2906002)(15650500001)(5660300002)(44832011)(86362001)(36860700001)(36756003)(41300700001)(47076005)(82740400003)(81166007)(83380400001)(16526019)(7696005)(336012)(186003)(26005)(426003)(356005)(6666004)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:43:57.6292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e7c194-6f8c-4fc0-c5fc-08da6c22e67f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

For optimizations and debug purposes we added an option to exit idle
operations on cursor updates.

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 2278181ad3d6..9a26d24b579f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -868,6 +868,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.use_max_lb = true,
 	.force_disable_subvp = true,
+	.exit_idle_opt_for_cursor_updates = true,
 	.enable_single_display_2to1_odm_policy = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index ea5160d0c92e..8157e40d2c7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -869,6 +869,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.use_max_lb = true,
 	.force_disable_subvp = true,
+	.exit_idle_opt_for_cursor_updates = true,
 	.enable_single_display_2to1_odm_policy = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
 };
-- 
2.37.1

