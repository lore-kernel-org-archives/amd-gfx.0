Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0ACC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F2310E6BC;
	Wed, 28 May 2025 17:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LytWLf1M";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5303210E65B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPFmZF7jb076Cb1DcNpb1QXlPqVp6a4QmOoZ9MexGWrBMFJR9H7OHiYjOLXmFEsXQZP/80Pnn4WVrR/q1u6qGbolta9WlmHWJ5MPEZ6w6SyaZ2fYxsyAhb1fIkDzRMM0AgNlG2ANZ3adINujRmqXwYGzu8baVfe+11hjYIZxW6Nuf8hxGEaP7CcsP0moMsAGjEKBs05OLOE5HT0UDSQ+QQbf4jGq4DmZvvXevW8Na5i74RxXDH8Cbqd87tSVAiuUH1pvAxOf4jqNxrcqFfDhUGF1lGKC0SWPG+VpuQQR2nd6tHT+lPUsfDHM9ghYyxzHrFol9Hk9kV3ayVQzTJHV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drsfTVtO6baerD+yH+uLeXR4dngNvakWEdW3xQgR18g=;
 b=I02SUUMEz3CHsM2wx79yCd0f7Iv9UoszHy6oCeuPlEuk4Osng5LKUIzp9kri1Wy7bCzS0pJJQve+nMhvE2+E+9T/o6hdYlNx984GZQwq9d48qZKuJ4VvYUixwSr9NpxnKTBclh0qlUmBpUUQqJ/feumUU5X2DuchrcPUU/Z7465JFOaUre3qCPp74E5etS/SAQIxDGqovU6t+sAOwQpy0jp0DLQHjQA4Wuiv4O+h9grbhpksDyWZUVAltl11Bz8vM04U7lb+bRNvxpxm11mbtZF1Gckslwh3vJuyrlO7NzyEekMBGTyXdTZPkQacfAYOmX5AhRzci8SSZTaUxCJylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drsfTVtO6baerD+yH+uLeXR4dngNvakWEdW3xQgR18g=;
 b=LytWLf1MKdSMLQzEhnNBVfos7O16pv2lpfSMw7Gu+b7NG1WmJgvN6TEaDzBMrXAvOv5M4JMAcCHrWMPwkTUzEwC6sKB0IaiTKkTG6uVgfzBu6aInC1xoYGoXKpehcgr7OoeX/fBDbUgY5Y9LR40tk3h14EmpHsLiFDzw8aszY/M=
Received: from BL1P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::22)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Wed, 28 May
 2025 17:28:25 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::1f) by BL1P222CA0017.outlook.office365.com
 (2603:10b6:208:2c7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 17:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/16] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq
 reset
