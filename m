Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A84C55185
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767762076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KamSdfzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767762076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB1989E32;
	Wed, 22 Apr 2020 22:08:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802F389E08
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2Y0pdVRNO2/2tlLmNl6sd2oT2IHdzezzn2qkjLlwNzBmTXnkZOVTe9jBoUwxa/M8VzCQB0+/fw43oJR+R5i1WVEqMm/FmM3mRZBybsw+0GzmAKDnsndg4wfC8XEK92E9Pc5cR/TL6jkGTOx7O6jE2kw01RSaU6X9Cxrcu0wnF0Y6160NI13/t0AcChocjuEYMffrGpV5iyJrpnNI6OdbKI0JrHuYfiXTgdjwA7ShrIUCpjBfZ5m0Q8Pp5Cd9g+zqr8v11sbjWd8zLfN1gzZY5gv/5aQLipaI+tK25sy4bjNt4sEh039fu3QebTD+giecny2dsxaR3YVDFekIElbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u8UgTbUlRI6IagEMskmrD/2bqTFa/ZtTLI4tNaKfNc=;
 b=IKeadQQdnCnfpHLlFQHDmUD3t1J7Fe0Lrg9l++mkczHrsll8eAAzhvIHGmbITXv+dvRynLjpIZ8YD/3Bh856taGMPxCmkSHqsPZVnwS9efg7mXgnWopAC+9Xfgp25PxSZtJpWDBQ05s31ejpUoSd/+4XCmJpY73iaxQyoZ//GLKQgmh6+pGlECh7GF2f3XZ7WpavaFg9neom9UFt57G/YcMJDOywfu0xjg25mF+dMq4VF1cueD25UIaX/K+lB/X0mlRJRHGmpOKRIg8Qxb5tr1RQrDN5CXznBdl4xbDeAGmvZclX8je1B3s2bXwr5QQVpApOY5DkrLb1M8qYkZJyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u8UgTbUlRI6IagEMskmrD/2bqTFa/ZtTLI4tNaKfNc=;
 b=KamSdfzCv7OokF3nb6G7U5SkrDRHltSX+Nhq6n8AZa/MRFhBMmdm9swAjekr0u2uLynIJu1V1NnRNPkhmA1X9zDkEtAZFUVAAqCzQ0dOiBR+rmuLuY6f1fbjcWxxI6DGRJWrLaK78KAd+PBtsJh/dNcFjgZb7qfxgy8bcvNyyKM=
Received: from MWHPR12CA0042.namprd12.prod.outlook.com (2603:10b6:301:2::28)
 by CY4PR12MB1159.namprd12.prod.outlook.com (2603:10b6:903:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 22 Apr
 2020 22:08:12 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::ca) by MWHPR12CA0042.outlook.office365.com
 (2603:10b6:301:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:12 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:11 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:09 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:08 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/19] drm/amd/display: Do not disable pipe split if mode is
 not supported
Date: Wed, 22 Apr 2020 18:07:48 -0400
Message-ID: <20200422220805.15759-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(428003)(46966005)(86362001)(6916009)(26005)(82740400003)(7696005)(186003)(336012)(82310400002)(36756003)(2906002)(478600001)(70206006)(70586007)(6666004)(356005)(1076003)(2616005)(54906003)(316002)(5660300002)(47076004)(81166007)(4326008)(81156014)(8936002)(8676002)(426003)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d10d860-d0c4-41e5-eafb-08d7e709a5f2
X-MS-TrafficTypeDiagnostic: CY4PR12MB1159:
X-Microsoft-Antispam-PRVS: <CY4PR12MB115999E4882C72BB858206BB8BD20@CY4PR12MB1159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYR1hLOtd0Gb3lRzhvouplrrXJHY/ddWDOFqcWqikem3p9oD4+0jBfHGj/c3KbJHinLACQF90alNoaIljKXygaKDrtdsdjPxQ8wX/H6pXZd1PM7Uuvl2n2BAoQJhNJSvYdl6wkNzJ6H0dYFp3nsiFdJg78jqfvs7o8SqlKk08UzhSAXanWvkf6GcpjovqyzD7RooGOYIXa3gutqbeSfRMQeqh2jLIoQ5XQO0rdYVBWsCGcM/954/i1iRzwNAqZJteLrjX5/tMdkiKfcnZ7deSpacLtUxQ5SH1V3PezFFCEHqMxxz7Tt9KM1FF3PgwXjY7Iw78WA/NmyxgnaWQboNmrRcvmhIQ4dDTi1gL3EemXuFbVMR6g8BF619KCOPiH4oNqpSZQqYp9BdKmC8cpsTqqxKLfgwQA62Uc4BibwLtvh6/D97MNOo7I6qUw6JgQ4ZxJcZnhEBE08bum6UiImiATHzPePPILgc2kXxyeskN11p4g1pOGumOas7x1OM9j9nqx62APIplZPtRGoDmbFjXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:11.9477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d10d860-d0c4-41e5-eafb-08d7e709a5f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1159
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Sung Lee <sung.lee@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
If mode is not supported, pipe split should not be disabled.
This may cause more modes to fail.

[HOW]
Check for mode support before disabling pipe split.

This commit was previously reverted as it was thought to
have problems, but those issues have been resolved.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 63044ae06327..f41fc322d50a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2623,19 +2623,24 @@ int dcn20_validate_apply_pipe_split_flags(
 
 	/* Avoid split loop looks for lowest voltage level that allows most unsplit pipes possible */
 	if (avoid_split) {
+		int max_mpc_comb = context->bw_ctx.dml.vba.maxMpcComb;
+
 		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 			if (!context->res_ctx.pipe_ctx[i].stream)
 				continue;
 
 			for (vlevel_split = vlevel; vlevel <= context->bw_ctx.dml.soc.num_states; vlevel++)
-				if (context->bw_ctx.dml.vba.NoOfDPP[vlevel][0][pipe_idx] == 1)
+				if (context->bw_ctx.dml.vba.NoOfDPP[vlevel][0][pipe_idx] == 1 &&
+						context->bw_ctx.dml.vba.ModeSupport[vlevel][0])
 					break;
 			/* Impossible to not split this pipe */
 			if (vlevel > context->bw_ctx.dml.soc.num_states)
 				vlevel = vlevel_split;
+			else
+				max_mpc_comb = 0;
 			pipe_idx++;
 		}
-		context->bw_ctx.dml.vba.maxMpcComb = 0;
+		context->bw_ctx.dml.vba.maxMpcComb = max_mpc_comb;
 	}
 
 	/* Split loop sets which pipe should be split based on dml outputs and dc flags */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
