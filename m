Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070C4EA4E22
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 15:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9585810E082;
	Mon,  2 Mar 2026 15:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zxeAlu/b";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 182DE10E082
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 15:23:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw1/nAAipTzU/ftFIreSScUiba2/1uXaqHJ2azl2BKC+5Bs6zx8WwLngxnNmm/t0EvUrli52qDuAg2FtIDOa6+oM4SazfFG7A+a2otwjAm7ReChzDGcyrqLV59iXjD7jWkvMElSStN4fPKi3clGaojerVlqX01ca9G0gFysN0o8lmjpBIF8aP6MZ8++EoWjmbW8fQ5uftMcwo1c1fpJaaUed8QDQNxZz1BOUipxfksyroUt3Jo2DdNVuzfjBcpVMu9mPgZ4Uc//tDTZ1J4nIMDBZvPibeFmHKrNfe93oJVvL3ZhO6DNimSYsA3kUV9HXiWZZJsGCnt8tV9bPfsgBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38qQpKhHQ5n2ucg8kXm7Kuu+fhOpONlv32992enFrjE=;
 b=BrNmS/3AGdXbvbbj5yMOEF+NFreXtsLAbUTwt+o2cCFdrCVgRalZXMHd2yi1N4TN4vQjSMy6MRn1e6KcCe4dXKcucQT/1Fmy3bBvoEH9QEc3o2TyBSelqNbrcUHOtc+eZ9VNJEZQWNy0ibeokdbSNYtOkl1HTI7l/JCIEahLm7kLmxe7VZw7zPQKo6P+6oqZqCQ0NH4y23jBE9w8+RzpznWDUzQfYbq1r3wU73LUBIFB4fWEHYXNGTvhVeqeZtnsmW1mQ0DTFLSsYUT3apegTNu/hmufUFmQNZAQ+D/5GRK98OwvyJRIa/MRwFfh4uD+DoAeFxGjVADCriBIZwgX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38qQpKhHQ5n2ucg8kXm7Kuu+fhOpONlv32992enFrjE=;
 b=zxeAlu/bM14H3vCIvnl+95i1hejjzGfSr8BTHgdeAE/RqKxy1RWJ9dwNfsN74n5/WzJP5d+OiuQ5WSEwkyRMdakFipQDu5P9WoNmVJ4sb9IvzFI/2AgwhcEUIuXcrJv7XqvapMQdW9JjfXSs2FhtVI1L2s9Fe0hym7ndlAFZZPY=
Received: from BLAPR03CA0120.namprd03.prod.outlook.com (2603:10b6:208:32a::35)
 by DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 15:23:23 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::b6) by BLAPR03CA0120.outlook.office365.com
 (2603:10b6:208:32a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 15:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.0 via Frontend Transport; Mon, 2 Mar 2026 15:23:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Mar 2026 09:23:21 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix mutex handling in
 amdgpu_benchmark_do_move() v2
Date: Mon, 2 Mar 2026 20:53:06 +0530
Message-ID: <20260302152306.1736497-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DS2PR12MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: 9153245c-8f67-4955-52be-08de786fa4d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: bYVFL+ODXBe6WdiQ50Ds4ZtytiyBlZ4atIko03ZS9wS5TxqPsUVVABsFhA1yu93LSuH+nluFS4o7DH2Z0dQo0NZhcHMez18LPEweMBi8b+8RyZnzphiUY+GRe/kwpxrQHGxFFKdNY/zKx1kH1jIy+GRtAxXmcFC4HW2NYfht55/0atnth6ZJB8Kwpoek95O9iW+wABYBRrCWR4Nwedbgezambf0q5rozxXL1sZ2R9GhW3FtN2piaD18mYO2R+8wV1+GUpKA41ZT9u+xPlxJ4tyL1NVGkw+eZxAdak4AheE3O3vGraE8xMB2beRfhnX5dLA+fXZQUm7qPDRcLP7I9AwQjJCSuRxB1NtUVM55c++FftBiHGA03IhNzvDjbhPWyZ7HHIQMY8p3TAqWdAPn3HsrxialQ8Lsv96UxoNPRmMKoWrhRYWkrOdj1ZpWhh28AxpjSPPKubhjAU4IT6cMP2GjJgpF19dbbLE2pEhpwzCzH6sDDCo0zU4PqUJ/fL9er36Ab1dH/VkqDqVx27bP4H+wp6yICY5KJFlKediUUDC9pl38LPlsESWWggrWGoiRWt126eH/zhOxzzaMxRjoQeoNeMQTtNsIoVZUTd98JxcjlBAURfYP9svt6UlizyfH2U5/1kDuZzQn9rPEfgWHA/n+1eevQTcKUuIfPfw2nu/uIAZ7jRdRkDdmVR87DtJRXwG08tHznkLsyQYXkCD2Au1TsNdcOX3ms2+qPbd122kPyCGFwzvmJhbRJAdyZgxg9AMB/QWB8k7kRs1dDLyLpFNIzvzVlzqiiGUYDjqMRunMVk3OQp5EBZ6Gr+SM+pBrmF0/c8yjAVzijeswCUPoM5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FGq/DTVbe+gKrTe5goedu46sXJGBdaDZtqalyybpV0+NVQOvhWkZUxUQeK7hIVTGrRuAOsEyHh43xLahnW+vdkGvIQPH2m3RmEEAmCjc+BvNs55xNkiarb/bGcdtjeJsWjuBnp4LX/JveEhRVWyYGYGcU8VO59xg29St3t0PMgaj/2yyHAXo/UVvbbHWbJ/i50diMtW/sbrUI2ZOOZb7HVglEMvl4qywCHPJF8ebvoybsbASaRA5vFnMbNqGzlpoP4Yw8OU75cxVKU4jDUFhHvqbBTNKeLQOCBB5yxHH8M8qG5gY/yMxWLA37LUZX2KdRQsPpXLGXf7Y7+BOKuGTZqgKM262irn0Y+2Y0VXCsl3y3C8Vrju5IaNXXANkmnd9CjnD95GiQO2X3iyL20Xe4s4CEpTOOpq7KEW2FwcRZK80UWEN3MoH6UXM5seRgJ1s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 15:23:23.5039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9153245c-8f67-4955-52be-08de786fa4d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9567
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

Fixes: 64c9e5ec16fa ("drm/amdgpu: add missing lock in amdgpu_benchmark_do_move")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 98ccd7ab9e9a..f7cee5ce854e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -48,9 +48,10 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
 		if (r)
 			goto exit_do_move;
 	}
-	mutex_unlock(&adev->mman.default_entity.lock);
+
 
 exit_do_move:
+	mutex_unlock(&adev->mman.default_entity.lock);
 	etime = ktime_get();
 	*time_ms = ktime_ms_delta(etime, stime);
 
-- 
2.34.1

