Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93607C282C5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 20:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B0210E002;
	Fri, 28 Feb 2025 20:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3XktonZ2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B45CC10E002
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 20:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYh3eUbSZ9bdvUJgD3EU1E7OJgR7MuQiSKJf9hLgFVKakx2xEgiLML/ASKFtzyWFyTJhlYUbG/YyRluut0Mhbh7V7c2v5m6tbjXL+MAJOcmtWCm456ZDI+05DxBbi83llsrtjRY8M27aYlOSz0Hsw8r+/p791RvNVSXDTQYPVy0bBZIggmOdumlWjkOPlNe4rrDp9IvQFt1MkKyvJVFzpB3zaNlGEAJRwq+jIXkobBNI4qFSL/XPF2WYKH0YIJdrbFACFPOZGkJNZC1nqdzs98eMRbbJGvjOLyhWgWheJkv5MnRD4YLLK+t3MytMRRNS04WU/ef0sWP2fMq+RZk1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn/UYZ2mjo9KbxaP92vJ8WbE+B9Oa0QZtINRSVZ8Las=;
 b=G79fCOEyOROYnWmqOqrXSmUCiY2aFkYAQbV1bArxT0LPYaZwud5/TDekSyT26m2IQl/uwIem7yzoSP8NUE+nSzrsprN46Uj4v2S7gIIrSXOGIZ99k/JqOzt/qweauOyZHRaf/rME9bLmSpgx4TS3UHxLeLlzBsWSAY0YZAG3t1hXwHchcmV8S4HUkGYL5S4R9LIQ2c30BN6rDERw9mDQbNOe6xnjq6FzYPe70mVJCgwTOoDskNp5KpoMoz4njWltYkUwQC27OGLVcHkM5KbJNE+zlvRVpbwwBbx0psXp+jUBOdddU0XMrFUDbz/eavPzD6bzHW/xOq2jnfhdzqm06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn/UYZ2mjo9KbxaP92vJ8WbE+B9Oa0QZtINRSVZ8Las=;
 b=3XktonZ2YVxwXAg5oO7CdbLdjN56Eiv+ZniDiOfpOh085tV8IIJ+IGyZy8t70N6jA22AdcoKNOQeK5oyqsF3ZSQ2CAXTlSWud9gkEj6gJls0UxijiiNsVa4CU2gxn4mFK+GqWFmVyixqvlBY+3brf+KA7qwXfKMdV/+tqaEiRk4=
