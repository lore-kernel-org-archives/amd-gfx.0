Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AFBC43460
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A659761447
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A659761447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356026EC8A;
	Thu, 29 Apr 2021 06:26:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743266EC8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqZZr6HED5W13z8PZ1fUwt+bilIjeIzS+pQjB0ow+zOClG2W26hLQTIvmEb5n0bKSc/E27/NF1l89jrUuzaV+5eC/psPHf4vmDMf/ItwxnPTsuL8ggSFQfNwyCMM+vpgdAroMJqx716LOmoz7uegvMFdnP0bhPkKBPgn8BT4KF/daKIG4s8qHiqALlM0JYsJcUQannXv6zNOjSl7nSLHEDJCuNaI+RXdZ74VFkalpmWGve2XjmmxLT4N2kw5Sxq+KL9M2U3kgm0b1pNxlDay4gS+RkwWZlvdm0Y13kXThRWU4gWx4PV67nvSmExXJWXcBl+wJiGyeHiiEY3YKIcJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so54wnypORiGCKhKF5n1jMkK/9B2qfAm6ZIpRTLZHvI=;
 b=T+TtFHjuICygrtuUVQp2nYC8q7fvEcp7rEYS28br9AIsegpb7iou8im/KJF0Ys5OiJbkliZTG8/BmiQCXfLV6KeJ6UOTHBLACV3kh/h0qW5kfG7QFPvOylMv9Scc0ytIQWGHZNWFRXI1ZHvSUR/i4xOmT0jWeS3yIfLppl7Ijk0+1mrqsoCVLF2Geva7oSTtJIjBg68LvKbFkGWOmcXFisDZnFUWTO+mK/1V3iKvLNVC1eCFKXTLMT8QvM0HRf5Zic+tei8Zb59cLZPZcSmzH3LYl0uiWpQIKsFKT1/RF/iB7tzxiC/hh9yra2I+Ghl8CBUeMFLY3yW9WyPwLy1R7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so54wnypORiGCKhKF5n1jMkK/9B2qfAm6ZIpRTLZHvI=;
 b=MKFixl9UWqRv0yVCS65KZ8wQmsvqTcVGqqULfKWEL6Y0BAatvKOZK0vDdrKzFkFLWZycB/eaiXWATNeLqDjlXOgOVsEIraGB2IFeeYBrreIL/AIOx2NCFPhPqtKLVlkZQskZxJaaSr4jQjY4JDQ6QW/F1qerWfb9Lpih8xhLLjQ=
Received: from BN8PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:d4::32)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 06:26:03 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::e7) by BN8PR04CA0058.outlook.office365.com
 (2603:10b6:408:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 06:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 06:26:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:26:02 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 01:26:01 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 John Clements <John.Clements@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu: initialize hdp v4_0 ras functions
Date: Thu, 29 Apr 2021 14:25:43 +0800
Message-ID: <1619677546-2630-4-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8107303f-c7b7-4363-1ddc-08d90ad7a9c7
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4199570668BEDDADD20E27BBFC5F9@CH2PR12MB4199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55yGXVAoMlaP5eoqOhTqn0xekmKEIfrtjrAzHW58TAZQ8lv9MjG9uJhdL81DrczaPPE7iopZbWZZWunP9cmWjw/Lc8FvAZcB12CRTF2uhAeOmVU7ELgo5qe5QThi2qlLz30ytJLNmg5CBbNwOTNt2JaabkjUMHExRV5CbHQaE5lFlhY7UJvpZOYJJkjYxoz/pRUjC9Ktj+26COJEn/7mykJoL1/4xmLpgEGWXkJT96Zw4yJvV45yJDMo5IS+0IFXfx5iQDMBMPzz82ZYObts1foWKEvB6HlnuR7SmOJnt5ljMIiVDJkUf4gYiK5USZ7wjsuWD/kIDs2OE17Le8pDR23sbAiLds3fYGlCUzjXhzDJVd2foSVymU1GhqZp5HqhwZQhci1b4Yo+aVbLlOF4SCeNwDbMPvZZ0SI6hWxXyKfRzBUrgt7mz3P2i/m9AKTA7AXuf2c4n+4Fe7Q2aHWrtayPQZeRCFv2vmph8cFM5/SHAy6pnPozyaRCLqEa2NrVJ7RoP0g8WRbjO5OBl9nx0w9BigmUBwqxvdzoElaNk5+NIYyYw67DT2jV3bFQrjY4AAbqYXrS6QeZfz1aYd1mC7lCK9eUz26ZfkciZliYNs6lIliqIjVJZSJWeJu2S8jVOYnekFm25456qmp7PSX0wUgZQfRhHLFupjuEyh1KsR61+Mc1i6X15CvHA7g9vznT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(26005)(70206006)(70586007)(186003)(8936002)(8676002)(2616005)(478600001)(82310400003)(81166007)(82740400003)(356005)(2906002)(36756003)(7696005)(336012)(86362001)(47076005)(6666004)(316002)(4326008)(426003)(110136005)(5660300002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:26:03.1841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8107303f-c7b7-4363-1ddc-08d90ad7a9c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

hdp v4_0 support ras features

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4da8b3d..8e0cab5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -53,6 +53,7 @@
 #include "mmhub_v1_7.h"
 #include "umc_v6_1.h"
 #include "umc_v6_0.h"
+#include "hdp_v4_0.h"
 
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
 
@@ -1210,6 +1211,11 @@ static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	adev->gfxhub.funcs = &gfxhub_v1_0_funcs;
 }
 
+static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev)
+{
+	adev->hdp.ras_funcs = &hdp_v4_0_ras_funcs;
+}
+
 static int gmc_v9_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1230,6 +1236,7 @@ static int gmc_v9_0_early_init(void *handle)
 	gmc_v9_0_set_mmhub_funcs(adev);
 	gmc_v9_0_set_mmhub_ras_funcs(adev);
 	gmc_v9_0_set_gfxhub_funcs(adev);
+	gmc_v9_0_set_hdp_ras_funcs(adev);
 
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
 	adev->gmc.shared_aperture_end =
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
