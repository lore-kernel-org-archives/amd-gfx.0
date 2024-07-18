Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06055C3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E761610E8B9;
	Thu, 18 Jul 2024 14:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="moEpzg9/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7B610E8B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:07:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpz4hQhtp/9JAxSQSZMo/q07bxuM/F0IR665N647bnGFZrKs2HOu3/3MXQs1kQVmO9op7TH5H1c1yjD47uiCVIuonQhUhU97JF41kF0GRMslLuYYcEIMxODydORfTnfks1r0hHREXGDi6kaYZdZ+qEXCQj6tB3re9drlfiFm/iAveJ6F4eApdZ9m8maFHmpAshJ7SdZLOxRBXZARM0QGMO0wdmSCotIQQgJfca5AF8W8vu06efWbWIRNeEPuAuLFYpyQrQMyjWfA2R0ZXrK1fYKMONmu7eOsOoYPERXMUj2hb2AWOK+SHiigV1b1UJClnAWrLSzwWMhlodVpiyJX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1eK8ps4iXy+NxTlfEirWd+WuS2gP1Li60c1GuspO1o=;
 b=KcT5+WczzzdFJcKnTgcXOeR4AlYUKobrju/0KiPeRWwxHRIWrLmzGWAhlqN38TPhPysooRrbcCCe7NO5il6vvKqGSvLIPdy291fm8B2hHWQqXtxkyQGJ2YkB2XivFQMgK/8wzX0bQuSaPO3re+sG3z9UBeuzNqtUsakj083cmmj0Y0xsFOnBMIqAbPpW/ft096rF+oVIzuIMYn4CWsu2ncpxWgb1jBUtNAVANkfN/yUTGmjNd0swqPlk0Rnd6NbNthrWcdWbG7/eVreA1DeOHKZnrxQ6UOvLkI8UzLZeuWjMs6fe5UWoeVLQr2gN05sej6CP4soWAyo/HxIClqhBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1eK8ps4iXy+NxTlfEirWd+WuS2gP1Li60c1GuspO1o=;
 b=moEpzg9/gY7HnVzC7J6qMl2wNQLtbKN0FFl2ZALqzcN39OOeyu7qGaIAgW4qU/SINDsF84X+z6XvljTN+R+Hj5IFxo+SvW4h0aidkVMqNXJLjaRZw82/Vwh5k++nRC91P0/ViUbbk6v/wO+r/jbOywRByuMAUPRPg7NGP/r5628=
Received: from BL0PR02CA0002.namprd02.prod.outlook.com (2603:10b6:207:3c::15)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 14:07:52 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::d9) by BL0PR02CA0002.outlook.office365.com
 (2603:10b6:207:3c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Thu, 18 Jul 2024 14:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:07:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/34] drm/amdgpu/mes: add API for legacy queue reset