Received: from BN9PR03CA0733.namprd03.prod.outlook.com (2603:10b6:408:110::18)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 20:29:07 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::af) by BN9PR03CA0733.outlook.office365.com
 (2603:10b6:408:110::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 20:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 20:29:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 14:29:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add rebar parameter
Date: Fri, 28 Feb 2025 15:28:51 -0500
Message-ID: <20250228202851.2550575-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b009fae-3a4f-4bd0-9724-08dd58368c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rOo24xuXowozXd7kerGKudQRFPxJfWVqcs1GESMCiOP8WX+Vf6WFF7NsE76X?=
 =?us-ascii?Q?UPC8yB+YqhZJMe8UFglwjtWhBQRYDfhL0N8Rgkrhu3ojfmDUm4XQyv9tZg43?=
 =?us-ascii?Q?vaRIHrw2i36TcRskQvNe2en1578eBSs0zArcZXe0lgPuKKg5KtwMrR4yWsaP?=
 =?us-ascii?Q?AFxvCrLKuBEPJxHxqS7gszhUqWTXsTJgASFnlZhnPeKl4LwtX+EUgOmzbHmU?=
 =?us-ascii?Q?2q9tE1xw6RBKPENnNj5eYZP6vil2gRe/DRP2PwpLQYBOQEdAAfw4yQzjYpvd?=
 =?us-ascii?Q?6DqzfBTk8fiU1PiKKz6ootkh1JMI7lcy/3XXUA45mK720l/vMQpg6/1Mj2lx?=
 =?us-ascii?Q?cK0W05Vvct9QoR7dPfEHypK46GbGdQ0ZDPciBRy/zAngvh5QzxxshFSPRd/x?=
 =?us-ascii?Q?wcmnf985Pl0bWuhG4lWlpSZWPq4F+8cjSVlfV3t19T7qBfEwD8GQ2yW2Gk0j?=
 =?us-ascii?Q?4Cg040vArUEgjqLbMc+PVvm2AAPwuL14FR4eYdt2zfXKOSsr4GI0cRDu8rHt?=
 =?us-ascii?Q?Puef++aEvGWXQ1sqq5akn6XJx57dqyxF2oK6OkVxc0D6nm6VWcCdDL2rVTQp?=
 =?us-ascii?Q?bvctiBNAvQkK2UV/fuZFkbiVGGlcOPggrBGJ31A482hBOt3ptfuxbLHMEGHa?=
 =?us-ascii?Q?IB3NPA99JpJMCibz/nezcjJ8n61RPHLb42cjRhmJeF6gIGuGK3VZ6zByLqPU?=
 =?us-ascii?Q?OBzL3YtnkxXy15JK+TTBK9JjYjy77NLCt6Wm3MGoP02t/r9Qs0/fiG/K0g0H?=
 =?us-ascii?Q?mUlM6JWSYU6CtFTfHojdvBQGF9UF8tzRHGUhQj7A97EIrPieAv/KdKpT1Z6a?=
 =?us-ascii?Q?tq/Obwm+4CYHKmHyGvxxiW4gYRT98v+TU44yHBUlGBD8pDbPJoyjm8XCbefc?=
 =?us-ascii?Q?tWVi5OLniKARK2JbfNu7elXEzgg8hE+N6he6L8VrzcR48g+XVbRzI0sw32m7?=
 =?us-ascii?Q?cKsQRtVrm5vQYbvO8wwOw6OslfT1DRnq7zizEPgjSJUI2tAANXgXI9KKvURA?=
 =?us-ascii?Q?dQDowiVdKuzGQOu/qpgboDIL9ca5OSeTCQQm7XROgCDGEX+XQcF9w02GMvPZ?=
 =?us-ascii?Q?3YKnqbppaWQdxe6q6HhopVqrzBXu2eKh5F5XTXj+sM58RKTXDlVp35ls/Pyn?=
 =?us-ascii?Q?u0uxJJr4P9PRK2Dj8/fGOsawaGFgj0bVjyP9ek3DJ96ipZj92YmP3lYLmDbd?=
 =?us-ascii?Q?q2NZRcopitTn6WTdR8RNWXU+f/PZ6LjJhy/QQ9vGCmEZ4mwZs1UDB1OA4jwS?=
 =?us-ascii?Q?O6CR48z4lyQaSUW/FrZsyAFX1NQc4vzE0pVCfIeqy+E7UHiWI2P1dn2THI7Y?=
 =?us-ascii?Q?Smudf+JHCwLQ+FVyptpVGwyMXjQDhA+3R2adugJ+ox5yVIb/Um/KaRcfj8Hj?=
 =?us-ascii?Q?uEMGdrgEtvB/+KC7cx6bdnBiN80So3OX3tlvYt7+oXbevn+a6PKoMh6oeJKi?=
 =?us-ascii?Q?Eeqy4L6PKV5UJdeNywSuYh/8mjY/G7TWus/5nndEpsUO3w/BWZQvmw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 20:29:06.3389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b009fae-3a4f-4bd0-9724-08dd58368c6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
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

Add a new parameter to disable BAR resizing.  Note that this
only disables the driver from attempting to resize the BAR,
The BIOS may have resized the BAR at boot.

Some teams have found this useful in debugging P2P DMA
issues on systems where the available MMIO space did not allow
for all of the GPUs present to resize their BARs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++++++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 87062c1adcdf7..948f832f469ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -268,6 +268,7 @@ extern int amdgpu_umsch_mm_fwlog;
 
 extern int amdgpu_user_partt_mode;
 extern int amdgpu_agp;
+extern int amdgpu_rebar;
 
 extern int amdgpu_wbrf;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0a1a1f3ee5fc0..cc1a991ad4719 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1662,6 +1662,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	if (!amdgpu_rebar)
+		return 0;
+
 	/* resizing on Dell G5 SE platforms causes problems with runtime pm */
 	if ((amdgpu_runtime_pm != 0) &&
 	    adev->pdev->vendor == PCI_VENDOR_ID_ATI &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b161daa900198..333c78ac000e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -237,6 +237,7 @@ int amdgpu_agp = -1; /* auto */
 int amdgpu_wbrf = -1;
 int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
+int amdgpu_rebar = -1; /* auto */
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1083,6 +1084,16 @@ MODULE_PARM_DESC(wbrf,
 	"Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
 module_param_named(wbrf, amdgpu_wbrf, int, 0444);
 
+/**
+ * DOC: rebar (int)
+ * Allow BAR resizing.  Disable this to prevent the driver from attempting
+ * to resize the BAR if the GPU supports it and there is available MMIO space.
+ * Note that this just prevents the driver from resizing the BAR.  The BIOS
+ * may have already resized the BAR at boot time.
+ */
+MODULE_PARM_DESC(rebar, "Resizable BAR (-1 = auto (default), 0 = disable, 1 = enable)");
+module_param_named(rebar, amdgpu_rebar, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
-- 
2.48.1

