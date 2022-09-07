Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43FFC38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FA8610E241;
	Wed,  7 Sep 2022 18:12:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17ED10E241
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejYuww1DcP2B2MfidKDHYzL/e8W53ZDwPYnu4QuChgPhK64Q0LXWz0vMtK1l2frmINWqlZvf1zq28nERZlKXNr0UbDtQB/6GTqKtbePSVC1y1y/0WoNvWsyWvgkb+hbm0PmXGSjJjV6BgEiwMqQAu8rvlk/pHeBtB57jQISknE79mEuis8WOHBNdTD6ARNxpRKe7k5RXE9AFWWgwGWANQCl62IZZMZ+11Kudf3yLS9wuh51x2xsczmtUknMQYNYSHlCKG5NuLmfgnlMcI/QApdAgByjoki1NtGioyO7L0S1xUxh6O66fkFWt32v5Sue20spFKjZvb1aWD7P7nj1MVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPbSGRevuvcxjmYbHw/Tg6R/Rh9u64+cukn6XQ53vqs=;
 b=OBGbTfFmRNkDRofUd3Vc50BGqpBvRvwtW/ssE45McovZa+icNTM/jzRXZ/gOA7Nxx0KumZIo4Ztjaeppy/iuHoHLpdoyL+BTLj0PYt/V5TYqeM1dFIDGYgiin8wsY7Fwm8xqIcIEmmKeA7RMJ4eQRitb3kkaRxNSStauDz5rPop+GfCIqwY5GNrF8M2y70PLVZ8iH4MHqCTESUEvEuyIAbGgdRYnyb/spI6vzHGLoGvq3m6ASX9E96bdQNdZ9wpRGERPLSqiOi5t4gKTShqsuiqVKnAE6bPFmYbdIsva/EU7CeU4qB2drQqC3j7NgH/oqsKMLDZ46JDZ+wIShm5/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPbSGRevuvcxjmYbHw/Tg6R/Rh9u64+cukn6XQ53vqs=;
 b=MMbYn0f1u1IoGl+6y4pxiUNZJ+M0UsiH6TTZYH+wXHsSpEvh5OIpdPhTqCXAsNwvwnRQIT+rAjVlUuQ88BRnSKzil1z/hJF/wbtfiLHfgjPuT1/5Z4YzX1LjmiU2bOPsGUycVCYh86YlmyN77W6L0Px4lwCrP+W0UQlgY6ip1MQ=
Received: from DS7PR05CA0002.namprd05.prod.outlook.com (2603:10b6:5:3b9::7) by
 MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 18:12:17 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::2f) by DS7PR05CA0002.outlook.office365.com
 (2603:10b6:5:3b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:17 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:16 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/21] drm/amd/display: Assign link type before check dsc
 workaround.
Date: Wed, 7 Sep 2022 14:11:41 -0400
Message-ID: <20220907181200.54726-2-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e143c4-d855-4f99-7392-08da90fc7fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWZ3rwdkkA84nX4Jk+J4cEke8TJZtIOBkxfW3oNGq8iW18tyzyVU4MjOng4Emzz1tLeXA5X0aG7lb+hXpU2cWBPPCOHML3hg+gGVXOAWRSEFb1NixSM2yAwWCDczTve/rAVtzhHlJ6kH0hKxROaAUqeuR4ogKyQz9KU+n+Gm8S6H9ygq/xJv8jE43QIsuFRvU2MOt+TPeGKFVyUui1HwQ+1oB7nOEujmw5+vEUsYzGM4vq8HogHWt3C6MDyTUtHl+qgMiDob8aLBACAFc/nvyKjr6Ui3W2OeLsP93n6b/zW3hqjn/U422FelvCl/P6a+Gtj9OTBZGg7cuQ1DY2XDqFVmOJ26LSgYFA8kTcyaqQhOcxneXwpbbAEcKXQvzmCVf5cx5QQHgaYAE+IzMhTzZHJCAHK1jqzr8qTErYbngOW+SQA2DiRtOHYcEE8SJf1NObDpO8Hhe47UYqLBOlwmHgoOlWl8UhOEVyPXqEy82KrbtndrXwk00DuMKIXGzNW7LfrS625aUKa08k0rbK/vpoUAzfpa5+3SJCraV1oCSZ7z6rFndFYgopD8P2Ji/GZFGTC8ibubF418f70woRkD+QvfF/8PPRFwBo2ZBp3FUnBfbwWyh7xC27g5U3FPpBnOz4ItRAsg40Q+y6cDJac8bYhY8fFpcu5uc1RW0OHo/4tZlAkPfKXPvWwWZ+OCozyeBXBBUbl8nVoBw/ccI2b0xm4elGo16mFpGsLlSLvbOax4mEnYnvsZElkyGY+d/t08/rRUtcynb4x/soeQERd3mRlHkd4x27t7cwu2toj014celjM7dm0Tedd4bg2/oesO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(40470700004)(46966006)(8676002)(86362001)(36860700001)(356005)(81166007)(40460700003)(316002)(82740400003)(54906003)(6916009)(2906002)(5660300002)(8936002)(82310400005)(44832011)(70206006)(70586007)(186003)(83380400001)(47076005)(336012)(16526019)(4326008)(40480700001)(2616005)(478600001)(426003)(1076003)(26005)(6666004)(41300700001)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:17.5672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e143c4-d855-4f99-7392-08da90fc7fcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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
 qingqing.zhuo@amd.com, "Xu, Jinze" <JinZe.Xu@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Xu, Jinze" <JinZe.Xu@amd.com>

[Why]
link type is not assigned before check dpia_mst_dsc_always_on conditions.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: JinZe.Xu <JinZe.Xu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index db45a6fdffca..d860d60a4c20 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -832,8 +832,9 @@ static bool discover_dp_mst_topology(struct dc_link *link, enum dc_detect_reason
 	LINK_INFO("link=%d, mst branch is now Connected\n",
 		  link->link_index);
 
-	apply_dpia_mst_dsc_always_on_wa(link);
 	link->type = dc_connection_mst_branch;
+	apply_dpia_mst_dsc_always_on_wa(link);
+
 	dm_helpers_dp_update_branch_info(link->ctx, link);
 	if (dm_helpers_dp_mst_start_top_mgr(link->ctx,
 			link, (reason == DETECT_REASON_BOOT || reason == DETECT_REASON_RESUMEFROMS3S4))) {
-- 
2.34.1

