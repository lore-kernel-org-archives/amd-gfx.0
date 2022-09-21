Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53727ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 23:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23FC110E977;
	Wed, 21 Sep 2022 23:17:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CFBD10E9F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 23:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPHnYiQ4ZTl3qtvIUKsUvQud45IpqL0vJE2Oku8kuOV62X77obw6kto4mk0Jm20HzeqqwAK4M8oL6dfc99b3CgZN5USZiV4xbdeosPVUAakp5qaQhf1jej+EFEaFZOZCUo6nWhTt1O4kpuaRaFgYgbecImm88Hdqksh1ITMrBkyiWl8MSR19qbIr5Cx2YxLPkNwpf0Y5ugDBLfBQct1MJlYIO2yRgFLuhDkQHarGCkjxbnGsxuZXx4c6YGbWPJbLNEZD1xqn1RMLO5WO00nQporqgaZxecKrxEN/UKycpJVrL7tZH9uZVB+0XmPkSAIN+0un9CHx7lrrRWFA/zd4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnf96KBeIpc7D6wZ6Bx973eUaLz9j/VtQFHa5v0fOAA=;
 b=QD0nVFCJwgTlxVekq0MqHQQPLbeRuE4H8DQU7Pgkfw7OQUsfY3AXqq3fDUwAtZ2U2s5/MUL9LmXkQYt5PbrI9hxoRgQIetSxO98Kw5wDW7rrtf6fnQpnK1lnEvaaa9yiT5rENsmKsjMFpNVD0kbZ7Ru3psoBdoUlqLaa9CBr56lN29Jxd3jeJb5792EDfD0yyghFsROh35lD/oaJlyC53ulQgz3PfzD9GP+0uw+ibK9yCa9AJwjutds6FNG0iTMtOVz7uGRhr3G1Lw7TNLWsiSSZPDLsr4RV2QjLELb4BLlTJp9nFFXX9xx4Im37h1k5HQacU4qFCJD/Lkz9cdif4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnf96KBeIpc7D6wZ6Bx973eUaLz9j/VtQFHa5v0fOAA=;
 b=TeXoe/7LTS6mdOYvTJNblWLJja7N5G/FUs8O3m9oLmxwCQDHLwA0UrqgCNbN6iJQdc11ilQjK57c6ZlKJ/i1RA+L+QDTk8lORFBLrK5pYd+XPkzPu+ZUydYrbTmj24lDWD79+MONXtBHJ+WtdiM6MFRktJ1nceRuOP73ogKmdSo=
Received: from MW4PR03CA0027.namprd03.prod.outlook.com (2603:10b6:303:8f::32)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 23:17:34 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::67) by MW4PR03CA0027.outlook.office365.com
 (2603:10b6:303:8f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Wed, 21 Sep 2022 23:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 23:17:33 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 18:17:32 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/31] drm/amd/display: Update DCN32 to use new SR latencies
Date: Wed, 21 Sep 2022 19:16:45 -0400
Message-ID: <20220921231714.303727-3-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921231714.303727-1-jdhillon@amd.com>
References: <20220921231714.303727-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 69eba166-1731-4a3e-96db-08da9c2776fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAH6Du8eelGJ7+bZquEHs1WyHqjBjQWi87al5DI6tLhtB69Lo/SANyGVs154B3iphCpBNfFNf6bmo5ovZ1Zf38HBz3N4OdcVgCPw29Jybd8kN2FyuaZLWctVzw7I5HLGEMciFvv3NKB7qPC4xwJyKBXizhEStDm/bGjddlE+VACUhbYuNOBeJODuU0u+K/zg5Pdl2wgK81Sc8tRtgQaMBYXdN1B/pZTKjxBLx/4eA34/a+LXAQIQcbeQeaLS1j2oYGpsN29t1Z6HUKgbtdA/Ri1QbEaV+V5maGNLCClVIRN8EhyWigaIafbBlMsrEL1ZasFsXHNKPKVAjLvdOUC5+wmP4P+PtQlFDPU4u1719YcYQlkNHvLcRyaIu9w5+8h0NnHYYRinjyfGqJc7ixo8mdlP57M8Hj8kyzZzOqftm5FlELV1qbmY9ZI3lwkqGay4p+8q+dSM+G8nfHPayM1nM7LFT6bOB1j0kiMSNN/vcN6chLFPE9oIwqXkktllnedfB4zwiFzjCZBMzb6bse0FTq4R+JT1YqtIxYfQwmsilR1WdtvFwwNO8k4QlHr+5fRG5t128RntKgZcYxoIDPNHUFOrGVbpQACyeMwLeHgUrZ3oxZWeXg7bainirHj0SIACzCbGrToA3O3bC1tjoqAaZF3eXo0DaaSJEF51ki9lXHi9/SYgxp//754GaMj9s2SwIGlEFmrzTNG4yq9DGcRSauQ4Jpqzk4h+LqHEacy0Y9CW16hyjtInKi1x8O4VPjsTi2FQcp/QD7o8xZcl4JfwpQjQ7CnLx1PnZ2NaZJ5mD/k2nzhmIWWCVlV73P1OFo1b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(36860700001)(478600001)(6666004)(356005)(54906003)(6916009)(4326008)(8676002)(70586007)(4744005)(83380400001)(82740400003)(47076005)(426003)(15650500001)(2906002)(70206006)(316002)(26005)(41300700001)(36756003)(81166007)(5660300002)(8936002)(2616005)(82310400005)(186003)(40460700003)(336012)(16526019)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 23:17:33.8459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69eba166-1731-4a3e-96db-08da9c2776fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Nevenko Stupar <Nevenko.Stupar@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Update to new SR latencies for DCN32

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index fe0770038a90..6687cfed2ca9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -121,8 +121,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
 		},
 	},
 	.num_states = 1,
-	.sr_exit_time_us = 20.16,
-	.sr_enter_plus_exit_time_us = 27.13,
+	.sr_exit_time_us = 42.97,
+	.sr_enter_plus_exit_time_us = 49.94,
 	.sr_exit_z8_time_us = 285.0,
 	.sr_enter_plus_exit_z8_time_us = 320,
 	.writeback_latency_us = 12.0,
-- 
2.25.1

