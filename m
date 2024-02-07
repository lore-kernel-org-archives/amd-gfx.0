Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37B9C4829E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16C9810E5B5;
	Wed,  7 Feb 2024 20:52:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jiSddyZN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8024510E477
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij6lCY9j3l7bRQ4k5n/SlvjBeUAd5d5A9AxN3thkpWUsgjoj+EXYctOKDztjjnZpRrEZLHfhsCzCVndsvH9RinuMzpfGSii8vtYNbVMJEE8xx34CGOB3vYyNBK9Spb2rJHN2w7Z/C2YjA8ovaS7p4PmDC72PgoYon476s9nlQsI/PM94KiLGG7pYYInbwZrxTaUKKCO0yexRZ1JuZAyElxpmMRnXAbiGbfVygouVr8JO0RHLWkL7oZ+2afQTLz3mxYBUezz4HgeormhSGXPlTG8flSfJec7lFY+aTBPqyAZVY1OzOeHkV2AyLQXGJ9DX/8Vwac5ouhi/TCRVfYAKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYkm8XEC0mlKKdngTvCNEB0TXO8XNUm2w2x+PXVtCsc=;
 b=YMy0LaU7D0rarxB+7LdTPK0QkRl7o7X4CToewTImEORLYo6lDQW+rVyKG4VcL114lDDxnqPn5cd0eKU6eP0Jsv6ounW+SHwFI7XKj3H+JtInEEOXtJmOIlIwZnyoRfXqiwM6Li8IbECvRYXjD/MJ+Kg9HPIZ2F1wPOg/KuvZbbUZhxuPVwnZVDWaqWQR33I/O8ufXv1PYQCqJEJ/2LY2EaJOe60cpeavqzZXaRoM/apu9IH7J3Bdxjclp1fKd8UMMVqN4m57pljrEkZOMGz1/MLD4YeJuzjUlgB2pFwLlGvsrBKcYzHDS/jwKN+75u9uaJCZwrPUNtu3QvPXIHtoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYkm8XEC0mlKKdngTvCNEB0TXO8XNUm2w2x+PXVtCsc=;
 b=jiSddyZNLRVU7VD7R8oPq8Huk7pqnZXF9RMNttPrf/sa4nS8tvjt+UJwNvH/FFNpyzqe/1ur3h4SeKzMKO06yRrk/Yl1dU8yGgPcfHI6MnrEMPNeTfOoOp/7UOca++2Ry83uo8Doxka4aeyVwWbFH5T9KS0dNn8lEeK+8Kl0Tzw=
Received: from SJ0PR05CA0114.namprd05.prod.outlook.com (2603:10b6:a03:334::29)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.10; Wed, 7 Feb
 2024 20:52:23 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::6b) by SJ0PR05CA0114.outlook.office365.com
 (2603:10b6:a03:334::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:52:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:17 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:17 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:16 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>
Subject: [PATCH 13/15] drm/amd/display: Increase ips2_eval delay for DCN35
Date: Wed, 7 Feb 2024 15:50:48 -0500
Message-ID: <20240207205200.1608684-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: df1eb07b-bd27-40a3-9d46-08dc281eaeea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1kNqNVK11jR26TpWHPqMf2if6nSYnOkYf80wvWQErideVVVqkpvbYBSi205+fvk4qMGnz4t6/KUOlWJ42uEziZjebdGRHLHKjm6t+SfoPJBHSnrrgAGCgiW7+oAtI2Z14eA3+Th9+2PlbFMyaySQYorFNUAN0dXtu7iKA00P353PvW4FHRJZiRRtu6vybw7l4Fku1y1g+3fZVLExWR2bwoZgZWAOrUKpo1HLrLskvxYGbmgqG/CUsRtOTgGQ0pcsWXdM5HMWwAYs0zllrilZ0FFB2IvEmW+ZgD/KWjZepqQfGGOhuGmDkMsTdB8QYY/BTh74lEIgUYLuYkhQt2BXiEcbBQuM1bu9GzsSrA+h0zxlbt6V04jQnqVo5f8jTFnRBTgSrfEaFm06GSz2jIzOsIKb05IxzqLLBy+LGrPphlds1m82X8QoEkbYyHzFtom4Ps6lUfEP3DvE2IJkmawFRdq6ra4rBHqhsVCwb3pg9v1+4bDrHS34oldJSYm3Sz/fB5lDxgPlY+uHQ8mgOpVcvDKlt9SUIci/lFLsYmjzAkn1a8vitGZmqj42FOi4oU0204yymp0CisFxF4WC4XX6nnG8xIj3Hqs4R7Nsix4N7c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(46966006)(36840700001)(40470700004)(36756003)(86362001)(41300700001)(356005)(81166007)(2906002)(44832011)(5660300002)(83380400001)(336012)(426003)(82740400003)(6916009)(1076003)(2616005)(26005)(7696005)(478600001)(6666004)(70206006)(70586007)(54906003)(316002)(4326008)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:22.5540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df1eb07b-bd27-40a3-9d46-08dc281eaeea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
New worst-case measurement observed at 1897us.

[How]
Increase to 2000us to cover the new worst case + margin.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 28266b9a148a..5d52853cac96 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -781,7 +781,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.ignore_pg = true,
 	.psp_disabled_wa = true,
-	.ips2_eval_delay_us = 1650,
+	.ips2_eval_delay_us = 2000,
 	.ips2_entry_delay_us = 800,
 	.disable_dmub_reallow_idle = true,
 	.static_screen_wait_frames = 2,
-- 
2.43.0

