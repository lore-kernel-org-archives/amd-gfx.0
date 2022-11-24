Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C159DC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E7210E27D;
	Thu, 24 Nov 2022 21:14:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E26610E26E
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX3GARfz9sTBbcChi9tDPTPDi2buUYOuhYEEit8yaNm5csON9fOfixNYxmBJsr0UToLT4uzVJ+q44wbzi7Zy33Ga2ETFtWfoPBtMeud755NA3+8YX+MVmia/VE13Wfs9LEQQlmQOUcQ3wsKh4rtyjHICQJV6AWP3ARMBg7c4DcKkc/q8HmDaqHSS23xQMqR9y8CB1aC/WSBpKC0UwOTXOC5/RSG1jAQRZeljzj46xnCTyKZblwJoTWpS2AP9IR5BavAGCoqxORWjl9vOAvn/z9DwscFlaK6fOq1Dm5amyp4v/kKYU8N66gipDGqv634Wu6aXZpqm9y3VR372PebD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJE68J94MUkKdaLhsV9fFk8sxNUQJmJYw8Djq4PxXZs=;
 b=ZFAaIWIcRGPH0BWuJy8mkI8s/p1Ve8Tg3bsp3jkLoFrShQORwleCOvtg9RFfLQwt4SxXPyGZXyp1zNaDevyX9f9Mb8f1DIwytu4008NrNvukMfijdvCX66dw4/3CINYZx94N3iIoKJD1HO/BKXucTA21NpxWu4kOUKT5ohXfPpv45G0f0MgbJRG69yHJ5epSiXGXuC6D7p12I93vRWg/iWwVELV29J5JUuD0PoSs9FHf3JApP7aOcFUEr6smYcG5rSJXjggdYC1/MXpUYS8DtHL+CRkqHBZVCUU8JNnwhDDnuaLbSGDx1KtOuSdQ/PV1pFzrwKZd7haJgT07TuYNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJE68J94MUkKdaLhsV9fFk8sxNUQJmJYw8Djq4PxXZs=;
 b=Qo4QCvVEiW47MZHpGLUO1WDqjgGiYw8aT18q7mOq5KdJ1/c0c3Ohr14/JLwp+u7ASTdHk8/tIkNPiaXIc9TiyU+h2v5eDtf4weT1aZrHNojbmI3yMnAc4j/siExNtQpqWbJ54Qw9qVWEgxusZdvc4dwDg6Vo/iSC4P09CbLQoeI=
Received: from BN0PR04CA0100.namprd04.prod.outlook.com (2603:10b6:408:ec::15)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 21:14:10 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::35) by BN0PR04CA0100.outlook.office365.com
 (2603:10b6:408:ec::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 21:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 24 Nov 2022 21:14:09 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 24 Nov 2022 15:14:07 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amd/display: program output tf when required
Date: Thu, 24 Nov 2022 16:13:44 -0500
Message-ID: <20221124211348.214136-9-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124211348.214136-1-jdhillon@amd.com>
References: <20221124211348.214136-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ce91a2-f76b-4ae2-6b1d-08dace60d417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTj0SXdPaMrfSiO5Kd1pkHpD3Pq2HYnk55cO+fihcBtnBguPjpqbYlqvCj4nLDqEoCV6msHxY0CJXiIZ6RYH9gwG3JxNtY4uqmIMZE5tCgcIe21owFwfjjPwJp41q/XCqldGDtmCKxFRFunBjs/8rA9yEl8soC8/4hfVKf4m3P20C9LlgcCwlHzAk00P1hmlk3y5cPrUbD3M+BlBaRiTj6thEFPq0o3uvoQQoQoSeEkCyZKBRQg6liT5+iuwMgo6ujNTkdfp0WV26dFnBilqs+7KgWZsCwtnZg4IqPRSx0kgvzv75aTlEcwmLg/IA1JwuEuhL91nfhapNspEro/rma6+49uvks1jTSEsDl1VK8bSP9u3n6xPMLTYVIwcGEg+m4LV2x9+RH3G6K1/5N4dboyzjQIuImaXYWQdHm6jpiSY7ud+BVlFepByPkwm64/JBEF1mnAeBFR0oCjyGS99xiYmyXGlNyNvPm15kOshrhBKhFi4zAKYHbMOLroFqU5G5rHP2gF7rlwESUAg2nEo/nj1Prv2+kpisFKtm/4C08prSE7PugNHNTxFXr1FDTE+UGOkFKupw7YLbis49mVqrZh88lerTFBakkkcvE93Nog/4pX/aAcsL8c24S2uYoiEJICaOwj0KtDBnhysRFnAspa40z6u5FtiJW/LONTtgR5qc8Ps4Bx7FMPyaMtwxIiS3bFPxJeiHm4oRY0+0GzCfCuIxGWW5EMzuy3TyCu1bYc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(47076005)(83380400001)(426003)(336012)(40460700003)(54906003)(6916009)(6666004)(40480700001)(81166007)(356005)(36756003)(82740400003)(36860700001)(82310400005)(1076003)(2616005)(16526019)(186003)(5660300002)(26005)(478600001)(8676002)(70206006)(316002)(70586007)(2906002)(41300700001)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:14:09.6364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ce91a2-f76b-4ae2-6b1d-08dace60d417
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Description]
Output transfer function must be programmed per pipe as part of a front end
update when the plane changes, or output transfer function changes for a
given plane.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index db57b17061ae..bc4a303cd864 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1741,7 +1741,10 @@ static void dcn20_program_pipe(
 	 * only do gamma programming for powering on, internal memcmp to avoid
 	 * updating on slave planes
 	 */
-	if (pipe_ctx->update_flags.bits.enable || pipe_ctx->stream->update_flags.bits.out_tf)
+	if (pipe_ctx->update_flags.bits.enable ||
+			pipe_ctx->update_flags.bits.plane_changed ||
+			pipe_ctx->stream->update_flags.bits.out_tf ||
+			pipe_ctx->plane_state->update_flags.bits.output_tf_change)
 		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
 
 	/* If the pipe has been enabled or has a different opp, we
-- 
2.34.1

