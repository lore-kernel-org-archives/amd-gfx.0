Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB2FC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 14:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0344A64FF3
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 14:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0344A64FF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC4216EA33;
	Wed, 10 Mar 2021 14:25:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 602F06EA33
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 14:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuTnU/TZMkbRrgSFvza7SG0JhoJXQQoLKxgCpqUj1K/tu+E51YyIuD1bK3/yeEs0goagguwC732776ZHKIPC/PgWqXdXux5oIAv1ffImfYhMvmR8X49PgmJU3QG8gJO4lz6Xt5SoWYsNMAJNuxsJHx8qJRmN7rwOJ+31wyIdkhLDQC9x9wJXx5CmoyDnKhXAdBIMmuYBvg2O3B9hhHCgai7g37NG+LVFCl6eCB/6SCgFoSTGcJFmNuAxmDYNOrxEe5L+aHvOMWorlgyv2ClKRYymy1NmakDfSqpSdAY7SE7A5Xs5e5IaCjYkrDSc3l2RIJ9PhknXupQdPbIT9n8RHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPYLxQpZ7qJ3fvEHVU+p9fsej7nZKt/a1AMComBPKmU=;
 b=D9trEzAoRewRBMJ0GRx6frzIDgxBZ0kvX5hvc5q6rKnF7/ToKE67P6CQ85iBDHRslDVraV2T2n2SLZg77fJsrWY09OnYlaqhJ5GKETAIb+VosAGzLaRpAGAR2qVSzy7UXD/OVaNbEqraiwNXZ6/+mRTsiJtZfmYa1RyIU1CmXRUTpxCT7CVOMMkII5DpSkk1C36qqPuSj4cJ5yP2pAMtLeebvlcVakN49X1gIT+Nctyr7PNSgNoEhyBKLEKvMnWhwd/ZREVtwui2fcgOL01foHPEyXUymBnht1gxAffSniiYMkSOcFuehlZHFBMZc6xsQWaN9LF4SAH9PsRlMKoSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPYLxQpZ7qJ3fvEHVU+p9fsej7nZKt/a1AMComBPKmU=;
 b=NmKtMCKVeoDSrs5B8SsfVh/mtQFCu3BHA1gMr/ZWUJm85NL6zenJQNdx5BUXtKhWQfXMY+ekihqKr711A+LZ5zhikiDhzcb3HIWoUv3mllRjNqLZLMtWI2rO9fccFvqa4hk6iv7UK7XFSqiHxk/SUTbHGIxN6Q+GRrhl0/M7Odo=
Received: from BN0PR04CA0184.namprd04.prod.outlook.com (2603:10b6:408:e9::9)
 by BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 14:25:18 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::12) by BN0PR04CA0184.outlook.office365.com
 (2603:10b6:408:e9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 10 Mar 2021 14:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.31 via Frontend Transport; Wed, 10 Mar 2021 14:25:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Mar
 2021 08:25:13 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Mar
 2021 08:25:12 -0600
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Wed, 10 Mar 2021 08:25:11 -0600
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu:disable XGMI TA unload for A+A aldebaran
Date: Wed, 10 Mar 2021 22:25:09 +0800
Message-ID: <20210310142509.2252166-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19c45645-48ea-4f2e-bd8b-08d8e3d053a0
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2981D546EB219C5BB8E7E7DFFE919@BYAPR12MB2981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQ5NpypdTbGgXs+d/P9ZKOUPwterzE5TQTjHX3TIlhaFACaCyi0jTBsg1FMP8DQBgR1F18JLm4zuxdH2YoAKD19XEssV+XW6EsA/2Zj9bdPdJ5I0OYQWJZu9w0YrCZKpX4JbMqFf8vpz4Z8r9oG0n8YtO9EnFylAE23I92dE+xJ0beGVUWxh3AGn4sc0KaAVExtF6DNx2e7HCEJslcLTjU5HVa1vSoP/oWavd9YHBIa87BAQ7BLjcH6FPt0sQ6SgFIMl5fOspHSYGvJ3WXto6N9YV2pEBnYaH9DPpCcaDN532geTzjNUUgviJRGCcWrRniOvA1ooMjwIFnMpbFmJvRRQrkhAUBJqL9smPHDzzfZnt9HsJKWlw3Uz5720D7upBNkB3EiSBTMsPiIJt57tkur7v4UUNqc1a6VqhJd3QgyMukVdYFPwq5Lf4XQCTCnBSiIMHv23RjTs0LJZX4r1B3NSMILz6Vs0NfZfZkzq8f05jIHHhIFrlGWqe4EJbXIbQupaGqk5dw/4ek9PX7ZN2qVultS2bYjRbR+rbV/f5pU8F70H6DP49YtS9g55phQlLXMkP+12hgj4/533XLL86H6XdjbU8c0jJX4Ynlq1aTmi19IVatOPX/kmz9qsg7GgTiP5i+RxQ1Q+GU0lNr1f3L0YZcEckmkbRTUtg05VKOlA5RwqSAG2Uun+DKXlzdhb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(36840700001)(2616005)(478600001)(6916009)(36860700001)(70586007)(4744005)(83380400001)(356005)(82310400003)(2906002)(5660300002)(82740400003)(81166007)(70206006)(26005)(186003)(86362001)(8676002)(36756003)(8936002)(47076005)(54906003)(336012)(4326008)(426003)(7696005)(1076003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 14:25:16.8231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c45645-48ea-4f2e-bd8b-08d8e3d053a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Lijo.Lazar@amd.com, John.Clements@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In gpu reset, XGMI TA unload will cause gpu hang.
Skip it on A+A aldebaran.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 80a4dc51951e..bae304b0d67a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -791,8 +791,9 @@ static int psp_xgmi_unload(struct psp_context *psp)
 	struct psp_gfx_cmd_resp *cmd;
 	struct amdgpu_device *adev = psp->adev;
 
-	/* XGMI TA unload currently is not supported on Arcturus */
-	if (adev->asic_type == CHIP_ARCTURUS)
+	/* XGMI TA unload currently is not supported on Arcturus/Aldebaran A+A */
+	if (adev->asic_type == CHIP_ARCTURUS ||
+		(adev->asic_type == CHIP_ALDEBARAN && adev->gmc.xgmi.connected_to_cpu))
 		return 0;
 
 	/*
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
