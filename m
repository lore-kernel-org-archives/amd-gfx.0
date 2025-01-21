Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88E2C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C04C10E632;
	Tue, 21 Jan 2025 19:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ci6aH+7j";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F380110E636
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE+hU3k9VmSDI+MfPGw+0KWQaSuJPrUuFvKQ1aJOO8nbvnR8pnomhPAMUvF/lwpJkkOho3Hg3gfykt3y5WPEXc7k+7cMkQAlms3WLNt08ZEmFmLEPjRm3oUVkLBlJ2hgOBagHna5IM81CRITKe+IVtxHdA6rGaowphZl1hQuubGOhXk0WY+vwaidEcvQnETs36y8JM10EDy++OxPJZ3jjA0SciaFp1Lx7BJ3keFNlbUWmCRuytdK2Fau1pytqEUrjTI7XhxRlH2ufbbczBO7rxB9Gr3N8qyHIF1B/4On1rP6IKrIpHNJLpBVMTIwd1zzjiazIB7kx2aH1SwMJ4Zflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buK7ow+wCp0ZI2QFNLkV7HQ+/cR+EVsvMrw5L3YXNUs=;
 b=oVCtZlBgzfYXoZmTsSc2Kir0Xj4oCiakfJoB3d1wkI0gHWTmnLCJ7ysx7woe/64i1eEwl3QJznKvaGibgqkSxRmRUkEHMTFj3Rl1X/5cFuUPkbcmK3ZFfCLQKhz2tBhTA9+xpYayHxM1uUhKKsEPRV1Vz8q0quITg2pVzv/2FY6TADdeba8GBFa+O6mp4GHPbZ/idLlYVVCOf9xv36B2QVrdCenX8L0yjR67MUJZ+8bvbgj5HeTaSPIgImCAMpBziR8uuW4C9EruLlOrsKIskhFgsMnEfgwYd5nwTnq6vL+BSGz7jesqbdsjEnZ0oHqOWZUAgKvOELttyEbZ6rukzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buK7ow+wCp0ZI2QFNLkV7HQ+/cR+EVsvMrw5L3YXNUs=;
 b=ci6aH+7jH+4A9I/fpY5y1jrVnWKpVcliGHMIMxBearIVkig5SRQvOiw2DT1NKPa0+g553jZLvJ8W/rcGciJ9F36bmd3l9pv6lmef+hF/c3tWFU0oe3fTRQq0oYqJ8AqoIMVCloQBBYwUCXNruv4btXrDP3z7w4V3/n5yX5/aFsE=
