Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CDDC3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F0910E8F4;
	Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DWJRlAEK";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5794F10E8FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0YO4DOiOLcCkW8+12eC8KoSf3q9qs/5wv+HDdMERBCj6JUE24JP8oIgiIuDyhdXRBeJmonNG8C1gdUL6Eq3PUVt3lUYBt6pzoy1Y+5rs80wOHYDjN0+m/d3Cj6/wxs1RoeXYegDjtmqJSr/hait1oemJBmh0B5Lm1haLfO08y7oAzrNWmjjFz39Ypsncbze2embYvnlGwUDMSACmb8O9uTBSY27jktwkbzjkrPR/SwGq9uYndJei4Fj/ktvArfd8JzULOe9cZfBKT7n5sV2N57HVqBD2HAJNvDpv76Z/PhQzMTRrVa+NPuE668rxfi2mzH95YXdp1mQ5wz1T7NPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHlwXCC1H8V3+Ixo2uARZNljDO8ieJpeNOjB6zZEXqk=;
 b=M4OoC+k5OWMVlGHganCT7CrIqm4O1U7mzVjgCqBKwva9pUYbXRzqemmGJdDtmM1R5PM99+3N9iN7UXDSVE/ko2hnOjfPa+2lSSn11RgVn2aK1nNyVhNM9ond1pgeCL14DSkQmNLGzNo64Qfc9Qc//fIpvlO1l8mW9Un5vamnLoqAXzCbu3s/bpeAFJrjcuoVfwoPa8i2TVed44D9Pa+TQL5Im3OChB56lC+ji8iAkvng7dzLBhSnIDoUz53v5qgD1rxDBfcRfTuUOy7LKBfw+DaulCu7VgjIXz5ZuhEE7H3qZ3Fp96QviDfOqp+xDDcdIXdpZxyd/Q5aR959ymnYhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHlwXCC1H8V3+Ixo2uARZNljDO8ieJpeNOjB6zZEXqk=;
 b=DWJRlAEKI94r1r7ESIQHZ1SrjfjeXy6zMWQ2PxiznoIo2ENi4ff3dkn70iPizTZY1S+crZMNQlEKr32UQQcPWx0YYJ+1oHherpcNSqmImk4YdP4zL4a+GPb03PPyjXRvRLcjjKDSAQ6P4Mpx1G9v5FAZT3BMJop893tdnXsmxL8=
Received: from BL0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:207:3c::31)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 14:07:58 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::5b) by BL0PR02CA0018.outlook.office365.com
 (2603:10b6:207:3c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 14:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:07:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/34] drm/amdgpu/mes: add API for user queue reset
