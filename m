Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BE7C3DA41
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 14:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE2E510E03D;
	Thu, 11 Jul 2024 14:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WwlYsaIs";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C7410E03D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 14:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/3eWwMtWJSR/syl0mjzsTco2svlPEGzOW4pIk7qsjnf9gr4Ik/uhoQcarVo1eX7eAWc1i0omQPuGRXgRBp7jg62WEKHjeqVZ/w8+lB2GTnHfkXn62vI2DjG492G6o4IxS0i+txo9J7SMb3PDm721TW2rLjYebNfsCPkzXCFUXxWXHN7GU7EIISUCfqhHYXTTI6lFI1gje/SIQqbhScYgPc0K5ZnJMCdjToWdUCRH8lBp5+VPzjLYTr/0/LOj426MduzrUAQgJ69s9cCHLL3Lg9QqV2yG97RtlKNtMufL/JXP3BQ9cqePsLZnsRZcRxVoR/n2pSyoNljGmOoNgHZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJIgfaBVN5PiaYnS8ZvGoaX+ZNyeqSfYPm0FRWnyT6o=;
 b=B2M1oLC1Nb5TE0L6ofgkM0hruYcLvvvBpfqcjQP8A7NIT1x4hw6kNaCn5Qrf2om2xvr8W5S8/KHILNO9qgXfHZj2QCTp/cqkdiWJNREgHw062j8ZxWq3kMaVvdwSq3pGMGKHdUwI5HdQCWnxlK5wyXcy00y4dXoW1f2p4fW8nyxTGZJGkyAm2W3JsYBqg9iCcnKeU+vvYb3eM2ujRyLEiUyjdc7wWJuD7bylIsTVpzT+pwr73hzqt0cmdVBCn0hMvqWpAXZ7el+J0DsuXek0i61xmj69rlO5+OuKcahSRZedTKN6BxFpnMkyu1OahoobsR5/cNFDZLZKwla9CrfhFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJIgfaBVN5PiaYnS8ZvGoaX+ZNyeqSfYPm0FRWnyT6o=;
 b=WwlYsaIsAEj0AE2yyHZSdZID4BPgntzJiKf3yHOw6arurWz/hWXPgIQyskccgwE307QjXja/4nN+u0vTEGDivKLQrzQOtrBmJZsNEQni60AsvdJo2UcH2BGMNC4WkykvFgOrrPp5oMs636/Zvg902hkvRxj8g2lkQpanVevAXDk=
Received: from PH7P220CA0039.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::26)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 14:31:33 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::53) by PH7P220CA0039.outlook.office365.com
 (2603:10b6:510:32b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Thu, 11 Jul 2024 14:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 14:31:33 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 09:31:31 -0500
From: <sunpeng.li@amd.com>
To: <chiahsuan.chung@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <Harry.Wentland@amd.com>, <Alexander.Deucher@amd.com>,
 <hamza.mahfooz@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] Revert "drm/amd/display: Reset freesync config before update
 new state"
