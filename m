Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2DFC83F0D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45EB310E53B;
	Mon,  7 Jul 2025 19:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AKL/o4Gr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E3B10E531
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwSHyXxaNhvSu2AXhkuvcDPVjuDF6jITb4zpLV8UlknT9NNlPM9mMG4oUSJtm2A+jAC8iO43e4hdcddKVGfI/wmFz3TkgvmieG+YSDjQY0WcdOnwLc+881hZQT2lOS7arHOQtOilbc+yrtKf3d58XWwrr89kXWCQxFc4zWXIy7RJqxY3q1QGS0da4eWkes02Yhye7n1VerNjHoQPygSu4NVq2e+3J6X4ZHsD20Xtc6UFOWU95XbCHEJkul8+G9NEA65GkQrk3UCZk5NCtrl9Dy1P7EFryTBle/anN1VLWMl4NVe7AR0p7R93RQG2nRB6AmAdqG8iZIY4hWhO+RbTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46E8nH9sWDvXFo/ZSzwpwdIYcye14AJ8ItNoitZ42MI=;
 b=BC4OaBs7aSE8JtZ09hKsyPmMkQ7HCdeuPFhrXrvNGthaLKDNpOd9BZE9DGcoDw8/CU0nnFCnyRcr6xL/bY/7C2ZTtl2KLyGmeLa3AR1c8b7/9YMPBvINVmfSV5+zPXBeWIBBUbuZeEBzOTd1jorOCdGHHfi14Kztqo+xxvUAqwS4m65n0Rl6cFdPcKK1LuRZe6bHVscgjkGxCPBDtjon75qTBt+zFvwb7WYQEpfuazErEru3s0fgCXgo+fAbGO1JLmtTZCOXR7Clw+VvUFmTjVLsrGsrUNIXnIOubKgnEP1le3XoyQPcC073PAkCHurUSW5DIgkUNcmtmVHHDSemxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46E8nH9sWDvXFo/ZSzwpwdIYcye14AJ8ItNoitZ42MI=;
 b=AKL/o4Gr1YNw7R2pxhBxJnOXuD8PUjUIGtTehigxsH1SGoTrjCY0V0Jgi5sdMiTRdm4xR/UShvoOddiXGVZ+ydA6IzaYS7oZHj7Gw9K8sIjmj0rHLZFk6XM4/gSeSSev7IElFsNe3A2PZ3rExha+av0qiy8wOHUF/cExq0n3LLk=
Received: from PH7P221CA0071.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::24)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 19:04:30 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::4c) by PH7P221CA0071.outlook.office365.com
 (2603:10b6:510:328::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 30/36] drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:49 -0400
Message-ID: <20250707190355.837891-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e5820c-1d08-4add-f42c-08ddbd891a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HQRVb4I93NcrULVWHRv18PnGKK5XMoIw0klxv5b8z5NauOLWz27AE6f8cJGo?=
 =?us-ascii?Q?KGoUx4sxjlCS6hXNVJkRHHZQdQdUUfaBMzuPCVozPdT+JjjPkS3pvMaEk/2w?=
 =?us-ascii?Q?DfnqvQEQN1WhpFGYIv5XhVoSLKX9eOMw4sRk7aFIlREr1wHJ02tTqohLU4uD?=
 =?us-ascii?Q?PG7I92DQLLt7DV3bxq3VzcKgC9s+W9CRwiuZNlXAG8sR36jab1Q2Qc0rvafS?=
 =?us-ascii?Q?6g9w8LLYsyA8OC13eH8keF4xPJsJyrZU9PHs2WsHzN+NimYATR5C4a/FPDsO?=
 =?us-ascii?Q?2ArIPMBn+SYw2WzyxagcOFfgvAUXDmkR7ZNkSE4nUsebFqKCoQEFO4ajJUd4?=
 =?us-ascii?Q?X/gUu3+REW7oqu69DIpKxWNTtBqP/P3pE7d2fJDBkq5lWhriOh/D+rcW04wr?=
 =?us-ascii?Q?iy8VqH/47360+muDmH5b/JH38OLWEGmvVGIsbVPCGSuKmWFG2VMom9hOkqOP?=
 =?us-ascii?Q?fnpudUmvLKTvyh16fkSmMmg4ChCIiSzxzivmVuy14nMLvp0EPSveXNJPy6iT?=
 =?us-ascii?Q?oMvKdjJg+nglm6Ff0g8Ji9qQis/o+3rPRhI2sGhqTDDnk6I8E8CoYBAcFhfS?=
 =?us-ascii?Q?r8HU04ihqoeUmxLwTwLw5bfog1WgnUxT3vab9UPCN6V163eJ5SqH6JlPe273?=
 =?us-ascii?Q?DZgGvBX8EOBE0z/UYSfdZ0rQe3almYW8REySHAqMZm5+09352w3C5YW/IinT?=
 =?us-ascii?Q?j9QnniJRF6NT2EYajp3IkDsFW1Vkj42n/dpIc5tm1p2cHAjIY/jxQVX9QWu8?=
 =?us-ascii?Q?I/godkuLtl/VgWp1AR4LmgNqTEgULJxdkdDpjgj1CMs45lz0QZ6yMtVPweoQ?=
 =?us-ascii?Q?9Jo2ZUgRO8xqkmwTE0xQYJlhrR6LsuNjuWF6hozytGjqMZh7ai1WdSPVvVYm?=
 =?us-ascii?Q?vmROYPR4q4xLi2836Vp7kVia7/r7yYgm2C2tcecbdWJ0zwtogbcSVP6BtDbz?=
 =?us-ascii?Q?yCkfvLLxMvaqC+VZfI2sMCNNlnaPCZmtzkgF/6KIYtlj2Z25MCdYp+sXsua0?=
 =?us-ascii?Q?i4P0QRHPbdH/+LV+RpGx/bbrECk8+AJrK/e5WlyxXPQyvPoAfY1ekK/p1f8y?=
 =?us-ascii?Q?aP7UagdrwaF01qTAZLEiQjkBfjPxNzheaDZ3FANUFSLQ+bsq1MP6UfEFMbMP?=
 =?us-ascii?Q?70c2ktPFeX4xwBcv1k7zo3/18/vl2UHvU7N3/B0PclW3rCKUJkPpG8gkwo5Z?=
 =?us-ascii?Q?B8kipQ1A8rH9oA17clkusi8sTZWgaHDPrvBwBcKfBbLW2kyV9a0Yp1E6iDfH?=
 =?us-ascii?Q?Mf9ogz7IFncB94iLcEIE9eiwFIwWIU/7Czh2f6t7Qgwn0yIWSpXZaA/q/6Mx?=
 =?us-ascii?Q?LZUFQltw+VdzOUybhOsGSEbyQU4Nmq4IgGu9Z/jaThZux4XhktOFjClom6XI?=
 =?us-ascii?Q?Z6hDXGWlGP61YqkkK8lbggNKtyP341DpZ8mewX2hhIxQAEtbKOAurbwb+CF/?=
 =?us-ascii?Q?7DA1qzPGSd4QLpqoz9GC36oDQYZRNFmbAazaq0Zjmf+ptgYNfQoUtCzHEjcs?=
 =?us-ascii?Q?i58XVeyLg7oG5Zqfbdmw2Ldh6+pWpw3UnJhY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:30.1675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e5820c-1d08-4add-f42c-08ddbd891a19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d8fd32c1e38ec..3bda19b92cde7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1609,7 +1609,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
 	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
@@ -1624,12 +1624,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
-- 
2.50.0

