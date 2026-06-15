Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83F0CD98DE
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F9F10E793;
	Mon, 15 Jun 2026 23:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QCEPlZCU";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF6510E77E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHrpbiT33XUhu2yv5J/l+4R3fk0BM9mfRe0OrFIVrpab5wOgfHsg+uHOO2T0wETjNNLjcAx8QOhOciqBVCoeH2nCqQ57HJGHAc/A4sbur+83T3wJEzEXT0jvzxEhJagpOYk91klT2rH/65q4xlVdgUlF/47VU3gg7RFSXX/Yskhg9fXYFHkxKaMe1Ybvy6zP4hqzXL7lHXtejS2Tm5OPC010RRP1H0ywjN948k95gBa57ecGpAuTcSWlvX4+LXAAV3S8D7cYmqcuiSH2QgPkj9YuEPO4oLWlHqXlWF11V3WYxPTmmPvA/rdEZT3CwHhCAmeNy7tixs6hjdjnZoP7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQiM4RP1bO2m9jYLEwMjpnYCvLDYOpA0OYcAHKgJbeM=;
 b=aBb73qlKBb9q9d0KkoEOSuVQuZcouFNVxGgonR6aV6yKc+09z2TkQ1PCv/RMlpxFQmQRbZd/2BznwGmDt5s9754HEWQYfURgh5nVAgAatFBMaBrQFyskI0jfosa4e0cN3d90MjfbRA+FE//oisOltYmpXKsAF4pRAf9bIknwQeGk2Fy/76C5Ahf/Y01bFESdSTn2O1bkkLB7liLaQgCq8PsRwUXGz4K7p9mC+dQIHcHRH1sRiXeYlWmlPn/qAM9ALnqjegKaJDOhuYIoVOkOhaLFMhmui3AkHiRAqPHQzkj1+DLey1ns3c2ECdJ4AXuvQTzG084Xz3LHcIrtz86ykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQiM4RP1bO2m9jYLEwMjpnYCvLDYOpA0OYcAHKgJbeM=;
 b=QCEPlZCUQrDTLUUSjRNNokr1nseiYLrWtDkvnOtrQ5v7i5qEvHIhk5S/zhKNhAE+9qc7NQoAx8W129vZVW1Jp0zhq+XXea20J9zPrlxT2sVAkzYmTQKJqLU+h5qpENt+8g1ii+XkdKh6gb/x0xWI16kw9cZJD5kglb7QqblaNZM=
Received: from SN7P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::35)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:18 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::85) by SN7P220CA0030.outlook.office365.com
 (2603:10b6:806:123::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 42/43] drm/amdgpu/gfx12: drop all BUG()s
Date: Mon, 15 Jun 2026 19:56:44 -0400
Message-ID: <20260615235645.737189-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: cf15cdbc-0b60-472d-d4db-08decb39d4de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: PJm9FY1vIEssJP6FN3Q1Q7wP4k26764GGtFO4kEATeKxSe9WXaKUDtBlUPajQ8lexfBM67qpop4f+cVsB/NBDLHJ6SbhKswwfMYGxrBdTngi7oJbRzyK2FWPmVJKUfNpOgph9lYzSbgFWKt5lrL1DLWl9Dw5duIiyZX8Nqa5yY0ugLdMkdyqbrwADxCUUfqJL7Zipw1khSMCJMb+t4O492Vu/frjfCC1ZsnTic+32PYVg0lBeeO79kJixQBbJbYpmfOfxONCpf0mUp6Kf6+U4BRyo7DcSOMc611Fs8UTDUDTS4PjBbRtoKUK7ZffNNhuZ501bDPT9v23EHrRvDQUk8ny3RLp/4Rlc6U7cn7KJrTYjB4A3ZwJ1ujDdiCuAw/9cRK/vaAAMFwZFCkrzdVFj0wBrp1xzomfxZRS8j/nqNw/Zk3TWp6m8uEINd78uLBwufYjZBisE/GX0nUnDWlv6hXE0XS/5q/HcjbsmGWShMq9R+lTWQlJ7HF82w1+kC1LE0BwwTiaV496oOA9W/bSMrTCm4zGx322UyxAoYedJYAAckyjcqONnb9WSwTIvjhblg/uj7Z9bn26Pn4VxgozNhKhJXtL85EtKpRAbO/+zb9LuUgSNc9VP7yRMvb0A+SwoK8FlVtWDCVaJmpjojQrlLn/K6+fHaHsp8zAkFkAQV+kavyBZ9IMlacsDCYIKH7FBgmAyXxi7t54eurOZyDq8LRD6OxNtKg4I/VK5CP0d0M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pYp4WrC7eaCOavACD+++i5He6ZNqzBJ6N8SyAxB5e/eXkSYxTiGOnD+F0PN8r8nXnX284wXiVf33JpBaxvOZqXic+AckU0bMbC3uN+R+LY0U4V+LVbARE7a3NGnr3v2llYQ6ui5L1APofSJv6+QnZMzkfeqCmSDo2zp74rbS4F9Ynpm4gjwRFaqn9SgPvIa3IY2CWg2r8R+VkBx1rLkB/V+Q0h+P48WJnZnYJWudROBWZDWUqqpUivqu+jDiBogfTKI++haiar29U8eK+HCcujco54jhfqPxy7g2BmdM/FhcCFrAhTDjVGBYNVFU9J/6Xhw8QZde++bMGsuUlLSBCNSDrVox93TDCPXKwsbRwVcx3WWzxSL2zfu6+C+Ou9k3Bcdq7PyjFBCGCM0FInjsEcxHBKkMUs0HvLz+6JTNEGM80CxTPCv86RJfdiJxZvr1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:17.7482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf15cdbc-0b60-472d-d4db-08decb39d4de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a5ae91af9ef0f..51c384e6cc6ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -964,8 +964,7 @@ static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
 		break;
 	default:
-		BUG();
-		break;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -4455,13 +4454,16 @@ static u64 gfx_v12_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 
 static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "gfx_v12_0_ring_get_wptr_compute() requires doorbell!\n");
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -4475,7 +4477,7 @@ static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG(); /* only DOORBELL method supported on gfx12 now */
+		dev_warn(adev->dev, "gfx_v12_0_ring_set_wptr_compute() requires doorbell!\n");
 	}
 }
 
@@ -5048,7 +5050,6 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 			}
 			break;
 		default:
-			BUG();
 			break;
 		}
 	}
-- 
2.54.0