Date: Thu, 11 Jul 2024 10:31:09 -0400
Message-ID: <20240711143109.13603-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 56613a77-acd3-4377-2e0e-08dca1b62995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xb9hbROS+kZ6MQSI81E/SLPG7Y4mytJHVTm9vYbWmLJ842GH0Psli1uhIITc?=
 =?us-ascii?Q?fGx8t9pfCqk6+HkOvl63TPdvA5tcCqoF8kdNCXtvocmFq6vOHImw28opeG7b?=
 =?us-ascii?Q?Q4jjUNWUiQlTbZ9rhVPSLARlmGK/W/GzWkS8HkIv6sGsoDJK+7pugoj8pUxO?=
 =?us-ascii?Q?pLRS6gE7iOOqhtEVR15VpUunUyJdoqQQqiSGtoSJcSwGFTFRZnpfFwcAEZI/?=
 =?us-ascii?Q?m9iCTC16pHySszs9JZd0v9hqW0vsLuKFlsnypijc2oNfS5wikWuW6nU7uKm4?=
 =?us-ascii?Q?vsJXXkf49jRa/6408FgCMyVltSP1Fesx1rrxwwU4o8m5DklfeVKjEV/D7exa?=
 =?us-ascii?Q?+Ny4WXCGccGhF2C6RA/aBsouBrJmAVSQjxSOJpslbz+YS4sJHhb4ikvuMvos?=
 =?us-ascii?Q?fnhjSfUla4EDi8rPzt2fJ0O4rrA4r707YvoYDP6Yf3e3V2n9dexgFdShxBB1?=
 =?us-ascii?Q?Uw3es7+m/z1t2rP5QMiOwogPZ2SjA43UrbFFhmWoMl3Xh/fSUDWR4pBmG4KP?=
 =?us-ascii?Q?L66DWTX+zLwH9JwJ83T9SA4k33nvF7XRZ9OEJ66DF5xXY2h+PRKRQD5TW5Ee?=
 =?us-ascii?Q?5GWC3t3xls6K/tyWl7aPeVyV03NvXExrYhz7lqGpTt6S5M6pVyfS0kw8YZEH?=
 =?us-ascii?Q?5lLL6euimCS8yOlipxiCDTdUPNZth4L97RZFx78B8YlpBFh8+4zoSZ3q4Gx/?=
 =?us-ascii?Q?T1ACx687KMv/jDdSTOvZLWaSaCLxU3j1LlbeQoXq5cLHqTUm27PzIQO2Lxnr?=
 =?us-ascii?Q?Fm+FNJaJl8Zt3Q1lP7k5/HsVdHBlP2o46fGayYyT1cPXnkPFbUO1+KfIFne1?=
 =?us-ascii?Q?HKyH5G5LvZ1JIHoWsg3RbDEPkqoSddDw3ffD6E5ppqbk8+oOCXkAdC64xH77?=
 =?us-ascii?Q?5U8rdihv14hslNwO8PJicbhuNIJdyik7ZbwkV7ZFmYMewNoPbquX3tef01Dc?=
 =?us-ascii?Q?vlDTDNy/tgRPkUTw3/cTN2ISdkbYVTyC+uuq9fU7VrL8ZCkzAC68PjF+Rjia?=
 =?us-ascii?Q?c4xjjYU70N3zPs5ApK5Z2h0ZWSlMxHls0EZ/rv2nybtO5lP2Up8hL7BpSGd7?=
 =?us-ascii?Q?bezp4o8qFsQkmqmGsDMXN8NsEY2WpliWBIpuoTbpELGHs0wiaH99Z9fK0r/7?=
 =?us-ascii?Q?75IyMNiQGW8gPds0cYh/nZtSKzw7yRH+lnjHEG6WkzimrBRTAZw7tal8dQJ4?=
 =?us-ascii?Q?uQ3lhg0lfU3AUYwKqE+muaxZKwVdQgtQTzYAJLJm2dO83ld0m8BhUgrJQkY0?=
 =?us-ascii?Q?nPfrCNTNE/3//I7ntEJ2e1mkBjN9NA3ncfgyi/ZdWOlGpgDQOY37U65dIQGR?=
 =?us-ascii?Q?gZewTrEwmNQjMNCDFmLOi5aJRTLMqnXKS3bI2emM6HbBapTu9oi3C2X/pT82?=
 =?us-ascii?Q?SmUTOBg6lcsDVKyNlI9sO1p3jV45oaFSxYs8VzC1qpi2uNGEZeovTlNUgeIA?=
 =?us-ascii?Q?m9g6lq6Bm0hiQXhp514Wfj2kmBgIBMU4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 14:31:33.1342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56613a77-acd3-4377-2e0e-08dca1b62995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947
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

From: Leo Li <sunpeng.li@amd.com>

This change caused PSR SU panels to not read from their remote fb,
preventing us from entering self-refresh. It is a regression.

This reverts commit f8ebe6341a6a3745ef02648b4b5c2c89fa4a9ace.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d1527c2e46a1..19307d0024d3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10463,7 +10463,6 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	}
 
 	/* Update Freesync settings. */
-	reset_freesync_config_for_crtc(dm_new_crtc_state);
 	get_freesync_config_for_crtc(dm_new_crtc_state,
 				     dm_new_conn_state);
 
-- 
2.45.2

