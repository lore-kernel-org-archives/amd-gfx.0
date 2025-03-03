Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8076C282D1
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 13:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC1610E412;
	Mon,  3 Mar 2025 13:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rEMU43Ow";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC6110E40F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 13:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X76Wy3qQN1mxC7F0UYonDo/2oNSaamf8R3R8Ej0tfk7oYwL7BGNet4AtP8Bn3pa/Nvrh65DBoQoOoYBIz7fm29USGt7xKapAEABNzYU4pYMirU+mbf7zGYwuJqM+FxXTm4j+0aPJgh64XYz/xgN0Np0cLyngP3Q+dEsUK6fsDQmsuoAMamMWcCjztE/2SNqrDzUtoay8ueDXNYWKnEWw/iXa+BzDb1X8G+dG19CMVRcIooaIFw62lZWZZCQyabuyxOWXEekz1rq6g2wFGf1/lafkPwtXuogzNmB9Ys4OMhmjjO6QxpCR3tPFobuNaqPv46nUuYC8N85l7o71yh+Vig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkvaVNRtDvszyOUYw3DCJJXDbxk7ipFZSR2rBFxifrk=;
 b=LZuzvu2j0tMQ3p0Asi9MIGUDnaWn04/7y1Fr3di19PxmnpbB+eftxdlrFmUlq3DawFBIDo9R99GWZlpl9pJZOcMCRx1BjtgZfBnwWijswMAZdSu8GVuVQuJICb7oOElYp1S8BNs0c8SaHeHVDnZvXAqP6seAKHVohLGGIO/yh2YHKt1uGy9c0dgqErpxcgKmPzQIrzQzqBrogpCUpLccQE5oFqtnamCa1PZKJ3ZomXC8Mg4RrS6s80UAkyH0SBWa1srtSFWkPxtNmbqCIglJWa7K6kjmd06MH3vpna5vSaENF0kDpWN+NlLELscmxWBXQz/HmpMbGhb5pKF9fXA7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkvaVNRtDvszyOUYw3DCJJXDbxk7ipFZSR2rBFxifrk=;
 b=rEMU43Ow60/NSp5CYIuyGFPR/QKYlyPnJSDwp/eHfKntELl/0z8EEJwR2HU2KHyxo5eZiz1HSUYxsLqozyiSreYsDIQxmkishgOQuqxmV4rrfl8TIfPnzXnLQTsOpUDBZxPy0TDsr4mTYaU9eCqHx5R5w40fyi10U0TDl6JKK7c=
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 13:51:00 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:fc:cafe::d6) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 13:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.4 via Frontend Transport; Mon, 3 Mar 2025 13:51:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 07:50:59 -0600
Received: from aaurabin-cachy.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 3 Mar 2025 07:50:59 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <alex.hung@amd.com>,
 <aurabindo.pillai@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/display: use drm_* instead of DRM_ in
 apply_edid_quirks()
