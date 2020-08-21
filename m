Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F30C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 08:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F57207DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 08:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WnhXFmPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F57207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A4626E101;
	Fri, 21 Aug 2020 08:36:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2CE26E101
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 08:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPbFWL5XerpdcP6sFxWWxnE9piiyK0cSftBzZ1hC2Nj/3pInIeErb4lho/6oD5PgcdJTsQFL6bN7TNAtNZ5NySj3GdGip51FcQL2ZbEbMu+XxorM+uDjyJ1FkiOhb1tXmBE7PYh+c/bsseEVO7ARoOEZDdE3U9nxIlLfUYZ130oOL9vAlMwe0B2bq7Eky08t7KBqDobRV5Wg2D7JBJE7WkOhebsfB0arKbGMlNScjy1kRqR21nJgvmrVCiBNN/q3p6xKj6ck2HvIc5UYE283wpKS7ty2YjCAWao4tMYXGolmjEfP7LsK+Y+s0zkuwBs1/SZd4dNEDaLM7cSTMPySTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOkgEO6T7eZ3fMKm7smtHRnDcAUa0z//OS8Ob16po8Q=;
 b=CiO0rKOHXXEtwm0Z3K4E9bK3jVNkRHGLaeuGO4mq8EfqfUKrimX8R6wYYu1nupYS1tnmgeFjMHvlPUJtAxlD8L8T6UFsjZkOYSF/mJIuW05HjqZauQ/hjWO0YjGZDrvGHv5vIAEatBaGeSE5kE/qMvjldi+fg1Zs+tsqCycmWrOv7z3EXB5yo2ebeIJp0Jxg0HuxMnLXeL7wcA5SmG5SDixZW9bNN+Gm1DneH4TieNxmjP2el914OsopHAo6a6MueS5IJabZHf8JbNLqC1qTq0nReM0TI7+XiTzcTB3wJbSQAFA3f2Rl0XPkRXAhb+O0pYF45npxYewWrJHJ/N66Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOkgEO6T7eZ3fMKm7smtHRnDcAUa0z//OS8Ob16po8Q=;
 b=WnhXFmPtO93kS2xOSeUshXQ3FPipsSn3GxBnPDlUORFyJpvwHIM6SdMOqUw3/yA0K8gpR3sdBiKrR1FNzK1FVxBKnllEflH/b+Vz6kEiYKjuTRfSgWzIJnqFrg8ExV9n1svfpNhEZF6vy4Ciw6KKZ1T14YDGoGG4NvqxEOPJsLE=
Received: from CO2PR05CA0086.namprd05.prod.outlook.com (2603:10b6:104:1::12)
 by MWHPR1201MB2493.namprd12.prod.outlook.com (2603:10b6:300:ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 21 Aug
 2020 08:36:04 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::49) by CO2PR05CA0086.outlook.office365.com
 (2603:10b6:104:1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Fri, 21 Aug 2020 08:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 08:36:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 03:36:04 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 03:36:03 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 21 Aug 2020 03:36:02 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: set VCN pg per instances
Date: Fri, 21 Aug 2020 16:35:39 +0800
Message-ID: <20200821083539.9506-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5207f08-68d2-4177-f10c-08d845ad3e1d
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2493:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2493B344D9835F6B7B844DA2EA5B0@MWHPR1201MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Pr+b+Qaa6xxsXyGn9BhkfoA9+wLYMHNybQQA0MCPGzjk2uZTuI7xMus7YcmtuaYRliTVLElmGYSDCNMn4dLmAB0nt7RPN+GbpxNZlO9VNFzDggy8Q4oFph1greFB6k1SGSmNfIoASCQ6vqWX6Du6qRQt9hm2GbxDHEDKfUjc7O8gtmDp+z6s7ki4XMikiplYVrgqrsKhUQsPubcNsKKRZjvPC5zk57kRN7X8YzcRZziIyHT8W2BcSvQJ9J2gNWMO1zHLTyo9SaLO2pjXu1Ci/FVQY5ZEU434ME8fMpD7RJgLcxyaTjkIfllBVPy6gLl4lLZb51GFc6twCrs1DTxAJP+u8biSLgzmD7V7F5bNvX16e1fWyZOszoqxPFOvo2hFeegSPSiPh2lEbVhumWMAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966005)(26005)(316002)(186003)(70206006)(336012)(5660300002)(426003)(82740400003)(47076004)(7696005)(86362001)(4326008)(478600001)(70586007)(36756003)(8676002)(82310400002)(81166007)(2906002)(2616005)(54906003)(6916009)(1076003)(356005)(6666004)(83380400001)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 08:36:04.5184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5207f08-68d2-4177-f10c-08d845ad3e1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2493
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
Cc: lijo.lazar@amd.com, tao.zhou1@amd.com,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When deciding whether to set pg for vcn1, instances
number is more generic than chip name.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I5bf3f024ac499c347e3ea72563ae75e4a540f321
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d2320ce7ef0d..66d655958a78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -783,7 +783,7 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enabl
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
 			if (ret)
 				return ret;
-			if (adev->asic_type == CHIP_SIENNA_CICHLID) {
+			if (adev->vcn.num_vcn_inst > 1) {
 				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn,
 								  0x10000, NULL);
 				if (ret)
@@ -795,7 +795,7 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enabl
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
 			if (ret)
 				return ret;
-			if (adev->asic_type == CHIP_SIENNA_CICHLID) {
+			if (adev->vcn.num_vcn_inst > 1) {
 				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn,
 								  0x10000, NULL);
 				if (ret)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
