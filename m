Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0114EC4320E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 01:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5D360E78
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 01:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD5D360E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 467916E459;
	Thu, 26 Aug 2021 01:10:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E84C6E455
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 01:10:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1CrYU9xYU1eK29uR/Duv8gm8sQbbKdSik9ENGVu7vCmKMGKMclnUKa79pcFRl7mb22Xz5BphAXjHina9exA9Vlf42WRVL6A6iLFPCJWErBVcqNANonQrFF0qbEGiJHfJp97Q4juKZOsq6+g/Hv83Mlu/O3j55FqXnQGEUxEBjzaud4NT3i7GnFHGq+lxi/MpMGMbMf4zE3z0WBWrDonOtgR025uFuRv/sA0E1g0ftk8h0RHl4hsac9InG8lTaU0CKrvxRjrUrKVrqfA53BGHMyHraQAHGNR81Tv4JFCNAlG1NzPzIf4FEx5nKrmq1cI4qy7k8bU7RU+emsUwx2G4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1TrZySr8OcVQEzCwHD76GrkHd1CPnw5b+4VsHi+T48=;
 b=i2IBNjev8akFPMQbErdszgUQWew4H+lUvj/zECh5sAmMyxV7qmL0R9cuU9avYa3eQJEag5LfLxC4maYx4LLU7YTGyCyY8yLhmhxTpIC5cUXcaGm0XBNFapDLuhLs9v+qeyPdgjg4b3f4UH+2YuGRccLtjtR3WCFRocRzpWdDAS7ng0imJ13+xrrO8hctn9oY/J1YvEAiGeQd8o9iTkF83sSc/9qgmAv/dZ2vKBJhYzgJYsbyhGn61B9xk8VuR6IHKHw3NGiPAz2uaK5S2nZuPGbVqS3ajgT+4wGs5UBBqA1JpFGnNiq1RLGmwbVyUCiXWvS6+q3Oiqhb0wpj06oe8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1TrZySr8OcVQEzCwHD76GrkHd1CPnw5b+4VsHi+T48=;
 b=493pLG+yjigd5YQjr1DhpnBk3TbKPp/XHvH8tiDuG7GnDM7CR2FSB5SjQSyFmhSkskPoLgcRB7/I746wRCSIOYhoEv7LAJUhzJyxSbjAtlAcG9dd8yZ+vUZvS4yyh09WB05ThXgCCyDtio51N1VJq5qkNJ7Iu4FaR7fAGHQ5EEI=
Received: from MWHPR14CA0052.namprd14.prod.outlook.com (2603:10b6:300:81::14)
 by DM6PR12MB2825.namprd12.prod.outlook.com (2603:10b6:5:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Thu, 26 Aug
 2021 01:10:10 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::8a) by MWHPR14CA0052.outlook.office365.com
 (2603:10b6:300:81::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Thu, 26 Aug 2021 01:10:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 01:10:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 20:10:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 20:10:06 -0500
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 25 Aug 2021 20:10:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <nicholas.kazlauskas@amd.com>,
 <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH 3/4] drm/amd/display: Remove duplicate dml init
Date: Wed, 25 Aug 2021 21:10:01 -0400
Message-ID: <20210826011002.425361-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826011002.425361-1-aurabindo.pillai@amd.com>
References: <20210826011002.425361-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c699f31b-b186-4217-f636-08d9682e3f9d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2825:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28257479FFF9DCCB0B2F034E8BC79@DM6PR12MB2825.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSw1KLn8pIhxr+Hzpe6+kv7UUHTf4quXlpvdhJ60DUd0noBMXYSkr8crqorOwFnMMGMGhxhz/UdPXWJEVOOwNpJXDNv84/Ii0Wt/jXdtRuyGb/Bfv20hUoeuNeLqESVPYTLIlob0KCpoah18PE+pKb2SIRBpcBzWZPbLi1grul5xgRA56I5mvM8HtNFSlPLoXUSQfbcHGzUSuIFtEmjyjmG+pOw55waPKF4Jm53d/koRNeEEE3RgGDvEPxTciV5W3zr3e327hyw7iddnPL5ZutRtxIQ/nSgVZwkIEp8+5yrOA28RewQ0VRbGVsZljqGKcKRNBiX46q+rHF6Ak7kMnzn7YrMP3UatMUtr6QrsKKYK4YSlkChPTv2EGPZYRiM59Y+9XdRLfXlL7GOSAIt5XW+OSr2Iy4Q0xidOC2aWeMcc7U+FfC2NV2bT1qLh+I36tTAN/36MVQamkKL50I7zvyby6DpvmzNlOpa9U5Kr1ZZCR0mPWOWgbjbrsawEiWFCMCQp4j62JnSxxFVafCdGJKxgSJ+OtQvQa3dTFXQbRYzkx7oYN+Y2yip90ZlPrr22zTkbFRkLB6Ywl2P79rsolE5B6TLKaVHkqFWLXh1KGhIdnlkyETev8NtKuwt/Zz5MNybQIho3ARHJVFjqFZaMGuMOgNk20ZWFf7XGbcoBiThjKRmUT7qDNMwxMxdQaiLt/gBVbrQ7UMKe/AUNEDQqEa6GNPeKKqFyDFyQljpcDZnKmVfZWej1UyKUjehWnUm36vUFUTE56GMsEJAJG8DyLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(36840700001)(8936002)(5660300002)(36756003)(8676002)(81166007)(36860700001)(4326008)(54906003)(426003)(1076003)(336012)(26005)(70586007)(70206006)(82740400003)(186003)(478600001)(83380400001)(47076005)(2906002)(6916009)(2616005)(6666004)(44832011)(356005)(316002)(86362001)(82310400003)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 01:10:09.1208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c699f31b-b186-4217-f636-08d9682e3f9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2825
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

[Why & How]
DML is initialized again unnecessarily after its done conditionally.
Remove the duplicate initialization

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 3d2443328345..d090cb916767 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2511,11 +2511,6 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 		if (dc->current_state)
 			dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
 	}
-
-	/* re-init DML with updated bb */
-	dml_init_instance(&dc->dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
-	if (dc->current_state)
-		dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
 }
 
 static const struct resource_funcs dcn30_res_pool_funcs = {
-- 
2.30.2

