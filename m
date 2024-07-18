Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4669C3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 04:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7D110E480;
	Thu, 18 Jul 2024 04:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WWkob9Nr";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B5FD10E480
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 04:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zn+8S2wTO34ApeB7vPB6Gtire04Pve1P3eI5LCTDEoddoU7dnUPxEaY036oc7B+dohPASHiVwM5Ucs6KD1BtVLCQgNmum5SV8XybxHMGnhZVB6s9h8/kL5Dnf7Idj4P6i12eUfeq6pMjRpK+FYg/uQaP+ZEREnhCnMBTtynt1JZ2TFOYdcnrqdfqGYIjynJ5egfQokl7bzuqV+Ro/rDg4CocLW+O7TJYCkcZu5M5hRuHbybYmSxSZ0+pFjvRVOSLGaNbr4eypf2bPL6CvHFKybURxaseg7pZUBFkza4QzqzduEjKhr006BRpnfpNmRmN/cDA15GbUm4S1FuO08qCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0BrEP3BNFQefsBrF6xiMsQ/YtyV+WPA2qFaWGiOHCc=;
 b=HVqLUPr4DK9Dfh/Snmk/S3QuvOQJcDkEwDN8CFqHoTjeg3kkRfBwUDMlcXW4y9MFpPoIJkST7kGW+ZBpt8RImmCkAKx1fjE68CzhvYoqLriWzMRimBwYHijKFjPIMsyhKaWLiq1GlKg/H4UZ8G5mzSDAq7V+ygT5tgyJBg9wExk2MgSXdaveT8DiLBq71iAnAm2C1ePgVK8TX/Kl0vbPRGyFecwsGImnGloXDuPehpvvp1BnUOaqtFVBZiuQUQ8RkHAxaeKX1L/fLVIJo2yGbUVaoXzg9Ok5q9047YR/Agd7SoOeLyHxcVQvyLIhuAPUEzePQkEvuWssuPPh4dyAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0BrEP3BNFQefsBrF6xiMsQ/YtyV+WPA2qFaWGiOHCc=;
 b=WWkob9Nrw14Zdf6e6w5EukQsaCV16uEkLU936KpeAAuBHHPzzjhyTDupKxaxaHxoiR73yoolQAtoijwNZVKYMMJOfMBqXXBDXNET7ac4OCc/kIZTL1XFhcPG2NbT5ZwoOQBsPuvToJh4niM0WOLExK5kujy1dDxGxiFXs6ad3XU=
