Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA9DC55178
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B11E2224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fX6iZ9vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B11E2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2606EDC8;
	Wed, 21 Oct 2020 14:23:28 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680083.outbound.protection.outlook.com [40.107.68.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144196EDD1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFIrz6Mx2/MMCYNYRHLij4dWoi6rCSqFNV/Dt7/x4VKOmFmtZ4UyY0pre7vQ1vp8268AlKnJecsVVEhsPNiPppCQm5biGu2IzreWQDeMk55lyBGn2ckrsQiqQyowBfkrbg7HHgLwC2eA4GSlTLeX0BdsR9tYCpgs6ZwSgFo9w3QgDi+85oqYH5u78vugbVApJepuJkUrMZzNOxjl1v3Fj8NJ3S1U7UECo2Yv7upfdT14wdVaXbcKEMSqvzQvHG6Qn8qmBkrbhut/7YwDFhHcLC5Oafm2pnT0rQiymLRVyg7Vk8DCmJ24GAIEz5vi5fHw5wo1hbM0a6tcA2ddmTK0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GgYTe+az94Uh825m8v5KFsa023Loakhtg2iDnp+HIc=;
 b=YSNrEZCv57xZ3XJZ8GzMUiy5MQ1vivnhCDfsn4trxwzuFdjEx9CpqPMIvW2kJCvVu0Zur+UXSRTaaoay4vHcTaZXx9RJyHkGn44fPKAGc6ls4fo5FeaEdPOf7TZq3bf4E1ZP7mcG4sUTSbd8kbUvtZspBKg4wFMzTQwTu0rgAdXkiTpIgfA8oR4zxADiHieAXCWooIJRTQMB9slE6IyTmEWupFG9Yj13ptDQVjjaCH3ehPXE0L9y+TEwm2HfHYXFwcfeedhl++eMYQcQ9jdKGMiVCFiHc02K1toBBeNmu4XWwix7Uh6zMX2WneB7Kov37s6z/T7miZRP7ihlt4wY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GgYTe+az94Uh825m8v5KFsa023Loakhtg2iDnp+HIc=;
 b=fX6iZ9vhSNlsQer2hkApVOkDWVXCxFl2ocLOJ9/PddfX8oAW06njpN52SDYU4TmOEhRnDi/7A8Yx5f48Zn89pzVSAJtQAGHP32cRC+FaLkjweNehEEx/lQE79buY4Uwi1qPI2/rpnKtCVUXur5dBVueGPXObx3vOkdX6ijgu5fc=
Received: from DM5PR16CA0047.namprd16.prod.outlook.com (2603:10b6:4:15::33) by
 BN8PR12MB3266.namprd12.prod.outlook.com (2603:10b6:408:6e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.27; Wed, 21 Oct 2020 14:23:25 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::31) by DM5PR16CA0047.outlook.office365.com
 (2603:10b6:4:15::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:25 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:23 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:23 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/33] drm/amd/display: 3.2.108
Date: Wed, 21 Oct 2020 10:22:48 -0400
Message-ID: <20201021142257.190969-25-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2a56193-e4d5-4ce9-987a-08d875ccdf61
X-MS-TrafficTypeDiagnostic: BN8PR12MB3266:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3266582766A51E85C0757F338B1C0@BN8PR12MB3266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYQ4TbBo8JwrWfBm1i6N7nnGvXrO0jN1ufw6jVHCkFjbyTTtgZTwdP8sHHsGjMoY5MKgsoB27FHx80rDLqcU3dSV8Uqtn7/eJZHfXvasTlzJlCNQ+MtZoW6nU4H/sm73zwYuLYZw8OqzoYaEFG754mg5nvCHxxTsiKcstoZIReJFctBHovTs31lwTVYbmmiZCdJx4qk/2r8p7bdQEXydK1/54qcAAN0WVzLir+6ipWLILCncwrf6evUUVLizwkPb1Y9ipIksQxxQL5W7uXUTgAbmu12EQk8KU0SEr0g6ar8PaQw04UcAflTY60cstUrEZVNKpWtsocFYI+iqYzekdPerlgFU51ONI3Yy9NSUdcjxmpQWt+OpZJtVrDL2ZSth4pwmB+RdmRUpGfbAfqOTbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966005)(70586007)(70206006)(47076004)(8676002)(82740400003)(478600001)(316002)(81166007)(4326008)(83380400001)(82310400003)(6916009)(86362001)(356005)(8936002)(54906003)(6666004)(44832011)(7696005)(1076003)(2616005)(5660300002)(26005)(186003)(2906002)(4744005)(426003)(36756003)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:25.3429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a56193-e4d5-4ce9-987a-08d875ccdf61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3266
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

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index daa2589464fe..7622cd222d66 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.107"
+#define DC_VER "3.2.108"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
