Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F05CAC5B8
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Sep 2025 09:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DF3310E2A2;
	Tue, 30 Sep 2025 09:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RjIAXB1t";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011001.outbound.protection.outlook.com
 [40.93.194.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B79710E2A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 09:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9lOATrNV+lmM82P+6DstsF4m79S/EimgJgoISbGO9pzMBRmXNsZNlu9LNv6W5Mjet8UBp/UlUrsHyeNwjb3qSK5r/sXk+sf8L64teOSE4FCiWUNXpJ33v10xFAEmuydVLFd7VKZKEoSGBP8c3ajqVZr3C6gDf99ZAk02djFqdtYdtLri8+wk/TgM935eZ9gJTes/Y8inOA8/6JYbv+Mihxoge2ZiQivKFqnsYHOAmbC/iQnEXDs6uw1J34AzEDxcBH1iq04AxLvPWBY5F+dnvWc3S38Umh6LQoC1+Q7hXHmrue59QN7f5M9vdQadnbUajVkCYR/uzu8210CFhN7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV/g+sdWAv3mL7wMAblIbHNEebT1So/CDiCoLk/nyOY=;
 b=VuIfnMYoIECoE408TXup/xHqx2TGhCddVeC34rYUQBaIae5XF0oYX55oCunlWPp0bD0QGC37pkt+hZy/9aQhUB/3/Axp1agwtoE2HxAnAAEjURMlgyts89S3Tw7ElE9UqIp8Hh3x/IFS8tDa4gHbDJo5sCSd/uMiLJulCj45WBQH0bmqsDO40vOo8gyQKELMXI1mWaBFlPSb1HaApl8CK6fNDLIs6kWtIfj2U+3MjMElrX6siwTrcY++ani5/deUAFCJ/Eo4Mxh+9f7tlSeY/D48T9AZdL0YLmsm0A0gQ1b/OtMvWeMVrZJzRxpjTN9R8qoar/Qe/H4/pgpqcZZwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XV/g+sdWAv3mL7wMAblIbHNEebT1So/CDiCoLk/nyOY=;
 b=RjIAXB1tgMCoOVveOiww+VO8J448bgwoGAvEKyIWxLAwEiTDIgOiiJJ7vWTubSp2j+tfsTdaQWZbNBBLb2uUx6BPj1GLqgqXgIqUaGChPrf3rN9m93pkSLj0eTESOERMN4VgBmsCYpZZaTfX5NpQlnJ6NSyEUx+LfZI371Yxw7Y=
Received: from SA1P222CA0164.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::29)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 30 Sep
 2025 09:36:18 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::be) by SA1P222CA0164.outlook.office365.com
 (2603:10b6:806:3c3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Tue,
 30 Sep 2025 09:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 09:36:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 30 Sep
 2025 02:36:17 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Sep
 2025 04:36:17 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 30 Sep 2025 02:36:16 -0700
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <HaiJun.Chang@amd.com>, Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: use GPU_HDP_FLUSH for sriov
Date: Tue, 30 Sep 2025 17:35:53 +0800
Message-ID: <20250930093553.3726252-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: aebdebda-d392-4ee8-77cf-08de0004cece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9w+EubYl3kZsUTfgWpMEWPGpQ7BZA3BocSO0e9MHDFCI8XjJW4TtvqX2jlKa?=
 =?us-ascii?Q?I5XsXK5YZ+3R+bgZnoxmTn8Obs9RnoT9KhCvPZ8e+GUv+/+oapHBJDmoV9o4?=
 =?us-ascii?Q?kn5KMGbnzjeJHIz7V8tMFOgrZNOdkzPc1xAm102PrOR7f8KWX5opfUEpjeUV?=
 =?us-ascii?Q?v28Iz1KodpHEG+oX73sRV803ADKctIR2A5SBRiApXa/LpcwdTqmF7qqqY848?=
 =?us-ascii?Q?vinF6UrAMM4zdeiW1oYimHJOPPQQf2VWsXcOuNZlHFrR4DTb6MvEeNgoeksr?=
 =?us-ascii?Q?mtZ6fU2Mt8KQKMARJI8xdk8xD0O00ocNGoy+U3kZSOnBt6PIx0RzBp9veTYx?=
 =?us-ascii?Q?1jTc2cYdVVoTyZ3DM3c+50LaQH7QVbheXvSLtfj9LIVK5TaLeuY+RGwcfwzV?=
 =?us-ascii?Q?e1QcMOE0LV7rSomTS9deUBp2OB4oiIxY5YJxebX924qWBJc/YmxcucQmzYxI?=
 =?us-ascii?Q?/wBvMJS7ll2oILXyBaSNyl9tPUHLEFYOfsARfGvHvZwlrP+Wv1zlc4R0QTyC?=
 =?us-ascii?Q?6xwXpHuA2A8mHusG5rBdIorixQVwdZCskH1O0Zw5dlzqAjAsaEkNP/KPHrlN?=
 =?us-ascii?Q?XK5n0lkfKoL7/kJ2CMpOwLjSh7cR+IuvTFqLSisDgCpUHkk/BEUBpNJDArES?=
 =?us-ascii?Q?4k12EvHATvDA+t7y0uXddpEHxrdpiFJK8Es8dxzv/aEFtjqaAMj1/Xafea6G?=
 =?us-ascii?Q?Nhxu7pg34vhmmQK/guV0WOGxcZMUS1jLktgVT3fCCoV5J4B0CMPjTj4CQ+C6?=
 =?us-ascii?Q?w/C+gCeLJX8GnppymzzFJSIABNwxPM6bfA/pOIwFtRj2EKMQiTQd1oL/CYzw?=
 =?us-ascii?Q?KRT8qZFc2IPaqQW3mS8MVTsHHS+1hDZU3xOk6dVtRWCBHtArlKK1vTXVKw5z?=
 =?us-ascii?Q?u9GIVWisPVnaCL05w+nfiKag6rUdyqDWfrr/CEaSAOewF5hUJkY8Wp6ikUCY?=
 =?us-ascii?Q?ZUfDNjq4Vr6jYDRpY60/8XtWbsf8waA5ATanMdbJSOgWcZyIl4d6FLrGQBo8?=
 =?us-ascii?Q?I3soFjK857yzsHN8QxZEivJ6CVDiRsHJ1hLrFAZordyPosAr+l89x2fIO/Rh?=
 =?us-ascii?Q?y8woXNbjrprpfkcwEZp+h6UypmKTr/rLmBrPi6zo+9knvop211GAKxhbt9YS?=
 =?us-ascii?Q?z86rcWBMKhsPb7C+WAvDkAXyAsyvX2BmVAwVq7HQBs2aqdqLeYYE7XQYOntr?=
 =?us-ascii?Q?8M1fMKQuJ2mouVZACx58GphPfpmb9GunXOaYaxbjbFXK1oZNBu5iFoNzcRMe?=
 =?us-ascii?Q?bVuo2ny48mBV5cNbVdm0fPfphYRrid5h7Cs+2jeiu6yRcytyIsQUeHkU7mEC?=
 =?us-ascii?Q?9L5hLWc4gPPmYhlxwyG2ZBKiUocryG6K0DOf1IeW5ezKWUg99yatQYEAG9+V?=
 =?us-ascii?Q?/dOJyLeHvscrGIqkeFzZto8T1s1X5bhwPMTnvzNTCn94nirV0PuwXl6hUbt4?=
 =?us-ascii?Q?nl+ECubmt6AabRVPeVv4gDgY/Bv2UJ+FMN1qpTBt64e0L8wA+apyGHIBD/Fx?=
 =?us-ascii?Q?TM6MK31eIGUPaSqdbLnc7H0kX76CncY/bSj+y+Q08mzK06cUH8ZtEHFDJF50?=
 =?us-ascii?Q?ZO14y/JBrOXm6Xi5L7s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 09:36:18.2045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aebdebda-d392-4ee8-77cf-08de0004cece
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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

Currently SRIOV runtime will use kiq to write HDP_MEM_FLUSH_CNTL for
hdp flush. This register need to be write from CPU for nbif to aware,
otherwise it will not work.
Add kiq ring callback to emit GPU_HDP_FLUSH, and use as generic hdp
flush option.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 61 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 12 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  1 +
 drivers/gpu/drm/amd/amdgpu/vi.c         |  8 ++--
 10 files changed, 80 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7f02e36ccc1e..9cb13424ab8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1194,6 +1194,67 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 	dev_err(adev->dev, "failed to write reg:%x\n", reg);
 }
 
