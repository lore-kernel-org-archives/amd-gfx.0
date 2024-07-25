Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15586C49EA1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33A2310E29F;
	Thu, 25 Jul 2024 15:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h+Wd9/82";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4502B10E846
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg/PX+Ijj/5ecLrkBtppJdz2tLUEPtYoOFRJmz1Es8OdWNe8Uo0lG85xkAN+wTpaM7VguZrVnPgGuJXfh+0RlZ2Iiv2dPNHq+7E7iiskyOq3Ex7J2tf2BrcT/Qbud98JoVaLWEY0cRZbmQQSba1CHPECMgD2Wf3EcsYqvtmJCR57qor//14kxTSdm3Bg7AlCjPW2PCaPZkwJFswyEfpWT4yPcAZVRKQIXk+v49204bgZhyj1gLsCDFeeyGEZhTz7fIset4uG1Vya3Ls+soX9TX/qKEYDurYrSNUM0ZFlya8RkmMw8o0RHkLHyn13nD6rj5rd8cUPuPEcfskZoki4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/TB5E+TDj+1vkaupDz51XId08ee05FD4zYHOhsR0vQ=;
 b=xoE/uTWXDgJ1JOyDiKtjYZmJm497HxIyUVfbUFYHNBjMPxIXWy1gIu6MnYq6YQxT220LVk2eoto9gNQYcDjBTtsW8Cuku3H+H/XMwDhy0U5qD4Dzl6LkhpgiPF8a2VkyCfs97WX2Fe7dWJ0qM0G8L4GWb587CEoM/S9AFW0PqKHzE/+4BYhXShKOkrr1hzMzEHsJx/bzfzm4BuvvZCJWkJsQa67yJ43nLBRCXwpmKIoR+kN3ZOqbBxg7PLgM32xGR4N8LUUxDgQysY9/llQfMPQNj8AkP2+xUXZyG0ok17UQg6DD1rN3lWbIJlGmDL9Gaa/YYArMLRu5IDja7zYFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/TB5E+TDj+1vkaupDz51XId08ee05FD4zYHOhsR0vQ=;
 b=h+Wd9/828jGh67Lun/50UxAqBfYwrgY84BoqMhk+CBSDTtUriKMJdXE1gxsLpz987zGEnV/uMMv9HxTFsso03l5hciu25i0nX+2fx0HARzHdvcmvDkIY4x8Jldji62qOsdKAsDks/W8h7QzoROlxIxtUUl2T1gl6CF+4Tou7nMw=
Received: from PH7P220CA0119.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::6)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 15:01:26 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::24) by PH7P220CA0119.outlook.office365.com
 (2603:10b6:510:32d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/53] drm/amdgpu/gfx9: implement reset_hw_queue for gfx9
