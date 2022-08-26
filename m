Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C0FECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70DB10EB8A;
	Sat, 27 Aug 2022 02:52:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB63110EB81
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYS1dk00+CNcoxfhu58DjrjsHtU426SJmpouuma8OCeOehs0EF8ApfmbO/z5lZQHBgF3EntMIir2ILO2nIag1SJ3Gs/ZFMC1OjkU3FvAMD2d09MHrB3+cOaEpCtISqpCRU222PFR3VWmLQkB370Z/13/wkd6qBrV/rDAXOFBdsKOS/Fmrxz6or7jAzL0Z4dk2Exlo+aS623k2p22Sfcb76Bh0BF1N3/VLU7JtH0th7BEqeC97gE8Ae6KHrZSdp1RZABXBzCWLYQN95TyIYvOP6gbng8ppKtmqzoH2hzdztqIQ8BL8Q86eer+89JwWu5FeETF1h6w1HiqpTCQ9Wu0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWek2UZGdomsmrQfyxyGzrfqDKx+b6AgmQY0M3uigew=;
 b=IVMOhYaBy6FtsbE2f7I9NceDs1EM29nXfRFy5Mr8hH2wgwl9EhrS9NZEt8uvUELG7YxtvGmbHPV/2g7ebD2EQ7E7TqZIqSntwnDX5NybC4UKBIsiG2F86lQgJwJR2jDcVylZysriuFeR/wDwDHJyrDP6JeQboh1P8rGwgkLqyted8DYaWAKv88Kfk/qoKkTwvnDW4mrnKvIKgyjeJLUxdBVo8BMkLmFI6ddpFV1HKxzPEmWbjz7wg9FjNYkLVEIMKG0C81b9mu0Bycrd/7OBawBu168lPTu9/d5LVIIhc0HQtGyPShi1Xm2kl05Al6gPHYb+bEhGNCSVE9ms8BG3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWek2UZGdomsmrQfyxyGzrfqDKx+b6AgmQY0M3uigew=;
 b=vmOXd/gRniadSYghillTQzCrYRWXmuGnRM8/+zD4smySERga+eZEyF8u5GRwl3ozbBCUrM6DGPNkDvjOAid7FbGxZHULpEziA9OHqyrD9WBVn+NL2B5OKCkrFScb97vNUYEUMoZ8ocLcmZ0z/lCXomRMayzD2fB+N8Er6/3wSlQ=
Received: from DM6PR05CA0046.namprd05.prod.outlook.com (2603:10b6:5:335::15)
 by MW3PR12MB4538.namprd12.prod.outlook.com (2603:10b6:303:55::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:52:07 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::bd) by DM6PR05CA0046.outlook.office365.com
 (2603:10b6:5:335::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Sat, 27 Aug 2022 02:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:52:07 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:52:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 19:52:06 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:51:57
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/33] drm/amd/display: use actual cursor size instead of max
 for CAB allocation
Date: Sat, 27 Aug 2022 06:50:42 +0800
Message-ID: <20220826225053.1435588-23-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e3eda3b-d95c-45a0-92d7-08da87d72140
X-MS-TrafficTypeDiagnostic: MW3PR12MB4538:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDSRgFJE2LPCPHyw/DhrtwbXXzkjwhMHK9NMaDrsG6Xex7KPspJVqwYcscPuycTPKrDbHE9Ckev+h2NrkSyzSQ6MAyUPXs/2QIHktwNkMZy/7tDLIKFxlL9hY4jCrGQmaKFxP5+yybwdW/Fn5JdkXhHJJODpQexwBRjePz3/3GntXeUQy1427l4+WX6K5eBGMs40RV50T7J6nYG8TYw9wb5l+8GB4W4OWqOMAzt2kMPwgVh4NcFEGKZzL4thRKQ/j9zPVdq3a+kc+vuGDgEPwY/MY0Bv3sa5qcJu1KYukjlsGFT9xiByuPArcC5N2hFYfBpbLaD9FIiWsofu94Hy5BnF7B0PTcdGDik/Qk7rFkJKBKB5vcTjw5MCk3UEGxNODKwK1mzAdJAcPLaprOWy1HhsK2KlBAsi4RsGkLWkLmSJJVPiMulZkYKkGw3+HCDAM57LIsoiFfqITldE+iQxYbDQ+El+xfuooOw4r1V5T7s67pEtfsPGt6jOzH2sflRKv6ofq9x4FR2gp2wFkCT27/rfAQ5VJdBqWt+P7jDbyWURxV68M8FBN0pfHshdaQsRsMfBUivWbl63ei/Fcb8TdtFUPa4WY87Z2K3RjKSXRHXcEBT6LJKEx5xaY5/SuLatx1lT6h0N9aPVBPQ0AA68sRR2id6ou4B6l7UVm4pfwziRlzGhY3LbWFhrQj9pHWsgoyEc0DwT2jQ1zLykfKPcu5x04rufK+vDWFPzFTu9NZJ+jKy71KnhoWsJIzFru8odZ233kTwGeGtF7mLQUv0oSEwkoqco3M6uucetmrT8uFIttXb7i4byWLLCMnYZn1nzKq0hiAG3wcEjnRXXNGexcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(40470700004)(46966006)(36840700001)(2906002)(316002)(70206006)(70586007)(8676002)(82310400005)(6916009)(54906003)(7696005)(4326008)(478600001)(6666004)(41300700001)(26005)(83380400001)(40460700003)(2616005)(86362001)(186003)(1076003)(47076005)(336012)(426003)(82740400003)(8936002)(5660300002)(40480700001)(36756003)(36860700001)(356005)(81166007)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:52:07.0851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3eda3b-d95c-45a0-92d7-08da87d72140
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4538
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
 roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, Nicholas
 Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
When calculating allocation for cursor size, get the real cursor through
the HUBP instead of using the maximum cursor size for more optimal
allocation

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index a54cb79e7ba0..2d428ec48e24 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -295,7 +295,20 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 		}
 
 		// Include cursor size for CAB allocation
-		cursor_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size;
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe = &ctx->res_ctx.pipe_ctx[i];
+			struct hubp *hubp = pipe->plane_res.hubp;
+
+			if (pipe->stream && pipe->plane_state && hubp)
+				/* Find the cursor plane and use the exact size instead of
+				 * using the max for calculation
+				 */
+				if (hubp->curs_attr.width > 0) {
+					cursor_size = hubp->curs_attr.width * hubp->curs_attr.height;
+					break;
+				}
+		}
+
 		switch (stream->cursor_attributes.color_format) {
 		case CURSOR_MODE_MONO:
 			cursor_size /= 2;
-- 
2.25.1

