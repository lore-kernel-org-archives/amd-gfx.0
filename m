Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37FDC001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43DAA10E4AF;
	Wed,  2 Aug 2023 06:52:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5244B10E4B1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv8hErqgQB2J3S/qqti8u6K/oJl/gBJkMzKTSUHn4Fh914v+mo9OUO13WgyngZ4/lKvFtO5qKPZh3Cl+WsSXupSQ+SBQk7bGTF0HZf6SrGxsCijG2lErd4RxHK9FbqQHbFDoBgE2qUH0sFgj50sJladSzDQicw5JpY6rBNREznREIwmkPCPP0VJsUUYwXB9nqI7KFLZB3s3L1/YmsTQbOsa/mSL11+I8sca0MjTAmS6/K0B/4DmVgsKO0thZ5FhUaF3+QXHNV2qa6coXpJCHxCobJdu09KxLgDO4XFKCdVFPirx76R6TNV08KVUnXeVoAuz2lm8XoUmPN4bQi6gR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bjeCKoBqIILwMHGq8pRCXFDYWMed8dh59Po0ba9Ngs=;
 b=DdAbZPJA1XjNrZ9ZddkfiRo3kO1TVx3rm4EmpYR/ZqsPyGXUgaEPRKblUvost/n5ElIzATufWpZhsyeD3us0LC9hPLMq0UR6k1uPnLLkVm0Tx8pl7j/7Mrr/WyJJW1ecirsK0v9fXfY7thOi92wW5BgYcSpDJo1Bb3Z2zRT+qAi0Zgw57mnbvnokf/HalD+W7tfZE2iZsLnO6UIi/4Cb9Iv964B2bzCAl6lv7tAG7DUeMuWrIAmW0htYm69ZP/hWxm4l+51Q2qQND4C7NYe6CMXpSxMsnQ06rcPU/lYVcdvk1ZU6f37w7N8cpprBhbfLNAjYJjo4GxHBkjKk0h2cTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bjeCKoBqIILwMHGq8pRCXFDYWMed8dh59Po0ba9Ngs=;
 b=rRXHR4B+sOaHJFZDKQL3iqFL0c4sfpQmDWqLXVGlRDK981hw6luq6DrGuifv2W6aJFmBDMH2aSDZEl4ITFVs+qVmT9speVEyCC5nsg4MYWnnA4T5pkbNM+TLn3A2ml1Xs35zQi7R+4oFqz9pRghpeTZP4P2mxiJ0Lg+xx7GwD1k=
Received: from MW4PR03CA0156.namprd03.prod.outlook.com (2603:10b6:303:8d::11)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:52:42 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::57) by MW4PR03CA0156.outlook.office365.com
 (2603:10b6:303:8d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:52:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 23:52:29 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:52:26 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/22] drm/amd/display: Use DTBCLK as refclk instead of
 DPREFCLK
Date: Wed, 2 Aug 2023 14:51:17 +0800
Message-ID: <20230802065132.3129932-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: e00393b4-dc6a-4b97-e052-08db93251112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLGUGue73iDnbgwKwj+EPYB4ZnbRzaq4oGXr6PONQDKmfJ2Pp1DRWhim7CuwulVIlEqLQoEj8OEW3Ihl9aj+xx0hvLph3b23ltMSLGiqU08qh/qegPmJ5c6dzE+YpcymGSB4If6jIcyleld/rlJmk+Jll0ouiAMTJR4fbMmO5f9kT1lCry3yN1K8vi5BQeXAfEwn6NLFgo8/9dt/Ffx7ZLVWRYBueTS+CQHTrzh8QriG0xpqU1R9VS4pgNxb25K6KcU806Jaw/FELOgcy9iyr0TGN8Bo3GEdfgCgUTztzlgZGsRlK+/wbdGc+XuboFjQsZgmEF6fRNQzZLZJ8rUBAfAxokxtxQmjzdmulkIY2HMLsYnMHAixZzAIr0jQ8YaA/B2AlKUsimEFPtmsqANxaY+1P2xJeX+MY9GFssS5du5X/82oVZcr59/SysrBCHtS3Gxp2hNu5gz0PjE8rqZSkJHHCIFkhNhB7YszWFOrGJHrYP/ETkj6nLJ/4OoiM78e6h1xuCfqlY4XwnGYIMfnMO7fFWr2EaXZOHkJMP3Zm+nNzQYE/R6ZBS7JQS4Qobr2nFqTD3YlzvNGsJ27mry9WLYcNRoAKibMzm67aPYbmn9kvmjHQP39dLSll7AvDSmWakMFrjw91POErv1q8qYBH5j/+uhUUpoemIM/NywXifmO1NeNoThm4FNyZyO794eEpKCekR/qprsE9uS47xelsljFfJK5tF0ADuI8jM0qlgifNJJswLDVteqWlK4wq3mutH7+iTCOHj6lQ5WjxuzmHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(36756003)(86362001)(82740400003)(356005)(81166007)(6916009)(4326008)(316002)(70586007)(70206006)(8936002)(8676002)(41300700001)(5660300002)(478600001)(54906003)(40480700001)(2906002)(47076005)(2616005)(426003)(1076003)(83380400001)(36860700001)(6666004)(7696005)(336012)(186003)(26005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:52:30.8829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e00393b4-dc6a-4b97-e052-08db93251112
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
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
Cc: stylon.wang@amd.com, Austin Zheng <austin.zheng@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Austin Zheng <austin.zheng@amd.com>

[Why]
Flash of corruption observed when UCLK switching after transitioning
from DTBCLK to DPREFCLK on subVP(DP) + subVP(HDMI) config
Scenario where DPREFCLK is required instead of DTBCLK is not expected

[How]
Always set the DTBCLK source as DTBCLK0

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 61ceff6bc0b1..921f58c0c729 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -281,7 +281,8 @@ static void dccg32_set_dpstreamclk(
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
 	/* set the dtbclk_p source */
-	dccg32_set_dtbclk_p_src(dccg, src, otg_inst);
+	/* always program refclk as DTBCLK. No use-case expected to require DPREFCLK as refclk */
+	dccg32_set_dtbclk_p_src(dccg, DTBCLK0, otg_inst);
 
 	/* enabled to select one of the DTBCLKs for pipe */
 	switch (dp_hpo_inst) {
-- 
2.25.1

