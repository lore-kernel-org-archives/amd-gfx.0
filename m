Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A7FECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9099F10EB7F;
	Sat, 27 Aug 2022 02:51:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C25B10EB7E
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikB848lRLkvEJxVpV6Oi61i0yPMpKRUmQZp3onLeGCMIkdmRsaLnMlHhUL2zMyOTTh//xzV2nLJCGsNtkIlj21P4jNj9t1Uw5paJh/zgYnWkVLEFORI6JJt+zB8G1/+LD9Gj3h38ajnkuLjrrt/DQ6NBC1LmmQJl7WLErH6LsgfyMHuVComS29crsYjS7x9NDBsOM7u6Umy4pHxlVSpJzuTKQtahP/QxjVm0JxNkQ0iMWnc0ZGxiJorrpRYbasLGQrU2+noh9+TSoQeYDgPN9gU5cO9PcZ6AkXTS24504mmMfYlpjtygtUdz2cPzgtUwEi9ogjPfaDQ2/nk4NK2OJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/K3E6UYGowFCPFmWuBp88zeWgthKwdJQbmNyTwwJYo=;
 b=eLEQaG/JcMzQAx6902Iw2FEBLDD/WgGt0Orl+8DcAEXQz9yPhPqxyUBSuC0luNgaubs7r2EZYw7EQsbW7t7Dvr3pqbvOb90ZnCuMPK1qcafNJ4RPRQWdu0SfCXupBhdv4LSiW4C4yKktuKS9zaVFeLrDXqDwJo2yQBNc4Gcgl51C6XkAUaUufZvZ/JudyunENi9u17CR3NejndQdV609fg0zi6g/NlRZCRiSrZ4X5b5SEf2N6quJzC+XTO59ru86/SgaMTyd5eVqKqZFF+jklXS5gglu7bGQx/mpHMcNzrkSdkK3//x6HmxWxjdEjVPBfQ+jAoq+mE7imfJrE5hspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/K3E6UYGowFCPFmWuBp88zeWgthKwdJQbmNyTwwJYo=;
 b=U2chDGTo+c5cWLb95/o0XG6XUsiNFctpK8vbSR5dOT/oppaj69Hefd4U8tH1V6YrJjJX3IyDhJAx4cF3qSSln6f+FaQgr4elEs13i48sMfwWisU6AzFugcPrbfpJPvPKs96HGhm+aRxbyvL8MI1a5DyEX8YCxOqadIveHfLVKEg=
Received: from DM6PR04CA0003.namprd04.prod.outlook.com (2603:10b6:5:334::8) by
 BN8PR12MB2868.namprd12.prod.outlook.com (2603:10b6:408:9c::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Sat, 27 Aug 2022 02:51:48 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::67) by DM6PR04CA0003.outlook.office365.com
 (2603:10b6:5:334::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:51:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:47 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:51:38
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/33] drm/amd/display: Fix CAB cursor size allocation for
 DCN32/321
Date: Sat, 27 Aug 2022 06:50:40 +0800
Message-ID: <20220826225053.1435588-21-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e1a32ec-fd2e-4d7b-4058-08da87d71615
X-MS-TrafficTypeDiagnostic: BN8PR12MB2868:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +mh/53zrr7JQ9mNMbIhFOMtvQZkJk+lAG5FMpq5uuexucQNFxkHrk3fmqy0SFu2gU1CnBrCWZyhohg5izNf1BdQShQCPg/+M02CefK+SxA0i+lpWTYNFw3pvqTm0LSiznWz5Jeswj/nZwZcbtpqZwHi3QQk/p0uVhhU1LJf1DG9yzIOucefkhLqp3hjTWQOWkq0Kdm7q8w5UAJDTmQarDxK7f+ibbgxIqifpKaoc2hIgPoudTFKfgKj8Nd98EfRgn+qhEwi5WrsKZQp33QmE5WbAvz2V7dTPtnFcy/UsJZjmZql/DNw1bqcpMk1DG23quJv2pn0l9f3Mi+TPVbvN8IyvCqu20BD84FK/CfYAVp0TI/TpGUlMPngqsCEFXdii5G4pfv/Fgp1vP3r5JXtGXV29hOBmwx6zvJd66j8p3wWg73DpR7+3Lcg1kCe85r0s8HYM7mpAVkdAkFyRWC81J7MRlsGmd4KnSQdn9Ql+aYsdYJpzKBA8miQFVa/WfGPrdWdngG8Wd+6EZBodDstOyqV1MqFh05WvUXqB28/kmJydYflsDw4mB+46zu8v5Ey/p+b+pFFMlsKY//Hlhd+puY+pQvAhHgVt5iDUMpqeKNw18GQW9I642CGT7wF9cGxSMjKKsCYYy5/kFKlpY2SxilQHYFP2Ho7IpXRYz5zlfmSN6dU9kZA45YwyEJiq/YjyqcaZ+7lSVfx08RxrYfe3i0fsP5EYLXdcHoE9dBIuw41nFsuKAm+TGWSqlrKyuk1/sWEijR3fRLzEVUpf0U3MP+ucYOa/CF2sdjE3ln48htRUmPnoGWfK1303KqJJXbvYswpukX8PrdcWsSJAvdzJlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(40470700004)(36840700001)(26005)(81166007)(356005)(2906002)(83380400001)(82740400003)(54906003)(36756003)(6916009)(82310400005)(6666004)(316002)(7696005)(70586007)(4326008)(478600001)(86362001)(8676002)(70206006)(41300700001)(5660300002)(8936002)(36860700001)(1076003)(336012)(47076005)(40480700001)(426003)(2616005)(186003)(40460700003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:51:48.3618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1a32ec-fd2e-4d7b-4058-08da87d71615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2868
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

For calculating cursor size allocation, surface size was used, resulting
in over allocation

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 63648e2056a0..4e965a0c2484 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -312,7 +312,7 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 				cursor_size *= 8;
 				break;
 			}
-			cache_lines_used += dcn32_cache_lines_for_surface(dc, surface_size,
+			cache_lines_used += dcn32_cache_lines_for_surface(dc, cursor_size,
 					plane->address.grph.cursor_cache_addr.quad_part);
 		}
 	}
-- 
2.25.1

