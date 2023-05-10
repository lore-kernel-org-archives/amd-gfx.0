Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141FCC7EE2D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 20:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A32C710E528;
	Wed, 10 May 2023 20:49:25 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB4310E526
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 20:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLGPGfixvCVsPcTk9lzXXb0CiErhi01E71GwJAPUY/hKEjKV3EvcjJDYpf5+dHTxPqzYioRzyWtZR1VIprFlwfhDY4IBnw9oPbLPy3mSjBuAoqgzQbwXuSJDHv+7PtkmNODAmhOmY4zvKnJE+xDjrT/RbMb2lgyDzb62PGyxER75P3fUjLwUj6IpcmWtMimg1NCrOjIj04ZAGrMKRh2UTIMo3vyzuEfBzKF47RMendo2RhcUtEFuyta+RpguVawJk8BFZFHNZsc6Z0UjxvVZQEuJaotDmnWIrfu28OJUTcLl7VnKcUpIfrx0JFF75gFB7UdrVIM/PyE6MqEw94xu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDe042oieszHT3TISp3V3KkyH/k6HWjani/fBSit0EQ=;
 b=j2Yw9VSpQQ3lIdZHF/+pAoOaJZqTTgdzuwNmEujAnoijjmVJui6L0huD3wvjeUB+tPxzHzTa1/HXTCQigv31+Od6F0OZUsiVig+5gUeSDlCz6kGnIigBf1VGQmgXIA128srldMP0OC1Fzaajht/KPVolSUQNtdh7reCrtRV/Exa4P53Be4MFLzp/XuqzduIN6Oapm+iGV9pyk9i47Pbt4Gc+HiDGQ7oelN19Dh9IT2vv9ySz/Ny002stPwmS7wbpjMInkxb2YvZ7gW4d0Zv+0n1btnt/tzel4oLoPIGBrOkW6wwuox7Y3lQJWpb2R0r6VLkWWKOUJxdjo34NiTmXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDe042oieszHT3TISp3V3KkyH/k6HWjani/fBSit0EQ=;
 b=WgiFXiLbiTIWce/+fSVlZKd22G/6qQsF6WIarxzIQjaPf5by9j3Qs4t8d0niDj8jAbH98oIkM8mTk6Ns1dj+9rjsnILWelzR/mpkzgPjKcTkLl8GraTdag4YBZZGA05mS2NEVZwAckfdPH4czkCiix38FYZlfALKanRAKgUK2n0=
Received: from BN9PR03CA0743.namprd03.prod.outlook.com (2603:10b6:408:110::28)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 20:49:21 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::37) by BN9PR03CA0743.outlook.office365.com
 (2603:10b6:408:110::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 20:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Wed, 10 May 2023 20:49:20 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 15:49:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 13:49:20 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 10 May 2023 15:49:14 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/10] drm/amd/display: Remove unnecessary variable
Date: Wed, 10 May 2023 16:48:58 -0400
Message-ID: <20230510204900.949963-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510204900.949963-1-aurabindo.pillai@amd.com>
References: <20230510204900.949963-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0495a9-51ec-4dde-81b2-08db51980790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqVdCp7hwzkvwb22I1iYqQ8oqEmAf/FiH6Gr7OSs3KGK+5MKuFOpRCB7yyA2NuoZ14uA3+nEuIMRKfXReuxuEidthpBAXgIb9wBMljWvR2gJPkU8OonG+yaD+jAER3j+aab80C9ADNRfE79BuZ/1HzXEteT41duScaUDTbpuN2sLX3DKzvR5zgnyVccoqwgkSj9seNYH4SBQ6/xoVqGpvruoqnZ/yEXb2npTVXWo4O4RzsnwDksqLlo20SRaoWN0MovqMKuucS208E93IkFuDqHCarKrcBMj+VvqFi+yYZLqgXOWFxQ4lQxx1sskkT8PD2ZzWaBJp7bGUFiA2yc7MZQhkQA1dcNO9m8eKYEltcCmLekuC7ZRi7kaCb6Ng+zQ0RltrVDVtAtViPM6vfrBnTSXGH2ksawVrw2NWV4VL8qIwiRdmmQFE5+6Cphcdn4dNStUkCttk2z3kVVJ9X8gWjG62ZOamMwe+fjEgRtF8mwmdvY1MVSfrhy7eHFzeA8fW1OduvFcufiQPHuZn1ZuyYza/kZYixO/jW3l3CICSOIemnfrKt/2HbaxLveIhl5iXK2mlKYDSKmxhVDmtenxmQYGonR/CqLU4zqdzo4hDrcXOk4rLvu0byPj1kqf0PsBMq1jsv30Ne5YNdgNr4frgf+AkLCBHeexuyDq10RRQLlZYVvqqwvVFYeCU8qoBbk6UhGO6qUn6Ejy8xni/WQgCY8Xl+0HTt0cHfewOe2PGM2q/ilN1NdIYYtRyO1dQn1hOsWw/vTuu/gqWsMkH9shRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(44832011)(54906003)(478600001)(7696005)(316002)(41300700001)(6666004)(8936002)(8676002)(26005)(1076003)(4326008)(70206006)(70586007)(6916009)(83380400001)(2906002)(47076005)(336012)(40460700003)(426003)(2616005)(186003)(36860700001)(356005)(81166007)(82740400003)(40480700001)(82310400005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:49:20.6378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0495a9-51ec-4dde-81b2-08db51980790
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

There is no need to use dc_version in the dc_construct_ctx since this
value is copied to dc_ctx->dce_version later. This commit removes the
extra steps.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index adf5d0e1a7c5..f864fd3b6f29 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -857,7 +857,6 @@ static bool dc_construct_ctx(struct dc *dc,
 		const struct dc_init_data *init_params)
 {
 	struct dc_context *dc_ctx;
-	enum dce_version dc_version = DCE_VERSION_UNKNOWN;
 
 	dc_ctx = kzalloc(sizeof(*dc_ctx), GFP_KERNEL);
 	if (!dc_ctx)
@@ -875,8 +874,7 @@ static bool dc_construct_ctx(struct dc *dc,
 
 	/* Create logger */
 
-	dc_version = resource_parse_asic_id(init_params->asic_id);
-	dc_ctx->dce_version = dc_version;
+	dc_ctx->dce_version = resource_parse_asic_id(init_params->asic_id);
 
 	dc_ctx->perf_trace = dc_perf_trace_create();
 	if (!dc_ctx->perf_trace) {
-- 
2.40.0

