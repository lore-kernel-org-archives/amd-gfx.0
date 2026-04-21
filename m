Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26692F94CA4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 18:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A5810E923;
	Tue, 21 Apr 2026 18:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WSoG/8MG";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013014.outbound.protection.outlook.com
 [40.107.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 136F210E923
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 18:07:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6NfAMzkhPGOL/NlkRbgMLyuOiDh/bySiga1gBQUrwHyEi4Tqq+C29dHmvRQGQyGCyIK2aGqi3uefERRC66K1B49xg/uQZcwxxIRy7MXNfD7CVIdw0aiaC+50Lm0IFx4DkfU0HnawPTIaVkaq5QgvGieZHO+5dpnKeosKqZJQ7chCWHBv7C6cv5ppOyelXqWaNPaMHKJKhZtE29ErvGc+YMszAzURsqv2RjydJ/4RxNp6nrmiRCaPRQiE78qH0JxsT6fsXpZKWhoCBMm4KLc3yMO6gKu3W0xV2JTU1p0k4Z8j8vhHjS6A1POtXwo1zxd/VButvTzwzAsInWg9kq5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHnPiVA6E72/dcBhh0XLK4/ReIKgfj9S+kQ6XyTQwLw=;
 b=Zw4g5tCRHgmBQ/ze5ASZq9j3YcQszhJeLmrEWcf5Smva9cU00+9ES6phEfJUK3XghFuTTrOty0qhCn54hrYsnfeNWAPZcBE7ASQnsLXEVkZhjBASUJesPDA737wtIBRSTg/WkHr7doPWmcGV19LgN9P0J8WCcB6P1K/Ijuh1r4wZdRAavgZFfNevfFElf7jpeHxzG07FIoVv77nUlSlrXFL4onvs4Sm3IekyiIiqr7o++abPjX7PdtbvaqBORbfm+D9XXkTz1NGS0pfjeogUTqq0+LhEdOmlkHVwypXvgsKzjg8f8cL4y+ObggWpSER8o+xiYGIHlFA67CaciWENTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHnPiVA6E72/dcBhh0XLK4/ReIKgfj9S+kQ6XyTQwLw=;
 b=WSoG/8MG1d5c6j1LbTITA+OJq7d8JTE6VgyqS+4Ah02P7Dh5caks4tZXg/0CTw5hOmH6MYRpjdwedu5Nm51yVSf3IYALjj2GwAZVHrr+GnlR2CtAl9BVzepj2PZ+PY+szutzspNPPxcdqZwB39iLojsyaPP6E64TTA5HNh5EPSk=
Received: from BN9PR03CA0455.namprd03.prod.outlook.com (2603:10b6:408:139::10)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:07:51 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::fd) by BN9PR03CA0455.outlook.office365.com
 (2603:10b6:408:139::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 18:07:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 13:07:49 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 08/11] drm/amdgpu: Add queue reset records to WAIT_EVENT
Date: Tue, 21 Apr 2026 23:36:24 +0530
Message-ID: <20260421180627.2402093-9-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
References: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcec3da-14cc-4763-52c7-08de9fd0e6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: gyRZEqgCiPowrFdC3r4XI5IZzBCVHaLNVWeb4Y/f/+6r1FCKvJglh8uNBIq8XhHbo1JknA2wPqq7M8ARdaldVcrP0jb/eGI7lDxa1OhI0hBuMcDHBxzrC97T1VPCG0HvOugTaqhzchcwpqOb2WiEWeK7ixthsFFUhEW4r7dgY0Oqw5WpteBO47PZsd+Prhm9+F6YGGvYDdOkeXN0v6H5lr9N38o2zX0M/kFRIvrZQpcomp+92ip7mRPp7MERjTavtdAnq2wvQ1IJQG+eDS8fBU3xg9AzChfDiDS1jNVTFR+OYPPz30M3R3+uLFSXTy8qIOGT2FMI/s/0etQg4wOtZTb9JaPzW2YL7BrCItBNXJfWed3qiSScEfoEYWvPixHNszxR/+Ob3+8P4yowoHzBRNhc5aWehTBtunfjc31BLaOd7CekX6DrFl/Vwxp/zP4hEcFNiiPTSDZyygso80pVPiBadFfHnRrIwvpcn4JvuwA5CnDa/8+flkyA01RQ7s+M+ezGrs5aOMuTF4Tzpqa/WndofLGRo82BP2A8kz/2Y2Ofx0/jcUpxWTY4UCGGo3J8RMdmEAVDEqKnwCoMBILUUC65YUMQLmcsOTGNF0ERnsCrXRIVfzZncqwQ5/RkGsaLrFejqduHw+IC7U3h08v1PQq5QFdPZwMaNYvQZlVbxjHnxXF0gJ/y07LS0ZGbH1b20lFXISVrkHyIb14PjRJx4wl2vWtmUQB+w9fhM3TVaG2AV6NJxQk7eoZGWmMVAd4zc0R1Xr0OYOAvUCp6jqlqVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jKo06HI5C4eYLmVACZXwjeXATSSfU/VAVrlvnaFEtUXGFz53XbAxqK9asb80YxceAVID64ggldZ46vhqIzD5wFRJpWC/f/Y6CCwJg+x3YeGX7w7DHub4p0pB2dOf88LMBuO3bfVlpa31Oos5qjwkiZXqAjav1fXiiWvhzzgsqbbmfLMtkFRo9XNZIQbU5mdf8cuY9P2rLzn+m6Xy2JuFanfoLz8HcbXaOHHGEWcxHcWDS/7SA71e+1AB0TNlWM2saYC11DIP/qcNC9rIRcao2PKdmb+wIeyeRUAz5rhck0qYcyBcsv9Tvu9umYihc7qmuqm3W7uKxsqKainot+J6rE+VUiyqg4k2Q9EODyq+VN2HcoklTrJ8jbJGR5TlvO9Xbt+QUT9Sv/SBVMVa+sDdLYPOgHFf3pilSJHaAsNOMJOV0IcJuOMb5e+uQcpzwbyp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:07:50.8348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcec3da-14cc-4763-52c7-08de9fd0e6e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
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

Queue reset records into the WAIT_EVENT path when hung user queues are
detected and reset.

The user queue reset path already identifies the affected queue and
marks it as AMDGPU_USERQ_STATE_HUNG. Reuse that point to queue a
queue-scoped WAIT_EVENT reset record keyed by the queue doorbell index.

This does not change WAIT_EVENT UAPI semantics.

Changes in v5:
- Use queue->qid instead of doorbell_index for queue-scoped event
  handling (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index e99241ae40db..e166df3ef285 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -24,6 +24,7 @@
 #include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_wait_event.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
 
@@ -262,6 +263,13 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 								DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
 								queue->qid);
 
+						if (queue->userq_mgr &&
+						    queue->userq_mgr->wait_event_mgr)
+							amdgpu_wait_event_push_queue_reset(
+								queue->userq_mgr->wait_event_mgr,
+								queue->qid,
+								0, 0, 0);
+
 						found_hung_queue = true;
 						atomic_inc(&adev->gpu_reset_counter);
 						amdgpu_userq_fence_driver_force_completion(queue);
-- 
2.34.1

