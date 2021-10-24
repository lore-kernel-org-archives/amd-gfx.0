Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AE0C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA067600D4
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA067600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F79589F8B;
	Sun, 24 Oct 2021 13:32:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6244A89F8B
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fv5lAHyfax+N1bf+x9KQWvnGXiFrYixoUG/VaYgP6qrHKL2zOJ1TnB80lc7XcQDiZczKlC36yFZVCaVRX3qwwL0W4VKC/uuYnFYtnniSlTTkXWWpI2P1Tr9fIWWF6pJtPRDM5GNiWgIeaHvn3cSXghH6ZfuLXRUOaZ5TkLBV6yiPQvCtye/WXjm5PWmpeW45sNrAY0eL+ufZbQAL94PVDTp32qIDDeq+pNgVTwwdj8Fk5WCzy9fvb151cA/kQFFBYrmVNnPb1ObXUwELR6fkO/sUPhMibJ6Ws8E0VxFQfplAdOZErAdVWRa6QK5j9APr6K8XrM9+kUiBmNfsGfnjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEzZd6Rt4Ki6XZhoKmyRQxZgdMGjCywb9smBHLrAxyw=;
 b=fCOe/DIBQN6dX0QhLoRYm1IKoZjQd507tPfcOv6/ZbQoQ//i4KvhTVfE7EKVTYceWJ3zCw0AfNLxHrTmKtWe9EooIA+SKAJdUyi0o5zNJ3grkKBccxAVExVyktw0ozRZOXu6Md7kFQMUV4fNK+xaH8WzUEXmTGZ0u3XfKjVNN5aUWXUdShC8+h1gzxinsITcLwV83yD+FPboVfzmhU1cb7j0i2cbfWEaag0ZybXJONm8aRHbSoxefwwpbHJ+S1tptIzinSCCOOOLJCvKxRgPvuWjVaLcI3tgz6s3cWXtzSaWq1iF9k8rLPC1H32xbwOSJtQ95QW7LgoMlh1Sc+IU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEzZd6Rt4Ki6XZhoKmyRQxZgdMGjCywb9smBHLrAxyw=;
 b=RYFORfEkxvrO7FTQgdyCLlH9OdjAoBK+dfqc/1+Dq5iStzWo/fUQIlZuSFgJafP3/TpiQgi61fsV2a6KeceTb1U/OUZat6kusIKwHtYGQJF3IQwCPIOWWY6++N2WBjEKZz0pSmjOlxYmYCSWnUpeMr4flPf3QnBqHDSBF15Glog=
Received: from MW2PR2101CA0003.namprd21.prod.outlook.com (2603:10b6:302:1::16)
 by DM6PR12MB3449.namprd12.prod.outlook.com (2603:10b6:5:3b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:10 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::e9) by MW2PR2101CA0003.outlook.office365.com
 (2603:10b6:302:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.1 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:10 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:08 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Lewis Huang <Lewis.Huang@amd.com>, Anthony Koo
 <Anthony.Koo@amd.com>
Subject: [PATCH 01/33] drm/amd/display: Align bw context with hw config when
 system resume
Date: Sun, 24 Oct 2021 09:31:09 -0400
Message-ID: <20211024133141.239861-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fa2bfa8-9582-41eb-2db5-08d996f2ae93
X-MS-TrafficTypeDiagnostic: DM6PR12MB3449:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34495153E98ADF52662535C698829@DM6PR12MB3449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNOVRZi+9YVdRDHHiy/1RD5rQX2+q0AP+sHGldZ/kt2Yza/oUKcCVs2DvdPIRnBsXZdQmLf1MKN5h5pIQ43h7wvgzMQuTUBr8U5uYwitmS1jFRCeEGz9f2NPGkKVoWoGJZf7HNNEMoLof3vc8eqQw5A2WefWErSC0lsTxszsDzfBKURXGeMwJt9wSVdHNTON7jhSefal/dv6Uo+5pc1rwVgMeUv5ffx1PIC0LfDts0XvF4sjuyT5MwL71CzoVVT51QNb8uSpAP3Pk9EHGgrtlKRPVppn/XV2OB6uJHkWp/Eext1mhIBJWTeLJ7b+lkmllWb1qmRKfgz7bC3HFrBh4khnJgx+ajcE4RcANkaMmtzdu/xf8A90lZhMvgnUzuHQbVNvItJO/yDooO3m0LW3ynDtpNpxUnTHmCUXYV+/xpovmi3D/YAskM8NmS1SHY4+1kJQTfDxYWt/y9UZLNoNR9dk15T0Sb3mo4YZ/9vwARwZNnZZnXy8+OO+62Zx2NX4c4Q/QtMEkh8cLG4LZcHbtrHjRYW5U1Pni3DQ7yqTbILzCcRDkDm8G9rH8OyyRjNsXszEndFawAuj7sg4OLnGBU0Sg6+jhBPSmEuKE9/dBO/BUBYnn0AQR+Lki5Oq5CtbAY3A9W9rY6GC733Es9x5Sq8U5lEdlTEkn8VXV9Grr231GDH/LO0HlxK2dIcyFvCsfjWfTYKNLhPgS9nGM7K/wxXMXkdufqv7ZRZbJk1ZFtE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(86362001)(426003)(81166007)(6916009)(70586007)(70206006)(186003)(336012)(2616005)(26005)(82310400003)(356005)(36756003)(16526019)(36860700001)(316002)(508600001)(8936002)(47076005)(8676002)(2906002)(54906003)(4326008)(1076003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:10.3259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa2bfa8-9582-41eb-2db5-08d996f2ae93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3449
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

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
When the vbios config and driver config are different, if we update
clock to lower before call program_timing and program_pixel_clk, garbage
appear.

[How]
Align bw context with hw config when system resume

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 44d27579d898..a25732d07222 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1378,6 +1378,12 @@ void dcn10_init_hw(struct dc *dc)
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
+	/* Align bw context with hw config when system resume. */
+	if (dc->clk_mgr->clks.dispclk_khz != 0 && dc->clk_mgr->clks.dppclk_khz != 0) {
+		dc->current_state->bw_ctx.bw.dcn.clk.dispclk_khz = dc->clk_mgr->clks.dispclk_khz;
+		dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz = dc->clk_mgr->clks.dppclk_khz;
+	}
+
 	// Initialize the dccg
 	if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->dccg_init)
 		dc->res_pool->dccg->funcs->dccg_init(res_pool->dccg);
-- 
2.25.1

