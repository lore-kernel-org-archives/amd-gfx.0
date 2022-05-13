Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FD7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 20:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756EC10E922;
	Fri, 13 May 2022 20:51:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1A610E7FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 20:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKKzh+R7cIGqsUf+79JI9ZnuKjVuTuJz/2/vmEGcmcC6EPMIQSydsLqyGDYNSmSgF4uyNIYOsYXdkjNezIlxutiouy62Tbfx08ldtRXpPOwhYoM05LyyZFaSzVrS5oA78sHssms6xd/UDJTiztboUKZql1OqdpwVyCc6GL0KyOrKqgPfquMrSGG4sLmPaZXaQVhmUmznATLklCuWpQLwGyZsRCeSOHoGKMTtkK6ohjzHpWhu4w6umTufDHe6BedLq40G4oftDGbE4cjz3MQeRp0Iszmd/w+plW99AN5fLDi1frq3K0QjZAITJI3UUUEr9TLyKUH7I31kroe2/Sca6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rv01nESGvnop+CXY02YaGq/lYhwns1pxUdMe/49ZDkE=;
 b=A8bvU799+0w4EB5zuhkcj21c8I7Koo4rzkD0Q4qL80iXKwFBcu/CiU+u2Je85EYRNSc87n3wgNB8eEWkGes1vzblPJz9QhCQimQqpFu1RyaKQ9DJkGq2RwFX/toeu8HXlEkGN/EccofrSWl30E9Hh0iOMGRVu3As00eT+4dHKgu29zu3fOR0nc1RdL5uBK6QOHPsPKn+xFYSqEYym1jD+01+QlGAhRN1mcTE2X9G+nW5F1cL+wMKyP2VBm6akRIrl5XVbRqyR3Im76HHbeJdhA5jK3nWuYatmU6mW91v24dm096VoEefgNGSsr1FE7rG5u4AShdqxdoPxKq8UkWitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rv01nESGvnop+CXY02YaGq/lYhwns1pxUdMe/49ZDkE=;
 b=x7rdhye3Tl1tCerpyNfGfLkOc6Yjusl9Ko7SEGwLHh/HvWWpXA98Jb05KQeko8nSqbGdqDXnkdS8aDu0eDrgYcVXu13314m2TZ3ENlSf5SkrS3TVA3KOd/WIJKUPk9nJWBPw5Tb67p1grC1KoMIX+mgJpiABgOFqgZp65nspnz4=
Received: from MW4PR03CA0300.namprd03.prod.outlook.com (2603:10b6:303:b5::35)
 by BN6PR12MB1587.namprd12.prod.outlook.com (2603:10b6:405:5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 20:51:27 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::5c) by MW4PR03CA0300.outlook.office365.com
 (2603:10b6:303:b5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Fri, 13 May 2022 20:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 20:51:27 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 15:51:25 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/11] drm/amd/display: Clean up code in dc
Date: Fri, 13 May 2022 16:50:33 -0400
Message-ID: <20220513205041.1311639-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
References: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4338a7b4-c385-4f9b-e284-08da352259a5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1587:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB158784D1060577751F73E8D7FBCA9@BN6PR12MB1587.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IScn31P+DYa7a9LUEOOfxm9ukN0Q9w0dKDMG6WI4j+/dlddOikjoQcy5WlpGjaI5mnKrqHhyEea9MCSaUp1ghcHs21vgW7VrckAVMNmbW3qk55CNXmEUaJzhHp3A8KuhLYScBlgR8tCZteQkwfUfUqliuEokoqe/J3taDhqVjqVPNV+duCL3zaObHAhN9Oujbj6O01042JhBVTCO1RORNmt3JUpabSD49H3VGymZySewyFU3fINcApTo8rHAnLBLdvjQtQQLWJw5iTk//SbHTAVNl6+eXPy+CMncM91BKfJ024x3DYcuAb8nq+F/1+QWuf9oeLs0l9XnWPFSkvt52gV+okxcvDSid/4WRyZff2NmirrjyR1ZG0xdvtHsx0aepYmAm6IHaSMBWK7g5owiieMx8oIL+l0lONMMCLEAsTnCsH76pTV71qppYfvN6o209gNXBeFbv+TpTgCu0bborXYk5o7iCNYBMOsOdHr6MXT19NT8SebNAefO6Cwpeo9n0gCac+rbDAPhDyuCVB6R8xl38m70il2PruM7EcvHgTSBjq63LSodEnmGCEZUtD2v8V3GVwJm7+idTEpU/cG+vAeUSuW6xbpEq7OFLZM++t8Wb4INN24eE8DC2cubGUgEj0n4KwsYsAqUU0fdz2giNr2Aj6vbF5Dxr+MgP5U8QTZnpEIijhOkcH7eeBGovIlX/9+92ZMPxqkGe+my3GbI6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(26005)(6666004)(336012)(5660300002)(2906002)(44832011)(8936002)(40460700003)(36756003)(82310400005)(70586007)(70206006)(81166007)(86362001)(54906003)(508600001)(356005)(8676002)(4326008)(316002)(1076003)(16526019)(83380400001)(36860700001)(186003)(47076005)(426003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 20:51:27.3675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4338a7b4-c385-4f9b-e284-08da352259a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1587
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
Code clean up in dc.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 15 +++++++++------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  1 -
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e41a48f596a3..f14449401188 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2901,14 +2901,15 @@ static void commit_planes_for_stream(struct dc *dc,
 						top_pipe_to_program->stream_res.tg);
 		}
 
-	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
+	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		dc->hwss.interdependent_update_lock(dc, context, true);
-	else
+	} else {
 		/* Lock the top pipe while updating plane addrs, since freesync requires
 		 *  plane addr update event triggers to be synchronized.
 		 *  top_pipe_to_program is expected to never be NULL
 		 */
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
+	}
 
 	// Stream updates
 	if (stream_update)
@@ -2924,10 +2925,11 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (dc->hwss.program_front_end_for_ctx)
 			dc->hwss.program_front_end_for_ctx(dc, context);
 
-		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
+		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 			dc->hwss.interdependent_update_lock(dc, context, false);
-		else
+		} else {
 			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+		}
 		dc->hwss.post_unlock_program_front_end(dc, context);
 		return;
 	}
@@ -3052,10 +3054,11 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	}
 
-	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
+	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		dc->hwss.interdependent_update_lock(dc, context, false);
-	else
+	} else {
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+	}
 
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index e1f87bd72e4a..0da024912dbe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1773,7 +1773,6 @@ void dcn20_post_unlock_program_front_end(
 	 */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-
 		if (pipe->plane_state && !pipe->top_pipe && pipe->update_flags.bits.enable) {
 			struct hubp *hubp = pipe->plane_res.hubp;
 			int j = 0;
-- 
2.25.1

