Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E751DEE0214
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 07:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C816F10EA14;
	Wed, 11 Sep 2024 07:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BOH3tSdv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A82110EA10
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 07:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OK2QMbEulLUUwT6L9tHsjO7BVYY8kCa7m4u8UrIjP/eUT/tMrDMJLN6n6yu+THh/gUgFqYAGqz1VJ7Fu6L0jp74bbBSxM5mDUGA8BLP9NwjETHRdsKldKBfcrnSVg1beBHqpsOcEjLnCSkIYDOqEh14yxhBkXDLjgcotzjOgWe1x4jajOY0ib6ZokERTMXjLtZSxEM73bcfACLDXJzHkaswC0xJsIH2tV8kMWdcmGVPwHM1YKBnmg0dZaMYzoTiHnJXnF4T4gwAoo/QQpQ+78o7WE0ca1d0udsTcYCsFsIGzMJ+DrrGnHwx6dE5nKTwTAh2B/xGeS/4vkw2AcDDdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMTgzgNzP6FPTVfOoTTNzr2NFX6kBu7uZ+ZDlRY5PTQ=;
 b=l92ka/9vkjOGd1lcpXHsPQ9FUILiWlWcIEDB04PJQc/G/MHKYXfLiJvLTEcq22hvuKTgPnzG5irikDAun8noD67n0VWWrnjRoDkdtXsDDzdujuleGgCElkovBpqzW71WufmMIdMWzsyUwdJNvH7rGa5dT0FY3+E46BP5J9Ya7cgi7inslwhVwrH0gJ7eU5zTqJSWB1JbG8sF9zljB42v8w7m51nPe/3pfNq1D6+I5WWjqhj+OfqRWDDoitZE96UnE82FJ+gHmBZXwIQTv16EiXw2+8p8QiPWZ+MeQeiavpzokB0Fy+6nKYSS3wSQV7MlhuC2rcQ9SeZXoNULRYz8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMTgzgNzP6FPTVfOoTTNzr2NFX6kBu7uZ+ZDlRY5PTQ=;
 b=BOH3tSdvIX448XVZIaVWN7nne/Vg5ZYu1UoXJj4oQ5bbrVxRh07cM4rx4hKmbUalBkhFnJ0/FK48x/ezNkhV0WGc6LpLe4NwmNp5hsOyOwhhYK/kAkNlOkjy/K1Nz1oebSSz/8WgFCcE2zEHknMEg+7IzxO4GvHBtskMy5lz9Z0=
Received: from BN9PR03CA0520.namprd03.prod.outlook.com (2603:10b6:408:131::15)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.19; Wed, 11 Sep
 2024 07:07:37 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::c) by BN9PR03CA0520.outlook.office365.com
 (2603:10b6:408:131::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 07:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:07:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 02:07:35 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <feifxu@amd.com>, <rajneesh.bhardwaj@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 09/10] drm/amdgpu: Add interface for TOS reload cases
