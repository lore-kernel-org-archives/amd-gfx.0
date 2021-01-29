Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E666DC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 03:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5A964DFA
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 03:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5A964DFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 316D36E985;
	Fri, 29 Jan 2021 03:07:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B01DC6E985
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 03:07:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci5aI5/e1JuNcVVkucjtdjCQGnu2WHJ5WpNOWRru5S/O9hgc9Cy1657qtjY/jO/EP5lorHTyTbgyYy2ewkdBy247OYr7bT8//OwslrX1a3BYIzV2GNo13KpMgFSERe59IWQYie/v4FjjQpg5GDaxAaey/S1MkVi9x0IzxCBq7AoOWuzcSw8UxeXJTM4xg8mUiU9a5FP1DWQNaUc7NtlIC5TM6CfGe0Q7FaUdVRQzr729GUHxZg/p5NZbCBFDG1EPPuDbwV+faiuLH46vAsvmzNijoaCRHcZcVqn93jRI1H1lY42+UI/eGSlO02az4jfUMbTF0F9ntmm++rYg36M3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKR7nHRaaP35x5X2r+3m4tEYmySP8DcMGzMAtnhIyKY=;
 b=Ldv8R2pWJbQ1AKq4abtv92tXg52RaKsfAS2VQXP1+aeWjIcLg9qY6K8U1aIWUlmwNLUYOCmAWJXMaBfMs0J0sy22TsZwKqszM1onMSptNOoABU89nSknaDDyCEsKCUi7hgIHD688/qZUoANAKkwxfZ8i/+Sc430dKE55PuPAiinNuPJ9302uMxM5+B4OVLkZZKaHieT6GzZOXvgwwprdrMfzFHGFD2v206twpKG8aplrqfcVAIP2aKz1zBRhR2Wrq7jOyr6aQC7Kx+IoJb3F26izjjEPRJ40hctVcf1RWo4hA6KlbAv4rveOuaEG0TPjpGlCcDWmY1UM4mPM+7sTqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKR7nHRaaP35x5X2r+3m4tEYmySP8DcMGzMAtnhIyKY=;
 b=DPwgXhTYUyz6A+h7ceRDmXym3EWiena29z2iO0hbOoPcE7BnZ8MMVEFGzRRwY+lJsqFzL44qpylB2AsJgNocbKYCkIkvFOG3TZ91H4CCXcWpEcomBxfJFoepDi5VnAKnUvqQx7AKgJjNOP/xG+F4JuPM0g6DJ/EKboeWt9Iv/j0=
Received: from BN6PR17CA0008.namprd17.prod.outlook.com (2603:10b6:404:65::18)
 by CH2PR12MB3991.namprd12.prod.outlook.com (2603:10b6:610:2f::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 29 Jan
 2021 03:07:30 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::ba) by BN6PR17CA0008.outlook.office365.com
 (2603:10b6:404:65::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Fri, 29 Jan 2021 03:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 03:07:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 28 Jan
 2021 21:07:27 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 28 Jan
 2021 21:07:26 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Thu, 28 Jan 2021 21:07:25 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable ACDC feature
Date: Fri, 29 Jan 2021 11:07:21 +0800
Message-ID: <20210129030721.23031-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4987ac3-9076-497f-9f7b-08d8c403039f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3991:
X-Microsoft-Antispam-PRVS: <CH2PR12MB39912B4B45AC6E3FD33599C88EB99@CH2PR12MB3991.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JEcDNMn2RyfESAtqPMZuesx3i69KMGd/AL150AukWQ+QUEp9EYKvXR2tJuMqjLf4s72HkuIrddkQgCWNWhmbe2+TyzCl4PC3ixRmMwPYeahbfMuJ6/6uRLlud7qzXNgPqIBPAR60XvvIy44PXwqmgKEIwiD2r3aceykeTDwVA5OU+ZVLfZ5JyjKEBT19pgNjtGcVTU7Pef9pt7vKdZVobpbBtRofaPgNejQeWhYKj2qoddrWU7DCYV7e9O1bdPk6eRsBo9KZoODMUeOY4BayXOtAxL7gt3mLMdBBEda1o4SXDlL7btxUmlD6R6Gm0F5hc6OLNIGTnOD41dJHddP8AAUluIK1dJHNqDY1tDTiuH+BMRz2njFFuDb04NGw3uB1JHShpH+QGEitFoCvrq3I8wqolfya4ejMAGHH5UcRzQyWgP90+pBZZTHzC5BGtCIubC6dSVDwrzLo8Po/hL2LoloxXKSsSXHpt/9FQ8vIYlDAaU72nh3uxvFGFDkI9ACH2arnZhGsijJ9qaPSESGl3/CAwxl86brMZvD0PXI4VTAiuq1bKuodjiOsY8pOqvblyq/qNRSLHAlRbkmAenAjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(44832011)(83380400001)(36756003)(6916009)(81166007)(356005)(426003)(2906002)(82310400003)(86362001)(6666004)(82740400003)(7696005)(2616005)(4326008)(316002)(186003)(8676002)(336012)(70206006)(70586007)(8936002)(5660300002)(1076003)(26005)(47076005)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 03:07:29.7234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4987ac3-9076-497f-9f7b-08d8c403039f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3991
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The power limit and clock ragne are different in AC mode and DC mode.
Firmware does the setting after this feature is enabled.
Applied on mobile skus.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index dffdcebc80e1..faddfa9f5642 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -261,6 +261,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
 	}
 
+	if (smu->dc_controlled_by_gpio)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
+
 	if ((adev->pm.pp_feature & PP_GFX_DCS_MASK) && adev->asic_type > CHIP_SIENNA_CICHLID)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DCS_BIT);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
