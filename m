Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C4CCD5BD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 19:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3984810E990;
	Wed, 27 May 2026 19:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cJ3jDK+S";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFA010E985
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 19:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVetLP8LOlNPmKuZkTNqlRazctUrCnm9y3X8o7DrnVZjXFI4NhuJL/Ys9Wf3k0Pzj4NAXqDoKaiekmFfzVw9PwJHVAOIcTStvBRWwudi+zfOySsNYoB7OAdPNCPaSZ68UVLOpTBXgHsYrH8rOZ3Yx+7Au3gHTDBd2g+AgCevJGN5KdtAUnswOFyeqff39Xgfaxs/GXlqdm91zJwAZ9E7y6eNkxh6sAMNXBgwtqX5+S1W6Gkbk7wDkkQlNbO7JZmp/nE9STh12i4ylLXLBE3iFkZcmQ1rRjgI6rCLpMeSdEY88+3zqaFRnAKf1er6vi1hA2QeZ06owWjI5M3Nbu+7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6igFNmf0hHbQARoL14eeV3eK95AKZhxhWcTDxrUq6s=;
 b=eE43kQqI9fX1DRmA/b7iiAZSmlEn88O/XOlejrg9UUDaAL1uRysA00Vkw5hAIjxVkVkP69iK/lGAIlanRw83JNDtvXOIPNLmUxTd3NFTxQZhFVDYdhpmB+eai+zfaRX6p5lrQbCu57MhyL+19MOovQM4VHxhS7gFPOgGunA3swVf1HZDigEsmbrZl5cog4+3T1YLFsVbxt5EC7I5qko5RsmTz7eDPeG+SsXt5Xu6bI3eGjLs7uZOuTF7T3Peljn9k5NgSQrVB5B8uJa5p2PskPuUBn7wW1HyFl9LHiBTLDirJKjnT0vy9AmBmT5BHwEOJ0hi8a+Pl/onRQMSr4Wfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6igFNmf0hHbQARoL14eeV3eK95AKZhxhWcTDxrUq6s=;
 b=cJ3jDK+SRJT/WEAd1wLfb4VTf23iR3oEaUy8sB/MPKZmxb22w/QZUzP7u5s9yUKpq+mUxWV/vEjvUtMAeLCsq3W3y5eyOTVvhmE0CmDPV5o/Cg9VEhKWW5Axqkjxj9B3CBYruJG6jsjNMbekDXgp8FDiT6eCrC4cIhg7/XPzyk0=
Received: from MN2PR18CA0010.namprd18.prod.outlook.com (2603:10b6:208:23c::15)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 19:43:01 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::1) by MN2PR18CA0010.outlook.office365.com
 (2603:10b6:208:23c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 19:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 19:43:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 14:43:00 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 27 May 2026 14:42:59 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH] drm/amd/display: Add a default case for dc_status_to_str
Date: Wed, 27 May 2026 15:41:51 -0400
Message-ID: <20260527194151.2253853-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: a0237d2b-df20-4605-d278-08debc2828f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: JaprmRbcN2zxNQ2N1uY9tGC7h6k0/hEhFrD9guE2LVeytFEe3pqfZ3IHSIN10QT3Zm417En1qKyZ/2Y+UAAILsbXKcV6Ec/O2a/emBtX7JzfPbMpvNVYSYtJnDN5KUq/AeJ3OFXWNmBCBlrhS68uHB5cyCnrO3DLd6hy3IAAbiVnPjv6st7BaPEpoKYAiPTz7qDsP2DT4ZRuhc55sbvY0B37/utIIDfO1JfjsKJN1+R5otuhiFLUOYuI4+y5VO5AkZPy1rir/UyoZS/6V4f2AWBE9eSOR76jDaTj8a6N0RkwBTtvRKTW8ABsxAh1sWjwYxSawHXSaf/Q0nSSn/tEb1E7xGwJ4yM3w/vVb4m7vjRmbY1uLaHo4VKW9QWXBMQYCAmH2tZw42xRTu+8mc9KMS+1I2aJrUsmFGYWKxmTSkStYiqwpgDNPveS0Am+Jzo7LIWzRBDj4HvhaPFTkyoth2qImmqfEneuskhpPW8w0b06biHBU1SX/5EBLC3CNM6mkxJcId1Pv9eFBWF7B1G3CBKwpAmpgSYByBwRkgRdyv/+cmMc5JDgN6jvgO5UHefQIZTGz0Q27+PtoH4P8kfqxo47uQMta3amQKv+lZiDB/oue9RNyQQZODD49GsaqTr9kGfSt40el2QGlKJ2305hqH5cr3jm5nY2thMUDhk4I2V/pp7kkfIWd+BPoACcPq4SoXtoFo7M4PvCPNpbh/eR/Hpvo9CwhMtDXYYOdtgez/w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I243VSU6Kd08rWM1h4r3bmbVY3D1vpzpLVzDp66vsMR08W0ozwubWWx5BexfkxaM1zWOwkjPje6xL1EgTjnhzsjJpLF3VNs0Hz6/m8E/IkTi23dZ9bTH2wkrUKbYRKheTr1/qHR5hVWqF78hnohGWkE1ecYgCvpML2cBncglS/THSg4KevDWRU9Mn5u2VPEOtf7lHn670mYo0uA3BZTi5Eyg6DjuAzJeKsClxs1z/a3R9m/bVEyXO71gh+rPWaWNToLg8D4LKk2uYAm19KFG0NKqFKm9wwEwjTIZCbQrSb+qbISjT9ejPjLRwL5hnuJsyx/G6goDaU0dI4LW8uCxSj3yJmOf7pxfWfozBkpspdgpPmeyyxWwqcbq+j2bIZhISxD4D0+Eu/7uNV6qxuXq1zFn8BWTS8LEtqYD7dRnt24eLqZGu1KPvj4gWwi6dRU/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 19:43:00.4791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0237d2b-df20-4605-d278-08debc2828f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
If a parsed dc_status case is not covered by the dc_status_to_str, the
switch case is skipped, and the function returns
"Unexpected status error".

This causes build failures when new dc_status enums are introduced.
Changing the 'return "Unexpected status error"' into default resolves it.

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index bbce751b485f..44028ba88f80 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -272,9 +272,9 @@ char *dc_status_to_str(enum dc_status status)
 		return "Fail DP Tunnel BW validation";
 	case DC_ERROR_UNEXPECTED:
 		return "Unexpected error";
+	default:
+		return "Unexpected status error";
 	}
-
-	return "Unexpected status error";
 }
 
 char *dc_pixel_encoding_to_str(enum dc_pixel_encoding pixel_encoding)
-- 
2.43.0

