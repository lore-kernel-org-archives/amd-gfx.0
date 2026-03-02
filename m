Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06111EA4E22
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 15:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9646010E523;
	Mon,  2 Mar 2026 15:26:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fgQHhBGn";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7E210E523
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 15:26:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWUxcgoiYFACrjEVEJ1YgC4LgqMduFGknaI7CsqJNCeHiR0t2ZGqsCFhDr8KxHupyrzCnDY/v8fAcT1Bt8ngkizZ9xGHMnxCRCR6b2w3ISvLMXXtjSLHZCsxvG3k1L/Rmw39IRQHz4w4L6z9jw4yUgU8Jg0b3uH3ruhISie191ibmhEZQ3pw63r6IKhRUftpllzbCzsXvafX34MwZysRsRtKrXn/AEYJ/DvS/nm1SQe0yE0Y37V3lbiz2Hcc2PLW1udzHvFFrq7MeZm0VAXSlDsLWXb6YvatmGCLuQQdCd0skDzUQ7+l5OZ3VG+pOzMWbMGMGhV345/9H8dAjDLhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V38Fsi2Ct/ilYKiWXQmhMs/qukP9ziqJejt1An1hIco=;
 b=ARwuLHaaXSMOakgLnSCOA/a+cy1HhLLNQ1/oAhzVMs2LvjKUYs9FfQbI9kbu5TBIWyIEve2bG+fQmzsNmM4ogsnQpsdXqxFSyDylY8ew31aGWZpJ9284pA3ynOzZ5iHsYKVnzUt1w6b6HG1nNhMmt/qRGrcddOaedC0jyoYpEGZL/q94kFr5V4cECrmgYwBivHp+sKF8wzAUHj8ZHHNQN1F82X1UOpoN0zGaoAqHaDpDqglVEwXgZFBde3FsuNwkowe/XEYOdW51v1fRChbnV/ZGCHS8Z+JkIFrua2KRCJHg/Atgsn2GzWd4w0HaP3P/fe304o6eAYQg3JQjc+rxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V38Fsi2Ct/ilYKiWXQmhMs/qukP9ziqJejt1An1hIco=;
 b=fgQHhBGn8xBrK/Ut/CeHM5A5ehzCeTPzeDrb7ENQV2RFQqsav5GTZM3ZrM1mOY5O4hdoVcOu8UuhqChmAijfz86ODfw7L4w5XcDANpXjBrpNZ2FgaalABLzxpggBAuoAUUjNRwUuSzbv4ndGQK6ZMbP+gwxjFvRFCiqJ1De30Ak=
Received: from BN9PR03CA0731.namprd03.prod.outlook.com (2603:10b6:408:110::16)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 15:26:41 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:110:cafe::5a) by BN9PR03CA0731.outlook.office365.com
 (2603:10b6:408:110::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 15:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.0 via Frontend Transport; Mon, 2 Mar 2026 15:26:40 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Mar 2026 09:26:38 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v3] drm/amdgpu: Fix mutex handling in
 amdgpu_benchmark_do_move() v3
Date: Mon, 2 Mar 2026 20:56:30 +0530
Message-ID: <20260302152630.1736760-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 787e5c72-b802-4c1e-733e-08de78701a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: Y1xrMj9c10GJj6FkC1pm6fsldQDv9VGTUFF3GxonhS+9ycw+6BBLtkBx63FTGaJqgkbNksegufm4A/RFHSdaFSeLRwdtxULIzQzBS+CfRtIXrXgwGlqzHRGIOa6DOyFSEPhrg0/Q0+aV5veGUCNqbuqceG9QEi+FtpaOx0lPQeGNXafyqcxPTtZiiRf4WPgXJn96m+iCo5wPZQCHTejqmxp8OMunpG6NfTfYKE9mj4Kah6qGiw1aOaPNXcw/6C8VZyimKtp2BW6ipuSIt8TA/aHY2AA4k/T+ha1D1azwsXXYMWNY9i070hOSYwOoHZKEH8SRLgOg2ANgQ8NiojQQQO9jlTi6H17tspQZK4664D7G6gc/5ZUyEhnMafEyohTN3xzA4HUmK09j870jN/M0VZ3hQneRJPnEClvVE3AVuWgx4907o2ULccPB9L+iYMNvnE6Q/woDyh8Yn8V7mTKN88DXRyr02VMnAIYebHanxVn6iw9m0KfZWLh2nbK9GqWrmsdJmNNlS6AkCYU8KvHGPT/YFXk4d6CEqb+ZoK9rOUyHGCYYalMazJgppxw1l7SrFhzKJvxXJZiXt8nObdgh4z0xQ10XovtoTPz4HO028XkqfvNCPiqjJe89n0k+xA1wDXY8bA9bmw/BJRgWdRc5qeuWt/cFxmzdRkAlaz8dMUfCxUzYnbTWs/wk52ihcdRhIHhGNRs4nG+fgGET0v37kDl/prd0qxmh7rNvF3u706ugpyXURuVf0kepXJnoNDiTQKyf6rWqM/8NOWveecw6NM0AqHC3+g4yUBLWfKxRzOTuy9l3+UjaIUtuEXM8DHg8boofNSjY/zJU9nravdnj5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9AsarX7b6W7Tm5Ju/KBzGdRQQ8pavHUmr/CbXYrebpJxlXc6oM6oZmxDtXGg1I4BtAuSfDRrIcaAnP4WUiMNF83J4y27GafWrrcCNl+2mMAJaN0l+JYytu/06B19zgLetZc8xy+0iaXQTdPMQjd23je/D0fCBWyMqWNd5PXEGltwLIbP9ReL8xicxtjeF5yLQBuStHRcs8ZMUiYsRi32XOPfGNimfghe5nqY625CqxGf6Ma9+8B5drIzOLE63q5Rv/hEAvnPE5Zbm90GcdbYERklmOBWErrmv/da6I7yeKXE7jT5VZE0ozPpZqZVKZ/6rutBzE34516L6PnbEPQgb9Imk+Hff6P7hEfHawe8J/nZrVWdZv+Dws79UxazN4N7sqBqV3YFxAJtf/yig0P02Rb99zFwWdS8/Ul/BtOdmJl+C7/n/EFfC2fu5YoF02x8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 15:26:40.6033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 787e5c72-b802-4c1e-733e-08de78701a52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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

amdgpu_benchmark_do_move() can exit the loop early if
amdgpu_copy_buffer() or dma_fence_wait() fails.

In the error path, the function jumps to the exit label
without releasing adev->mman.default_entity.lock, which
leaves the mutex held and results in a lock imbalance.

This can block subsequent users of default_entity and
potentially cause deadlocks.

Move the mutex_unlock() to the common exit path so the
lock is released on both success and error returns.

This fixes:
drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c:57 amdgpu_benchmark_do_move()
warn: inconsistent returns '&adev->mman.default_entity.lock'.

v2:
- Drop unrelated initialization of 'r'
- Keep the change focused on the mutex imbalance fix (Pierre).

v3:
- Remove empty line

Fixes: 64c9e5ec16fa ("drm/amdgpu: add missing lock in amdgpu_benchmark_do_move")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 98ccd7ab9e9a..6f3c68cde75e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -48,9 +48,9 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
 		if (r)
 			goto exit_do_move;
 	}
-	mutex_unlock(&adev->mman.default_entity.lock);
 
 exit_do_move:
+	mutex_unlock(&adev->mman.default_entity.lock);
 	etime = ktime_get();
 	*time_ms = ktime_ms_delta(etime, stime);
 
-- 
2.34.1