Received: from BN1PR12CA0005.namprd12.prod.outlook.com (2603:10b6:408:e1::10)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 19:40:13 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::ce) by BN1PR12CA0005.outlook.office365.com
 (2603:10b6:408:e1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Tue,
 21 Jan 2025 19:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:40:12 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:40:10 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Hansen
 Dsouza" <Hansen.Dsouza@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 10/14] drm/amd/display: Add boot option to reduce PHY SSC for
 HBR3
Date: Tue, 21 Jan 2025 14:39:15 -0500
Message-ID: <20250121193919.3342348-11-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e09c479-f93a-43b9-3e84-08dd3a536c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qt7M5zJNDw/J1GnJFtI02WnFG+CsBkcbodd583N8OL7pZSwAUiC3WjUqaH9P?=
 =?us-ascii?Q?bivjFcd2N7w4TkC+eIPGbS8MxzaqgNl6M3QQN3OV0H3bru6WF/ID2O5efkwo?=
 =?us-ascii?Q?UIZUR8lpG0uQvuA+0c5UeNynocfCNNOcIrsFeoAnF4oYGqrfvakO8HPQQ8SP?=
 =?us-ascii?Q?+6y0CEeOb/gufHHkS8wxAx1tG2YQvC6kELjp396OdrrCjcFO/6gswuNbgAte?=
 =?us-ascii?Q?s2ighs7370o0DctWX3+yAcpx/oPzK7JnnWj5EDwI+8IADwtQZSKisP9vt4dG?=
 =?us-ascii?Q?EPitoVjvYJckIEya6EXUsWLHkb+WoaQKbktfJSWEPXWJKNH1t3G5Ko0ujQn8?=
 =?us-ascii?Q?LYE+pxtSm4U4YcwBOSNu/knutIE4MNMAunAcO0fCn6V/dnI1aY5xBKgzcz67?=
 =?us-ascii?Q?dGPUpiLfpwBb0IR9eCTtxP82hiojSiDYQTYZj6cnomKwTsjD99oF6+dgnCmP?=
 =?us-ascii?Q?xhXBffXjsyUBis1KZLUrQd4gQ5n5dt4NgIHfneAFwNyI4S39n1R+RMzy/Hz5?=
 =?us-ascii?Q?pGD8twQ9gnWRrRpcRpcL82c68KzNEBdQIRgYR70z+2ytOsgKdkUilLujsG6D?=
 =?us-ascii?Q?FjwbhumLdu63tMwwJ0f7xzv70Zp+yMrP9N5YiaULuiGsFivPxSn+mqhBsmkJ?=
 =?us-ascii?Q?KIKWO8XYfz/nKGNOMbHewj2s64+tre840r6nsjPylSplFCYx5jnIhmyYVdTN?=
 =?us-ascii?Q?Cbx1Z+x3uKFb4Sy3r18d6jruglv71L9b+pTjx1u9i/wT8yPcuhGULUrwIZiL?=
 =?us-ascii?Q?ZeO2O0zintA1Tgpy6I36nDTp+Le4xK5/FWkLz/tthHikbLwfHgA4DWi2sOlQ?=
 =?us-ascii?Q?tqONoBLfdM0fZq52xVOMkq+NS8UAtYrTnYAVcAFFiMfQ9PvkXH5rseC+mmBE?=
 =?us-ascii?Q?v8QPUnghuMN0NBClbFhkhVWkVhFIWWqFl2cYxB9J8rNnJaALe0gGIEg/NeIt?=
 =?us-ascii?Q?pAar53fi2vqNnV/HlsMGSUp6kolcS5P4GkYvA4mpuraSDcfBdBuu/BR1nDZd?=
 =?us-ascii?Q?QpGnuWmUlSLjxj6JZaDpiMxxEJUY/VvxhVFUe0Fuu2R7tbeqAPR9Uf3jiLci?=
 =?us-ascii?Q?zDpOOoF4WvuzTRJdd8+mkVRe86OHGb8dpWcZ4aE99P3CKeKKB66yhhOPK/c8?=
 =?us-ascii?Q?HrruS7KHh6nGh4AyMgLioQuFRiABGidIqDOI/e0C3ET3V1fmACq4gLz0QpnR?=
 =?us-ascii?Q?3Gsexm3SlZkxXxonrjlmrx791DawjD7NL7USByeKAub7gOi1hgWr5bJlThkL?=
 =?us-ascii?Q?UxL+DXyFlUEHN4bDQ51VNuCMaWi4UQiECo/f9NdrXt6pDtH5zh2V4fvcyePH?=
 =?us-ascii?Q?7AC2+pwCZugXr+bxH5yqD0CxBm6xe4jfalYAgcjZxtTWfhyCCm7BldNnC4/V?=
 =?us-ascii?Q?eQDRhBmADALSeOaLCQc+5YwQcC7cx9kHnGfmymju7rYz1F7Qwr/eQ5lAa48w?=
 =?us-ascii?Q?oovhmOLKf0VVINYWnT2AoUNwJ3cJ70w3b51bYVs1hj8viaM8I8Xp2GjI0QHn?=
 =?us-ascii?Q?ZDsvA6bxAwX8GF8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:40:12.7257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e09c479-f93a-43b9-3e84-08dd3a536c2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587
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

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

[Why]
Spread on DPREFCLK by 0.3 percent can have a negative effect on sink
when PHY SSC is also spread by 0.3 percent
[How]
Add boot option for DMU to lower PHY SSC

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index d9f31b191c69..3d0bba602b53 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -371,6 +371,7 @@ void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.usb4_cm_version = params->usb4_cm_version;
 	boot_options.bits.dpia_hpd_int_enable_supported = params->dpia_hpd_int_enable_supported;
 	boot_options.bits.power_optimization = params->power_optimization;
+	boot_options.bits.lower_hbr3_phy_ssc = params->lower_hbr3_phy_ssc;
 
 	boot_options.bits.sel_mux_phy_c_d_phy_f_g = (dmub->asic == DMUB_ASIC_DCN31B) ? 1 : 0;
 
-- 
2.34.1