Date: Wed, 28 May 2025 13:27:58 -0400
Message-ID: <20250528172801.34424-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: c169bb0d-d00b-41ae-d1bf-08dd9e0d0d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bBt9URByxsQIMv9TfSFAz3DZKgSeABMpVC1I/0sqPlpFTZd4oMKB07wKVLsV?=
 =?us-ascii?Q?resrW1DtC0+elyPj3Cib7pQ6dZWg2T6NCweKzz0b9gJ64KlEotTWoTd07GoT?=
 =?us-ascii?Q?cvoujefr+v/ZIKXQnBG+Yw96pA9cjyaifykYYwX1iBje7MI1cuYLFvL3F2Ig?=
 =?us-ascii?Q?AiOXi/jUlaCG2tkuvPlKa6QacXCG80IZoh4HOXuU/fhqAKhaysTsHQ5dLqz0?=
 =?us-ascii?Q?KJiswq2m7o1IGObCSNb7InT/9XTh+gmbA3jUWn9Rr4WXa5eyfPvMC9PKJeFt?=
 =?us-ascii?Q?PKkXYaT036tWvB+UUMefjoVbQ/inFC+ENTXwcKE+er1GNCnDmKeDKML0YvFr?=
 =?us-ascii?Q?GCd52tDo+5oDqSAdoGz1n4CoxGb/g6ufBRxB4D/u6cfHMUMvMzafHWuyl+pf?=
 =?us-ascii?Q?/FD+O4OdkSYqpWOLswhrQupOeFsgjGYYjiaZ4voYw+AA2KnINEzu12o1+1Cv?=
 =?us-ascii?Q?5oRUExRv/2nXbgEoSdFda7w4AYRVawc2MC7G8lZotR2Ztghyf0l8U12cTm3e?=
 =?us-ascii?Q?jCdgo7CzLRAuCDHw7CKWxs51TsktAKs4SJt5XM+C8a/Ehle3eK+/NivsoLZ4?=
 =?us-ascii?Q?2ohYaPwWArlABGyRB4BjjWwrZBIoQfCTaho8p4W500geBayBk/eeS2xlIlz4?=
 =?us-ascii?Q?E17iydg5qbDBuNsMDWSrZV2WxGShiYaJfa55NKlk7nP9E83ZUWGtq1gnjJas?=
 =?us-ascii?Q?wjOTD4ntR2N44cQzRs2o/eZZwmn+SICJO9ZOSUoQq2tvAokoD+iHbsVhiyAx?=
 =?us-ascii?Q?AzCJKFMG0oY9VrLXZVBsdKDXjwDq6ckJhSu1iFPgHqKo8lUlaJvaIEgHNysb?=
 =?us-ascii?Q?TmdFkWjqJmWA+JnXVZ7QVv6NLZuPXJYNSaWPnddS4ddfxyBIZOiGJIzwBJ3i?=
 =?us-ascii?Q?vHfWxzGDu76FVprdLh2LosDNI7L5MVjfGmOFHiG5CKpcczoce2XffxkOSKKc?=
 =?us-ascii?Q?GcKjzRlpZcdU8J4KThxCdW+EX5cwUN1SWmYInlwxK5Umyo3jznY+jnC/duGc?=
 =?us-ascii?Q?yjjskliJBoKj5AaYzyHJNPhJu5MAGu36McaH7egAoMqA4CY8HLLsevW5qa55?=
 =?us-ascii?Q?vMKUE2iD0GTm3EvEdoSjMG86aMcFuJtfLrRAR5TNSPoiNtJ3j9X8B2U88gMP?=
 =?us-ascii?Q?wuf0i42ONjLJVbPFN1PvQbe1t6jAjOt/zTozw1SLu6qLIhzLoXdihdmfS24B?=
 =?us-ascii?Q?9AjWpGIEVsJGNxy8FZyr6qtLmosJCEkTB8e5NEsZcbkU7U9bvcdCcjhO6P6M?=
 =?us-ascii?Q?+SB+YNXDCCg1K148CEX/bcJvKz1rHZhOASb++L2WtSMTkz8TwhM24qW7arCm?=
 =?us-ascii?Q?VfS3e9GXB9aJbEoNQ2IO96nIb2Ywik4+XxKfzlxhvC7RSXKJwKUqOh16dB4k?=
 =?us-ascii?Q?pAp79UXIxrDNh77UqNmHw8ZpUakXuM6bgISTlIhV3yfCmgkvCgweSB+/XJWZ?=
 =?us-ascii?Q?FFb2metTsxQC9i6MYppf5DOwNhSdNxVfkbfTPnfYj+5Lpml2kcH1kF0azOGe?=
 =?us-ascii?Q?s372AEMt1JNjIiCiUj1Nau5tBLzszD1FS0s8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:25.2431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c169bb0d-d00b-41ae-d1bf-08dd9e0d0d65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c233edf605694..7724689c4467e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3558,6 +3558,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
+	unsigned int i;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -3612,14 +3613,28 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
 	}
-	return amdgpu_ring_test_ring(ring);
+
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	amdgpu_ring_commit(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	if (amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
+
+	return r;
 }
 
 enum amdgpu_gfx_cp_ras_mem_id {
-- 
2.49.0

