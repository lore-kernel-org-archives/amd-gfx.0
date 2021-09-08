Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA7CC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5EB60724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA5EB60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F4E6E1BE;
	Wed,  8 Sep 2021 14:54:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C406E19C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIX/yW+LELFWiCNSEaNoopsAIN2rU4aucp/SS0vRmi40vlTmHlcIVItyf+8jb+Ad2zhRveqz7GgLQ9JLFPL/SRIAVKamcedFS+z4c5P82YliPZ28NUfwlJMCpq1jQD3MTgQ7NrlpKyhVCdW5XKAb0NzOhN8zkeOFvAgEggWKCHtfcIe0OcFBozFmYjVZNALAeJ7yBXf4z/VEwJRuVx7UOPnARIug1MhhjmsYxvGjuzWX+A55jRDspWPLLSQQlZp2WOoWPh8NuFg2nQ1KQnPCB3Na03h7ajEZhVBZr3UAvE9aZQmwzznXCrbuYNsT7MdflTivbso1A+lE9eN+fhl9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ZK58z8akltD6KQSXrzpAcE3+x4wKSway2dWbYmOp4jQ=;
 b=exMVw3MXTdYYpXeFJpDAZZt7KML7ae8SEI71jN+hGCz11mbX5nVS8S4kajJDo5fYj17jjY8Xp3LZKbhMxpkM9B87o8i3e8d8SCw5OH+7AP0rkVwONsV/4YDCroeKz+SYp8+LvaTFYuJZ/ShdMxToj599EtN6I9YpF6PM8XwyFCovOlPT4fOsmVkUvGugIL/54dlCcQ4892jvI5L/oeOiPlTr+s3G2BrzX4u5Otk0K3jcWGJ1QVqpLmJ1LMgq62cxNfiBfN7V42h/x5m5zxwNy0zgLQH+EVIdFiykz8k6k5sWWGRad+JJ4UNYe82+pPlFW5VPJx3vXpbMza04feDVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK58z8akltD6KQSXrzpAcE3+x4wKSway2dWbYmOp4jQ=;
 b=JVFb0t/h3QFx3qUfWKHWZyqFSfLrFgqOvAgmgplHT+e+ATBECkWbKiV9Ih4gD/NDC4TDaUp+wg448+gajCUyu4o9qdG0/h4WuN3kd0bWoIM9Sx8kKHxfyTsX+9P38JS3qsUtTFiizeThbovZ+YRhJBw1h7cSM+PqOy6HNCQ+twE=
Received: from DM3PR12CA0127.namprd12.prod.outlook.com (2603:10b6:0:51::23) by
 DM5PR1201MB2520.namprd12.prod.outlook.com (2603:10b6:3:e9::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Wed, 8 Sep 2021 14:54:39 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::90) by DM3PR12CA0127.outlook.office365.com
 (2603:10b6:0:51::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:38 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:37 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, George Shen <george.shen@amd.com>
Subject: [PATCH 04/33] drm/amd/display: update conditions to do dfp cap ext
 validation
Date: Wed, 8 Sep 2021 10:53:55 -0400
Message-ID: <20210908145424.3311-5-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2c37974-7e12-48c8-579f-08d972d89507
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2520:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25206208E451343E43CC0775E4D49@DM5PR1201MB2520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLCv+Y2Gld5XOlSTN7NI3meef0z/ssnhSYKeHCUX5qZoYrIUtaoTvAd/UHndQnige0aqKg9NZTEIxKzN7sn6RZEXS9a5GxPFMPR+8TSGeNcqq/ZGQY87/RNMsD0zHM/ZH4mMfO6Y0eUqF3dVzve/IzCpZE45eds3quI/4wlW3vlRHbmz1cA+nOhczJrItuZBfF7pJH6WaZ7M8N9a/dlUD7BHKG3CEEc3AqOkxFClXHzKLBp2vovIjYS82tUbjJOQoSnTKsPsGYiIl8dlbROC4qmWnwoOpWXAB4VkGWe66xbwQTzU1JdkeJ7qqdDJmNdLzJEtIOrGo02xy6MG+tHSh+EHxShagEOrBoPlXlcovP8MCL/oYZwhYsxKsAohzUQVmdRnTLHnf2eSRjH//D/uZG625plrZpWuJBgJJB+pISnK5wlof1YDrwyIZQlD6SlKiYj40aeq69xLcAiDyN+sswwZDWh0FyI+r31rBJ8IcHu8iTUnrTMzQcnVnA0MrHLSHB2spbL/afdlQsxrB00G3mYdPBpVBQS/cA66u+/W6G6HvGI6Yr/WTC7iXWKajWko4wKoEsg0rerVifpzb0Qvj6Ee4Gx8zMGoR210qgNHWNxQ1gNWAm5avhwdgZtAibdSmNv25cVFFNvSYHb/52bV/B6rkfGELM5qzm+Qe8+sR/V9WdgY2Vh6i2ZH+uPqAAM8h87hftQkP8YyiGsSJ5lE7l+XiNv/54/Gx0rbJDLbHcE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(26005)(4326008)(36860700001)(6916009)(47076005)(44832011)(426003)(2616005)(1076003)(82740400003)(70586007)(5660300002)(82310400003)(86362001)(186003)(83380400001)(336012)(81166007)(70206006)(478600001)(8936002)(2906002)(6666004)(8676002)(356005)(54906003)(36756003)(316002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:38.7495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c37974-7e12-48c8-579f-08d972d89507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2520
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
According to DP specs dfp cap ext validation is only for branch
device withou 128b/132b channel coding support and
downstream of the branch device doesn't have compression.
Therefore we are adding conditions to only do dfp cap
extension validation for branch devcie supporting 8b/10b
channel coding only and it has no DSC passthrough capability.

Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f1c9ee53ac67..5d9460e0dbab 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2606,7 +2606,9 @@ static bool dp_active_dongle_validate_timing(
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	}
 
-	if (dongle_caps->dfp_cap_ext.supported) {
+	if (dpcd_caps->channel_coding_cap.bits.DP_128b_132b_SUPPORTED == 0 &&
+			dpcd_caps->dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT == 0 &&
+			dongle_caps->dfp_cap_ext.supported) {
 
 		if (dongle_caps->dfp_cap_ext.max_pixel_rate_in_mps < (timing->pix_clk_100hz / 10000))
 			return false;
-- 
2.25.1

