Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB9AC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 23:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A9710E9D6;
	Wed, 21 Sep 2022 23:18:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D3F510E980
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 23:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5uOo+jJLeqg25s+FAlG2yJ10WgiXTzm8Ssk6/QkJaVLdj+31g9sgC0SRSn83zjfD/4GLdaEPStjZN7VafeiHhriNURfnTjsfFhLdxA6/bwHT7eXEVKspo44v2V78TG4R7rDV17tnkQtBAov3n9EgGJ6+XtTuZri1fPM2cVcAKSMZCRH5dwYsL2qCKUFzWRmQ8uvffDHk+DJpUeXvrivO9WBVe4xn3yz3iBeZY4aT9vNjGViZezhi4+3RXoyh21zR4eN8B21F8LEHK8hYYCdDmnCVUICa3c2nkXG8amYeIt3rAvbYqVwZzt8+2PDHPx7msb7mBw1Y3CV3lA1K27mGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln97hpwJe1UL4kTpzojJ92svvrwtJlvGcskIbbQktw0=;
 b=iemekeXZgPIUcplYXCokjdaqSocoSis8q0G+IimRR7EKMYm7ZlclEt+FuvK0GnL4qU/96eFZ2JDHog/3TFnUH/Ai3VnEQIoKGlUGMFsOKCiKznH0AmbNnT0Kv9rV5uEd7Q1aL0SP+MhylubYYbfAgUEwPuwtSrRovQYoLkerNSjRqduR/iJUsTTgHDf5X/GUmDRRUSaHnAfMYWiJe9Q1EVAJTUG5c8sSPJcetUdFTd8ZaMgqmkVOrX7ARmyHNEos/iDwaQnyr/dU7mrCxyWz1d5rGZlKve1YcOE56T+jRkJ0Q+th9BWEwLnhV7D4PC+ESLsyqF4xIJ8SOP6Xo3QJKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln97hpwJe1UL4kTpzojJ92svvrwtJlvGcskIbbQktw0=;
 b=ZjtZ5ySV2EOtdzUfdeU13pO1SVLdH0/u9awnUBWCyQaSFQ2BbKV00ad34z8cOxVTFtbIm78e/NjJd7x4hcviBlJyZaOrn+aG+X1ZADvaRABx7NClkqMY+E8Sv+aGZfJFoH5fEjrbWJK6EZDKNRHSfzi0UlvL0rNg/ne8Zb40HEI=
Received: from MW4PR04CA0308.namprd04.prod.outlook.com (2603:10b6:303:82::13)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.16; Wed, 21 Sep 2022 23:17:47 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::a8) by MW4PR04CA0308.outlook.office365.com
 (2603:10b6:303:82::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18 via Frontend
 Transport; Wed, 21 Sep 2022 23:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 23:17:47 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 18:17:44 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/31] drm/amd/display: skip phantom pipes when checking for
 pending flip
Date: Wed, 21 Sep 2022 19:16:53 -0400
Message-ID: <20220921231714.303727-11-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921231714.303727-1-jdhillon@amd.com>
References: <20220921231714.303727-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: f0074c07-8c32-4e4e-570f-08da9c277f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2P2hORP3ubFdnwNa0YP61mYnvc7teHqi7lmbP/qBcsCSvoZ4bkeh6T6JFMQ/iyLCWEyCG57g/twSodP3bZx12mIv13BV7tIqB95rNiVT0hX2F2Al/Ha0qjGCRQli7IMBuzucRTwklcpBuZR4aWDerVrOvEpHch6Ehst0g5LRm2OxMnGsRmoiNWPViYJNe2E1Efs+xOF1zbPHIZDzkDnaAmxy+tJCku7rWNcUsZ5O+ZNEmHa6o2TwO40z5CqNZrJgNzPX5iOX4adiAQRKuAH0vdLPdJf6HDV+bI2reHzlvSnqt7UvtzHvsqQRKo9y43gWWzpXZ7WcAUb42VvOsHWFKVfEJ+1SDRVjOhBnUnW+HX4QpVP+O6eU1yQic6Y4FJQX32P5uFttXNGXmuZNPpfbAGWeK++lUf+vpwWqwBH8ZXTszr+3o8LvEHpjojCMItTKHYGMwX3hIu3NNVp7I+Z2ntawDtvXC2F1+B/h1/qx5aL2gB6br70aDEqkK8IXgKLHKBfdfC7tOq59UYNTu0CpTTpcv8WyAXGiRtxeDmab+P9HElabFtItnJpLmgrQRyWINioizNFezoeAucA7BJD7vZ4ZE695AbJ1+dbYrQS4vxY3KsRkqp8SaRep1XrLQbJy4OPlNNQCcQxBvXn1k7dLtEsB/L9h9v9cGyMxt8JkUNi5sIXTK6HwA+7tTGdLAmFgKk21evlPybBLRk+aqBQoe+2NPZy5zYuEPzeOKoi3kdZTHHLSdKCX0DdJAsOzol4yYLTq+Wdw8ylDFg9NGy9ToGYTZPw0fL1vGBMHWRKtCBQODMIMvLmqHiGo9YqvP31e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(81166007)(36860700001)(82740400003)(8936002)(356005)(2616005)(1076003)(83380400001)(70206006)(336012)(186003)(16526019)(426003)(47076005)(478600001)(2906002)(26005)(41300700001)(54906003)(6916009)(4744005)(316002)(40460700003)(5660300002)(70586007)(8676002)(6666004)(40480700001)(4326008)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 23:17:47.3447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0074c07-8c32-4e4e-570f-08da9c277f09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Phantom pipes are not programmed fully to hardware and hence we should
not expect a flip completion.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 351888fe9b72..b5ad0bf4135a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1201,7 +1201,7 @@ static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 		int count = 0;
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (!pipe->plane_state)
+		if (!pipe->plane_state || pipe->stream->mall_stream_config.type == SUBVP_PHANTOM)
 			continue;
 
 		/* Timeout 100 ms */
-- 
2.25.1

