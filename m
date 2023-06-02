Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14447C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 09:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A83A10E00B;
	Fri,  2 Jun 2023 09:54:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0695B10E00B
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 09:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKOcFqLuOJSdtTBdoE3RkocIBN/If1NoDhshY6i2+QnwDssipTSfJerRxKJCvCw6y/KROgY/ib2qUSjW0mpQllvVLmGHuEIQ0iF9aCqftlL+eK4Icy3tuwOeuZ3R4Aw4MOnLBziub29cBRz8WjgRWVUtkK2k82LJL5Q0ii6J1jYC5YSb4Q4Jvoylk9jS+4PCqeVQ4NJW1s4L8JNIdtqjgpLzr8G6zBXnEde61WCez/3z0Hkecv5f4fh8K5/C+NB6Nq264ZI9IUJfpmAdyeRMAct/QJxYsyme0UvlxZtRA678h+n113XvLVXK2rB+4iXLdmLzsV0ymnmwffq/PfvM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+i62Sual4+lwrFoTQxCjmiwCeZNRvmNjTR1MuIhXLM=;
 b=M9vqzlxdcZLp/l68a4XGuzm93a8oahMehY4oAvA9lw6KwtVeghRStYjN/E6ao26LGHYC2Gmq5dldTEz86ae7wb7r/fiOrVuDPM8yBGmFd/3CSYPQAJs8akH41NchSRuC5f5q5x3u7eXO2RxPuoQpKfzaMVmOInXxaDbMr6WMNibsLKGRndgheAe8LWDNwKQqwJbf+7hklA2Q9Zjfw/6cFGvy/auhcQroDZVO75WHnc/oyBx8X3wSAvIJa0qUZJ0R5YO2YYNEccR5+H9MOTFkHDXB+kiuSEP/8G4qbSLbSUqtG6C127TMmi6Zi7mPyy0aMG2Z+ZkEx4Gy+MeZ+h0YNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+i62Sual4+lwrFoTQxCjmiwCeZNRvmNjTR1MuIhXLM=;
 b=K+7FabEKbMImTH2Nc0cLAemkoZAqNzhuAOPT87e/KcTN96tcrMfZ+sE2kgBXKJvYG3hKhUa7uX8p2xAqmiQ/3rZOFR9gHq/1/KKO9+jJlYLugUsfo0jtVRc7fm3+cU7lYRv0Qu4NxitELrqKR2UVVTtHDdfvvFVHrrfUExu8c2w=
Received: from DS7PR05CA0098.namprd05.prod.outlook.com (2603:10b6:8:56::8) by
 DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23; Fri, 2 Jun 2023 09:54:04 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::66) by DS7PR05CA0098.outlook.office365.com
 (2603:10b6:8:56::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.11 via Frontend
 Transport; Fri, 2 Jun 2023 09:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 09:54:04 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 04:54:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix dc/dcn20/dcn20_optc.c kdoc
Date: Fri, 2 Jun 2023 15:23:46 +0530
Message-ID: <20230602095346.1603786-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd18803-97f6-45da-a32e-08db634f4ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBL8BJN3nqi+5kQ+zpr80gj4CP1dgJZ93bcJWiI9LNbFJmh3UnnZFXiyF0GRv0+whpIy1sDXdkapwhk03SBtjFIYue7GdcSORlkf77uwRntWRzQ9lt5ldZloDQRp6zBiXYFFxVdPq3jlJ6Mef61rSHk1MzJCkmBrVljjumQhdMzeqeUxIAx5WMYlrKV1nIEpF7O9Y7G5cyAYhyvTnD7xYq0ay3M+PzrK3BXfG0pInAfkKIsuCqZAPUh7o8pvYAmkaPUHLu7J6gy/jq4PiwBkCThZD+T0qO1GhTSF7VahsYH9V2pl1ig/i/CzFOrABgVkoyOrwH0aoHmT+aKkDTlw6BCK/klH/l1P/neHQ/s9rFE5R/XXZtjolJBewBfNF+h0MkfKGZ5eanPw4/J1VHdB5gPJGcON8PC7APABnnfqRrF2SojDqk+n0niI1gtbMDLuZ5cCUAiPhfJkVEuImkpDAFV1fU2VR3lRF0CiIeu71vTQ7z/nxTLxhulpjtpIwbUT3NIVcz4sPqF50XTjCAroRe5eWmNryhnRoY4QEzMX3FFa+5bZje4mVa4ZGD0hyr6f+u4dTggrqseUfzA4R/PNXGlGPx90Nbb0OxZI/lWbbwO/Poafwflvw4+6OutGFK+jLcTX/SvzZx9+7bywUFbK105Zz0kbeHMmOGOLl4eKjEgPE2k5Te8RJfaBnXULhUzyyDUtkX+o4FusoyBzfufdKB5cCwwVS5eLGUhhFvx6GtkyVA1e8SlkM4IzJXiyGev4FrxYk0XV0G/KAZxZ3Qr9WA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(81166007)(82740400003)(36756003)(356005)(86362001)(82310400005)(40460700003)(41300700001)(8936002)(26005)(5660300002)(1076003)(44832011)(40480700001)(186003)(426003)(16526019)(336012)(2616005)(83380400001)(47076005)(316002)(478600001)(70586007)(110136005)(2906002)(7696005)(70206006)(6666004)(54906003)(8676002)(36860700001)(4326008)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 09:54:04.5894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd18803-97f6-45da-a32e-08db634f4ce4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
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

Fix all kdoc warnings in dc/dcn20/dcn20_optc.c:

display/dc/dcn20/dcn20_optc.c:41: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Enable CRTC
display/dc/dcn20/dcn20_optc.c:76: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 *For the below, I'm not sure how your GSL parameters are stored in your
  env,
display/dc/dcn20/dcn20_optc.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * There are (MAX_OPTC+1)/2 gsl groups available for use.

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c   | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index e0edc163d767..d6f095b4555d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -38,8 +38,12 @@
 	optc1->tg_shift->field_name, optc1->tg_mask->field_name
 
 /**
- * Enable CRTC
- * Enable CRTC - call ASIC Control Object to enable Timing generator.
+ * optc2_enable_crtc() - Enable CRTC - call ASIC Control Object to enable Timing generator.
+ *
+ * @optc: timing_generator instance.
+ *
+ * Return: If CRTC is enabled, return true.
+ *
  */
 bool optc2_enable_crtc(struct timing_generator *optc)
 {
@@ -73,15 +77,18 @@ bool optc2_enable_crtc(struct timing_generator *optc)
 }
 
 /**
- *For the below, I'm not sure how your GSL parameters are stored in your env,
- * so I will assume a gsl_params struct for now
+ * optc2_set_gsl() - Assign OTG to GSL groups,
+ *                   set one of the OTGs to be master & rest are slaves
+ *
+ * @optc: timing_generator instance.
+ * @params: pointer to gsl_params
  */
 void optc2_set_gsl(struct timing_generator *optc,
 		   const struct gsl_params *params)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
-/**
+/*
  * There are (MAX_OPTC+1)/2 gsl groups available for use.
  * In each group (assign an OTG to a group by setting OTG_GSLX_EN = 1,
  * set one of the OTGs to be the master (OTG_GSL_MASTER_EN = 1) and the rest are slaves.
-- 
2.25.1

