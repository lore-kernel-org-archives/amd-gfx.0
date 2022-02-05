Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B6CC433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 01:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C6B10E2D0;
	Sat,  5 Feb 2022 01:50:59 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1219D10E2D0
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 01:50:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fv4ekj8vaP3HBYDqRAvRMgRu9SxMZo/m+GIpSI2MSDMh1EFmI2BqoVkEFl9rWxMj2Dachwfm4QDXIMTkIgp0BgumpNNpR+zw2pyxe9dRpEswBf4xAViQTDdZ+o0ylAF12yXUZysMxOhnKLiMncl4wn0Af1YX1RD+ZX2vBbLvawAgCnN6xMnZl2Fclxg9KIQWE+tPJvlN/NOQD/vzRDq0vGmKQICJYkBR3yLfoo0t7dDpj4oLJMewMhIaDZyqo2QgVLgFTSS0mMTwb117nv9qTaJCp2ODvcUD6XXYOV5NXPZgC8YtZFnhIMADBTXyeOIzU0VC8NpWCSVBZt+Dn2yxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2nbQFIFQRf+DJgrXqTM9ByzJuvm7rKTVGIzVmD6J3k=;
 b=UGZ4s2MF9Nj88DzTfDfti+OH5sQozfjj9SPqLKckRyDPhTuloaoxB71C78YvNOlPRzMAccTNVAxfAAzXUqfPfDcP4hdRMtIURtUJT0Oztk/DLoM3Qd/8aJg12kMeSCfoeeu+BtN+0f+kWmPXiKJaQ/zSlMj6dXwlKO5SA3zTscLzNoSE/Ku0PE4UgiAvRj6Oc3Ljm39G1VBGNy02wJTdcmJizfx35T6tgwmTeK2Z+Xr10lm6KOc1+Xj5bCCJoLbLHLJltY6O3c+qmkGAl9a8u61uhEgmzE10ta3HBM91Ga06DXASeCyhvvdD8LHcMT1imMz5FKHoQIS9cVIAdk/GkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2nbQFIFQRf+DJgrXqTM9ByzJuvm7rKTVGIzVmD6J3k=;
 b=mRucMTiNV2yxhwLHrz5x+YqWCObjqbBB58jop1CnkyRMklyid+zcOkXrYBhkXl6f6Ll/TIBEBXDkLqil+TdRxY2W0FFBs63iCXuGdHQNn8VHsR0EMpNGm+ia59/3TBxjRpFwKXjGZMXbSpP47PGr+1LOcTVA6IrKrkOFd9U/NY0=
Received: from MWHPR11CA0023.namprd11.prod.outlook.com (2603:10b6:301:1::33)
 by DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 01:50:52 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::62) by MWHPR11CA0023.outlook.office365.com
 (2603:10b6:301:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Sat, 5 Feb 2022 01:50:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 01:50:50 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 19:50:47 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amd/display: limit unbounded requesting to 5k
Date: Fri, 4 Feb 2022 20:50:18 -0500
Message-ID: <20220205015029.143768-4-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205015029.143768-1-jdhillon@amd.com>
References: <20220205015029.143768-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 569ddcc5-3b7f-4540-4ddb-08d9e849f051
X-MS-TrafficTypeDiagnostic: DM6PR12MB5534:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB5534016A5BDB581A3C378AE6FB2A9@DM6PR12MB5534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJu/dpOLexJ48FTj7xk51Y2bWaATTB5XdcH4EnjDX7kQTRmbW2v1Rr3yjYe5SBIdOGPkjRU4COjrDvQIinHPsOc4VUTgUnPzOxpxYfpSw74HCWvInyorhx5+jfMcRxVUTEpI0rAypSe2BWuu6hPLwyp2it8hM/xqg8a1xyQ8Ptiel5dO0vbcSX70lkh7jWWBIfgAKUjrCBHP19Xc+kUGZc99STsT/WoXG+HA+OnXEOIRfkBup+ti9dNr79IGO1PMjXfMaH+MBh/7jiNLaTB+ioWOoVq+FbvtO4fx2nu8UYvwIeC582jUA7tE8LbTlQvBYDOUgls4TU2bxwC20wGG8Ead04PVhBfsR0CvSnuVLN9wb0OJmtShViX1YafBuAStCtrfd41RwGmuSrXcL/VschGRuychSoV0g3b9lTKn88mjYChJldj+8PXNiVrEIXkAanf92JYzQW9TN/eSC9GxpU/5oiUtSUhUWGVY4zOypt7AFKEi17tffyRMjX2qmeu8yZI/dQznkCAbWwgiRXH0rpxVwZU7Z9zaxyhhDqlas8Xjd4khog4Wu30UPlflOugwnJeX81R0YN76eSmJ4JfFxG/xG7rkCREkIiPmFkZCU8mS6IWFovAVrrV2hjoKExdSc0PCYb9xzxPEcFtS5Ugb6djKVdI3vMsGWsitkBSZd0jTuZD+e7fej2keBpiJUbMkOvJC+n+GdmMdhhfXvDMQGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(6666004)(47076005)(82310400004)(36860700001)(356005)(81166007)(2906002)(2616005)(36756003)(16526019)(186003)(70586007)(70206006)(26005)(5660300002)(40460700003)(83380400001)(1076003)(426003)(6916009)(8676002)(4326008)(336012)(8936002)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 01:50:50.9877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 569ddcc5-3b7f-4540-4ddb-08d9e849f051
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5534
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Unbounded requesting is unsupported on pipe split modes
and this change prevents us running into such a situation
with wide modes.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 7f9ceda4229b..007a7dc4f5be 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1836,7 +1836,8 @@ static int dcn31_populate_dml_pipes_from_context(
 		if (is_dual_plane(pipe->plane_state->format)
 				&& pipe->plane_state->src_rect.width <= 1920 && pipe->plane_state->src_rect.height <= 1080) {
 			dc->config.enable_4to1MPC = true;
-		} else if (!is_dual_plane(pipe->plane_state->format)) {
+		} else if (!is_dual_plane(pipe->plane_state->format) && pipe->plane_state->src_rect.width <= 5120) {
+			/* Limit to 5k max to avoid forced pipe split when there is not enough detile for swath */
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
 			pipes[0].pipe.src.unbounded_req_mode = true;
 		}
-- 
2.25.1

