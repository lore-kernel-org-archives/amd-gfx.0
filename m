Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D67C83F26
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 19:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A165910E6BC;
	Wed, 30 Jul 2025 19:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VFwtW9yh";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A930110E6CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 19:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+tG/r1Ra9oBGfAiAdVpHiD2fUcPnFtelf8uxFvJ+VY6Zt9wUcnZHACn2AR+y/cbBhFhFewAdz1gRlLYj85CFaWsoCI46MkPodEwz67nFXcgMrwCVR2yEc2HzZEcax2oIzn/iHdDzGYtNxqdGGdgK2Z7g+BPzGiLUC3exNEk17px0vGpxUEolxPijQNwN1cvtKCQ/y8UWgOM3KAGpdehMItbZsdmAk5ikOqI5zhllkDgYpnQ6GWYta9DuD7kuw4OJ7ea3i8V+oojy4F1TFb7Eny4wZflVC4FrwBKcY3ENFfIevezYmBI+JFJGVZGIYu4qNTJBDNojnYQ7WXbIhTAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC9I4iU3MvwIvtYgtfPOHDvfxDux2aqPDt41pZhVUtw=;
 b=H6xEY+PGdw8FC/Z8/DsUQQCSFntS2RrbU5O/cpCulugoK/hKfCyq9/Al1OL6V5BukpoNVmYI2ff6EfOuvO9nZNMHzqMlMJaQf956U+UIBaiU6V2OPcihuBPdHv6Wpr7aWbLTz9fY7KKec/o7C/UNdl5d9U26djKrBGFCdJk0Dzh9NCTGn0TMB0GtAV/rIBsoOyEZY7jH3WEm5VGZXXOqTfZGtKpymsrBJR33XdMKpOA5yqw821+hoHRylz7gSFIkryFevlP3ktM3yzuvLmavgoPKVdBojmMbUZV8x4UedZInWIvjbDRbwmoXdpFjc6etsLQYo3uj7p/BoQttrLP8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC9I4iU3MvwIvtYgtfPOHDvfxDux2aqPDt41pZhVUtw=;
 b=VFwtW9yhEuqpFcSzxkR45wg2GtqkO6L+2GlBu6Q1InxYuHBgn4IpQMrt2puo61HFpNSF8BRfnF+L4NB79lXHzjd1aQRe7CxkVN/Pzm9gD6rDra6PNC3HwDoq23UrIA7lj2wAZ6N68WMYh0Pw+1Eqs3K4Xv+1O2CZ6hS0xqhF3ow=
