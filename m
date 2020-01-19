Return-Path: <SRS0=dEFY=3I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E120C32771
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jan 2020 02:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3841B2469D
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jan 2020 02:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f0jqAHCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3841B2469D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023046E1B5;
	Sun, 19 Jan 2020 02:46:23 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750054.outbound.protection.outlook.com [40.107.75.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56806E1B5
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jan 2020 02:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB6oLiBETS6AAAAMEgGwWUtgVl7JVL8KIBEfboqrb3BS3IHDDjievSw4URvn8LNDTjeT7dRQwufYMLyPbUwlnwSsKAr73GoP7UroOUVGnsFmWwrOXeAXzSjU3dDZUtxJQn0HSh84e74v94kLf4hIEVrXHezkD40d+SOdGWujEHTnONY5DfgvltsSg+j9T9xUM8L0PA7wxgcEoyAzZiuNskHL/0o/9CdV4SlCSyepJMHETHTILKW1BzUEXYWt73am3bJDnFXX6fg71X5jFcSLmzM3jkNErP7SExRViiIiuSxV2Gn4LSWxJpDB5uC/G7xqOMoTctBL4jEZUnnERbWNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmjsKjbVWQsAU66F969OOWx5pANE1IJYr3p25X5Z5oQ=;
 b=NjOLyRtzRiGr7wvD10RRzf9kd7zNzacHfPvar8CmsQx9aTfUg3/FuwtPhByaa3ASkt83B7SgHDXy3XB3h09HWOf9Xrx+QOh7wag6Vvptkre2V75J5+3Beif07aLLMSmx2gwtsu3Y2qFMHon9BB82hxYtNQBIEaIrI2KpmYhGJBpHbPL8QhrIPF3FQLdI+Ec1RIE0SfmHkzVVoDnWlbzjkouLm4MICc8Un64Q8WDJORaCo9t70ebvjawVZ6rSSF6UQktFK3bGyjP0of+BTulTOZ944mzGP3qr6lgMgbD1NvwCRRw6KAJoLYX1G6ANg3PHKoufZXr7NC/hUFBUds8o+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmjsKjbVWQsAU66F969OOWx5pANE1IJYr3p25X5Z5oQ=;
 b=f0jqAHCQBC93pm18q4enFA8Bro9dqifS1pADorL64x6fs5yf2furEiDxyIZqBR/f64b37nLt5LdUXi4acFpkmNjjGPTL2vEWAAii12WbchUSLbmjTem8M7B9f+aYSgWc+UjVACemWZM3BE0SUHylS9pMMvH4oaHOMJk/mSWcmJY=
Received: from BN4PR12CA0018.namprd12.prod.outlook.com (2603:10b6:403:2::28)
 by BY5PR12MB3956.namprd12.prod.outlook.com (2603:10b6:a03:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.22; Sun, 19 Jan
 2020 02:46:16 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::203) by BN4PR12CA0018.outlook.office365.com
 (2603:10b6:403:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Sun, 19 Jan 2020 02:46:15 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Sun, 19 Jan 2020 02:46:15 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 18 Jan
 2020 20:46:15 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 18 Jan 2020 20:46:13 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: refine the security check for RAS functions
Date: Sun, 19 Jan 2020 10:45:59 +0800
Message-ID: <20200119024602.23079-2-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119024602.23079-1-Dennis.Li@amd.com>
References: <20200119024602.23079-1-Dennis.Li@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39850400004)(346002)(376002)(136003)(428003)(189003)(199004)(70586007)(478600001)(110136005)(36756003)(70206006)(1076003)(6636002)(8676002)(8936002)(81156014)(81166006)(7696005)(6666004)(2616005)(186003)(26005)(2906002)(426003)(356004)(316002)(86362001)(5660300002)(336012)(4326008)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3956; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f803d965-f928-4593-d457-08d79c89c0de
X-MS-TrafficTypeDiagnostic: BY5PR12MB3956:
X-Microsoft-Antispam-PRVS: <BY5PR12MB39561DEBEDD11D39FA829FC4ED330@BY5PR12MB3956.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-Forefront-PRVS: 0287BBA78D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSzaHmj4HixS0WM+HXLjLR3ThTXrBL/QBgHEstEhIVE6gizr84vm7XBEeSkm3XRO0Nhcq+ssu431WCXxfYQNetb281wsO+Xlu62dZFXqSrX5Z9a0Mj3nDMYMqW1Rv1rFnv7q6RyjssVqfw9vb0ieHOpzL4RRJfo+uDnuOdfWv6J7gUhY9+v31IJPrA2xWyq67rvc7aCGNH3EC0ZpsraKH9heM7theV8wUGfSzlO5U1B0Oth+Kbj4yBhrWUnYE4gCUVdoaHsQuRc53wb1Ina2qjmFpqEMfB8iq6tYEOV3CJUVPikMxbmLJm3s+pwDVSAlHPO+WvGAbLe3MaJrKpi9ZkJnCC23r1ELvtdqJXUe1JYPVoMpzMDtNdAwmN9BaZn416rpmRoLzJQ9VAK9jx53Z+iDYAYKHgXCj+/J4I3yQlCIvp4xsIwwmJrA7smbszfFY8XjObpT87Ob03B8X0CkZ4Oz3eYMc6XLafQPPIHu9kI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2020 02:46:15.6075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f803d965-f928-4593-d457-08d79c89c0de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3956
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To avoid calling RAS related functions when RAS feature isn't
supported in hardware. Change to check supported features, instead
of checking asic type.

v2: reuse amdgpu_ras_is_supported function, instead of introducing
a new flag for hardware ras feature.

Change-Id: Ia3f73bd9ee41ee3d0dd18d6f46e67124cf88d653
Signed-off-by: Dennis Li <Dennis.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e3d466bd5c4e..759d8144f9c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5967,7 +5967,7 @@ static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 	int ret;
 	struct ta_ras_trigger_error_input block_info = { 0 };
 
-	if (adev->asic_type != CHIP_VEGA20)
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return -EINVAL;
 
 	if (info->head.sub_block_index >= ARRAY_SIZE(ras_gfx_subblocks))
@@ -6218,7 +6218,7 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t i, j, k;
 	uint32_t reg_value;
 
-	if (adev->asic_type != CHIP_VEGA20)
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return -EINVAL;
 
 	err_data->ue_count = 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
