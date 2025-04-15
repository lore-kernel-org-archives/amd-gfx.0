Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCE7C369B2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 01:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A9210E325;
	Tue, 15 Apr 2025 01:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cLlnLS8H";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2950E10E325
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 01:32:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwrSzdm+9U7XKFGyP/PhiQJnmHfsVb6BdvozIA7fPflQI2DYfoCbnwmhPaluJ/TdS+Or5ecb+rHIRTlGXiG5wYhRq3giehyaN/Qzt19TgRSg/vIsL4lfzcKj0WIZH3+A81Mkhj/EFe+TeTx5/Lf+UK+KD1CSMat6sMR47ulmW57vnmWFdd8eL0nCEeC+KZ70eHVsLOWI6BtPCciRSA+1UYp/nNYboF4bEsZhE6pewEdSlo8NmbR5C8X9QkxhA8OHSMxD86Lhj9Mtl/dGzgpG7uUPkBWpt8XGRiodr2jftZrKK5g0yEOAHrMAcvEjYRZFVkDLPUiLrquapyNO7GCdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzXNUSbXS/+JQ2g3wcYDo5Fa7h8HraPlk6PyJl75464=;
 b=saX+4yxqq/IE5iQklNiVM0V6tA5rlAbfyZRqXB6D3zAQLdvaNEwqLHOy2cOZmepaMASunoWvKFHCjMfKZAS8YOh2ZpzrDg+/AgIWRPytTWXuen/2mLC2OU/eJ7g6Rdt0Za6d8qPsWHDJIafcCbA79qyFGVQNbsHMv4EzZzdD5oaJJA8QUz5+GV3oRDh4OeXOwKaKxbtosWOKPMD1dkMhQ28YT5B5at4asH4lSy9NXGTlQQbwWLCBvKY+5pFcr1LRTYri35G/wEOtKDFIUgKRiyT/yfXxAcZiERmBM8zQQ2MO2J+gbpED5g4UhH8eis7dDheDznDgrS6QxDDPYQDyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzXNUSbXS/+JQ2g3wcYDo5Fa7h8HraPlk6PyJl75464=;
 b=cLlnLS8HzL3Gcu6GFjID+9ITHtgH8L/pRH7oWoqTyRnr83Zu0TcQWAGQ+TxKcnV3rtycD1iJdd5+0u7MivtiJxeFRF+xMKze9EPQF7ai5yR2KGYiXyYjpTdBq1AhuKjQ72//6p11T7UWiA1a65V16ycN2y6BK+1icFoasezSnbI=
Received: from DS7P220CA0072.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::16) by
 SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Tue, 15 Apr
 2025 01:32:41 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::23) by DS7P220CA0072.outlook.office365.com
 (2603:10b6:8:224::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Tue,
 15 Apr 2025 01:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 01:32:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 20:32:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 20:32:40 -0500
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 14 Apr 2025 20:32:39 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v2] drm/amdgpu: Clear overflow for SRIOV
Date: Tue, 15 Apr 2025 09:32:32 +0800
Message-ID: <20250415013232.1105469-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SN7PR12MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af8188a-810d-4fbe-7205-08dd7bbd69e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?45F7L0sZFvyvKJqiJZx3D0p2k2nolUekgJY/J/zvXaRDRMQQRZFi+qxvIfBf?=
 =?us-ascii?Q?rqDHIaY+ZG+MFxIb+gDc7UmZfZP9rmypv2Meu5r9n42xMvzWUn3KVHtvdko4?=
 =?us-ascii?Q?NCXASpWQMhm+xMQ3daB0jfDj8DbJmWsMqYeUw2eGeE3t05OgFupl5SbvYv18?=
 =?us-ascii?Q?zjdcjUUZfOxJ08RMWaJr57hCIgPJJY+S3/IYJ4mV4e5m8ASCLZykgK7BXK52?=
 =?us-ascii?Q?poAVg9dDgi/nf1JVSl6NlMpxcMO9Mguf5i+vo+Cze4vqQYgkKlBdD/zqGwe0?=
 =?us-ascii?Q?69ZUnKCKog4/oZrXDkqzaFPeVqsDNamTRS4M3HWPYwolestjLCVCO7HJRDvR?=
 =?us-ascii?Q?hi77oopD1q+wWNYDe+hdb73QR+sxImnFcR96WPsqZoX1RuaTsK7pQbezCaD/?=
 =?us-ascii?Q?oV2x53HSkTccH0p21anpdwvE+kELCsVAdpg5lQeMPPmopIgcpXRXnmzm8PMK?=
 =?us-ascii?Q?2GZgoN3hmqitY9G9kfRh9mA/8n+hUCC4pGtfPOouxykBkYMTtQ/AEpvas2qg?=
 =?us-ascii?Q?6yWCxcqakiUzYI84rxbHMUJFdmJcW+2GP+Ushb5oykFYM5kjcG3ZkvLz3FCC?=
 =?us-ascii?Q?KPqR0pSGKOkylyoez4Vqkue3wtM+qh9+tNj9lUWbrDAki3o6mRz67YW9Y2PO?=
 =?us-ascii?Q?cS+qsFsXRpJX2hxuNC8/iEyYnvKI/dinaVG8EnjL+ymunJdDSVBxznGe9id9?=
 =?us-ascii?Q?sAcen4MvWfSG5OU2k2BYL9+6QyThcQ415Cwjf8mZ++cOBE1dunkf2JlRnFcz?=
 =?us-ascii?Q?t6gPTnaYqPnBPQJUjOga9v7UFFBb8b0COS5odQAxNc3ga8ScQmJckaWhqOEZ?=
 =?us-ascii?Q?26eqXtlceB+7e3J2+fm3zUk4gdzDu1JkNwK97Hi+LY2XcZHD2fEeWRbzGFeF?=
 =?us-ascii?Q?4dgq0kzgPAi+lkSi1Y9Gkiho4EDwbWsfgwLs1PS84XbtujmTvAJxzsP6hNFy?=
 =?us-ascii?Q?/Yc5/V3BBtVWPJ6/xJgTizJqa2xNBuNWC+uMdwjjnrKV81jzSeNxlka8tvVC?=
 =?us-ascii?Q?6VQwSEFoNQjWFn52E1nS7LRQvAlhbWxoGnVhcqY2j7dO72g2mEkctCRxNaDj?=
 =?us-ascii?Q?ZttRxnmUTrK9vqPyfhP3faypcjOOU7fe426SVIrxrbcMByxT3Glt6iznJI8p?=
 =?us-ascii?Q?iAAbPY/mbUeFK8N/Upq1/Bp0dBRGEPRVhqcJrNX4M+g7ws9RTpG08MLYBZFE?=
 =?us-ascii?Q?Shelii/mkcKxd4nyjMZKEJkCiCko9oTtoLEhv+RI5f+k1V+pTmrpKIh+7Nxn?=
 =?us-ascii?Q?AHWh+Zq1lqkWCRY9oqd/cly0wYyhErTB6zhOAw6Cp73jwlNfhN6YBDcjCjTz?=
 =?us-ascii?Q?bd2pwyxvyvaRZ+6btLRH19NGwUoJijIBksub5OsDGgF9HvWfAQKkigVdqNcm?=
 =?us-ascii?Q?XYBg+uLxSYCpCQtzrdIUyRhsrfIe8bvJQQxZjUlFe/S4mcBEXRUdJRu1ONS8?=
 =?us-ascii?Q?Pat4J6B/n6XokJgBbxw7QwB76GHMxKuFD6+IXswKbkNUsQZATRipz9u+HpIX?=
 =?us-ascii?Q?U6T+SJHbxw/id5BoDuknEmTL3G3k5faMA/LE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:32:41.1417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af8188a-810d-4fbe-7205-08dd7bbd69e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603
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

