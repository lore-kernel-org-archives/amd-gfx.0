Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590AFC3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 09:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8AF710E4A8;
	Wed,  7 Aug 2024 09:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="12KMTmZf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 604AE10E4A8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 09:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOX/yGY3wQ5c7k1TM4dzIpURsSLhyXKqvuogPjttVhGV8+DSfODp8MY4AMnv5hjb93CexaSchEIufxlxemJVslNA2AjmdDLpMWJFUBbbbvQG5z9TzYMM4N7M07NT96sWN90nzgCYLq3RovwxokZo0zBztStXbIzlc4MHfLgGR+s7+GuS2SksKWhuH38UzV6YUGgRIgDAug2xZ8egZhSXE/5cKhUjrG4yuVTY3FerL620PfOYWSpR19Yq6rkocZ07VC55hgR7dhs4Vm9q6sshovKboPR4IN0us1NpYfad42JmN3/uHm+8HCzmuFhWzhesmOC344W1kV7i43dkdrYXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/v1hpVs+pUuFKpCZCDoVhfen/WkWR6kHZwLdroKFNtQ=;
 b=KnQ45ji6SHapU99xkFi6pkZK6IgNYmIA3WoR83ETSuDjM7OwUQBnJQXelCBUAc3L1VXS4uGjccdRfPLfhMRVyQl01bSwj1ZINSWYW5UisrTkIpcK4D+GYXOgG90d0/AQQOl5zQO9jID98+gTKHtco96xa+NySekTmk3IKo7xYgpN0qPA7tx1r+QubYFijPtXd4V6cZFbb2ytqOWq7UAX1yPZT0qETxoGKgpA+a9X5EfJ3CjJNMse3ussxO70mqs1AANbjWBwFfORYHPsHwLh29POAebxEgAB3M5MNIsp+Khoy5tF24Tht3jTRvKZYTR1OTEW7XRo2ucEaFs4Fe/ZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v1hpVs+pUuFKpCZCDoVhfen/WkWR6kHZwLdroKFNtQ=;
 b=12KMTmZfUGZX4ABkJ17thXa4Hvtv06WGAnoz2KcVcl6a2cyo+e/IvPmxwBwnyX1qjxIINUdFwbOb/M4sl4xaDXQIaPtF4MPhyrom0QT/iQMjcx+OF/Kj2DCVLNMhYSx1DxrckfOhm+rnnRdtHjxLRsB4/mkNgQ15jQwFwzwG8I0=
Received: from DM6PR21CA0017.namprd21.prod.outlook.com (2603:10b6:5:174::27)
 by PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 09:39:12 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::b1) by DM6PR21CA0017.outlook.office365.com
 (2603:10b6:5:174::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.7 via Frontend
 Transport; Wed, 7 Aug 2024 09:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 09:39:12 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 04:39:10 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 2/8] drm/amdgpu/mes: add multiple mes ring instances support
