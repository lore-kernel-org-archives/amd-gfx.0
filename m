Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32CDC4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B19560E95
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B19560E95
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AEED6FC20;
	Sat, 24 Jul 2021 04:10:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E3F6FC20
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 04:10:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBXlj9c0qFIz/bIy6IZqOdoZC0/L5ODlJBmgqbE+tOOM5M0/8TVxrJik5ap0BOfkJb6JZ5WfDUfO6gkeKo8sXEO8QJIKdzMUiqOCdULEEaUxGegb63V0Huv+V8TEXK+avTBjiu6lb4cg5NGEAjVPGA02ZEsc6xTsMJp0iNJC7NUZCy8yGlNznN7D7nHRZGgTUBFjoNJJtDR/k7l7Z6wNiW1AQ+wIBqBHX5qGPPI/qddUyzywUpU+1Rs65BMq528Wh1D4ggW8WDmFqKX3ZpIEQ2gU7NNiF7jumiYUVB3aEOT6mldDgiX9JGny61XtyrIohFLovz4HmOsyaTP4EjDdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjJWIpWo48XVHVZCLB2uhiNP0Zvoxj9B5d7rMVGqAeM=;
 b=cKJw4bB/fRw4QKvl66QoaEvSeRSyg0AeoNZ/3niBmsXIKrghYwc2Al4sVCOFXQ206QuRD2vZDxBGNVm1M6S1Z/GXpHR/g4g5r6qa1EU+WcqEGkjqOUqgsEahQ+/KXcWnGAk0SDqXkahQDXkryPntweMs0dg+1nd8oSmF7GzFB23DpTAg4ps4SvqOx/6P0uaYeXkGyaV9KvQnKAwEMF5CSV/Awp2nS7ZH5+DVodHruKwFE/ou2AWT8nnZQhuO8pMEgpqIC48Qo8onhm/HF5kzYlsflf3BR3KW1yVGfPwxxc8zF9VItdZHVrSXE34Y0HrjfMPg6NIwpPay+lK3TPGF5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjJWIpWo48XVHVZCLB2uhiNP0Zvoxj9B5d7rMVGqAeM=;
 b=RV95F5WBw6JJG409E3swmuTRAr+z83qxnvBO0YTJi2vXc+DBu1rBJtvVJOT1nG4wLjUZtlRmAmD7cs9N9AWdKQ10bmBR4Yjt9CnWdrJ2vMuPJmKE63XyeT2x5vzzFNdcGL1TLntyG3i7HWjYRq245QjnI/3Aq4LkMLo+K3dzCQA=
Received: from BN6PR16CA0026.namprd16.prod.outlook.com (2603:10b6:405:14::12)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:38a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Sat, 24 Jul
 2021 04:10:52 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::50) by BN6PR16CA0026.outlook.office365.com
 (2603:10b6:405:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Sat, 24 Jul 2021 04:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 04:10:52 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 23:10:49 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amd/display: Add ETW log to dmub_psr_get_state
Date: Sat, 24 Jul 2021 12:09:52 +0800
Message-ID: <20210724041001.3875757-6-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724041001.3875757-4-solomon.chiu@amd.com>
References: <20210724041001.3875757-4-solomon.chiu@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 647b5b14-100b-44e8-9f79-08d94e5906ee
X-MS-TrafficTypeDiagnostic: DM4PR12MB5055:
X-Microsoft-Antispam-PRVS: <DM4PR12MB50554DCCA9F6DBF1845542CD97E69@DM4PR12MB5055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndjw11RPgTwBgRl15Qkhm5re3l80UlJwEzHO05D5S5yDETQ6DzvKNGWW3ipetcEj9zOPtXlOPyIiKw4DmC8MnNpiCM9A2AiLG+Mxd0xWCuR+uc6l7ovDj5yjjxDgRzMJjicOo5+bsKPV+8yxxjvQOo0t0nEifC9KBlxPbm0PDFd+zbo76iLBEt5TbjKcrcFn4Y1VbTqcMp0j5KNQGZWHu+08rCVD4iwY5xj3NfSMtODlbEwlWJLtY5Tej+x9M2xDfPJvyA5zelPdEb+ZBHtWkth02bz0r/xGic1S6WgD4yLYArgQwUrwykTDJYvvSZ+eYqijQFsofji9l6Zb20g3RHC4w7TFyucrKciFQ8iWtdvy4PHId4+jFJyVOMQDrxO4F6Mp5RtJjyPWXDKleZIRm09na4i+KRK9yI5/sAb5AMuZiy3RbfXya1ML3tlK0BWcRDrQOAPmQ+wPLeK9wzPboiudFP6DLv9CQK01rOXCXCu67Gl60wZqnfHFjHfa+orddQxpwjWInkNuGT3WM8zGc0uzpe/L0Bo8hSwTeNxQb/unXuSchAjFjOxT1236RcXYVOLVsuhi6lLLM3ZYmRDw1RDqDqq5qgP7+ZrjbGuIYMUdwqGOlue1g7DWHVyoOihkDuaSiy1jH+Ax7N9YAyohsjOm0sVllCnRGA7tld5irS+CaaDGLEvUzRXds/Ocqh3SqbvoXVtC0S32ZlqbTE2opLwGtaeMf4LMrFxvuw27164=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966006)(36840700001)(4326008)(16526019)(186003)(8936002)(70206006)(6916009)(478600001)(82740400003)(86362001)(82310400003)(44832011)(356005)(70586007)(6666004)(5660300002)(54906003)(36860700001)(83380400001)(336012)(316002)(1076003)(47076005)(2906002)(8676002)(26005)(2616005)(81166007)(426003)(36756003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 04:10:52.4463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647b5b14-100b-44e8-9f79-08d94e5906ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
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
Cc: Koo Anthony <Anthony.Koo@amd.com>, Solomon Chiu <solomon.chiu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
GPINT commands have the lowest priority in DMCUB, so it's possible
that the command isn't processed in time.

[How]
Add a log to help identify this case.

Reviewed-by: Koo Anthony <Anthony.Koo@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 3428334c6c57..1ca8b1d94bc2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -29,6 +29,8 @@
 #include "dmub/dmub_srv.h"
 #include "core_types.h"
 
+#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
+
 #define MAX_PIPES 6
 
 /*
@@ -96,10 +98,19 @@ static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state,
 			// Return invalid state when GPINT times out
 			*state = PSR_STATE_INVALID;
 
-		// Assert if max retry hit
-		if (retry_count >= 1000)
-			ASSERT(0);
 	} while (++retry_count <= 1000 && *state == PSR_STATE_INVALID);
+
+	// Assert if max retry hit
+	if (retry_count >= 1000 && *state == PSR_STATE_INVALID) {
+		ASSERT(0);
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+				WPP_BIT_FLAG_Firmware_PsrState,
+				"Unable to get PSR state from FW.");
+	} else
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_VERBOSE,
+				WPP_BIT_FLAG_Firmware_PsrState,
+				"Got PSR state from FW. PSR state: %d, Retry count: %d",
+				*state, retry_count);
 }
 
 /*
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
