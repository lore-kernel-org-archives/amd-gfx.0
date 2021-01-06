Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7758AC433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 01:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE74221E2
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 01:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE74221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81AFB89BB2;
	Wed,  6 Jan 2021 01:05:28 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC7389BB2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 01:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVBSRU8oCPstyel2XlmrQaWGZqCYz6JVbkVsdqA5uiKN/wXUU+bXA2TnySXl1XaLXBD4t35zbUtlkBySrZQo84D8lIqIKHGl23oj0jKyUwW20MPRGOBMPAypFQx5X4Aw7kwysKqdWx/p61UJj92eJHmoraGUaaFjZZtrgdbjitazA6syYzB0g0s2EoEbTUQvDjANs+lWx9uIExBTC9c2l970YK4l4xwi1Y/RuNDFLjNGICEFsfq5cPZzE5lNZ+MHI/5PYEg/fXV+jSvm09EdDeZX90ziKkm7hkKk0khGS1AS0utmSRwh/TGwmgrMMkV8JgF9iaahcUS9iZzeG1Krlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMaKXl4j3m/M7+eEnTeERfFO1cbIlM34Qm036UTICiY=;
 b=dHVJwumT6dBWetp06t66WqgvpdqyIMiRoQNo4cfXQrX7TwlmgB6atVQP5pCKoRHJ0uAbOYHyPdLcBUZ5wvfbjg9nKpafEiFVpvTyuzUgfoFYT49+oTA0Ek8zyov5LlV/aXj+7BiYu8muCJcsr3eEn+dy8EoeG73TMap+FgPqPCvnNb5GV+tEeQznxgNyOxA/ihr+2yQLR4fl+1+0RgEdXYbFQQi03Ys3Z0c3GTEcK6HGaJQ8IT+q00PQ7INoUXe+yLBUaeaLjxFBFsyRR+dRFP8nkxr7FH/XrjrldlZgjMn4phavouB3ndLkzAdLcuT0l7YG/OPby20RHn1ChBflOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMaKXl4j3m/M7+eEnTeERfFO1cbIlM34Qm036UTICiY=;
 b=pHM2Lu1V+PD3RZiCYtJyG9uamt/N00HDXnGBahiR41b12LBk9Xq4FHGRpNpYOZpaQPKvD3cN/YcJ31O2ubg5pVG0zshg4EJqKWiAldvlUTQ2w7dOncgRZHty8YVp6y+PCjiieSsBKBpBblMEIp4eDdhUE4+nlciJHApbXFsHxfA=
Received: from DM5PR04CA0070.namprd04.prod.outlook.com (2603:10b6:3:ef::32) by
 BYAPR12MB2710.namprd12.prod.outlook.com (2603:10b6:a03:68::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Wed, 6 Jan 2021 01:05:23 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::de) by DM5PR04CA0070.outlook.office365.com
 (2603:10b6:3:ef::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Wed, 6 Jan 2021 01:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.23 via Frontend Transport; Wed, 6 Jan 2021 01:05:21 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 19:05:21 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 5 Jan 2021 19:05:20 -0600
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Add new mode 2560x1440
Date: Wed, 6 Jan 2021 09:05:13 +0800
Message-ID: <20210106010515.486545-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3a77017-5c79-4796-7a12-08d8b1df2454
X-MS-TrafficTypeDiagnostic: BYAPR12MB2710:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27102552A353E157BB9FD49B8FD00@BYAPR12MB2710.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tL9ObE+aISLa1IWL0VHwlD3vqAyaUFnZt+LdzfcBpNmORuU/Od7FL34jp3+T4/2AM/qwuD5G0eMD0CfZ+SD8WbNU87/1QnTD3ne0Jv9IvhUhkXRgH02B3KJJ0Vkv/FgFw6br8oek848hcdDODa9oH4/SZGbkUmCvesnjxEQuqVFYj92ZQlkIdUrCHNwqifMzsnrgzCMELAcDhHpI44I9LdRwp4Uyb75UptxrgulBzOAvGyRP93LrxsixH782yxB1U38Q5/xWhR3ZEO6z9EOy8RyE8xOtnicGWIDgqPVjYHMdAeWbEvcY014SWkds0kk2GWLF0GRLWfr5qBY/kNiqW7KRpTq5AahaB9japFdNUM51USOVShvH0Hcg8lmi8N91JG4x3w58cXAeULjzWg1jB6VaMRVMW7o9DB/AfEsrRDxoJeHIQwKRnHiuulKT7dhlqbShGJ0UeqsQ9X5F+HbttL+CGFdZawZa0F3fJke5a1sUtjAv7Ldb3K1gyANgsHP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(478600001)(4326008)(82740400003)(34070700002)(86362001)(316002)(5660300002)(8936002)(82310400003)(6666004)(186003)(2906002)(6916009)(336012)(1076003)(70586007)(70206006)(2616005)(426003)(26005)(8676002)(7696005)(47076005)(83380400001)(81166007)(356005)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 01:05:21.7305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a77017-5c79-4796-7a12-08d8b1df2454
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2710
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add one more 2k resolution which appears frequently in market.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index ffcc64ec6473..9810af712cc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -294,7 +294,7 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
 	static const struct mode_size {
 		int w;
 		int h;
-	} common_modes[21] = {
+	} common_modes[] = {
 		{ 640,  480},
 		{ 720,  480},
 		{ 800,  600},
@@ -312,13 +312,14 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
 		{1600, 1200},
 		{1920, 1080},
 		{1920, 1200},
+		{2560, 1440},
 		{4096, 3112},
 		{3656, 2664},
 		{3840, 2160},
 		{4096, 2160},
 	};
 
-	for (i = 0; i < 21; i++) {
+	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
 		drm_mode_probed_add(connector, mode);
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