Date: Wed, 7 Aug 2024 17:38:41 +0800
Message-ID: <20240807093847.2084710-3-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240807093847.2084710-1-Jack.Xiao@amd.com>
References: <20240807093847.2084710-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|PH7PR12MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d71858d-8068-4c96-185d-08dcb6c4cb8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oHM82RzTpO1XnRnr0GCJH9oF5Li4PYaeAKdB1K6rHt5Z/aRPcFf4EwFy44cH?=
 =?us-ascii?Q?0FdndclNk4Nr3XOYkyLXirsxuRdhgUl/d9a9F68cahpPyCERduDG1EAsAbeU?=
 =?us-ascii?Q?r28+a3YkA/xa1FkPMfOUopSXlTjXiEmAkgR/DcacSb98nviB596GMtPEfMhk?=
 =?us-ascii?Q?XByZupNy+fLv2oMDeyucaWz9gS1cr0qJXthHyfSx8ufRReca9WPEBobugRap?=
 =?us-ascii?Q?196EGYz9JVlT2TLGfY2JLR0luX2SPAofDBkhIAH5wyAOzcrMgN3uGd3OKCIE?=
 =?us-ascii?Q?LZaKZIsfD911DpBuL5SuCNomlnS0A7EeuzQPtVg8L/5DHG00Xs9l1dkm6vZ7?=
 =?us-ascii?Q?2uBYl2GcLEzR6tz2LEZ6S1BCRqP817V9OiXMVuHQ9oSXeNqyWLqGV3wmlzHB?=
 =?us-ascii?Q?jIiT+Ya25BsXJZz2RfMFcWDKeIXTSYGnBzXhKYzFSiMKnYo0uGYEWlPml9UX?=
 =?us-ascii?Q?GC9vTKwyg1c7wC0EKpEMHUJm81ih06N3/wGvPFNfH/vKB3/T2l+ygS2bI7go?=
 =?us-ascii?Q?rjg9HCkiAjYqj5QrRsbjmAmE4ElKh7jgz9rp6QsxY5TKm/JCPgBYaHeVFkgY?=
 =?us-ascii?Q?+qWedQt766gChRmaJFxMnIASVxMk2fy9grbsErRrAqRxfZ5l08V3Vl3FPM/V?=
 =?us-ascii?Q?NXrfOc0i+AtV3e3MxTUInKAOWI0dvsc/Cxtw+kDMB1ioD/XkiF3NVyfaPEWA?=
 =?us-ascii?Q?K8qEBJPDOtX8Ren0afVFfNL6yJmWsUCJoALwE240Jb9ZPjt5iaXsOUwb9OHy?=
 =?us-ascii?Q?q0SMWOCEGflSH4JzV3Nl9+Ma0bo7v5UyF+RU5CVRQCEMnMLqE6zIwhPwNiN1?=
 =?us-ascii?Q?mYCR6UL7wa7/HPZtaSHTpPcdDK0lOW7zKbiGAcIn4fenRxILNShFm7YlhkfD?=
 =?us-ascii?Q?pYERv5RCSjRK+r94bRMaPCGzK2E30oIwmrCXByYOU74MVPpuxwS62tt6kggr?=
 =?us-ascii?Q?rQbeq7/ND5bThqD9xEEGNlhTyCVL/hkb+5fjvrmJel6nmqvJGrX1bsK2JiKz?=
 =?us-ascii?Q?E8Si65mptBUFWwTaXrIEQhovyZaw8upIS4C0NlaNHBqV7dl3prtRW6ymwjhm?=
 =?us-ascii?Q?2uz7QUQzrlZEm8O+EHiC58scCqXJkKKOzqNAAkiaQVJpLx9I1MLVvNDcCrHO?=
 =?us-ascii?Q?iMH1bzQAQMR4fpQrrmHwmz/qXwc1gJYqgy9efBaomLpDUNsr/oS/3FIcFgWP?=
 =?us-ascii?Q?Ob2+fc7N/HmHGbp166iOaZAFL1S5w2UH6oObJtm2e5oxwgiSGT7q9sYd2xAB?=
 =?us-ascii?Q?j6vM8SVtvI+igxLcWbVp4crWw58aUO0vnNQ67zcN33X0jDwlXLPvsZZl8Mqp?=
 =?us-ascii?Q?VszsSh2UcyU4YzMkfCEhwKUDHJRKqJs/o24zbxHQyOkC94gwktbhxPvtyOiY?=
 =?us-ascii?Q?NJmrd+1H3KhJAh1yOOoqVNcCsjALoq4uoA9vbILc5Zu5GvwzfdSTTc64+DLf?=
 =?us-ascii?Q?jKuqcekwTMZTuAkcO5rnQeBf7EkNGFK7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:39:12.3631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d71858d-8068-4c96-185d-08dcb6c4cb8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871
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

Add multiple mes ring instances in mes structure to support
multiple mes pipes.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  |  4 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h  |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 34 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 34 ++++++++++++------------
 9 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 82452606ae6c..f165b9d49e29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -995,7 +995,7 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
-	if (adev->mes.ring.sched.ready)
+	if (adev->mes.ring[0].sched.ready)
 		return amdgpu_mes_rreg(adev, reg);
 
 	BUG_ON(!ring->funcs->emit_rreg);
