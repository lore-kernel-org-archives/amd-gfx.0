Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECEEC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 01:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0827210FA60;
	Mon, 25 Jul 2022 01:30:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0638310F263
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 01:30:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6qOMPa1TrqZQFAC7J7cEOZi6/Ch3OH+0+VkSffNQKleVeYIGM0saOeWXtriCqqsR2BeEbzkzDtNfa4ZZjkxUPNguvaEl0o6E6tT9t/OF1mq3WKUz/ZPxmRZKCmY3l79ni6iiHn522uwoV6wlEiQnrhj39B2gyKwAdoPmRx6J9mUGEfLixWBMfP3q7QO9R+RfeAa3v5wEzEmjYsxr7tWLX+7s7Zyv4kSStzDLH2Jkifo+x5Qcxg7WLTeZXLGH4pc7NGqrCKc3hX5zTJ8ubq/D1BFdnRHAacYTYkszRRrR1E6Ob5P9Ag+eeC+c1enosxHF2xroM7pmtbDFesMSzZQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLyzVI4xJHPOK/Kxn8TjMyAs73mPzK2T/k4scCo+mzo=;
 b=FO48lAnxtLkD7h5X2DOWNbZMyEziyZl1N2qWnEmIUTgayl93JxipXCAyASp80eGEUR+zNukrYcbL77xxck1Ooq4PLYu1yhpBAruhmJ3oYUKjVIb9gzRYDpgUY4IH5TxmLp7JWRE5TURgc4/BJCLbREg04J22mRzjXn+ZsxJYjXct/JHDT9dGji7sVKDcT/qmpjQlYNbZYiyZAVgF90ATlCZky7sp6DFb/+unI6tScNkM+vx+uiSjZP8tn9FHzGDqmdyYFBx8ol3Kf6vObVyRCk99ZH13slQq9nKZJJ1NWefPBLWlAr/3VCE4ydD8sysUe7/05m5wQMHWNf0lo/QxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLyzVI4xJHPOK/Kxn8TjMyAs73mPzK2T/k4scCo+mzo=;
 b=1Maz6XjZm8r1wO7pKSGWWdVjzf9b4T3Ibu78CjxmqIdyNZB/7l+6zBCwCZ3/Y7YABXDSO3EQgIZO1OLTEz9wEBWEQTofp3pemmtEYfsjwEYHsTXVDJuCXL2aG3NIYesanaatuyiDf08XveQhjVAFbrwKsmzF34lMtFj1qynhBfU=
Received: from MW4PR03CA0252.namprd03.prod.outlook.com (2603:10b6:303:b4::17)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 01:30:43 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::f4) by MW4PR03CA0252.outlook.office365.com
 (2603:10b6:303:b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.24 via Frontend
 Transport; Mon, 25 Jul 2022 01:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 01:30:42 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 24 Jul
 2022 20:30:40 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] =?UTF-8?q?drm/amdgpu:=20add=20declaration=20of=20function?=
 =?UTF-8?q?=20=E2=80=98drm=5Fneed=5Fswiotlb=E2=80=99=20in=20gmc10.0?=
Date: Mon, 25 Jul 2022 09:30:27 +0800
Message-ID: <20220725013027.1423657-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11aac01e-c536-46f5-8aed-08da6ddd4a84
X-MS-TrafficTypeDiagnostic: MN2PR12MB4552:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJv/3tileNYIu/ivJPYlsSZWahVJ+WUdZclXNzc0jJ3TQbib6xM0UfbHtrd4jJhAg4i384/W74GFaIibXRuNM5/6mtich+NUFTganjC/jRsIh3nlmhChHrGA3sxmxCF8zOdl8YGO7f6SPrJy5zCvxVEJC6jojyhSedzFYVWHugx/ptpFt9DIdcaIr+9f5YB2bCfU1EilRzuXkmgij5T+i/rjoHFHNryJdX6bibIR7oy9/Hrd6AhzK83WmG6euSGqkn3neUyJnSVTKqQaKJs+6GVoLKqfSq9LeWKzshwLD37HjamEIeXPw1dzDJTA80UL3aLj2VrxRPAooY04PRg/DhcUtH3GtdfUYQwHxjfM1I+r3exnXLQhtHyoafkFdDuBrWyutHOqRv0sLQRSemzru6EpfjRPK9X2NsteRv6cTIhEh5+6wADjepoIyzmTAvW9pxNKkZBLAjoT8ghXRuasfsq3e4L9Y6NaEN1U3aLeXyrhTb2zk4visDy6KnlMxJuGtNtlWItLgZSRud3jMCCXHvwtIeMV8sCsXIq9zgP4/NMNN5pDtJLFnOefHZ5NV0jent0GOwRUcgh0XVj9oL2Nfohe9PyC6IH8T9v1711fz9qmjJdruiuRFEg+nY6pI+YfpVqtI9/tuxGBqcbz4H7Ue0zRFW1c9+iGXZ9iSIwvfyMM3Sp6S5cbnxRQkVSNZcEc3ehIRy9BxEzJlZMDYVgozH46vrSSXlpIIrdUTSvaUXalRQAkogKIIWgPoSZtBO0Q5sAlv+eQMexfddjDDf82+LFbQRUjaZ7gzUKGqaADI1NqDYTaEUnjMuR5FEl52kOX2feyikg2lUjfrsHP/iEhQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(40470700004)(36840700001)(356005)(70586007)(82740400003)(81166007)(70206006)(478600001)(316002)(6916009)(54906003)(4326008)(36756003)(86362001)(41300700001)(36860700001)(426003)(336012)(47076005)(7696005)(16526019)(2616005)(186003)(1076003)(6666004)(26005)(82310400005)(40480700001)(5660300002)(40460700003)(8936002)(4744005)(44832011)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 01:30:42.9871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11aac01e-c536-46f5-8aed-08da6ddd4a84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixing compiling error:
drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c: In function ‘gmc_v10_0_sw_init’:
drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c:983:23: error: implicit declaration of function ‘drm_need_swiotlb’ [-Werror=implicit-function-declaration]
  983 |  adev->need_swiotlb = drm_need_swiotlb(44);

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f8fa27b7b53b..9ae8cdaa033e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -22,6 +22,9 @@
  */
 #include <linux/firmware.h>
 #include <linux/pci.h>
+
+#include <drm/drm_cache.h>
+
 #include "amdgpu.h"
 #include "amdgpu_atomfirmware.h"
 #include "gmc_v10_0.h"
-- 
2.37.0

