Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847C5C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AAA020801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gvw4rP3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AAA020801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E50A86E463;
	Mon,  8 Jun 2020 04:59:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF67B6E471
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYtfkRKVBtQQAxd80Z+pBKbCZsxLqTgTSosXbRJ8ObDbEfQ+f/ZVEV/X8dw2fPsHWHB3JI4277HjA0vpjfX3BsZbC0Q5lyDFgVgCtpH1djUUn4MrEaalXEGULi7tgeBuRBev8rcxpTpnaFEXQw5lrUHZL3BGta+HyhToVSim6vhQwANae62jgpDbMCZCcNmxTscZpQOKzyrUWklnbn2v9v7j0zmP8fOGZ+SRGGkBvul8CXJL/hFqaQsMZAuvPy90FJF6iyL3okMYYfzWcznp1oHcSDlyhW75N0+QoHClz4wZ0tofIdOE+E0JrPqL4aR185at6Hbtylz2uR64zENwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5M2qoaUiUp6sHB/Xw6HR17atZsBRkbowxtHvbK0J7k=;
 b=EianJ94QwHYq5Wa3y3ysFluVpU6EmTBxWD+1EIcUuMn7OOG7PJGr+SGcQv2LblPhBFpVefowlCFueXKv6KbuJXSI/eWuJbPRwzFACza253TAzGR7FECWqRzpl3aMYrKJTA8V8b+wLVVbYDO3WtH4R9Ucl17QZomH3HHTaayRkaE6ZmNAcZnoTtm8EqQE1/oHkVLUqH0BlZCL2/QBz7gUzlKlW9ZPTpOcpN6BrKPSzq8qWCs+oPxIF867qSe0P5QFesH5dTcPGhnlEzSUfUa7wkc5vSwkLIJT5hOatnvK9MI1AuLILitGo9N9w0wO40kDGTV8TXbHK2GQ2fpDZGURmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5M2qoaUiUp6sHB/Xw6HR17atZsBRkbowxtHvbK0J7k=;
 b=gvw4rP3kEH/4YYX2JaSL+gyLqi0eU7o0jjg/rJW2mWKQqMNlXxPkmVCZ6L2RL7EumbyLTumZUO5F4gmwUttjDHYH5trLDjd0/7IfhMmG5VOGv9dL3IZKo+UYFa2FI407NA36sr0yHLExFkyQBpYAYsJCC36N1hYPsBZ0vPRqkLc=
Received: from CO1PR15CA0103.namprd15.prod.outlook.com (2603:10b6:101:21::23)
 by DM6PR12MB3530.namprd12.prod.outlook.com (2603:10b6:5:18a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 04:59:33 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::e8) by CO1PR15CA0103.outlook.office365.com
 (2603:10b6:101:21::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:32 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:31 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:30 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/28] drm/amd/display: Move call to disable DPG
Date: Mon, 8 Jun 2020 00:59:03 -0400
Message-ID: <20200608045926.17197-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(83380400001)(186003)(86362001)(5660300002)(4326008)(6916009)(426003)(47076004)(82740400003)(336012)(81166007)(26005)(356005)(36756003)(6666004)(1076003)(8676002)(54906003)(70206006)(2906002)(44832011)(2616005)(316002)(8936002)(82310400002)(70586007)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f1ce6c7-cdcc-4fee-7318-08d80b68bbe9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3530:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35307087D0B5A89E66F03257FB850@DM6PR12MB3530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETNfRzqNtUTbtfrHLbEHuYc/R/VXuzlXUVMykW1s3Izm5PAjb+flyrwSloPENYjqliYSO7WkKa3dqKYp2uiW8BYMvCbi3bw9TI+FQ7Lu7Ft29EJOHMZ/SMbBjDluJcyCwlKsfqLABRJUYb7EgYgPCbSlDRiMecUegPzDgigy5134/kjhIyxYb9hIjJxkjDWHpsJfBYVQnwtlLeXs2HU3YbqUvR+Ei2rwATFxHAUWUZZ357qwhXnk0Bdb2Omg0qUKXWLhNpNouDanbsklVBUXH8qtstRbwqlebNa2vddenOACgwzZrLsX9l/vEw2QscMczPRWkSImE7jawyu4iw0OEd7hRNMgB0lg50j6t1T78enaTUgWfNY5xORH6VKgI5fcmUqAjJdHoPCeIuI40s2Nxw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:32.8469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1ce6c7-cdcc-4fee-7318-08d80b68bbe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3530
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wesley Chalmers <wchalmer@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <wchalmer@amd.com>

[WHY]
Disabling DPG should happen after setting watermarks and clocks

Signed-off-by: Wesley Chalmers <wchalmer@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5b7466a243b2..49dd310ed588 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1248,7 +1248,6 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	int i, k, l;
 	struct dc_stream_state *dc_streams[MAX_STREAMS] = {0};
 
-	disable_dangling_plane(dc, context);
 
 	for (i = 0; i < context->stream_count; i++)
 		dc_streams[i] =  context->streams[i];
@@ -1264,6 +1263,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	if (dc->optimize_seamless_boot_streams == 0)
 		dc->hwss.prepare_bandwidth(dc, context);
 
+	disable_dangling_plane(dc, context);
 	/* re-program planes for existing stream, in case we need to
 	 * free up plane resource for later use
 	 */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
