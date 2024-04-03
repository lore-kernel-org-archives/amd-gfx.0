Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214EBCD1294
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34238112E8A;
	Wed,  3 Apr 2024 19:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kTqwqoIN";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50135112E7A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmxFlY+UZ5k05PqF7EBwhr1k9FQkwn8UhyltsdMlRyDit4y2BOI/rx8XhKBTj/7Aks8UHXJPo4XVNOPFg/CkcB4QSJFJML62Z183hGyoiXQFvwouEMT5Ju/SunBtSYTo5h2tFSsq6WQXF4EjjNXgigu7Sm+4qFFR28sl4kGX/4gFkzaonGyAGOVaq9LGARHgcFNWJA18X19iZqGj1n67GcKyTL1Gpf25P37v9qlMAoFmDuYua957lcx0y7iHwPFZAWeAS8wbmvVAonbg8fjLdDGl/eUq7/JWwdGC5E4a1G5ZjSbV2KFyIeQUDD4Fbt8oDrsG/2bZU3brcnZIr+5WbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jH1s5j/QMKJpPhLikUmjPzVA0z97uNk7PcNYzg/4iDE=;
 b=UocQTg2bB94yuY/Or6Dp16v3wGRVMji5I3nC8nCbp81IZX+hhWzgPiGH1NREX9CUJJojuEw82kn0E9uWYfid8qpgku9/mwh6rhACD3Ycuhnck385yVcAVsyn32IlFL9inJxociu3svGLEM9oIMLVTldAgvvBVduMsjHuPU4uunQfS3qMTUE0LOwK8qWVDZhxGjtraRemCa2wtByyFc2sRj7ThzB9RqUk1UFA2ZLDjcjhL1dW+LbHDeTpyOhbx52KNiUOmygtv0Z81SWnaiLXrTzVqlrkqSojYpBLGOp2RSwdp1ozb5LlP+1ExirQm0kYzfvVqAb8lKEvnzMh5hMJCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jH1s5j/QMKJpPhLikUmjPzVA0z97uNk7PcNYzg/4iDE=;
 b=kTqwqoINnWTP2DJNDQ7XcGItIyCPaZQqrzj75LUOAYktALJBIwK9DQzwgLxGDiDhAigTu6B5x6Bq7LGReRf6DRAy36W5rI21IiCVifbnxqAJXkV2FKXS9NRDjQsAqCCNPvccdRT76Acv9neurai4FbYJEKCcC6/lBmZLPvNwEiU=
Received: from CH2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:610:20::24)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:54 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::d6) by CH2PR07CA0011.outlook.office365.com
 (2603:10b6:610:20::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:53 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:52 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 25/28] drm/amd/display: Add fallback configuration for set DRR
 in DCN10
Date: Wed, 3 Apr 2024 15:49:15 -0400
Message-ID: <20240403195116.25221-26-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c2cfae-82f1-44cc-b02c-08dc54178309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5/8umfyfMjqdi2H3agApfd6JcJyfwIpCTH++pEPV0DZ9fAFUtcs7RPEqcCqRy0L7X5W1IbKSBLL6CSE7yKs8clKeZusocsHnJ1LGOo1OOia4GfwhDpGpkoIrhCZfLWk7e1fktgJHNBAOC9JprBbsfV0xSzjSPQ87vhsPf4bHftTJm7bDzmSkyX6/2pMpcMmQZESvHAEkorbriVdIUykN6DfOTUUnJji3DJVOXikpEUZMTBkjzbLFJlnQv+yqSlZp0aqH4DX1EpdTeimXssfoxu+vW4qmLsxvEjfdtljDg5twk5uRlsDbhmcwHfcjst/Kb+qgc7BnMGzWegtBLkzfiJmDeWzhIkAwxZWEiCZSzyUTURM2XKaA2BJZhAebpe17GksSV7XmPo/LAaJQB8Gevui8rzP4l6v/7D/vnyhbKq74HGnGUn3viX6hV7qm15J7aNjcmkeWHaYM8Vlm/m8/z2u3NFxgtdRkEpwqea+0fP8VJzr5fFEUoKpjmDwxDOl4eZqI5duA7yVPcf9DGqadeycUWeq+WkiSGvQq2zVgsrDsBF8rs8vwKPETyRkL4eqS1bdkvWgN1eZ/y/JtRKVT0at8Gh9vAYgr2cwvSWTxsBuqJj68VIHMtZ5iF8JVBEETWxebsyGh/cU40t/Cx1jX6aKBXd0Rp7Kwai0Kqrt59Tg9nxiQ4NtWmggHBZPgzEZRbn20/TH/RJ1QfnNo0v4WBWzGh4hfsHmZMrlYnn0Nd2mvgsY1UjvVmv11VO6YJAc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:53.8417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c2cfae-82f1-44cc-b02c-08dc54178309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Set OTG/OPTC parameters to 0 if something goes wrong on DCN10.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/optc/dcn10/dcn10_optc.c    | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index f109a101d84f..5574bc628053 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -945,10 +945,19 @@ void optc1_set_drr(
 				OTG_FORCE_LOCK_ON_EVENT, 0,
 				OTG_SET_V_TOTAL_MIN_MASK_EN, 0,
 				OTG_SET_V_TOTAL_MIN_MASK, 0);
-	}
 
-	// Setup manual flow control for EOF via TRIG_A
-	optc->funcs->setup_manual_trigger(optc);
+		// Setup manual flow control for EOF via TRIG_A
+		optc->funcs->setup_manual_trigger(optc);
+
+	} else {
+		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+				OTG_SET_V_TOTAL_MIN_MASK, 0,
+				OTG_V_TOTAL_MIN_SEL, 0,
+				OTG_V_TOTAL_MAX_SEL, 0,
+				OTG_FORCE_LOCK_ON_EVENT, 0);
+
+		optc->funcs->set_vtotal_min_max(optc, 0, 0);
+	}
 }
 
 void optc1_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
-- 
2.44.0