Date: Thu, 18 Jul 2024 10:07:03 -0400
Message-ID: <20240718140733.1731004-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: e693c2d4-c351-43cf-5158-08dca73306ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jtyja7aF0JSOUd8lrYR4PLUZgjaBgd/PBM2X198aJzNIiKBrQtvJnVIv4amm?=
 =?us-ascii?Q?AC1uQdlataiwH0ixKhQ7AVqFHi6LjqiQOmrLq6Pub5bEm1ICj9yEsMAE/TRb?=
 =?us-ascii?Q?HY2TnpwysoXdDIfkTC7PtH/waqY3XXB7AYtslsoKfp4zPNkBycIbvjDTQM7u?=
 =?us-ascii?Q?fzMj2EjXU8Jxvdqxnvo7etaJIQgCvqxh/K1bqo6QJyUyqblZ6f/1uTM3LZ5B?=
 =?us-ascii?Q?psNEt+YjhcxvG1hXAIz6EQarAGyQN3jndrat27CutfW/9E8A077i1vdphoSs?=
 =?us-ascii?Q?U0BWftE7+DmT1HxjlVYwQwHtRklqLP0U591MMGlo4CsLxNJABIoULYas6ZQN?=
 =?us-ascii?Q?aQnpxieZbJD0zGgfwfDW+Zok6Ij2NCr0op5G/Tcm9gLy2qQ6zurGOURuDwVc?=
 =?us-ascii?Q?nLdKeRzPq4+czpF2C6fC/7UQo3fUfWqraIPSXJYnBhQ6OSr30UWExkEWvD1V?=
 =?us-ascii?Q?wx24IBEaPaGGE0cuIXkLGMMGrLcCG9gDsW2HhDTu4v19L/fczzNdv0XzQ7KZ?=
 =?us-ascii?Q?WVRFEitKY5pFyMBt0a/NRGj6tTDMna1Zs3k8dp9dGgRRf40PVRvqzNQ+72lN?=
 =?us-ascii?Q?TR/MbnB+1KfBjHkmbjsUndPTGSTTLJO6Revjqknf00++kq9fBHYvZDwNNjIB?=
 =?us-ascii?Q?KLdPUmsFxhXEuQxXtcyN2TnrAy2pF7kqF9XuUnkhw138ddl99n7D7DRx9vid?=
 =?us-ascii?Q?WKFPCbrPIv4t/l7yKD38AbsEX/bYOWuBUqGMV1TEPetifmVa/u1jfnMUpiC4?=
 =?us-ascii?Q?W38zTMwN4aqf2x2Q5mIElBFIvkqJm7H6eqtUA+Iy0JKU46JoMMNxn+ErFpSc?=
 =?us-ascii?Q?nC7xMIF4E7VaAapzLCUUlu0ROHQQGm8cO0HweRfvVisAs7qauPTbEnanTql0?=
 =?us-ascii?Q?0ecFYADljS/dsY9pNgNFrhbKgKvIeGCAbOZDbnhpJsh+kWF/sn+rhxN/YKPp?=
 =?us-ascii?Q?v2yexMJHKT209xR6fYBySuk3oTZRTkPEJnxH/llMMiCPnQo/wyUK9VScvBeI?=
 =?us-ascii?Q?d6tpxWKpQm/IdOByL26LaJKjH2AlR0jHHDY9mqo9eqRj7icirEmLm5B2g/GT?=
 =?us-ascii?Q?oby4cdvB11yZJT0/Ri8xsS7QFsvQze3HRFkoo5owgbSI1xrJQmBRGTIDIyJl?=
 =?us-ascii?Q?kdk8K6D/WzIuz+QaGx+AzSIhVoPxU2EhdFtEwn+Yw0StBgJRo3GPozodi+7J?=
 =?us-ascii?Q?N5Y+jRDmYbT7xApyPd5Nj20ya9rh1jOz7xqYq8vZ7YNUnvDcwU7mR3WRdKXv?=
 =?us-ascii?Q?IxvzUkO7n57CT1esLlQjPDNeqbqZm3cB/8AbpUKGGA9oEyb9UZt997Fp8Den?=
 =?us-ascii?Q?Nyktsww4O/eVM/y9onoJ91HYlqIvfUP9cNE/Jl0y+KmQlg2OSLEbo8Wm0IAA?=
 =?us-ascii?Q?Suqnj/FhHY0HQ8DZlpacu+avQBtMqvnTsOFnOWgekF9hHqOZV+tnbqaQ2Qts?=
 =?us-ascii?Q?cJ24UIFzx3yM6Yh6PvALAjiks2Fa5H9Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:07:57.8498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e693c2d4-c351-43cf-5158-08dca73306ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
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

Add API for resetting user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 43 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  9 ++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 1739aa11cbd2..b3d6a9fa6775 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -774,6 +774,49 @@ int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
 	return 0;
 }
 
+int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id)
+{
+	unsigned long flags;
+	struct amdgpu_mes_queue *queue;
+	struct amdgpu_mes_gang *gang;
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	/*
+	 * Avoid taking any other locks under MES lock to avoid circular
+	 * lock dependencies.
+	 */
+	amdgpu_mes_lock(&adev->mes);
+
+	/* remove the mes gang from idr list */
+	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
+
+	queue = idr_find(&adev->mes.queue_id_idr, queue_id);
+	if (!queue) {
+		spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
+		amdgpu_mes_unlock(&adev->mes);
+		DRM_ERROR("queue id %d doesn't exist\n", queue_id);
+		return -EINVAL;
+	}
+	spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
+
+	DRM_DEBUG("try to reset queue, doorbell off = 0x%llx\n",
+		  queue->doorbell_off);
+
+	gang = queue->gang;
+	queue_input.doorbell_offset = queue->doorbell_off;
+	queue_input.gang_context_addr = gang->gang_ctx_gpu_addr;
+
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	if (r)
+		DRM_ERROR("failed to reset hardware queue, queue id = %d\n",
+			  queue_id);
+
+	amdgpu_mes_unlock(&adev->mes);
+
+	return 0;
+}
+
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 4456956c325b..771b63db1846 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -248,6 +248,11 @@ struct mes_remove_queue_input {
 	uint64_t	gang_context_addr;
 };
 
+struct mes_reset_queue_input {
+	uint32_t	doorbell_offset;
+	uint64_t	gang_context_addr;
+};
+
 struct mes_map_legacy_queue_input {
 	uint32_t                           queue_type;
 	uint32_t                           doorbell_offset;
@@ -360,6 +365,9 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_legacy_queue)(struct amdgpu_mes *mes,
 				  struct mes_reset_legacy_queue_input *input);
+
+	int (*reset_hw_queue)(struct amdgpu_mes *mes,
+			      struct mes_reset_queue_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
@@ -387,6 +395,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 			    struct amdgpu_mes_queue_properties *qprops,
 			    int *queue_id);
 int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id);
+int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id);
 
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring);
-- 
2.45.2

