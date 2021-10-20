Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE35C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 13:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5F3611C6
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 13:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C5F3611C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6956896E7;
	Wed, 20 Oct 2021 13:55:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B698896E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 13:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbVn5OVmrcvMh6Ee10pXx5FM1mL8SWgKHdwglLQdK5OdvWDz6vBE4AjhO/jsG+FPjz7Hme6FW3xnLpo7QgHKPRfNX4ygAPwYeNckhd3KZaUdL+u94OZXU3/oTRs59gOHIx+W5SAxWiE//SIUjVkjYhJmFwr5uiakaHirOUjnsq32purMTGNQ3S+/nj/lMGtIevBir0KtAm3uTNBZvETBwlQGhoPuoWs9VopXYA+IQjobTkQfVLL2c9RTrQX8J233HKrCIHibIOzGwiNOXhjcsgrg0fDzpJZeqtr4k8Vo2wvqSqoqlGbz5m4iGmzA5KQYRxkF4NTPYeKpg6ATy6BF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUoGAnyV+kK3RQcmUORLcXxYYW389E1qe73X956sP14=;
 b=RJ1hveANLsqckFWVk+Ywcl9Vi+5UbDx8WIUNay+wvBmsMq+d4VbZIkG8i6+uyDwvlJcz3A/pjdGEeGyKloQy5Jy+SMAAfpNofV7nAyUAh5udqZ+mh6x7njS93D1//SjD2NVuB+zNgceS7iIXs9LoKPnfZ84Q7HC12aAV56moUqIHNyXocwtKWZeB5k+Ty2dWJX0u/h2xt+rHwNxS9MxrPStPDZJ1Jq7DV1wdYx148fW5iapIgeYjW8Ur4JF9WXDucl5q5fmJwjmYEQwpmtg9sJBZTyzD356hH06zx0gX08ypc7EE0gwbQ/rkZ+fnUScG/nxZuo3rkoTeVNtJDEwmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUoGAnyV+kK3RQcmUORLcXxYYW389E1qe73X956sP14=;
 b=5gzayjWiane8dmRnUzyB0HybgIBT2elUWjSvfRmctzxDmiAAmk6UVYC699D3v0YmKCImJQ9Ixu1AqCuHBVlqTMd2KULWVQf/xZNSKTvaxT9Uxt9nw++1olsMpZSpxj56q+4Nnzrhs6gKyjhO7mrPABVhvYWja0N39IDbASYMprM=
