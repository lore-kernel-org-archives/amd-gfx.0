Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82447C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E858461445
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E858461445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D106EB25;
	Fri, 23 Apr 2021 02:40:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 186616EB25
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA9gvyijBGL8OTD29Z/m44K0zqFPf3Z15sAsu599Vjo718hdj590JA+g/W58R5vwSlbrMjYJ01Si/9QscYPowH0+FOSG4sy4cmTOWeVRy+9Jjz0m0kX4gJwavluNyIiG5yVEYTpWNqKM7ehj7YkfBIS0mEnq978BnhhVpATDvdYWbBrJHPC9Lx91XGOvJ2iTHqA2tOdTxpOhR+P0E6YUgqTqd8DGtrMGHyp2PaLy5NnpVxUwtRKnN3NK7uhUtBSIBKvy3bBfiw1t4pcwLv7ps+9jXqaI7BdCJUANPU6DnVHges7ePkBYF5iXwps2A6wmRYn0z7z7cYO2yZUQx5MwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgc1aNDieyRXkmj1h/uhIjf3SNc6xx04xk8ggHX4hI4=;
 b=j03YbmfZkswpu/yjlYhZe156VkjElvn6wytcueiblqTItmdV4sqXd5Tx7xcWkSE3Y7xCd+Otebum3W0D/Y8TyMn33dT2iRCNg1usnUFuJjiFfRRzF6m58TzFPfZZeFMwfoUnPY83aIErTCsjTpmUfnvJ6kw+mtiDSUp5JDpCx9ojH3bHbqG8lBEuRvLBfIDTGICfREHabVoms7xIJDkijXQqpG42HZkzMii38HPn5bTtNcyhgvw4gFq43PsfkpKoVhL/7hVK8Qmx3xd7r0zNAvTHc0D4+r/zZKvgWvFlMjaSi8ALNssQUXB1XU3+0NgfT+Kjyzl4trigD6WVXcyeFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgc1aNDieyRXkmj1h/uhIjf3SNc6xx04xk8ggHX4hI4=;
 b=PAglmyhnjUEvqskpEgc4BCXxRC/zhUkgUYp3SC6SXSYJhMuYDhQLAs2k6Q3do92aJYC69niaqioOCseVE83kq4swaRu5DfK3P4XPt/5uI9TsMB1WviqcZ8nDtsRQbsDZVRzEweWJ+98Cgm0YB6sT4CFM6jvyqbxmR1wDwY4begQ=
Received: from CO2PR04CA0142.namprd04.prod.outlook.com (2603:10b6:104::20) by
 DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21; Fri, 23 Apr 2021 02:40:05 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::3d) by CO2PR04CA0142.outlook.office365.com
 (2603:10b6:104::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Fri, 23 Apr 2021 02:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:40:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:03 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:40:01 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amd/display: skip program clock when allow seamless
 boot
Date: Fri, 23 Apr 2021 10:37:02 +0800
Message-ID: <20210423023714.22044-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a589164-5530-45e9-fe23-08d906011a1d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2795:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2795BA4666E955DEFF7E8C2CFC459@DM6PR12MB2795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1A+qA1qw9zU4HLLBUKAAxnQNGqyblqpTgAKDZ2gjkbUhgdnbia+beFlTAuPFTUP2iK+G/laaspk9YMjsvxgy8AlVOgYTg06BDGUfkApzsecpudKkI/yiJopdvb/qqOhHfHUkVockHwSDmxdtfFcY0wrLsOU3ZT2hp21+ktOl6OFEL1LQZ8dXrGyI21HdAYeODbeEDqDCczLJFTWk+/ZdvrLb53LNcY02RCfwHN+bUGMKT3TVhfUOW1pjPYbgXGw3DIPaAza92xRX1HSMfBhR3fo48wMmYBx2jCSJnHS3/YR8+vz8AIavz5IW+5lXuF85AG8YUuMeV9buuBCzYT/586B1txTNJUBkMaLJWRPbjx19fzWWUtl1hI4/lG3JdG6vLvlxRb8W3cG1+sMB1Nf1ETvhNBFYkB2g5z1aFBBCuwRAUrlp2KUKI0qoZn7NzMHQMoj1sIJU77GH8v7XiLLuk8OzL00/KUyS76g5p7kDN6p2ebjKNr7rx0Tp03cdM2ucYxI4lE0KfDXptv3yjzncsrOgHUJ/MKB9BiMbzZCvc+mMCDusEeR6Sl+Sit650Q3pbZaboIMVjEGVswHo0ekdhu+DVHWT/1gJZUVMTEc15AqYEEGP1pPYQAY7nMdLbmmaIuWDm8BvcQeXM6UYSY/rCtE8MCh21OIBksSfbaeVzlBxh6aGNSbNthTowG8RX7bF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(36840700001)(46966006)(81166007)(356005)(70206006)(36756003)(26005)(336012)(316002)(186003)(7696005)(4326008)(82740400003)(36860700001)(83380400001)(86362001)(82310400003)(47076005)(1076003)(2906002)(426003)(54906003)(8936002)(478600001)(70586007)(6916009)(2616005)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:40:05.0873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a589164-5530-45e9-fe23-08d906011a1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
Driver program dpp clock calculate by pipe split config but hw config is single pipe.

[How]
Skip programming clock when allow seamless boot.
After porgramming pipe config, seamless boot flag will be clear.

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f4374d83662a..931fbb4d6169 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1206,14 +1206,25 @@ bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
 {
 	const struct dc *dc = link->dc;
 	bool ret;
+	bool can_apply_seamless_boot = false;
+	int i;
+
+	for (i = 0; i < dc->current_state->stream_count; i++) {
+		if (dc->current_state->streams[i]->apply_seamless_boot_optimization) {
+			can_apply_seamless_boot = true;
+			break;
+		}
+	}
 
 	/* get out of low power state */
-	clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
+	if (!can_apply_seamless_boot && reason != DETECT_REASON_BOOT)
+		clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
 
 	ret = dc_link_detect_helper(link, reason);
 
 	/* Go back to power optimized state */
-	clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
+	if (!can_apply_seamless_boot && reason != DETECT_REASON_BOOT)
+		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
 
 	return ret;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
