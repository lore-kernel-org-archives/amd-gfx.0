Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6FFC52D1E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F2510E90F;
	Thu, 18 Jul 2024 14:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X1K2UnmB";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C86C10E8EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOnjM+mey6BU4u4GwREz0KBd3wy0pHRKzdUuoghsV1CUNB/A/9jWR/ade4PFQ4APMOe6lRwlJR/k0s2bGjh+D5a7y/avAteuLrA+cWVbfUddB/YhxHMPhzdNz7tSzSTBe0UZYTJQ1ltp7+txRES+CME3zdKDMjaOFaVSNWIcJ/SAyggJKsBQ2E82gUwO4LJGIAzfeTjuXyoVCQRjCCvzaGWUsgoTy83BnomedpONgHwOVQfmFtd1e99hrzoIjK6OPcEFps+tteG3mPDV4dZw+4yhSZb/VOqw/nTMwLqKPNfca6R6BUQgwU+7MfXboM644K5rUTUrC33qUGRB+N3oIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEJV0YC8ur0ZjNJT/hYbKhC207yNLUWxjBhZyipwlgI=;
 b=f5OwSgeFPpueqIe56rfCPfosNLVmPO3Dx2oSDHoz/tEp8JfXnKKXLQMfuQIxRmmxLJVhqU4aEHQb2k8SvofRFkzvfbNa5HJ9OQk0Bfw/MThzFsLYMi6AE0lQnJuQkNNAEbEWTjnMz5DmS7Vy7s7wtr2OHTIXaxtoBHmr0aheXQCnknMfMAxr3ikM6RtqUX+Qcnb00B6GNQLjIfwwAyWGztoj7G89WlsDnTRb9dykOraeJ/cLDY/8oP+vo9T5LEHzAiKt2g57cG3MbE8aku8bIAeHTYmaiUx7xhP9euENZNi9EUPi6ddwa7fVaLw3p6PnXVxxy/GW0wmmHnPXyfeSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEJV0YC8ur0ZjNJT/hYbKhC207yNLUWxjBhZyipwlgI=;
 b=X1K2UnmBQMSrOLHGooBMYlyEvyZScXFalU9huym4U0gaP44D5SZ/0lRp1UE7gBEY19haEwMkCRpO4qBgLOq0Xe4TvQZ8CfeDqJH+BVLnaqzlAXuCbtCY3iaZiQFObC9al6ysBqt5rZeVivgQYZ1K2oZXp2xES39hkcPYqE0aqdg=
Received: from BL1PR13CA0088.namprd13.prod.outlook.com (2603:10b6:208:2b8::33)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 14:08:05 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::f) by BL1PR13CA0088.outlook.office365.com
 (2603:10b6:208:2b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/34] drm/amdgpu/gfx9: add ring reset callback
