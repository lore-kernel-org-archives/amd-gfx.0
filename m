Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16860C55167
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 06:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F68710F15B;
	Fri, 31 Jul 2026 06:32:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K9Swiucl";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010015.outbound.protection.outlook.com
 [40.93.198.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA6D10F15B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 06:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AExtZC/gXb5palXz0i5tA6RWujqce7LKQsgVWax8Rh/wTXgaFeET+T8ESRmxxNx7HRGCwjqeQPWwKTxHmT5MDHsofHc9mSprl7nhcr9jMb/egUf54cRJAWpqd83h31Sf7AbCz+00cNYR4IyPjAs/4O3ZzxgoDbKrUuRXy9f3IJ4rINB6MdWFI3RIHRhGSZBWcCWH0yLaXq4MUqOUxt/n/xcGxWzdw+2srfoNVjZb1lQeZ1fQE+hPtA2y01ecTxxiPM0eUI3p119Vqb1k4Pkpo/3k6RMWK8vQ2XCSrn76JnChXfn3m4F+y8fSCja40PXeKKraJLvcSBULm5ABoDpaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPXAe2AbDzoGV/hzvZK4Q4Ya0AVQasuWnsWkSc0DtLk=;
 b=Gyo3cMxYaPcvuNc8ejk5kcefZmqzTQ3Lpe2MJh+jmXzjtPxbdJ1sTzAPzW5/V/HrrO+QLcegRtTR8pkKEigd/K1csTVfSLqX+3thzqzize0jhUDcMUuq+aQyZBNqbGzye2nXZiBy943dzscEkwTywJTaWKZP8TL0PmRJPEkX2R6kxp+3o4DUFAc9GR2CvCxb/g3cFgHT/9sPgOeApH0onvROvz2HxzmsAe9S6z7XSVNdJDDKQ1O3iNco7mfWAIlUqOPfI3U+khCdeflaHN11Gj64oYTw64FvHQ21vkvJfLUxH7SuuGebsHft6uRaLilCf6/Dk1iqc2lknBfwmqlTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPXAe2AbDzoGV/hzvZK4Q4Ya0AVQasuWnsWkSc0DtLk=;
 b=K9SwiuclgfTfoxPNzuOGu/UENXpf3mTGkn8r8ruLFSpa3JuU9KJQe8KFw51LwnOHhcoWm4l/jrf5ff3F50Dh2y4aYmSQRQ2NmSaTJhqlhWhwxAvjtzE2rmb+8erajVb1MOVL+drjfMRB9E9uPmThImr+1QFr8Ap/OZnABp/nybA=
Received: from CH2PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:52::12)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Fri, 31 Jul
 2026 06:31:57 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::8) by CH2PR04CA0002.outlook.office365.com
 (2603:10b6:610:52::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 06:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 06:31:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 01:31:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 23:31:56 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 01:31:50 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Mario Sopena-Novales <Mario.Novales@amd.com>
Subject: [PATCH v4 4/5] drm/amdgpu: recover user queues in the shared
 priv-fault helper
Date: Fri, 31 Jul 2026 14:29:56 +0800
Message-ID: <20260731063128.3026783-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260731063128.3026783-1-Jesse.Zhang@amd.com>
References: <20260731063128.3026783-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 0accd388-7b8d-4911-6e2b-08deeecd6b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: AWWtLsO09TTJuUkYTCEBmf5R9JZNyg7tD8bFT2YhEvrJXjZ8Z1vJGl/VrsUo/4TaoiA++j5yNdhF8yzgSdzgAovbg2PBikcsf7kI2uX3u9cN05CsGOVQmTYJW9QKxtUuUGWj1XQVh3y6ZBBYVu0ob97i7DJsT6Y6sA8Xx1ePbbrghMtcO3DH6utjL6sNetI0T9rXkzIifvpMJJ0/4jVT1L1hp2Qg+IW9nEsqTAVU3bNf17GE0jr+vyzBYi+3gpyVhTDqq9H4094UCBEKjHllT6VopFeFS87ZoqEFs27N7QGKjoD4gm+0E8VgBXrAju+dEUMXqAINL6+o5033QD3DwkJbMiuO0bjQivV2whk9TR+lptM1deGqSr6NJIMONTMXTn2uiFSG3fzNMijpoDD72r1kbTMFbpSWTd418BnTOfyvQgGgbBIdNlCvNKbQR9cj/UdY1895okSYLp1FdHbroktwwKjfnHSNbglpmQiZCRuq1tIyIVnHGohwgna1Gtrzo/aSEmwUvZsDZyBBiIkSrEwl3BL8TrXxaPVkuO2liPCq7TOC98td26351pU0dNO7gS5hxnPMrhiRv8Zk/FgNM8nj6k7MGPC5JZtH8YGBLZDdXYHcSzuwEUS5NhwZRMPebhDnTnB8J/QlebLeISziR+lOcNgV6qFJ4JOFY17dNL9iSr+W1q1BNiJGgVEbAYoZM9yLWKOxtQvo5TRhdp4WLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dFu6XR3mgmf4ohzfxPugXCWMUqS3Nfj/mpchl+ylluNsKP+cfgxxfrO5FdV0TUkXQuM3Y7fXMFPTaeEcErtbIpvhMpaIZrFm2WM4MDucTkOdf7gi7zxdZHpDBrLkkujo3AiOdXX6eP83TwXTY/MgLU9NnM6zwsOLN1Wnhw8Vja9iz8YG3kfspaEYl9MaEE9jqwLRl4xs1fbnwoaxop25oYh8DBbvw33TtKgMZVN6Kw2DDXxMh5D6cdvcK+Iw5AS+yBtwRnaWX2CA46m+tohZaGHsRBCmsto/94M4ruqhb+SJYO6oBsFSX7JXRp2oUC1cy0OTxbBYqGQh9lG53kEslsur3cObjvwGSwTqgNRQAoq5ClRcNDZTssSLDujOHKuP9OOYQbW6TSAXas2Sk+nqpgE3HQ1KUe1ckW/dVNsZ4Jkp11Oi9zLUg3OPF0P1MFOy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:31:57.3538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0accd388-7b8d-4911-6e2b-08deeecd6b95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
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

If a priv/bad-op fault does not match a kernel queue slot, it belongs to a
MES-scheduled user queue. Extend the shared amdgpu_gfx_handle_priv_fault()
helper introduced by commit d8ab7636160e ("drm/amd/amdgpu: remove
duplicated code in gfx_v11 and gfx_v12") to recover it: gate on
adev->gfx.disable_uq, reset a compute user queue directly from its
doorbell, and for a gfx user queue (whose IV carries no doorbell) record
the HW slot and schedule the per-IP recovery worker.

v2:
 - gate on adev->gfx.disable_uq instead of !adev->enable_mes (Alex)
 - document why both the doorbell (compute) and HW-slot (gfx) reset
   paths are needed (Alex)

v3:
 - rebase amd-staing-drm-next. adapt to the deduplicated amdgpu_gfx_handle_priv_fault() helper
   (commit d8ab7636160e); no functional change

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Mario Sopena-Novales <Mario.Novales@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 4d21d83451a4..a6f95ff47d24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -866,7 +866,8 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
  * @queue_id: queue ID of the faulty ring
  *
  * This function handles privileged instruction faults by identifying
- * the faulty ring (gfx or compute) and triggering a scheduler fault
+ * the faulty ring (gfx or compute) and triggering a scheduler fault, or by
+ * recovering the faulting user queue.
  */
 void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry,
@@ -901,12 +902,25 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
 		}
 	}
 
+	/* No KQ matched: the faulting slot belongs to a user queue. */
+	if (adev->gfx.disable_uq)
+		return;
+
 	doorbell_offset = entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_MASK;
 
-	/* No KQ matched: HW slot is a MES-scheduled user queue. */
-	if (adev->enable_mes && doorbell_offset)
+	/*
+	 * A compute user-queue fault IV carries the doorbell offset, so reset
+	 * the queue directly from it. A gfx user-queue fault is raised by the
+	 * ME and carries only the HW slot (no doorbell); record the slot and
+	 * let the worker read the doorbell back from the HQD.
+	 */
+	if (doorbell_offset) {
 		amdgpu_userq_process_reset_irq(adev, entry->pasid,
 					       doorbell_offset);
+	} else {
+		set_bit(pipe_id | (queue_id << 2), &adev->gfx.userq_priv_fault_slots);
+		schedule_work(&adev->gfx.userq_priv_fault_work);
+	}
 }
 
 static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
-- 
2.49.0

