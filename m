Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF60ECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E84610EB4B;
	Sat, 27 Aug 2022 02:27:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB1810EB4C
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YU9dUA14W2VW1jChXXBwoqMEkNKCAcnRMd4DhtdsJ62JHkvlDYbutw56GUqGUsku4+kYbWc26R/NoBs+1Q0IIZ4tVv8K0mar2cxrjyhrLC0srux9xszC5xPJzAWFfd1nosn5McN0OF0ggSb86DVEFfMg+3QZ3GHTE1agr2AzRwhogrFCdHjaIY8vjr1Fnmy5Z+j4z9XipSduK9lflhzIsFgzyzq0P8swPiRnuq8NmEj6PPzn7cY4QibUKQQ23fOueVmd/xoJaw306t+Cvh3rQt4HWtYKMre4IZECbzg6VlZgY1i6WxkP2DxREqGRQHt2ELp4YX+osoTqL3wU6vprAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMIlN4mb5p+GvpxOl48Q96oKLFceHB/artroUPwwUWs=;
 b=fOeJtVs9rcd/LBmLXwizsom+ofwttiXOLcLubHx6itC8Nlg7TW8hudCl1MSW3aFeL9DRY2eRWCug/Y9lM86JWb46etXQLNP6raDXENZt5oLswYfFkMiWU7l6RCAXa24ZeY5Vg54Utu/1IUuHMnnte2Jw9N1U+P/7GzHvybEXNd/ngeEp8YNmZB3lNvajatJ1UYqakq9DSvNQ4FpJRmGkCwVM7GHY7rHtSEF/dT7B4TVxO8ztAxjFI7Wv5HkfK/uk1W7qL4hTs6QkiRoU5AOjq2c+i+sBS1nmSQd8W9divDUjfDCcM4HW/s8D9BYYLFkTtwSSt0EX0HZRpFQEbMrAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMIlN4mb5p+GvpxOl48Q96oKLFceHB/artroUPwwUWs=;
 b=lXNqQzY4gKg2B7WalJtDIsB8qSD2dWhvTqn8wd9ZxxmR410toouvkVK9raK7+U1/5VI3URdj5hyYx7hIqqzea51K0UFKKcjSjaEQbZLEONi3LRxXOFCNf+saYTWOeVGN9zwFWiQVVkug6wIH6SvMGiSDFIm4nQIMpzmNP7NJha0=
Received: from MW2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:907:1::25)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:27:32 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::5f) by MW2PR16CA0048.outlook.office365.com
 (2603:10b6:907:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Sat, 27 Aug 2022 02:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:27:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:27:30 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:27:27
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/33] drm/amd/display: Only commit SubVP state after pipe
 programming
Date: Sat, 27 Aug 2022 06:26:58 +0800
Message-ID: <20220826222722.1428063-10-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826222722.1428063-1-Brian.Chang@amd.com>
References: <20220826222722.1428063-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b34a1651-eb43-4e18-7b58-08da87d3b1e5
X-MS-TrafficTypeDiagnostic: DM4PR12MB5295:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LcHMaFLNk4qIDqsktsOId7q3NbYIhSk8nlbuZlZWhwDZYi+6ovOfSRHFaVn3FDe9x+ALrVeZA5DDmdUXrnR4JsCasjgauljzAfHCSyDdjVd6+Ilnp9IlBrz876JlHfOUHX1i6xZ4tSDFw6zohHhBHBugOGENoXYm0ushj+J2pdQfhfc1/NtBXppv7RKi5PGQ+UEqMfXKH06pyy1v74tzqC+g+tBZtNnIBodd+krxauJ8X+D5FQE0kUAnKaWtZVDawwo23xUneRrv4VJ7Y56zShYFSXPU3Ezl4ROjodp/ZAt741lPMgu8OLSfiit1l0flt2KfpmX4XDs3TfvLyHdfAo2uBCgPVIlYMmR5inUJtxLmBoa2W6WhYvPnh1BWE+oH8P+VebDHJ3fa+MLlmsZoax4/m+swq9LarkZEwzosN6jx/bPDi8+GhnB5OZxUMUXezpb2U3H9xzVPqeljjcFrA+ioLOea+aY1Rmopclk2lvbnGCn0NXQDK+P2Lp+NmgTr20QnI7B7QnO+hU8bQ5mDElFXxXZOGJzE3B63kLOiK4c2u9rUzP0pILGe/QOc8medpGUdJqDMZ+7w6+0QMYFGeFQwXmFHxe4W9ANZEGZyc7fx+jcNJ9OVZD20mab5TZonrWMOH2PAkRWsOrGPYRW4T0Bh/XsTFS4TIm40oiWDtT89whtAu1Gt/uEN4yzKox1rmX8UEm9nhjh93fyEGPkVWIHEin3HDMoCz+flJHGsLd4CDyOb84cutTThfsoJqMjsK08+pW9+4kZAmBytGMW7M0yHIlcPa/4AcX2NUrOmUvt1n3hzg/8TYchZcG29xuJDoKRY0n0yp2rETIX6HvTZ1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(40470700004)(83380400001)(82740400003)(426003)(316002)(40460700003)(186003)(82310400005)(86362001)(6916009)(36756003)(54906003)(47076005)(336012)(1076003)(478600001)(7696005)(2616005)(4326008)(36860700001)(2906002)(8676002)(70586007)(70206006)(26005)(8936002)(6666004)(41300700001)(81166007)(356005)(5660300002)(40480700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:27:31.6927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b34a1651-eb43-4e18-7b58-08da87d3b1e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
We only want to commit the SubVP config to DMCUB
after the main and phantom pipe programming has
completed. Commiting the state early can cause
issues such as P-State being allowed by the HW
early which causes the SubVP state machine to
go into a bad state

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ced09f875e58..95daee11a445 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3333,10 +3333,6 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (dc->hwss.program_front_end_for_ctx)
 			dc->hwss.program_front_end_for_ctx(dc, context);
 
-		if (update_type != UPDATE_TYPE_FAST)
-			if (dc->hwss.commit_subvp_config)
-				dc->hwss.commit_subvp_config(dc, context);
-
 		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 			dc->hwss.interdependent_update_lock(dc, context, false);
 		} else {
@@ -3344,6 +3340,10 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 		dc->hwss.post_unlock_program_front_end(dc, context);
 
+		if (update_type != UPDATE_TYPE_FAST)
+			if (dc->hwss.commit_subvp_config)
+				dc->hwss.commit_subvp_config(dc, context);
+
 		/* Since phantom pipe programming is moved to post_unlock_program_front_end,
 		 * move the SubVP lock to after the phantom pipes have been setup
 		 */
@@ -3477,10 +3477,6 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	}
 
-	if (update_type != UPDATE_TYPE_FAST)
-		if (dc->hwss.commit_subvp_config)
-			dc->hwss.commit_subvp_config(dc, context);
-
 	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		dc->hwss.interdependent_update_lock(dc, context, false);
 	} else {
@@ -3517,6 +3513,9 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	if (update_type != UPDATE_TYPE_FAST)
 		dc->hwss.post_unlock_program_front_end(dc, context);
+		if (update_type != UPDATE_TYPE_FAST)
+			if (dc->hwss.commit_subvp_config)
+				dc->hwss.commit_subvp_config(dc, context);
 
 	/* Since phantom pipe programming is moved to post_unlock_program_front_end,
 	 * move the SubVP lock to after the phantom pipes have been setup
-- 
2.25.1

