Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D020EC00140
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 15:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F20BDACD96;
	Wed, 24 Aug 2022 15:30:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA317ADA2E
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYzxW7Ugz6rb+1EqxY1L61+DcD5fkGgpf62P9IqZJ/GpSoi+iEWodNXevWk16BtMcMXyfdwj4wZagrm21C5yIvc5+jX+4/B7OSdYiskydt/sKKgc1GO+3h9t57WlV4oYwOgJ7JGeedUKlyU2SW826CUzwiZ0dq5OGC2ZyazrWiL9AXZ1DmRbM39n+zK1QYAtmdtT3FbrGG7BWDMnTm3OIkp/F6/D0uH6j6Z860t59VnaOTs8mkFJ8mP1xUvDJsCEMNWtQ+iJsRxyzT3FzAZmu1sZeGrzOMLCWp8tjkJIKsf1jc3uOu95jgBQJ/v4fN/og/CiKb+PfXZdGh15Q7P0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTsm3NKG+kXr+sLuSvEEj2p4chF5P4DiA/7wi3C19v0=;
 b=hZgv8qkRlPY0hXrw7jdvtpNg0Xh/zFVCtz7ImVAioLsYt2l+biJXIoP2hzC8O1jX3r+3OjJ0vugrOCiDpuZL0k+uyJTKbRbs635Ldv0TZvPA4ja2gZA2O3piCF/C3XVm5hGO1gxasPEOOkwufSqSqMjZ6jHwZ3DDizoAOfiY6SVzbjGXz+OmgMmhO26Zyu4iB3A11ki7/gWA06gjE7BeZzu9E6aB/SZSYwRwvsxjwXJgsXejZe8v5pKj3aOYaBgsIbhzDjlWAlCfiI1sZjwQOR8y+1dgHMi7XrdLF2/b5zWQmAytWevvgQwaWOCZZsWrttberWJ2S2E7JKmek76VgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTsm3NKG+kXr+sLuSvEEj2p4chF5P4DiA/7wi3C19v0=;
 b=i5zftYubeWAI+PVJz3l7c3zd0vkCEYZMq/Zz3kE77aGOctRVWXHiL56+q+oI521tN3nW8ALR3VcrHb8VeUFvizjF05rv7/t+p/tJzCxvSLm+QhK0fB82tkzm1YZFPtxtQ/mSF/miOBwUwKNDcTrwGd4v/HvI01fsSVGwKal5EmI=
Received: from BN6PR17CA0050.namprd17.prod.outlook.com (2603:10b6:405:75::39)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sat, 13 Aug
 2022 02:13:16 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::e0) by BN6PR17CA0050.outlook.office365.com
 (2603:10b6:405:75::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.30 via Frontend
 Transport; Sat, 13 Aug 2022 02:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 02:13:16 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:13:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 19:13:15 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:13:11
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amd/display: Modify header inclusion pattern
Date: Sat, 13 Aug 2022 06:12:18 +0800
Message-ID: <20220812221222.1700948-11-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4b25ab2-a78a-4c26-a3bb-08da7cd16202
X-MS-TrafficTypeDiagnostic: CH2PR12MB4294:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXumfSOxjqTZk1bBkNq1WpXyZoYaOnS27ppuSKQV36tlHGL663wwPYKCIBzei6z6cCs33RlplzJVTl1+iikeSwEMA4Hu6Ub1x/5Arhf4C3IuN4HweK+DnySC4uplmaJFFB+VVy/j+mtezex+PQuzY8+ojSkXrRSeJWO9yIj2ysSeUzBQQzBbY22UR3Cldwwyzoz7g0Cml3X3tiX8B7vIofcBsl4S0C2r3/uP5wKOmATDK15davMbQOvF3/iRe3WnV21ojEMYUc3nzOa8kZzGZyPG1PkHP8nbSLLX3QlhpwOWBgwEbZvPhpxPIbyOsaQrYt3YavvThYaozfitHkkrBMNzm9eH/LZV4M2WdWRCfxeNvzwVuyBm9+GbinDmOT4BGkpPNNjUDAsCdftY3k3HXHiHeMP37wUG1Hd7nqM7iNg9LV+RtbyDE0+Xp/Vt5SYqsCAyXCCjg/tAbW6NRBCQr3i3DhPxsOpAGoLej85E8lPPJrh3vI2WYsNTJaErJ/QFKtM9AaCmAq8M41XMY0kbw9MAmZCVYq5u7jBVNXsTC8qsLpzOCIstS/ZSdgV3lXlOA2OZQaFIezKsAOHGKaORIMjn2Ez9uUGhZ2WoshT+wx2AoJdV8ICSeAKDlbh8mryIW7osGLaWxD+9mfFR+euPzeUnbt1IeFYrTLFH1ZQd2AQw2g2ghGtnK0RVozWN7U3HXlm4hkdfyXljw4/6cctNc50u9Vdu8g4Nm0JszpscIu2Ue8w1j8ocig0ebuE2JllbuI3XVvqxhy6uLK83gz/FI7QlP4Dma3NeEP94BKzcWpEZcnQ5QbUg+jvdP6xe1dVC4XjKHpmvDqMsUy1hKAxJp4Ql/8VKblQf1NPHumwJXGE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(40470700004)(46966006)(36840700001)(70586007)(54906003)(356005)(81166007)(316002)(40480700001)(86362001)(8936002)(6916009)(5660300002)(8676002)(2616005)(336012)(26005)(83380400001)(36860700001)(426003)(82310400005)(47076005)(70206006)(41300700001)(1076003)(186003)(7696005)(478600001)(82740400003)(40460700003)(4326008)(36756003)(2906002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:13:16.0070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b25ab2-a78a-4c26-a3bb-08da7cd16202
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chaitanya Dhere <chaitanya.dhere@amd.com>

[Why]
Recent backport from opensource broke the Nightly tool build
that tests DC and DML for bugs and regressions. This was
because the backport had a header inclusion that was not
consistent with the AMD style of including headers was allowed
to be merged back in DML code that caused tool compilation
failures.

[How]
Modify the way in which the header file in included so that it
is consistent with AMD style of including headers. This then
automatically fixes the tool compilation process and also
helps maintain the code quality and consistency.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c  | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 3fab19134480..d63b4209b14c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -26,7 +26,7 @@
 #include "dc.h"
 #include "dc_link.h"
 #include "../display_mode_lib.h"
-#include "dml/dcn30/display_mode_vba_30.h"
+#include "../dcn30/display_mode_vba_30.h"
 #include "display_mode_vba_31.h"
 #include "../dml_inline_defs.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index 66b82e4f05c6..35d10b4d018b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -27,7 +27,7 @@
 #include "../display_mode_vba.h"
 #include "../dml_inline_defs.h"
 #include "display_rq_dlg_calc_31.h"
-#include "dml/dcn30/display_mode_vba_30.h"
+#include "../dcn30/display_mode_vba_30.h"
 
 static bool is_dual_plane(enum source_format_class source_format)
 {
-- 
2.25.1