For VF, it doesn't have the permission to clear overflow, clear the bit
by reset.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  1 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c |  6 +++++-
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 901f8b12c672..30f16968b578 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -25,6 +25,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ih.h"
+#include "amdgpu_reset.h"
 
 /**
  * amdgpu_ih_ring_init - initialize the IH state
@@ -227,13 +228,23 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 		ih->rptr &= ih->ptr_mask;
 	}
 
-	amdgpu_ih_set_rptr(adev, ih);
+	if (!ih->overflow)
+		amdgpu_ih_set_rptr(adev, ih);
+
 	wake_up_all(&ih->wait_process);
 
 	/* make sure wptr hasn't changed while processing */
 	wptr = amdgpu_ih_get_wptr(adev, ih);
 	if (wptr != ih->rptr)
-		goto restart_ih;
+		if (!ih->overflow)
+			goto restart_ih;
+
+	if (ih->overflow)
+		if (amdgpu_sriov_runtime(adev))
+			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
+				   &adev->virt.flr_work),
+				  "Failed to queue work! at %s",
+				  __func__);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index b0a88f92cd82..7f7ea046e209 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -72,6 +72,7 @@ struct amdgpu_ih_ring {
 	/* For waiting on IH processing at checkpoint. */
 	wait_queue_head_t wait_process;
 	uint64_t		processed_timestamp;
+	bool overflow;
 };
 
 /* return true if time stamp t2 is after t1 with 48bit wrap around */
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index f8a485164437..8d3ae88b96a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -349,6 +349,7 @@ static int ih_v6_0_irq_init(struct amdgpu_device *adev)
 			if (ret)
 				return ret;
 		}
+		ih[i]->overflow = false;
 	}
 
 	/* update doorbell range for ih ring 0 */
@@ -446,7 +447,10 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
 	wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
-	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	if (!amdgpu_sriov_vf(adev))
+		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	else
+		ih->overflow = true;
 
 	/* When a ring buffer overflow happen start parsing interrupt
 	 * from the last not overwritten vector (wptr + 32). Hopefully
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index e9e3b2ed4b7b..2ad209406d17 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -350,6 +350,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 			if (ret)
 				return ret;
 		}
+		ih[i]->overflow = false;
 	}
 
 	if (!amdgpu_sriov_vf(adev))
@@ -437,7 +438,10 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
 
-	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	if (!amdgpu_sriov_vf(adev))
+		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	else
+		ih->overflow = true;
 
 	/* When a ring buffer overflow happen start parsing interrupt
 	 * from the last not overwritten vector (wptr + 32). Hopefully
-- 
2.34.1

