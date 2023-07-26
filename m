Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CE8C001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 14:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F56E10E480;
	Wed, 26 Jul 2023 14:37:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9D810E480
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 14:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMHR7V3RUyZVN2QP+If2FJ/WnkGR3GjdLeHRFWuJXkmwgGSTzmefXi3yXC4hANL5PAczly8CXiIxmHTFPO+BA4VhbCF9uMOqQ+95oyjP7vLzOsk/dDbI4BKPRw64hTT3GzHYDUWpumuwzi7yOYMrEwUXuwXJY5fbnERWWLU3V9OA/O2ThXwM5CWPt5ZAsACVIhQuZseoAAMXFlUPEuE5SwsWcFsjyO7Hr1sGOTLEZe6Bk3E6d0JIPxY4qX87yvUUwSNHZBYqEHKYyLGL97aX3onMaDqR8qYqC2qcjG9jiRA6tMXd/Abn8C+mb76/dwtRd9wz6D5esRB4vDpKJGSuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3BbKQi1qMudjBjFHSk0IqVTRPk/o1o8X1k+q6cYKDo=;
 b=HsLqIty43KjUVSHyNRtLJKf7irYaW51P4VqPaL32jnzAZsVT3S1d2WrsimnR+hGO3OEVCZyIOk7WwsUDR8GAAjpKx17puKQhXCxB2q+WiBsEH7lXxW9xME9qz1TcA5+de6qTn+Q6aNIIotyFXg/utABoqQkMDYLuxRvL/foCts0FyvpD6bB7+DKMiFgH/KPIedEVc768fZ0nGgByylbuH/k+eMvAPhtg9BzEKUFYtbq6/NJ4+uzXZydcS8AkbEHuXfj0QWcoT+48VbpKFdy6/uFgl0hjUmvo6Bc6gqan1Yy7zwqXP0dL1W/A5SPkzRYi8kYMAygvi6ugduq/5SE+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3BbKQi1qMudjBjFHSk0IqVTRPk/o1o8X1k+q6cYKDo=;
 b=4AJhBkhwOe23r9z9uZKG9zDctlA+x4qabld/beo5w/NWK8Jn5nh/fgqOmVeZHjd2ZCqAUOpyxAkLclaRwJXIT02DiE+TQX9R/R9pgWoyVEyGz3pgADQQYq2yLvrptAMRJypZPQjK/0Bj7XxUoYh3zjbk9VMu8HDehrX9Ez0RdhE=
