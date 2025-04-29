Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720F0C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 19:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD6410E1A6;
	Tue, 29 Apr 2025 19:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pAmMpKKo";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8648B10E279
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 19:30:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUXHVEwwelfFuBr4N0cENz9vxzr0u/tELobtKHmoK+MwMSyX/vVc1nVTQDnuKvJgK+FdRo9Mk39o+HGEXAaRBQvW1wsGegHoe+kR6CC21teiDYaCxpBHaEVE8DMTpHO9cmirZrthsIUo4FF5FQAl/1RgXFy2geUxGd8HK3KbIrByC4WajmAkI2KbJ4uVgU18ok2fnk26YtuWFyb6/smgValP80w1Tty2bkNsoKaHK5mgdOrcQaOdALERa1QqItLgQle+Ds78DXoj7F7n+vKPSabmF/t18YAKfZEX+VGQFI1IIpSA6jm6RuANe4E/HzpDkzWK0RRfNNhbqaXr1nTkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAr6wcrlDsxGVaFt1W1eGARv0IkaD1zxBLImC+OoNA4=;
 b=V62kmt4GgsckjMVc6q/7nO6Xq+P7VGn2B0T1hA88JNhQPaO7/VQtOwOYBDe9DCUUntLfNZ1KpRfqXacTUhmKvF2GtaqSsMZkumIvipDvy/JAAB8pDQitJmbV9I6CRuuuoSjM5q3MKiCiDQosKnNtrwjOjeF52tjjv0oiS28Gh396bumfhRgNlZFriiFhg73Tmjl0p6hMVCyafjzwvc/ZHpEvDWxxHZg39ny6cL40NSAMxN537YMBRcYDi27JY7yag7igWphw0ixL7aTaARvu1r1VSg00lxX7qNMfFRokH/9kB5/EQsw2x5YOt9vnnmxg29pQi6jipvslxeRrefXoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAr6wcrlDsxGVaFt1W1eGARv0IkaD1zxBLImC+OoNA4=;
 b=pAmMpKKoumINa+CXhLoLB9+UjrIMgqWVyMkGaKLLO3ADdWYWIMpuoye3NVFxaf0cmhUmEu9in+NZh43yNoUVDZogRnGZacuc+EOmpDr7+ueBqFQ0v0SEY+D89F+qGF4pl5YdLiia1/dbSOf9lYiiJTDoYmjlGRVsEyEQhpeYtKA=
