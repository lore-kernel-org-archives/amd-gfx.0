Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251C8C54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B434110E1AB;
	Wed, 28 May 2025 02:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="crps4nKR";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A6710E1AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxeBL4ypHKX7XKPuJ2DWsHwpediOuFgC9ve9ojJhebbb32w/Fz9jH7tuVikn89dGg7RpFlsinf51Uxaf83HkJl0+Q6iFrdqt4GkZ9gY+eYhrC0Y0Oz8KjeL2dJWgKkt5VIuW7kOxMHLN9BFUZXLCtmqc+J/wsjoEmK3zQj8x9mA5dHCds/Xj1yW4Azxqzc2YlW6TT3GwykwxHwxFnLnfX2Q8w5gh1uH9TQucBf/D3qFARd/FiF/f0fG1xLNJsAuUZJAvjsu4htKGvv+18Vtzv9jYbvPVHsrEiQgvPsHc75DEQx02UpE5mrXcImPA6GIdP/ILYxeGifPo9N33Y69a1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p7IYuPAVPTcf9CgzHoZTHqOa3nHJTALSj3mHr00v+I=;
 b=VmhyDv1bdZsBOBOupkGoTcZQqMrbDQEdTqfIr7c5S+wXwYUhkjXE3eDdp8dPXphU8kYT18qEyNapROFTA2MCGGeorPQGG+WANIQvPVqRNoKukOLwtib3WBqaFdXiOhAYFSywm90SoexD3AP7Q19hiKUF/km1I/XxzEVg6XmMnUhoFxAaIdtl4SGtuNrtcHgjUjBrpxPElcXrIknr3WZHP6CIfbotlh/LJBm921sJwSRQq2GK7c+Wc4tqGxoJqcU/AQIp8SGpC8T9P+XLog0HtXV20tUoTOOUtz5U/DsHN+fyD/OE56vWHBKlaiI+B6tcZIs0Ne1y+K4yCxTEUuWsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p7IYuPAVPTcf9CgzHoZTHqOa3nHJTALSj3mHr00v+I=;
 b=crps4nKRKMcFBMT0ObyCioHw+IlxmJ/Y4iFxvUk3BuDDxA6JAPwIgVnQKyC4XedcyZAj4ZA35kHK0COzsjDGBrbARGdU0SeZUmYhIBl+rku+XJ7pIGdatli2Ex0DKsmZ0qI71gp5/n9gbaF70+3s4GHnuc4lot2OlyLVBpb41Ig=
Received: from BN9PR03CA0760.namprd03.prod.outlook.com (2603:10b6:408:13a::15)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 02:53:17 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::15) by BN9PR03CA0760.outlook.office365.com
 (2603:10b6:408:13a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 28 May 2025 02:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:53:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:16 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:53:12 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Jingwen Zhu
 <Jingwen.Zhu@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 11/24] drm/amd/display: Add disconnect case on dongle check
