Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C47C282DE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 01:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD98810E1D0;
	Fri, 14 Mar 2025 01:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Oq/1vnh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C57E410E1D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 01:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaZoExm0uWxLIoa5ubcqkdwQOrmMIqVTCN4SRdod/NUwkzP/tM46N4jezXyzZFR4b1pW5jYFcNi7duqE0ZdjHsaHMw+M6X6m7//+DHCSOdwg0WHAdL6XVDlA7L/cI0Uvqg56adeGRCYfoOtP+vayyZJMYeaL9ZDZyjzwAMRbUEZab+L+jmxK9iQtFSIn2NrzNZSo68+oyBI7j4J6QqfPCmi0P77CjTQY6o5NEmrDEuXupXN5bbP8L0Y7cSzWECAqxY/cZ9j4aVABVH1aWJAbtLYtVOGXow5exZOOUAo++Dmt30vT32xshkDdrZNeRvsrVch0xPCdkbzSUyswVAP1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTnv2s0Ve5ibNhIbUXCPt7EXKYubMkMxj6YyXfj91Ec=;
 b=F45thnM+uAcETsbDzodjPuML3fx26WX/sb9OlAN2kfktFn/pbxBQ4/7JUogAYDhgKM3J1ha+sG9e0XSmRppBew9icd7J78n10lz814m+/r/3cWghKpT4kozq5NkuFj5rhggsd0ezD+t8sQgcO0NtkhSMHkPAmCNjD/qVHr5aOj5dvJIbRfwBC/XrNVYl5CxHgChFSSDxvUQvmbfCBMAwIKTfeoDkD0B+OH6/vVzWfdpaqP0lotKPhLZw1HHuJaNa/OYuF0s8LowQdHARZbECfIyhGRVWUamOiXhEk2/vBm3gKsoiOrHFHt3hNyOknNGLYxioqS3R3k4MfvfAmn7vVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTnv2s0Ve5ibNhIbUXCPt7EXKYubMkMxj6YyXfj91Ec=;
 b=1Oq/1vnhKNHVpbU2wBeMz0J9qhdkemj5DCKjMkiETQ6m0NLz5Dsyh540JHxMi4nwDelvWWyR2dwUvsOClfqmGGylYVUELRWT8CMxBQLhwA+0uI+wCKlyPd8OejFxSoTBTDkJCwfyJIszUc8eutqeDYY4SzwUqgaTv4gfHknJ+Rs=
