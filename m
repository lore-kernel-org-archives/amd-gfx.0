Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1DFCD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 13:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C68510F18F;
	Mon,  1 Apr 2024 13:50:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VpgOo2V7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD9810F18F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 13:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2Bha+hPsVWXGImGjXLpJSArfr5bKjlfOpHYkKPlEQsNwE05cxe/xTVyG/P/ozwlAEkhJE6qmJKzaUDrtmcf4UQb5lQNcagh8w9qfwy1ZBQejgScch69CffDB5psldYVggjqORrMEyuuWGU3Dg3m5EkUpeFwplQw875hRL3+SxPr3iiSm7bSvs/mMEo5lP8UcslJrwx90yHmeNSWQVv8OCMM6SRYmvlPu1Q8m1gFtq8uTRAjF+r9xXgsuzu2S1hwH8tWwXVgN1ZX6fZuCFefQs/v9sO3CucbRlXw9yXQ7iWDomWC4iQnkHFw6l90uswu6bNmaUYJxjjGUODD2eZepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPitkzBtLz2cKi2jlDE7/LRrQg/aqovI7B5+jyfgEHw=;
 b=BGTtwBAflS6zQp2POdOyRdalUDjPSzT7T38evmszC6DJyiewMdhPJptNtGDVAECxzyO/lPlz89ImPXPTB+2LQeO3ARPGTY7YE3PPnJCP8ubGZZV4oJcqMXCv4LNxdugsAFGuo45lC+H1o7nRK5erojp2BQIqrfmZyTV9CFsD7pgoAWnGJ6XCv6MxuXKCKmPCF+mypOmy4HY8Fyqq5hyVl9Ni3RP1856YD73Ga0hjHbE/JMMuofVmYU+2IoIEEkKUx4yd9p0S1JupF1id0Vt1ngFjgcfJVe86v+X6Yo8lrObP8f70Jc2FpAF0CEoUhA4lKs4Lw5APLpHMa9YjFibsIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPitkzBtLz2cKi2jlDE7/LRrQg/aqovI7B5+jyfgEHw=;
 b=VpgOo2V7cC3otDAbd8FTEyZTiGkFao9Cppfsj283PuLtFIsedTAacKYkSI6+pj6jU/FEJ+qY1thal/k7v3/KTJ8nqngKPAllcsLhX90aVkCam39mJNh6R/o5DAD56CDrAUWTou+jqWdtvaA+qFqdPlZ8bvESpLHoq19acjxvc7k=
Received: from BL1PR13CA0364.namprd13.prod.outlook.com (2603:10b6:208:2c0::9)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 13:50:50 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::5b) by BL1PR13CA0364.outlook.office365.com
 (2603:10b6:208:2c0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24 via Frontend
 Transport; Mon, 1 Apr 2024 13:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 13:50:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 08:50:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Joshua Aberback <joshua.aberback@amd.com>,
 Roman Li <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Add missing parameter desc in
 dc_commit_streams
Date: Mon, 1 Apr 2024 19:20:31 +0530
Message-ID: <20240401135031.1406290-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b526b2-5452-4ff8-d743-08dc5252bdd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwsM1GFpUOHx/W31W5s1zdx/qu6sNyEyruNzeGh72CYjX6eVqWYWLKLRaKktSLReMVs1FXT0uNQIdkWx5QusTeENkAClKPKuuVjYxnCPdcOpzeEMsk2W532APahY3DvHzDAp569RislAxfgbFi9d/HwM0DT4yyNW+RoFotBXuBylYVGbBgz7/LrkOy/ds8Tig7LKzBXvTZ34jMgvC0J6NvqZWdInV5/YuItkSU2nFYT4Gne5MXsQYrDgFUQzn+eWWKkUNL8n0/Nl0eKFOIlh/vCSgFIuPABiP7nLySj6yEWB/b5AchdJslb64PPSt5bqqk3dJd8VcQnAnJ8d/25z5ybT44K/bTLJhqF2b3em2nCWanooqq4Z0UjSCyfUwx15UXD9MtZ9isiBQoEE877IqTMIcPAsWn6xBylfsVjhecOSg1IRhDh8cmT/0U/AZt2hu91qIID7CSGnd+mQLcg4kjzcqdL6kOz8r2n9D1mIBzDPMlDJWD9CLFX6DvYdkg1X0v1s+RSKtCKGgLKk1hIiSxuRVNqRDL63ipYXZU/O0Bqp3XD4LAB0MNQ9zs5PElXro9HjOZTLk4UglM8TnBUlsU1PeG6ypyhBxjO4u1400hkREflDsp+Z9azBDkqFZGO2UoSoqK8i6fR4uKqjAApQefwIGPe+7/PUgpkbQ4mO8Dwrafm3Xoa9OQD7RCOAb1I0h8zKUOnKwvaWhGZq1Xe7YXK9rMFswu7RXvLwf4yJ3ATLq9enjPNENQn/elNmAqaR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 13:50:50.5290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b526b2-5452-4ff8-d743-08dc5252bdd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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

This commit removes the lines that describe the 'streams'
and 'stream_count' parameters and adds a line to describe the 'params'
parameter, which was missing from the original comment block.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2138: warning: Function parameter or member 'params' not described in 'dc_commit_streams'
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2138: warning: Excess function parameter 'streams' description in 'dc_commit_streams'
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2138: warning: Excess function parameter 'stream_count' description in 'dc_commit_streams'

Fixes: 515023b2ce5f ("drm/amd/display: Add handling for DC power mode")
Cc: Joshua Aberback <joshua.aberback@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5a93278fa246..0ffa79d83bc7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2125,8 +2125,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
  * dc_commit_streams - Commit current stream state
  *
  * @dc: DC object with the commit state to be configured in the hardware
- * @streams: Array with a list of stream state
- * @stream_count: Total of streams
+ * @params: Parameters for the commit, including the streams to be committed
  *
  * Function responsible for commit streams change to the hardware.
  *
-- 
2.34.1

