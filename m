Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C720FC04A94
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506B810E2D6;
	Wed, 16 Aug 2023 06:09:08 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1800F10E2D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:09:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm5ym7xAyGuwYqn+HxOYMVQYM6jjXewuXHwKt+hXq8s9NhrjI0aQGzQl5MDF6WG2vBME7X5WA/ra/olZBx87jrck7LwZBWttf8WItdPaxsPbYvi+SJO5FSFoeZuaAiUzs6mrQMw24qXDlXOksR4QfQAl0myiZFaabcvMnL74n9wKgVYe5CIF8MmCXyIJlY6zPXzhIZmOmweAt0qXkWf6hgCBYj3bCY02s0g6AOUZbGZgxlUNs+ycsfdCAbhFcJnup60C6Uv7ayKATg0Z3ON0e4/U6ncuW1FvewMSa+bbh2EiDi7ZQmBIw7Gb/e4af+tlEQOdIRWYQkkhaPc/14PGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziOHLetDUrySTAsawc6fjo0aAwLF2WREixzuQs7bxkM=;
 b=g4FNByMXXPhhy5vJPxa1GdUauRAmT1I/lRExD+Ymf+5mkr7znuKiKleikOKKKzZw386AlpfmJCNOW6MMNHfl9RYqB+eqM+PzXW7zY76TyS4qQiz5Kdizq8AYxJzneQBW6Dsl3FH8G0Eqiy9nIwfkSxrTb5aq9eLb47GaAYrRshbI0qLkJY8+T/G6ZyYzLyA8xLBYZryNQPBHLD1/CiMU7hSnY8CuknW850Ln6fhbRbmC3tuw0kosyeL2ZC1Iwr60wD4zz5YkbGt29Nng7eHfHv/r7FHYPHBMbVYjQtBKwp0Y/sve/4jFpzV+dfF3YOXqRcBTBPk+CyR8N8kVFfwBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziOHLetDUrySTAsawc6fjo0aAwLF2WREixzuQs7bxkM=;
 b=LAS0qhVyKUfEEQFp5znO0Qr568eNjA6/eAesgSHEMQNVdZ2b0RDX+5S/pg8GuPj4QjsYi83MDOHCKLGS/4D6sRStShHR7h/ciB2QasCeqV64cvHVYkMMChOepV4GVYapmYBh7NxZqieA9OE4rLeQIER2DLG16JympFOI2OWwuzI=
Received: from CY5PR18CA0045.namprd18.prod.outlook.com (2603:10b6:930:13::26)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 06:09:04 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::46) by CY5PR18CA0045.outlook.office365.com
 (2603:10b6:930:13::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 06:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 06:09:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:09:03 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:08:57 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: ensure FS is enabled before sending
 request to DMUB for FS changes
Date: Wed, 16 Aug 2023 14:06:56 +0800
Message-ID: <20230816060658.2141009-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: ca99e7c9-1d8a-4474-c282-08db9e1f4ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Z479W2coLYs559AqA+toXfZSZ7K0uXo0Hv0C1ikyI11M5c1AU5932r8xdHMWO+Dd8i1xU/HvujCN78FwqL5cIelo3cy+ShrbkddR4JBSI5qbC48TrTwxzElLqgZRdikVVEcFWB8ZlKgaalW36i9eyzD9//uQM/RH5TofgMZUpi6vgnmLsBWQVmNG4ojXNlEhjOFMmuD9blf48C1lcnXGX6zy1kkn5XSZjGEz/yDhaN1ZopZG4wFlYgEQJI8K6X2Dyd//vJ9/Clf+G1GwGG7G8Wd0tHZq6Uz3rPm5aV9TLTe9/V1BlpKQY9oXXpimfgSfSBaF2KA/JN52rFxeLuS9RS/iwVZs1IbporfAIZSD3bmkhfQ6WYeasiTAdolWMLwbvTQ8HD7EYeJvrAXnJDcpvKLYA/dOa/ERk8iiBspLH6yAyqnCgNffm7v0NE3UbMGrTqMr6LwaUw4s32mWrE+suqtIKKG803KUeCy9gRL3wES9A6ba71Rx1eqtbOLFaHkrYqyPy6unofZVpkmKprZj7CMLIvCj6xM5gPaa1z8OydpeXL456i3IjgOTN211dwqXEwr5OAH4ix9M81iZdul+EmLjce60O4R87uqrO3jquk/wQjzGWoXvruVbWtjmRUS+PzMhoZTZdWpWAf6Yo5Npg+UfbgSBHv1Pu1EabQqno00eKvG2RCCJRDPV2DVvSscspA8VGhnc9eFf9fqbW6L/EcJNmNE4QfuvdouSsQG8fSlQP+tCK2Rzfv/cRNyzHTySanRVS94kleVENJBz+ER3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:09:03.8988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca99e7c9-1d8a-4474-c282-08db9e1f4ada
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
ignore_msa_timing_param indicates FS is capable but not necessarily enabled

[How]
add check for either allow_freesync or vrr_active_variable to confirm FS is enabled

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index f32b5c71a66b..b46a26a8ad4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -552,7 +552,8 @@ static void populate_subvp_cmd_vblank_pipe_info(struct dc *dc,
 	pipe_data->pipe_config.vblank_data.vblank_end =
 			vblank_pipe->stream->timing.v_total - vblank_pipe->stream->timing.v_front_porch - vblank_pipe->stream->timing.v_addressable;
 
-	if (vblank_pipe->stream->ignore_msa_timing_param)
+	if (vblank_pipe->stream->ignore_msa_timing_param &&
+		(vblank_pipe->stream->allow_freesync || vblank_pipe->stream->vrr_active_variable))
 		populate_subvp_cmd_drr_info(dc, pipe, vblank_pipe, pipe_data);
 }
 
@@ -645,7 +646,8 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 			main_timing->v_total - main_timing->v_front_porch - main_timing->v_addressable;
 	pipe_data->pipe_config.subvp_data.mall_region_lines = phantom_timing->v_addressable;
 	pipe_data->pipe_config.subvp_data.main_pipe_index = subvp_pipe->stream_res.tg->inst;
-	pipe_data->pipe_config.subvp_data.is_drr = subvp_pipe->stream->ignore_msa_timing_param;
+	pipe_data->pipe_config.subvp_data.is_drr = subvp_pipe->stream->ignore_msa_timing_param &&
+		(subvp_pipe->stream->allow_freesync || subvp_pipe->stream->vrr_active_variable);
 
 	/* Calculate the scaling factor from the src and dst height.
 	 * e.g. If 3840x2160 being downscaled to 1920x1080, the scaling factor is 1/2.
-- 
2.37.3

