Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F65CE79A8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BBEA10E430;
	Wed, 20 Sep 2023 03:21:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4968E10E430
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOxXfiMqV9uyK7SM85CPsuPvyNY9LUxD9DbBrJ2BbOvWUiShnWHEqV5aYXXqQX8WoTGNIVyDAiQmcYCPOKWx/eq1HH/oi+mihk8edukmT4Kn6VhYMxjGQCYL2inxf/cEYBgfxeJdHa9rjMwscsCgAMo88XF6Vy6XaJvrMavK7OviI+rivKJUt+xX5cqOrPEcidjHpUrKulwGE3N3JLICJ5HOOpYWJPbhrf9LHfC3iln6VVA3UCCbb4uMas62IzNizfmOiq/6t1WlOPnAKh6QGR5Q7LXd/hkHhIH2Yn6mDluajhl07P5XPz8AFoQ63XAlJkI2Rdm0RYNhKJBt1MeicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYC35U+JNjhzTy94drxKmZMAv521HvSZLIPjrc2fS98=;
 b=Q8WmSh5uq1eyA4G2GILgqzKmxBbxhOuZD9+OmoMh02Km89n2wwhtNjEVa/xSSTHsC2uZxnsOSvfdPcAa9/GRSzpK8CvwllH5OcVlrbGiDRm0+0/d9FSpjtLbmaI71Ggi/iqwqUJYxB0Cl7sgSP/BzYezlaABOymshc7O3oi3xrK6kC00WHaS9c5sg8LukUMddZn2JbSLXaTgnUeIyMI7o38DjaSLqpxn+Zv/b91v8z7r/AXRxqyLmyZBErsaMTg20qlKvvhGCtSIR9WCvMGgORVzhZlYUMLdyxCZGIF2VzggBJZNmqgfbxUp9l7bQMmzmFAVsiuzXIwhf2Z84/BEnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYC35U+JNjhzTy94drxKmZMAv521HvSZLIPjrc2fS98=;
 b=2fCNL1GTK5AFkSuCSVz13/OBtRzGMsAmKpuHhWJFblYO8AtXly2nP7ROxsoxb6UAJ+7opYA/JiGh2Ce/KnSKwsfYBxYrP5ktlGFMctoINBd/h9/nyL0okmvo7CG9D26LWrqQlpKSu2CL3awpzwljz63KfJtYdFrLJknHvGmE89I=
Received: from DS7PR07CA0007.namprd07.prod.outlook.com (2603:10b6:5:3af::25)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 03:20:58 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::bb) by DS7PR07CA0007.outlook.office365.com
 (2603:10b6:5:3af::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 03:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:20:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:20:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:20:56 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:20:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/19] drm/amd/display: Rename DisableMinDispClkODM in
 dc_config
Date: Wed, 20 Sep 2023 11:16:19 +0800
Message-ID: <20230920031624.3129206-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e86f76-0b07-4575-4b55-08dbb9889b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFVMKHiLTkXq1vxzZXe6aqMF9EqFOT8SRN4Ki2tAL0LXJa59uSQzcREKem3Ohix0zfbzXZ3NCd9nrwGqv6ihiyHkqR5bppIVcql/UAksE+7q+ze416/gsNoFWv/wGmmExslzF/Qy6xya3aVNs44VUzScMHrx+GfAloJf4lujsja+b/Oq4qK4Idx32lWRMCDh4NS6CG1BEFw/fctYn5+wQAS2DMG55VXqBMwkRnwkSmrB1cVpX4dDUcMtbaf0T89iWbbgVhzZryEESp8M2lSrWccHc7NtZnbfUuIeXgPitv11xDrbUteNq557KCB3pINoVKPUAUL2wxmIpygoHzFGVwtcqwCyIRgXpP9YQCyrtOIDeCjvUvFJTrPEp5zd7Hl0Dg5pw9zfK8oj7vRJs4GVu/X/HbvfsUhJE0/a9VUEcYTCAn2VIBhsa8BSr+eBCrefKJuHJqAD2ZZDc/uGDLFr/DZ1k0syOUMxK7wa4IzylTvK6S2GzdG8jaTUVJRzGHKKWXVrvpGTL4EzzzUJ43idFNyfSjPdSzPrRacqoAXVCLPIzN/AbRJCkmlLfTsV3YxA+L/anK+wFMTub6jZPLXpUJx/e5wJ0vR0I1hiHJSfXRtV8wOaiOzwperGVIYH/c9AXNDX86Iggl6qRnw04v6Cb3fO12QnnRcFZbWRJmdN/Dk3i5uYIK3rG4Y+d2rZLpk+sR97Sa8wFXTxdZTRX6yV90FYqNNlZAMOvMGq0De9haUQPHxp6VbcRbEt082dJQRGOJpjpbzZwXEfcVscIeK9YA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(82310400011)(451199024)(186009)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(356005)(81166007)(82740400003)(36756003)(86362001)(40460700003)(70206006)(54906003)(6666004)(5660300002)(4326008)(8936002)(7696005)(70586007)(2906002)(83380400001)(336012)(426003)(36860700001)(478600001)(26005)(2616005)(47076005)(8676002)(316002)(41300700001)(4744005)(6916009)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:20:57.7843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e86f76-0b07-4575-4b55-08dbb9889b80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Gabe Teeger <gabe.teeger@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gabe Teeger <gabe.teeger@amd.com>

[what and why]
The logic for DisableMinDispClkODM is reversed now that odm is
disabled by default. Renaming to EnableMinDispClkODM.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4065bb061c85..53555ec3b4be 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -421,7 +421,7 @@ struct dc_config {
 	int sdpif_request_limit_words_per_umc;
 	bool use_old_fixed_vs_sequence;
 	bool dc_mode_clk_limit_support;
-	bool DisableMinDispClkODM;
+	bool EnableMinDispClkODM;
 	bool enable_auto_dpm_test_logs;
 };
 
-- 
2.37.3

