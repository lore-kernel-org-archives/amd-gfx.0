Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA764C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jan 2022 21:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C31310E1A1;
	Mon, 31 Jan 2022 21:54:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1584910E1A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 21:54:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMm1yy/ia1rNPLxUjBm2CMPTh7ifcXsxYEJP4qB4CaBO5T12YTxDHtQH802lD9tmablkg6XCDjnQzugbYcugasbBKDOPlon6mVbw6secIxwp10HC3Z5eDRvfbW1ADMHYNsYEG1IZd/lQ25T4hAAO+mqJiRVIBRIyd/JLIrpVqaklm4J7DjQBFJRiqxUUZohyH0yZZI0noVSlX5TJ25ss12DOCi6RRRugJmPK9IISnKUZGitOiEGteZqU/v4fxAhn46ulodk8BDgkRFQ3x366BY+0DU58LLn9e/Vne+z4QeXhFCzNmSpSmfJK1znCNPe76mlxpE6p3QD82/7LGfSnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glW17MKhfn9xfQ3cehtFtOU5bt+esJY4nw5mXt7NJHw=;
 b=g0Cnv3vNuu8Bv6Z/lqrJ2frdeuI6eVZrPdA10DgQMtbz3pSCsEg+KE8ssK1t5MEzPbjS28/U8GirvP0WHVaMPpd4Kqox0yBU66LtbUAyvL6UsAR3yJrTpGb4oAaBiuAbWDXEYrUzvMcStuXheJCwm7DKAg3puIDKUeKmptTv7fJpbXoHt3c7TnlZlk/9Mv+YAaJI3yrITj40L/wuiVlXeod8yjXGzYKZSGK8ytnoqoS7AU3yDRgJTpzHMsPY7xHZsYGRAF72Ok6BX5ebO3Li7WDu7UbdpzrjpYIzKIE65fdpE8QTY7PJ6Z7Sbf3VxG+JFg5tMCES8bmjZ7tvPeN9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glW17MKhfn9xfQ3cehtFtOU5bt+esJY4nw5mXt7NJHw=;
 b=i+3G8f4Bftas//kMMK13SlC+1x9KEs6IgNx2zRcLvZk/Zo/FJAVLHLQKWC3osOhMaj+2WNNP/9NeOTA6a83T6bSzhqMDI1zfjHPHeWAefyNVdQl7rm0T8rUOFWMojg4Q5NxGLwpjpMjUmlglw4XPK02evv+Q5lKJTuFJ8+5lMcY=
Received: from DM6PR12CA0029.namprd12.prod.outlook.com (2603:10b6:5:1c0::42)
 by BY5PR12MB4952.namprd12.prod.outlook.com (2603:10b6:a03:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 21:54:00 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::3b) by DM6PR12CA0029.outlook.office365.com
 (2603:10b6:5:1c0::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Mon, 31 Jan 2022 21:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Mon, 31 Jan 2022 21:54:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 31 Jan
 2022 15:53:58 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/display: remove statement with no effect
Date: Mon, 31 Jan 2022 16:53:42 -0500
Message-ID: <20220131215342.2763153-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3625e704-420d-4710-e4f9-08d9e5043043
X-MS-TrafficTypeDiagnostic: BY5PR12MB4952:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB49525A5069F1A0E7D0111E92F7259@BY5PR12MB4952.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IApwAKc7DzXYYqqMbA0wZpP9bVsA6bRRh/WSUzIPkOvTkPcjijRFLLVBdd6qRLS1LEFvwjoO7fPOcfCXhGRp89L23N37ZkhhjGm6yTR14l6E2QaOCLiofaWcNNIAX/yiCXXtt9VjLe756lfNPi/RkV+l3NBIfKPejyGcOy5mP7kQsYSRR08/QnrEaX2j2RIDdFzzFRuIbG9wjb0LoSRp92eJs3RDlguGRopt7On2jGCILrwtEExcundrCi2KswPXBAFCSgDcCX/UNWt68pT/rt7Q1hk2aPv0jTi33PjCwJ4eGopCG0JzJbTH6btfp8+J/WlrZw0miXxQADFXLZC0NrQitfQ5Ng/d0Iub+6QiAxTCXCi+ONvdivhQo2Yl9bXTRh5ILCzNfdWVib17BtWITAXZuey8DTL2zCKamw3SFeUkSQCnUDjKuA9q8w0uDz5V1FXIawHsGF8OGbUyO83b7G0k3hHJa54JC4nPzE6Hzu0UdNB+FQVP1fDDwqfHM8pS263gXkvUXTorcmSOrzIEskY45uXOnDDUy/yhMffyASKt2uKyubgC0my8QhvCEHnEjPJNbtjMl5qr6YUtbIoUrIt3N2/sPvn5VTwViap4a8uoOSPqHM+l7Tfo6GczRgJG3QxzlgwMIuKPjBfCdLlIEtwfc7zkfP7X7VhZ1nPJBN6deJZq5cKDVwBk8ogQTIyZ2uOQ0dPIjXZphcBzTb4paw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(36860700001)(356005)(4326008)(316002)(81166007)(86362001)(83380400001)(40460700003)(508600001)(36756003)(6916009)(70206006)(70586007)(8676002)(8936002)(6666004)(5660300002)(186003)(82310400004)(7696005)(426003)(336012)(16526019)(2906002)(2616005)(1076003)(26005)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 21:54:00.0927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3625e704-420d-4710-e4f9-08d9e5043043
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4952
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c: In function ‘dcn10_link_encoder_dp_set_lane_settings’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c:1123:49: warning: statement with no effect [-Wunused-value]
 1123 |                                                 LINK_RATE_REF_FREQ_IN_KHZ;
      |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: f2581998d9eb5e ("drm/amd/display: add set dp lane settings to link_hwss")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index 779110a2d948..ca39361f71c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -1120,7 +1120,6 @@ void dcn10_link_encoder_dp_set_lane_settings(
 	cntl.lanes_number = link_settings->lane_count;
 	cntl.hpd_sel = enc10->base.hpd_source;
 	cntl.pixel_clock = link_settings->link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
-						LINK_RATE_REF_FREQ_IN_KHZ;
 
 	for (lane = 0; lane < link_settings->lane_count; lane++) {
 		/* translate lane settings */
-- 
2.34.1

