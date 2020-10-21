Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C576EC56201
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 08:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D9D22249
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 08:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bAdEq8RB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D9D22249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C0EE6EA7B;
	Wed, 21 Oct 2020 08:18:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37BA46EA7B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 08:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXevzQ9Ga4E2kAV/jHwPKIhD9I1LWcBmYSLu4fILRtLifNWPu7oQY1BVQhFEKg2qh1BSZ/Q+75w4wh2o6Xgn3CyA0RgukSfJ0Y8bgfpULjYz6MfA46PIRZqkbccabu+oi+k7z0IUhIanflggboYEsq3rTNNB/xXcv69KLBmF7TfM/TrtbIBLlssabJBpwnoE9YANuWeXVaoOPoynSSdihDhn3y2sjTm/3w9KI/9iJYTb5vZ/yIoPiW6K32J/DpQn9wD868NuytAs+6usuIe3DVDS3yC6R+4aKw8qGvrxvVQv8YR4yzt38AsXGi6ySNkFUxUkogTLOHXFqao52KN22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+cM1odspcRbkA3tUYEjnuDfFFFln4HCwUbyIAiffyQ=;
 b=QXg1oHpRFnqfBF/4spv3vp2yx7hYS/jgD5lQegwM+/WFJhXEU5fIkXXKC/eoCppYfLJTETy6v2IlTkkmLIPJFGhyz1AGWx18Su3AZrS9n5KDEIc450ei/+3VyzDVGAeoaA2X9kERn4n+27fcp7OvdaaTm4usO2UunI195lJHg+l0z4UGYiYFn7diYUa4zF3n+VjlhURo6sTPIfYy76NUl3bIhc3sFA6YtroWQFlFcy4W+abuI3bibTOzwcn3zaGKCBIfKABA9/yiSkGBpyt/Aywsn3CQXQS/5xkGYvmB5J3wF4p3TXc1KXfg+uUMO9fLaN4dttClNgKIxULJME4fhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+cM1odspcRbkA3tUYEjnuDfFFFln4HCwUbyIAiffyQ=;
 b=bAdEq8RBlKmFqjbaJRltpxVg9N5U3cQ450teuFa7uCzSMazmTZ76r31TjVvJEDTuICj6JiD4st0a1L5vMoNS9i+nYeVtW3JiyUL3Go6VRxMdPp8n7Y137bHRp2FxIUL5QESJUzatt4r0PejJi5gTIujVxCkFszp6AI8Ef955EYs=
Received: from BN6PR06CA0001.namprd06.prod.outlook.com (2603:10b6:404:10b::11)
 by BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 08:18:38 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10b:cafe::d2) by BN6PR06CA0001.outlook.office365.com
 (2603:10b6:404:10b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 08:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 08:18:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 03:18:37 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 03:18:37 -0500
Received: from lnx-kenneth.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 03:18:36 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix pp_dpm_fclk
Date: Wed, 21 Oct 2020 16:18:33 +0800
Message-ID: <20201021081833.15508-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d81a256-a9ed-4be9-4487-08d87599e976
X-MS-TrafficTypeDiagnostic: BYAPR12MB3192:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3192B9EDC5F01EA95D54E8018E1C0@BYAPR12MB3192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fob4YOYtjpgUJbQU3NhYjmPbCpn7pSyMsqOJkkwSp2x48d0UmY+TxXNsmTgVPhP5XYYWJ/Mh76SbufFsEjV+7uTAMFzfwOc2TEP0bzprAxNHPcwWvXWCSXl1EyJxl12B2OrZu5mKoTk4Rt5E02hBZ5KOuRBKVkOUdFoCT7oQoe5BM0FXglxfzey43yee6KQCXSF7ysNWdNfK9kdytRjFw/C/aR0B2cyS/LHr7fW50K3AW9UzN4vZYhbfoeDuAYZUlD5PGxGI+iDJZcnfxTHvhCHNenBywaoE7iMTT6yR2h5MEgAXZIUhsj5A9M6dYnVONrJdbJS8jQyTpbU7YNL5R94falkb++hbnhsxJcvts58Dhmw9cxTRSrm7Uzr+7dkDrirgd6vIwFcvcjQ4rTdstw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966005)(426003)(4326008)(44832011)(6666004)(86362001)(2906002)(336012)(36756003)(7696005)(70206006)(70586007)(5660300002)(26005)(54906003)(186003)(81166007)(316002)(82310400003)(83380400001)(6916009)(4744005)(478600001)(82740400003)(8676002)(356005)(8936002)(1076003)(2616005)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 08:18:37.9773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d81a256-a9ed-4be9-4487-08d87599e976
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3192
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
Cc: likun.gao@amd.com, Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fclk value is missing in pp_dpm_fclk. add this to correctly show the current value.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 27b6cade9ade..d2851f8e9c11 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -456,6 +456,9 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_CURR_DCEFCLK:
 		*value = metrics->CurrClock[PPCLK_DCEFCLK];
 		break;
+	case METRICS_CURR_FCLK:
+		*value = metrics->CurrClock[PPCLK_FCLK];
+		break;
 	case METRICS_AVERAGE_GFXCLK:
 		if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
 			*value = metrics->AverageGfxclkFrequencyPostDs;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
