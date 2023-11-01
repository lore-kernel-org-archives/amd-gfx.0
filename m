Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C291DC4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 20:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 791A910E783;
	Wed,  1 Nov 2023 20:09:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8149210E784
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 20:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z99mDI7PxzHUlfSrxOJffiOmPxewk4s9NC0z0qU23RFKVf9iObxv3/9g3SR4z6o0UQ/J7MF1EfpFzxEmBK87YHsXqNyMF/0OQtMwQmwDfcSW91eAOdDkmmo5L7JS0mf1ubOAw8+CvXvXcE1U6G9Jz3oi1Kr4cDRDWFCBuv6v1o3okDbFE9DRhM4MlXrkkpjNIbYe1fpZJfBuhgVcrFZ6DHky8ZUVwFavNmEJGUNoVfxuuu5N52oFU2MAzjbrvBb5RzDmzsZn7irtFJkpQBVhOg3FF95wlO+U8EGAlG6ZLGkmgAKEIMGfbfbmmok6KLADH5mQTb7fkJ3wrILCPQJByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQZigOOPG0e23/9tkZcRBAX+XpEBENqedFYYz0Qz7cs=;
 b=B16/If8s5AFyY/RjPbGGUQ+h+Y5WhweVD1tLna0/hyM4SLuFmeetfMtAGvX9EA7a1rzOdefLDoqxtSFGwUqzd2t7JrncUe9m8xBtaImfrVJuDeEJKKYlqsRa3vQdDE6QjCscRJO8Umw5yA/9dKkEGMEhM14Vir+VXYTtpFx6GyAKsjY0E+XflT6m9ESP55idLEY9UBVwVi4mUCp/t4I/kwg7/m2LmGywaj99lZ49OH0SgbyhLJ2c5a5G7vvoPFPhQ+pSkLhe1AeC/Lqung4OKhxnoP+jK+IhBLwWhf8f8yT81GLmWchiphiwu64FjRG2ju5FU0L81Azs94DEiyNwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQZigOOPG0e23/9tkZcRBAX+XpEBENqedFYYz0Qz7cs=;
 b=xKTqiirj5nA77SZhIE/Lgp1nyTmQtJZcPvqhat7Hshphjbrg2x+WsqDBr1RKRLHmguIruFteHzoe04A9drWKxWRbvEa43MhRAUt4HcEqi4smFMeYCfaYaKjcbDxlAunQV1/QncbT5fv7Y3SFMr5aQKLmDSdhJ62JVKPW2raFvgE=
Received: from DM6PR08CA0060.namprd08.prod.outlook.com (2603:10b6:5:1e0::34)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 20:09:07 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::70) by DM6PR08CA0060.outlook.office365.com
 (2603:10b6:5:1e0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 20:09:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:09:07 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:09:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 13:09:04 -0700
Received: from hersenwu-Majolica-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Wed, 1 Nov 2023 15:08:58 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amd/display: Set stream's DP test pattern upon test
 request
Date: Wed, 1 Nov 2023 16:08:29 -0400
Message-ID: <20231101200832.995436-10-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101200832.995436-1-hersenxs.wu@amd.com>
References: <20231101200832.995436-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: dabf1c25-0dd1-4ba3-667b-08dbdb166793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObpvG6kRF5Xh8xDJYvuCzVEO+aSAl+HoQFU2R+QHpbMzYG17LfaxXqShrISzSz/S5FND8mv50fsaj6UFsxs9HpVqWf/ls8g7oWMwrZ1TmRFy+i23uAkqwVuOQpDwW4CUV2tAsYOLagFvyyMnvfruCEJ+XQOSJ0S1I6doEB5Ye3AA9N5McQYFHDu3KGvvij0zPy6SCWWvycTvx16dN4k60lpaJ0MZApE0I0mtwsUZ9L9FkVh8bbDGQ/7AVdbS1yyhW9QP5+/Zz5+OxwXezFPIGOyOJ8daHOcgoeGJeAZtjiPLUCvJb5/Ea8KJZ4JQguuCpqH7G4lbyQAE5gRAumtaajj7qVZw9OZFccNrh5RjPwQdU5RbIXpFEv6VHHKIg1SvDY9c/GsmBhqWZnm4ioDAca9w8ihpxo40ZerhZnoxmXyJfI3n73tQQvVtmjKlusBZG62sVC4RT0wWBEqJam0mpu56GISopu+8L7v7XglqJT8NGDvGs7A9ihoDOoGNJgKUNTVy7ByQQ95ta8Kf2S+F1bjTT4xUfMFkSK6q82JtEF9qxwc7ScQOotxFfyDN+LUQfO1W5ZKrwR+xMECzNiIOXpINxrPZYMO74XrI4JldzmBb+AQCuUp7CIAp+OvBPZb01dcGSyjs4ZG9Daq8szhBfS9yOy4gf3cjmsoUciKXMU30yw+cVynkn/8pkqFb27ZrSYR0DP0kMyWpKcQclFA3583rpi2XGSqZSOFulZSFi/LQMeQ08gxP9wPE2aCEuRDrUCV3Qbes/TNDiXoMNZjcVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(6666004)(2906002)(40480700001)(478600001)(40460700003)(2616005)(426003)(26005)(336012)(1076003)(36756003)(81166007)(82740400003)(356005)(83380400001)(36860700001)(47076005)(86362001)(7696005)(8936002)(41300700001)(8676002)(5660300002)(4326008)(6916009)(70586007)(54906003)(70206006)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:09:07.3877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dabf1c25-0dd1-4ba3-667b-08dbdb166793
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
A recent refactor of DC's DP test pattern automation code requires the
DC stream's test pattern and test pattern color space fields to be
correctly populated before calling dc_link_dp_set_test_pattern.

[How]
Populate stream's test pattern type and color space fields before
calling into DC to program DP test pattern.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 9cd83b780102..ed784cf27d39 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1216,6 +1216,9 @@ bool dm_helpers_dp_handle_test_pattern_request(
 
 	}
 
+	pipe_ctx->stream->test_pattern.type = test_pattern;
+	pipe_ctx->stream->test_pattern.color_space = test_pattern_color_space;
+
 	dc_link_dp_set_test_pattern(
 		(struct dc_link *) link,
 		test_pattern,
-- 
2.25.1

