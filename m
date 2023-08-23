Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03017EE49A3
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6913B10E46C;
	Wed, 23 Aug 2023 16:04:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E289710E466
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfA6+clvR9HFHQr6RVZkAeTdPQMeIAMqbtCuCr/mXTjromWv5Wm7jOUIPtWcfksMIGkzR5ImeYyEQI2bbIfwLSIeEtpI0LNqL7z4ubqlMAvorveEr+M+mCgw4+UwPWxftsoA/Y5q2glrJvUAKcgWfzv4kG4HxJRuI7Y53d71lXAYrSDpJ5Mt5dOKpaXGBbFaVZ5zwEJs4yzx0TV7z8tjUN25jATcMnyu8TvArCGec90k2SvhpRgA9Ng8QoPHKP7yPjxZVgl7gMrAIEnz29ust9pir67cHHN/AVwyym+dpTIe92YlKev0HbRg27soGpu6Nf9F2bHas9PtvSUWQPJetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ALULStPyEqytKmvpV2lgujBfNZPKK/5NZkZ7KT4OJ4=;
 b=c0uvPt0CK3ITSWyLEDtfh+rvwRwtoS/nE7tXQGH1UeylLocoqoKhHSEYZbJfZcoRuWKhb589WjEErkbK67GnwnUJn9/JaMeHn0J0BUtBqPvUoSV195e9IRMTbJDBZmxH7wHzPMG/ZQ4E7mMTVlIspzW6uJVBzzEWfUOCdXT8bahymg4uihBk0laHt/3x1/clopbOc4Nb01U8xjNnp/F1yHbGyUd+0cnK/ksgzK2Z5/ShNvSkWeGl6pReW8CCKeYb4kYnSfLeF3N0/q5nSL5tYI6aQeQHfijTuBByAHrTOMV9Xt45HOY7FZtVd6uKUEdnFZ7JMYQJ4w4lRU3kSaBQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ALULStPyEqytKmvpV2lgujBfNZPKK/5NZkZ7KT4OJ4=;
 b=PTKguJ3uZdqULdadbup5Jg6pqUz1OW2tN90/Wr6voCyUSThLJ5US1M0d9k4j+wQjGWUchNP5+nZxAHIqEf5AivK4s/876DR695nqcGojRpuhfPkmt42KIwk8fb99pvCCvGHnJ9kRsJ9KPOhr93gIv/6CltKnTg/J91Olk+jOTtI=
Received: from SA0PR11CA0149.namprd11.prod.outlook.com (2603:10b6:806:131::34)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 16:04:25 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::cb) by SA0PR11CA0149.outlook.office365.com
 (2603:10b6:806:131::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:24 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:23 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/21] drm/amd/display: add comments to add plane functions