@@ -1065,7 +1065,7 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
-	if (adev->mes.ring.sched.ready) {
+	if (adev->mes.ring[0].sched.ready) {
 		amdgpu_mes_wreg(adev, reg, v);
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d1823af6ccbe..c32dbf223996 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -589,7 +589,8 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 		ring = adev->rings[i];
 		vmhub = ring->vm_hub;
 
-		if (ring == &adev->mes.ring ||
+		if (ring == &adev->mes.ring[0] ||
+		    ring == &adev->mes.ring[1] ||
 		    ring == &adev->umsch_mm.ring)
 			continue;
 
@@ -762,7 +763,7 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 	unsigned long flags;
 	uint32_t seq;
 
-	if (adev->mes.ring.sched.ready) {
+	if (adev->mes.ring[0].sched.ready) {
 		amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
 					      ref, mask);
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index d7d34fedb383..f3437a2d2d2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -135,9 +135,11 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	idr_init(&adev->mes.queue_id_idr);
 	ida_init(&adev->mes.doorbell_ida);
 	spin_lock_init(&adev->mes.queue_id_lock);
-	spin_lock_init(&adev->mes.ring_lock);
 	mutex_init(&adev->mes.mutex_hidden);
 
+	for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++)
+		spin_lock_init(&adev->mes.ring_lock[i]);
+
 	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
 	adev->mes.vmid_mask_mmhub = 0xffffff00;
 	adev->mes.vmid_mask_gfxhub = 0xffffff00;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e11051271f71..e7915a24dfdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -83,8 +83,8 @@ struct amdgpu_mes {
 	uint64_t                        default_process_quantum;
 	uint64_t                        default_gang_quantum;
 
-	struct amdgpu_ring              ring;
-	spinlock_t                      ring_lock;
+	struct amdgpu_ring              ring[AMDGPU_MAX_MES_PIPES];
+	spinlock_t                      ring_lock[AMDGPU_MAX_MES_PIPES];
 
 	const struct firmware           *fw[AMDGPU_MAX_MES_PIPES];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 111c380f929b..b287a82e6177 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -858,7 +858,7 @@ void amdgpu_virt_post_reset(struct amdgpu_device *adev)
 		adev->gfx.is_poweron = false;
 	}
 
-	adev->mes.ring.sched.ready = false;
+	adev->mes.ring[0].sched.ready = false;
 }
 
 bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_id)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index a8cab1eae314..63ad403eb5fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -230,7 +230,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
 	 */
-	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
+	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring[0].sched.ready) &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, GET_INST(GC, 0));
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 542225eb13b5..8a7de2e2e7f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -299,7 +299,7 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
 	 */
-	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
+	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring[0].sched.ready) &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 68c74adf79f1..3d103a5ca184 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -162,7 +162,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
 	signed long timeout = 3000000; /* 3000 ms */
 	struct amdgpu_device *adev = mes->adev;
-	struct amdgpu_ring *ring = &mes->ring;
+	struct amdgpu_ring *ring = &mes->ring[0];
 	struct MES_API_STATUS *api_status;
 	union MESAPI__MISC *x_pkt = pkt;
 	const char *op_str, *misc_op_str;
@@ -191,7 +191,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	status_ptr = (u64 *)&adev->wb.wb[status_offset];
 	*status_ptr = 0;
 
-	spin_lock_irqsave(&mes->ring_lock, flags);
+	spin_lock_irqsave(&mes->ring_lock[0], flags);
 	r = amdgpu_ring_alloc(ring, (size + sizeof(mes_status_pkt)) / 4);
 	if (r)
 		goto error_unlock_free;
@@ -221,7 +221,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 				   sizeof(mes_status_pkt) / 4);
 
 	amdgpu_ring_commit(ring);
-	spin_unlock_irqrestore(&mes->ring_lock, flags);
+	spin_unlock_irqrestore(&mes->ring_lock[0], flags);
 
 	op_str = mes_v11_0_get_op_string(x_pkt);
 	misc_op_str = mes_v11_0_get_misc_op_string(x_pkt);
@@ -263,7 +263,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	amdgpu_ring_undo(ring);
 
 error_unlock_free:
-	spin_unlock_irqrestore(&mes->ring_lock, flags);
+	spin_unlock_irqrestore(&mes->ring_lock[0], flags);
 
 error_wb_free:
 	amdgpu_device_wb_free(adev, status_offset);
@@ -1025,7 +1025,7 @@ static int mes_v11_0_kiq_enable_queue(struct amdgpu_device *adev)
 		return r;
 	}
 
-	kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring);
+	kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring[0]);
 
 	return amdgpu_ring_test_helper(kiq_ring);
 }
