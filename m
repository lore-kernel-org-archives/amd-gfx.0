Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E00C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597BC10EA9A;
	Fri, 21 Feb 2025 16:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c0v8QoPD";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B92910EA9A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxM03Bq4YCm8YajxhNiK7CNFvZ8Jzv7lfJais9PkNXdF11w/u5YmCFvkWlTcwW4XyqA6GNmTSgBfv7KHnjaFi1+qfLLbL/yQ+WDUJuBx0jncaxzU8MpYbnalU4ZFr1orU68cQGjPnWhyY8hwgOpcXsR02ZGEIcEc6PwOyh7hP2QSxOpdKh+01xg+u1TbZOB4NWz0sui/RF3xLDZ4SJwOswIcMPSwakm8/HHN4sRbv4i3Z9ZhU2TlwZntTisBlGgqgZAynDgWhxMt7HAiPzj7OOuaAnrltlMSx+0jsxgtCQUTyBrnmpkQ5XEdLtbIL40oFUvV/RsAARnOzC4klSndLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zkva3OIzTY6VaYUVsGElxy7oQ5Lu+lbw5SIPfLbhE0=;
 b=hsFrfahjYVqBTbXq7zQ2NkMVqTrTZlK4nmLVWz4zPF/jg9v65aWzOOOamveAY0GVxlJfNV3rgF+BQqql+v9GFZHW4Q1x11fZoPTKFCLEaayaA8kYjeMVqe5QVz2vEyQm4tLV3cRbH5RJ3Q5FdI6LqXJZfgOUPShHIa1aL9K7BlIF4bjGXB5KAo0w/HzegxM1t6DfEb561krxYabDH0hd/RjmoCuXz9tGwIY4DgFfXgPi/SRx6o0+y1n8GaYYCpq9irA6kn/XzImrxDJjEKbOAD2I1mBGoraPEbQyFwIUoY3toFi+cDkrKBkHd6lbMFKTirUBnmDy8esO2gWuRGpzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zkva3OIzTY6VaYUVsGElxy7oQ5Lu+lbw5SIPfLbhE0=;
 b=c0v8QoPDhdmXl088YxhIv3PSH1VInrw34YbvUHC0vKbNyGLJ0s5eVn8pxx7Tvl9NfBO7uHxTr/RGbobzgKIbFDmfolp9xZk01VfLsnIN2b8eojA1bavmV++mMb0eQDxH7lUkTE0AgTK69k/ntrP5ruA4XI3DI+DAa99Iao5b2bA=
Received: from PH7PR17CA0057.namprd17.prod.outlook.com (2603:10b6:510:325::6)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 16:02:06 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::f9) by PH7PR17CA0057.outlook.office365.com
 (2603:10b6:510:325::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 16:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:06 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:01 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 01/24] drm/amd/display: Revert "Disable PSR-SU on some OLED
 panel"
