Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE4BC00454
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E712077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Eru/wYHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E712077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 309836EB74;
	Wed, 11 Dec 2019 15:34:18 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760057.outbound.protection.outlook.com [40.107.76.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D6B56EB70
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKPnNxaN6EgB9VTvj8EGaPofOnfcOQA8UI1x5qExEVURS99XXjQllER9Dk5rKeiWkZpM58QvjKnEEb95Whn8ej2WKcdQrtmX3LwlHgA2AP3HWNigikyTfHO9oBClSXp96hOGvbD5N7A0U/ePa4rq5KfJ4uoMgS8KApNWNZe/O8vETHsaTuMfqeQ1dYYm5++NEkcD1z1ZFuNt/26n4oTKNS0up9n7n88uKbRdNzHjaAgveseuBbR8qtc/99gg60ZCzc7T5QXWXKmCnh2LC+GPn7nd32UJIOoF2SNup2Dfiqqpg5eGo95dnaipfLvz0hwZ5F9b/QiRFox++ErfKR5jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI9skgA2vSNNQNg3cd8z6EcXH/jXwG8joC2vHd3BksY=;
 b=b/xA5uZ6PDwppd+x8S+2gfvbg/xs+GKCM/ol70j6bI1FsQVYc+27hspPVpNLz1AClV3rarDL2Z+cIJcDd4H/flwsQgeoLsDYV/htyknF1hilsWtS3J4eZVoUB5m+xY3E5+JPXm8Fhz70720F0vONoLVb3Bz5s/r7c4zas8LwGMlzGfzo1NW4tnx+Ovvs8fdPaC/i+cBiJxKQdIilbbxJzQFEG6wCzLI9S22w8I0oPNrmucqqBc5LIZKt0zjQ1cruN3rya1thpfFeHSflSvzmgPmTfTooInRgj0jaQ0DzLU5blAp9v9hN9kcM78667zdDgke2ptzSrs+7/Pmc0aPY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI9skgA2vSNNQNg3cd8z6EcXH/jXwG8joC2vHd3BksY=;
 b=Eru/wYHyjSsjEl7EFJYwqjNAVPs7Kx2eY8tXbtJxdQ34ibP3VCtz9XJDReKFOpIYRmE25jXR0cnozmvBui6U/op9jFth28VAhPzDdVn91tIACcKtVVJM6zMD3ma0AZT+MzlK1tZKeg7gqOOWNfSOpxu6tbKcdZeRzbNv6DTsR4g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:34:14 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:34:14 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 31/39] drm/amd/display: Fix update_bw_bounding_box Calcs
Date: Wed, 11 Dec 2019 10:32:45 -0500
Message-Id: <20191211153253.2291112-32-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb251e86-b1ba-4f18-3072-08d77e4f81c0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24912031A42FC424CEEAC868985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(6666004)(86362001)(52116002)(2616005)(15650500001)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFiPPNnCGK06TgQ8xngDadJxn/rWroK7s0xrTaTRSoGGieOdugAQEkicfimJQhlUT24fVdw87MiEYuQjQn+R4vptv42qyW6QoslNiASj5x6wkIsOwtJs5c+W+LesTXiFxRtfG0y9dI/L1YE/XfFgysMPneBo8yFMXysvXZyLDhQsP73YXSw8oa0f1G+psgh4hZ4haM25ZDGLKOg/Z+ZsKjRgZ+qf3Y5CtN3tzafQZGZs+LqCt6AFByY6pEdSsYvQWy/IHqFVDpkigb8P4bjh8RlvexpO8Xo7DNwnzXrsaNDn2LQ+wOyeKhTSVzfFKgdyzHPuaAR1lodFggIg/6HSVeigvSjHhAOGYXsQIkC9hmmEglQ8SgrWLigJVUViNJDiQXWbt8FnL3vXWfnwsgyYo+dexnYWyYwTObmgODjIBrfZ02R1+UG4zgziF0smSWJr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb251e86-b1ba-4f18-3072-08d77e4f81c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:44.2825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vibljG2nAt99tELrfgxlX4mWbywBxgeedA+Uf8eF4uGC4kZo4NZA+9Kd4XUDuBxcZwqnFpoY5ly7dxsr4LHLRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Sung Lee <sung.lee@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[Why]
Previously update_bw_bounding_box for RN was commented out
due to incorrect values causing BSOD on Hybrid Graphics.
However, commenting out this function also may cause issues
such as underflow in certain cases such as 2x4K displays.

[How]
Fix dram_speed_mts calculations.
Update from proper index of clock_limits[]

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index a662769b0c48..111f2c30c6b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1317,12 +1317,6 @@ struct display_stream_compressor *dcn21_dsc_create(
 
 static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	/*
-	TODO: Fix this function to calcualte correct values.
-	There are known issues with this function currently
-	that will need to be investigated. Use hardcoded known good values for now.
-
-
 	struct dcn21_resource_pool *pool = TO_DCN21_RES_POOL(dc->res_pool);
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
 	int i;
@@ -1337,11 +1331,10 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 		dcn2_1_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
 		dcn2_1_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
 		dcn2_1_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-		dcn2_1_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 16 / 1000;
+		dcn2_1_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
 	}
-	dcn2_1_soc.clock_limits[i] = dcn2_1_soc.clock_limits[i - i];
+	dcn2_1_soc.clock_limits[i] = dcn2_1_soc.clock_limits[i - 1];
 	dcn2_1_soc.num_states = i;
-	*/
 }
 
 /* Temporary Place holder until we can get them from fuse */
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