Received: from BN1PR12CA0030.namprd12.prod.outlook.com (2603:10b6:408:e1::35)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 14:37:32 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::a1) by BN1PR12CA0030.outlook.office365.com
 (2603:10b6:408:e1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 14:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 14:37:31 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 09:37:30 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix pp_dpm_sclk node not displaying correctly
Date: Wed, 26 Jul 2023 22:37:14 +0800
Message-ID: <20230726143714.3380767-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: f70e6327-c6c6-4c5c-df9c-08db8de5d856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frCKbjF5gwoM61+2wMjznTuwPBSmbBGdJBHBMdMkjdwRobWGFPa8dfYuQ7PFvLvy+VsELcOwWHn7ClT2dojI4wJGh0qdv7/o/y2DP9Njq45tRZ1EHiyTcxxd09veSkbpOff6VVLjPJDsBHq+AqDZ354KcIIo/92B7PVp6dOR7udsKRvfYeEuGinUQAi3nHaNKqdid4mQe30QZd/g1ojYshjyBtDjOtBprCFlHbAmN0ixB5fQLgu/uiA3BEc02WdkDIE9xP33o0a1I4XZ38u7U5IaDsVe+XdmlOKpizu/mzyhTP239TcsjtiFtDFpdsVgKIPCRJDj1FcDq1GSQisEY0fjpkmMPJNdLDx1OZR+dEFfdSQxjtwgUMMuE9nACPWw2TURgqevR9Okd1ajShZiN8lS3jPndjnS8mYfnuCl5IoH3kT/iAfctB3rgd7E2vJYANibztw5x9sKNwevMnx7GToFHjqCiflZO2tD2QrbG38iyLoAUt9IHH2yoTHBxRfjmlULuSALlsrvzwm65eLZ2cZf34vE8B21fw8K7Y75UTMbU2sX4ON9ku8d14r7jVtZ8ih5sxvC9TbuM/jM53Q5kHquuPOEoqLGtvHNQh6rd4IEAK1btMEj8qrCQN3jmMQd0FzBQShVpnJejH+tdCjatTrrOwgMfXRJu5QMEHraf1oHa7hsL448OnEWHQVmpZ9fp9lv4Ph0zVRCq7VbE5O4dmRgKo0+UTHKZJa9lV9CY/8w2H7+4LE+YUbVd9yVktFppUVHSmXyUlYfZZmdjc6bIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(54906003)(81166007)(356005)(478600001)(7696005)(6666004)(70586007)(82740400003)(41300700001)(316002)(5660300002)(8676002)(4326008)(8936002)(70206006)(6916009)(2616005)(426003)(336012)(186003)(16526019)(36860700001)(83380400001)(47076005)(1076003)(26005)(86362001)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:37:31.9187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70e6327-c6c6-4c5c-df9c-08db8de5d856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

if GFX clock is in DS (Deep Sleep) state, the current gfx freq may less then dpm
level 0, then pp_dpm_sclk node unable show correct freq.

(align output format with other cards)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 56 +++++--------------
 1 file changed, 14 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1ac552142763..00eba3f950c6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -772,8 +772,6 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = NULL;
-	uint32_t display_levels;
-	uint32_t freq_values[3] = { 0 };
 	uint32_t min_clk, max_clk;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
@@ -798,50 +796,24 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 			return ret;
 		}
 
-		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
-		ret = smu_v13_0_6_get_clk_table(smu, &clocks, single_dpm_table);
-		if (ret) {
-			dev_err(smu->adev->dev,
-				"Attempt to get gfx clk levels Failed!");
-			return ret;
-		}
-
-		display_levels = clocks.num_levels;
-
 		min_clk = pstate_table->gfxclk_pstate.curr.min;
 		max_clk = pstate_table->gfxclk_pstate.curr.max;
 
-		freq_values[0] = min_clk;
-		freq_values[1] = max_clk;
-
-		/* fine-grained dpm has only 2 levels */
-		if (now > min_clk && now < max_clk) {
-			display_levels = clocks.num_levels + 1;
-			freq_values[2] = max_clk;
-			freq_values[1] = now;
-		}
-
-		/*
-		 * For DPM disabled case, there will be only one clock level.
-		 * And it's safe to assume that is always the current clock.
-		 */
-		if (display_levels == clocks.num_levels) {
-			for (i = 0; i < clocks.num_levels; i++)
-				size += sysfs_emit_at(
-					buf, size, "%d: %uMhz %s\n", i,
-					freq_values[i],
-					(clocks.num_levels == 1) ?
-						"*" :
-						(smu_v13_0_6_freqs_in_same_level(
-							 freq_values[i], now) ?
-							 "*" :
-							 ""));
+		if (!smu_v13_0_6_freqs_in_same_level(now, min_clk) &&
+		    !smu_v13_0_6_freqs_in_same_level(now, max_clk)) {
+			size += sysfs_emit_at(buf, size, "0: %uMhz\n",
+					      min_clk);
+			size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
+					      now);
+			size += sysfs_emit_at(buf, size, "2: %uMhz\n",
+					      max_clk);
 		} else {
-			for (i = 0; i < display_levels; i++)
-				size += sysfs_emit_at(buf, size,
-						      "%d: %uMhz %s\n", i,
-						      freq_values[i],
-						      i == 1 ? "*" : "");
+			size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
+					      min_clk,
+					      smu_v13_0_6_freqs_in_same_level(now, min_clk) ? "*" : "");
+			size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+					      max_clk,
+					      smu_v13_0_6_freqs_in_same_level(now, max_clk) ? "*" : "");
 		}
 
 		break;
-- 
2.34.1