Date: Fri, 21 Feb 2025 11:01:22 -0500
Message-ID: <20250221160145.1730752-2-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4db615-694f-4b53-66e1-08dd529116f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tJdS9SxvO9FqzM0hIMBzu6OEz2VbB7vFSN+IUDsdiAnH0NGolkPdJQoy4uMI?=
 =?us-ascii?Q?Cbp2g9kppvHU1yxV8ZTr4vAwPHWWK1RvrEvkoSOHqQjuZJoDxkCl7VfavQiY?=
 =?us-ascii?Q?cx3fzuPDzTzxgTjeg0UGPGsrzi7VDlT3gLHFg9UI7gLSXaLlQYwjD3hm1F5L?=
 =?us-ascii?Q?ZrKIspugN5jDQCk2+Tm8/UmeLp6Sob9j5YKdA8DpkDF1PoxcMQDYuyLpY3/V?=
 =?us-ascii?Q?zG3UUR796TbzpkJk7qCl7LSyDIb3aL1/s6UbgTjXXIS/PQICWo/8Gfq8gusm?=
 =?us-ascii?Q?ArpLkWlwQQ5sOu7ZvHOmTyOmE1N3Q0wB9GFD9frvNZzuT2/76JRoc69WGwn1?=
 =?us-ascii?Q?2AVrEf6mFLwqG5RiWPQWKTESnUJAk/Gp1OML7rJqVzu7x4JP+uR2vhP2UB7F?=
 =?us-ascii?Q?woFmneNZ7IE2KmySabXyZiQb4QW99Pygy17fZjQAq7gxrH8enFo3mJGYnX7x?=
 =?us-ascii?Q?BefQZ1dv2tQAoLTht1GEWl3Ob7Rhn6QyoTSfpWh0Wjrg82EGiadOIsbmhg/x?=
 =?us-ascii?Q?S4aIOOLkmJOjdGGhS/qGP/yS9cUg6c/ZOryoZ0TuAdWblyqvc34Qtil9zSaz?=
 =?us-ascii?Q?8TOU9X5gGgrA63tsTXDxQ8L0g/5XfmxCzJj1F+LeF7178g5Jmx/0mI5UMBsI?=
 =?us-ascii?Q?3A1fyj+01PVFS1FsT/M+FZX4oCQ/IPNJVX526u8qicbeFRDCf5qw+okiCaDN?=
 =?us-ascii?Q?WyvwAeY/HksYZ/w3AxY7qMqW7TH08ywnT4sZElrQpZ4eZhfrJT9akk0KAs3p?=
 =?us-ascii?Q?nSVxQx4MaHQ1ovxWasptGUq1dIpB0VUwSPOX3uQsJF/UbojD3qyRC3/6B3R0?=
 =?us-ascii?Q?5k/GEoYqfhq7JzNzudyM5CEeMVOa9MZ0bkl0kK1Hi8O/9XHoO2w4Ul0tNMAw?=
 =?us-ascii?Q?6fO9GQiLTSzX/xGpv2ga+dljg+BWcQrovOpLTS0sy87qzkY+n9TbNeWvBmYv?=
 =?us-ascii?Q?AmF4tLyEaUYl4X6/Rr7RTSa1cIS5+DEcaTyTNZhyJKG/8BFAfB7bwBTKl/lQ?=
 =?us-ascii?Q?ktVdVzxImDLN5RTc7k5RqGuh9CutW+WwrdVwBx7S5LqdF3QAgSIoGquXL93Y?=
 =?us-ascii?Q?qDPmE+HHtAiG0zo7JV20Q2L/3sng8cEbE1NOurAKCM/OsMiITjWuUI7GfsLu?=
 =?us-ascii?Q?v+QkmaipnXjOfqsG8LEAXp+un8pF2r9NZwA/vtGChJFujkH0FpPL0eGziClW?=
 =?us-ascii?Q?h1mkhrGdi0wjsEBvOPIaz6vETbvIqXeNahIMb8a9Zf608yMhdcm62ogvcbMs?=
 =?us-ascii?Q?Xclum4kgV3RI9V0mvotkAClu3rpxMs5oBAGNh7S96PljrOBD6wLrPH+Dtk33?=
 =?us-ascii?Q?K/9BzCooSpTC9lc2TB/xTHtoR9lLXN9wtRa6+nuhQLeK+3pZYZVg9/85ZroF?=
 =?us-ascii?Q?JzaFkTTF12h4kfy1+8TNF23Rhp2+jSm/iiZ+XeVyPlm7e8MXOE5jsyl9TBhd?=
 =?us-ascii?Q?OXefzJzStDQ8urKd2ShXXkb23uIHlH9Hgmlq3wXTsM5tVuffK3dNfpl6SyNp?=
 =?us-ascii?Q?Hdom0UYKZA+HkEY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:06.3505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4db615-694f-4b53-66e1-08dd529116f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
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

From: Tom Chung <chiahsuan.chung@amd.com>

This reverts commit 9b908d788090911d339a217c015e0022e8020b75.

We planning to disable the PSR-SU and fallback to PSR1 for
all eDP panels not only for specific eDP panel temporarily.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 104f03868266..45858bf1523d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -30,23 +30,6 @@
 #include "amdgpu_dm.h"
 #include "modules/power/power_helpers.h"
 
-static bool is_specific_oled_panel(struct dc_link *link)
-{
-	if (!link->dpcd_sink_ext_caps.bits.oled)
-		return false;
-
-	/* Disable PSR-SU for some OLED panels to avoid glitches */
-	if (link->dpcd_caps.sink_dev_id == 0xBA4159) {
-		uint8_t sink_dev_id_str1[] = {'4', '0', 'C', 'U', '1'};
-
-		if (!memcmp(link->dpcd_caps.sink_dev_id_str, sink_dev_id_str1,
-		    sizeof(sink_dev_id_str1)))
-			return true;
-	}
-
-	return false;
-}
-
 static bool link_supports_psrsu(struct dc_link *link)
 {
 	struct dc *dc = link->ctx->dc;
@@ -57,9 +40,6 @@ static bool link_supports_psrsu(struct dc_link *link)
 	if (dc->ctx->dce_version < DCN_VERSION_3_1)
 		return false;
 
-	if (is_specific_oled_panel(link))
-		return false;
-
 	if (!is_psr_su_specific_panel(link))
 		return false;
 
-- 
2.34.1

