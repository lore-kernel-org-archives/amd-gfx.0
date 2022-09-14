Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39BEECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3501610E838;
	Wed, 14 Sep 2022 05:14:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A4E10E838
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7GxbDlT/9amE1ixkSHoCntYOR/Hl2t7Lc/adGxoJjU791XwJQ6bIlWakSNHWjBNoE5fIbP18Dq/aPGCmfsLhVpIWzEkV3ijMS6Kzyf5U6mILP2NBoBe/qxiMick+SijJJQju0O8RPeGzbRfoI78x0eFoeVnQ8P9F6X0naTNQ2tR/El/0kqxiC8aUMT82oaoJMnADfjaX2KRAEJnfEzTluCVvY50QooF3V/ZhB/DOc+ruZ5yD53QqyGpn2V++htan9uFoAeMl1FiWrIEwGXT7WTCT+W/f52Aw0gbnTT8eCSJGD1zhrvSTC6B7AUrB3xeWF4nNN5GyjKFiy6X/Qyckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPBBu7yceNxS/6oq8QiXYEGvTmTzFcYvX3DzZEUbDnw=;
 b=N1AcX682YfBv90MM5tBWTvjTgd2fApTgHQl74vTEfuQN+nwht7PdAbaD3dOYPcfKxKvfcxkYcBbp09EZk8pVUmU/2iYSJFToV8XYPKeg1OLbX/XLPKHyS+6KieIPRYkoUFVf/KHkjB092zOGd78l1mH9Os2ot8oVpZOPVvbwiDmLBTXWy3+t9zny99YG19iy85sS/TcLHXQHEREmfGL4c30LFy0mZgqHYJQS42mLgDp6HeF/mgSG7iaYkHHGFvRcCc6U0K6nC0fKILMr22zIH/LABr4apRYu/RxzpUrVUEVAZ2NZt7nTOpNkBOgpN8+Kwb88M+poSijRlVB3QmWPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPBBu7yceNxS/6oq8QiXYEGvTmTzFcYvX3DzZEUbDnw=;
 b=LtoK07QGMDx/OxHqo0gZoiyB9neigzipAu67Ki7UaLpYjwaAlrgSJI8JCgMpH6Fy4/jSLzs3Ar7WsR2Q8NTInlo3epar2naXfDiuvYPHujRQvqCGxmfzNRu5lSm4ji67bqu565oVdslw9E2AmOILN9mh5SY1+QF2S89vcEwU2p0=
Received: from DS7PR06CA0035.namprd06.prod.outlook.com (2603:10b6:8:54::9) by
 DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Wed, 14 Sep 2022 05:14:44 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::59) by DS7PR06CA0035.outlook.office365.com
 (2603:10b6:8:54::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:14:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:14:43 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:14:39 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 20/47] drm/amd/display: update gamut remap if plane has
 changed
Date: Wed, 14 Sep 2022 13:10:19 +0800
Message-ID: <20220914051046.1131186-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 53250078-dc7a-4b38-eab0-08da96100954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fYl5meo0l1rkTOeyv9a0PLBd7dehuil/ZBPRP8berXkglkkGuVr2d5s58+Vl+Hv8dmog/dpyDswMxR72K/iAwQ28Tmo1pZhAje4RP+gMnLmZZ/w5dExOCclDNlZgnOpr7INE1cGu55FoJgUA6P5+RC0oCgwdmKYKlcDDY1e9I2fmItadzFRkFWTLGrZjy8RpmsqvhmZkVGMxuugnuIfWDNR3a3lK5ftxGzLiq/7IugZPw7cOcqLdBABL+gXrhAJ1SPiQzXLOLQfci7HG0i5k5sVrbKIDPQIdgUnOzcKZFR6khWbgIo+U2sKazMxY7O2KbBGqgagrzM/V/x4k2Sw2xcPtZgAs3DUt5Piesejw1eYbwiT+dHCGyiw8opHIuqOOoK7IYNFhqWp0v3zcuXATx31/BJYxYaMqNXJFkmMSiDYSiuFjO6yzixw0lYGCZLV+e9W3+RX5zLV+/fPZhOB6j0quXuCtKVWxx4rOesKr3XFoDNIiCUY8QEvP1Wzu9DAkAXxdWFYYt8xjtNJ+7BXb8aMz7ncU26saz/7rtLruhLsXIOZef71vYPz54OEOvbmyJ/4NXVF6BOaCXzD7cKi2U+iF+uYeGZExkekV0rYzgPVy4e2faAJTFOa8MGMZGGzCraQbidFYcvknh2t/Gmd3O1rJtZIGrE8/lTrtzBtY/wNWKrlO/hGa7Ve8w8TMHebZGMzao+kt4gXiJgoSE5LCVCgMpu6GSVvhVSg+Z66ysUbzX+U9ohhC/Ph6Q2NMTxRFuxS2hVNESt2+AoC/MzcNUukP3skkeALpAAOn7ZKP1nWdmvZYCj99SIv5jaz6Vif
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(426003)(40480700001)(26005)(7696005)(6916009)(70206006)(86362001)(5660300002)(47076005)(1076003)(81166007)(70586007)(82740400003)(356005)(6666004)(36860700001)(40460700003)(82310400005)(316002)(36756003)(15650500001)(41300700001)(54906003)(2906002)(83380400001)(478600001)(186003)(8676002)(4326008)(8936002)(336012)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:14:44.5612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53250078-dc7a-4b38-eab0-08da96100954
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Hugo Hu <hugo.hu@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hugo Hu <hugo.hu@amd.com>

[Why]
The desktop plane and full-screen game plane may have different
gamut remap coefficients, if switching between desktop and
full-screen game without updating the gamut remap will cause
incorrect color.

[How]
Update gamut remap if planes change.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Hugo Hu <hugo.hu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index ab56f14d6247..e1d271fe9e64 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1573,6 +1573,7 @@ static void dcn20_update_dchubp_dpp(
 	/* Any updates are handled in dc interface, just need
 	 * to apply existing for plane enable / opp change */
 	if (pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed
+			|| pipe_ctx->update_flags.bits.plane_changed
 			|| pipe_ctx->stream->update_flags.bits.gamut_remap
 			|| pipe_ctx->stream->update_flags.bits.out_csc) {
 		/* dpp/cm gamut remap*/
-- 
2.37.3

