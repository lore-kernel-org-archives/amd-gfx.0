Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3094DC44537
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 03:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC34810EC05;
	Wed, 22 Jul 2026 03:22:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nh7D2Mhs";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1966A10E425
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 03:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuAJvU1LFV/iCU6jsfVuUBRduYe36txkBxlKo7ewavhkLfPcLcITxkI2VWtXCP45AX1Xk2rSlAAx2v3mrwkWi1yYNzO4f6ao08OFspn5XsjUrwSJ450IgpQil4/6GTalZfVpvC6vt/wtJqiS5YOa+bYI5SyNIyT0Hb9F4JO4GWHUjvQuUqPU3fJY7W5kNJnR2x9Eq2t7OzS4hPWhb0SLUvTgTquuDNVTKB9rcfDzWYO79MMR83A6VYBTDz0XGouiKU1GBHvfzUr4xv8TLxZODwhhYvy2D4gxoZFfc43dm1arEKSWX6cOBHWn1AbEnxsF6IgD8LIWdoucRL+YItkCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1waTbF6cMKLSv9Np+UShgTkZ7dX6gBIgHxWABHrGKg=;
 b=jjvwkN28tH3thluaA445nzGtwJmUhK74pXo5CkljKBD7qe/nySf17NLuRfwdXkbXiudkqG9W+VLYmCdYHAZO0x5m6V8Upz75lihHtCfsPGoAHACB8sRbs8LSTIDg1IeRUbd3ku48fHwq3fnx79FayojmGZ2F0eqQN4q2KZfz8DUD2bgQaYVqyvv/q+i/PakT4fLCp75Ru3VgcNPC44UFtZlL6DOOMSNcfa/9mOV0aFkr4LlezHU/O+8ioyq1lKTt87WJ9aZ6kolIQ03c3s/F0D427bEvqutSTb3Q5KtM7NqU0m0ru95rX6Msc88NIa5Ub9n1YFJKFs2/n1dhr/mZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1waTbF6cMKLSv9Np+UShgTkZ7dX6gBIgHxWABHrGKg=;
 b=nh7D2Mhs/6yms7NBbmpz8LTULBojbKJujYHRSKh1eRMnlvc6eNzRKwcWvd2d9cULSfNeCEAdTnscPfUp0BdZa9oTk+5M6RTOeZSaDnA5+ZqtH0Ks/VdD5W5vi4Lw2wOvm1mXPZZiJGIXTK5gypNfmEPFLMJuJSYdBmhHDFkJ8zo=
Received: from CH0PR03CA0435.namprd03.prod.outlook.com (2603:10b6:610:10e::9)
 by BN7PPF8FCE094C0.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:22:01 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::12) by CH0PR03CA0435.outlook.office365.com
 (2603:10b6:610:10e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend
 Transport; Wed, 22 Jul 2026 03:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 22 Jul 2026 03:22:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 22:21:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 22:21:59 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 21 Jul 2026 22:21:58 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu/userq: mark a queue unmapped after a
 per-queue reset
Date: Wed, 22 Jul 2026 11:21:16 +0800
Message-ID: <20260722032152.2904563-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260722032152.2904563-1-Jesse.Zhang@amd.com>
References: <20260722032152.2904563-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|BN7PPF8FCE094C0:EE_
X-MS-Office365-Filtering-Correlation-Id: 7037c8d7-b380-4706-381c-08dee7a064b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QFKEzdXYdlgfpp15drzLQV/2iQAEPYUkALBuo9o3l/Ajop1xUlVq0M5z+HpZUJO4L7fXpsZSLl1hdPQI3aFfV2fJIO6MaJbRuf6rUCkX9vxOEyIJjFPzumZyA3cBmUgUdy2XNLu5fFo0JGKSJi9nbOPzD0vmTZ0e0I7i6/YpsRfmk1sIrHsNVIFDU3OBts7DDAyuPZYDdchCDda6BtuPLZcveRTi8a/B91v/oOrCrF+yGEkGsgyJZZT5Wr6vCN94hb4MsGeHUvTjlfAHPZK7BX8HkUcdJH+chwqsfhAteis4urvDGvAZZUaf++2cOZWWYjLg2mtBLw4IlBbEqXReNY/hS4o1OYk3z9OZqBtFw2lr8JsGZy5dAsy84lqqbTgDu643GguDFPwgRherYd+W0khwBoc5hqQO7YV9mNSH2qNzyPTqPxmogQf/4UbaFb1hw3+xaakBbBZ3SVENq8VfUKnFKxMIe71IyIGBJzI1twEPDcw3ZzRIt0u9SRWTr8a8AgVpW+LNth546G9HV7To3cm07/MVYNn/9kmi+sA3L/Xa7vozA8e984l1C+5cfeyLd0DJGNi2oqhrnMJLmbzs4TbI9WVBivFzEFdWtfAXesS+4I1Be6Zh2+bbjHTkNMqUmpo1Qmv+hlon37bDI1Vp7DUKuZKVy3bomwqAeGDByRSUjIlfuVIEfSq2bNMmKegF6tuIK6q6aLYzvd/dt5+wfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6MGt4WRJBLrwLRQvCJi+WqkANdAUtZ4Jmq9fQLDLaxNI29J96d+azVHScWusOQ+DHYRi2GPz2P6zH2U9U5my2S78X2XCYvevUEalyzSHdtoc4BW8Py6GyvfSeaxRhMiybybM1Wb3xGtF9LNwnA1NxlXsng2xfUyIIb9tx6UCE9FWxtXGtsXR4yaxGOr6Vha67IJNtkWmS/c8sj7IZcXsJ8EoRBoqR4bgHocW4n+Fy7XzVuJ+3im83dwbkyJ4xXQ4Hre7qIfLXR48DkOBZGwH7BfKPo2nX/wrzmQvAfrRzqBtQblA/7XhLvxvf7c7d+O9a0WoA2tSLPzGueGj5L/CCUXg3KZ0RxrfLcTXa5RivhSwt5DVwrtQb8rEsnAtqGL73dlH00SW//fkJ9axemBT8kD/AEeC6wc+o149RpeVohDdTci2M2R/AIwSAvpnRdqp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:22:00.2908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7037c8d7-b380-4706-381c-08dee7a064b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF8FCE094C0
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

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index df4efdea1136..b5d5065415d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -26,6 +26,7 @@
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_trace.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -209,7 +210,16 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
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

