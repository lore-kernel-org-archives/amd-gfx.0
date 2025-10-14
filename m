Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBA5CCD18E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 20:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E30710E69C;
	Tue, 14 Oct 2025 20:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5CDoE+2x";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12AC410E698
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 20:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIi4+viOxz90X+pv4QJ5tu82s329qb3GHtUDg+oKz+lfWbZjMxsQo/iGVJwkJW+gdN5yIfwy71rAut8tObsQMhErLvCFICj0lWo9L/uwRi/vmfujvS39q7Vt3F+FQANsHbztc8gYBN8azm3sEQlZP30YkxV7LLazrEhaIOzz0V1OHU+DUHxYQ0cyt+pwJzGRmtBs+krH1Ft4NCo1etKa664iUtq/FcsiBshhqxwbDktbWn9+y2VOCnRHbFz27e+xRUYWK8TJbwuBKaENujo1TA4dbiaHKohO5KU/OUODn3pjHVdVlgRqDFQO8QNCsv4dV4olWQNXRP5xAUZvlIyp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNXvJT1z/Cgld+QqnisGRMQuWtxkNbuXl7rowwsGyZI=;
 b=qfSxnyBqohVD4qaANDY9e4MZPY4XHao7qlwaJi6Pric1wXyuEnLcNxTGqUb9lkTfvQPHaBYlKvCGGEnwgJFAe4sP3soLuziFxjNWUaeOQfgYMuxpqby0NRIR6go+H0x5C8iLPEjmq65pXtI6MBaGq1poQEIm56t/T1MPh8FojMhMkVd00FXz9tkEm3+ozMhkziNzbrxKWaqFvGVsVOnLtTNrq2W9vy437m6TIi4GNvbUAS9YzGO0+B50wy6ngtlZpgYJxPy7iSDG6FQoM3wVkX18CYgpjj24LVgy7ok9X+cj9CEGVjZyTN5u02IVlEWiUV7LO3ZkszD2L/iyn/OTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNXvJT1z/Cgld+QqnisGRMQuWtxkNbuXl7rowwsGyZI=;
 b=5CDoE+2xb3s5Q/5lKNy8eiJncxPjlTB7oFfi/YfhmyLK/LZaDz32tTpZ9lXPfDhCJY+Zd2tdoxIcARGa3Fo9GcZwERiAfTqNCRU9SflICzMAufsxs4PWqFIHVlmCbieDwz09Gv65ySAyPRYd780pCNW8t30R3C785nM4wpDh3Rw=
