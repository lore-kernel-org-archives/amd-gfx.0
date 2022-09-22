Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8934AC32771
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9034010E9F6;
	Thu, 22 Sep 2022 00:19:13 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4795110E9F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBA1VIBVuWFwkjK6ZQ7gpqpJAD8ABQerJQCUQRBRiwI1oV+UrrXzyv3xmyB0rSiYRGCiBB417DZmwsiBWYLbqiFHDmQvt5WreVCh0nnJ2K7yFDC7vO5VphM4XMFkuJro5FoEwG0lxHKGc7YyomIaSHQPC4/C1DfHRf60bZGVx2q136qk7JTZEWhnR1RSISh2DF7aZp5xMHDj97fXRFKwjTU3PBTHO3EeL1QuI0EO1ctbAEc2r5jlp+6JQHvv1eOZv2wvrjnRtGWFpWkpKfus0kGLMy8n+cXDju4enwHsdhATJhTTDekSYA/vZlRT7fImgWsEt5wqA1JW8vA+euYZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln97hpwJe1UL4kTpzojJ92svvrwtJlvGcskIbbQktw0=;
 b=oe3EzfpmZXEyr6u253j1kPvbvs96MH6DUyUFoVTZ+L9Fi9eOnxU3v3vUavwysK/2URQlOTy8dXXF0HLzco1E8tJ8gkBPX+SDtACooGvAa+BGvU/kHQRh/bmnzy+A3ua2Ea9ssQmKLeJlssz6fSSETNKfvqwZedUTAk0yBXvnmysndeot+mOyTtexNbWfDe53AejHOvW+zoNE90bN7tMyUkU2NVQd5mM1CvVW6QLWDrFkoURyQUEvGy+00DnGKC5kTEkCYeGzcsMLknAlYmZEJuH7+KxLrCCNH87RJsjiY6n4GD4NaVU1hTxSt1xCzKirIrP9ipAecfiuoQSij+/iUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln97hpwJe1UL4kTpzojJ92svvrwtJlvGcskIbbQktw0=;
 b=zxxrnpItWKkQ/FmIor6UjU75bl0J6SYK4OqIZclDX+JO+U0xoR9rbxM0xpyYB8OyIEeyWHgbr46XiMpuL1obOdEgTdA26OX+B2MhScAtoAkhuG8dCZ5/575KkeVBDOqO0Sb+JvRFMgU92D/N3cH48BtAxfCD2Brg1zblrSJupt8=
Received: from BN9PR03CA0228.namprd03.prod.outlook.com (2603:10b6:408:f8::23)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 00:19:00 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::37) by BN9PR03CA0228.outlook.office365.com
 (2603:10b6:408:f8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 00:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:18:59 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:18:55 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/31] drm/amd/display: skip phantom pipes when checking for
 pending flip
Date: Wed, 21 Sep 2022 20:18:00 -0400
Message-ID: <20220922001821.320255-11-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: ae85804e-e653-4f20-6f96-08da9c300bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TaHmdGEU/9G+0U0opothpbHMODjZbegNfaAAXz6tsBvxEXjXV93rCjENiEHL0X4vwCriSXv/28qSoPW7qPU8NK6scLirSaAThDCMr/2TW9vLRhMX57xIdGHSldL6EQeUEEfMlfg3BXf3aDQ4AlzS3nanzSQLAGeTaZQpbVNYypBJTZAPo+VT/t70DHG1nJStzkAzPNbNYD8mA78yLwrrLKQ+EOSk/JxtdpDSIqJaSCtQPPwoLJHYvmXrrzskZwRvCtnPwfTbMaLN4aJ0iF9Dt4lJiY9WR8s48Aj/Rk0KRIOn5hf7BIRnpfAhUhs/57NUMQ0W7mwxKlCDmdNXCaH6W+mIGNB3IG19yxoxut4N3TLYFqRmxYaapjXl38Zbx89SqDF8cT3EOHhCk61yeOMRAShUTJsU08g4R/H1zO9on/GfqDu4c72khb9DtVkK+1TjPVcmxg1JJwsDzDTK/dRH01vhRlUy/rbgLvqPMatAXO6cHQHL+nPCBXXkBP3gB4p3d/BxHS19uCHMihmXv9RpveleWpBpryJvgzpPW2M3KfNT6x87tEYC8Wwu1rFTr2wiwUH1ewcbg/9iR6f6rj8ZcIed4MWMreWMDT0CDwg+ZPHOrpljfZ5I8floBHWfMYGmNDnl3faUCebEIns1zPf0mUSoAvSRlpf7mJ612Sa3crAryJuQeFdpDXRspHcKHxhfALFrOnunJCwwuFcGeGnfHogdjuCcBrIngxpdUgzNpM4QDdj+ZOwA/IxLcKpExzOvws36wIWHaACA7KaquQnF+kf+t1jI3p+gi8bbNLpgpw3X6QvfoQA6PIPxXmDs2OJ2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(478600001)(4326008)(36756003)(41300700001)(5660300002)(8936002)(54906003)(8676002)(316002)(70586007)(70206006)(6916009)(82310400005)(356005)(81166007)(36860700001)(40480700001)(82740400003)(26005)(2616005)(426003)(6666004)(40460700003)(186003)(1076003)(16526019)(336012)(83380400001)(47076005)(2906002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:18:59.6556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae85804e-e653-4f20-6f96-08da9c300bd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Phantom pipes are not programmed fully to hardware and hence we should
not expect a flip completion.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 351888fe9b72..b5ad0bf4135a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1201,7 +1201,7 @@ static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 		int count = 0;
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (!pipe->plane_state)
+		if (!pipe->plane_state || pipe->stream->mall_stream_config.type == SUBVP_PHANTOM)
 			continue;
 
 		/* Timeout 100 ms */
-- 
2.25.1