Date: Wed, 28 May 2025 10:49:06 +0800
Message-ID: <20250528025204.79578-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ed9487-0ae2-47da-f8c5-08dd9d92cc14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V3tO9J5Jcc9Xovcjg2SLpZYAVIZroEOVWbOwTlkD/dq5NTpeyo2jEZqx1FtK?=
 =?us-ascii?Q?P4S+MOzKU5EriDjwtrQE4VgeZBGydq+/AspLgGfOgOO/m0G4dZw9lyRsJwms?=
 =?us-ascii?Q?DD8md9K+qWKcyOIiWbTpPEqlK+M8BiqT9SPJECIy8IJTsdvyqw1XIUs8S67g?=
 =?us-ascii?Q?1Uji7DinL2B5vimd1wA/FCX0JkSPkM5JMza5PQhtcoeb+HWZ+981FiaCOqhA?=
 =?us-ascii?Q?z0h85v2dKkbhpJ1quQWIoE/y4qL/wD096q6TDt4z4ZiTnwGyYh+gZzShI5XT?=
 =?us-ascii?Q?0hmkI6aoeKhgKCWhXRQrjnmn3R1Fvpjb77uVtiRbikilTyVTcH9N2wE+Z0NX?=
 =?us-ascii?Q?okn1DwnJ5vW2jyn1SlPd78xTbD6KAmX+nb67QjyyuiLPDUEn0Z15bJJiLqhd?=
 =?us-ascii?Q?6H5TcWxkdkrDRdFfstTwAU6lKe7mC4zl+ZGjP2idLrkWEnUuaWlsf4Kna670?=
 =?us-ascii?Q?1J/ctF4CM/tEWXyr4V0e0iztZSAzNYnIiPO6DGwpEZi8etkRR/2ZzKu2G6in?=
 =?us-ascii?Q?YRzs8XVsY2QeUEBf/8S3hBs7TEeQFoDmNWo2ACoiQzQz1suaU5/QzvsED1oe?=
 =?us-ascii?Q?A8xWsneytIydd5fKfmfqjbmqFlu4Z8nsRpdz7rHLS9EVBpgdl9hxIfwcvwCM?=
 =?us-ascii?Q?oQ4DKp8mcYu+YDn7Ot9/1b650bQN8RCuslRBzbpuwICkvowBmztDENBG43m2?=
 =?us-ascii?Q?mAm1ZMyNtJWeJPIUp+WS4Hnu6OSeJo8m8gZugh/QL2NbK1dy0fyhrCqt9GpX?=
 =?us-ascii?Q?alxLU9UQxWYceidYNIikriaLwmrcVk9ZtoTweAn0bChA/Dx/r34lYYhI/Yai?=
 =?us-ascii?Q?x/5dqSZwTRB35dDhZDas25KhyJygm1FpZ1WUfrBs5I5vTyWLVKnheF7Y5qxU?=
 =?us-ascii?Q?5T7h4/1i/1jtO6ouCxDzVp7z87VgtryY8daE9q91Ae4hCEeFnCkqsbmoM+/C?=
 =?us-ascii?Q?x4i0I+m6mOrIy6AGogGakwrsITWXesXv1PPUP4jtLuASTSFQ+E5T3tRoL03E?=
 =?us-ascii?Q?ZwhpKmN7VWKMt3vehns4kQaUTtYD9DyMyyEdHruruYx/hlhciHJH0tyGKT7z?=
 =?us-ascii?Q?MojEiQ/QRZeYPfC7I9JjZxUnI0t3UgXR2/hRsXouI5RT5lLOe74VrYqZlFbM?=
 =?us-ascii?Q?XeY4EJz+x8oOaYMGmkPiH/R6j8l4fZaA6zlsdq3vQuzp7ro2e67B4P9wmW1x?=
 =?us-ascii?Q?HH18zInZLBujNvX56PiZmHASlC2ePQNXMVvciVM+tM13jOhuldyK6oG/4rS3?=
 =?us-ascii?Q?8zMLoizDaZ7S7L0pD4hvicQC/ocbii1gwkEzJ6LZpWReFRbCCTrYBBbsw9ME?=
 =?us-ascii?Q?M56J5yG51Vii+sEudbsT0rDJQIi0HBYnWEKTdJPNBBZhN6IM55xAug4RfVDW?=
 =?us-ascii?Q?2cQHvp4zzSy1zJQ9anlXA8i3t261gtvJTlfSTe8l8HrgzY+xRNX/JZYvi11k?=
 =?us-ascii?Q?RVlgfk3y/YH9+dWLLUWpEwHtZqTsgeOTle27THES9xj7b6InFmmJ9tW4Jz5Z?=
 =?us-ascii?Q?cKdpZB+JedTYP9RqItfU8cikCSb0YVVOMHdN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:53:17.0754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ed9487-0ae2-47da-f8c5-08dd9d92cc14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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

From: Jingwen Zhu <Jingwen.Zhu@amd.com>

[why]
In the case of an external monitor disconnection,
the kernel mode will attempt to post new timing
validation with two path counts (eDP + external
monitor removed to virtual).

[how]
Skip validating color depth and pixel encoding in the
scenario involving a DP to HDMI active converter dongle.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Jingwen Zhu <Jingwen.Zhu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_validation.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index 29606fda029d..e2235fd32998 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -86,6 +86,10 @@ static bool dp_active_dongle_validate_timing(
 			if (!dongle_caps->is_dp_hdmi_ycbcr420_pass_through)
 				return false;
 			break;
+		case PIXEL_ENCODING_UNDEFINED:
+			/* These color depths are currently not supported */
+			ASSERT(false);
+			break;
 		default:
 			/* Invalid Pixel Encoding*/
 			return false;
@@ -104,6 +108,10 @@ static bool dp_active_dongle_validate_timing(
 			if (dongle_caps->dp_hdmi_max_bpc < 12)
 				return false;
 			break;
+		case COLOR_DEPTH_UNDEFINED:
+			/* These color depths are currently not supported */
+			ASSERT(false);
+			break;
 		case COLOR_DEPTH_141414:
 		case COLOR_DEPTH_161616:
 		default:
-- 
2.43.0

