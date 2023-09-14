Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAB9EE0213
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D4710E21D;
	Thu, 14 Sep 2023 02:01:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5512C10E219
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPR2OTUP8/sVDtfPGFoiU7vcC8jc22n0JzjQd+43QitsEmjIEESH6wGJzS7hiLy2CqxQm2fPONX1scV900RSZNRU3/W+2jXQVIFIHLyW6+uAiLFrJRqh8lxIw17wOBfja17EdNqq5LvC9JQO39PA+cqX55YmwOwWirhJ4nSg7Kg4F3z+syNx/4k8tiOfiWKelYw4tMbX9TUPa7NWb1UUjHuS/RsV3hnjKoYM0beT1/jpg+EhkA8W4FB/xmaa+6INHVu+Nu6wfSHd5ee4RNG/7+g7AslXIpbJGciGGwMAZUkOG/+Z7N9YVFroSt9o7SMpaB8d6r6jPZgtOcg/WWJ11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bNqtWw213DM6fO4IOoERaJ7HIr2F2+8btUFqMtVVuU=;
 b=QmH0XN7RCOBs4DzijziyFEYRFnJhjVv3vc9jzE4zDVX/wRDKu9AaeW5TVb8m1GR2DALu3A4frRUbiCeYxSZqEHdkftzuSS7SG3yX58nW9vLFr7Pm5LjOXeKq34RUqb5o6bcdki2c1lLU2bXrggiSLb6+nfipR/xpguIsRkoeYD9kW++zmYqD7TKwbq5DMELb7IvB93t9IbuMry3m9WCDp4LhZxba7kq/HUpeoqDiYuoNWuwYo9DTmhrbgKVqEub03TeIPY3/8tBVYwq0ksFKVm67WXX8Kqaz7KoPpJtJVpq9VPrnhNjgr4HJUU08KajmzzSQYupCheWBIJcBcy/bDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bNqtWw213DM6fO4IOoERaJ7HIr2F2+8btUFqMtVVuU=;
 b=v7t6m0DJgnBIKVxxNMxe/DLvU1WWqiIcMWdkXV07FYRcQIb/iKEJbePQFBm2XxHjWw7jrQMkOl9WOKiw6RzecF6XmSjvUPrUeXH22/Ngus4EidR8IX52QOGe68bmvtyyI05Csp9otOdgkJu7GzEwhRuspFC5aXHt6N1HgdBRmJ0=
Received: from SN6PR05CA0024.namprd05.prod.outlook.com (2603:10b6:805:de::37)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 02:01:33 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::52) by SN6PR05CA0024.outlook.office365.com
 (2603:10b6:805:de::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:32 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:30 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/28] drm/amd/display: Add pointer check before function call
Date: Wed, 13 Sep 2023 20:00:01 -0600
Message-ID: <20230914020021.2890026-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|LV3PR12MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f08481-46e3-446a-a5b9-08dbb4c684e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFW8p8HqAMtYvHz+vn1zbQhTIpoeFs1M14G4jIwOCqpaKQifS4a3TAaQdsIJRrvS7bLEHN0uql+o3OXN6AWE32NMZsvO64Wb7KLK8JX2ZpXtNL3tSrmdeN2g2epqj6nHEcmo2GFXcm+fKDP6bcb+yR0GbsYWzv97fUHYC09e7OeSbLIfHFbF9cNoJnKL07Yo2ASQh40PEGAiickDenfjFcy2JEoOAhqJsdwrZqgb8TuPySr7rQLvp5gNyOQ70vW6h1jwpDmTYEIjYMwbfIu2lEwCIhj2poX2pMZfiQhT5ltbAtat6s+2Pyjji8C3Hw9ti6B7iwWf4lFubqGvpYCBESGd4budSexh4Qm6HB1+DAjh1NoIp59emCINpPXkFc/C7dTxAi+5gl+3mbgHHzsLz52E7KpFD8pBxQCMk350o8qACatGxwM7Gs4nvv5x7EAiLuNuuKBfUTcxv4+RShR3aPsFwpUS40nstlvupQ/hJ4A8j3zGubRCjJ4O2xV1xORChubshlMTpBVnCnGUyodDq7TuFu2Ka4gd+A0I8QzU7Bg6iq1efbVFGxtPX431L0aPiR91vSu7xwUSaCX2tVU616KBBLNVd3wcZZmuzgkswD2jBtYU1AkoUa1VYY4iF32lU8zPehWqNG+DzE6KQhgjADGCTYV+r/GTfmcGYWLP9uwdR7Txol10MBOZ7NUd7lLn6vtVmHj1dxMy+hEMn/BCfrISVVB8atYy3zFa8rsLE2Lvr8fEQttlI7GSIM4Cdw/lplABpAFiE+MaGiFXi65T0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(6666004)(1076003)(16526019)(2616005)(26005)(8676002)(8936002)(86362001)(41300700001)(4326008)(40460700003)(356005)(316002)(36756003)(70206006)(70586007)(5660300002)(81166007)(54906003)(6916009)(2906002)(82740400003)(478600001)(426003)(83380400001)(36860700001)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:32.8730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f08481-46e3-446a-a5b9-08dbb4c684e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Sung Joon Kim <sungkim@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[Why & How]
Call to immediate_disable_crtc was not checked before calling,
exposing a potential null pointer hang. Fix it.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 98d6a1f8af60..ca6ce13921a7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -128,7 +128,9 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 				if (stream_enc && stream_enc->funcs->disable_fifo)
 					pipe->stream_res.stream_enc->funcs->disable_fifo(stream_enc);
 
-				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
+				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->immediate_disable_crtc)
+					pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
+
 				reset_sync_context_for_pipe(dc, context, i);
 			} else {
 				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
-- 
2.40.1

