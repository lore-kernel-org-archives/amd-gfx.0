Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9653C49EA1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB45110E862;
	Thu, 25 Jul 2024 15:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z7tPrlPK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A1D10E867
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mdt81OHQO+idAnXGO1VGCAzb0psS68aGieArXVkre6Dz8k4B8KMJB1I1Lcar/Lgu8+YYOz5azfeB4NvPujN5/45eAGdzUH4zk8R2VP4Qp2kmNcaF3x5fQkLRQd0PKhlp9dtRhswd3KtzMdajdDbcZmCX6nc/IhSyZsxD9zDWPej2lULyyEbTiX/3nJUVs08xgnTjAvNFgKbubwxPTNuKB2If2aE+yJ0IixCHQMk5tLL2svA0v9nFTa+HLFjwb5wXtWSCVaSbmArQk3hLpgKEuP1TBDCjTwHqKqcPUsaRflwZlhkC00WC+rHjkTlLHAi4cFzZzuAgRYeyDLrznHkJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0Il39+96/Vd7wjVQfAgicypLG/SvS+eCwDjXkSLNOQ=;
 b=s0yiO3jhFzZconwA4iHCgay0PYNeTv22nSWFT5+abmyTrMp8qu8JvdLp6fA9oj2Q6SGbmcjWj+Yt2610DsVFA0QWpx1DlNESMPfkzdU33smBwiNuluxBE1SPxKklGyfIN6q0MSk7UTm8mb1t070D4lDpy1EsgqUMaIjvKeJ3erDnK3KWQ27JQvCnkzB8LgqXLG9SqCXXbQvrNr/nCULedZDM8ydeAVNsvZW8zuc8BZr59ailRZEgd1RyqeGe8QsrsWeJ3RxyZibgQNHYXFO2OCHPQafaaW/u3/PStl0u08f6hhfDod2HobyyNLVJ9l73glsqAStjGjieRsnrNQQnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0Il39+96/Vd7wjVQfAgicypLG/SvS+eCwDjXkSLNOQ=;
 b=z7tPrlPKLMYrrDBcWYwbV30j5FWwc9syy2OOJLxzYstvKBv3J0Arij3jWDm1JbmrpkWTEnOgVH6Smj/tJUAclAGnQ+tcHwh4o9laOI5rCu+60Jsbe3vhhopgXxLaEX4Dk5tFxmWu3x0owW80kSfK937gw69YA35+F9F7oAQeebA=
Received: from CYZPR10CA0016.namprd10.prod.outlook.com (2603:10b6:930:8a::19)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 15:01:28 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::56) by CYZPR10CA0016.outlook.office365.com
 (2603:10b6:930:8a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 34/53] drm/amdgpu/gfx11: add a mutex for the gfx semaphore
