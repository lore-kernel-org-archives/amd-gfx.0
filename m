Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABE4CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08311112DBD;
	Mon,  1 Jun 2026 05:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kVfXpEQj";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012039.outbound.protection.outlook.com
 [40.93.195.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B83112DBD
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9WNqIAM3oU/t1E9cFHzjOS0TMec38wgECq0nzc3kgikVT63eiCVrpVq37RAj5eZlNEqpPIg8UUGVKiepMByqoZRD9fBgfniyMNqsuAgWb8Wj98cqPz2NY2eFW3v1aU77bJENXHOYL9+utrlA+c70rKCEz5ppwlBfIsCgNvVIyn3gdny+ajyMpqrO5dKHXTxD9KsSYihCYPDSGK2QnPFCxBpwq9K4yJ9Mc96+67ik74Us/oy2doPty2zIs6F17E66zQFBp5DVl6j8/asTH2SzEAHlCq4EZwHk0exo1GTw1TSZVkrMyFMpIIsn364lIRD9A7JpOMXiAJWgDHsGc9a+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kILUrURiBcHh4X2uxxJ0K6FGH/sw0LDS7NDRPyeA8Ms=;
 b=GP+lba2X0ZHHv2ZzJwF+XDq0DkPyWkvmHT8bmTKwj7viVTAyguz5Hhkfyt02fJAOyRbdELQrCym7QdllcfE1djXGtBzaaaksIfd9UTXMsLcS1fa6wf4qlhKfkKrXdXGP8R0jYUsnXcp23fNjfERjJQbhrhiSqShDLwkNJ+Ycii7Vck7FOP7Enw1LV8eFzgDfL5MS6sp+sIVJTHmNqpsVmJCEpVZYkrhZXdTiR+TqXZjnoxMlv3zPN87ca71pkPkR7IxObMWYkUdC/ERR5N3qYzBnVmx6CvSHdggwY6kPvlX+G7xbdOVRAfEQ6AYXb+sq5I0Ans9Ob51P7gJWMoibmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kILUrURiBcHh4X2uxxJ0K6FGH/sw0LDS7NDRPyeA8Ms=;
 b=kVfXpEQj433lTqUWfxEQu+ec7RayHcbnygNsJ48Q+Z64zmX+E6bi1hW4Y5M7pphID22jYFal0RdoWXy7n3xlHNzAPAhWUHe6LFFKmiLw3ozlOUxJGAoXhK1yOQBgxpov3CN/P8o3316aeJEnfldzFtZjPlktFnT/z68Lg9guC4g=
Received: from MN2PR22CA0018.namprd22.prod.outlook.com (2603:10b6:208:238::23)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:51:09 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::89) by MN2PR22CA0018.outlook.office365.com
 (2603:10b6:208:238::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:51:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:51:08 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:51:01 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 05/42] drm/amdgpu:
 amdgpu_ring_set_fence_errors_and_reemit() handle NULL fence
Date: Mon, 1 Jun 2026 13:48:51 +0800
Message-ID: <20260601055034.3700921-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bbd575c-dd01-4104-e0ba-08debfa1c76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: ZwyiDwrTb866Ecl7XUBrtuw+XAj8AyWmz0TCT0Ub+aNdZKiv41w3jXGDHGXjOjTuAhM8P+/CmVoCpJtkBDOOElyBpUx3tJfp2WChWR3+FtlSPtW9/W293QMyU48WvroWoSgHLLiyHcW5XJ6eTbEfUqNkzhPV2KztQ3Uvt7cFgBUX0uwkmwIi1oz3AHrGb1k1+g0bb2NqOoJggCidRYYo3PTX8QzmR99R+zVOpBfWxRIumNwOzg66HA78JgQVvlyBG02OdMV1xDyYtmyQ+m1uUJZFUNoWGiQDRFh5y2wSt5z7sDp9D5PbEvdayt7PEt9ulnxlw6GnfHOh4xvBIC6y87z9LgXnr4/DVNjzBzYSr/VFZtUCoApEcuVA2dRUHbUh/tEYNFNQTPnVQhP1s4Lkcm1+xSUgFlWaeMtczxMsV1kFjiK+0Yovphvg7KQP6KxrgMxSId1o+Y+GzmZHTSc2Bhn831ojwMUCYUFUbzs0186S7n6YBlcqJQNOq1yXaQHzCUCbBqPGjgeGwHb9v3op/OK8tJwhEaGMW5zD0z5iKc2HCgQkzaYbOdrFAJoADzcN0vvrNr2ZF1nZdv+AzHWftCww/tdh08VMFJ9VfxmMgnzCkdAuGKvn+9xTyPYlJL68LnGdGkfF59UMb7GC0BC1tskUkGlfunvQtYm7pWsyDqkcG00voBp8MBE07mBQnnWxGiF8AV849998XakSVs5FmPtVO/ISv1ezQSv4kromfCc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LelnD8arpbU13xD4OV2g/Q/gEMBy/eozaBF6lRF8b1PcunG3w5jkOfa8m/94nMtx41hGG2ypxKZrUcfG41PWbmu4FiP1KeWHjWzv/k1m5FtZ8IvLFrOno4MIDubAupXPiqeaFfms10+g74h128H8Gt8ROAMwVLHwrsvLxBvI6mSM+T7aWijftaRtLMjXHZsU+zzYuGi/DfEC42SYz1jy8In0hrkRj5V9EAhN5Unkq1hgvqwkWHLd6IXiWwCPzehZPXJNyk7Vvy90wis3hvFV9G1YMkfNZcpR0WPAfiS2uWdcUVTN+RU27kefHWt9RuVY55YcuWIBL/ypqmnQQZWMJWbSaNVFXjawREOvNCbrZbJ3QtT/OKSMan2dfWu94+xHAwNnJwkxfu2u38CVN9MqUHm6EdrYJaE1bz5HknugHn6OYRD5AP14RNk4QOE9k5Cg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:51:08.9397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbd575c-dd01-4104-e0ba-08debfa1c76f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537
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

From: Alex Deucher <alexander.deucher@amd.com>

All the guilty fence parameter to be NULL.  Will be needed for
future functionality.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 733e9b668ed8..8569c1c637a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -750,7 +750,8 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 			is_guilty_fence = fence == guilty_fence;
-			is_guilty_context = fence->context == guilty_fence->context;
+			is_guilty_context = guilty_fence ?
+				(fence->context == guilty_fence->context) : false;
 
 			/* mark all fences from the guilty context with an error */
 			if (is_guilty_fence)
-- 
2.49.0

