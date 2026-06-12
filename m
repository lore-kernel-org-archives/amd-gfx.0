Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22616CD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 09:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAEFF10F3B5;
	Fri, 12 Jun 2026 09:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="akvf+mf5";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012020.outbound.protection.outlook.com
 [40.93.195.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4725E10F3B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 09:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLKbWoQ+/gvznSayZ5ttNTqLf6b/GVhWGBvympCzbk9VvhmDImhdiTpfjCyZKWPFSuW6sP/oEr7CO9TV/FlZrW+ibr2VB3L/Yi8lwE0yqbW5hf79SJrq/Ew9wRjr/EuDsxIzv4sgrJhaLi47swiC/oVERfxgs3LBIUaN6q4fBAg0QFUhaxAPCZBgYa1H4MsxSSOS9CoeajMc0XxrmxL3zqTigJFDhogxry1P6q+FnBgl/tU5bQ+CUaNHcXWFTzZTRGC5DpNZHUhN2YrqwoobhitY1G1/jvvU7uf0mCFcP4S1nKqmLUAi5EVAsjVT1r/ipKF9kNGIlio1mmAkm59TJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjRfHurCkjRhTFzkJcbw/NqW90Pbtr7zMSBVnbA8BiQ=;
 b=kd9bEBw+bDhxCNUy1EH2GyU8jtDWqgz6E7gzOiotzHrdb9dLAp2RNCkUnx3ZA6/rB0LM5MKHKTrpS1qHa0pnm1Qh6+CMaA0S8dtS8KwdKHgx8VgPME37h/WilxWZr65EpxCqRVA0Ux6knJ5h5fUfzj8Lh4uIwUYvtgAHMli2Vcb5n2UyD318UVqi+jCl+AOLQ1uzgYq/pD7cSBvkQpQ9HKZUllDT5Lt07EeVo/xRdBPfwnEkTnaM/K6JdoGCzLmXY8ZsYvEMIJ4cX3YldhOk0crFYxmuoNP/ifMbvKtNlWKxdJTdGyRi2SWvnWaooJTBcpHm/LTkVQKhSnW6ODc7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjRfHurCkjRhTFzkJcbw/NqW90Pbtr7zMSBVnbA8BiQ=;
 b=akvf+mf5rviYf36ROSA0A1UEzVMHT1a9uaRqK7lcbKRg/TX5ycMletZWjn/Z/gnFVjvTHT0dWA1JEU3QG2MR6oD7Ncwn590J7P46Dc6Cwq0o0os7nEEQ55lQZnKdJ4xaXAjnaT05vbgSScG3uftFt9D9tsH/CxXNcS/RisEqOLc=
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:27:16 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::3d) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.9 via Frontend Transport; Fri, 12
 Jun 2026 09:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 09:27:15 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 04:27:13 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Huang Rui <ray.huang@amd.com>,
 Huang Trigger <Trigger.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [PATCH v3 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2
Date: Fri, 12 Jun 2026 17:26:54 +0800
Message-ID: <20260612092654.1632603-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: d0969350-0c3f-4b0d-237b-08dec864cad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|11063799006|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: O7O+0zLAD7EVNV1q6zsv/8F5CfZ6ccVgrw9qjn26ulh/KMqheSEtEVNkVKXlppoqXi9LpwcLfBvOpVpQ+6a3Cj6O8O+310u41PhUyxAbRkca0wGh6xXWZyvzG8dV287mazRQ9yVwfwOnZ2xtCJb9jvKVrR3ljIFmcy3U7bIeYBoY9uqUQazgAN8AgP/m3XxN0gWSn7ohnFSxrQT6Xx396zoJsZHNxGNW2AiCOYQu9Q48l3KSG6cY6QUIVaRW4w2DsKwLObFnUsawXkmOA3rM8YRpd/hdFKf3+cpzq+Rv95MGY3KeJZ7LGw79QPeAXwGf8LhWtmoAAokJyGc4ZGVAK2NIRGWFPtz/300NM/VI8kv1lwNxHaCM1fIqid5PjJ4RYv5z8bbWFQ3wi9zrFeDQrJx0ha9O7DnZn6clLnEwb6mZ19iuT/s83JXRBLxyNwspMNakA1KfzJGzyil6n6TkhsaGkPz6nnvSSOGDaTdm+tvUkLHMTrH2ZEbjwBnqJexELc/sULk2V6YjBLj2SeCttZ8CrUrZTdWjE0btMQ408dv9exhjCiQ3tnnR2jHZt6NclT9RBUkgLaxxI37/cFnwtFkR3Xrz8SzmUtWm7+ec7Bh+g/qOmIRkIJURo2bETLeS/I6S9+MF3YgEdwJ6RZQQSn7wNYucZJxBrSG41xqFISQfAxijPxCgQfkKyKg6myq2SOCsl9TzGHD8PusJXNhhLyxQJQ14b5SE+1FArOxSSdQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(11063799006)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sHPrbzYjZmNdV9aPXCrhB0WbxkdM7YWZwiLfeFlnPUWwVUPE8UXtIOU89TL0UdRmE9wBL4FlAeWlWA48Z2Ad6AZkY0s0PlW+a0r9UxHyp6A/aR64vp5W5QDY5KL52MG387pd9gbHB/EfwuV8bNmq00xfdGysf1IokxV+44y6IOZXWlIdP6+VP+JE8ZGUwpfNGPicRhfXjZyhhKFd8LULiZQU2H7sPG13cYlLh6KQi2TFbh14T++1D252QH9nOjWQowdMES+khSNK7PwaWu0JkJ6n9at7T0D3eT3L5q96OABvxwOiaG95zS8y5aY5Z6iBs4IzoREhcGUcQ7lgKK+VqFu7crNLLVZekw7uZ/kCFkw7njyH0t0Nl+pw6tIVthdSm6GGEDelFc/x0AcCZ75tKomLc1l5nly+lBqjuhr7N4Vgg0NdJAxNtTgYpidQUEc4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:27:15.6977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0969350-0c3f-4b0d-237b-08dec864cad3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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

For Renior APU with gfx9, in some test scenarios with disabling
ring_reset, like accessing an unmapped invalid address, it can
trigger a gpu job timeout event, then driver uses Mode2 reset
to reset GPU, but after Mode2 compute Ring test and IB test fail
randomly. It because the HQDs of MECs are always active before or
after Mode2, that causes MECs use stale HQDs when MECs are unhalted
before driver restore MQDs, and causes CPC and CPF are still stuck
after Mode2, then causes compute Ring and IB tests fail.

So, add sequences to deactivate HQDs of MECs in suspend IP function
of the resetting process.

v2: Move all sequences into a new function gfx_v9_0_cp_mode2_clear_state (Ray Huang)
    To check reset Mode2 method in the if condition (Ray Huang)
v3: Move all sequences before Mode2 instead of after Mode2 (Timur Kristóf)

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
v2->v3 changes:
* Move all sequencess before Mode2 instead of after Mode2, and add a new
  function gfx_v9_0_deactivate_kcq_hqd to do the disable compute HQDs
  sequences.
  Then the resetting CPC and CPF are not needed since we have already
  move all sequences before Mode2 and they are not stuck

v1->v2 changes:
* Move my sequences into a new function gfx_v9_0_cp_mode2_clear_state
* Add reset Mode2 method check to the if condition that call my sequences

v1:
Hi all,

My board is Renior APU with gfx9, smu12. I run a testcase that
accesses an invalid address to trigger a amdgpu_job_timedout()
with disabling ring_reset, so that driver will call mode2 reset
directly. After mode2 reset I found compute Ring tests and compute
IB tests fail randomly on random compute ring.

We checked the scan dump of GPU, we can see the CPC and CPF are
still stuck, that caused Compute Ring tests fail.

I added printings in driver codes (gfx_v9_0_cp_resume), and found
the HQDs of MECs are still active, that may cause MECs use stale
HQDs when MECs are unhalted before mapping compute queues (restoring
MQDs to HQDs).

So, I send this patch to fix above problems.
There are two main changes of my patch:
One is to reset CPC and CPF before resuming KCQ.
Another is to disable HQDs beofre unhalting MECs.
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 37 +++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 90bbddb45730..0c01701488e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4071,6 +4071,39 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return r;
 }
 