Received: from BY5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:1e0::23)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 18 Jul
 2024 04:04:31 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::46) by BY5PR03CA0013.outlook.office365.com
 (2603:10b6:a03:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Thu, 18 Jul 2024 04:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 04:04:31 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 23:04:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Add 'pstate_keepout' kdoc entry in
 'optc1_program_timing'
Date: Thu, 18 Jul 2024 09:33:44 +0530
Message-ID: <20240718040344.1370693-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 882b62ea-12e6-4fb2-055f-08dca6deba33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R9JJqesAAvkyEyhS+wxI/dYuUN0rf81bltDVdVIkQFWpCpaXOJFaLrxrXJm5?=
 =?us-ascii?Q?coHo9N6WaOWwBjJYgg70E5fX2n+RF3LS1s6oCGOZAOE6OQlNzs9PRG1vZcjP?=
 =?us-ascii?Q?R20C59vvk++PVmWlgCACCwN0Cz6ta9mchbGvc4nkyWQvY5gm1VgrYtndLPL6?=
 =?us-ascii?Q?rbjcyuPlJ6ZGYqZzqIAGsEvquHzyLxiqKRrdD4+Fb5MtbiDw9Ia/ongRMa/r?=
 =?us-ascii?Q?EelaMwzWAkL3KbkbbMDMLxr1TCvEWHr0l8oHov1K73qUJIksSL5rESLE6wVt?=
 =?us-ascii?Q?GnAHAe7Se1Bey+MGrz+bAGrocQwt3HYWs9/QcCA7tVdob3SB3V/9Q0LtR2vk?=
 =?us-ascii?Q?yRa0SJeNl+Hmc3hghYjzQ5bI23kncOW7IKAeJ5La1zvc98y9Q8XdCgkfxzR8?=
 =?us-ascii?Q?fTgbsS49TBcizVfawWzQYFn/PneDp4xBetPH6KLez+eKNOPwMSwF/FYoxvdg?=
 =?us-ascii?Q?m/3rQtTbFpWF5uzpFfrOUufwqvCLz9Bc3ErOX1YjQHTvQEP8Lem/T4L9GnoX?=
 =?us-ascii?Q?4SKpoZgRGksPQEUjldy8uAKyLa88qZbYyBEC3A1j7LuLf1UN0Ro5r+wJ9C5I?=
 =?us-ascii?Q?ofwDuRiDW64CQuWd4UlA8NW/3wgPNISrz8g81xivOJT41IQ7ee9NI3H86eOJ?=
 =?us-ascii?Q?bfqj1P0thtUlN2NxI3FtJVm73Wx5Kt9IVE6BFxT6B7abRMihkj+dhut5nlDL?=
 =?us-ascii?Q?ZLdkxIYZtmxxjVA16t5dk7a55nwC297lo93rhr4LUvtPseIFplhvsievMx+f?=
 =?us-ascii?Q?lcKDpgsTOFOiuLA5/LyQsseLhTqzszfrUIBz2f7e6b4tm1Wc7BIYwqP6uRlC?=
 =?us-ascii?Q?LaRoPOkJZeA3t3IQbcn0t3qrxCMpCiYRenD58JxBH4uxsY1yyVIrvNttKhZg?=
 =?us-ascii?Q?xFz06XnKqzjlXLuicS5PaCoL/92/tbSDH9WWNUYAON+OcnZI68lQDPuyPlDg?=
 =?us-ascii?Q?cchFK4RpXIqLzWcWmP+tBM24uB9m9gZadKr/jfgelTkKA6AgpC+C2NIF74wS?=
 =?us-ascii?Q?yXiUQx8j+DZO5poV2I1d/RXTpcCF/fYQK2YlWCxZDo5Un62wX09HrLdskjjG?=
 =?us-ascii?Q?juuvX2TaNrg6ZWYuhKbPaDSY73tV0k2cj1ZdthcX5CSmM+2BNx8HPQUDKYLy?=
 =?us-ascii?Q?UbHh4Xwh45vzk955F4Xv1zYkpwKN9BOJ58RnSek+PrRPUO+SskKteqOB3Kzp?=
 =?us-ascii?Q?Tn/wqrwSHZ/MxiijHUk6gakFPa1DzgYJEprRvl9E4aF85czS5+naF+Zd8Pss?=
 =?us-ascii?Q?pI7BSv7esuOYNIJ2BM8MQy//Yh9AJhcfEeSoHQgJA7ve7fV2VrBx9hGC0TXo?=
 =?us-ascii?Q?smWA0aWTYRb6UyCzERi4KPxA8/OYalNzeIBv7kvJYVTjt/kKu0S+JngJfjiE?=
 =?us-ascii?Q?vNft7inxSre0XJNwRxPuhc3xVAwzvEnecvXm03ArX+UOqBAjCB5WsqONigyH?=
 =?us-ascii?Q?uThgGyoxkdG1mFLHdHmdOz2GEcJ1G/W7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 04:04:31.5061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 882b62ea-12e6-4fb2-055f-08dca6deba33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121
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

Fixes the below with gcc W=1:
Function parameter or struct member 'pstate_keepout' not described in 'optc1_program_timing'

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index f00d27b7c6fe..097d06023e64 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -148,6 +148,7 @@ void optc1_setup_vertical_interrupt2(
  * @vstartup_start: Vstartup period.
  * @vupdate_offset: Vupdate starting position.
  * @vupdate_width: Vupdate duration.
+ * @pstate_keepout: determines low power mode timing during refresh
  * @signal: DC signal types.
  * @use_vbios: to program timings from BIOS command table.
  *
-- 
2.34.1

