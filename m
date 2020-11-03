Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4B0C2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 23:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A9B2467C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 23:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wt5jfRjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A9B2467C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1FB86E90A;
	Tue,  3 Nov 2020 23:12:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 279346E90A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 23:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPcePjXSRz02nCGJmPEr4tlBWHO85rXnFaw49sO425qGzDzuUq7CFfKynOK1j+x1eP+zytxtg+c/694cKwlDLfkYzmnGNueP0AbWRjpyFfl6q0gL+msGnoV0Ru4XKy7ghPsqO1gPSARPmELbSVvOgoX1Y9LKfN3fiaflt+hLq4dP2UjlqR0o2wlgjftWKkRT4aNr/cjSphLlIDyGq/98jw2c6r85t96UqesOT8tfJ07sdxWwYRzo5y8aTKletNLdwRVmwwrLGnrsOkwj8hdxtwk5TfoR548HUz4A4u1u3C79sUY2zsjW/NLtZW4HP8l5SMYKQEFrZpHY5B9FjlU8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C7tFInxnXA3z1iJ/mwG5SpEznr/EkU56bAo1fqdH/g=;
 b=MDG3HM4YTsO0PdlnZYgga9hh7GF0yBGclPZ5Tr2LXH6TdlA9zH7jHdpl7v4houjZCReNl6LoD2StInllYdMBs6nlSWgoCuW3Dxz6Lu7GPSY4WaYtvxmk7h5/CS5u/+7zKHw94+JJZt9GbaVy86XILTKzJoEPXnf/5MgBiIr7QNpFpCXeGngCie0sHbwSNXHyB5GcxAhg7Givzs/i3njwwl887E6hiMAvrJZfRzaQOgcEGr3CJWXclPfmmwTQpW6qERbHUceHnpwyYYpFc0p8AfXbFO8R4AHlFPPaZK8bwMi47cPQC9AlrknB9vOx1FrYyXR6kCEcGE9Ws/FBDywL4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C7tFInxnXA3z1iJ/mwG5SpEznr/EkU56bAo1fqdH/g=;
 b=wt5jfRjBiYdZtSyKLtwiySmI/gtH6ryYlcYYhzZ3LbX8axLuUd6iNr6Zax3Dz5ooceITXNH7VYTAKGvtDl/KqbMh1Ug8FF/TVQCwngaYIEvYRjTQ+Rf0MEibuC8/lyTRrqMIwNqx2ColmVKBl1nl4sTdIW5BHOAwAxQ/d0N+5DQ=
Received: from MWHPR1201CA0005.namprd12.prod.outlook.com
 (2603:10b6:301:4a::15) by DM6PR12MB2746.namprd12.prod.outlook.com
 (2603:10b6:5:41::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Tue, 3 Nov
 2020 23:12:50 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::c) by MWHPR1201CA0005.outlook.office365.com
 (2603:10b6:301:4a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 3 Nov 2020 23:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3520.17 via Frontend Transport; Tue, 3 Nov 2020 23:12:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 3 Nov 2020
 17:12:48 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 3 Nov 2020
 17:12:48 -0600
Received: from roma-vbox.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 3 Nov 2020 17:12:48 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <evan.quan@amd.com>, <Rodrigo.Siqueira@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: fix psr panel lightup
Date: Tue, 3 Nov 2020 18:12:28 -0500
Message-ID: <20201103231228.26376-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06ef3867-098a-4887-5214-08d8804dfbc9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2746:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2746006070D1F13C64ED779C89110@DM6PR12MB2746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+yIPpg9auXDzXyxV3aVLsWDWZzx2xlPMYlBhoV7X7nwN+ycDaL9HL4sAy/9+OOrh8sQosBmN3FWiQZ4sDljxqLGe0YFsjSzafc0rc0CLKCnVSkV7gQyCqVkZEBwAyUzNICRdUlxNZFnSrK77IjH2f9snCXJdIZYlO6pT9xct+1yDknEoF3zOf8Ym/ZlUnXJvFdo6W1d2jerNUrEk8/eSwyZkWfWC0s+BH0aD0smCveR0etCv1AYIw4zVI0dZ+fJpDxKYlhZgIeoWrKCnvxHXpRyFuYYM/rdFm0JNQpPanEKX+e3aYMbyMKs/1l7lwj/VQw3qt1PsY6PeO5boMpK2LeqXCpK0p6hQ6ADXLiEWxlR7X7DK6uLTON3qVZQI9PFJ8w4JEnxDxFAZe35Bs2NtHfD1e22WeZxV3rcwRIb9LI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966005)(47076004)(316002)(356005)(2876002)(186003)(478600001)(86362001)(70206006)(4744005)(5660300002)(36756003)(2906002)(81166007)(82740400003)(70586007)(426003)(26005)(4326008)(8936002)(1076003)(8676002)(6636002)(110136005)(7696005)(6666004)(336012)(83380400001)(2616005)(82310400003)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 23:12:49.6348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ef3867-098a-4887-5214-08d8804dfbc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2746
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
Cc: Roman Li <roman.li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
The change for correct asic type check
caused a psr regression due to incorrect
chip family id for Raven.

[How]
Use correct family id.

Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6b8bc8dde6ea..09b51fca3d44 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2740,7 +2740,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/*skip power down the single pipe since it blocks the cstate*/
-	if ((link->ctx->asic_id.chip_family == FAMILY_AI) &&
+	if ((link->ctx->asic_id.chip_family == FAMILY_RV) &&
 	     ASICREV_IS_RAVEN(link->ctx->asic_id.hw_internal_rev))
 		psr_context->psr_level.bits.SKIP_CRTC_DISABLE = true;
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