+void amdgpu_kiq_hdp_flush(struct amdgpu_device *adev, uint32_t xcc_id)
+{
+	signed long r, cnt = 0;
+	unsigned long flags;
+	uint32_t seq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
+	struct amdgpu_ring *ring = &kiq->ring;
+
+	BUG_ON(!ring->funcs->emit_hdp_flush);
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_ring_alloc(ring, 32);
+	if (r)
+		goto failed_unlock;
+
+	amdgpu_ring_emit_hdp_flush(ring);
+	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+	if (r)
+		goto failed_undo;
+
+	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+	/* don't wait anymore for gpu reset case because this way may
+	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
+	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
+	 * never return if we keep waiting in virt_kiq_rreg, which cause
+	 * gpu_recover() hang there.
+	 *
+	 * also don't wait anymore for IRQ context
+	 * */
+	if (r < 1 && (amdgpu_in_reset(adev) || in_interrupt()))
+		goto failed_kiq_hdp_flush;
+
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+		if (amdgpu_in_reset(adev))
+			goto failed_kiq_hdp_flush;
+
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	}
+
+	if (cnt > MAX_KIQ_REG_TRY)
+		goto failed_kiq_hdp_flush;
+
+	return;
+
+failed_undo:
+	amdgpu_ring_undo(ring);
+failed_unlock:
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+failed_kiq_hdp_flush:
+	dev_err(adev->dev, "failed to flush HDP via KIQ\n");
+}
+
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
 {
 	if (amdgpu_num_kcq == -1) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index fb5f7a0ee029..5bccd2cc9518 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -615,6 +615,7 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_iv_entry *entry);
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
 void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id);
