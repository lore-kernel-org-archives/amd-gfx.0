Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD97C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6A29010B;
	Fri, 22 Jul 2022 20:39:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 191579010B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWojnJC2w9uwpfa8243WXLULu+oXzFMkAWW/a51/5f8kIEyXQiG66EVb25TRV2WZu5nUcNFXH+UotMrhAk8G64dWzlRkxWWqy+joWEQQWR6NM/QF8JyCFdY/yHye47IC3TaPLK1QYhsZFga9w/Wmf5wqO+9mgLiS6G9E/wBiotXKxQGgIn8WcOJUOCE/OnZlXmoVi0q+elKTVPSGHeSAVZHp2CHCKihOisfCoUHAC4c1k/8O0S5bu8RbimI68ROBbtiNqDYl09A/AoLQyYkQCYNSF7R5JA143L2J6zZH/Pbc/BdySuEPGY4hfsnpAFAQgWMxmA3iEn+Nd/LFvTQiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlX3qEnpi0nsUP6b5tMfJ+wXyEIoLBCMru5/yqeSJJY=;
 b=EpG2AtCy3Ubd0qVHH57VvFTz5QUridXrPZn88qbSIcyKC6iQpnYg/1rAAQ6Iv3egvWBYRM6CdHtROpAb8zMLbLXn6jHFHoHfXW1Ua2cfMr11U7fWfdyFWl+dl2zl/bdJYqoScbsPi5c9/1RHTCuI8X5NhpqZ8tD1OsbFCK749PpVbp7i/tva94X74kaUWttXzA67Sc9bQTwP+t0hhqOMgr9RIZ+LvDHoW+f5QVpSaX2w3dCj85GCNDDTo2ZwhrrNLg5xjwoLvPPmwTH5R6HZeohfZgfdZTUMB6LDjBp4OhsWfcAcCs848CYH2p+HPWKTkdRnp8r/J9M77FhqGHECBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlX3qEnpi0nsUP6b5tMfJ+wXyEIoLBCMru5/yqeSJJY=;
 b=qQaqjP3bhPodlDrYMAyE5K0z/i6tT4T//xQfOv0UOumkyDHCr3lXJFbW2lfyyL5OcX3vKVivdOz9WhX6Q6m4sPpnUjEBy3ie898rQ5BxrTsQkpd0aBvyodYkXXFOLpVKalsQd/D82q+9YCsB+MbMaYezAAHFQBIOkN4knU4/aMc=
Received: from MW4PR03CA0116.namprd03.prod.outlook.com (2603:10b6:303:b7::31)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:39:16 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::c7) by MW4PR03CA0116.outlook.office365.com
 (2603:10b6:303:b7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.22 via Frontend
 Transport; Fri, 22 Jul 2022 20:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:39:15 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:39:11 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/31] drm/amd/display: Reset pipe count when iterating for
 DET override
Date: Fri, 22 Jul 2022 14:31:14 -0600
Message-ID: <20220722203137.4043516-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04afd0f3-5ba1-4732-8fc1-08da6c223e8a
X-MS-TrafficTypeDiagnostic: MN0PR12MB5812:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXRpYGwnXkkqV+f2UYM+DRyQgoZLV5IYcUysXpqI2ZVGhJipJPM7jqvdK3JoprxOHVc6pVaY/i3w3i4dy+au43J1svZ3Q2e1tglBUKF5z0n2fH8z2VQKBFD37IU+pb5W0dl05dpt8tLA1lKbXLRSva9atf6g+KTYTXM/+Cup6ofl4HBMBhLLI8hceMzHV+gyv1tIcV1SqgQ/n9vuvJrKX4UwGDriam6d5aGnqjFyJ8FUT8SIEUabQ/s0Cg+SBsKvQIWgXIGXDUKcX8PAXNptqciyxRZhnPfLXOSSkp7uASU+LCQt3dTA0ebtq/gfhrl5YMFogFhFtOuuXdrvAHRDrXEVzr6L2lgvD8UGIrPHaTUii2tnEJ/ezMZz01QBFt0hkmTqbeHHYSvKH3GE0hiHsOZoE1aHJXrnD0wlATiuSsmDeYnzz0+ARvw0JRj7FpvZith2WFjskUbK5m9hc53weg4WQj5SwEg/ZsUk+TDtKQq/julhm2VaO+O8MRdHRU7GrOnCmr/cJIUu73Nk2zC7l7h5iiWW3FuGlCVjjY6oOWggrOBA2B+ak6hKKC6jz3XGcHBgWzf2DPNw6xzji707NK0ShpgSt5Quc+sd+yF84HFRdu7pNs3sQ2v7Z1YazK9n4PczX6NT1lOyeIBV/1rM3kGEPFVTCpo1+4U7JOg9If5yGZFxh4/1/T/5tYWiGepJebPHjQVVRDm5FRxH5y2OzR5jObyiKSbamYGfCMWGiHc2PgacAS+xWXRLCPGtdvAxlvEsl2jgeaBDsOpfgQUslCwDtV6qc8tQtwee03wqsBUbOsEjGG03fbVMPomstvoffWs1AQLgv1FzyPwGCLFyBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(40470700004)(70586007)(8936002)(5660300002)(47076005)(4326008)(40480700001)(8676002)(44832011)(1076003)(336012)(82310400005)(36860700001)(7696005)(83380400001)(54906003)(70206006)(40460700003)(2906002)(36756003)(86362001)(81166007)(316002)(186003)(2616005)(26005)(426003)(16526019)(356005)(6916009)(478600001)(41300700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:39:15.8427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04afd0f3-5ba1-4732-8fc1-08da6c223e8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 daniel.wheeler@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why]
Coding error in DET allocation was resulting in too few DET segments
being allocated, causing underflow.

[How]
Reset pipe count each time we begin iterating through pipes for a stream.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 266c49884f04..b3f8503cea9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -184,7 +184,8 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
 
 	if (context->stream_count > 0) {
 		stream_segments = 18 / context->stream_count;
-		for (i = 0, count = 0; i < context->stream_count; i++) {
+		for (i = 0; i < context->stream_count; i++) {
+			count = 0;
 			for (j = 0; j < pipe_cnt; j++) {
 				if (context->res_ctx.pipe_ctx[j].stream == context->streams[i]) {
 					count++;
-- 
2.37.1

