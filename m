Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DA7C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D1A10F641;
	Wed, 24 Jan 2024 07:03:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACE210F658
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cw8aqC+ACg2utVFnID+KHNIQFy334FbkFrYpKgqkm2DxJnCb3B035OKr8QQAMD4cCzVjIxcTezxfokprinh5jh1ly45c5fYsnqYT8ZiX7JaHtzPsk3vhkPim0vGEU2RPA2AhDFMPAOCRqxLa3GhbUwZzD8d7LsMZatPWijbER+uX/EjmzVik2KsOHrFfBc19m1TNVV9OyH2E/q5xWscfpWJv0LX1EK6c84NtvHdtB4pXZyE3cMLZmCgJiLT0JYO6lX+P2jDaUErk82hgfT/ro7n52YYi22e9cfX4D9uRyc5hZ6/6PohnOQaFZqDgW13QTsGbYrZ/rdNYaWBBvgAuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFA1xGi35MLogqc90x7e74oAJOaAyp7k4NRmFYOtOv4=;
 b=gufaEoO/9WnkKWs4GzLMCHhdFD0IHdn7QhYqVNpcpe1Zf1b+kwf9xNrdzNn/CSLzXKHGFBSEDNpmzNuRcvgfMeOtwWKoqv8pV7tBvmbvdJtOiioOU2RJcl2enZcKCRUGd/aXuDm2cLA72yof5pc54NqQaRC5jmLOLUmmif4UCmpawa5YGt4pr5Rzlf4ErMdh841bfYVjfcmMXBiAWEtLKNU4K/I1cXENCt8HrLZ1t2kAXZJ2K9a6s/utrIHFFz1qsk6HS3Xsyi0PdJa89dH7oEQCCB1owa4oa9vbFKH1R6K1DMWVFmxpI1liIr7llZeq8R2qvyueHxXk5uFz7PzlLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFA1xGi35MLogqc90x7e74oAJOaAyp7k4NRmFYOtOv4=;
 b=HCw2cmloqGoxJ5o8HOE1osDduv0hONn7vZ21eVZLpNz5C2O3Uq1ezxqM5lyT64ztFo/+ArBW1hpvoEXLHM4afS2hMY9LOQdJw64w0GNcSvAEchwfHSC/U0deNVEqIEmx8hk3r5JilNxyqXWmtbxffPd9/eQzOB8BrA32/24F0LM=
Received: from MW4PR03CA0156.namprd03.prod.outlook.com (2603:10b6:303:8d::11)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Wed, 24 Jan
 2024 07:03:05 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com (2603:10b6:303:8d::4)
 by MW4PR03CA0156.outlook.office365.com (2603:10b6:303:8d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22 via Frontend Transport; Wed, 24 Jan 2024 07:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:03:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:03:00 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:03:00 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:51 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/22] drm/amd/display: fix incorrect mpc_combine array size
Date: Wed, 24 Jan 2024 15:01:51 +0800
Message-ID: <20240124070159.1900622-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd39279-2bda-441d-7168-08dc1caa8328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecceclTGPuAhSCnNVqJed+6oZJfeD3dsnF+2hS/rvEquU4s/cYnIe7K7JBy3Hc+56KvjbIXm2kqDC6qVRSoQ2PdWoqTfbqwo7CYksB2H5c20tJa3+Q4BVIeLj4yP+OyTRSGBl/QDs7OnY54JOa5p5k81tCJ02yXgsUfxPqOg9fo8Rwc5mpOsFElVtv103GRtRVIrxJ7Vnd11HsvJ7RRNO0/UvHSWmycioJXhLDH1pa8jAMbjp9tCc2C2TAOlgQE71Dh+vVVm7bb01yUCP2qlNLXSNBczP6XxwSvgC6eQvgoXCpPr0F/e11GmAzlvUuu5RUJHmPUf8+6RpI/wS+mrXnbMjbYQ40HcAf7hsGsyj/hDfkKaNCbyUkvoV2hgVVlf38hOeykriYbMTl2p+f4p4FLZilIfE+MtEp0PaGKozPjUZbT6qFissNrF319H9tM2Haz/bzGhIczGKxFdNrwAmN1IWOyHLFVi9C0crUNSej087YJejv176hIIKVg30tY2yFBBiilT4yiKWEN8E1O4cJokbgzlBo0s7jl/EmODB+T4oIZBjHhuPQEpLhj7guiXLzNmdTuJ0eYLzYHWoxpBaafsS7BCYcJZkfksEB/3gfc8KsaCLPZ4YZHEkAqW2EQpXrCKF6WALzqQVLNT5FizFFBWPTSYo7NHlDruMzJsAbTJdfZHF8kwRL+vGzS4OhhD6N4Rqtv0kNR6aax0Gm/vhTBdlw3+VyPcQIeNNq36VuwatkLYRNFC2FaGQKun4jB10b7FHbFgzPiDCY/Mohcc0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(81166007)(356005)(82740400003)(36756003)(40460700003)(40480700001)(86362001)(26005)(1076003)(336012)(426003)(2616005)(8936002)(54906003)(70206006)(8676002)(70586007)(6916009)(478600001)(316002)(36860700001)(47076005)(83380400001)(2906002)(41300700001)(4326008)(7696005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:03:04.8845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd39279-2bda-441d-7168-08dc1caa8328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443
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
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com, stable@vger.kernel.org,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, wayne.lin@amd.com, Alex
 Deucher <alexander.deucher@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
MAX_SURFACES is per stream, while MAX_PLANES is per asic. The
mpc_combine is an array that records all the planes per asic. Therefore
MAX_PLANES should be used as the array size. Using MAX_SURFACES causes
array overflow when there are more than 3 planes.

[how]
Use the MAX_PLANES for the mpc_combine array size.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9b80f65c0466..a7981a0c4158 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1113,7 +1113,7 @@ struct pipe_slice_table {
 		struct pipe_ctx *pri_pipe;
 		struct dc_plane_state *plane;
 		int slice_count;
-	} mpc_combines[MAX_SURFACES];
+	} mpc_combines[MAX_PLANES];
 	int mpc_combine_count;
 };
 
-- 
2.34.1

