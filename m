Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BA5EB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE5E10E62D;
	Wed,  6 Sep 2023 12:49:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA4810E62C
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBFL1njESSVN6fx7Y6ICeTR+Fa/AQgW0FnK3JmtsrWYaPQYLuw2U0yMPc4RPurD5X5Or8/lRdOCQPdfkz7VWBIJ05IUT53dqICx71Sg/HpKD+GOnuicfwXMNDrqHo5q7195G1uIY9/zJ/kos4Pr8rR8cMt97dXquPzadhPsM0AdQ0vWjEvob/XxGC63wSEFWBq+ojgXb14OiJz7zAfhMv55w34pMCBS4RX/Lek/HNruxn0YpnQvPLRg1uDlY2ZlG6Itj1TG66+8q0XIPz7WpE/UR4ltYJdyDrwxOl7tO/VMcYToFEVnA9V6wDu0EuEl9fnRzT7uriuMMyn1DzWonow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpj6nj/Eks4btAGRB/w4r5/AJD28gt9iW2mfXWmyaEw=;
 b=Xy93YOT+bEGBMDfCaB7tOv0zqI+oAIEfQDqzDsMZaJux5KL5kFC4ooZSPH5SJztPuorJ2qCz8WM4qNdlRUAJdajiXR9qBOb8w3WnkoUCfzbEphQNjz4CI0HYf2Jbi0gQw/rtxvQyjWuekYHUf8Y3pHUTOaJRgsCj+i5/wBV1qjXqko+p0tkZRdR1i+1Y8lufBUSL2m/GgxQer2mKnF3nXQkzHhAEKnkEuyKsczmC3LKvwBEbwG13eiIyizwJMaXo/l5UKDZiTSevcWYUFEi/OBh44hoL84cBlzA1RNSJbVGfy8iwZ1BNU0NbJELh1eVHhC6hDrQYGjgvmi1eT73mkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpj6nj/Eks4btAGRB/w4r5/AJD28gt9iW2mfXWmyaEw=;
 b=z1eKyo2tvShjjt1S862HBEK5yUb/It7LfzraQ7se6R5BwGd92vOPGeI4/MuvcrzCWHyUmJpdd97jGEAB80ChNNT7ZVTCKrbAaLnn8trPEU3DBm05bpYoFl3qP8g6UPFQTQ2345tDQ2BDR0X6Q4tUqhHntR7WEpm58eKxEmcZrdA=
Received: from CYZPR14CA0025.namprd14.prod.outlook.com (2603:10b6:930:a0::27)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Wed, 6 Sep
 2023 12:49:12 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::27) by CYZPR14CA0025.outlook.office365.com
 (2603:10b6:930:a0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:12 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:07 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/28] drm/amd/display: Don't lock phantom pipe on disabling
Date: Wed, 6 Sep 2023 20:28:07 +0800
Message-ID: <20230906124915.586250-3-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: acf80afd-76b4-4808-04c1-08dbaed7abaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nF2GVpKkRyh382jjDPMto6+KLlf3hv2mmxUsqOTZagDxtXn6BAWODWGlJ6+BMNHp+YXa4tuY5FgG3z3WZmphNYxqBGDWYsZaxSuAIcMwTa96NXc2vJ3iiaURm02nDhjZbR0lu6TPNyZHjibNWOdkU0dJplN3SgMa+mwbEYvTr7YpnSR6KQZ+pvw48thRy+cQCW8jxgug/iTPkf6SKDRKFBnXr+6bUUMuyRa/T780B6QYzWsxlpQVtnXQuAn9TImZjMZXqhibMNJS72DltVi9hjC439b3eR1pPdo7isjsYh0c4u6huT2QhhMOH1Y3vFT7Qnxe+IIFjnkAzOQG4+3x1shNWrufS3CBnlesQ33YagdJX2oQNd1jSqfRCytkkIPfg4jE3la6vEGLDvQM0aoXTVgUh+1JnL/b7CC+JPnmz+HeINPb2ZSN9WyUX04U3NjKH7QV+aiddbUC71mSAvBkpL7eN/e7TX1S7GPbKwI1QJweOmjEys7Ip9yn26asgnLeeDPZiCS5RDupE70INxyljzMexm5K86OZep0+zkrtxHScuj7j/iz9TVp1xnkgoLOUUxXeT6JdzBxNE5x9TThArrfBvxH+o6Qy6Z08AGYSNL7IYFPJJAIa42fd913T/6H8NYU7YhjRaAJnzwdEV8R85yDQ2KtK5bKSGsoxWclB3vM8DK8h+Vn2SDH8D/R+Dnb+JY158KNRscJLdm8AG9MK8Cf57SrlGxEZfzemdmF7Td1exWIBnJrsMAkD9kU/EGoZ/YWnDlEJfA5+1VYb1OFK0N67aVsjn4IvbR6b3fhlHjtXe/p4WUh53Kpu/Im3efsp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(36860700001)(44832011)(54906003)(6916009)(316002)(2616005)(81166007)(82740400003)(1076003)(86362001)(70586007)(70206006)(2906002)(41300700001)(8676002)(4326008)(8936002)(47076005)(5660300002)(426003)(336012)(40480700001)(478600001)(356005)(16526019)(26005)(7696005)(36756003)(40460700003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:12.3539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf80afd-76b4-4808-04c1-08dbaed7abaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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
 Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- When disabling a phantom pipe, we first enable the phantom
  OTG so the double buffer update can successfully take place
- However, want to avoid locking the phantom otherwise setting
  DPG_EN=1 for the phantom pipe is blocked (without this we could
  hit underflow due to phantom HUBP being blanked by default)

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 9834b75f1837..79befa17bb03 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -111,7 +111,8 @@ void dcn10_lock_all_pipes(struct dc *dc,
 		if (pipe_ctx->top_pipe ||
 		    !pipe_ctx->stream ||
 		    (!pipe_ctx->plane_state && !old_pipe_ctx->plane_state) ||
-		    !tg->funcs->is_tg_enabled(tg))
+		    !tg->funcs->is_tg_enabled(tg) ||
+			pipe_ctx->stream->mall_stream_config.type == SUBVP_PHANTOM)
 			continue;
 
 		if (lock)
-- 
2.42.0

