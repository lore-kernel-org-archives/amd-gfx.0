Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1DEC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 06:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BE210E12F;
	Wed, 15 Jul 2026 06:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i35jLEzZ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D50810E134
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 06:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pD5yRPSsT/6icaan5d3J/kgxQzrC+hDZqUt1/WkcuShz+4r5u0rSdONlLvLmfa9mW9R2OvtOEVi2uvJQIc5V1SIlaoSEeKa78Sau7DZBt4t1WwMazmzXeG1xPOprg6Y9VtQLf/Y7QerhmoyVDD+zmjpuVAK3VnFyvSnNKssO7j+SMbFedZ45S78rrhTbpIrVXDXkUVxEaHWyxJF1M/sf77BBtsJtPmPGvAXzi1mAUsfQMikXC+x6R4g43ihh3AbEvIwq1H6KNS6lT2NCi3JO6KUaRnUShOAPT2UQUvwAw5INpWsI/rs8bKu3tsPiZ0ojf8CqS2wqW2Bb+DuzeWrWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1DjJb6XAQu9jlZX5nywVvJBMuBgONuD5mE+dOqqW9U=;
 b=WPPqoDySFZjj3gI5fTtUf+yk0ddFLWeBv4nmbHHF/7dfYoIu1O+Yxv7B4kA7uYH3dBniJnVl3se48KyeL8pgC0zHYLmJyRtpXl/GQMJVs9y3NLEmYWXKGw+ZVvVKN5pwDLLNyhgHo3FIWfv3qY37aXOlocvIAhwLY6qcABZb0p0E5Cbu+zuYf6idDKrSelCoHOd0tt24hE5Rk4a54pb97zpmMXydeMn5rL+DPAULbFGY6NlEKF130kCH+LKmnpnUA+uNVS9Qqs/KIuoKBubFrqvlK+TpjX69K3ltzLGdjLzbsMrP59ljm6KQDQaHhWqrShXl3Bg15jCD4ym3wMrfjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1DjJb6XAQu9jlZX5nywVvJBMuBgONuD5mE+dOqqW9U=;
 b=i35jLEzZNDoGoh0PA5sUOskeD8Ma/YdE+HTZtfPxN/m5gvP1sJs63q/uW0ce2Nv5Iia8TzzNuUdQROaaGRlcslBP9jQP1sQAc9qo5+8k/q+Ly+BUxCNUgQ8ndNrS6d6hSCLw287s8UQgGeflYLdfTRm7zDVEqBNjPOuQuWQ2xXM=
Received: from SJ0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:a03:39c::17)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 06:33:50 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:a03:39c:cafe::6b) by SJ0PR03CA0342.outlook.office365.com
 (2603:10b6:a03:39c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 06:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 06:33:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 01:33:21 -0500
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 23:31:37 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute userq reset
Date: Wed, 15 Jul 2026 14:31:27 +0800
Message-ID: <20260715063128.581232-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a7fc88-1683-48d4-5004-08dee23b07e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Lt7ZdzsZidHbq8ouV61Ux34NQD2IBUJKth2Zipwl5hrdQcgE/gnlD/abtWlWnLYtWvUDZUyDhKdnxWu8QsYFdz/Khh2j4SEhX6ZREKfYCBUBAaJ4ExyyBDVVAcr2J0NgI/q99kLBR2YBOUtNwaLpHdUHIp3pc5GUYYHhxOdfIU0GI0EufM50JIMgstpNLjd/1sNe7TWI8sS8Fn+2l7P66nbPnr9l3BZYIVDL+y3yLPEe49lmdEVBFzOMzrLTzat4mzqL8LstaojeCJt2jeybzlGIzlqpt/t7+SYtMPCi4TAmMbiD+KjsqTJ1GLIOFrJdBKERbLO0ww2hBG1OikS8YOFfnoQDGrZA+lieBh+ftQbi6Fxo1HnbABbPKXOL4PQARG8aQXwzK+NjCgOs3ZjaafWrpJcbAoCBemzeO2Y2AXZdnF1kPMnMeVDieA1VxkcvB4DRgTJFMz22rH7W+X3XaPh06QcpRqTybJwr30V1xalyvXLm8BeXwzoWqkD4R9BXGew9+tNLXH3BIxeKtYPOzIeXFSzNMKNDRqKd8QFeh8snjl3nLRVvazApbKHrz0kvFXMKxRnttD0YnJaJCoIMzbvYKVVjC4iyIXNZldq5QG+giiBXLCUgmLKmkWbnpv4gedwTRVvH31C3xGDsrVHxX/g4CocVSd62KKZcek4ezHdtFzEmgoIPGTtw+F+d0SVJUk0LB47HeyECUDuulklosg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iehnNwYL0MfEQdoe6ZwV/EAHZVsBUzQ0Y1hy8Myml2lnUKW7k4dyVGyH63ILjmq+S5YdW9p8CzauRMl484ODrEBSVVp/cq8y5kJTv0AyLsFK6F4rF/rmdQQZdK5ZOeRNVzO6AX1FZgYbEsfkZirpre8rV3w/HnAirvc0GwC0h8LvocnJTMzFMqLi16XP+GQLhPoL6g0BPtTFfFI9WiKANrC1R1DQ6x0y2iKjPySLYfwQa+RM95Mv9AnbsXW7h4Wb2/WUM2enQSIAu0Ub7fN0NJZHAD1uMOXQkawWrelZQYUzB/48IU3KICa2IoyKH1uK+Amd5WIHYDZSvUW3BU0JhZ5SxvrhTbYzI3V0Vw9juKVVeAwkqMvPP7IyRPEt4U9jkmDO424raiaoc32ffGBsaYbsZNOeJQ4kpOIEavcRoIAUrWtbpc3YH+0V26GeM1fK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:33:49.5420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a7fc88-1683-48d4-5004-08dee23b07e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134
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

amdgpu_mes_detect_and_reset_hung_queues() already detects
the guilty compute user queue and resets it through
mes_userq_reset_queue(). The additional reset via
mes_userq_reset() is unnecessary, so remove it to unify
the compute userq reset.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 5 -----
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1e275c2e7dd3..4f2d5ff2f7be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2315,11 +2315,6 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 		deferred_end[n_deferred].fence = guilty_fence;
 		n_deferred++;
 	}
-	if (uq) {
-		r = mes_userq_reset(uq);
-		if (r)
-			goto out;
-	}
 	for (i = 0; i < num_hung; i++) {
 		struct amdgpu_ring *hr = NULL;
 		struct amdgpu_fence *hf = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index b6bfa3974839..fab21d4275f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -226,8 +226,6 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 
 	xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
 		if (uq->queue_type == queue_type) {
-			if (uq == guilty_uq)
-				continue;
 			if (uq->doorbell_index == db) {
 				uq->state = AMDGPU_USERQ_STATE_HUNG;
 				if (use_mmio)
-- 
2.34.1

