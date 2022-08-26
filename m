Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D527ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1AAF10EB65;
	Sat, 27 Aug 2022 02:51:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D143910EB65
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3hdlm6yrfVAqYLUO7XnkEFlWuiYMkClorCvW6dNNlF5UZGjUGClmaPpq/+mLns19qcLc3/1CmLVjetm8WgdAU+zyGi4SU2+S0v27tnXhBy8kr4WsEqXrCut7VIMde8OU1zX7aNosdFwHZ+ZB6VGLjHk0wK9LxPkEHHk0tq//IATCdh2+xX7fnqWv1XNVX/5qJsXaQf45lXewALk2J9E58V3pptTajb4hyH2HxxGWkkhj4oWV2+1iLgajCUgpZHzlPoLabYvDN32iJRt5Fx+MvtwYPu7JdsOZrOcBP+E3D7zEtgerLwM3bqpLyRBqj3ppVm/yFlw4y8G8fDzFnTmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvzVkV9H9HDTPBuikJwxPcAZ7VfJJ1bS1MLO6WEUrqs=;
 b=hvvytynrLMNL7f+OCDgkQKRy+aoru5p8OYOzwN1nF4XUePjFkY8bQgoPog7DufFWiSdAblIsLxdVoeYJdPECmi93JYY74fSsOgk0FG8EF0sdJoP6dMo+f5QL5bYsXzGUXhlmGy//gUvIQk22egX1mrdT1xnZe58z+9NqVC9Id2l4GzI4JmSGmZPOdGSJdxUf4neSVKBePBtE+Sl4SCA0ciF3S4rZlGq+KvFgJWsAxr5cQRBQ+yGSk4inmtM0jtSMPhqo8q+/4AskPrIhmdkAInwCB+lJuWxUKN3xNPzf8arw+cBaT6ICYKJSbKcY7hByoqBlhPLeUwRDAY9AHoyGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvzVkV9H9HDTPBuikJwxPcAZ7VfJJ1bS1MLO6WEUrqs=;
 b=krEH7ASCpcPkju01lhkDgxDMbRZ8kfMFSo6dVZIqnYXWJvlJLDe0vM9Un9b7X7ZBJdugbul2d82YlJAc2L9We2mv6CIS1IUWrgiULUqZhyIyW6tDef2QMaoKxxxEId6rlF6Fe4lMbjOP2zADUCzpHDmaTi/F7wxzma4Wm2in6nw=
Received: from DM6PR08CA0064.namprd08.prod.outlook.com (2603:10b6:5:1e0::38)
 by MN2PR12MB3662.namprd12.prod.outlook.com (2603:10b6:208:164::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:51:09 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::9b) by DM6PR08CA0064.outlook.office365.com
 (2603:10b6:5:1e0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:51:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:08 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:51:04
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/33] drm/amd/display: Cursor lag with PSR1 eDP
Date: Sat, 27 Aug 2022 06:50:32 +0800
Message-ID: <20220826225053.1435588-13-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af4d0eb4-bbc0-45ed-8e89-08da87d6fe8f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3662:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlDk1PUGeqVqyHVqHoA4ma+ge0YIAqP/U+Gz0QHp9F7vdmPC/Slhxwcdg1+l+foTMnHy3h7QLAQuVfED3dT3A2kII7Yu5ANnvP/kwEObMEUjQJpmp7sAWMQvb9+NNc0Pl732ujBtvM/zZZu5xN9BLKVBytxOozv5gNQ8RQIh6nW/x0P0nXjAmLB9/uwg7Ea/rBQ8tvz6SPNx8vJOVASRv97MQlFXjW8FsVhkjFusv9TA9wc4N3u6Cokj31ELuPMBcMfXsI4EgHD5lYfvMTyTajGXLzPr5Ue0bkfk96dIB27Ezp2gnSUoEsjpq7s+Jn6kJbahHYm95lDoRb6s1WwsJucgcV9Sya9F9LvCYqSugfN+jP6r+luGX1wnWD+kis9D97bEmzPOuEoqZr+ZhN/lXTatZ6mrYCrnc4fWDkzovXSBLHl3nHdb8P43Zp9irvgNS/im9TJ4cWfk+JUrt7fw70DbzjzPvy6madycH70JT2ytl5EfC1sIzn78L9mszvKl4GllBE9O6IfuFoeJ+7NBk8bwn5MD4Sb8juqwxh5urkA85XgibpY4Z2pme8IRnmA68HCChWfP6t76aw2ouA12rk6qvHoPtIj3u+w9OEZKawGDIdiTdrJzN0/Ozu2v9gRIaKKyRHEnjdUp+W+n2aDm/FCfgFfKjO95hbP9/joS946bF55V3cJ0VTKI4yoeSNCX/CqRc6awC8VFc1ETP4ImvsFLQMZtlqiQc6jwB47KQi93Fe69Mrs7soMGJbBE4RZl8/a6UaIAnbPNB4ITbeI8F6QPfbwxJS/Zr3gK2qtoiStVXROIbUeqJakgnzrsjkmeagSZ/WHp9rRkAUiyWAID5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(40470700004)(46966006)(47076005)(426003)(82740400003)(1076003)(336012)(186003)(2906002)(81166007)(356005)(2616005)(70586007)(70206006)(36756003)(40480700001)(5660300002)(8936002)(4326008)(8676002)(7696005)(6666004)(54906003)(6916009)(41300700001)(478600001)(82310400005)(86362001)(26005)(316002)(40460700003)(83380400001)(36860700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:51:08.8199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af4d0eb4-bbc0-45ed-8e89-08da87d6fe8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3662
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
 roman.li@amd.com, Gabe Teeger <gabe.teeger@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Robin Chen <robin.chen@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
On edp with psr1, we do not provide updates
of the cursor position regularly to firmware
like with PSR2. To send updates regularly,
the flag enable_sw_cntl_psr has to equal 1,
but cursor update should be provided
regularly to FW regardless of that flag.

[How]
Ensure that we always send cursor updates to
firmware when PSR version equals 1.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 37246e965457..1eb3957f52a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3343,11 +3343,7 @@ static bool dcn10_dmub_should_update_cursor_data(
 	if (dcn10_can_pipe_disable_cursor(pipe_ctx))
 		return false;
 
-	if (pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
-		return true;
-
-	if (pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_1 &&
-	    debug->enable_sw_cntl_psr)
+	if (pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1 || pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
 		return true;
 
 	return false;
-- 
2.25.1