Received: from BN9PR03CA0190.namprd03.prod.outlook.com (2603:10b6:408:f9::15)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 19:00:50 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::ae) by BN9PR03CA0190.outlook.office365.com
 (2603:10b6:408:f9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 19:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 19:00:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:00:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:00:50 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 14:00:49 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 <stable@vger.kernel.org>
Subject: [PATCH 06/12] drm/amd/display: Revert "drm/amd/display: Fix
 AMDGPU_MAX_BL_LEVEL value"
Date: Wed, 30 Jul 2025 14:58:57 -0400
Message-ID: <20250730185903.1023256-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730185903.1023256-1-Roman.Li@amd.com>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: e15a7fe5-54d4-45c9-0065-08ddcf9b66c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n/8hosIQshLwqkwriRa+dgT1tRfyVRt3n8v7Jumrrix6DkccdP66ZyN1Y2Fh?=
 =?us-ascii?Q?8kYA99WpgUV/XoHrdLG4/jz03VfLWIZG22JZ8iuFz9roIqNV9e8vbirEyzKj?=
 =?us-ascii?Q?LuretOwUURIuFLuzIXLcg/H9VK/d4rwL3CHir976iSeuvsMnJDUxP1grhe4/?=
 =?us-ascii?Q?67umVEC3nkJYZl9HQoLN2VARslPoVbAd6JYrnHRpXs2M/D5ueH7QUvSzo0Tc?=
 =?us-ascii?Q?grTAYHFf2avLZkocmr5ZHW8J3J5uOhqxKevNXOQsM6REbpTI6Q37P8WvP59Z?=
 =?us-ascii?Q?ztioGRuWG1+rcbH7qK2wu6LhfHizSwlV6Sv26OZc/nYjccXZO1kqDnCGGrfI?=
 =?us-ascii?Q?d+2OHJfRnVk4C8wRiUAs3YKZMkfoh2Zo+FSiL3ja96SbkOLqaCUxP2GtK4pt?=
 =?us-ascii?Q?WkVUc813NLuU5VeG7DjRp7YOBweR3ZjwXLQxtSQmsyg9FvNV3xsm6Al5GVGL?=
 =?us-ascii?Q?E9qebn8y9kuWcc6oB3R2W5PYegkSYkuxpkxQOdqhbDtmbvOYl8bLYuT6iWxr?=
 =?us-ascii?Q?w+VNna/wePS3fYqRIQJPVigIR+xhlEWCssgqWApFBmBzR6Y3cEckMG4MKSl/?=
 =?us-ascii?Q?ku/0JnIojVX/ymFerqOjlGkUmSnwrkvcT76XomHs6yAtyEpkXMEjF+3aNhWd?=
 =?us-ascii?Q?Z1SQUrwaz3zgIlcbSMrYbhKRCPFdiW27Lx+Ljh7ujjONjrTbzsJ5A5MIHGYi?=
 =?us-ascii?Q?LA+21oCodeTThODhmDGiaDZL5qYo0wkI/2T3/fV/f27V8izQEOYRy0WKeqDO?=
 =?us-ascii?Q?xg/j/jnW/n7wxeme27Ol2mn4NULxRk2ZFXLVBawA1R2kZdqwkrfN0grnvs6f?=
 =?us-ascii?Q?+2haKHUn7fDuvRW0AFSUKorajsdjxD0Q8iCuxOsWR8Isjuzxpueyl30pM01O?=
 =?us-ascii?Q?ArxGNZCB4DvKBwgxZtf5ZPxBgK3rDtqiqZYQ+HfRR8xeDgIbMsnjRO1eErBt?=
 =?us-ascii?Q?POorJ7/XCdO3rtWPRelHONycr3lBbzdIINbpWFLq4Np1KtZKpL0qyJZ4QbuF?=
 =?us-ascii?Q?qgNFyzbjivvJoN94+4HV3AM1OgEhjK/VHmWCubwTXIyyRhhJp8/TUuhAQQxc?=
 =?us-ascii?Q?qUzKLLy9QncNmb7M4/VFqrEowbVGHjaTUIc22FqIdNdWmi2t3gvC0i19D1S2?=
 =?us-ascii?Q?2HEyhruIRfcCgW4h/cNb9jHaGZ3XRieG7xqwYsa/tld5N42Q+RnF8VOPgaY2?=
 =?us-ascii?Q?raYz3MtK2pBeElPjMHlvLmRG3BdhzS31UJM+Af1J+S81SSYhuL/q22w1HTu0?=
 =?us-ascii?Q?La4/ts6l5Y3mUBrmjlh3u/zbHBdnXb3fOeKkGc1jfxKAvy5QRmxwEGTEcZ0/?=
 =?us-ascii?Q?UWqLdJ2YlxAqYzuMUQNlRq8htyngUYDKsTtqHdDo6YWZVzRm7aHWTvxzQJ+x?=
 =?us-ascii?Q?1De5Fsyq6vnr7c9LdIB+P3A/mmHpzWXP+J+y2fSz8VDuywlFGXt4zHzFqMyY?=
 =?us-ascii?Q?1Xak6jtikjT6TSAEPL+v2MEkHRF/jRC4jpm7m0Z/yHn9/Z4t8MAZIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:00:50.7239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e15a7fe5-54d4-45c9-0065-08ddcf9b66c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560
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

From: Mario Limonciello <mario.limonciello@amd.com>

This reverts commit 66abb996999de0d440a02583a6e70c2c24deab45.
This broke custom brightness curves but it wasn't obvious because
of other related changes. Custom brightness curves are always
from a 0-255 input signal. The correct fix was to fix the default
value which was done by [1].

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4412
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/amd-gfx/0f094c4b-d2a3-42cd-824c-dc2858a5618d@kernel.org/T/#m69f875a7e69aa22df3370b3e3a9e69f4a61fdaf2

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 16347ca2396a..31ea57edeb45 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4800,16 +4800,16 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	return 1;
 }
 
-/* Rescale from [min..max] to [0..MAX_BACKLIGHT_LEVEL] */
+/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
 static inline u32 scale_input_to_fw(int min, int max, u64 input)
 {
-	return DIV_ROUND_CLOSEST_ULL(input * MAX_BACKLIGHT_LEVEL, max - min);
+	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
 }
 
-/* Rescale from [0..MAX_BACKLIGHT_LEVEL] to [min..max] */
+/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
 static inline u32 scale_fw_to_input(int min, int max, u64 input)
 {
-	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), MAX_BACKLIGHT_LEVEL);
+	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
 }
 
 static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
-- 
2.34.1

