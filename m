Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEE7C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60DA10E2B1;
	Sat, 26 Feb 2022 15:42:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C58710E29E
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFL4chMYgaTYl0zfW46OK8oB8DPI0xTjSvXlVoU2MldfpvFyM2U6o5khN3WwAyvJ0MKPbQFjLl7eVxmB7zg7X2E6vNC83kTWMfglk8YGW3eJaIWsMpeqGzfoi7iFSfDhlx4NraSKof9bmwGuKb6dxwHBOLQ4Hysp1fmAWINhiTTEIRjB01MH9wU+dnPDI37BVej3eVx9Ma2Y5cBRFN6VeH4ZpJOROTaZoGXACbX3BOPLNX09WaUgk6MZEa5UagWKn6mv2JDjr1Kwj1hJXyXaGdj8n+R1xNJHQpSJDv9JawxYoeRWQFIDiUelQ1CvgJtaoSYpq/py5Vi+UADCgvJInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AlygvKdBtov1sL4pUz4zv7eptzqkZlxLPEKsyzLeuY=;
 b=RTYt5jAvOAq6uHu4623Xlu4r6m4cN3rcj08+dlYGxiiDXRg+UWG8Dh/7ipIwGSclFQt6YdD8qqJCUsALoEn7KY8eFa/siuXlTEMATZpJYbWEdJBlwroj451kkzjW0/wU+QLejdnoCGiX1JbKn/iCBTLtKe4LBFcYjtkrw2cF2vjHmFdMRDOUsv03WAuIsAX4H4LxxhCxbIU/op9oawIMBGk6A8uVGicBueY1l8TTGDD7rk0j0mYXVERkiWlLlFGeU9surV6BSRwhjsN3U2Is7VSrGmjZOHiOm3vJcE5aVn/bAlOWi8ckLJ2nFZaPr+WN8B7MAhZa4hg6wZvJ+0TL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AlygvKdBtov1sL4pUz4zv7eptzqkZlxLPEKsyzLeuY=;
 b=eDPq8h1/kWufWMXdQj8WTrMJuRJc8ozte6cezV7E8OxAQKk/bSMa0M07edc/gBAEOa0f5MfGrDisS+gumJ0bNvXKkeHAsMso0o/6Mc09rVQ7Gzo15pYNF1TrGEi1KUue72E2IQ6AFw8YCZeXcu9Q2MOe0pAtkG7vININ0mJX+Dg=
Received: from DM6PR01CA0024.prod.exchangelabs.com (2603:10b6:5:296::29) by
 MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Sat, 26 Feb
 2022 15:42:02 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::d3) by DM6PR01CA0024.outlook.office365.com
 (2603:10b6:5:296::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Sat, 26 Feb 2022 15:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:42:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:42:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 07:42:00 -0800
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:41:57 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amd/display: Modify plane removal sequence to avoid
 hangs.
Date: Sun, 27 Feb 2022 07:41:09 +0800
Message-ID: <20220226234117.3328151-7-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fead126-b4bd-40f7-262a-08d9f93e8860
X-MS-TrafficTypeDiagnostic: MN0PR12MB5740:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5740F6090F8F001A0A862F42F53F9@MN0PR12MB5740.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QuCiYb6jMyCRlytcWG3rv+esvJptQOlh+De55fuSMaHewFdO2+FPZ/VhwKQMzXE6UcR39GAoKxSp8Qws0lz+qMYne+VGwH6tuM09otJACYhwEgb+pbzwWCQt+MOQe+phthCYulMtFtn9AiuVlT27BFy7r/Tb3tUT9eZohfaLEm96Toz4yS92PGOokRubCwuQoyYpD07rmZp5pK49Aq8NiKqscNR10kLIPYnp1qgzdrZG7rigVfUp/ppSBytlp7wdYvx4gdC2oiLjied9XfpbQ2FhhLK+sxclTy5IPUW2jJo0gV/JeoWFD+An0tbAEmqlLeo1RivsIkYR0RJ6L62BqR/DQl0OECGKodwbUJtYx7mUYom0MRobRw+lGl0dvjk0e5mOF71RHtjbcrDTeEb/8Te61Yn2ZOoUzVaFIMxmRSbpcNSDsOWbx7wK6GRHSxU3ujGjjpvWW92xQSOq0H72KNBG1Ywa+BPDdR4EJBzDWonbMQL93AkjicPyFKyGg0KRbtIH8LFyg0kgfC79sJawAG1bA1WhOc90+DM0xauhb8/R+oxkamEO99jniN2o3IUQk3JgZauJlZCM/8f9ewaCXrgdm1YrOSdxyfW1F69W7clWlw7sFRnQKGoSDJHKSbPI0KfaBm/4/yDjH5SIZ0YE6ptyuqxYVU7L/zNuV4JndL1FkPieY5WtJ8OsPCj0fXw3MHJUW0LC3qDMIOzqJPoM0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(86362001)(336012)(186003)(26005)(70586007)(70206006)(82310400004)(2906002)(356005)(36860700001)(81166007)(1076003)(7696005)(6666004)(2616005)(508600001)(40460700003)(8936002)(5660300002)(36756003)(4326008)(83380400001)(47076005)(8676002)(6916009)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:42:01.9833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fead126-b4bd-40f7-262a-08d9f93e8860
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c      | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index b467c0376027..bc9dd48258e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -107,7 +107,7 @@ void dcn10_lock_all_pipes(struct dc *dc,
 		 * (un)locking. Also skip if pipe is disabled.
 		 */
 		if (pipe_ctx->top_pipe ||
-		    !pipe_ctx->stream || !pipe_ctx->plane_state ||
+		    !pipe_ctx->stream ||
 		    !tg->funcs->is_tg_enabled(tg))
 			continue;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 33d74ecd893d..a665af19f201 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -931,10 +931,6 @@ void hubp2_set_blank_regs(struct hubp *hubp, bool blank)
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 	uint32_t blank_en = blank ? 1 : 0;
 
-	REG_UPDATE_2(DCHUBP_CNTL,
-			HUBP_BLANK_EN, blank_en,
-			HUBP_TTU_DISABLE, blank_en);
-
 	if (blank) {
 		uint32_t reg_val = REG_READ(DCHUBP_CNTL);
 
@@ -947,9 +943,13 @@ void hubp2_set_blank_regs(struct hubp *hubp, bool blank)
 			 */
 			REG_WAIT(DCHUBP_CNTL,
 					HUBP_NO_OUTSTANDING_REQ, 1,
-					1, 200);
+					1, 100000);
 		}
 	}
+
+	REG_UPDATE_2(DCHUBP_CNTL,
+			HUBP_BLANK_EN, blank_en,
+			HUBP_TTU_DISABLE, 0);
 }
 
 void hubp2_cursor_set_position(
-- 
2.25.1

