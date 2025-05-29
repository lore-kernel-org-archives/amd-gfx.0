Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9054BC5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 14:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C98F10E07B;
	Thu, 29 May 2025 14:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MsQRsoPf";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF52710E1FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 14:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAnZLtMAuxKzHimZllsd7cV+qOt/3BMn3nHw0XqZt4+l7vLi98pspZnD3UppV/yDlhopDkkw3YNI70Kp1VnJqgPNesxqgqYeWQt4CsIYz5UPXzCwk3qwa/AdeIiFpSUv0LX5OzIPC9aavuNUC3Kq/C5nVS9lvXFt0mz2xnUyVMyuuPjEK91PR/pTrPTHgjHqg4YLYgWuw1pBwx6TBMKqejIU/rjO+MowTufWpaWkyIDfoI5BXVDlDz1j5O/j8wcKCrZDQ/ThEzi1XjjlLBwElIxTfVwwWCh0Mf4O53iPNL5GcZhuFST3jtkgpBczwgYYjF4kI30QuJFoTr0A+Nt+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEbKwzVIwaindiL4fiP/e+w59DgSrj+lSs2MPQ1Gvqo=;
 b=NpX/04y13B6Nxoz1cH4YNqTvpi0SkWbJjtTR5qf2N0JnKh94h3Oizl+J8hRHliF3nAXDzH6KWdmVWNAR3Xc2vatSWRi4UUSOtzAY/8Ov+B5HU0nlGp+7MuUawS8N5HcIzQsIVY7h4PZNGo6GLPc8fP+b3cltbWQGviwRJ2IHvijVtEnQ+PH1nR1UorRU5uJx/+cYcZZK5oe22xemGbcqqcYalhPLwTGf3RSvRVOwFNh2OCE7bZ+HxkKkst0M4KoIDAQcC9B4Pk4MIm4Kj5YSfPpayqWMq/KmkLJr1uGNrZkDmt7GVeLkCsLewnEUvBa7YMzURTUvFlNys6301agFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEbKwzVIwaindiL4fiP/e+w59DgSrj+lSs2MPQ1Gvqo=;
 b=MsQRsoPfkvgPX6zNfz3oafwG6TKHwKb2yCtHUzoJ3RKjwY3HxAtpIDMt4cfxyxiXVgqEYhhRKn6na2lGJ62WwPEj9W6umCwi7hl31Lr6UOsKMrbMdlFOOGN6bVsrzAsj6FzUq/HablhNkMcQhnUX4adMLqPMPizS2AR8nYTZk2w=
