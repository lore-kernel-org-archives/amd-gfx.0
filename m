Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5D2C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCB710F650;
	Wed, 24 Jan 2024 07:04:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 713C910F650
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NM8xBDmH5ehGjDp4sktOOYJq6P9Vd0qlW3YLSfyygUxTTcrdbhCZC5lhBeockZZIOYYOd2aB2SYPAf1xna5BtEkwTtm3G7LHuW6AD8IpK39dZB3ZV99thMnUp7i9rg90OUDEx4fZKXbTlreKPqYxivvxe7wj9rA4hy1Z9fDaqTihTZtyhOysZGL0NSTrPrIqXF99lSYP4lgIAobjyq9vyJ0i4XKmwYopjCvNhCSSXSRgBD0rU1RtxdLhSksx1yyh7dJxvJnXhlKsiTSIyAWlz2DQ5dIQaPMDwu0PoNSJsEgsQ3GaufJxfFslnkLFIhacyKUUXIi31CM2gmZEg/Iy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+zsxRmSwtVQ0v0mIC1zbF+c5QjDOoIRo6C/068HRNk=;
 b=EVAIQ6yibYGD99qSbliA9RnUwY3SZxyQ4b9yACJiWz2b59Z9sJcyfimZEFoEtX75HMp2XyNmzCZfBaNfw9ckb4hp6paV+dlycXTo7HhXmTMnIhHT3AHlhvAK98hg+YX8fRGicZ/KTXXRRf1VqxBolBQnXx/AQjM34YIjZH6iXVDQWywdQfD+GUACxR8vCfhcgSIqmK1Z633Kmg/pVbcQxMZw9nffih0bDDUhgLVmaV+ClxDQv/+hwyd6UzuIM62X3EunZO4Or+cWRt/POtNiXxHF+6ns5tDD8ioECzCXbejpCmEmGxiz2wwS54NrhNpihaNeWBC1AX+bbZdRl1cRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+zsxRmSwtVQ0v0mIC1zbF+c5QjDOoIRo6C/068HRNk=;
 b=Ni6z79FwLT4hHv0non3e0QmqBOy4i9pqvRyWOA1IfQhBS3icY9ugKLD1zHR/ROJCLtLsWTYX5doPKIgnZAYKLg6Us1s5pqMPcO6zoFG7UG2e7l7IF8xa6eKwSOrx1A5QxFTLMmHlxx3pWwOi/KtYPpaACgXTWbzExUde6vwWTKA=
Received: from MW4PR04CA0112.namprd04.prod.outlook.com (2603:10b6:303:83::27)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:03:54 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::3d) by MW4PR04CA0112.outlook.office365.com
 (2603:10b6:303:83::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:03:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:03:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:03:53 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:03:50 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/22] drm/amd/display: Populate invalid split index to be 0xF
Date: Wed, 24 Jan 2024 15:01:57 +0800
Message-ID: <20240124070159.1900622-21-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 112d5497-358e-43f9-d774-08dc1caaa0bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uL9ufqx22Qvebds5dCFfq1q9ZyGIuqMHWfehxd8xeMCcVyuSF2Z0Z+4hYQIGt5IFnH3fB2hGeQ2S2jZXmggajShkvySUMDZ9s4J0yY5iHFDtcSdVUX981NsYYg10CA3h7I8BKldff5MwXkhc4kRsx+hi+HaVhWy7/CBn2eQBIWqipBM9MIA6B7pdilzi8V2q80fKzdHBl4wVLv7mHgI6f0EouiSs8Dt4zqZngPSJ9HlOkuJlDoL1HnT8Z4a9JigbhM51wbf9akcNNdZxfYPvF7Artg4+vVsCy5iikaS684A0RjEv2QXCpkJcEzZhYAvv1gX3tlrhMYn2ELRL3GILNCfLG6plqaMGLH8LqERFV824coDx5o9ykmpeomJqwxAr5SoIYQcFlaipdv8a0L8bbg18kS/y0I/QC03NYGrnm2YYMMPhSeinn3brAxZVDyXyMKqZwf1blITgKGYrAWe2m+jW0Oh/LPFCeEcqdR4JZwCHokviCZlOURFnxP5bM2gyNO3tOQxpz1s34krMZHwf5Rm5AExuo7PMnDRh2EJtUi/3r5gIueII50oIiitAJM4ww7gFSZ/12hcj1vTUnMX5lK9nLj2f2y0XUW9ttrCZFGiFKSqiJNW5S57gjzaVCkJGEfp/dHQ1bYv43bAOywmOrA7q3NYn7POF3S26ddmdF6N0RZkXg+9DnPmAWOvtDGoN006UO72yulpl8Wr158ZQfhatzIEpCPUpREBuZaVN8fWga4dCogZrUCPOfLq2tNSXVZiMX1E/4DFuo2rTh6eo4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(54906003)(478600001)(70586007)(70206006)(2616005)(1076003)(6916009)(316002)(40460700003)(40480700001)(5660300002)(7696005)(336012)(426003)(26005)(8936002)(83380400001)(2906002)(36756003)(41300700001)(36860700001)(81166007)(356005)(47076005)(86362001)(8676002)(4326008)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:03:54.5044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 112d5497-358e-43f9-d774-08dc1caaa0bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
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
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[why]
There exists scenarios where the split index for subvp can be
pipe index 0. The assumption in FW is that the split index
won't be 0 but this is incorrect.

[how]
Instead populate non-split cases to be 0xF to differentiate
between split and non-split.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 3d7252218ea9..0ccdc0c979a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -780,7 +780,7 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 	} else if (subvp_pipe->next_odm_pipe) {
 		pipe_data->pipe_config.subvp_data.main_split_pipe_index = subvp_pipe->next_odm_pipe->pipe_idx;
 	} else {
-		pipe_data->pipe_config.subvp_data.main_split_pipe_index = 0;
+		pipe_data->pipe_config.subvp_data.main_split_pipe_index = 0xF;
 	}
 
 	// Find phantom pipe index based on phantom stream
@@ -795,7 +795,7 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 			} else if (phantom_pipe->next_odm_pipe) {
 				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = phantom_pipe->next_odm_pipe->plane_res.hubp->inst;
 			} else {
-				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = 0;
+				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = 0xF;
 			}
 			break;
 		}
-- 
2.34.1