Date: Thu, 18 Jul 2024 10:07:00 -0400
Message-ID: <20240718140733.1731004-2-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb55bb5-f92f-4cc1-9e82-08dca7330390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7acSRiCm72q7J2/O70jdco/KgR/pOWzeKxHCHWu2IScZqj9tzjcaznJbH2Yx?=
 =?us-ascii?Q?3EWPP0UnPq9e2WTA8OtHoHZk5Jz/ZP+hjKUjF5QqvZUbhuq/IPIvniRpElVr?=
 =?us-ascii?Q?2wR1r67/e5ryOhn8juu4bfoc8jtc7UuhkfJoFF4OUrLFqU81JwR/R7FilkyJ?=
 =?us-ascii?Q?e0I5I6bAhZBR1st+2dhQzCiJgcx2KLiihE1xMrfPnVfBWbqplkuVZmZr/nae?=
 =?us-ascii?Q?pmZ6BWcEGarFrlFCNpw04njGH++a7hOaixJl3KSw80BZ+4gybkz98JFUOyZ3?=
 =?us-ascii?Q?h5e170pwZaqJvyFTP/AYNrUa3J8Q06mwEXCimYQPVdAAKhYobw0MFmWIlgMg?=
 =?us-ascii?Q?JsCbq6G8pVF4uPNruJ2alEgGRiJlEYJxPTvtxS5aFx6upvOiOFygRcmgfXix?=
 =?us-ascii?Q?Qkn0cGAyixSH5E95ovkiamnef1lQZDR5MjgIyvgrRWyHYZi1RrZ8M8MRgc9X?=
 =?us-ascii?Q?O+ncc/BZdeCy+VgY4wzrueXJl0Z6FJ95FF0CDdPNGhBOWuiV97Uc2jYlH9Pv?=
 =?us-ascii?Q?mQBuMBqpg4iqsEpD2uZvXx6XagigcghUc1JztmngfwvlpoZ3AcfTyr0y6UGe?=
 =?us-ascii?Q?/VJ8sdPQ6x5ToFWmmD1YKsJ6tDKPVOwwEhOR8aek481sbWFQyojLksBamglP?=
 =?us-ascii?Q?4qKfk2QbSeWGIsnCH5zccvd5zTklTsAbHsXTA+l+TmuFX3rseMdlaB81hATI?=
 =?us-ascii?Q?32XAH27adLOGNBHj8Sw9ZoX/aGUCD3pKILNxOjAn+hmkhmNEX4a56XYxkDsY?=
 =?us-ascii?Q?ctMVrX9RqUnIwT4f+rExwyD1dIZyJSo+HZhtlUp+Qo+XX3ABtjZeqoZKDxyh?=
 =?us-ascii?Q?1dptUEx4iuTzQYzMl/nd9OhXIh8FK5HBeXJKu0GEHC40B1KIyDtD2rKCYw6j?=
 =?us-ascii?Q?+Nwm2q8FGauW+hqdCsFFo6Dal+hq5+jzTwkdna1Fq15iisziR7WPlW7wNZ++?=
 =?us-ascii?Q?2YLq6fF4FbjGkTzqd3vsRazDCtWsE3RNt5aaqS77RsYED2vgQXh+lHCNWaLb?=
 =?us-ascii?Q?WP0rv33b2eJhu1QPgJ4aFV6w9sejxlRVRqAM4D08jBmT3p9DlbZG7i5f5Mef?=
 =?us-ascii?Q?oI1zKXRMtY6f5GFK5iGXCqzPKhzxthfKO7qTOQB6O5N+ihHNOnmXIPe27Qcu?=
 =?us-ascii?Q?sYIN0r1qsDQJDuoAtvHMrSHrrb1ryU4no13FO0wEW9Kff7ZaW/LDXGAt4Si9?=
 =?us-ascii?Q?Y85PH0LJp9wjOd92t2b+VMHFqkTCNDcWP4BtVfBb2ITHovDSdlBZQNn9AjGD?=
 =?us-ascii?Q?jQ4dv/8sGFQyhCNWyNcsHqyL03ihluHm13BlWFfSyCEhx3x4mKOl9Mrr3t7z?=
 =?us-ascii?Q?TtEPAR+vA6eKFqK6vH1u9KgcGEzONEkTc90VdjG2yWJZYRtah5Ip3L5Bz529?=
 =?us-ascii?Q?bBzqI+iXyrFB1dH5hyCk2olnIGnE1MCYv1tYDH2D11v7daj+rxRNoi/AAeII?=
 =?us-ascii?Q?FZKojslPWxDcwUJko6oA2Ox56wZMHC1B?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:07:52.4122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb55bb5-f92f-4cc1-9e82-08dca7330390
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
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

Add API for resetting kernel queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 16 ++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e499d6ba306b..1739aa11cbd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -819,6 +819,30 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
+				  struct amdgpu_ring *ring,
+				  unsigned int vmid)
+{
+	struct mes_reset_legacy_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0, sizeof(queue_input));
+
+	queue_input.queue_type = ring->funcs->type;
+	queue_input.doorbell_offset = ring->doorbell_index;
+	queue_input.pipe_id = ring->pipe;
+	queue_input.queue_id = ring->queue;
+	queue_input.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
+	queue_input.wptr_addr = ring->wptr_gpu_addr;
+	queue_input.vmid = vmid;
+
+	r = adev->mes.funcs->reset_legacy_queue(&adev->mes, &queue_input);
+	if (r)
+		DRM_ERROR("failed to reset legacy queue\n");
+
+	return r;
+}
+
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	struct mes_misc_op_input op_input;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e11051271f71..4456956c325b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -279,6 +279,16 @@ struct mes_resume_gang_input {
 	uint64_t	gang_context_addr;
 };
 
+struct mes_reset_legacy_queue_input {
+	uint32_t                           queue_type;
+	uint32_t                           doorbell_offset;
+	uint32_t                           pipe_id;
+	uint32_t                           queue_id;
+	uint64_t                           mqd_addr;
+	uint64_t                           wptr_addr;
+	uint32_t                           vmid;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -347,6 +357,9 @@ struct amdgpu_mes_funcs {
 
 	int (*misc_op)(struct amdgpu_mes *mes,
 		       struct mes_misc_op_input *input);
+
+	int (*reset_legacy_queue)(struct amdgpu_mes *mes,
+				  struct mes_reset_legacy_queue_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
@@ -381,6 +394,9 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 				  struct amdgpu_ring *ring,
 				  enum amdgpu_unmap_queues_action action,
 				  u64 gpu_addr, u64 seq);
+int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
+				  struct amdgpu_ring *ring,
+				  unsigned int vmid);
 
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
 int amdgpu_mes_wreg(struct amdgpu_device *adev,
-- 
2.45.2