Date: Thu, 25 Jul 2024 11:00:36 -0400
Message-ID: <20240725150055.1991893-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 4725683a-566d-46d0-2ae0-08dcacbaa92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tX9rvqQ9f6EmFtKAjFSo5iLxzIPcbqgZXtMszE/fITiUTk3WaVhk3Tka1U8u?=
 =?us-ascii?Q?L7y/JOZusBboujU37wtJ9UfESllQ45+ZagzwjSLItMqRn4p83rCyHmZyM0u9?=
 =?us-ascii?Q?u0FN/stf3i5f/Rt4O7934Tm0Iaja49O9jIqmNr1phuj17mqrbfu9xFsjj1XF?=
 =?us-ascii?Q?GfVK48a+A1eo9KJHIPXGJPI/bhx4E1tIs2BdgcGTwbcuSplUR9ZOQ4rZk3D4?=
 =?us-ascii?Q?bl2SFeB5lahlKX8CF+W5ylQNFwrp4+OpGnk19d7uUbfdgHHwQnrEKZuK52qE?=
 =?us-ascii?Q?KPnlV/+rqyQ7kKisapUlu/SHnhNlYzqMw4mM8EO8nkz6M9yv/oJLm5fUtBvA?=
 =?us-ascii?Q?kKe6Fz5KbntD1c8ecmg9xSPi+RXvfsMGKvt8CeanVP1futjomkpE8B0n/8mW?=
 =?us-ascii?Q?HZQ25gdo9sZQJsrBgPiM0Sq0pFQPb+uDxUWcy70+nH53StSZlHTorMHCUX0n?=
 =?us-ascii?Q?/nQL4oQpJMHeGBB9u1B/1eKKN8AEL+wAG1VDQNdL8KSqFXUvs3sbBw4J3A9L?=
 =?us-ascii?Q?A5HUqTDIPL9zTXvZXLcDZ8/+DcRuhNzoocqWIMXujP3h6fIAYqzAV8lsl1kp?=
 =?us-ascii?Q?ftwlAXqMVuW98j/JkKsVyp5tLGpW2sZkM+hms9lguilb/BIUHvdsXdISm19j?=
 =?us-ascii?Q?oGUYXpEldLGuir+IMRJgiViANFjMaQsCU1pziKVF/wdy9Sm1fP1H8eiYGS3P?=
 =?us-ascii?Q?ejTz0mDD+/QZg9nMZkZVUZTGKGehUA7nRmnrpi3WIXEK6pK8ZYFYcJqEymg5?=
 =?us-ascii?Q?5xjbLm7ba8PpVGLFcw3711vSGdcK3/o5ZJq/lVL3VvrlkWsexSqBKgOSeNci?=
 =?us-ascii?Q?wPDUvoVnh4nkFGv6ya/zN7vYSEZNwwLaQ2bkq5ynjSN3FCb3DayFJ2laHiyI?=
 =?us-ascii?Q?kIMuDemBD8U5diuxXI+0tpPwVBCeD0NVpnTPNx+tvciwCr0WlTybdB6uYp6l?=
 =?us-ascii?Q?g4vvzri/PRYTGvjYgWgiKm7AT3o3bZjWvNSb4oqTReYlcDQZDGdefDTdEqfo?=
 =?us-ascii?Q?HA9ggAGjuhX1UNK8Cx+EwLtCoz3IPYOOPbCIoKLgiAXzhsrigmDGu+/m/bW3?=
 =?us-ascii?Q?yE3W4U2G+ukgPxMjAQUL/h+PTJhmIyNKeRLEyVOp1sX11aKKwJ8DrxFvQOc+?=
 =?us-ascii?Q?mb/uziHfo5RCirvA7re6JMG/ni+EUsOVyZ20a0KEh7N0YKOKnMZwcUNYsnVI?=
 =?us-ascii?Q?InAOzUP6XIaqN1PdMMqI4S/WAUuIKw4q4pjIbuClhXY+dvaPYU2JETZkyuTL?=
 =?us-ascii?Q?/N1U20izFNf2jIAolwhA6WfzL3JElM/7IJQJUE0Pp1nrNTc/uPFIGE34nSyW?=
 =?us-ascii?Q?hl47/OZWgfN3rDjWP8kJshYOrQHc0tZOb0wXPxy7CTAL2iwwF2BXQz20bSGm?=
 =?us-ascii?Q?/nxTy//g8WrpW1SGRYFc5xfPXABSOy5xJ4nblj04c7ST58teYBQh0aME8gcD?=
 =?us-ascii?Q?anqIfrIthF78wxDADZ158ieCw+n5j1d1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:28.0590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4725683a-566d-46d0-2ae0-08dcacbaa92b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465
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

This will be used in more places in the future so
add a mutex.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 10 +++++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 730dae77570c..71595ece4c13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4059,6 +4059,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->notifier_lock);
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 	mutex_init(&adev->benchmark_mutex);
+	mutex_init(&adev->gfx.reset_sem_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6fe77e483bb7..17b945b545b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -444,6 +444,8 @@ struct amdgpu_gfx {
 	uint32_t			*ip_dump_core;
 	uint32_t			*ip_dump_compute_queues;
 	uint32_t			*ip_dump_gfx_queues;
+
+	struct mutex			reset_sem_mutex;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fc9659daf3da..6d8f2124b30d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4725,10 +4725,12 @@ static int gfx_v11_0_wait_for_idle(void *handle)
 }
 
 static int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
-					     int req)
+					     bool req)
 {
 	u32 i, tmp, val;
 
+	if (req)
+		mutex_lock(&adev->gfx.reset_sem_mutex);
 	for (i = 0; i < adev->usec_timeout; i++) {
 		/* Request with MeId=2, PipeId=0 */
 		tmp = REG_SET_FIELD(0, CP_GFX_INDEX_MUTEX, REQUEST, req);
@@ -4749,6 +4751,8 @@ static int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
 		}
 		udelay(1);
 	}
+	if (!req)
+		mutex_unlock(&adev->gfx.reset_sem_mutex);
 
 	if (i >= adev->usec_timeout)
 		return -EINVAL;
@@ -4796,7 +4800,7 @@ static int gfx_v11_0_soft_reset(void *handle)
 	mutex_unlock(&adev->srbm_mutex);
 
 	/* Try to acquire the gfx mutex before access to CP_VMID_RESET */
-	r = gfx_v11_0_request_gfx_index_mutex(adev, 1);
+	r = gfx_v11_0_request_gfx_index_mutex(adev, true);
 	if (r) {
 		DRM_ERROR("Failed to acquire the gfx mutex during soft reset\n");
 		return r;
@@ -4811,7 +4815,7 @@ static int gfx_v11_0_soft_reset(void *handle)
 	RREG32_SOC15(GC, 0, regCP_VMID_RESET);
 
 	/* release the gfx mutex */
-	r = gfx_v11_0_request_gfx_index_mutex(adev, 0);
+	r = gfx_v11_0_request_gfx_index_mutex(adev, false);
 	if (r) {
 		DRM_ERROR("Failed to release the gfx mutex during soft reset\n");
 		return r;
-- 
2.45.2