@@ -1039,7 +1039,7 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 	if (pipe == AMDGPU_MES_KIQ_PIPE)
 		ring = &adev->gfx.kiq[0].ring;
 	else if (pipe == AMDGPU_MES_SCHED_PIPE)
-		ring = &adev->mes.ring;
+		ring = &adev->mes.ring[0];
 	else
 		BUG();
 
@@ -1081,7 +1081,7 @@ static int mes_v11_0_ring_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
 
-	ring = &adev->mes.ring;
+	ring = &adev->mes.ring[0];
 
 	ring->funcs = &mes_v11_0_ring_funcs;
 
@@ -1134,7 +1134,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 	if (pipe == AMDGPU_MES_KIQ_PIPE)
 		ring = &adev->gfx.kiq[0].ring;
 	else if (pipe == AMDGPU_MES_SCHED_PIPE)
-		ring = &adev->mes.ring;
+		ring = &adev->mes.ring[0];
 	else
 		BUG();
 
@@ -1224,12 +1224,12 @@ static int mes_v11_0_sw_fini(void *handle)
 			      &adev->gfx.kiq[0].ring.mqd_gpu_addr,
 			      &adev->gfx.kiq[0].ring.mqd_ptr);
 
-	amdgpu_bo_free_kernel(&adev->mes.ring.mqd_obj,
-			      &adev->mes.ring.mqd_gpu_addr,
-			      &adev->mes.ring.mqd_ptr);
+	amdgpu_bo_free_kernel(&adev->mes.ring[0].mqd_obj,
+			      &adev->mes.ring[0].mqd_gpu_addr,
+			      &adev->mes.ring[0].mqd_ptr);
 
 	amdgpu_ring_fini(&adev->gfx.kiq[0].ring);