Date: Thu, 25 Jul 2024 11:00:31 -0400
Message-ID: <20240725150055.1991893-30-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d113369-4da8-43d4-7602-08dcacbaa838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4b30/WHpJguCXFOfA71OpbETmYugfFcRj4zZH64QvGmBRpuJhd2gbc1p+qfN?=
 =?us-ascii?Q?vsw6Z91fmtaX10bwQOEfssOlhc4PayZIftouzgYmZ9fQAVvPUZQjfAAomsEW?=
 =?us-ascii?Q?dBhTiOtIhYSxh6RER9eoR5NpoCBH4ueOOKx+G69w5+3TCO/BtOvLsOzeD/6J?=
 =?us-ascii?Q?iGVdfQ78Zo79Nihbd15IgsgS5wRIA6itrx+0/v/l5gIuEA9DECbwDcLcuw8+?=
 =?us-ascii?Q?sPxvslXp8aAVR1QJQQleYi8QzMe7NW0JtdVP2UYfa8B57FNHeXmig8qPVsuE?=
 =?us-ascii?Q?4ANoPiPgoFiPHLAYceziaX/DRQPlyW+qGuPeySZhvgelpVz10GGs5oTdQXuP?=
 =?us-ascii?Q?QoPgYY36V/N+Vz+ShnXuGwzpMC2WrjRwHkqbRo/K7aqdtpZwWcNZ+TJUhkRO?=
 =?us-ascii?Q?K2hWiAndNrdH66VSXOUciDfzFikgV2348azMMux3v5Uf0fd8NhiDH+jLgx/P?=
 =?us-ascii?Q?ir/nGyPxGTxQ2I68W7zk5DkbHKHoisFTYaXQF4kSWUltT6IAS04mEIoUlRXe?=
 =?us-ascii?Q?Gtj6w7UO+VqI9t4x40rCviFXFUvpMUdRRWsEmOSpSVfK2mn3HsJg6V2jEsrv?=
 =?us-ascii?Q?1FyZL9f0GtEk+zzO9KsFJ26VFWhO1lh9NzO7uDlolt+PvgJVedCBUIoJjBxw?=
 =?us-ascii?Q?XrRcUnjZ5Knj3MeITGVZJ0c6i1xQSOnh/Dlt5d0UiwmAzuyZhnWS0OVveLuV?=
 =?us-ascii?Q?v6IlwjKnJJd/3+2/PLCrJVaKfoTR0mckfY1qePO97SuTWTYdkI72USgzc6AK?=
 =?us-ascii?Q?VHNqL70bZNCbB2IWOckevpZfTSrr6pCs0SG+DDYRXiX8UpK7kkgcmgN9Yvi1?=
 =?us-ascii?Q?cyOkgzHOdChAXl8rA3KXE887XaT2xLdz5KyHVuWyxUhMpfhlrbMo0o7cwBxI?=
 =?us-ascii?Q?1Cc/KQZoq7/kzX5dxrR/jKmXpMHXmcOMo/fr8y3oyc+glfn8yqxnxz0fwC+u?=
 =?us-ascii?Q?olqecGxS83XQJW5LS2dlpO5+mkCGjc8dH3bR8HGzd4W/QFsVGfM7ELZFJRzX?=
 =?us-ascii?Q?WCdqYrgQ3kwPRIAY2/tRMwrsKmx7Gc4VOsP9ekh85T3X7Z/ltl24C7Cma7Uj?=
 =?us-ascii?Q?eG7OvUh7CxieGjh0Im9eCxgMqvO6+RNaF3yUlYBa7MbZQU2NvTYASe+fBGhA?=
 =?us-ascii?Q?kLYbzg0h0sZ62zVefQq+EShRFET10dpCnGYmaZD9gNT98ZpOL262N9yB075O?=
 =?us-ascii?Q?Pa5Q3dgojYX2qxT5DIDwBwJR+rhnGdvTJD1jdBxr4SnpVneTsU0J+U+gEE12?=
 =?us-ascii?Q?rWX3S1mmXdYR6ano0imnOZLIm4Adndqlwp88pVTtIX0PlyZEVmHctGfky4xd?=
 =?us-ascii?Q?5+uoq7z4KK3e1z6t0+jKAbL7z4hsvLRZqNOBIXCfXfBsUG9Bt5IM3fSam5G+?=
 =?us-ascii?Q?/PuFxR3OTpbAcAr+YVQQ5tjHS1onC0vLet5VCcbf8mwOD2cuE4o2Uil2V6ps?=
 =?us-ascii?Q?YikjK/PQCcXe7vkl33H+mwOKWgQZ2FdE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:26.4684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d113369-4da8-43d4-7602-08dcacbaa838
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Using mmio to do queue reset. Enter safe mode
when writing registers.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 37 +++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 9790e64ec4c9..d69a0e2f6eaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -893,6 +893,8 @@ static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev);
 static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 					      unsigned int vmid);
+static void gfx_v9_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v9_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 
 static void gfx_v9_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
@@ -1004,12 +1006,47 @@ static void gfx_v9_0_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
 			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
 }
 
+
+static void gfx_v9_0_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t queue_type,
+					uint32_t me_id, uint32_t pipe_id, uint32_t queue_id,
+					uint32_t xcc_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = kiq_ring->adev;
+	unsigned i;
+
+	/* enter save mode */
+	gfx_v9_0_set_safe_mode(adev, xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, me_id, pipe_id, queue_id, 0, 0);
+
+	if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0x2);
+		WREG32_SOC15(GC, 0, mmSPI_COMPUTE_QUEUE_RESET, 0x1);
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout)
+			dev_err(adev->dev, "fail to wait on hqd deactive\n");
+	} else {
+		dev_err(adev->dev, "reset queue_type(%d) not supported\n", queue_type);
+	}
+
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	/* exit safe mode */
+	gfx_v9_0_unset_safe_mode(adev, xcc_id);
+}
+
 static const struct kiq_pm4_funcs gfx_v9_0_kiq_pm4_funcs = {
 	.kiq_set_resources = gfx_v9_0_kiq_set_resources,
 	.kiq_map_queues = gfx_v9_0_kiq_map_queues,
 	.kiq_unmap_queues = gfx_v9_0_kiq_unmap_queues,
 	.kiq_query_status = gfx_v9_0_kiq_query_status,
 	.kiq_invalidate_tlbs = gfx_v9_0_kiq_invalidate_tlbs,
+	.kiq_reset_hw_queue = gfx_v9_0_kiq_reset_hw_queue,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
-- 
2.45.2

