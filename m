Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3072C55167
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 06:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E99A10F15E;
	Fri, 31 Jul 2026 06:32:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DmFs2T5A";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2398310F15E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 06:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzEl6vFDAFQB+Wsfs3+RL26TgWK+5dWdkxL4ClMLfA/9KJhB1qOOrFNTjgCZTIWFtQRWjkJ5tAyjy2hyuTY51ipPcHvUGsMBSNmOj459hCoS/cdv+kdJfs39dR3KxOJJRedPtGC+dXEaiNLz3+NBK1DR73xE4I3hQc6Z4NzXqWZmgLck70lFjwSYJWPtlnejmhjWiXlKMW5wm2leMxgNzRzdWukOp417vIhKo+UbioS3fl3EVe13QHqSC0t1SAViaQLk+pbuw32QVcF/gOuZy3UH35qEnNxyd76F/moTu6c+bZ4BkZZPXb0Q9Vcc75qG8wrq7S1FBmDUcX59/Bwa3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plfCexRH1nqWaVJnJUr2kFqPXtu7aIVNKq6OUjuZkEU=;
 b=oaapYXGFwQPK7ffVk4KRd2kLfsJjjLD7su5K8A9qK2zChKnSpu9AAZ/dMGseYA1wna3x2xnZQA+YP9Y0eAn7MUM0zdJGeg4QwMM189rUxeeVqA9qvhgC7kLoejSuRN81HSkYuxUcbaZJ9V8xEXghSLkdFurjcKOJCsa4Inc/woJz1K3SF4/pB+hrl6jUSArdixMSVUcUZyhN0YC2nbmjej0snwRLdKRnzsnmSkErAzy/+sOLg6IMT0niO6jXYgsWEkR8EoTi+1SKWXIw/scGSCihYVLzRv5XEgJKHqe0puvtsz/OUQrJE2ondVhCKGTYTJNBm1EF782ql6fGDKbyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plfCexRH1nqWaVJnJUr2kFqPXtu7aIVNKq6OUjuZkEU=;
 b=DmFs2T5AhJFApdY129mBbcoE+UfZlKnxvHL7Qg6MQJBVzRcTy21ljLQRcXgezsvrRasNUbC365x6K3nLaoAIwPEQ0uggusdwjnMe71Cx8Tlg1vDLit/zUdUUonfUWsahD1aU6lspPn4ttDQx8xlfsCXq79apAow0VmYBSpmWdA0=
Received: from PH8PR02CA0012.namprd02.prod.outlook.com (2603:10b6:510:2d0::24)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 06:32:05 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::1e) by PH8PR02CA0012.outlook.office365.com
 (2603:10b6:510:2d0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 06:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 06:32:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 01:32:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 01:32:03 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 01:31:57 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 5/5] drm/amdgpu/userq: mark a queue unmapped after a
 per-queue reset
Date: Fri, 31 Jul 2026 14:29:57 +0800
Message-ID: <20260731063128.3026783-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260731063128.3026783-1-Jesse.Zhang@amd.com>
References: <20260731063128.3026783-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 53638bda-d6d6-47e8-7170-08deeecd6faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /cmXFXDHV6muyxJPKonLnj9ToSNG48j1dU2oneyceghVytThngpR0ZYuwGphANDmd7FBcFkcGbzYPxPrALLfkaj/PL3ABIb+4e+nWAEUXMMgFDKOPBH0GCgoTyHSeh8SN7GdPxQhLKocDK3FrFxmBXr7qvekIT6Mkv02l1oN/2mvjXTWo/ErFNM/9jJJ2KxMkANMhjb6i9shOL612HzbecjO6OsPTMXlP7pF72hdT62fd0b4Fua1tVmKhDcC236SJA6qDsXFx6rohoIadDH5YY8CppGW6Wenu3Ll2BfhPc7bhVnbYAIoHgF3SZaeQBHC93a5oCtF/cOSsKpn4/9v9ytjmG9iEMH79RD5Dx7CkD10rwysWHEYer9v2MJrmB5r2ZjnpprhmuWeJVzOBrTGsRRYanp1RL4VdQ/p0Y/TNyS4HWsJxMfRARCgckK0a7x5leaOkFiY7ozDFbLHpeAeGK8YIdv+Jyo0XC56CV4QyTY8Zp/8u6yWS/6E+Bl1RYTHhOnT9NZYlYJuP3bNVRlk9Dd3pcUeh55Y9HgVmoFXABG5SXJrWRs7sy2La9ONHEcZ8PIsKlwtMtq7Ub91Ykny2Kl5Or48bkFOZU+w/c7x35ehRF4+gLFLBmtKcpaJSDwi/Rph1lRR/Yjk24dMG5BvX7yU4Q9/KMlObcL/iCwrnQPF5eKO8IyJkUMVSzQY8YyS4Wnc1iiaVX9LLpQhSqkOAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yMxh6WBuX6MfKprYGBkm9q3yWnMsWSw/B81pdA+VUJf3YdumFY1kRTfhlhnYgqtIGPXXOouw4Vsuv9Hs3MZvqksZ/XfmiUVfkk/UCPdafphcp9v3QzS1b5xYZsbQepbd5dxAwNfNMWjnu+DSDxUf43doCx/RUTXbGjjAZbDCWA4Rxd06ngp1yBHJhyjI2zhqwf6OQnnlpn0Dz7k06tR0CpyGMCkypfpbAkX5C1kzzMH9EzGwi46xe/Cg5I30tA2vT0LbXokjXMN5YfKqqudOOjKNyTTWEKgjAGRkDhQYpr9Krt6gSWWSgePzNevNF/tu7+sTjTLvzlNYgig0lC+/xdIydvcArDYfzDpuK+18hfdncKFyX7X4GHJBEhFHSFDeOdBbcVh9tg2ay8nU26EuM0NtRC3hDgG0aHXuAurWqB9XfH1u0CIaQQ4VNGoLkp1m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:32:04.2353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53638bda-d6d6-47e8-7170-08deeecd6faf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
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

mes_userq_reset() unmaps the queue via the low-level mes_userq_unmap()
(REMOVE_QUEUE) but does not update queue->state, so the queue still looks
MAPPED. The destroy path then issues a second, redundant REMOVE_QUEUE for
the already-removed queue; for gfx that unmap waits on an EOP that never
arrives, times out (-110) and escalates to a full GPU reset.

Mark the queue UNMAPPED on a successful reset-path unmap so destroy skips
the redundant REMOVE_QUEUE.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 639e4a37f872..b5816f9a8ffd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -26,6 +26,7 @@
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_trace.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -205,7 +206,16 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		return r;
-	return mes_userq_unmap(queue);
+
+	/* mes_userq_unmap() does not update queue->state; mark it UNMAPPED so the
+	 * destroy path does not issue a second REMOVE_QUEUE for the removed queue.
+	 */
+	r = mes_userq_unmap(queue);
+	if (!r) {
+		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
+		queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
+	}
+	return r;
 }
 
 int mes_userq_reset_queue(struct amdgpu_device *adev,
-- 
2.49.0