Received: from CH0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:610:cd::23)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 01:02:07 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::41) by CH0PR03CA0108.outlook.office365.com
 (2603:10b6:610:cd::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Fri,
 14 Mar 2025 01:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 01:02:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 20:02:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: adjust drm_firmware_drivers_only() handling
Date: Thu, 13 Mar 2025 21:01:51 -0400
Message-ID: <20250314010152.1503510-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314010152.1503510-1-alexander.deucher@amd.com>
References: <20250314010152.1503510-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: 990806bb-72ca-4e13-c6bc-08dd6293d7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ta/LgWKuEzGxRC7/BWAe1PDqLOsGbSL/u3XvE4tzt//fyXjTmI95dOvUDEZQ?=
 =?us-ascii?Q?lCuFWAYdZcTfZ3H5mxMJ3kt0mC4UuBBQwRHPUnXGfnczgKGxjZ1clQYYZM+U?=
 =?us-ascii?Q?PGAfO0MuXH46SUZ9EaYK87n77C22oyZXMETBXzB5uCqb6KHFcII22qT6jPKW?=
 =?us-ascii?Q?Ctm6P9GDkcNEdVN5oj4os0DrGdxTTdrWs1Lmm/CfqGVGMoNSGCdnQ6iIMxzg?=
 =?us-ascii?Q?O2jpXKu0nU3HFvTl5SfN87RKfCOEdcT+DIbLd+G0W65zwfQLEJp6OG4jMbNA?=
 =?us-ascii?Q?j5GNkik6SeoQXxiJqActhOAfboJArcHmcfXZs1n/aW6kir9PqG0XtMtycmvl?=
 =?us-ascii?Q?KowCStZktizEWO7UNSXfWzcQSgqXa+9p/rpHnY8j4fpH4nVTZDEnlLkNmAtN?=
 =?us-ascii?Q?EM4joepMQ0r7dvMpuuDw+31wfLUpSbAWDoMiegGQv3ay4hSqlo18ipvxsbwZ?=
 =?us-ascii?Q?uB2jBFpGgwaLVFcqSwyW5QJKqIQihU/s59HsdsM41APr2b5bTWlCFwvFUTQc?=
 =?us-ascii?Q?C3LY3T+ZeGpuetLOAEEzHb3bMeWzDqqTioRjDzkiNnsRk+mqb3rDv1fs65bW?=
 =?us-ascii?Q?pA+Geo+d+eZ6DXv2ZqWakGgvMFrpzEC+MbqXbd+W2fh8E2yJhRb8ARFYBp3u?=
 =?us-ascii?Q?FzTlfLQYSaDGREK+9q5GBG26gZfa9BNoNK30LzA2XD5FzQf8Uu8rJsVUe1XG?=
 =?us-ascii?Q?5NFM1eKDCSw9N8YHAdv8ha0N5K3LNKBzOT87tt+RcSv9MSZVg4Hsh+li5z5X?=
 =?us-ascii?Q?yXIORKEUpivyLtOGRK8P1o9d8U+wy1/ijhLDphxtkF7JlZLXUnFhgRKzvpIo?=
 =?us-ascii?Q?Ql/cozaV8BzUKPkv9H/1bFBTdQpJ0GLB5tzEevywnCU+x9qUcM2pElqZbSkf?=
 =?us-ascii?Q?F9LIr5yVYV8s9ZHK87K8IOluyzvsvE91xPjJ9uVYIB9QgL89CGgUzurCQ2UW?=
 =?us-ascii?Q?DiEqlTb+/4brVpwHVIAKnZsKvPcMr/BBcL8q7tcue4AyByqFvkpCacyonoRb?=
 =?us-ascii?Q?zG+E2U7LIo0QVN96PnX5r/EvuQbSBrtU/Xf3sv7J4irmTKdHKzJtXjH75Zx9?=
 =?us-ascii?Q?vCpQTMbvF09dFPRDct4TqnvCk/8qPhNU11quxIgAA95/yxwPB3hI6W7oc/iT?=
 =?us-ascii?Q?BEF4pYecEhi6JtPtpWqWVfGniFF9CAMyC42JKYiz9gcTfaZzZUfhFlxtj7ji?=
 =?us-ascii?Q?VczQ9GkmAtG8XC++cnxu0p3gWKRstteGGioC5JP9UJDeGujC8XClDw3r3qaB?=
 =?us-ascii?Q?dwjikNfAM4FdGFeRXNzFO67dlhQU+s8r8W2ZIB2Sk0K9M1hgLI7ZA2Wk8avk?=
 =?us-ascii?Q?2mqkGNebFg9LGGh0G4U1jPY7RW3iFYxjQZs6gmZwVfFnu1BGTXtWqm41paIh?=
 =?us-ascii?Q?phHlRXmsQBHr1FQWefuSCTOXUcyFCOghSxaPPiZolo4mse4vsFAkPe/+ybys?=
 =?us-ascii?Q?mizeZ/fPNDnpkk83VP4ZGf6x38NYMomA0M9jj8a7uA0ORqRMhany/sEAlZEN?=
 =?us-ascii?Q?XDQACEbC43h1Wis=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 01:02:07.3049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 990806bb-72ca-4e13-c6bc-08dd6293d7a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795
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

Move to probe so we can check the PCI device type and
only apply the drm_firmware_drivers_only() check for
PCI DISPLAY classes.  Also add a module parameter to
override the nomodeset kernel parameter as a workaround
for platforms that have this hardcoded on their kernel
command lines.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index dd86661153582..4e1a6a249bba5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -178,6 +178,7 @@ uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 bool enforce_isolation;
+int amdgpu_modeset = -1;
 
 /* Specifies the default granularity for SVM, used in buffer
  * migration and restoration of backing memory when handling
@@ -1040,6 +1041,13 @@ module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
 module_param(enforce_isolation, bool, 0444);
 MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . enforce_isolation = on");
 
+/**
+ * DOC: modeset (int)
+ * Override nomodeset (1 = override, -1 = auto). The default is -1 (auto).
+ */
+MODULE_PARM_DESC(modeset, "Override nomodeset (1 = enable, -1 = auto)");
+module_param_named(modeset, amdgpu_modeset, int, 0444);
+
 /**
  * DOC: seamless (int)
  * Seamless boot will keep the image on the screen during the boot process.
@@ -2270,6 +2278,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	int ret, retry = 0, i;
 	bool supports_atomic = false;
 
+	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA ||
+	    (pdev->class >> 8) == PCI_CLASS_DISPLAY_OTHER) {
+		if (drm_firmware_drivers_only() && amdgpu_modeset == -1)
+			return -EINVAL;
+	}
+
 	/* skip devices which are owned by radeon */
 	for (i = 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++) {
 		if (amdgpu_unsupported_pciidlist[i] == pdev->device)
-- 
2.48.1