Date: Thu, 18 Jul 2024 10:07:17 -0400
Message-ID: <20240718140733.1731004-19-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c8222ad-f7fa-4899-a454-08dca7330b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+1GxL+L6AJtiMK0783Ht8ogm3zFUMOIZDTooMhFS5ipkCCP/IPy5Z62HvZhr?=
 =?us-ascii?Q?1toXDfaXy3tWdJbke8lijAVOnrIXnFiXHes6qUOdQpu6q6H5h5PvWMAESCsA?=
 =?us-ascii?Q?ZGWezf0jlYAH9NIwuitZ0cmC2pEnxslBoS4zb4MtXWqVS9OLI6iW4dw97lib?=
 =?us-ascii?Q?VGPgbP8iBrf70p0nVzY6SxmdXGE//TrCtAQU7WKw/8tvxvJ4uWq0UdhBswwN?=
 =?us-ascii?Q?QCugkiCC71Jv0ZCQ8XEryRYA/AndQFj39haBawuTbvEO6tcUIACGS98KmKPv?=
 =?us-ascii?Q?yNyVy/upeo35/nLyPmL3lBXlGaZDY4wwLrPXMlnv0XERjW87k39AgrF3r3Jp?=
 =?us-ascii?Q?kp8ipZcwTNEwlqnTBsqCm6R6/i1jbE5Yz4i3jSLcWzTstocqO6sMcmgcup3J?=
 =?us-ascii?Q?63gENnFCFFNHsyiAgTNcMLN25OG77r9OgZ8TTTGDvneRHgz3LYMfqKNSQYPh?=
 =?us-ascii?Q?x3rZBcjn8EpOi20juZ3ME0BPRFk11pAMhc2dN2AgsQrMTWH1AJyrz/8n/2Jc?=
 =?us-ascii?Q?WJzVzIs5BuM0JbTY6Z5Nenrarz9PwQY7LLpT8QWXQT+mGTFX8wmHyF8MMM7R?=
 =?us-ascii?Q?XEAnc+agYAhlceFmSPGGkDaLo067aSYgZEDps3oukd3o+SgDZcUwqsrdAwga?=
 =?us-ascii?Q?U5SgN7wEmY9UwFKMoENaMNIIBXe8KUxP2oaTHJ2KVIrnav/snuqNRZ/922Zm?=
 =?us-ascii?Q?ZLv/qy90VFz0wbIabuKPJtc07FfceDUs9amp+yJMBUCUuOZV21vnvHAp5h5A?=
 =?us-ascii?Q?FufW2mWU/AS1kkXgTZyZfA+GrNcbj2JvWvgYlprzGgR+7GOrnAZakVuAXHKe?=
 =?us-ascii?Q?KQIZp3txNyBeWatpg+agHBArYxNlaNMOHOSpSLAZfRyhV6UMCLkJ3xTw0ZKt?=
 =?us-ascii?Q?XKD6rbho6xPwkN8/61x+rt3UDlEuCRgZ5rVi2RTt8WgljIa5y7VVKJQZJvNe?=
 =?us-ascii?Q?LaWU43RE+j/Aev8Y9JSG+Q8td/D3Pju4EeiSY/r7x0moQLqEzgA+oD8Lp5pd?=
 =?us-ascii?Q?+NAHhAAEmqDP6bypP98Lw6Rjk8gjHRqM4SuH5HD7CAhANnQ8Fr2XxbB7HsTF?=
 =?us-ascii?Q?W/GbzJFfD6i1Utw21NlyG8nTB4Kv3mXgAtNsGEG2DA/9f8h1MdfCHONJiIVO?=
 =?us-ascii?Q?/5b7Yr95sKOWKNDtCBOz7McVYinqeVWVCMW55pEGge/158k4pXlDcwxHujQm?=
 =?us-ascii?Q?bFHw8ViqMlvJm8/NPrU+2g0He5UrxqUqAoEVKxSI4GlAZPFd0PcDxiXo/2Oy?=
 =?us-ascii?Q?OCfFFhAG8/4Ysa3bu9l6pcJgVqDg9hkL7cz+3L9aGiVaPQ0dWFfuzEkaXzaU?=
 =?us-ascii?Q?cZXNOeLpNo2WUFwiDIk7kts4wRmP50ZGMw3y467Ee3WTPJFjXgI6dYi0n3Z7?=
 =?us-ascii?Q?cVpaWWcKYiMaYcpwixdK1esdH3N2r01++PL7Mvqtp/EYq+rWPvvVNwV3Cq0+?=
 =?us-ascii?Q?6TEGNXo2XtPr54WHPeL+Ta6c2pn8jUEK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:05.1722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8222ad-f7fa-4899-a454-08dca7330b2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
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

Add ring reset callback for compute.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 675a1a8e2515..78495df29b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7100,6 +7100,43 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	}
 }
 
+static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
+			      unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+	int r;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
+				   0, 0);
+	amdgpu_ring_commit(kiq_ring);
+
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r)
+		return r;
+
+	/* reset the ring */
+	ring->wptr = 0;
+	*ring->wptr_cpu_addr = 0;
+	amdgpu_ring_clear_ring(ring);
+
+	return amdgpu_ring_test_ring(ring);
+}
+
 static void gfx_v9_ip_print(void *handle, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -7346,6 +7383,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
+	.reset = gfx_v9_0_reset_kcq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
-- 
2.45.2