-	amdgpu_ring_fini(&adev->mes.ring);
+	amdgpu_ring_fini(&adev->mes.ring[0]);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 		mes_v11_0_free_ucode_buffers(adev, AMDGPU_MES_KIQ_PIPE);
@@ -1340,9 +1340,9 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
 
 static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev)
 {
-	if (adev->mes.ring.sched.ready) {
-		mes_v11_0_kiq_dequeue(&adev->mes.ring);
-		adev->mes.ring.sched.ready = false;
+	if (adev->mes.ring[0].sched.ready) {
+		mes_v11_0_kiq_dequeue(&adev->mes.ring[0]);
+		adev->mes.ring[0].sched.ready = false;
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -1360,7 +1360,7 @@ static int mes_v11_0_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->mes.ring.sched.ready)
+	if (adev->mes.ring[0].sched.ready)
 		goto out;
 
 	if (!adev->enable_mes_kiq) {
@@ -1405,7 +1405,7 @@ static int mes_v11_0_hw_init(void *handle)
 	 * with MES enabled.
 	 */
 	adev->gfx.kiq[0].ring.sched.ready = false;
-	adev->mes.ring.sched.ready = true;
+	adev->mes.ring[0].sched.ready = true;
 
 	return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 48e01206bcc4..65f2d33978db 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -148,7 +148,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
 	signed long timeout = 3000000; /* 3000 ms */
 	struct amdgpu_device *adev = mes->adev;
-	struct amdgpu_ring *ring = &mes->ring;
+	struct amdgpu_ring *ring = &mes->ring[0];
 	struct MES_API_STATUS *api_status;
 	union MESAPI__MISC *x_pkt = pkt;
 	const char *op_str, *misc_op_str;
@@ -177,7 +177,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	status_ptr = (u64 *)&adev->wb.wb[status_offset];
 	*status_ptr = 0;
 
-	spin_lock_irqsave(&mes->ring_lock, flags);
+	spin_lock_irqsave(&mes->ring_lock[0], flags);
 	r = amdgpu_ring_alloc(ring, (size + sizeof(mes_status_pkt)) / 4);
 	if (r)
 		goto error_unlock_free;
@@ -207,7 +207,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 				   sizeof(mes_status_pkt) / 4);
 
 	amdgpu_ring_commit(ring);
-	spin_unlock_irqrestore(&mes->ring_lock, flags);
+	spin_unlock_irqrestore(&mes->ring_lock[0], flags);
 
 	op_str = mes_v12_0_get_op_string(x_pkt);
 	misc_op_str = mes_v12_0_get_misc_op_string(x_pkt);
@@ -249,7 +249,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	amdgpu_ring_undo(ring);
 
 error_unlock_free:
-	spin_unlock_irqrestore(&mes->ring_lock, flags);
+	spin_unlock_irqrestore(&mes->ring_lock[0], flags);
 
 error_wb_free:
 	amdgpu_device_wb_free(adev, status_offset);
@@ -1093,7 +1093,7 @@ static int mes_v12_0_kiq_enable_queue(struct amdgpu_device *adev)
 		return r;
 	}
 
-	kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring);
+	kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring[0]);
 
 	r = amdgpu_ring_test_ring(kiq_ring);
 	if (r) {
@@ -1112,7 +1112,7 @@ static int mes_v12_0_queue_init(struct amdgpu_device *adev,
 	if (pipe == AMDGPU_MES_KIQ_PIPE)
 		ring = &adev->gfx.kiq[0].ring;
 	else if (pipe == AMDGPU_MES_SCHED_PIPE)
-		ring = &adev->mes.ring;
+		ring = &adev->mes.ring[0];
 	else
 		BUG();
 
@@ -1158,7 +1158,7 @@ static int mes_v12_0_ring_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
 
-	ring = &adev->mes.ring;
+	ring = &adev->mes.ring[0];
 
 	ring->funcs = &mes_v12_0_ring_funcs;
 
@@ -1211,7 +1211,7 @@ static int mes_v12_0_mqd_sw_init(struct amdgpu_device *adev,
 	if (pipe == AMDGPU_MES_KIQ_PIPE)
 		ring = &adev->gfx.kiq[0].ring;
 	else if (pipe == AMDGPU_MES_SCHED_PIPE)
-		ring = &adev->mes.ring;
+		ring = &adev->mes.ring[0];
 	else
 		BUG();
 
@@ -1298,12 +1298,12 @@ static int mes_v12_0_sw_fini(void *handle)
 			      &adev->gfx.kiq[0].ring.mqd_gpu_addr,
 			      &adev->gfx.kiq[0].ring.mqd_ptr);
 
-	amdgpu_bo_free_kernel(&adev->mes.ring.mqd_obj,
-			      &adev->mes.ring.mqd_gpu_addr,
-			      &adev->mes.ring.mqd_ptr);
+	amdgpu_bo_free_kernel(&adev->mes.ring[0].mqd_obj,
+			      &adev->mes.ring[0].mqd_gpu_addr,
+			      &adev->mes.ring[0].mqd_ptr);
 
 	amdgpu_ring_fini(&adev->gfx.kiq[0].ring);
-	amdgpu_ring_fini(&adev->mes.ring);
+	amdgpu_ring_fini(&adev->mes.ring[0]);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 		mes_v12_0_free_ucode_buffers(adev, AMDGPU_MES_KIQ_PIPE);
@@ -1347,7 +1347,7 @@ static void mes_v12_0_kiq_dequeue_sched(struct amdgpu_device *adev)
 	soc21_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 
-	adev->mes.ring.sched.ready = false;
+	adev->mes.ring[0].sched.ready = false;
 }
 
 static void mes_v12_0_kiq_setting(struct amdgpu_ring *ring)
@@ -1411,9 +1411,9 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 
 static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev)
 {
-	if (adev->mes.ring.sched.ready) {
+	if (adev->mes.ring[0].sched.ready) {
 		mes_v12_0_kiq_dequeue_sched(adev);
-		adev->mes.ring.sched.ready = false;
+		adev->mes.ring[0].sched.ready = false;
 	}
 
 	mes_v12_0_enable(adev, false);
@@ -1426,7 +1426,7 @@ static int mes_v12_0_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->mes.ring.sched.ready)
+	if (adev->mes.ring[0].sched.ready)
 		goto out;
 
 	if (!adev->enable_mes_kiq || adev->enable_uni_mes) {
@@ -1478,7 +1478,7 @@ static int mes_v12_0_hw_init(void *handle)
 	 * with MES enabled.
 	 */
 	adev->gfx.kiq[0].ring.sched.ready = false;
-	adev->mes.ring.sched.ready = true;
+	adev->mes.ring[0].sched.ready = true;
 
 	return 0;
 
-- 
2.41.0

