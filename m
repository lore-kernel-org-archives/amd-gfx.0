Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D187C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B4DA10E565;
	Tue, 25 Feb 2025 06:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z/ZRdX9l";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48AF710E565
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxWbSHP7cKlnnb6wrKxRpmD7wMNyTFywOpX9GW1/Y9v79+h9HWYmB1WTbNcSQLQHkfuaUj6AxJ/QRJPTwZ2u2Fsd/tuN3iRphG0tWrzX/4UeyZ+FUH7OFcXp2t89qWAgic2ckDdk93yPcTV3YLAqw2kP3cS9w6G0zdRPCEEjpKTP7gIG1az3bF7bGVDDMvegCfEfIRr6yz4mVfPQI+mjycBaqikySFxr7SSyqD1MSuOtb2K18sDQo5DusF1euvGlAN6Luv3miHccVQetJEjS2uF/YZCSdWpinIg/HN8rvVs4RtceDxbDrRDA7V+BY7cGbcr9pAVTaBRM/NnO/Cw3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMEphiOhCPZELIKEtyrN9yNw5wP3Jq6q7NtHPFNQKYo=;
 b=gskdLMVb6fSw4BytTh/wsv+XRLG0tFYSM+t7JPBuCbKXKd3v19g42VVVsRBMj1ktEdUzk6ZTiqI9ZZhKVemjIfaZ4WpEPZyzKP/Woi01Rzl88yhEssRd/Y+9G4FBxVl+ck2kuol9wH77/3EYFhvJKDzc6xw5pqXLfee6xoTEyv1FPPDtH8RYTMmgAfpM6gK9zjgWAR2R0bd5rSUTP03jManuaDLu567uTfPFCIMADyfu8NqY7W1KXwAOq29YwXHFSjKblRV7GMGs3lWz2YQKmvWkF06qL/WdMXnGcRtMmYnFevEmfY+wVd/1Fh86Kla0PyhJRjRHV12urqP+gukfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMEphiOhCPZELIKEtyrN9yNw5wP3Jq6q7NtHPFNQKYo=;
 b=z/ZRdX9ldPaRK/KpPrLhXouqxJJI1YTOdX+38AH6WDRlm9o8JFfM2nruYejfv0KVXVjieTkFRXwWIKVhdEu7YqnRvVkxQ5jwBspAhvSC75pJt504DZ7I7xkbp+7iGzxAnJfAWO8kyG3ni2drPvhN9TeK05qG/tluCa3XrVNWXGE=
Received: from BYAPR02CA0064.namprd02.prod.outlook.com (2603:10b6:a03:54::41)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 06:37:33 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::d7) by BYAPR02CA0064.outlook.office365.com
 (2603:10b6:a03:54::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 06:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:37:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:32 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:37:26 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ausef Yousof <Ausef.Yousof@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 <stable@vger.kernel.org>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 12/27] drm/amd/display: wait for outstanding hw updates