Date: Wed, 11 Sep 2024 12:28:57 +0530
Message-ID: <20240911065858.2224424-10-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911065858.2224424-1-lijo.lazar@amd.com>
References: <20240911065858.2224424-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f71b7d5-10e6-4d8a-aaf6-08dcd2306b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dAfHieWnuuPOxWP2XRZ/2fkVozN19QaEau7wnZ5ozeyAjU7cAmx6uK1XfBbw?=
 =?us-ascii?Q?LLis4/SjlYU4ZzagrzbRCDbwGu4NYnHEZHl2z9fstRf1gX/4aVlWfkV+spF6?=
 =?us-ascii?Q?ae8HfGXnM0OTe6jQOkV00wzn30mMPcomjhJxiVdO262Kn+kAcSBj2d16ONsf?=
 =?us-ascii?Q?cZTU2mG1wMkLW/7LdBjAy7DxXUY4ID/3VB7xq2kdlGOLfiYfBPWzgwRZbnXD?=
 =?us-ascii?Q?vV+NP9tVQMWD1Eq1ChbbJswDmmMZhUvgXCVBuoLd0tv0SEXuRrhhPxpLKFCW?=
 =?us-ascii?Q?hbjvEiwb7N0d6KrHJ4k0eFQXYU3opDUZ1OrH/Ydu8lxkMxcYi3kvjYVKRVaL?=
 =?us-ascii?Q?f1mHI2J2yJSAl+opfTagTViyJAXCp2jZzHII/hYQkN8trvSbWyXoqfAWDciT?=
 =?us-ascii?Q?AMnB5DZ5buP5sXvK1J+ipux2nQEQ7tO4VgoQw82oG8ldPhjuzoRwr1un4XWo?=
 =?us-ascii?Q?aBJyKZfXenUfdQ5iWDQhUd3igi29fLoesvbUKYpIYlMyy7EQkQRQq4U8CA9x?=
 =?us-ascii?Q?hTl2MO3UKoVsvF5wQOs6crEePdKplCV8V5vG6QJzQT+JqpBoGqOgGqxxuNoi?=
 =?us-ascii?Q?Qf/jsdDKQBkbmeeQiB29d90cThCgAvZYOXPxSCNo+g8wWscLJB84XBQhnurt?=
 =?us-ascii?Q?WeVvAa9YzRz5LIdqaqJG7MH4SYASqSwV3r/f33uFZ3uMpy7c2GjZ28C2ZC+5?=
 =?us-ascii?Q?nV+esYNJ+R2oItQVhGi/8Hiay3/G4ed/U9F7roe103Tf4aVwfe+Rd1+2rwBm?=
 =?us-ascii?Q?8O81cqNo5/+M+yO5bxar93+Iw9l/I6DcwPB/PZnpfJTwgNUsKgb6M2Cg1B9A?=
 =?us-ascii?Q?YSeJT/BFfMXI/sEtlSU2Vx8KmTOS+toBTUOH/ArSnqiZ1Pj5x3ojNzItFEaP?=
 =?us-ascii?Q?ziMZIah0F9Q9qV3LavO72a0sys0yLiA8nidn4FZTY6iOpyMRK+yuJzMxBuB7?=
 =?us-ascii?Q?vIDYmXm8Bcrq0MhjL1r1NmtYejMdK52P/rlg2C5GP+fk+NtWzreu7Xf89cA/?=
 =?us-ascii?Q?unAp1xXGhkD6W20ZBlHbdCWvji8TEfw1PG4DNUJGKz5gdk7Ko0H7skZXurYg?=
 =?us-ascii?Q?3wL+OSM0cDrEaUB2DaiG5qsX+8jS7tI+Uy/afwM1w/SUnATKcuwGQ00r3yBa?=
 =?us-ascii?Q?dclQJNSUgSBviARaPHSi+LucN3w7u3RUBmOwqU9qr3Nh0IEhSrU9wtGMbchG?=
 =?us-ascii?Q?yzBVYqOyRytP8Bo9ATg4f22cY6R0VacxkNciPNBD2PZ2y67Y6OvVAs9pY9XU?=
 =?us-ascii?Q?Q1+bWo0W/dRZim4L8f1myJODscBYVtFt8FSsAHlHWCNWS33OmVzRkSoWxFmh?=
 =?us-ascii?Q?5i1AyvOMVZTzNi/6J57XkiSfdw4UWokkF1fUAtVts1O/QAGzobBI5MFEMFq7?=
 =?us-ascii?Q?g48NckCHbxpZ91N5/Q9F2xtXKx5msFGV8qc4EN439sd3Q9ZIn9CbY1hD4YjP?=
 =?us-ascii?Q?xkLRV+o+YdGjGzAUyKEBuRtubWyy8mg1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:07:37.8412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f71b7d5-10e6-4d8a-aaf6-08dcd2306b3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
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

Add interface to check if a different TOS needs to be loaded than the
one which is which is already active on the SOC. Presently the interface
is restricted to specific variants of PSPv13.0.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 25 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 189574d53ebd..3623bea2b1e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2264,6 +2264,19 @@ bool amdgpu_psp_get_ras_capability(struct psp_context *psp)
 	}
 }
 
+bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
+{
+	struct psp_context *psp = &adev->psp;
+
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
+	if (psp->funcs && psp->funcs->is_reload_needed)
+		return psp->funcs->is_reload_needed(psp);
+
+	return false;
+}
+
 static int psp_hw_start(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 74a96516c913..23581c44e625 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -138,6 +138,7 @@ struct psp_funcs {
 	int (*vbflash_stat)(struct psp_context *psp);
 	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
 	bool (*get_ras_capability)(struct psp_context *psp);
+	bool (*is_reload_needed)(struct psp_context *psp);
 };
 
 struct ta_funcs {
@@ -553,4 +554,6 @@ int is_psp_fw_valid(struct psp_bin_desc bin);
 
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
 bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
+bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 1251ee38a676..035e0ceda4c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -807,6 +807,30 @@ static bool psp_v13_0_get_ras_capability(struct psp_context *psp)
 	}
 }
 
+static bool psp_v13_0_is_reload_needed(struct psp_context *psp)
+{
+	uint32_t ucode_ver;
+
+	if (!psp_v13_0_is_sos_alive(psp))
+		return false;
+
+	/* Restrict reload support only to specific IP versions */
+	switch (amdgpu_ip_version(psp->adev, MP0_HWIP, 0)) {
+	case IP_VERSION(13, 0, 2):
+	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
+		/* TOS version read from microcode header */
+		ucode_ver = psp->sos.fw_version;
+		/* Read TOS version from hardware */
+		psp_v13_0_init_sos_version(psp);
+		return (ucode_ver != psp->sos.fw_version);
+	default:
+		return false;
+	}
+
+	return false;
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.wait_for_bootloader = psp_v13_0_wait_for_bootloader_steady_state,
@@ -830,6 +854,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.vbflash_stat = psp_v13_0_vbflash_status,
 	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
 	.get_ras_capability = psp_v13_0_get_ras_capability,
+	.is_reload_needed = psp_v13_0_is_reload_needed,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.25.1

