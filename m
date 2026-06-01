Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C9ACD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0103B112DD8;
	Mon,  1 Jun 2026 05:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mJFnRBH6";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011061.outbound.protection.outlook.com
 [40.93.194.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A37112DD8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJluDNyVtTaZATlYXFacasuTvdJyQSd9o/44bYib8pkZPHsYhPUEWIUX8L378ZBv3L6LsSWImWm739pBN67z6nwZu2VCEVk+TazfX2ae0tM4ABk1X3Aj9HtmWIeKrTr0Zo+1Af5/ZaMPPrczjw6DAFsK2baJIIVJnX+fLtaOdMQPC952WOpSnJ4nI5aoj+LY0PBKMV5rwobA/EB9B6hb9FNskHIKbKyqpV7eCAFDgKAo7nao5elO3UgztmvVb/4kWOtHAMJ3yiqAhr831iaZln0DJgjYzBLxK3qXar4qLeJZaFWqdLcDMeAqi38C7EzJoR0flBUlfvvtOgjzimlYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5vENMM8jQ2hyPh2ptkeIShBtXYTuRUv94KIy5rPmBc=;
 b=HmecKfM5+m/BZwEfDKJHsnGt6e8d2O+ptiACfLTP0iNluhJEkXWCsi075JAkS8PrMuDzL2ZnsGO9UTOhkCmXCCTdXnjeF9K0W+Gv8lvaFm55YNPMafnalJNkOItZIfkdMNGsat0Cnv30NKg5AQJyt1mdSneFhqMpMGZJCY2FY9qwRLCsr0U2axgk5l3XwOG4DcGC6UqiYEN4t1N2/1hTyd82ERFxBgnX7TVH43jiQl0tVyXnaiWFMaMJjBRkDmotYL40aYzNGubXUH6jJoRpPZdBPdSvfSpYVmERYYSk/iY6nl+0oI7mrp6dQhu+K0jf/Zh/Jl8wFkzckfdVtspGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5vENMM8jQ2hyPh2ptkeIShBtXYTuRUv94KIy5rPmBc=;
 b=mJFnRBH6HeRUfFbOtwBpF/vjw5CNpI5WNxdZkzczvm+Lqoa9/6IZWH6Tf9HOWQR3z0lnOL0dszNJsJFspvYwxNme8OXYt1BpSYqwiqCiQgcPbWYB0xNosH7/ZQTs1bK00meSiWl6KPni2L3d/U7YBs7vAMHlRZCQrWqGyOIcNVs=
Received: from CY8P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::27)
 by LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 05:54:35 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:930:47:cafe::17) by CY8P220CA0027.outlook.office365.com
 (2603:10b6:930:47::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:54:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:33 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:54:27 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 32/42] drm/amdgpu: store whether to use MMIO or MES for
 reset
