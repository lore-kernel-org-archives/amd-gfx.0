Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44ABC07548
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF8D21D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="plbw0Cwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF8D21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED07B6E948;
	Thu, 10 Sep 2020 13:47:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A7826E945
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh8Xu9mQq1msCV6HkZJOplEC+OkRLD61lNqS2j3AiIGCk46QGyhvq6yuKu9SDhzOCgLllWYLxsefJSOQpeVtGyd2xIwZ63e1DWWokEAbtkodQ0Up/NHGAjnBZqfMZ5UH5ihQkpwkoLxUvGuRveD0B4w87H8HipFG4aIZ49MdVBte7NwJ4II+q66Hyb5ZtwXbHWJf91Y3h16XH10IeoMvHHFu0BETepWe6UVjxhpVmVT4/Cb88+IWgwU1NTqOgA/k10R8yEtplkR3Cpwy+Jp8vcEh3WIMOFkAWZIWR0S8it9GtlvEJYeN6X3V3p3qwdjpPVyd2i+J0f7P7lzVM38W8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNiHBFFlDHOyXY49nIB/vVhO6DuBfxBC2OY/e6Jo4Zc=;
 b=hX39lzCl9hyAESQHIS/Cg32IFx2qP5E+rUAZGPwd03KheoKbG0s195HuRWoHF0qdnGOCDLvvU9YkxQ1hWS+811DR/rES+QyTk67qvcnupK+AEtRGmmei8iDe67ZA1G5nVXOCvxXc9OKVAK0AAIxBkUWLlZgpmERRoPLhkHqrxJfAUAImMjZwOOHFdV5SzyHLh0lzV3JfTyoM3EYMoa6iMCEJoEzvtnFeNcmGogsJhB8kYOi4D+T/oO9T0CLOtDNy128rqkbBdSuOASqnI3q7yBgaszZBMf+OZqWqZFdT23X6Z6Hbvlmlbi+vkrity46BeHjWFB5bnLm90L4yghsUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNiHBFFlDHOyXY49nIB/vVhO6DuBfxBC2OY/e6Jo4Zc=;
 b=plbw0CwxjNmpxtlTLxSd2ZPAxIFAT85OLwQN9wrX/SNiC6guzO3aAiN3dYfoqLnLZAhL+c01mm0FwJX4flaNu1mk1/igb4afLbZ2g5fwHlbeSbUR8bTkXErRnebU/PhrXf6kklu51JAamthHR1MNbmUfWdpOvrXNMWdcrTK7O5g=
Received: from BN6PR2001CA0030.namprd20.prod.outlook.com
 (2603:10b6:405:16::16) by BN8PR12MB3220.namprd12.prod.outlook.com
 (2603:10b6:408:9e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 10 Sep
 2020 13:47:36 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::fe) by BN6PR2001CA0030.outlook.office365.com
 (2603:10b6:405:16::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:36 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:35 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:35 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/42] drm/amd/display: Flip pending check timeout due to
 disabled hubp
Date: Thu, 10 Sep 2020 09:46:58 -0400
Message-ID: <20200910134723.27410-18-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8482928c-6afb-418e-c064-08d85590135d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3220:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3220D08F7464B6BF6F8E9DA98B270@BN8PR12MB3220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RY/YoCRgeS5xC4AroZoJgWZ3RI04iQ7FeWekO9EAbK7oU+d0w7k759lTX044NmbmhLK3Wga9rwd0VN+araxebx+NEXu/jTHiYLpYbgWFevWPI2Ki1Qgzxgo4vuPFTickxt3lV4vsu3A5Le4nY8gvUA+amWvYeSsUPYmXswhctjf0Fqid0/j4JN4yznPlgSeMfgVMeAf2YaS8Yl/mQmE+ehLBKHXEstgQoLQ2xLPNlPELRp+UgxY+5cXt+VJTCzzgjij76fnKDrhAs36wajw3xz6jdd4ZJIGVb6jSTi24qjOY8r4xkJb/EE0E2LHVWLmziMA0OcYACBn5RqcsG1CkJ3VP6WytLmJrUQz3d0vRJrjXpBw6QKVnu6pm3UYIk4q+i/Z7tJVuFSAzXLXNq1LrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966005)(2906002)(186003)(8676002)(8936002)(83380400001)(6666004)(426003)(44832011)(336012)(7696005)(70586007)(81166007)(6916009)(356005)(36756003)(54906003)(5660300002)(26005)(47076004)(82310400003)(82740400003)(478600001)(86362001)(316002)(1076003)(70206006)(2616005)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:36.1058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8482928c-6afb-418e-c064-08d85590135d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3220
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
When pipe locks are being taken we wait for flip pending to clear first.
In some cases the pipe mapping is changed and the pending we're checking
for will never clear.

[How]
Don't check disabled pipes for flip pending.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index cedf359a00f5..db5615a51fea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -734,6 +734,9 @@ bool hubp1_is_flip_pending(struct hubp *hubp)
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
 	struct dc_plane_address earliest_inuse_address;
 
+	if (hubp && hubp->power_gated)
+		return false;
+
 	REG_GET(DCSURF_FLIP_CONTROL,
 			SURFACE_FLIP_PENDING, &flip_pending);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index bb920d0e0b89..368818d2dfc6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -908,6 +908,9 @@ bool hubp2_is_flip_pending(struct hubp *hubp)
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 	struct dc_plane_address earliest_inuse_address;
 
+	if (hubp && hubp->power_gated)
+		return false;
+
 	REG_GET(DCSURF_FLIP_CONTROL,
 			SURFACE_FLIP_PENDING, &flip_pending);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
