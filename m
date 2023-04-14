Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A84C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E6F10EDB4;
	Fri, 14 Apr 2023 15:53:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9565F10EDB4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJmbM0WLs7Cx+DEeht3Frdvp9uHe0hM3po3UPj8o/74vvb/Z/epcQc60GErs0PW2p5dYb8ddzAq9eVpyFkZnf9HzVHuMm9NpAabZ2di/c0XUqJO20iok2klNPRgvNEcv+GX0ugQcDP1iIGOpLwGzawsPzShlYfETKwpDCHmVtk6p/f/fdhbSg6ohzkkmEukTxGfNlR0n3199/bdXbBJUkYWqP9d3yUeJchYzlLrleWlXj89eS00505ApMU4VHQdfKPvHTN7XdoEEjqWjMY7nICbgpuYY5Hc062RVd5j/pzL42Y9rBSbMI9iN8EIjziPvnb7FRPqP90ExsJ3OK/QuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZp8IHxqQ1CcAHCP6X2K8o6VCyRDf0CeC6WTuWN18fs=;
 b=J8fcJWTWZk8WSuHe0lkVtt9db0jBx4wtORKBrZr8ha8EcSqr/h9uXIMhP4442KOGMqAZQ9bxo3okR6yWAiqc9pkAuZEv5N/dEl8veJEdTsZioKtz+bCZh8fQnOHmB95lp9gDLq4/p+D083uIyhqmvv2pfUiRA+dIHVzgCVuPX0/WwpaiIUQgRlQmXmg5uyq7heb7kgTVpK+1k2YZk5MVZlAz4ayekrsM+Uq4xpsN2kwA7fC760npomVi5mmi76MeA2pBv0lQAkjDvC9D8HPKGYCUcRH56QNXKDu9zDv+YskKCpW2JIXPQpg/Hl7fUogBHdrYaAhpFOhwnrSuT15aOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZp8IHxqQ1CcAHCP6X2K8o6VCyRDf0CeC6WTuWN18fs=;
 b=Oas1YfxWRoVda0J7ZSNet+mG9q/x4QGhjRdKeDZJxLG1zKYLIwtwrmuVATYKr1+n5dNjy38iEeyNJYKDf8wC4k+n7+N11qvvZqfMLO73zj/q7uEK7OO9eqGAm/roPvlDAbbLPEGhALp2yD8NGBpi7FwqkwlT+Nlm3ZikcpTerAg=
Received: from DM6PR05CA0042.namprd05.prod.outlook.com (2603:10b6:5:335::11)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:53:55 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::29) by DM6PR05CA0042.outlook.office365.com
 (2603:10b6:5:335::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.11 via Frontend
 Transport; Fri, 14 Apr 2023 15:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:53:54 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:53:52 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/66] drm/amd/display: Set dp_rate to dm_dp_rate_na by default
Date: Fri, 14 Apr 2023 11:52:29 -0400
Message-ID: <20230414155330.5215-6-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|SA0PR12MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: 41185364-aa4f-42fe-cda3-08db3d00735d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Em1y1F5+Twt8PQFyU7somXSPIqxpXlQlUFUtuqL07aAt+Dbvzil1aZYXozQzrrk+xM4CLcheEIJg/5G23k+GadAqp3NR3RgkqvyKjioU4P5W4raF3lxRls2YpcWdYEAtHDYk5rps/Pf5r+RUNXJCSDKF9OZeo9un2t8Z3LAZmGWC6cYfsplmhrkcerkxt+pcIZzhPY1GccKuTjN7Wi1UBD/huLXBoTuR2htEx99F7nAOHkP/bFQewN4ZfsRbZZbgL3njq014uoMs1fTOG7u0LiaBfOADpfl1ZDZsp/lhvlyOuWN748LQkHtU5tm0qHsubKTuj0Ef+zxxWH8Q6sOGcDrOb3c4JUKU7A53CW1gR59C4+I7LMD9WsomtA8uJwr21mc3j+VRSeBSm0A/y9ice0W5hbTTaCoQlLA2/dTXUms1+TrSPNnScDyeeV2UYX96Fh8hWxU0ayr+jrWmJ9wxlSsk0egBE9wwHsxIYsQmnOXzJ1TgeUTvPKxI48pzGyDbxWb0oZ5UvwMZN1ugJWyDTYoDlFcHSQ8ETS/wnq/epktKF72aeRZ9XP6uyOksQGrMqyri3Riolz3TX9e3Kh9/rd31aDDiBwNtauFmraCKO9a8QzkyyEmFu6zXg+dEXeDI2KIbZlc1bbMO90yFgu0SIvy3muxMko1ecsaM+X0UiBHX150LYs9WdlP2BgMBGlFAhceKBUMGBHgYs4PdpbU40VpT/MTPosP7V5ZvtgI5XnQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(316002)(41300700001)(1076003)(81166007)(26005)(6666004)(186003)(86362001)(47076005)(2616005)(16526019)(356005)(82310400005)(36860700001)(426003)(36756003)(82740400003)(83380400001)(40480700001)(6916009)(4326008)(336012)(54906003)(70586007)(478600001)(8676002)(70206006)(8936002)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:53:54.7097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41185364-aa4f-42fe-cda3-08db3d00735d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index b79014f04cef..9fadac1b4c64 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1300,8 +1300,7 @@ int dcn20_populate_dml_pipes_from_context(struct dc *dc,
 			pipes[pipe_cnt].pipe.dest.pixel_rate_mhz *= 2;
 		pipes[pipe_cnt].pipe.dest.otg_inst = res_ctx->pipe_ctx[i].stream_res.tg->inst;
 		pipes[pipe_cnt].dout.dp_lanes = 4;
-		if (res_ctx->pipe_ctx[i].stream->link)
-			pipes[pipe_cnt].dout.dp_rate = dm_dp_rate_na;
+		pipes[pipe_cnt].dout.dp_rate = dm_dp_rate_na;
 		pipes[pipe_cnt].dout.is_virtual = 0;
 		pipes[pipe_cnt].pipe.dest.vtotal_min = res_ctx->pipe_ctx[i].stream->adjust.v_total_min;
 		pipes[pipe_cnt].pipe.dest.vtotal_max = res_ctx->pipe_ctx[i].stream->adjust.v_total_max;
-- 
2.34.1

