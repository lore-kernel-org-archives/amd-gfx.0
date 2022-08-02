Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67AFC00144
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Aug 2022 03:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB2D811A076;
	Tue,  2 Aug 2022 03:18:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9016A11A00F
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Aug 2022 03:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvaKYH+WLmVPmBN/SLASnj903ldI4tfPe1uNU/hJ+nd7s1bpPFjUygqMGHq7hzNphMHSo69qduEu8IuBWRhnILIWycSH+ws7/CQQLj2TAmBsnW4IFMqltSkO9ZPppgYISQtWFLvYLUM4cZRVYU+ApQkSh/63M1DlP99mrHARyxY96TukySDjkXR0YJOWjmaekIaTWTukkJIsgKGQvDsFbhhjxtUtRuRZMMygVUKCrvn/kDM5A3FbeElc/+STOxCV/lhU9aIZ2IGriR6nf8WcoVDx94wNTH+yZ31W3G35iqec9keGa2NUq35+ZSCCftcGGGCVqt2+gCxeQ+NgJxz7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4BSRNEONByMgcjv5X+Va3PV7r3izeutbYwqTfToXsA=;
 b=PcPo8cG+BFvSeWGyuvH7a5BN9+a47yvVT6VV1SVDsC0JPWzO/mzG6qlqlF7r6GvpGoG9mSiXMd9u55+Hd+jF63O4BEcHXbWscLgi6ui6ge2HK46GqMpp1rAk0INATRCNHjlJKjd81XQ3dK6BCm5RQt+QaN1FCqcvSQwugxkYTN7zsknUl+Ob15gU0gtJPvnt9UadbC9rdeFkBVOEsa+kQL1CP9M7C0PCWUoy7FMAZfkwDHEdq54TgZ+a4JqzK3+4DAAOOqGIAekCqiV1thBs06Tj6BvSbdlS3E0C2GlQnpzCyW3+bnSLrU8OL96HhGL0R1M3LoB3xZmO9a3HF04cEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4BSRNEONByMgcjv5X+Va3PV7r3izeutbYwqTfToXsA=;
 b=DInGPw0/O7VdkVig25wIujse+TNYBMVtFozAy2weVqGRYVuV+t+AhQwPN7TVC3gt9we2nQc9cEJbTaKD1WIrCxSxoXV1QJPnxyxFoWkgxZzEKQ69c2sixfppS3/a2+fZDDgeZsZxsfobplrQUzuA1/rKHojdxrZ6BmAS/sy/XBA=
Received: from BN9PR03CA0687.namprd03.prod.outlook.com (2603:10b6:408:10e::32)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 03:17:59 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::50) by BN9PR03CA0687.outlook.office365.com
 (2603:10b6:408:10e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25 via Frontend
 Transport; Tue, 2 Aug 2022 03:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Tue, 2 Aug 2022 03:17:58 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 22:17:56 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
Subject: [PATCH RESEND] drm/amdgpu: Remove redundant reference of header file
Date: Tue, 2 Aug 2022 11:17:29 +0800
Message-ID: <20220802031729.2088825-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dcdd2da-25b7-4624-f388-08da743599db
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKMrhOLzz7lGpX4NYosK92KTExdfezawdRkhqSct2hBuFq2PqwN6OKSzOq9HVnfN6OyjNdhV3X+CJ/rQcDVdNyLNO7vG88Kf9xCKkmm9nQeh4wRAaPKO+Nlo4BzHxJQQXdmMoH2Hq5z9SLcOk/aQVaEw57gOh/wEOmFUEj5YhfPkto1aIiknBEcYV7A/ggty2liHaeutgWAyad+eqYGyRMZwA4S4erP72CgXvSosACdUzwmq7tsxeJ7F54rQaRRqglyNPbOzm/8SPKSwlYstYlrGZ39fSmzOa7Jdzu1wZ8Woygylcmt+faKMMkrwsMD+bm5z28fm831T4gS1pYJ07MRwyRoJB2njsj03OXPUe7xTbSvZQhXIYeF0ebO4OMoFxRZi6HoPjcTDZqII5p5feNiyC0OU4hOvfewBXSlVSOsvsOLpnWXfy9M27nbairVL+JsKAhhdSwAKFibO29TKbBLOn6BLTQDq07CmH63GgDijBKFdLLJ9DYa59rxhg5CipqIIMGqAZG+3qbnFmUpEbBK4X3y03Fiah7fcESQyZm1xInaexkrcPDgWoiaVbI7MDkiKrL1/BmcYFUXeHbn+WQwejsrYmb8kTQostl9znXWLFX7TkWne8FgIUoieLt4YdZ29RpzFBcAnO4+maqq4JSUoMWruw9a+cBPRiIJ9xWNP3u6d2t6Rem0kM60oOq+IQwBv3HTrti76lxTmpxA2tZJ2twcCgyIhNbm0EiHzWVWFuQNFoG2C0NSAe2JxSnSXnq+ntEU1yzvPqqFYrZh/S03lYJBwEBcnIfNFWYHMGWAc9Bc5JNQOAmr4RkEA+iRdgu+0SIaooHSBRUzOiJj1m3I8oc/aHhHswcXDv4EU4os=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966006)(40470700004)(36840700001)(83380400001)(4744005)(1076003)(2616005)(336012)(426003)(47076005)(36860700001)(16526019)(186003)(8936002)(36756003)(2906002)(8676002)(5660300002)(4326008)(70206006)(70586007)(316002)(40480700001)(6636002)(86362001)(82310400005)(54906003)(478600001)(110136005)(7696005)(41300700001)(6666004)(26005)(40460700003)(82740400003)(81166007)(356005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 03:17:58.9139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcdd2da-25b7-4624-f388-08da743599db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
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
Cc: Hawking.Zhang@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant reference of header file dev_printk.h

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index c9821f89eeed..c39e8b333181 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -20,7 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
-#include <linux/dev_printk.h>
 #include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_psp.h"
-- 
2.25.1