Received: from SA9PR13CA0031.namprd13.prod.outlook.com (2603:10b6:806:22::6)
 by CY8PR12MB7539.namprd12.prod.outlook.com (2603:10b6:930:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 19:30:21 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::6) by SA9PR13CA0031.outlook.office365.com
 (2603:10b6:806:22::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.23 via Frontend Transport; Tue,
 29 Apr 2025 19:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 19:30:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 14:30:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Michael Chen
 <Michael.Chen@amd.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/mes: use correct MES pipe for resets
Date: Tue, 29 Apr 2025 15:30:06 -0400
Message-ID: <20250429193006.1931477-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CY8PR12MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: d2451dc6-87be-46fa-d058-08dd87544728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4VXFTdWjQ8EY5gi3fKUd6QNcFN2tLGE17hTmCpy0r8VHcaxlGR001P0TKHLZ?=
 =?us-ascii?Q?Yzcvqb3+yK1asMH7whfMMNrGK22/R9yeHZJQhv20t6u4nbv2o2ItbRhtXxB8?=
 =?us-ascii?Q?PUWBm6FdnI9HChQYghOACB2ldFsuEj/HvKnXCEj7CSio76OMA9pPzVhsCHgl?=
 =?us-ascii?Q?OX3Gl4u36Ko10yYUI7te2gb6AZ57YgkLUf6VHwBTSNzBiLPI7BtADs4kO9II?=
 =?us-ascii?Q?/NsAZ2fjN2yBkg7IIjx2bAOAJbdcsMW7YagfrDJc9cGxNSE6LBIGJlN/hXxs?=
 =?us-ascii?Q?Z2tV1hjHS8BlmHRbzDCGd4DvLsnC1PxHmmHcO/4Y4ZdFzypfzF7Rx5ncFlPf?=
 =?us-ascii?Q?5HkDASdxMHNjxkyoFmc6E0yUJea/Qm8Tz+sOb6UGiHxeK1br57hqcM84FVG8?=
 =?us-ascii?Q?Wlf/9xmBTUv2U2ZQWsXpWyVBfh2yuWZZ0plI7SE8MUG+o+YrJAkg2B6kY4h/?=
 =?us-ascii?Q?w0HXKYWmlts0WWh3GMTz4nTDc0NDJ+2Xf3Hk5Izt2nChVhBNOYjHESNLp0AO?=
 =?us-ascii?Q?hv/W/oSBjxtpksrRHzzS8bD5ALG8nvW/vyRUIxwsSkyoPLnHzRF/yg4sJoMh?=
 =?us-ascii?Q?OKZrCkrE2wcFOK8n1xjXq64M38ecuhQt3jWnhNBNJfdVwkd1gqubAm1/ynq1?=
 =?us-ascii?Q?wlBAjb3r6DRFKWs7xkqEVncOhUp/LBfuel/IBdxCW1AUUKbpKKDzcZ88Auku?=
 =?us-ascii?Q?/8Y5VNl+mXEFKFXeeZePuVPRZT3FbzrupslwrY0O+IjTsaTzADyVzt1itOGc?=
 =?us-ascii?Q?H25K1pp/SG/z5HADIGFXPObox6E3a8G1vaobrOzJ2p4U1K0yiwaU0Ock7TTY?=
 =?us-ascii?Q?e1v9UbBPvguGD3zwzuW4xdgMNerk0MQ4nuh6I/O74yOFDOEmO+HP+h5MVULY?=
 =?us-ascii?Q?/ENbs4nQR4Ancf1UarEA6kWymgnfbEZPyhzZ93VTh4qN7Q9m7E3gtV9abqsM?=
 =?us-ascii?Q?ZKntcbs/uBYlydfrgMWlOpNy6NjnqHHnXsNL6LIzkYrVzNKhW/MY3m3ZEJO2?=
 =?us-ascii?Q?T2GtOwNx/Xk+7NJMKw9u1Af5XxTT82PKPJYJr2gVYi7i4Ai0272+6xq7K0Bh?=
 =?us-ascii?Q?hdrN9WP52Mq9da+sEotVNUmhWsiE8lX66LH9zb9Oxq0Ipi9B3x4o+BKa7fHn?=
 =?us-ascii?Q?8e0XqcHvVbI29cUQTp+5ipOoVH6x6SfjSb6DP3IIxS6mHhskCm73J8fssTZb?=
 =?us-ascii?Q?hoPQ+bN6rz6UTK3Ui/OmwBwJpAY0iBClXCnWlArDKBi2STczmvY8q4HPGled?=
 =?us-ascii?Q?DZmYGZSvvtGMLeE90Z4qci4PzbaUHdbFOwDkcMPrGjxS+u4zX37BwRcKuTE1?=
 =?us-ascii?Q?WsjvSNyIw9EBSEFGerhsDMjAl/cvGmvSxWxB1prCd/ufpzuI++t6y4FG3UXW?=
 =?us-ascii?Q?xrhLmFGb/d5JgzXWaM5IjVwXL/p4PdxnEsjFXkci43PKDI4xgEsGgRW+ZKso?=
 =?us-ascii?Q?TTOMlDmaXBS90TK/PYqBo29Y/mZPDEHBDIrlxDVgVXZ9cp3N1n4OraIuDIVl?=
 =?us-ascii?Q?vA/Rzbr6GPnYkoN5LDnm1itWQMfAZNscsiZ5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 19:30:19.6760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2451dc6-87be-46fa-d058-08dd87544728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7539
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

Use the KIQ pipe for kernel queues and the SCHED pipe for
user queues.

Fixes: a82b069d9eae ("drm/amdgpu/mes: consolidate on a single mes reset callback")
Cc: Michael Chen <Michael.Chen@amd.com>
Cc: Shaoyun Liu <Shaoyun.Liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5de0d6c528f4e..2febb63ab2322 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -349,6 +349,7 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	queue_input.wptr_addr = ring->wptr_gpu_addr;
 	queue_input.vmid = vmid;
 	queue_input.use_mmio = use_mmio;
+	queue_input.is_kq = true;
 	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX)
 		queue_input.legacy_gfx = true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e98b0d892a593..a41f65b4f733a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -277,6 +277,7 @@ struct mes_reset_queue_input {
 	uint64_t                           wptr_addr;
 	uint32_t                           vmid;
 	bool                               legacy_gfx;
+	bool                               is_kq;
 };
 
 enum mes_misc_opcode {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index f9f2fbc0a7166..b4f17332d4664 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -869,7 +869,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
 	}
 
-	if (mes->adev->enable_uni_mes)
+	if (input->is_kq)
 		pipe = AMDGPU_MES_KIQ_PIPE;
 	else
 		pipe = AMDGPU_MES_SCHED_PIPE;
-- 
2.49.0

