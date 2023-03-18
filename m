Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE72BC74A5B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7855010E358;
	Sat, 18 Mar 2023 07:57:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E5010E356
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zkkn0Q5rwreFR9vygb/WnNidGqocYR1QOCsCGVgNGGQQ+yeAnX1sYJ3q4Hp0ciLbmdMaO+ePmqk5wtqX0fp0bxQNTLPG/OeUt5K48GPGOhpic59grZk+y7F2SKuFPD8T2BUd5DCj76ZJdW93G705ACjk7IVevyMWnwq37DKxkjukYMkzFlZ+2hJQGBlbxHe80wnFa1tHgF/e7+ssOnrgAcZEikX5jFUS/DODoJlYkKX9p/86cbMCMrhHffNbeAU3LycfsLA0yc2tW9lF8oL7125Fq64J+cn3lsOlaLGClEvpdIesOOsxWJIr1dXHNd9MRLYFhUGssnPCkROmnUaMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOgU7Ti7j5pSJFmKcIUnyhnYn5S73gvuA7A+UyRK9X4=;
 b=Z0H1Rrv3l5wZ5YcWiWRDLfNy6kEO411amAO9Zs+/toiWsorU1ROsj2mIDtUfamnzUrzEJHbwmxHwTu02lGVoQo1D/BmTfbumqbRfJdV6HUE3JL22Y4RkELLMjjk+vEPeNic5AqZ/Dcjp/yI91BUCAmwjUJUb0uvmH8R4QKTGWs+YYZ0miNgCbuUE8tQxCds3fSk7n6POmnNycFuBknSlKjfsb6Umdkqean7XnEmDfd7MZS8YUX0dGM5omLZZeWt7Lito2d3ayCXk+LXnD17klEb5P2TEkdVqKQy3kXH9XQoIfYA0wIQPoJosYkwCj7pv0S7VsxrM4t5KwqD//vvZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOgU7Ti7j5pSJFmKcIUnyhnYn5S73gvuA7A+UyRK9X4=;
 b=WxCulztHBNVRVxDFUTHNLqX+M2HZcnhwTRd92BTbgfNlPY95+rDVcDMlYCsB2tXyjBTAy4bOMQ1HM1h5Ox1UqGFLUGq5tdp5LaT5jb9InDPTx1fotz8mCKgHuRoOHOgGb6CxfZIekVTX75lnbeuvdGSUiTNmSw+GFjuSpYWtjaU=
Received: from BN0PR04CA0153.namprd04.prod.outlook.com (2603:10b6:408:eb::8)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Sat, 18 Mar
 2023 07:57:30 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::a2) by BN0PR04CA0153.outlook.office365.com
 (2603:10b6:408:eb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36 via Frontend
 Transport; Sat, 18 Mar 2023 07:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.11 via Frontend Transport; Sat, 18 Mar 2023 07:57:30 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:57:24 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/19] drm/amd/display: add missing code change init
 pix_per_cycle
Date: Sat, 18 Mar 2023 03:56:07 -0400
Message-ID: <20230318075615.2630-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb08719-98eb-491b-a8b7-08db27866ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F39G9HB9a0XcNKsKInUeKdmlK5NeOnUVJNU6M6QtvUEHyFHyLErl0sE2PUprG7+zyOjcGec6Il1PD92DaaGjqPqz1lEmNgErD4tUOzvYdc7BUMa4/w+KW0mc29KzChzS8SXZkjjhfFhlnp0GhjWiY5ztDJyJVPV5vZQNkWs4xOj9YC0pMJ6u3exORWKUvbMRjSysx56yDtUSVwi+JRxclal0+dRmWj7lMOPvRtAWgu291bhZVPiVZGr20GOo65UECuE4fQ+TDKaUwHnLSF66AIVZ77P1OYSIhjQOIAULPvbf41/3sE5PhESUXNlW83xDQEYKHYMf4AHx+L07G4645aHHC1b3lhY3i0Brol7owYAB60shSPW6e53wOWiWRH8llOn9E8Xq2JxmqOKCIlkOClaM4At8XxRa/0gIhtASi/BOdwldE10ZY9HO56vZhwnMwkWIc7GFmP0RaSNu1JkhxrYKuQOxUvl9O6Hlm+Kpc+eqVTCdXmENcaRW0Ao+yPzu3xUWVBhQFEYNw2tBdLJMG84/tJg+eToigEzfHYp+JHnENpnXF7PD3jbdxx40sE6ociDIEQFVldVJnK1srYzwigcoN0ffhZXY+yaISTYcOmWVEzGULQilXPmrvyeSqS41HOrWGVd/8P+cHuUFWBtRmPw6Vjyd9hkrMZqFQK9uKpF+LRi4y/u9tRrchLR9jJiMH4K9E/IDXP8WngFdDFUJvmf8oRpTXwmwcRvJgJSvbb0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199018)(40470700004)(36840700001)(46966006)(16526019)(2616005)(186003)(47076005)(426003)(83380400001)(6666004)(478600001)(336012)(70206006)(316002)(8676002)(1076003)(70586007)(26005)(54906003)(4326008)(6916009)(41300700001)(36860700001)(8936002)(44832011)(5660300002)(40460700003)(81166007)(82740400003)(2906002)(356005)(82310400005)(86362001)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:57:30.4223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb08719-98eb-491b-a8b7-08db27866ca1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272
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
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Leo Ma <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
missing change when port to these two dcn version.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Leo Ma <hanghong.ma@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index 89de64f18040..d05e7655f603 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -294,6 +294,7 @@ static void enc32_stream_encoder_dp_unblank(
 			|| is_dp_dig_pixel_rate_div_policy(dc, &param->timing)) {
 			/*this logic should be the same in get_pixel_clock_parameters() */
 			n_multiply = 1;
+			pix_per_cycle = 1;
 		}
 		/* M / N = Fstream / Flink
 		 * m_vid / n_vid = pixel rate / link rate
-- 
2.34.1

