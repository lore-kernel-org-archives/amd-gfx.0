Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE80EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 20:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1CC10E541;
	Thu, 15 Jun 2023 20:39:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 877D110E19C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 20:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKJzTd0y4VhInSZ5KrGuAVe8xHuUCxs6QA1Ubmtj0kJM+A/eEpCZSt4oM7C0AV5JYzGprhFVce5cJJQLnCrVnUuuGLpELPmTW2VcY8O3vaGSaGvpU+1hOg+9wZsxBmRGfeVBNbAlTnbAZzZGhqCC+FGwpdzHu4yNXkDAQTwtoceYy+lgWn38KtO6BKZ+Vb1oUMKc1eHMVHXQoyyAqhSWVVg9yJF9nbJu9C6XGa7Fz8OvfIH+h18Bym+JsdJle45lPzSrssNHHvH6OVyowvj5Lgtsz24XKHP4pkvV6UyK8cnlWzG7d1K2VHyjKAwYP3TgB3PyL/7px/w77awNnC1S/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CS8Lx6X2lPJJnEzJroQ6gMAjhSXVEkRPQoS8zowepLI=;
 b=P7CYSn9sdUBd3PN3BhVT85DJtDm/sUv8bn4Hk/AGNruly85Tyv9a83o0sYUqbjShD63RJ2+umDPC2EkPh/+7VV37ovKipVVr+SQ9xa3ZVJWXc4u4UZMXd9pBJnTSm93nlFXZhwpOxcXsvLp+QlWS2yIHg3LnybuszuQlVQzuwkogea5waNmafJW69/JXw8nznIJkkbvKlhopHCBFeBkUm8M7KZeCYA6HZ817xaSXCkwQehbg4RjX10fZXl2UvKsNiDXRsVVIrR4ENRmtkSUmU6RPVY9wVuJJOJP2eJ2Yj/spxSutKCQapLa/yWhxoZG4gjZuad4Eq+aYHnduT55D/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CS8Lx6X2lPJJnEzJroQ6gMAjhSXVEkRPQoS8zowepLI=;
 b=n6fzltwAgIZ5rl41T54ZZijEtuS4IAWYmsoW0+bTWiVMVNVABLpgjgctmw1id8Wf0i3bR8H/rnbpp7HrePriDVPQVrLZAgJNboNQX/UJfSZM4QV5OZg11zOisoOc1LomnZqYKc2Bt/Mea4pGheUpIgAUVzz8tDFj3NouxBY3pm8=
Received: from CY5PR22CA0041.namprd22.prod.outlook.com (2603:10b6:930:1d::32)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Thu, 15 Jun
 2023 20:39:54 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::8f) by CY5PR22CA0041.outlook.office365.com
 (2603:10b6:930:1d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Thu, 15 Jun 2023 20:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 20:39:54 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 15:39:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 15 Jun
 2023 13:39:53 -0700
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 15:39:52 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amd/display: Read replay data from sink
Date: Thu, 15 Jun 2023 16:39:28 -0400
Message-ID: <20230615203930.1715722-5-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 992952e5-938b-4ead-8a3c-08db6de0acf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmtZo/qLE26QK5qLPNCQBoVB/f+qzbQkz/vYaOrwNgSosyqcsIDirkjdMttiL+IWHrsxctIbkHnyvjGpGeHJapnC2D4sRrIBM6WQarH3psSBmAuMx9E6DFZDgspQKuJcemREAZac+fd8ioFYxecuO243AtQ7/IalwSodoOR7dX3ppnvB74HwNA59BhIGvwwx/FQ67LR8IxCC3Xvj+tISExwRqtmcxIzezADDy/7ZGpcSVGoW4/5dQMMgz1lgLd1SFoQQcGQcie9eXTBICnwBUixqfqArMt3hlCNaHBuSQM5fXvmoRVmwFZoSQuHlA8MTI/r3jU5krvL4A8izmHNrxWml0hziVVHNjs5aKU8YHfRTWV5hD1SpBl5ZcTVUKQDp0MySBVzeZt8T7zRdjhk2lCr+T8HUvI6q2s2+9OBy8D6NxWMOyGPLQ9zP8eQLBKDthVVWRaUK3J4dQiKE/NcAwM9CYJuI24qZq8sXBSY+Ce7rKEHX6xsSFYTcKQMj8nzgFvWXPdQIbT+EuuB0gIj1OvFiVNrdwtnwE/0YkbzZA8H3SxIqYnT7LG14McI6qDWk8tbl8A3gxeWzHn1qjeUbKnB9UE5D6K+xgEzgLbtPiBFqxXfDQ33YiiJDoJvBKZOJwXB3QSFXENlZt4EwWUSdQQkT+QMmo3KN2oBSfmVlzPlZiMWnPA4dSNaVHg3O8ax976I7GeYl2JN41zpgWFAKepX3xQyJBpDR/ihClM/mhqcjTs7m6Yp32u/OmMB2eaNFRan34T5xfIhYWm16+dNR9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(26005)(1076003)(186003)(7696005)(36860700001)(5660300002)(2616005)(8936002)(83380400001)(426003)(336012)(47076005)(41300700001)(4326008)(6636002)(316002)(8676002)(2906002)(478600001)(6666004)(70206006)(70586007)(110136005)(36756003)(40480700001)(86362001)(356005)(81166007)(82740400003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 20:39:54.3969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992952e5-938b-4ead-8a3c-08db6de0acf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Read DP_SINK_PR_PIXEL_DEVIATION_PER_LINE  and
DP_SINK_PR_MAX_NUMBER_OF_DEVIATION_LINE

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../amd/display/dc/link/protocols/link_dp_capability.c | 10 ++++++++++
 drivers/gpu/drm/amd/display/include/dpcd_defs.h        |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 3a5e80b57711..5eec5d9bfd68 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2008,6 +2008,16 @@ void detect_edp_sink_caps(struct dc_link *link)
 		core_link_read_dpcd(link, DP_RECEIVER_ALPM_CAP,
 			&link->dpcd_caps.alpm_caps.raw,
 			sizeof(link->dpcd_caps.alpm_caps.raw));
+
+	/*
+	 * Read REPLAY info
+	 */
+	core_link_read_dpcd(link, DP_SINK_PR_PIXEL_DEVIATION_PER_LINE,
+			&link->dpcd_caps.pr_info.pixel_deviation_per_line,
+			sizeof(link->dpcd_caps.pr_info.pixel_deviation_per_line));
+	core_link_read_dpcd(link, DP_SINK_PR_MAX_NUMBER_OF_DEVIATION_LINE,
+			&link->dpcd_caps.pr_info.max_deviation_line,
+			sizeof(link->dpcd_caps.pr_info.max_deviation_line));
 }
 
 bool dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_settings *max_link_enc_cap)
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index c062a44db078..5b70145abf12 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -172,6 +172,8 @@ enum dpcd_psr_sink_states {
 #define DP_SOURCE_BACKLIGHT_CURRENT_PEAK    0x326
 #define DP_SOURCE_BACKLIGHT_CONTROL	    0x32E
 #define DP_SOURCE_BACKLIGHT_ENABLE	    0x32F
-#define DP_SOURCE_MINIMUM_HBLANK_SUPPORTED	0x340
+#define DP_SOURCE_MINIMUM_HBLANK_SUPPORTED     0x340
+#define DP_SINK_PR_PIXEL_DEVIATION_PER_LINE     0x379
+#define DP_SINK_PR_MAX_NUMBER_OF_DEVIATION_LINE 0x37A
 
 #endif /* __DAL_DPCD_DEFS_H__ */
-- 
2.25.1

