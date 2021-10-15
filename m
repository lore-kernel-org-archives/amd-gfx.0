Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6034CC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2360A61040
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2360A61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D2D6E9F9;
	Fri, 15 Oct 2021 18:39:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 924116E550
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P72QCeUV+2AekRQyEJXNo/hCuCbl+DAw9YCYcwKwwVOQrB0f7R/crrP1+Zo4j3hvItUp//yJ5xfqsAccrGjEg0cybo7O0mVHd4feiCvUpZMUa4qTS5yfQSUe5eMP1+HSatHtKaHKRtHUf1M9rLeSsiG/ed08BN8WMnQiCUnlRSqWdP0+qEehPd6P63hc6nNZp/EkFULTeVUhmsspPCzI1dJQLZDquYzo+6sqfOTtFdrWxiZqz04tkU7j1mwJl93VW31zfCW93pWUQQn2xLBTymUlzjdmyPDf9kXNqNiKb4Dp5ItASeBMfOYupXNqxC92WI8KuGVkZHpxgoZIOj0VJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEoRLpDkRuARcV4yj+ts/g+dok7GpvMkgocSAxXgKpw=;
 b=LC/A4QgfVO/mvwiyEfCG+ZAK1YgKTghuJQBvAcZGbYu0byNHmlYAN0KC1jIjVFXHJdP0vU109iazE+sEPSP9E3g2RJ1aG4BFWzPJLjYu2DoN7WRspHwSPxCC5xde6Wue0w1ReUmMKogRPv9n4SMOio1xqMo+RKe2o4UfWRzYXhhTCLFZSv+HjTG+/6Omtd8x1uIYZS1vR2KrajEOax/XZxo58uCMnVlQMf4cw9y+wCFm0js1IAeMgS7/Z4MVBhhGyMFBotGgYmOX928m4GFKVMmak+wF+5ZkkpCgMUm+SWCfxMUZEj1A74QT4myBVCJBccot+8tOCHfOUu3uCVk47Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEoRLpDkRuARcV4yj+ts/g+dok7GpvMkgocSAxXgKpw=;
 b=AqRch7KLEONu3IBpeY75mgnBUaKBj1IOnlnkhXbzgg07jvJO4S07RyRhljlIczkMEAu/742vk7zQ1BCtv+CdHP5IOXFWWeDza8/q5vAKDwAbmHyfN+ammFBOmy8RLwUOkdb6SuJhBF0c5VwRZ4eexxz1rrxeBMKaqoPqedtca7I=
Received: from MW4PR04CA0237.namprd04.prod.outlook.com (2603:10b6:303:87::32)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 18:39:19 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::4) by MW4PR04CA0237.outlook.office365.com
 (2603:10b6:303:87::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 18:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:39:18 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:39:14 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Aric Cyr <aric.cyr@amd.com>, Josip Pavic
 <Josip.Pavic@amd.com>
Subject: [PATCH 08/27] drm/amd/display: Validate plane rects before use
Date: Fri, 15 Oct 2021 14:38:26 -0400
Message-ID: <20211015183845.220831-9-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015183845.220831-1-agustin.gutierrez@amd.com>
References: <20211015183845.220831-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cfec9c2-cadf-43cf-6554-08d9900b18f6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4230:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4230E4A83D7013D2CE87BE22F5B99@CH2PR12MB4230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YiRk9p2hkC3dz+Z0STlqQ/OL+20+S1x3cW7pATp0LMgqQ+LRHGNtlcIJ/O1QSz/+L+cqlBteG5+wM84JSjhZajDSRPjTdYhTl7ASlUMbX1Md93+ZyFtsQ44v8/6TqAgvfx8qUtp17S2biHH7J611E7kyv+RwICurdtXcJ5g+cVNGBaXkfWCR+lV6l+PZi1igzgbJnTfnKwxW2FscMA/L/0dYgPQsy/EaeyBGwR7ViOO26ZJjABygTe5ou41TuHlvXLMDVOUyKytfGBS2ierTG7sNSt/6gCMU1HjpZxgfF16DV9mlNW5iwn8TYFQpPxEd6DbfAGJfrTMHcLBhZVyPB3kkUB4ykFtcVGaj5r1JVgMh/j6oEejfXFlyrr4G2cI1SAA8CC0ZUBHg7q8GpmDQKwn1hYZzqPxbGMwPm/hgSrBifetPW70CLbeQ94/KXjyOhxFaFeqpxU32cgHcYKpBiMoMAppczvzldr2Iu02BHyxhRxusU91TbRd9jrHotBPCQQj//G6XTDCFfwS3JahAzssjtuJTudtIXbN/2cZwdh/kcg4VLFtyKcN35xwfNpxLG0VWcP6GZk1yh0vbsThXxBuABKJviAd+vnEgaPr1eX5dt57wrXDEXXryWCnyQv3dRfaTKRUr9sgJI6Ik73eQAuHEfzN/8R8t4x7rzeyiqE6EU1jFmM3mg1rQFYAHor2z3BL+3Tv6UynjLsuHIyuQ1MXuXtvGMAVt+eSXFMIhBc8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(36756003)(81166007)(82310400003)(6916009)(508600001)(2616005)(15650500001)(47076005)(5660300002)(4326008)(336012)(83380400001)(186003)(8676002)(54906003)(70206006)(16526019)(44832011)(1076003)(6666004)(316002)(26005)(356005)(8936002)(86362001)(36860700001)(70586007)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:39:18.5854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfec9c2-cadf-43cf-6554-08d9900b18f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
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

From: Aric Cyr <aric.cyr@amd.com>

[Why]
Calculation of scaling ratio can result in a crash due to zero'd src or
dst plane rects.

[How]
Validate that src and dst rects are valid before using for scaling
calculations.

Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 561c10a92bb5..9e83fd54e2ca 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3009,6 +3009,11 @@ enum dc_status dc_validate_plane(struct dc *dc, const struct dc_plane_state *pla
 {
 	enum dc_status res = DC_OK;
 
+	/* check if surface has invalid dimensions */
+	if (plane_state->src_rect.width == 0 || plane_state->src_rect.height == 0 ||
+		plane_state->dst_rect.width == 0 || plane_state->dst_rect.height == 0)
+		return DC_FAIL_SURFACE_VALIDATE;
+
 	/* TODO For now validates pixel format only */
 	if (dc->res_pool->funcs->validate_plane)
 		return dc->res_pool->funcs->validate_plane(plane_state, &dc->caps);
-- 
2.25.1

