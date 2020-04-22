Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F265BC55189
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F9F2076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e/Zpu7uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F9F2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F0789E50;
	Wed, 22 Apr 2020 22:08:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B13889E32
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNFjl0s8NBtfP2WKpSfDdgpdI/XpnBwa1NXY/8xzidTXlxT9hnpA7SUjT2c54qfHuSunsJkGqa1FseKqKXCfE57cJgVX0LJhsZd7OnQjGr57Iq0P98xRAO+dDzk9jBnbUztxJG16ID/wYlHzWCa828r6OJEPX8dxSBtIElzenjhepWmN6HrEvfTHHz98naWMqtB7bnf2tFtHk3mFOkFLSkrOJGAwHRhV9XaVsyuIx1P3SAfCxBBjdxuSw0ZVW2+9aXZWW8RJJ/CBhTQGm/36uTf1rWJUtqyiQGO64eOu0rqTIFMxCXNIDDmBt3gEnE+ELDWQC5J9pwPGXnFiPsO5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjl054B9MqG6kqXHb7ETiNpzortZe2HR+QZqCHq5K1Y=;
 b=OsgfGsuVQBBtpYINlGWLV87lM/aLew858ZLfIwJ97OYo6i5k59NfakaewrTOFwnPg9yYirFkUHbuc7lx3TLOwVuytt+hbSDh3WEVR4VcOLaDuTw8nUt5d1wMa//CV0F5HozO54p3LkpU+uI8vWXBkmON/nxF8cc85uwKaS6OzAsg+OgEBOtJOHu1C/O2u3xx+yDKm10Zdu2UeBq6F5AgG0eUlycOMY20mhSxE0qe3EDl0C6xKeAB/HtfG1rqk8Joce0qVY8nVOufJDcs4+UkGaq7FZLTd7cx9+kXdtL8DkTBojo08xhHOHvn4MNM1NUfKfcWx1gnCSGNgVL5SGZG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjl054B9MqG6kqXHb7ETiNpzortZe2HR+QZqCHq5K1Y=;
 b=e/Zpu7uokophdr6ch7XwUglhbLgSE+jJ7KmPg88v6cffGOl1y9oVFUs36fTdrxWHKseSYZGBYDUwryE4x8yro1L9NRsx6bMg2bI1/NblQO6FbjFgyJlbeuHfw0IdC5dQ7ou+hXrwVxoWlyl9VcDbUuPbE0Mw4fy9s8P1GdSO2a4=
Received: from MWHPR12CA0036.namprd12.prod.outlook.com (2603:10b6:301:2::22)
 by CY4PR12MB1334.namprd12.prod.outlook.com (2603:10b6:903:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Wed, 22 Apr
 2020 22:08:14 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::e3) by MWHPR12CA0036.outlook.office365.com
 (2603:10b6:301:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:14 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:13 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:12 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:11 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/19] drm/amd/display: clean up some header paths
Date: Wed, 22 Apr 2020 18:07:50 -0400
Message-ID: <20200422220805.15759-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(428003)(46966005)(54906003)(81156014)(8676002)(8936002)(7696005)(47076004)(1076003)(6916009)(82310400002)(26005)(5660300002)(4326008)(6666004)(44832011)(478600001)(36756003)(70206006)(70586007)(316002)(2616005)(426003)(82740400003)(336012)(356005)(81166007)(86362001)(186003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cd00cd9-4c76-498f-a93a-08d7e709a704
X-MS-TrafficTypeDiagnostic: CY4PR12MB1334:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13340CE07BA3FD156D42C1C58BD20@CY4PR12MB1334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EGZ7qELmaOop6W2ACI7tENJ9eP7l95fQDiv3Fsy4ul8pLf3NSrTaTUtyNaBh/ihQn2g3hRUPQSxmEQtq14XwNYUVofRUb8OjUvmYNnxCwBF1dkR6ZP/8BP8JAit4t13v3Y/dIJDco1i0mvgZDhzXQZtrV2xO6YU2YiNUjp3SZB3r2yCoE7xwEYoz9j55rJGyRHgD/wq3z73+R7XKvrXsFcxxcL38s1K9Wag/qfVW6Nl5Zo9vvjvzayRMw6KW/1dtwE/fjFufOVwhdwb0cEfajiitT/Ue/QOmt6xM3Gd73DQicyNq6Pap+856J70u2ve/Iqt546mUSZtfJSWDkONxAiB9npZtpBbOQK1aFpLuOYV1n/nlJxBvAyWdlwaKW+frOgPXT3wz6pAWkfNkKs2YV83GbzaHADEsG2nTvVyYu6jXGVhJX72LtwmVsFhtwvuZmDG2luOeplzD+G40QJXntyyILjrS2BvFQHsiKfMxtKu9Gz7w7Hk3TZi4deXRPCFNJHRQtRq8AhSbQ0E8aL7wqw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:13.7397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd00cd9-4c76-498f-a93a-08d7e709a704
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1334
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
Some include paths don't need to have relative paths
And some types missing

[How]
make some changes to headers and modify include path

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h      |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c     |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c     |  4 ++--
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  5 -----
 drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h | 11 +++++++++++
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 754b6077539c..855431483699 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -27,7 +27,7 @@
 #define _DMUB_DC_SRV_H_
 
 #include "os_types.h"
-#include "../dmub/inc/dmub_cmd.h"
+#include "dmub/inc/dmub_cmd.h"
 
 struct dmub_srv;
 struct dmub_cmd_header;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index a19f359e45d7..992d869188c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -27,7 +27,7 @@
 #include "dce_abm.h"
 #include "dc.h"
 #include "dc_dmub_srv.h"
-#include "../../dmub/inc/dmub_srv.h"
+#include "dmub/inc/dmub_srv.h"
 #include "core_types.h"
 #include "dm_services.h"
 #include "reg_helper.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 3b8a49e8e665..7b32e5d60ed6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -26,8 +26,8 @@
 #include "dmub_psr.h"
 #include "dc.h"
 #include "dc_dmub_srv.h"
-#include "../../dmub/inc/dmub_srv.h"
-#include "../../dmub/inc/dmub_gpint_cmd.h"
+#include "dmub/inc/dmub_srv.h"
+#include "dmub/inc/dmub_gpint_cmd.h"
 #include "core_types.h"
 
 #define MAX_PIPES 6
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7c7a3561b6aa..6b48285446c3 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -215,11 +215,6 @@ struct dmub_rb_cmd_dpphy_init {
 	uint8_t reserved[60];
 };
 
-struct dmub_psr_debug_flags {
-	uint8_t visual_confirm : 1;
-	uint8_t reserved : 7;
-};
-
 struct dmub_cmd_psr_copy_settings_data {
 	uint16_t psr_level;
 	uint8_t dpp_inst;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h
index 41d524b0db2f..bed5b023a396 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h
@@ -49,6 +49,12 @@ extern "C" {
 #define dmub_udelay(microseconds) udelay(microseconds)
 #endif
 
+/* Maximum number of streams on any ASIC. */
+#define DMUB_MAX_STREAMS 6
+
+/* Maximum number of planes on any ASIC. */
+#define DMUB_MAX_PLANES 6
+
 union dmub_addr {
 	struct {
 		uint32_t low_part;
@@ -57,6 +63,11 @@ union dmub_addr {
 	uint64_t quad_part;
 };
 
+struct dmub_psr_debug_flags {
+	uint8_t visual_confirm : 1;
+	uint8_t reserved : 7;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
