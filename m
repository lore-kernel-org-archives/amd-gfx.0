Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF5AC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB40D10E57D;
	Wed,  9 Nov 2022 06:16:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8CEC10E57D
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GM00m/NkVWrUSAzKBBrBMQbLsMPnlNs8q/XUFIlfykDDf+ikICSRqhIufxhCHdZTuhF9WVL0THhaH/eoUwKRCtmIQ4xjCAS0xiZRHraIJ4Au2EVpD6ujGAHQQE3e3I8px73+2k2Hj8D3q+iknTzcoalr6FL1WT5CaRm52n6SXDXSGllYkY/+2+4+2r8py5mqyIazebHFxNsgT5f7NysOMDoV24ZBx5p+42YN5MtmkFhZxucTnclDqjPilnE2VnMaWjDD4/dfX8uUJ5Lf4I6y1ObgkQQ2VB/V6HqwCyxvK3Jny3ipfYl+UBziteLXJStprc5f+ce1PBAzTMbjIJZrVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=319nmwt3bNr4OkLwTj1hAkXUoAnB869W29kd7OMEDFI=;
 b=fXXEUOxq0GUmufT6I1vK60/xf8dHGRDYxKdKg6byZkRnGx5NKkVFT5QUA5P0YGOiTwwaDnZUDUuOQzzYxjoPJe6VJx4Lvfa2BG7BvifyGsQxkjqOh0iS0Wq+DBDXriDNhpF4Zv7xFDTvV0GxB9wb7zJdex3jg2mjXL7teqFOZUGXhRWyAk41u9+GAizzDlrU6rUcl0kuNN7djI68Hsgzsfm2X+bhEesXVBc3IduuILyMyptqXtOE+6eAMsWY82K6sDJ8qFSNdsuQ0di55y7QkjFnVvoPJeiaBDHWQxVT7zygsqPENLAn3WpICceS75loyfgprsmVmHPRUTHd4YKAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=319nmwt3bNr4OkLwTj1hAkXUoAnB869W29kd7OMEDFI=;
 b=Ks3kQILNc10iiiI0Q8nTCKLsTEpY548Z5zHgXdccYNSIygyh7YpfZBIfNaaDSi7r17JMpzJLmNrm+noK4MpAvRlHpDcpP1Q+n+NoYv3m/lbQmcvOAzB0+Xo+N+qzDLRo0y4VJ10ivUqd48dy3JPm5AVKobdXAXJSTjvrxIJRPfg=
Received: from BN9P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::6)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:16:28 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::e1) by BN9P220CA0001.outlook.office365.com
 (2603:10b6:408:13e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Wed, 9 Nov 2022 06:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:16:28 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:16:06 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:16:06 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:16:00 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/29] drm/amd/display: Check context constructed for pipe
 split flags is still valid
Date: Wed, 9 Nov 2022 14:13:04 +0800
Message-ID: <20221109061319.2870943-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: d1564d44-bba5-46c3-ffc1-08dac219eff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OImIPisN8pMq2rsfILOqR5Sr2DHbzuk6+14JLTX5PTv8BS5o08jxlL/OCTt0WMVldMAtucskqGteL2uo+jwK8EqRwFzadHaD1W5OisDRLZ0Orem3d1zyMN2qWDBb/9NvArKE8z1D49F5CQmNkvWGc5BpFPXEmSpDNE3Yx0eM80lNXHuOgYpsLYU1YsmuGfKY+ej2xwkRyOvxmq1N/ATN4BZgYF1fn871uEYfhJ9xQ3lkFb5/+X3ez4780vvy/2aVWRE2pH7pLiSRQPB0XorDcaN7+W+88V0WH0gG3R2PGz6oJmhiyK036wGhEsETQk1jgTDYKQJuhVovtyzA/bFVK8A+c1QjADTqeznM8oCE7MwkvJQY/Vpn8nCymlH7Yc1T/HhdKBt1hSyiB87tU+vMzgG7z26p9TBAIAMHpxgEoZrF/YrsiQIVYBEwZ0+/yeIfVW5s3X3NokILGeM2uw3aiKy/guczJxSe7opYivHOzmf/pMvhgDy9tmxFLfz1k82OANjWkbgocNJjQpTU2veigwz248Np/svQSajrg5Qa8z9a6wX4bcVrohTHrXyZjPpOnBuqiTVKnESg6c2oH7y+F65To+5n85e1LOoQyv37V1xaJ6ZStniTGqInUIDzU5FKahsIVt2MbVsZIxRJh7THu9LiD+UB+xBFvT3+9tl7O6N1nau+IxpNaEL1+gPk2z95VxZNQ1qKx9pMWjazPkfTpN6T78cX+YBBku8IkUtKlVGwqPQ61bGzeLxSLVG6I8zCKGW+6t+PGSwPHgUugFA0xjQAnSy0qq1fRVRXsY5CvwkiniQX1oy0fMrMnhTgKOP/qKnL1hG1IY91ILIhL6JONFDyaMSLmusUz7xgc/fYd2g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(82740400003)(4326008)(8676002)(40460700003)(2906002)(70586007)(70206006)(41300700001)(36756003)(83380400001)(5660300002)(8936002)(186003)(316002)(6916009)(336012)(426003)(54906003)(36860700001)(2616005)(1076003)(47076005)(86362001)(26005)(7696005)(82310400005)(356005)(81166007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:16:28.1790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1564d44-bba5-46c3-ffc1-08dac219eff6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
After applying pipesplit flags, DML can select a different configuration upon
revalidation, despite the desired one still being valid.

[HOW?]
Check the configuration is still has mode support, and apply it.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 0b1e721be33b..f359f3edaf36 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1748,6 +1748,9 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 	}
 
 	if (repopulate_pipes) {
+		int flag_max_mpc_comb = vba->maxMpcComb;
+		int flag_vlevel = vlevel;
+
 		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
 
 		/* repopulate_pipes = 1 means the pipes were either split or merged. In this case
@@ -1761,6 +1764,22 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		if (vlevel == context->bw_ctx.dml.soc.num_states) {
 			/* failed after DET size changes */
 			goto validate_fail;
+		} else if (flag_max_mpc_comb == 0 &&
+				flag_max_mpc_comb != context->bw_ctx.dml.vba.maxMpcComb) {
+			/* check the context constructed with pipe split flags is still valid*/
+			bool flags_valid = false;
+			for (int i = flag_vlevel; i < context->bw_ctx.dml.soc.num_states; i++) {
+				if (vba->ModeSupport[i][flag_max_mpc_comb]) {
+					vba->maxMpcComb = flag_max_mpc_comb;
+					vba->VoltageLevel = i;
+					vlevel = i;
+					flags_valid = true;
+				}
+			}
+
+			/* this should never happen */
+			if (!flags_valid)
+				goto validate_fail;
 		}
 	}
 	*vlevel_out = vlevel;
-- 
2.25.1