Received: from BN9PR03CA0061.namprd03.prod.outlook.com (2603:10b6:408:fc::6)
 by LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 14:19:01 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::81) by BN9PR03CA0061.outlook.office365.com
 (2603:10b6:408:fc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 14:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 14:18:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 09:18:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: disable workload profile switching when OD is
 enabled
Date: Thu, 29 May 2025 10:18:41 -0400
Message-ID: <20250529141841.849654-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 343aea77-c311-4ccb-ecb6-08dd9ebbc191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4mmiZHi/MPAvGuBw92BsiVr1J9hTVYKhFeNwlcOYW2Q+b+DEXaA4//AMkHfk?=
 =?us-ascii?Q?DZzWAjyZV3B7JslgEgvPF4S3MxZkPlc9x1zf2y+CFsjHGmHGiIVuoh4vv16z?=
 =?us-ascii?Q?BacBE5HPp3yjg1rrPDpOOaYaz1dVVISTktN/uYa5yZaUm1ZB8YttEIp1XzDI?=
 =?us-ascii?Q?Vfn1KFT5bwbslJDWlaHsnAQq4k9O+saK54/rPz1s6vw8FkERCkMeR7iy9Mzb?=
 =?us-ascii?Q?XnckGuAXz1kumDtZguKCHJlpXWrgqAB6wOh7pFlBXNKbzu0ecOEhJRI6EzZ1?=
 =?us-ascii?Q?qrjk57qrHCyREDjngv9veFTV0e3EPkuiIIEtraPGfvYiylE7UDTpcDjGArfJ?=
 =?us-ascii?Q?5Sa10/xhodbHuXpjtf7tVTfMt4JXhjn0YbwA80ERw+BLLoDP6wRUhHLnlMpp?=
 =?us-ascii?Q?E9b81uEZOyymN4qGFroS8t+l7KcZDK4KYuZbCR12TYr1Ptu07mqdCcYhrHxi?=
 =?us-ascii?Q?rABa2mUOMyucqBy6HyJt9N7X+2pSTui797Lux5ehXyl8+tlLtFkKs2Qjo/vS?=
 =?us-ascii?Q?FZWRWjWxe4YfFeffR07fG23remIWSWAMjMQuWMmvQ73VvluuVaNOX8CetxpL?=
 =?us-ascii?Q?h97CLsgGl/hL9xxtZn7SrNG1sIl1kMxsOlP8rr5G5oHYbhhkapcjsakR/CS7?=
 =?us-ascii?Q?450yph+dksbMr7/2CxbQrSJwNhVtiWe10Yf8wg38r+gcYtCiIBK8BkxpfEki?=
 =?us-ascii?Q?gWomUKuU0py/aw5nQq+QAxWdfia845YW+nmDJKZMaY8m0n1xGoX/BFIuuoG0?=
 =?us-ascii?Q?2wYtAlXApNz2mbfFLGKxlqNevGw0nopDtJ+bd5QGdyulasJjtF6+f8aCED85?=
 =?us-ascii?Q?lHjAVkaqOwtO7mdIzorntIAwX6qrqxy3xKTb0NM0PSFN7Mi4Fyo8I9me/tzf?=
 =?us-ascii?Q?V7nQnBuTAuyc8v8/nfEkuwQbmqcGtrPDenaVtojFnWi02k3nD7aDp7/5tt5Y?=
 =?us-ascii?Q?VJ/dRnkOiEmaRdeNR1kA/d65roam4w1tNwaF9cSBfpoOTKV0oQq2OJcIUdID?=
 =?us-ascii?Q?ozVjhOeDY8pOclevkY4sdBGpN6Y/dpr8gKy1xpsFTfpeNA3EGs5YnbxFF8hi?=
 =?us-ascii?Q?V2498XqAsfygfjwJ4KN9D2989mB0tEFsIN/HEuHxpubCuLxIY6qs1cEPc71K?=
 =?us-ascii?Q?WpkLVNctLZd/3L/6C0lq8IuswZ7iYarGfqIX8WERyARjj1dZrxEtw7z0brxa?=
 =?us-ascii?Q?4yaKGILm6kVqqAbSoQ0TB2OZX38b0a0NMx+jMk46KnIVzNZuyYNYiW7rPV1a?=
 =?us-ascii?Q?HjPtvmHpjvACuVq4gflVr7s7EehbPeNcGZwHZ7/sBmK/y+Nj5bCSLeqbf7VM?=
 =?us-ascii?Q?SmEHFUISBX76NX7CJJ5EHXfw+je0wahxPDQ/48FZ4z7G4jW/GS7N3QqqWocW?=
 =?us-ascii?Q?sX+6SkowxNiec8FUlCUWlX4VxDi/vPl85WqClpwM6Qn9zD+4BJYsd6jOeUMl?=
 =?us-ascii?Q?nmpcxH4wXiG2/dTg4A36ANvRGj7QifSgtIPVy3F11IyDZtczjjEdWw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 14:18:59.9671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 343aea77-c311-4ccb-ecb6-08dd9ebbc191
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356
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

Users have reported that they have to reduce the level of undervolting
to acheive stability when dynamic workload profiles are enabled on
GC 10.3.x. Disable dynamic workload profiles if the user has enabled
OD.

Fixes: b9467983b774 ("drm/amdgpu: add dynamic workload profile switching for gfx10")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4262
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  8 ++++++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1db1e6ec0184f..c5646af055abc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2228,6 +2228,9 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
 	enum PP_SMC_POWER_PROFILE profile;
 	int r;
 
+	if (amdgpu_dpm_is_overdrive_enabled(adev))
+		return;
+
 	if (adev->gfx.num_gfx_rings)
 		profile = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 	else
@@ -2258,6 +2261,11 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
 
 void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
+
+	if (amdgpu_dpm_is_overdrive_enabled(adev))
+		return;
+
 	atomic_dec(&ring->adev->gfx.total_submission_cnt);
 
 	schedule_delayed_work(&ring->adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index b5477e02fe996..353f01c0d1000 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1701,6 +1701,28 @@ int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
 	}
 }
 
+int amdgpu_dpm_is_overdrive_enabled(struct amdgpu_device *adev)
+{
+	if (is_support_sw_smu(adev)) {
+		struct smu_context *smu = adev->powerplay.pp_handle;
+
+		return smu->od_enabled;
+	} else {
+		struct pp_hwmgr *hwmgr;
+
+		/*
+		 * dpm on some legacy asics don't carry od_enabled member
+		 * as its pp_handle is casted directly from adev.
+		 */
+		if (amdgpu_dpm_is_legacy_dpm(adev))
+			return false;
+
+		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
+
+		return hwmgr->od_enabled;
+	}
+}
+
 int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 			    const char *buf,
 			    size_t size)
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index b52162112fa68..9163962814ea8 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -563,6 +563,7 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
 				       void **addr,
 				       size_t *size);
 int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev);
+int amdgpu_dpm_is_overdrive_enabled(struct amdgpu_device *adev);
 int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 			    const char *buf,
 			    size_t size);
-- 
2.49.0