Received: from SA9PR11CA0002.namprd11.prod.outlook.com (2603:10b6:806:6e::7)
 by CY1PR12MB9603.namprd12.prod.outlook.com (2603:10b6:930:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 20:14:04 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::d8) by SA9PR11CA0002.outlook.office365.com
 (2603:10b6:806:6e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Tue,
 14 Oct 2025 20:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 20:14:04 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Oct 2025 13:14:01 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v4 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic critical
 region in SRIOV
Date: Tue, 14 Oct 2025 15:13:44 -0500
Message-ID: <20251014201346.9422-4-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014201346.9422-1-yunru.pan@amd.com>
References: <20251014201346.9422-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|CY1PR12MB9603:EE_
X-MS-Office365-Filtering-Correlation-Id: c822764e-2443-432e-7d38-08de0b5e393d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qEWYnfMZkKrpyODdXMTlDpQi0xYBVeo3fkZWaBriuwKlWh1NR7ZABHIZs0lP?=
 =?us-ascii?Q?vuvB0CCWJzOKd5WOveG916D4zaiRaoLh8/5sixLzhNKrnjHgImXIMwY2+4O1?=
 =?us-ascii?Q?+ee2iO3PDH9J845k+Unn48L9Sf8tibMBFQhs2ijQhelD9faVfDB19D26YJ5/?=
 =?us-ascii?Q?pL9cxmyac64oP8d7jEq52Mgclk6JoqdmQ2JCmI5HUYAl0z/P8oabMxQSIKXy?=
 =?us-ascii?Q?0wDFwBAYmADqpKoMy3RR0x9el4LFxiIjLtYFyp3VrL/PrBYgcQ+S6XVduQ4d?=
 =?us-ascii?Q?ayg7UmnCTZGsOaSZDCPT5wUxQu/qRUpFZrRWq3w4myaW3mmo0aEQC7V3Ffqv?=
 =?us-ascii?Q?oo9C6nSxXbLiMczJYCal1cbkxKPu1hzG9kinIqh7qhzPe0ErYeQb1zjM8GK+?=
 =?us-ascii?Q?kY8Jq0z+u5OX3s5mYpAxDVnQzwQOYPSoY3By2dvwIkA9RDRwjzAO8EaIfFYt?=
 =?us-ascii?Q?dkXblIZ/SJ8BYkTPRthpMXnxJ4DZnhb5qeum8UM9jdpebLb9jTpPlwB4i8xO?=
 =?us-ascii?Q?rjuSzcQ9FyUcHWvz+DUPVxRf0UOXgmdAyfrxI0dUSAJGP6nvEDmCK2yZd0Oy?=
 =?us-ascii?Q?UcKWgEFb9dakLAdu78d2lZNVD+qd1dbwcIKcY7PiFfjIVlA47CNQ7PkC+v6/?=
 =?us-ascii?Q?/sIlwAB4nOBjBOEoSCvIE+wyXNNiCxl5FZozeFk2MOe5aK3lvnIILA04MUPH?=
 =?us-ascii?Q?MG1cSFeEhJ3NBHFmb/bfsDSg0uRxh4OPO3uMIAL4tXmFQMkr5iPbg5rNxkwf?=
 =?us-ascii?Q?hn2tEK4Paal/fwHvC/+XKOSCccUZPEhUIvC/eg+DGVoY68YOeaS4Hhrkk+9z?=
 =?us-ascii?Q?m/QQ1EzE2zyW7U3Adx+JAL7sqPppGwXKd5ZZtFFFHHBQ0c7k+BOAQBuZkpoT?=
 =?us-ascii?Q?mKT+CTZnoJA4XFETHNWTVESCYsLiB3rzh964cGA4gRA72SmsoghAl4ByZl0T?=
 =?us-ascii?Q?ZcSH1mreYVYUYeRQow5Af2SU41xvSXv0SgOI9HfLU0oa2T8/e+Bk8R23lFHh?=
 =?us-ascii?Q?P2kPC/FcmeaTDc3MbuePOgSUPNX1jypsEQGW/AA9yI96vedvie+Qwqe72or4?=
 =?us-ascii?Q?4b1fEg1znFEouv0zf8HJwotDlZWvluGU+MPvVamYtAHtkcHRHrEk/JNoiZfR?=
 =?us-ascii?Q?XpnakO9X5/FWajDs2cY6HVYnBzx06LjFqjomp+pB9S3DulyycSBy27qkVMtU?=
 =?us-ascii?Q?sNzF3Q2mODs3Tzn1ozAOiK/2GBWFKEX5EruwfDtE5KKNjmKVY3UjUI0/DSUX?=
 =?us-ascii?Q?MvrEbPRqXCIl2vKBSd5Bg9OwY/kM/JoHDPOHQ1CuOSrft47BvEKrFf8rWcGp?=
 =?us-ascii?Q?vGOvAMfe5gCrvhQwoDZwtEjxNhWQaxRy9klN+UNNIpG2gNqAti3f92B/z3ZI?=
 =?us-ascii?Q?dSzBc58wS4IoNopb6OCAPFdzS55K7N6GlYN95tY0odhIcMeGkpUA0wicqY0l?=
 =?us-ascii?Q?JWHqrZcBd7EJvtV+6dyhcJwnxDhH9F2qBLvdafwDEWUZzoYKBI/b655OlCa3?=
 =?us-ascii?Q?xeTpGAAbP7JvfSLF5n4DjZoRV2wOjdIfP7RC7aB8nDKos+heC+MJHUUsLQI/?=
 =?us-ascii?Q?r1jq66+wL861Wke6teA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 20:14:04.7692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c822764e-2443-432e-7d38-08de0b5e393d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9603
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

- During guest driver init, asa VFs receive PF msg to
	init dynamic critical region(v2), VFs reuse fw_vram_usage_*
	 from ttm to store critical region tables in a 5MB chunk.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 29 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 12 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  9 ++++++
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index c7d32fb216e4..636385c80f64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -181,19 +181,22 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 	u8 frev, crev;
 	int usage_bytes = 0;
 
-	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
-		if (frev == 2 && crev == 1) {
-			fw_usage_v2_1 =
-				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
-			amdgpu_atomfirmware_allocate_fb_v2_1(adev,
-					fw_usage_v2_1,
-					&usage_bytes);
-		} else if (frev >= 2 && crev >= 2) {
-			fw_usage_v2_2 =
-				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
-			amdgpu_atomfirmware_allocate_fb_v2_2(adev,
-					fw_usage_v2_2,
-					&usage_bytes);
+	/* Skip atomfirmware allocation for SRIOV VFs when dynamic crit regn is enabled */
+	if (!(amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled)) {
+		if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
+			if (frev == 2 && crev == 1) {
+				fw_usage_v2_1 =
+					(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
+				amdgpu_atomfirmware_allocate_fb_v2_1(adev,
+						fw_usage_v2_1,
+						&usage_bytes);
+			} else if (frev >= 2 && crev >= 2) {
+				fw_usage_v2_2 =
+					(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
+				amdgpu_atomfirmware_allocate_fb_v2_2(adev,
+						fw_usage_v2_2,
+						&usage_bytes);
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 96bd0185f936..b5148a33b6f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1944,19 +1944,19 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 
 	/*
-	 *The reserved vram for driver must be pinned to the specified
-	 *place on the VRAM, so reserve it early.
+	 * The reserved VRAM for the driver must be pinned to a specific
+	 * location in VRAM, so reserve it early.
 	 */
 	r = amdgpu_ttm_drv_reserve_vram_init(adev);
 	if (r)
 		return r;
 
 	/*
-	 * only NAVI10 and onwards ASIC support for IP discovery.
-	 * If IP discovery enabled, a block of memory should be
-	 * reserved for IP discovey.
+	 * only NAVI10 and later ASICs support IP discovery.
+	 * If IP discovery is enabled, a block of memory should be
+	 * reserved for it.
 	 */
-	if (adev->mman.discovery_bin) {
+	if (adev->mman.discovery_bin && !adev->virt.is_dynamic_crit_regn_enabled) {
 		r = amdgpu_ttm_reserve_tmr(adev);
 		if (r)
 			return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 27235f3f3b81..820dab538164 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -940,6 +940,15 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
 		init_data_hdr->bad_page_size_in_kb;
 
+	/* reserved memory starts from crit region base offset with the size of 5MB */
+	adev->mman.fw_vram_usage_start_offset = adev->virt.crit_regn.offset;
+	adev->mman.fw_vram_usage_size = adev->virt.crit_regn.size_kb << 10;
+	dev_info(adev->dev,
+		"critical region v%d requested to reserve memory start at %08x with %d KB.\n",
+			init_data_hdr->version,
+			adev->mman.fw_vram_usage_start_offset,
+			adev->mman.fw_vram_usage_size >> 10);
+
 	adev->virt.is_dynamic_crit_regn_enabled = true;
 
 out:
-- 
2.34.1

