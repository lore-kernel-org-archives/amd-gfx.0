Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15CBF4613B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 15:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8993E10E3DF;
	Mon, 23 Mar 2026 15:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S0BiL71O";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B0010E120
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 15:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIEaPCsUP91SlEADjzuWgPhFR2zKqR6f5xLc+w9nlSpH+m3+1dyiLL0+gaIDkF3g3Xl8yRWSN9+P+Y9vuCssB5uUtZHmOHARuRTzr7ENKJwggAoDBy1GfNwd/QvrP2gJq/1w/J0CGJDZQepdHIeR9wNcUR2WHLNlBZeERKFWvpo/nCk/gayI58aNuDU0D7qCWoSE2BVluM5YrpZmERVlKy/Y0pBNFk+ZbnCLIrGVK9KapJhGsJdgI6kyt4nV8fCORH85iMdCibVn28r1Z/Uj+RCHjw1RewhtSZiuuyc1b77ErrzMw0D/OJpPNd6r35NQ/5CZfOrEhRbhx1pjI8goLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QduxPvS3GIsEzCxzn0W0ZVJ4QAw5yHHsw1KzDTBaudQ=;
 b=eOksFQzYyv/HKN34au/3IezrZYukdwhAlJVFkH7H2WB4CnbTnE74XHEzfu4x4IdTy7SjWVBQffK/C9Dcy5clKu7rPgoJ8KVBACAXZIs1nxHYeXEki2SzGjnuTsOQ0NVWjp/36y7jflt5SKFwf5ZbdA8n8SflT+pBeLqaT9Z0Jo2+Iy3iUgMuKbYayVLROvvqeRK0LPvuU83qfqNKfHSgtZo5x7yuavhlNckNUxLzFiTAyDnkXNPq8asxih3uYAMYLp0Sa+YPgJwdhKPhUvyGxAli1oFzjVIlqxPUSjSrQrqlrCdyFfaainuTyzoqWZ5XTJ5ZbOsxbj0aHGB1ZbYIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QduxPvS3GIsEzCxzn0W0ZVJ4QAw5yHHsw1KzDTBaudQ=;
 b=S0BiL71O9rTumCLcfbYKx9Z2UMykLU4+xeyKF6k/Ky2WYRWBgWZ0Nd97sQHQs+Gdx5SoAawdsEtD+JqycziximxDkhH9DDC57HLFKTFOYkXVIHzjrGMbvwNzbEXqXia6kWir0VHvr8FLFudpQWjTFBx1wtrtwOyYaac03gKtbtU=
Received: from SJ0PR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:33f::13)
 by BN7PPF8FCE094C0.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 23 Mar
 2026 15:41:20 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::cc) by SJ0PR05CA0038.outlook.office365.com
 (2603:10b6:a03:33f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 15:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 15:41:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 23 Mar
 2026 10:41:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Mar
 2026 10:39:33 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 10:39:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 1/3] drm/amd/display: check if ext_caps is valid in BL setup
Date: Mon, 23 Mar 2026 11:39:21 -0400
Message-ID: <20260323153923.1055788-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|BN7PPF8FCE094C0:EE_
X-MS-Office365-Filtering-Correlation-Id: f49eaf86-18d1-45db-f4f5-08de88f2a0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CivtKseX8UcZcewMB5bF+56rqADhRIjhIIHm4MPbx5znzeMFoO4HscGdY0Z2ZRP2SC9QjqrGGLWapO6JJnAbWsDA/1LSvs72cyvjCLTSU5tlB8V0NJMhh9MpMfyEUTJHGXNKig5euGtgU6uVFGLu1nCYvOpz4pwYaBE/g64Yja2GparqjecQKj3Vqje1NA+52BUKQvX29/iWzBrOyO782Gc6iPqz6FMBJYst4yzVh1IxTax9wtWbmu6vxRDH7w9LxOoaoB/nqoAwVYrDPzvuQ0JSCz+IUtpMiiGQEiMjNyP+SxevV+hzN0GK9pZH3Ey7he7AWOrs1tJ6ntvtY/5S49FG4zF793xSy88dS7/9EbA9mQlOHruzej62Gt7n2NiOjUqdPwP+WOsTcTV2gxUWtMLCmtZbOrnoGxqAnmEFLvK3ZMSzPBhruLBEhDtPfvcVS7koA68NBOeORtpddRcI8M1S9br35h7oCHAQ4oUWApryND4RtRl+gTFkoDVAqCn3kSQa8MCSpQ9l98zC8yQn1ASxxZ2B8yVn3CSO7OAv75uD5FtMyKrWR9CA3NaMse29ODJBptnLweF6BOzCCAtCYAD27ZaG2WQbAMjoerftxVT++/CW1do97aR0f+D+s12OwVVjKuarcgrk+t6Pg7QvdEPi1C9/kOfIi+OJ7CpjtgtSxIuBHFgNrG1wAYnFbMDsxvLw6eeNG93ZBdTjF4EpDseOYEjB8a0M49f+TpLyVWk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y0exJB63KNWR282tCbNjU320D4f48yBczOduwVFQe6w4DLFeQ9Y5dBxGx45PXn/ox7sk+yBZR/7U5gKZNt/nax02hFW4VNBYvtcxWmRas0mem4vm+TgAUmD4w0uqpLea+NrLWROWdz/f28rdkuxFSFPHG25xWF/qFg1scvkTomw7ZCupwNjptxdAQz0PqgUDFHYgxceGPRBacbmjCD8UMMucP9gJ5hClPdd9jR3VVv5V0UK/RROo7wO98BwX6ni7GY355XAlkF950Ys3H3UroBegreXf4yqQFPxWOH5/hg51YR0O0JBe/C5tLEeHBQ6gV1rnqYiOy49Rj01+wKajiOsQ0sGBM33IjqbtBg1HOFik+GM2ps/LbKyb8GQCfBbOuEdjmyVmeBkGbPK51pA8/VjGwRIrQ7S2uAlHqpfSUz/0Cuk1ORsk38fQR01nMuiC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 15:41:19.1109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f49eaf86-18d1-45db-f4f5-08de88f2a0aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF8FCE094C0
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

LVDS connectors don't have extended backlight caps so check
if the pointer is valid before accessing it.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5012
Fixes: 1454642960b0 ("drm/amd: Re-introduce property to control adaptive backlight modulation")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0955c2318ef2f..a347f48e3cd89 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5417,7 +5417,7 @@ static void setup_backlight_device(struct amdgpu_display_manager *dm,
 	caps = &dm->backlight_caps[aconnector->bl_idx];
 
 	/* Only offer ABM property when non-OLED and user didn't turn off by module parameter */
-	if (!caps->ext_caps->bits.oled && amdgpu_dm_abm_level < 0)
+	if (caps->ext_caps && !caps->ext_caps->bits.oled && amdgpu_dm_abm_level < 0)
 		drm_object_attach_property(&aconnector->base.base,
 					   dm->adev->mode_info.abm_level_property,
 					   ABM_SYSFS_CONTROL);
-- 
2.53.0