+void amdgpu_kiq_hdp_flush(struct amdgpu_device *adev, uint32_t xcc_id);
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 6e02fb9ac2f6..803f65dc4563 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -51,18 +51,16 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
 			      struct amdgpu_ring *ring)
 {
-	if (!ring || !ring->funcs->emit_wreg) {
+	if (ring && ring->funcs->emit_hdp_flush) {
+		amdgpu_ring_emit_hdp_flush(ring);
+	} else if (amdgpu_sriov_runtime(adev)) {
+		amdgpu_kiq_hdp_flush(adev, 0);
+	} else {
 		WREG32((adev->rmmio_remap.reg_offset +
 			KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
 			       2,
 		       0);
 		if (adev->nbio.funcs->get_memsize)
 			adev->nbio.funcs->get_memsize(adev);
-	} else {
-		amdgpu_ring_emit_wreg(ring,
-				      (adev->rmmio_remap.reg_offset +
-				       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
-					      2,
-				      0);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8841d7213de4..751732f3e883 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9951,6 +9951,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 66c47c466532..10d2219866f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2438,7 +2438,7 @@ static int gfx_v11_0_rlc_load_microcode(struct amdgpu_device *adev)
 			if (version_minor == 3)
 				gfx_v11_0_load_rlcp_rlcv_microcode(adev);
 		}
-		
+
 		return 0;
 	}
 
@@ -3886,7 +3886,7 @@ static int gfx_v11_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	memcpy(fw, fw_data, fw_size);
-	
+
 	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
 	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
 
@@ -7320,6 +7320,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v11_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 710ec9c34e43..e2bb8668150d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5597,6 +5597,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v12_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 0856ff65288c..d3d0a4b0380c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6939,6 +6939,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_rreg = gfx_v8_0_ring_emit_rreg,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
+	.emit_hdp_flush = gfx_v8_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v8_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index dd19a97436db..f1a2efc2a8d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7586,6 +7586,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 77f9d5b9a556..b1fa4036befb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4798,6 +4798,7 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_kiq = {
 	.emit_wreg = gfx_v9_4_3_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_4_3_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_4_3_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v9_4_3_ring_emit_hdp_flush,
 };
 
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a611a7345125..2f549f1a9018 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1309,11 +1309,13 @@ static uint32_t vi_get_rev_id(struct amdgpu_device *adev)
 
 static void vi_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 {
-	if (!ring || !ring->funcs->emit_wreg) {
+	if (ring && ring->funcs->emit_hdp_flush) {
+		amdgpu_ring_emit_hdp_flush(ring);
+	} else if (amdgpu_sriov_runtime(adev)) {
+		amdgpu_kiq_hdp_flush(adev, 0);
+	} else {
 		WREG32(mmHDP_MEM_COHERENCY_FLUSH_CNTL, 1);
 		RREG32(mmHDP_MEM_COHERENCY_FLUSH_CNTL);
-	} else {
-		amdgpu_ring_emit_wreg(ring, mmHDP_MEM_COHERENCY_FLUSH_CNTL, 1);
 	}
 }
 
-- 
2.25.1

