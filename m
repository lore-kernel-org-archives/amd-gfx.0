Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B117C4332F
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 04:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC52B10EB42;
	Sat,  5 Feb 2022 04:33:35 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B293B10EA75
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 04:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmjBoPtROFABCbmiXW9l+8BQelE67MWRO3+FJ0nOrTWGlDd1rm2kU22yI90lvTfmd9m0IRB+6wjo7x2yRWNlRvj3JTKn00hUktmHgRj5TFxivmqRMifICCPlL51y2WffMac9Y9gBHD3EEZ19oDgY0qz1WeiREnlmoMfPoxCLDn5H6OiwzjJFSO3yq+zN8TS29ngvX/WQnxKcr+qi6kvn3ZqBT6kRrVmIKziaQTQq143rtsm7Hg8vdDjPqshcZ0sDlgkWFsxO7B1RqPlRYV7dR+jhF7UCvtWIMsXuNS358rXY7KkuDQ0//MXH1Wt6hc+gGru57D5tKm2KSBzc0kBeow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2nbQFIFQRf+DJgrXqTM9ByzJuvm7rKTVGIzVmD6J3k=;
 b=WMDWJfYl97nk2QUnFwkBeqgPxxFO/IYyO8mjr1qE/NGukeBswCaXH5Q+Xvx1Fuw8X4WckK5+cpUSIEyhSktQmgfl4RiwHNHpnyj/MHUGvLqukvAt7nJXlrf3MiC6680dWICPn2mbZg7XbMyIFDfRP3/A5CYPfYAxrmotLQIcstURyOaxouzvo87gzJTn/d60OdFXTOE49nUg5nuvfPUXwXP1CsQccN4zpE0wN5gZYlsG+UOj2vSCsWsCIKW5OW1YCH+L5iJJG7eOOUSsEAL9L3tFVfhFUe05B1zXi206zLC2wShJaL/194QCM0RfjQYUxfOcAKHakcrlcC1EXoIxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2nbQFIFQRf+DJgrXqTM9ByzJuvm7rKTVGIzVmD6J3k=;
 b=mzCvJxB5zC3VMNxTyqWTsHrCS3ptslL9oTwRe+a7ep3BW2DHd6nQD4K/FQQZReH3RCpiEGqfC+nnn86GW64ipBn+gv5oPQM6GKSYqUwItn/FqW29lYiPhnZQAsR9O6pW44akv8E5l/lZmqIXMqiPWJ8QZIuBvroO6ZtjkTHia2Q=
Received: from MW2PR2101CA0012.namprd21.prod.outlook.com (2603:10b6:302:1::25)
 by CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 04:33:26 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::bd) by MW2PR2101CA0012.outlook.office365.com
 (2603:10b6:302:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.8 via Frontend
 Transport; Sat, 5 Feb 2022 04:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 04:33:26 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 22:33:24 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amd/display: limit unbounded requesting to 5k
Date: Fri, 4 Feb 2022 23:33:00 -0500
Message-ID: <20220205043310.165991-4-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205043310.165991-1-jdhillon@amd.com>
References: <20220205043310.165991-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f644fcdf-0e10-42ea-6c32-08d9e860a6d9
X-MS-TrafficTypeDiagnostic: CH0PR12MB5330:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5330AD79A0299E5E3EF86BD4FB2A9@CH0PR12MB5330.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKEzuwnwrBflz62Kx5kPYyMTyXci9C5qiYUtU/ST0G3tmS1zLF7q7tNgiiE8Kod8D7qKWt2/mO9E8AOhB1P7rZj30AQe3TASj2397Vxco07j2fGD+JaBOObkeMBhW7fkWNq+4UorUxA2CgoXQ6V4Gww6bXsP5oU7vtH8J4mP+bFdL2HazbVaZ8CZ2h4bbAmvCZ8UkH43MTBPO9gGjmfCZc9muuiSpia4MuWxaU699+zWDFfGVbmuF/j2N1e4OOWTtd0h7ZGQEgVmtZXyYQ+SQr8Hj5cB3x/rf/9JnNX/IwimGkCZRO82sE0SPhwh6IcxrgNoU11qeqYFIL2lb/RJPe+gKRSZoAgJO37hnBe/4PI6Ak4ZfmqzoN+QJMTVmR6qcx0Qzmj1tYAI37A7J8Lq7GHrAp7JEmwmCXrgV11qoF3E29Pc70rTg5H7jhxegB+lMMdn+qnNwEJ8FBRVghBue+b1OA/hyEEUijHMm+7yoZOIGV3MwBGZdJ1xBVXDnGM5kbvbvJe+8w3rDsYL22N3bF8++HIO5vGwVrT/RoqaBnXQ6HO/rbTSpY96ogXjGGR6aBgy9g4ONniGGXv/rlrdt4cLHannHo+dUI47lwwjQiFR+OCHcfcca21z6RY+voWkOafkfouPxH37Lv9b694pZ0j5mIQRQyisd/GQB2VF/LdH2Ok/8JgEp7zPH929OrPQZTID9n037LohfY3T62krHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(4326008)(426003)(70586007)(36860700001)(82310400004)(336012)(8676002)(70206006)(26005)(508600001)(40460700003)(2616005)(47076005)(83380400001)(36756003)(16526019)(1076003)(6666004)(2906002)(186003)(5660300002)(6916009)(81166007)(54906003)(356005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 04:33:26.1376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f644fcdf-0e10-42ea-6c32-08d9e860a6d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Unbounded requesting is unsupported on pipe split modes
and this change prevents us running into such a situation
with wide modes.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 7f9ceda4229b..007a7dc4f5be 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1836,7 +1836,8 @@ static int dcn31_populate_dml_pipes_from_context(
 		if (is_dual_plane(pipe->plane_state->format)
 				&& pipe->plane_state->src_rect.width <= 1920 && pipe->plane_state->src_rect.height <= 1080) {
 			dc->config.enable_4to1MPC = true;
-		} else if (!is_dual_plane(pipe->plane_state->format)) {
+		} else if (!is_dual_plane(pipe->plane_state->format) && pipe->plane_state->src_rect.width <= 5120) {
+			/* Limit to 5k max to avoid forced pipe split when there is not enough detile for swath */
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
 			pipes[0].pipe.src.unbounded_req_mode = true;
 		}
-- 
2.25.1