Date: Mon, 3 Mar 2025 08:50:51 -0500
Message-ID: <20250303135051.1177406-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303135051.1177406-1-aurabindo.pillai@amd.com>
References: <20250303135051.1177406-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae52d2d-895e-4ed0-79ea-08dd5a5a6e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t2chRvj/qi124bxTNYF7obkxIY6pSB3i/voptfByJWCOwzQYTlu4adakNWKH?=
 =?us-ascii?Q?XnLIbbl7q4GaYCLyoi0sAMTmCBW1HNZRV8viA6Om21xQFaoTyDAi+wsd35CL?=
 =?us-ascii?Q?3TxO2TeWykZwR2bMWpRBb+onLcJYTnZ+pOdea0mwI+dlsVw68E6gO4gzepe8?=
 =?us-ascii?Q?T4hWM7hJmz1BWnuKJMIuNf51kRa90SaYDgnPUWrJMWmYKDGYYQHdCvhDwkQn?=
 =?us-ascii?Q?+dwj31IzAhs4V+tfsoEs399a3X370Fkp+v07QgTrO4SV5FEmYrzpbR7bm6C2?=
 =?us-ascii?Q?pJ54XeVgLPQKPgNBvyM0TFoIE6lCpFZ24oqEun40mga6uFavROu15pSeGemt?=
 =?us-ascii?Q?8nM+V6Fd2y41DsmbjGJs6v4iq4YgVYs142WoMqdplr9hC0ydO7d/ev1DkJEi?=
 =?us-ascii?Q?CzlXnmBSwBSJxIwKx7TobOcrcUvo5Ts80G4gfeVY13nQjBTwR0tWsJ8PTSst?=
 =?us-ascii?Q?my8/mWXcZiXDqf0PKJsl+znls11Bif5HzMToFdPB42nJmishf1iOEb4tfk2U?=
 =?us-ascii?Q?ZnGuUFPaHMp6M6Go/DKAI5CSsakTR+C3fnHIK+XYyqhsKm20vQs+0TUPqoCU?=
 =?us-ascii?Q?yQTzYJ4o1tN5jiSinV4kgU0rKyAsBRSHMH4Y6XejDa+/Sx/nRdbhweNZjkgn?=
 =?us-ascii?Q?txGYg1junF3W5dk72WeBqIHM5jdhWFjqCnI6TJyEJB4JbQhNQRgUkaIEMGd0?=
 =?us-ascii?Q?5+Ph0e8w68gUeClVMVKIL+7l8j15x8xCiovhR5oCbCYnvyARqFtw4MXr6lEk?=
 =?us-ascii?Q?fb9JKZQ4nSsiLD3oSeUuLaS13F14oqBaou0bFywhqnmFSuuFu37ZpC4eOzE9?=
 =?us-ascii?Q?znvfHpwIlBbw9QF6gsQMpsVVVwUOReaBb+2B33UpgOD9TUW7LUf+7kpXjFRz?=
 =?us-ascii?Q?VuxjKLY7IKZifyPeAboBmTc7NkjzED5BtwGpyad/Ctl/NP6ns+bERGjvZfYi?=
 =?us-ascii?Q?LMBFk9fFtRzZRj/hdlUU7IbEFkcRz6SoUW0ig/fIHcaYuiFI50d9MAipqqVV?=
 =?us-ascii?Q?p0RORsyVhWoryw22tLaATrYXd4EYlr83y12yFU3wSh1qq/EEvQz3SJeTcOyQ?=
 =?us-ascii?Q?kzJgdn3TMYlxza+TER0kfgIAD0lDGL1jCcuqoJ3pa6LIWx/jQJ6kf3Ivfsb+?=
 =?us-ascii?Q?KkcfxWwE+IpexVe6JfOZlboY9dsqrRQeoeAeXuLfSGATAJJH2L9aK7yrfmBC?=
 =?us-ascii?Q?UFQAuMAP6L2Eq4KlX4Wf11Awape5NOI2eincpugPHMShAK7y7QhFwxXSK5q/?=
 =?us-ascii?Q?9aIId2jTDS38PuUfPhFf/Age9/4ie+8mhffqW0fE+BPBTZ36D51unjOgofz6?=
 =?us-ascii?Q?vULtN7KDcSS+aOGDqJ+MW/9evx2xiR7B55lPMRsb1MwbG7OYCiPTLdQakF1e?=
 =?us-ascii?Q?uqIrjq3IQ/hck/nIIymgClWNVVgpDFsqh472BNB+qdpGVReQlkVXaKb3hi5I?=
 =?us-ascii?Q?9Pdk5So1c5Sh+qnQUtiMR4kz4LKJXmyeATZ+isxpJkIATPgiReT0Dl6RvDUz?=
 =?us-ascii?Q?6iN9jUN26psjXUk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:51:00.1317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae52d2d-895e-4ed0-79ea-08dd5a5a6e5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298
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

drm_* macros are more helpful that DRM_* macros since the former
indicates the associated DRM device that prints the error, which maybe
helpful when debugging.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 253aac93e3d8..2cd35392e2da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -69,7 +69,7 @@ static void apply_edid_quirks(struct drm_device *dev, struct edid *edid, struct
 	case drm_edid_encode_panel_id('S', 'A', 'M', 0x0E5E):
 	case drm_edid_encode_panel_id('S', 'A', 'M', 0x7053):
 	case drm_edid_encode_panel_id('S', 'A', 'M', 0x71AC):
-		DRM_DEBUG_DRIVER("Disabling FAMS on monitor with panel id %X\n", panel_id);
+		drm_dbg_driver(dev, "Disabling FAMS on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_fams = true;
 		break;
 	/* Workaround for some monitors that do not clear DPCD 0x317 if FreeSync is unsupported */
@@ -78,11 +78,11 @@ static void apply_edid_quirks(struct drm_device *dev, struct edid *edid, struct
 	case drm_edid_encode_panel_id('B', 'O', 'E', 0x092A):
 	case drm_edid_encode_panel_id('L', 'G', 'D', 0x06D1):
 	case drm_edid_encode_panel_id('M', 'S', 'F', 0x1003):
-		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
+		drm_dbg_driver(dev, "Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.remove_sink_ext_caps = true;
 		break;
 	case drm_edid_encode_panel_id('S', 'D', 'C', 0x4154):
-		DRM_DEBUG_DRIVER("Disabling VSC on monitor with panel id %X\n", panel_id);
+		drm_dbg_driver(dev, "Disabling VSC on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_colorimetry = true;
 		break;
 	default:
-- 
2.48.1

