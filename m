Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDF5F433DD
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 316D710E80C;
	Thu, 16 Apr 2026 03:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FGWkx8GO";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013037.outbound.protection.outlook.com
 [40.93.196.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCDFA10E80A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:45:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8UqspVoA5TgWUE0J8IKOyaxtIrFj0aF9XeD5mPfzjXAOKPPfxuaRodlvYA/m4m87s4RRHCI2iLweMJCMMNfkwU9flnOwAE+O7qkYjRQJ5FVyejG6MM4+UrUcBL201c6JM5nCzVOFmFCrr0Q9R2W3JBvDtvVLrD/62vnM3yBDayPoDw9WyBrZGit6jaZ8Zwpc/H1W9Ww6zBKr9iOXYhrU2M/GRhEMKbY1vUccaX2XeleETulKGe4UyeSdFL5xc8PLA8XsSbl2XpJUI2I/csSFY3oDnQXDoWbeG0K6V8w34ioWymScANXR87JV3yFeqtB4fqjyPmHxjZD00Za/gygTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBRNnJY1up2V8e2ISCAEFm/6J06ZB8/wFfSrIEetRsM=;
 b=tQpkba8yJsIYtux790uHBzsK2EplNayQapjHf1OcHJCa5FhQVgEjArHx2hcn2qaAgGkTW64TSoMYT7QEEH6M5rvRRQ04mnvcvqumhQ8fVS2EcPKQM0SxxlgbsWz3QYqt8zOqvWnW0Wp8PIsSn0bf99z8/pXyd/LGufAzXLa1doZuHeQ2JYy8hRLJigo9J7s73SITZXHWnl0+FCiCtAu2F6XQS0nwkMexeqUkl3hnDJk5bFbTcVV2SiL/LkoYmeN+q6P3czq1iINPQByuRhpw8xMxV9QexUGRHbZDHCO+GPWdr6e85RSCNQO1V7UFwHZrUqRhYPHglxcl7fvwsvtGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBRNnJY1up2V8e2ISCAEFm/6J06ZB8/wFfSrIEetRsM=;
 b=FGWkx8GOwHqWN6ZT8Jzdcays+XyeFy66HOSivKOCBXujqm4NXodWHjvLB+zHJGLW9RsWtVSgYiNIFTLWI5G/hBQQoKd3ieRh9FQecjTC5SMMjkXZ1N3NznplPKQOtixtdwhIX42KA1pl5n3u9BnjnPQbbvPqeK086iZLl2KQBtM=
Received: from BL1PR13CA0397.namprd13.prod.outlook.com (2603:10b6:208:2c2::12)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:44:56 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::1) by BL1PR13CA0397.outlook.office365.com
 (2603:10b6:208:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Thu,
 16 Apr 2026 03:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:44:56 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:44:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v4 08/11] drm/amdgpu: Add queue reset records to WAIT_EVENT
Date: Thu, 16 Apr 2026 09:14:17 +0530
Message-ID: <20260416034420.2368152-9-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
References: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0f20ee-8767-43a2-3eac-08de9b6a86bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: JhEWUOHb/WWaAU5IHEktYzhlZv6luE7hgfXhlmuWDSlfeC5TVXELqCdclsvmF2y0t7+fP5yw+r79UP1kwao37epP3PNBF0AVN1mjUDGk/8F+Rrf/lOk5zWvabK4ZXSLkThD3z9BU+jLah+ogGeNQeqCDjfNGBGmppERZQBSbPvcNb4CGgT4rE8H6x4a0tFRvNBqG9Mpc5nGhP5dk9SCW5rqOI0bBQi4EJk3I8g8uTLwjKtqKfADKK+HS4Mrh2umq4LFFJOMUdRY8pZIdNfnDNxZM0dOE52xCmYMxzInUMzu/4b21G+r3l8srsTXJZn9a4m+5JJrXxZbh/QUKBTklq+urcmcwhH3z7LkbhWvnCG6qH5FinVXGmBOMU3WKXE206h4Z1w5NWUQjaVuWB4d+CQnvxqugl2rlmn2FcnMQRhcqjzcNqhSrw6DjirrpLtUmaRI7iADPppSH69OwAO18F6h9ddJSy/D40Tu5DwVX2aYVbJ9IdmJmRVsBttvNvMvjsqAaHnnWU2ch0UobDsXc/5aOeJ6OiiznTKz8mQrY/gjmqj+VNLS0Xz3lP2gWuQDBQlLvNGePR9yH+5TvJa6nc+musYV9Hg7ZyZZ6wjnPQrvik1a1Q6c7hUPxkqcXeGziaZlKzrNsBRd/8qLEWbKUcJ+rqxvMu1vqP+9sgsCPoJUYHL1rWesWuwfpO3hUdsATL6QoBA+WjLx2HFUv2rE6ldGUfdwKaVNg3A+rGZEhZNcperiCxbG6UoAXLvTahJ/Zo0jIeNCw9vg0nObplYeMGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SIfYVyb25l0LacbyCsFquyw+MqSyK6cLoN6wgTAW11ELDOb16eN6jgc8xFtjLrUKSNDomRIXICNgeRDh4WAwpVfkkvtLIcjSDNCTrwtnGIVWgmYIpX/l/27Xvb87xAMzZydviqd45IZL39vIyjEzAhnavROitz+EwshDjDysi/ZktcbRAraIe3yqLSqiE2csCFjSzdCAitCbvC3vN++Nvk68EHr0gXTRMhIExC83QmEmEVc9VENA9pv5IdaJ8AgUdJe4JmoKJnk5dkGPyTn9BkaGCzRdykVfpyj//kFDw8j01Q3U/i1jkbw3BhuJ5YAUOpwqK1LeniRtAadYIkPHFfHmfwwjk/5hYumj2w+RsqcX475+bh6bEmwcujFvcXpm57olF8NkPn/11nK06jfZwvybhlnRA2gzx7zWbRuoIXUwUJLENuylN1/9UwMoG26s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:44:56.2269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0f20ee-8767-43a2-3eac-08de9b6a86bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index af29c1d8d699..e130ff9b5a7d 100644
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
 								queue->doorbell_index);
 
+						if (queue->userq_mgr &&
+						    queue->userq_mgr->wait_event_mgr)
+							amdgpu_wait_event_push_queue_reset(
+								queue->userq_mgr->wait_event_mgr,
+								queue->doorbell_index,
+								0, 0, 0);
+
 						found_hung_queue = true;
 						atomic_inc(&adev->gpu_reset_counter);
 						amdgpu_userq_fence_driver_force_completion(queue);
-- 
2.34.1