Received: from BN0PR10CA0026.namprd10.prod.outlook.com (2603:10b6:408:143::21)
 by CH2PR12MB4005.namprd12.prod.outlook.com (2603:10b6:610:22::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 13:55:12 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::74) by BN0PR10CA0026.outlook.office365.com
 (2603:10b6:408:143::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Wed, 20 Oct 2021 13:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 13:55:12 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 08:55:11 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: move dpcs headers to dpcs directory
Date: Wed, 20 Oct 2021 09:54:52 -0400
Message-ID: <20211020135452.423205-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b29e9bc8-a6e9-4e47-bfa6-08d993d13c70
X-MS-TrafficTypeDiagnostic: CH2PR12MB4005:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40055C215E4AFA9824B7C4DAF7BE9@CH2PR12MB4005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cau9ohB8iW0ol4zYe48SPOaEfIubdu/+Q9UdOgy3zW5hbm6lAiNEINRIOJbGpG7t8mWsgcbPNVI2JwSKOhrr1dxjgRpndLUcRIhHZxeL2aNkL7hLLAWus7CJ8XGkBK+KwTz98gVs/LeiBdyknFP29KZ/wVdF0QNOdI/c4jNlLbevh7b0jI1pRfaOY++dOvVpwScpT6awvxGBZzWfOhcxzJezYmcQ/qqy0ekoAQL4nOkF3e0Jl8JyQZ8l2NfAxZ86m/mDEWuL1NG60VU5RUF+Lv92wl6oFQ6VXCmi5ffKbjqvV+a+pT8amwfJEj+iQIYZfbQJTH20vjAwbwYCTWdaa5SoJbZYGE4QZa/J15aXHqLiAbrqtlHTD9lLOPPRkKkkJROEUffIDmQJ5Go2DApdednLUovG3lPzZvjfjMMPYoRGmGTCuEu+HgO9kQB3sqftPSLwJkw9kQgB31gXCyW5F0cUgOfmuVUwdldCsIBbKs8zHdICt/2tPjNe3j+r76k/JbdFMiUT9gQGdBQ/aXnkahmeMH4IwapJ7u4e6YmiNxlVO0hC9qRVHzlSyjrlwIldQBP9hqO8C274OTNAxjvGbD1Ns7uOMLyatO7KqzR3PiG1D3vp9fmHt2+4AC0+Q8uCAsSui5NmrKEyohU4bnlmCwr9+vXKeF3K6uHc1ruMBk3G9dQbd+N6oFPNaWS4uQ9IAhzdUI/gTD+XlVN5cMjyNK7vzrHsvQvPaOGXSKn3nZo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(1076003)(316002)(186003)(2616005)(70206006)(356005)(81166007)(70586007)(508600001)(426003)(2906002)(336012)(6666004)(8936002)(8676002)(4326008)(82310400003)(36860700001)(36756003)(47076005)(26005)(6916009)(5660300002)(16526019)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 13:55:12.0666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b29e9bc8-a6e9-4e47-bfa6-08d993d13c70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4005
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move dpcs headers from asic_reg/dcn to asic_reg/dpcs.

Update various .c files to include new path.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c         | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c       | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c       | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c       | 4 ++--
 drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c  | 4 ++--
 .../gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c    | 4 ++--
 drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c  | 4 ++--
 .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_0_offset.h    | 0
 .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_0_sh_mask.h   | 0
 .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_offset.h    | 0
 .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_sh_mask.h   | 0
 12 files changed, 16 insertions(+), 16 deletions(-)
 rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_0_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_0_sh_mask.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_sh_mask.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 1861a147a7fa..7d4be9d727a7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -42,8 +42,8 @@
 
 #include "nbio/nbio_7_4_offset.h"
 
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 
 #include "mmhub/mmhub_2_0_0_offset.h"
 #include "mmhub/mmhub_2_0_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 3a8a3214f770..aa5ea6656a8d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -72,8 +72,8 @@
 
 #include "nbio/nbio_7_4_offset.h"
 
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 
 #include "mmhub/mmhub_2_0_0_offset.h"
 #include "mmhub/mmhub_2_0_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 5350c93d7772..8a312e0d9c1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -73,8 +73,8 @@
 
 #include "nbio/nbio_7_2_0_offset.h"
 
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 
 #include "reg_helper.h"
 #include "dce/dmub_abm.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index fcf96cf08c76..38f43f9cab5c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -64,8 +64,8 @@
 #include "dimgrey_cavefish_ip_offset.h"
 #include "dcn/dcn_3_0_2_offset.h"
 #include "dcn/dcn_3_0_2_sh_mask.h"
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 #include "nbio/nbio_7_4_offset.h"
 #include "amdgpu_socbb.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 2ce6eae7535d..e29220b3c67f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -48,8 +48,8 @@
 #include "sienna_cichlid_ip_offset.h"
 #include "dcn/dcn_3_0_3_offset.h"
 #include "dcn/dcn_3_0_3_sh_mask.h"
-#include "dcn/dpcs_3_0_3_offset.h"
-#include "dcn/dpcs_3_0_3_sh_mask.h"
+#include "dpcs/dpcs_3_0_3_offset.h"
+#include "dpcs/dpcs_3_0_3_sh_mask.h"
 #include "nbio/nbio_2_3_offset.h"
 
 #define DC_LOGGER_INIT(logger)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
index 5f6ae3edb755..3b7df1ac26be 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
@@ -42,8 +42,8 @@
 
 #include "nbio/nbio_7_4_offset.h"
 
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 
 #include "mmhub/mmhub_2_0_0_offset.h"
 #include "mmhub/mmhub_2_0_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
index 0046219a1cc7..6b6b7c7bd12f 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
@@ -40,8 +40,8 @@
 
 #include "nbio/nbio_7_4_offset.h"
 
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 
 #include "mmhub/mmhub_2_0_0_offset.h"
 #include "mmhub/mmhub_2_0_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index 914ce2ce1c2f..0b68c08fac3f 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -37,8 +37,8 @@
 
 #include "nbio/nbio_7_4_offset.h"
 
-#include "dcn/dpcs_3_0_0_offset.h"
-#include "dcn/dpcs_3_0_0_sh_mask.h"
+#include "dpcs/dpcs_3_0_0_offset.h"
+#include "dpcs/dpcs_3_0_0_sh_mask.h"
 
 #include "mmhub/mmhub_2_0_0_offset.h"
 #include "mmhub/mmhub_2_0_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_offset.h
similarity index 100%
rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_offset.h
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_sh_mask.h
similarity index 100%
rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h
rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_sh_mask.h
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_offset.h
similarity index 100%
rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_offset.h
rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_offset.h
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_sh_mask.h
similarity index 100%
rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h
rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_sh_mask.h
-- 
2.31.1