Date: Mon, 1 Jun 2026 13:49:18 +0800
Message-ID: <20260601055034.3700921-32-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 39db9f3f-bd5a-49e9-c9a3-08debfa241f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: SlC5eMN/Fkj6RgY8nuwXs4ZimM+Las5hlWKm9tW+NdrGxbZOfCK0ERNPYeeunwzUPqcyN6oW/0GQsSv5pCYckOqSkyy0110yFNR1GM2D/xEK9yD/zajxLrMWSRXf67qM2yn7geYPYfjGZ3+S2Hy6dS2zuy17HtBvvL/UhyuujhDVbBnonm0IAXj4Ueb7IxDi3nT6pPIGXNJS1Lxax0boHAbgM3nLh0YvyG90oFbgyMfPmgL1yo1xMI1pUVp11PKkJJCgcJcXKD/o2kL1xnQef1F+K1BeXOokyo6hXNBgrBgIZ/bwwpo5Z+BXngkoe2fePZQ/UsRGKbHM8+pLpH8Gso7xjKMI0o9kE39lIflbUZmXoaYa+svP8nSUc1MHgDLmJLN2Vt3JvRXuDzx9JWgBzoQPgk1YfBNRSi+gdKNRhwA0y5sDkjezh9qze+hsS+L2gGZ7CrLOBjAS7gV92NU6LODS2X4R+F8/QZjzrK+lMK08YCEnb5IadwhZiR1+lTvQ/ojCabw/E+xd+srcNrnYwzOL1JS0u0sFLeL6L/lnXbpWJ6RBsTngvU0R104qPlFSgM+5X1tlpBb8msSV0IkrWVU2l6ywCJHsxGUBeQaSZXgtYZIvGmqlsdGBxQKqCsapidHd8KAw8b1FyzoNIkb4w6SLkQ98kUgJ5ll71NtpfNjZfZh0D+2wHJGPA8wBUzwlPcEW+LndA/VbIn6CJxaOqor+RmuIIIDycqdkpaHRSuY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fJ+a4mqzuaF6RjRoY9YZDbmvRUKY8/AI71GpEUdWFVZQB8m351HPmd2xt3Z4OXjjzTu3LQtx93TiUONuGUyCREdovv205O7x7+1zR4uLDwaclleyC3jYJPjFLfJfs6ozvcoTEXE/aXJbx045fKbbWsodQDw7Wjw4c9DeEFqGDGRdT6xdUtMfhwTkAkTnXfKhVXr1Rtqqtil0H+/2r4XdIZrV948LqhmN6p69bzjxuBJuDoqzxZweD5ugvTPiFSmjwfP3l1ceQbdVx0jZu3AuOwbQwILVk/++va0HtpRRSO2LwXtEgf75E7PLTTqITSuKaLwurA2VCWpvypIyvrszkJjgsQQm+YDciW2Q6ag22TmJS82fRGwngOFnqLe9BnvZ61YNrYqNQcg/KO7JSHtR+0DNp78BTVCmYPi69VoyTRkya8gStkqXme9wmtjLUaRR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:54:34.4702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39db9f3f-bd5a-49e9-c9a3-08debfa241f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806
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

From: Alex Deucher <alexander.deucher@amd.com>

Separate settings for gfx (ME) and compute (MEC).
Use this rather than explicitly specifying it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 7 +++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 2a548b22725f..22fb90e229dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -116,6 +116,7 @@ struct amdgpu_mec {
 	u32 num_pipe_per_mec;
 	u32 num_queue_per_pipe;
 	void			*mqd_backup[AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES];
+	bool use_mmio_for_reset;
 };
 
 struct amdgpu_mec_bitmap {
@@ -401,6 +402,7 @@ struct amdgpu_me {
 	uint32_t			num_pipe_per_me;
 	uint32_t			num_queue_per_pipe;
 	void				*mqd_backup[AMDGPU_MAX_GFX_RINGS];
+	bool				use_mmio_for_reset;
 
 	/* These are the resources for which amdgpu takes ownership */
 	DECLARE_BITMAP(queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 455fe4b3c205..50d3990a00c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1905,6 +1905,9 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->gfx.me.use_mmio_for_reset = false;
+	adev->gfx.mec.use_mmio_for_reset = true;
+
 	return 0;
 }
 
@@ -6780,7 +6783,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool use_mmio = false;
+	bool use_mmio = adev->gfx.me.use_mmio_for_reset;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
@@ -6811,7 +6814,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool use_mmio = true;
+	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
 	int r = 0;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3c6f234cfb29..03b1fcc04655 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1603,6 +1603,9 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->gfx.me.use_mmio_for_reset = false;
+	adev->gfx.mec.use_mmio_for_reset = true;
+
 	return 0;
 }
 
@@ -5216,7 +5219,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool use_mmio = false;
+	bool use_mmio = adev->gfx.me.use_mmio_for_reset;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
@@ -5247,7 +5250,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool use_mmio = true;
+	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-- 
2.49.0

