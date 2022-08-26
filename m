Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE91ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 478EE10EB66;
	Sat, 27 Aug 2022 02:51:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA0610EB68
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7sWgjM6lk5kTwUcGSqGd/WfHlWTzaJ1NoRbV9V2DiJUdsA9n3sBlxh3XlxxM6+a3ynfJ7bSY8TO5p85gtS3rBbljOmJZNi+6/RwJ5Hi3BznVQk2alIYUX3/PrPgXUl990TYFBc5c4nH60zYgL0tHXvDpx++q2XthdzCYK0s2vblEC2oP6N9EzVCxR3/CzGULQ/bvhyqyoyewqzBjCXLB7IJFjELxG7AsHGuJ+zz71xoSDOlidFTqH7Z9+bY/ZA3QrJsENB8HTjouHRJttqp9FQbW+dkyW6hkYB4Au4B2kd8uG0IOMp3SqWBHGsJY39BIhUGrbhPUPM6YP0d89NIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMIlN4mb5p+GvpxOl48Q96oKLFceHB/artroUPwwUWs=;
 b=Posh9uenMbGsipQgNdqT8fUMGbh904KDd+Te4CwS62YZ6TgVii6cH6EcqBLWa+cRFsPpeyRJ7J18RImg3QG7BKufii/El7TAku0AjRmqiITdLGV7hTSlntCuXtIIap1dJ9Mi0JjXTPKnltN78Ix5f32QeHBS6v2e8oiotRt40HNQNbzon6mj9QE5iRmoLSNVbnYIjcJQGg+2o65VHnBCp0gBFiu7Ee7YvbJ6UVYCxV67xTqOkoI82lcvSdtP9Tfe3JX2vJ9CZLAenpwLbKYlaY0xSvuK7iKTDni5jmMUdX0BY+QmQyMUPhr5gP1o6XgqAZGv28Vmhp9GzXXNdAGpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMIlN4mb5p+GvpxOl48Q96oKLFceHB/artroUPwwUWs=;
 b=2hpROChDZae/MDkmxWO+8+KOfQb/q9ulkISuxQPHAstCzrjv/T8ivR6UJJladqffLR+RhZ466CpotTfWuGCcsbg2c04eE+CcW0zqgJu/5X8B2cIJp5T/HXFgWaKgu/HQHFSGeszvLErxPKeOReqwzG/cMwMwtOWiytI2NXFuqfY=
Received: from DM6PR08CA0043.namprd08.prod.outlook.com (2603:10b6:5:1e0::17)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.16; Sat, 27 Aug 2022 02:50:56 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::d4) by DM6PR08CA0043.outlook.office365.com
 (2603:10b6:5:1e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Sat, 27 Aug 2022 02:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:50:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:55 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:50:51
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/33] drm/amd/display: Only commit SubVP state after pipe
 programming
Date: Sat, 27 Aug 2022 06:50:29 +0800
Message-ID: <20220826225053.1435588-10-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1101b241-999e-483e-d1ce-08da87d6f6e7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z852Dbt6qk3kPWlRzeYTjcf+9NoTCrQ966zIKH+RZdsG4Aw4/7nC1p8mjgmEP34lHSljVpio7WN8tkj6tC7XTXIOWJglDBD34fYa5Ky9jsrPQn7M3Dw/NcOe+AgAXq1kaHxBkmfvHZYSWNiaD5J6TiOzdMG78UPK87ujNob3D31vtxBNP60/sHjTduhq45AHqvXAIaxQfmC4KIcqRMyi+4aDEZAflayLOEs3uNQ5LkqK633q7FJDE6nK77YTxNWSwcI08YriuFxAsnmn2F4vi9PZBaMRxhSVlD6VL+UvvsWmmlopr5/vszwIN3FeqeiXPNT7Nk/d4A3+NM3S+L/yl+LbnSZSRfjoWK5zKj2tkivuYqdp5G0L9IgMQFf67Etu/6Vj0BxUV24GzOzaDA9Mk6CV5hNcK3uCEvb8OYFfF4qhIJFkOsjyNyHlJ6c+W1xMovIWJpAhPz+Sza8qg3aPPFo2qe98T2endvkDLJFDKPvb2NLPvms2GE/RAzKfXKU06wHXc5oFU64jcK+OJwMTK42GCDGUJtWbKnmRA1/2QRoW51/f2ZsYeooSh4uqlJFMWE0w62FmGvW8pWQuh8FxhDgTx6+uSdW3VLc9g6bdt9tIju/CWkfJtkyXxDZhIQSC8kn2TH9dPC8UFLEx6ds5L6/IV0frnV2UXqRScCfQGY/YHRask69Hs9G8xYd2cr9pCk87GEQh7QV/xTlz7bUiwOH8dG14Y7hY6h7Vvw5Fl5tiah1tT9sSUedmWiXgYhAJkbE5ulavA7zNxQ8wupHaW8TEdlpDlQpmnrQ6acluYg1G+yfmXo3n9qzgSLhA/HL4DFdjSKUfklyzsT9dFt4n9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(7696005)(6666004)(8936002)(81166007)(4326008)(8676002)(36756003)(356005)(70586007)(82740400003)(40460700003)(5660300002)(82310400005)(40480700001)(86362001)(336012)(70206006)(2906002)(2616005)(1076003)(47076005)(186003)(426003)(26005)(83380400001)(36860700001)(6916009)(54906003)(316002)(41300700001)(478600001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:50:56.0547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1101b241-999e-483e-d1ce-08da87d6f6e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
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

