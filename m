Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16ED4C47422
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 880F210E836;
	Thu, 18 Jan 2024 14:35:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80DD210E836
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5vRu+a2+ZbQhllJT3Ac7LY7q9bnr7RcZJY8OX7kG+/hxAp2Fiu1RAMy9LwZdtrmBw8JN7b0bBcrzBMrI4HC9fdrvYJrpHPuIM2A5ukzQapZZkXsss5Q2sbKpdqJdbZ200pcZqmuAq9+5f3HnHYMBUX0dVN01gchoxL2LgBjMBtxUDjzODYAbRI2fm8R/+mzUJVH/BkvUmkuUsRaaChXadGe7WmSlVu8KAMdBpgRHqucUdtb/nlRJx3QFs9aU4cftNFjYv9NlC7fuNQOzFovVhfpAmb9cUAO5rT+8gWJsSf/BTUUi9heCfCvFQ9grzmp4WwkKk9vMrYPxnlzdjfffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR/84IjASt1nPa8baqax6Jgl13dqz9IhpXSBRtE7M1U=;
 b=HXZ4IkiBqvRXpBYn6OiAUtxwthkaOAg7USc9b3bwu1a3zirYj2r1RYBV7FHATlJS4bZ8b3IWqUw2vhmNjLH4+k4UTk5DZMIxES2Aq1s6Ae+bGBCg2fyczHqnhRNYsdlyfRcq1x48bpj51qLfRoUGqfaizYhg8onAPp7AmBZNzqEXgRaa5Ps+Rt0JchcVlI0oa9LUkadxBV120jtWxOfURzpVV88dWgIHV7da/d+x238F5slnSKIzF4aUEELrrsWZRLdT+hISJ0bfNn/V7U86drgTA7eQt+5dq/w1aQgaFtPDaCm5UUtIgHa1DnkML6QZJvN2lswl+dDa/ytsh6TPpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR/84IjASt1nPa8baqax6Jgl13dqz9IhpXSBRtE7M1U=;
 b=Ptd14pV4STwvuAEWeO9D3jXCXAZGQnCejf2s+8EE5d/8mGpb66LZahpA4jH1kxSTl1DupM8bnlc8zKedruNEmUDKVrJtFPhuHkgQAbdTPPD9HgrKhC+m9pcpXpSxm7GTmXGmRTlGxZAed95k7a+CMHRIK3o+ol7T0D5K1JiZ9jE=
Received: from SJ0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:a03:3a1::7)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 14:34:50 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::e8) by SJ0PR03CA0362.outlook.office365.com
 (2603:10b6:a03:3a1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 14:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:34:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:43 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:34:43 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amd/display: turn off windowed Mpo ODM feature for
 dcn321
Date: Thu, 18 Jan 2024 09:33:57 -0500
Message-ID: <20240118143400.1001088-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118143400.1001088-1-Roman.Li@amd.com>
References: <20240118143400.1001088-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 96110bc3-fb25-4d36-9ad8-08dc1832a057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Uda87pivHOdult5WVSpkDnLsvE3UVj1HBw2ZT2gEaFVO6MEwGA/pWltTg+UVJFLPmASOu9Rrbb+i6zU/2kvDjXWxAzbWprG4PgsxN+pNelBomDIfbbG1Gn+lqupfJjwPBpFI6wMmsXpgO0j1gsH6yDtuJgj9UKGkX8bGdrSbX3HouDL5sE5HfuzByWKJx6pvCs5C3+kqutPwbSxYjUZ+pHutwmNQ30Vgkun+7GiwKwle9hjYoK1+vNMEBhKoWjltQhBKXa/vHbxpeqtlg48bK6yuAOMyLW6qHHbWbUrx7uoTuegmj1KYrHFU3WXkUuaRMCqLvwkaI1+yfl+6zBSuuNZjySZmhuq/yGF19JEgkGC4iJLAl+xRaxQS11/3S5EyqYbF0ejZydhLH1iTqvTiTyFUDw//UjyT7te7ZNI2Xn69waIibgiEI7eDL1rufE50D7cRHDuscpJWPDlXRm7Z+o/oO5yO+TvYd2ebHasjn14zmlE2pnSA539cKoOPH2L8ThGNF+63xmlPJ7CZ0ZT3wMmIXRrmFkA2mmG7uVt9WKF2pWfq2qb6xHTVC4gGzJxD+7pB3lkrv2EN7JGzIvhWENi5R2brL2pb/Oe7XjY1t1wogppAKdV5nzViHrxv8MnPRM6YqvRN0aCNngfr9HxXUWmfVet0rkMlCOd0e+IzfyAqKo5ZxfOFLyyZDTOzADyEr8hYXYdjas1HVkhqbYcNF8TCYetGymZrlHt5eIEpvyP3cpB7H9lcn3xIe4tfHMnSU9WZDRuRkq0RJNtUmhhtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(86362001)(36756003)(356005)(336012)(2616005)(426003)(83380400001)(81166007)(47076005)(1076003)(26005)(316002)(2876002)(2906002)(6666004)(4326008)(70586007)(7696005)(478600001)(70206006)(54906003)(6916009)(41300700001)(82740400003)(5660300002)(8936002)(8676002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:34:49.5888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96110bc3-fb25-4d36-9ad8-08dc1832a057
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Martin Leung <martin.leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
It has been found a regression caused by enabling this feature during ODM to
MPC combine switch when user is resizing video window. The transition is
only needed when the feature is enabled. During the transition driver will
temporary switch to use max dppclk level through SMU set hard min interface.
The interface times out and fail to configure the max dpp clock level, which caused
system issue as the desired clock can't be set. We will continue investigating
the issue and root cause the issue where max dppclk level can't be reached.
But for now we have to disable this feature as this feature will cause us to hit this
problem in common use cases during video playback unfortunately. The issue
is dcn321 specific so it won't impact other dcn revisions.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 74412e5f03fe..6f832bf278cf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1760,6 +1760,7 @@ static bool dcn321_resource_construct(
 	dc->caps.color.mpc.ocsc = 1;
 
 	dc->config.dc_mode_clk_limit_support = true;
+	dc->config.enable_windowed_mpo_odm = false;
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
-- 
2.34.1