Date: Wed, 23 Aug 2023 11:58:09 -0400
Message-ID: <20230823160347.176991-8-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: cf581a87-82d8-49a6-53c3-08dba3f29f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: naI/NPhfou9eZFAwCb+eUjt8T+BQYeYGpU9mRK7IOSyd15rrtoqQeKO80IrGV3wp3g121vl3cgopQuW9TPvqA9t+UjAD8C0bUDY9j4vYd8kZIZTps0B0cA2XTZzHT5ui+eT8i1AqdhlzX9EUMyQ5drbNczoh9FtF34mN8TwM0BOvfKOvFR5UaGFUQfxDrJ0ZhtFC27I4JSWAwNGTDo3pyUtzfW2qKZA0oYY7gz7HLNl7vmGQ9+rhYLC6btRvL6DsLtpZLhp5BBAs8UHX9SxUS68ROdMtWJFzTPDixxuQyNA7AMdajD9rfJpY+TF5dGszUNB1DVlyOx6V/q/1AUW7YANDiQjNG6meXM4pseLIFKvxDMxD3vHPOm36podlOomVB9BoaX1QrjVSIQu49ZeOS7CU7eIR7+i+anGsD3xjObO9EEb4eG+4xwah/cSwLoPuLy6UXRJK1DI72yisfh+fbLuUTbQLZmbqA9SP+b76Pla3Y2kTe5St/XSk7ec0upHF5cLpINPVs1slXyXP/zS+t9Oa5TBpB/5N09TJJA3eYjgE1JVLcGUA/QyWToUdB+PJWk1QwcLJFf+6qU1r8wSp/dlVjhrHYSd8flRitd0ozwx0izNEZHtT1Gxx3yxsrKjftAaBMFl/QYWvKzh46iSDs2UOT5BFj1hij5Rd3qWeGBv0gY0OWrnNFT0COpHjLtQBKjDywSlnl9euoAaZaNFEijLGfzMUvyDx6yR5x0uOgNSmJKDliu6i01zE0g1rz8J6P17xOnL77bmJ5s3v3oPpFnZvLyMNiiR0q50g5cLfwj/QGFaI0wZeM3F9wuAcvPqO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(70586007)(70206006)(54906003)(5660300002)(44832011)(2616005)(41300700001)(316002)(6916009)(2906002)(478600001)(86362001)(4326008)(8936002)(8676002)(81166007)(6666004)(40460700003)(356005)(82740400003)(426003)(336012)(1076003)(36756003)(83380400001)(36860700001)(26005)(16526019)(40480700001)(47076005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:24.8099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf581a87-82d8-49a6-53c3-08dba3f29f0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050
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
 Wenjing Liu <wenjing.liu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

Adding detail comments describing the problem we are solving with add
plane function.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 91 ++++++++++++++-----
 1 file changed, 70 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f7b51aca6020..e4fb76d8e603 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1828,6 +1828,30 @@ static int acquire_first_split_pipe(
 	return UNABLE_TO_SPLIT;
 }
 
+/* For each OPP head of an OTG master, add top plane at plane index 0.
+ *
+ * In the following example, the stream has 2 ODM slices without a top plane.
+ * By adding a plane 0 to OPP heads, we are configuring our hardware to render
+ * plane 0 by using each OPP head's DPP.
+ *
+ *       Inter-pipe Relation (Before Adding Plane)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |               | slice 0   |             |
+ *       |   0    |               |blank ----ODM----------- |
+ *       |        |               | slice 1 | |             |
+ *       |   1    |               |blank ---- |             |
+ *       |________|_______________|___________|_____________|
+ *
+ *       Inter-pipe Relation (After Adding Plane)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------------------ODM----------- |
+ *       |        |  plane 0      | slice 1 | |             |
+ *       |   1    | ------------------------- |             |
+ *       |________|_______________|___________|_____________|
+ */
 static bool add_plane_to_opp_head_pipes(struct pipe_ctx *otg_master_pipe,
 		struct dc_plane_state *plane_state,
 		struct dc_state *context)
@@ -1846,24 +1870,36 @@ static bool add_plane_to_opp_head_pipes(struct pipe_ctx *otg_master_pipe,
 	return true;
 }
 
-static void insert_secondary_dpp_pipe_with_plane(struct pipe_ctx *opp_head_pipe,
-		struct pipe_ctx *sec_pipe, struct dc_plane_state *plane_state)
-{
-	struct pipe_ctx *tail_pipe = get_tail_pipe(opp_head_pipe);
-
-	tail_pipe->bottom_pipe = sec_pipe;
-	sec_pipe->top_pipe = tail_pipe;
-	if (tail_pipe->prev_odm_pipe) {
-		ASSERT(tail_pipe->prev_odm_pipe->bottom_pipe);
-		sec_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
-		tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = sec_pipe;
-	}
-	sec_pipe->plane_state = plane_state;
-}
-
-/* for each opp head pipe of an otg master pipe, acquire a secondary dpp pipe
- * and add the plane. So the plane is added to all MPC blend trees associated
- * with the otg master pipe.
+/* For each OPP head of an OTG master, acquire a secondary DPP pipe and add
+ * the plane. So the plane is added to all ODM slices associated with the OTG
+ * master pipe in the bottom layer.
+ *
+ * In the following example, the stream has 2 ODM slices and a top plane 0.
+ * By acquiring secondary DPP pipes and adding a plane 1, we are configuring our
+ * hardware to render the plane 1 by acquiring a new pipe for each ODM slice and
+ * render plane 1 using new pipes' DPP in the Z axis below plane 0.
+ *
+ *       Inter-pipe Relation (Before Adding Plane)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------------------ODM----------- |
+ *       |        |  plane 0      | slice 1 | |             |
+ *       |   1    | ------------------------- |             |
+ *       |________|_______________|___________|_____________|
+ *
+ *       Inter-pipe Relation (After Acquiring and Adding Plane)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------MPC---------ODM----------- |
+ *       |        |  plane 1    | |         | |             |
+ *       |   2    | ------------- |         | |             |
+ *       |        |  plane 0      | slice 1 | |             |
+ *       |   1    | -------------MPC--------- |             |
+ *       |        |  plane 1    | |           |             |
+ *       |   3    | ------------- |           |             |
+ *       |________|_______________|___________|_____________|
  */
 static bool acquire_secondary_dpp_pipes_and_add_plane(
 		struct pipe_ctx *otg_master_pipe,
@@ -1872,7 +1908,7 @@ static bool acquire_secondary_dpp_pipes_and_add_plane(
 		struct dc_state *cur_ctx,
 		struct resource_pool *pool)
 {
-	struct pipe_ctx *opp_head_pipe, *sec_pipe;
+	struct pipe_ctx *opp_head_pipe, *sec_pipe, *tail_pipe;
 
 	if (!pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe)
 		return false;
@@ -1897,8 +1933,21 @@ static bool acquire_secondary_dpp_pipes_and_add_plane(
 		if (!sec_pipe)
 			return false;
 
-		insert_secondary_dpp_pipe_with_plane(opp_head_pipe, sec_pipe,
-				plane_state);
+		sec_pipe->plane_state = plane_state;
+
+		/* establish pipe relationship */
+		tail_pipe = get_tail_pipe(opp_head_pipe);
+		tail_pipe->bottom_pipe = sec_pipe;
+		sec_pipe->top_pipe = tail_pipe;
+		sec_pipe->bottom_pipe = NULL;
+		if (tail_pipe->prev_odm_pipe) {
+			ASSERT(tail_pipe->prev_odm_pipe->bottom_pipe);
+			sec_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
+			tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = sec_pipe;
+		} else {
+			sec_pipe->prev_odm_pipe = NULL;
+		}
+
 		opp_head_pipe = opp_head_pipe->next_odm_pipe;
 	}
 	return true;
-- 
2.41.0

