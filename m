Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88519C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFA210E472;
	Wed, 14 Dec 2022 20:22:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB9D10E472
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:22:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca062Y74z43UsaEMZkpGHkn5yyySWFIpd31lqtLNjaqpVXaScwFdDQ/gvyKy72ltE+U9RjJoqko7ovuQSxdsu/gbNEamt95jLqOxmdbuM5qNIEkVTIt40GnKphmB5bAhTEOXyUlj7rr1JvwSWJ5fpJj6jtHhlHCBzZ0h0oKqFL8mVHPV4sYRemiQCMus0MObY1ZnW4R/xD1gu39RgyKoUSiJdlX/CklHSgcTRIr7fBbZ6zd9gNq1nbudz4igjGkMu9r50JzQdC9aTjLImTVMQrnNubsSVQezzE3e/lvAuW8VvcX85Gbiuxe+sXbniYKn4O7zhESJHIdTGVm95Aetjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1e5GYZwaYNHTusaPX+VA8Zj1/kJH69ixCaEh6QJYAV4=;
 b=N0kI/d5dwgf8AC4CRi6iaeXCZ6X8QB4UgaczILcQuAmX8PaaJe8vz54alo98N3fYY4/pvPGSi5pseKBefmIaGhojB3ejWVvWsoBQxLbBX/BsNp7tyBVSUuS9DMphqtV5qpSPj7EEflERBNqOJZEtRMN1EdNqcL4CKKRodOb5VDcVnsiRCvqDB+p/gK471XTq474b3znzGs2kdjWPpV8yvlIsAGXX8QOCl4D/OZ6WHCqCmS/ANigpFxboNBoJXaxRidljYqExZNYomIj2cxxXWqjhnr/x17N876svY82BekNFeoiUxLOXwivSdV0s39fUkV5+TJBm4zq2G9cyfGchng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1e5GYZwaYNHTusaPX+VA8Zj1/kJH69ixCaEh6QJYAV4=;
 b=exAhbgO4x2cTkOWMVXFnblitCbDu/enwRuiqDgkGkUv1Dnw+R0Iec60CG5CK1DVUqndbW3Xi4U/bZ/bfNTDxUS1EBPHDxQnR2naQF44d1zLK1/ZIxAr5yguvNohJa+Kqeno6WRqdMwkLFwwuAmpNyZKG/2L5xdzKQcSCYWlr0OE=
Received: from MW2PR2101CA0030.namprd21.prod.outlook.com (2603:10b6:302:1::43)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:22:01 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::5) by MW2PR2101CA0030.outlook.office365.com
 (2603:10b6:302:1::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.2 via Frontend
 Transport; Wed, 14 Dec 2022 20:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:21:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:21:58 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 12:21:57 -0800
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:21:56 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/18] drm/amd/display: patch cases with unknown plane state
 to prevent warning
Date: Wed, 14 Dec 2022 15:21:31 -0500
Message-ID: <20221214202141.1721178-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afe852b-4c30-4bb4-63c5-08dade10daa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46bUoKOqstSLmcCWz9BjgGNy+tO/Azpoow0E50WOtDdBD3l7W5BD/Ft9NRKJ3ZSwYnuBCzHbyKOqwF46gAN5fysLRYNqygvulg71tP1rjSVb0J2tjWUwOi9ErAZzwObnWRgU3c8asuqvy53FKT5EDqRErASl193B0zhTxRae01o5lFf/2qgDk4rAdqtEXV5J8sDrnbXQaY/3WlHMw6zKkP+7EH8nLv4pAsd6Ss4hRNdDVxYJmtrHSH/Je96uDOFjLQmon9IzmvcOy0x9nb5kq7xFNvEzWyXl16ttkW0ONtxhjMMK+hYQGW0F7wVVSxq55oKRapTnINUDohyur/RtG1cHuaypzOLGNe243Rv5Vg5jhpVbawgU1gazkgmzjVsn4tzlDZuAdyNbP181fFYaxmXdK5egkIbHKDdZFH0YycTJLy9B+MQ0qDzApupF2Br5/asGI8otBHHkyVWbhlbsZh7mYknJlfDhytD9BrAHZw2IsoipGJV4CgMah7jAQlVnxDCrrQJThrX+Ei30EDz6b8hS5f00BCkF4+HhFCNaLaILdKDa95ZIP1GsZUIdwme0n08ZMTA9MF+Y89RjJBmiEaDFTKO91ql3VOwlr4JsXGJNHx9OlURWjVw5X9mOzcJ0Le6cuIqkjcL3yfVG+J3qIAW8bpCQv7SYC29d+DP6JX737bfeasnx+KxDTwpOPEE2168lGUfpJoXhU7rJwFnw2K8Bem992oRrtEAIjQA0krE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(186003)(7696005)(26005)(1076003)(426003)(47076005)(2906002)(6666004)(316002)(2616005)(336012)(70586007)(54906003)(36756003)(8676002)(36860700001)(41300700001)(4326008)(70206006)(83380400001)(82740400003)(44832011)(81166007)(8936002)(5660300002)(478600001)(6916009)(40480700001)(40460700003)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:21:59.4161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afe852b-4c30-4bb4-63c5-08dade10daa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
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
Cc: stylon.wang@amd.com, Swapnil Patel <Swapnil.Patel@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Sung joon Kim <Sungjoon.Kim@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Swapnil Patel <Swapnil.Patel@amd.com>

[Why]
DCN301 resource function is missing function pointer to
handle cases with unknown plane state.
This causes assertion when global state is validated while
using swizzle parameter as “DC_UNKNOWN”

[How]
Add function pointer to handle and patch cases when plane
state is unknown.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Swapnil Patel <Swapnil.Patel@amd.com>
Reviewed-by: Sung joon Kim <Sungjoon.Kim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 8cf10351f271..ee62ae3eb98f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1414,7 +1414,8 @@ static struct resource_funcs dcn301_res_pool_funcs = {
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
-	.update_bw_bounding_box = dcn301_update_bw_bounding_box
+	.update_bw_bounding_box = dcn301_update_bw_bounding_box,
+	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state
 };
 
 static bool dcn301_resource_construct(
-- 
2.39.0

