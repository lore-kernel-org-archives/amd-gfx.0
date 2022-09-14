Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99293ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A9A10E80F;
	Wed, 14 Sep 2022 03:53:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A195410E80E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZkklvY6T0vMb1l2W+DEw/opPVXeA0zif8gcyoc1sB+b+HWRvBepvXRSHC+d6OdM5CFafSrHEvJr8NAJ7rHxgPaIdMX5BwO9VC2lkMTNdShWRVOgybC7xtLUGyvQLIiGIj//vsiZqZ+jYC45lBzJ+h7R1ICA3i18JlvyyjfN/aAqV4Z+WEvseAPNU0XR3pgrH3J3/xe9aJn/shW2gT6tk4+CpLt0HDjlHxwH9BPLu9v87c5qbVSWUNF4urcKAg+/6MN1jwU59I8iu/dK1yQe6sFWqZHRY7c/1QeegxPJjtSf4K2iEZGZlN1ALJlIdgxOSImaUa9mmgx+RzCM2YwRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpdw30ij4Fwu8LPqV26bibIITnnD9ShCLNuGUxOJp7A=;
 b=gjxVj2Eh5TI0L1lAGyjUh/O/krhjb+cOUk5YIicLv5dMs9edEOX8AKEZM9ut8cZJk/88Y4jgIQ48w+vCWiWA5Wf8k22rIB/H4M65S5ntTZkga6WhOnPN4WCRAy6bV8mxFuQKVnDaJF8dheAoK41o2MOj9SwRcqibh7NA4byoB72xTev/425SZlPMTsZeymZ7sw0RwKqZ/3GL+N7eMvw+b2gW4WbLhtWKPgFqIGWYOq3qOWgOku8PEjifCMKIlB76nk15KxG0od2TCw2mS0hrm8rCE9GXt/kGCkkTHpsU8s6EhrPSPqKfIUo7hpmmm4A27YdMpKcd9/rUt/XV9ff5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpdw30ij4Fwu8LPqV26bibIITnnD9ShCLNuGUxOJp7A=;
 b=IAopM1YzVAGS23mzE9T6smUdmungC1K7rWlYtPE0/fe0+/MXUTKf6DRGzuKG7MsCvg4zXuxWhJPTNdCfVaHyeejOFm2o674ybCGBAqRYvQTe34rnxMCUSvSZ1utPC+hNqSQlMMTwFG1ii3OMpTnHelzdZ31NktTmPtj3yDN7LtQ=
Received: from DM6PR06CA0066.namprd06.prod.outlook.com (2603:10b6:5:54::43) by
 DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Wed, 14 Sep 2022 03:53:34 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:54:cafe::7e) by DM6PR06CA0066.outlook.office365.com
 (2603:10b6:5:54::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Wed, 14 Sep 2022 03:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 03:53:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:53:32 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:53:28 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 23/47] drm/amd/display: Fix urgent latency override for
 DCN32/DCN321
Date: Wed, 14 Sep 2022 11:47:44 +0800
Message-ID: <20220914034808.1093521-24-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3a4be9-5b3b-4331-14a5-08da9604b24f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S84io/oKOz47/CGnfclWLMPxRjx84Zj9SibVT2a93YrNEi1Byu0LkNs0XvbtOD6bpezFMZW2xl8Y8/bFvAMxsoA55q7QdDesVO6oFF7FtCvXUEcF97plKkwNYtiSmrXcrAwn81vYp/0N96m0F8zNChGVLAAtz5JJk0+eGIx4UqPKdFKIeffaNmTX5vH4/2XSidWbZiuusUgFJrD3Xh9IqfG9jnF7TV2eIV4Gj3UIuyvHNuw6BuVDCHgxwlhR/6Z7XAFfs/tnYQDu6lSVbJKIPsc1A/3XAueuws92bF6zWt2njbdo9Qyl/Tci7Mp8SofB9APMFJkZ6OZEY/dguLArk6NpecgzXo956MzoqbOyCaN2ZzEogAGKKr2KyWwtzcwv9769W7dfw7fuIqgNgEB6rkJG/bhWlZ1nNyJVPDQzg+kvd2KpaCqVr2TzcUgAPXh/8N/N32Ep0Kx757oNdCQRDZTFi9dsYAvxmXosndOCDZ6L51QOQTlrYxikY/uNGEid7LfdXZCWrLbpq2lJGs5kxdnc5JMNdpWVhllBFnJVycSetWe/y5UUJU57YWRkFJ8XLom9zDp4o+ZPNYAdB5aNt3ZtiLaIqRZ6VmX2fBwhK8EbjFxZo48hx9JfL6/9mdvt+i2dNWMWm3VDUq6XlQZ6Nw7iLCY4yGEUp9qJ/IsJ45ePLy6KVj2Py1rH2l6Mm86s2g3s0bD6tVYD3tfU4pmEnxJKfmGCA87tBQuRC+L1iqiJV7QrIH61jpCgkL1ldCt9lGk2hcB/xG2eyKYQndYIrrolEbnMWY/qE3EZUmvuDrFW33Okaz95URuqyoErx8eJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(478600001)(36756003)(86362001)(82740400003)(36860700001)(356005)(426003)(47076005)(40480700001)(81166007)(336012)(1076003)(186003)(83380400001)(41300700001)(26005)(70586007)(70206006)(4326008)(2616005)(316002)(8676002)(7696005)(6666004)(8936002)(40460700003)(54906003)(6916009)(82310400005)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:53:34.0972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3a4be9-5b3b-4331-14a5-08da9604b24f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720
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
 qingqing.zhuo@amd.com, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Nevenko Stupar <Nevenko.Stupar@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
The urgent latency override is useful when debugging issues
relating to underflow.

Current overridden variable is not correct and has no effect
on DCN3.2 and DCN3.21 DML calculations.

[How]
For DCN3.2 and DCN3.21, override the correct urgent latency
variable when bounding box override is present.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 7ff7cd8b5c93..b8d4547a885f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2197,6 +2197,7 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 		if ((int)(dcn3_2_soc.urgent_latency_us * 1000) != dc->bb_overrides.urgent_latency_ns
 			&& dc->bb_overrides.urgent_latency_ns) {
 			dcn3_2_soc.urgent_latency_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
+			dcn3_2_soc.urgent_latency_pixel_data_only_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
 		}
 
 		if ((int)(dcn3_2_soc.dram_clock_change_latency_us * 1000)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 7ebf25e87933..dd90f241e906 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -489,6 +489,7 @@ void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 		if ((int)(dcn3_21_soc.urgent_latency_us * 1000) != dc->bb_overrides.urgent_latency_ns
 			&& dc->bb_overrides.urgent_latency_ns) {
 			dcn3_21_soc.urgent_latency_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
+			dcn3_21_soc.urgent_latency_pixel_data_only_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
 		}
 
 		if ((int)(dcn3_21_soc.dram_clock_change_latency_us * 1000)
-- 
2.37.3

