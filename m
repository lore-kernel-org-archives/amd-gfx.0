Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D5FC001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110EF10E2E7;
	Wed, 16 Aug 2023 06:51:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A993810E2E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4VUEFA2ublaMcINZPan0ACbR15G9WGA+EKSkjgdJ3sBSI6woFat800thFUF0wB0KEtpISor+mGSIfi3iYaEI3hvQM0hZtVT4f4XrQOHozxWOzGNL5nG3O1ij8hTx5pUanxEFOB6Xta9c/CMwqiaTtPSe9q2Osmt1l0/CG9DuoGIzGiW2lQS7eqzhw8vpmaX6rukj2lU0H/fAiZbS1x5nnuNWuMalC1Uq045HgIIXeTF0no1eAUVc0F6E6YOV9W5Ejj+0jsD+YxictWTV/VW7696yXInDNj10xPuUKVen/tNM7AkTUG5I5nqr5Beq7ltG78RflIgCkatit5SPgTxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCmF8Qtl56e8gQQPZYIEHVPJ+SNnDvgb8mvSqQO0DVg=;
 b=Se8BFr30/UbexIVYrpD+nkt960ciSak1OfGPqPb1WDQHm9s8QKHBbzwrD7dh7dXt4pJBqPBPWowjPRyrkdD7PsYP6UO4p3rbN2YahhxxVkMprp7LoSQ5Tcj1mTHk0Kl/Ai+bKtCicctvJuKd8f5OWBmtFh2yhfM1fpPptwbFeDDyfGGV1kGUyX/a17bLujblswnhHP+HxiMNEhY7u2/yOf628peVBw6fmB+J2wUG2GoA7h5BsGZuJA+OUR6ecPNlnlPHzXoJVlWTtabraWMA09za1Qqxmqe3VX1XzgkImdK4BQLBAAaaSwqXwqaaWHAnWupXo91sVm/UJ5HZxgO31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCmF8Qtl56e8gQQPZYIEHVPJ+SNnDvgb8mvSqQO0DVg=;
 b=HVtcwEN0pN1GokQ8mgfX70GR/DAyZK2mubaX3Xj5OwQWtut6KtPSLPscpQcAfL0+4N4RYsZqyKMqj+SDznQ9U2gsRMZt8eSWfb+PLFrkYPbnc8JW2gNt+Qh0alu/55Opfc0xmUPeiwkcKBUBN/xwu69luKDL+/2E9ILqCTnlsYw=
Received: from MW4PR03CA0213.namprd03.prod.outlook.com (2603:10b6:303:b9::8)
 by CH2PR12MB4874.namprd12.prod.outlook.com (2603:10b6:610:64::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 06:51:39 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::9d) by MW4PR03CA0213.outlook.office365.com
 (2603:10b6:303:b9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 06:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 06:51:39 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:51:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 "Hamza Mahfooz" <hamza.mahfooz@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Fix useless else if in
 display_mode_vba_util_32.c
Date: Wed, 16 Aug 2023 12:21:09 +0530
Message-ID: <20230816065109.697657-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CH2PR12MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fda048-3138-41cc-df54-08db9e253de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HKwyLB1mIDafeKYGt2wcCevE7Zs9Fh5pm+NbQfKSiFnp8xcD5nEdeyqWXxeMq4ughhiMh+3PIUlVbCRU04cYlHj186fMVIEWhMHTz0f/zPiIsvUoELdUfGsu4p9ICcZXb8J1VtIHDkBHGQUe7SqhPohdVj5lry0V5Za+ev1o6b3PqK4ot+piXuCfflXNLwAlxIGOangIVy+bDEaJCtBnVfbqGrXtvkms+ErXsEEXgAGbMvF8gwHhQ2KododiR/32DCUV6jfLRJqSKGn8ZcxC/R/0bF6NAcABpbq2Fmp2nnU20DZ8MuhPfNonzEkGEMPC4n9BOBEF45aZxkrBGwa/WYU0DFiR1s2z4cvZYGTPBJcs4553jwj2dS8GobfjivB1QNoru0Z0Vwq0Ijkt9PrjselxQgClBCPzkAkfJX09/Y83HOJ2a2+yOi9MvzyC7BWGjW7hakVw20LUy63zOPR2czMPU2KvDzq3Az0eilLR5PeEEVeRCkqsLXknYCsvmXgAP1UoEAhp+eSh1w39k68R2hqldzSQbkmtnIFnFNHlxTFkqEbi3Qwyg2FzMRS1OJ28pAFUNbaINCBfSZX3BH/wao2wnXQNncfSgoqrUSxuXv+NUDlZuYQ2jFK14WHQTK5IDZhguJRnyb7fyoXW2BF2o6sK7HThR0S9YxhQt55F5WLXuNF+AxuehNV0sXfQqNy+h8UjiGhfcgPCJF/2QSxF/5H7Ksi1l+cC4cOAJuwL+Etb1Jn1IVPV6Klwt1mYvP99BBFqx3eoV68i6h6POr6DhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(16526019)(1076003)(336012)(426003)(26005)(110136005)(5660300002)(2616005)(83380400001)(6636002)(41300700001)(316002)(66574015)(47076005)(44832011)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:51:39.1038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fda048-3138-41cc-df54-08db9e253de4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4874
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The assignment of the else if and else branches is the same, so the else if
here is redundant, hence removed it.

Fixes the below:

drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c:4664:8-10: WARNING: possible condition with no effect (if == else)

Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index ecea008f19d3..d940dfa5ae43 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -4661,10 +4661,6 @@ void dml32_CalculateMinAndMaxPrefetchMode(
 	} else if (AllowForPStateChangeOrStutterInVBlankFinal == dm_prefetch_support_uclk_fclk_and_stutter) {
 		*MinPrefetchMode = 0;
 		*MaxPrefetchMode = 0;
-	} else if (AllowForPStateChangeOrStutterInVBlankFinal ==
-			dm_prefetch_support_uclk_fclk_and_stutter_if_possible) {
-		*MinPrefetchMode = 0;
-		*MaxPrefetchMode = 3;
 	} else {
 		*MinPrefetchMode = 0;
 		*MaxPrefetchMode = 3;
-- 
2.25.1