Date: Tue, 25 Feb 2025 14:35:55 +0800
Message-ID: <20250225063610.631461-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e2af2f-e22d-4fad-6a96-08dd5566e29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vRBmZ3OXOiPs/KVZqT9CSGjCR+nfiqLNCAIo3yk3bkitmsdnjM+LjDkFXhOc?=
 =?us-ascii?Q?SkpwsKd1Sp07TSjH3ycAoVzISA1o6sl7spJFAakBes6E1Vv6RdtSq0yuNRwO?=
 =?us-ascii?Q?ycbd/Gq3T8GXV19VMzeYY/fTGvW+6S6gGvfAf0elpio7ay9+oWp46kHcLeU8?=
 =?us-ascii?Q?oWhEfilzZBBtWRVLfMXArCzkkN3YcUf37c2CEAXsTQz1FyAHLH9iTU7uRS1L?=
 =?us-ascii?Q?ylqU7oso+oYVW4VeMC27XvvjIwM4yjVsV31Fxt8zpBuq4G3JCjvAh2/X3CLX?=
 =?us-ascii?Q?ZGjzeBYMHA03bZkos+f73R1iSdYWEK7xGJJGfQ5+QPVllDV8y2759Dy8tRg2?=
 =?us-ascii?Q?bcEC3TJWbuUrr1WldrD47Sf0K1NLJgsNwxuiBRvmVJRNrn6pgp5q76sLnQzl?=
 =?us-ascii?Q?wir1DALgF9IXd4KttKEtzcCEdzORjUk3Z0lkLFw32F8IdMrIcJ5yeYNpx9+S?=
 =?us-ascii?Q?zb4ecGW+CzDi7+4ptmmyfT/ejouAKgc9DSYBnZGrCuRxgjNf1LapPXIswjOG?=
 =?us-ascii?Q?OVN9XRXXQQgrbyz83ACfVJ6PIwEzgdEh465INtzO+v1bbY5YZH1VaRpHeFjQ?=
 =?us-ascii?Q?G4fgNAjB/iMcsOR/DyhZ9/Ov22H6A/MvtFAl1zEbx4MWmEiBQS/dYl4hIbrm?=
 =?us-ascii?Q?VakbnTTg+g2/MXMfWorDn6DNs+L3QzD7yHUPC914dBtC+VdziJ2OPyeLgflB?=
 =?us-ascii?Q?IsnJH0h8lQNj1rILhtPLL4oTyXOaL5phEqN+gCWglDDRZe4kA/4M29dfXqrp?=
 =?us-ascii?Q?eVgl427HykNPu05++myR/4bKoflJF0l5PVeJCxxdPZlOmxgFO7nhbOT7GP3n?=
 =?us-ascii?Q?ehneNW8uwlAs+tZpsda1o9lAc884yxPGQheedcTy3eu/+AzlyvzxpTPT8LwC?=
 =?us-ascii?Q?9h0gyFObtkMX1ndfcXBbgDEoRfTVhWB6Ve9MaVnRzAJN56ZZb8hGyzEqzvxk?=
 =?us-ascii?Q?T3cGQ7TPW7GT9cF7AYL0bFIJRQiVeDy7sxwQOOQPOs+802uC5GLrQRwMpvwE?=
 =?us-ascii?Q?bbmeRfgiXcFHydlT2yviEPG07ta4Xbgwj8aZtkdEgzKABw2phfrRTxi6m9J7?=
 =?us-ascii?Q?jGnX+Q2jGIg7ykAiVK6vmonD9BY9zbIf76vB5CNZ0xESZgJp7oCdCuZDLcIv?=
 =?us-ascii?Q?iTwZHuOlo89Hdcj/rStqe1QV0HzGa5F84kNBa5oc0Hgcyf45QCIXvkRK8Udw?=
 =?us-ascii?Q?0YL9OEa/Jd2QujdoUYBk+jymI3q6I426mLcsIgF6kX0//m5Mo5j9Be73bDqX?=
 =?us-ascii?Q?LvWagy0c3Ej2XjD5CyP+6FjnKhsVoXcL5DrXx8wK0s2GMy4O88TfQkBEakZh?=
 =?us-ascii?Q?e2knGcGUrEpXXX/5CCHLZx8auvs3ked4XUsQyNCTCY8yPQzfCEOAqUOzvl8f?=
 =?us-ascii?Q?G8tc6n8tILCIaZupAN/Hdtw6Chruvgh0OEZIk5N139Na0bFwSUXKw305vX14?=
 =?us-ascii?Q?f1+SC84cOWvzPK4MfAnhO6wnARhr3WCeeUZp+tSdW0p+v1QNdumL7517cDti?=
 =?us-ascii?Q?jGmSRvd1dsCx9XQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:37:33.1777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e2af2f-e22d-4fad-6a96-08dd5566e29b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[why&how]
seeing display corruption as a result of not waiting for certain values
to latch and attempting otg locking/programming before waiting for them,
there is code in place for this but dcn35 does not initialize these
functions.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c | 1 +
 drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 6a82a865209c..7be72fd88477 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -128,6 +128,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.enable_plane = dcn20_enable_plane,
 	.update_dchubp_dpp = dcn20_update_dchubp_dpp,
 	.post_unlock_reset_opp = dcn20_post_unlock_reset_opp,
+	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index b86fe2b094f8..eb29e852dedb 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -493,6 +493,9 @@ static struct timing_generator_funcs dcn35_tg_funcs = {
 		.set_long_vtotal = optc35_set_long_vtotal,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
 		.read_otg_state = optc31_read_otg_state,
+		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
+		.get_pipe_update_pending = optc3_get_pipe_update_pending,
+		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
 };
 
 void dcn35_timing_generator_init(struct optc *optc1)
-- 
2.37.3