+static void gfx_v9_0_deactivate_kcq_hqd(struct amdgpu_device *adev)
+{
+	for (int i = 0; i < adev->gfx.num_compute_rings; i++) {
+		u32 tmp;
+		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
+
+		mutex_lock(&adev->srbm_mutex);
+		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
+		tmp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
+		/* disable the queue if it's active */
+		if (tmp & CP_HQD_ACTIVE__ACTIVE_MASK) {
+			int j;
+
+			WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
+			for (j = 0; j < adev->usec_timeout; j++) {
+				tmp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
+				if (!(tmp & CP_HQD_ACTIVE__ACTIVE_MASK))
+					break;
+				udelay(1);
+			}
+			if (j == AMDGPU_MAX_USEC_TIMEOUT) {
+				DRM_DEBUG("comp_%u_%u_%u dequeue request failed.\n",
+							ring->me, ring->pipe, ring->queue);
+				/* Manual disable if dequeue request times out */
+				WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
+			}
+			WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0);
+		}
+		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	}
+}
+
 static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -4095,6 +4128,10 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		return 0;
 	}
 
+	if ((adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev) &&
+		amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2)
+		gfx_v9_0_deactivate_kcq_hqd(adev);
+
 	/* Use deinitialize sequence from CAIL when unbinding device from driver,
 	 * otherwise KIQ is hanging when binding back
 	 */
-- 
2.39.5

