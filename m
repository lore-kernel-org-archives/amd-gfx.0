Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47546C83F1A
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 13:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA51D10E27E;
	Mon, 21 Jul 2025 13:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tU8Ho03D";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49B210E27E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 13:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7M8ko9//79uuUScOcLcznrdVcWzuHN0cSVkEUd3orwsNx1qSBdi2t5wkVZkZu+TERLbkwLIrEru1HBnxSv2f4B77fSZ/f37IoL4YkcZQvDEz1UwGjtAKTOGjOWqerji3EfGInajL9MH5KL0PX1gvFXlq0hOcUZ+qCB/r/WI1GLWohEd0zGA+6HhgTAZpPWVIGYl0aDUuYX1O3X29d1l5wweSjHB6RTtbq14t8VZr9ZY35eu68E1HvHh12eBlnhnM7akdqmGGtONRABPfZiqBzo4kYyDwqS2nxUOA1Q0Zn2xrZi0xdiyywZS+02zMLEdNybBj1JE3tVjz0FnNoiIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUI3i47c1BIk44EFZAMc0O32OlKjuvfgLVmWukwkKio=;
 b=C6euazBxUqLr7Aw2EvVUgRaVpOl7FfdHKMRNlw6tfCMnlk4NKT+VL0XKQbQHILWYLC8SJseGHWI4JucNwKJ2/e66M058MYLtCkAKQLQczGDraI11KdL8BVwlDiIyfZB6JHcTpi0kAwWKaYqHvg+o6x5RXycyYsmhJraSCDt3BepwV6YkYEeZ6PJ+2Gz1M/ivNLN1J7jokyFheLZomCjmP+rrO6ZwWmaImdt5k9WDOpSM/T99LkBwj+1jkxZbVzOtAdc3AoMRCjNG1aWCcmEgrabdXOWSgDU2S+juU05s7jZVGILLXtrLxIT9w8DsUeQVF1B59egVrZ8w+tT+NnycOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUI3i47c1BIk44EFZAMc0O32OlKjuvfgLVmWukwkKio=;
 b=tU8Ho03DYVHl55ICsnbH+t/mvmVMoEpjWsnFkCkgEPfiSXuUEUizydIN0hAnzEWjKRriCKoqX7mTVLcEKyIogWLCz4WTwRP/EMfpBm7zHcwsvvc2BkmshZsUbw1M/tREWPKNviZCS2hUk+IJiKkvwbAMkGbPsJ6oSxRfkXP0SFg=
Received: from CH2PR07CA0045.namprd07.prod.outlook.com (2603:10b6:610:5b::19)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 13:36:51 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:5b:cafe::50) by CH2PR07CA0045.outlook.office365.com
 (2603:10b6:610:5b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Mon,
 21 Jul 2025 13:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.1 via Frontend Transport; Mon, 21 Jul 2025 13:36:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Jul 2025 08:36:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix kdoc style in amdgpu_fence.c
Date: Mon, 21 Jul 2025 19:06:30 +0530
Message-ID: <20250721133630.1307201-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: a899f815-e37e-47da-d710-08ddc85ba581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2FDdlU4Q0VqeEViSGRvWVc1dDNvNDRNWWMyTlhYeFVsOXh2OUZZS1MxS3V2?=
 =?utf-8?B?bkhndXdCanY4QUJxaGlkdStHeVFGMjFOQWsxSVlJZC9Ga3lOR3lZUVJuT0hQ?=
 =?utf-8?B?V2gwUkJVRGVMQnk0eUEvMmF0RHI4dG5Nb3lJYkhNQXdCbTliWlQ5YkRDbitn?=
 =?utf-8?B?a1VuczlIWmdHNGJWcTJiR1F5WkN3WjZyS0lTblRXc0FYTENSbjBBYkhsaVVF?=
 =?utf-8?B?Tm11anVNRTVwSlp0ZVVHQ0JkU2MvUmpkVUlrUnpTMUl5alNBdnpUSlUrMENh?=
 =?utf-8?B?RkVSWHVkazVrdU9Sd0NRWCttT0tHaEpoZHlsRzFKVHB3b3NFMW8vbm9uOGxy?=
 =?utf-8?B?SjBqUHJkQVlhYkdvWGNyRi8yajlCUHBRK1diR05wRkc3Ym5PZVM3RmNEUkMx?=
 =?utf-8?B?dEJhdnhINTllbnZGeGdMUGZTMzUxczlTbWJmaDBsL3lUdHlMdEhtOVFzNlhy?=
 =?utf-8?B?N09NT3h6YVgwVk9kZFBiTWtHdDlaaDVZNWhrbmxmd0FlZlVFcDBkVUNNVWxF?=
 =?utf-8?B?ZG05S2ljYTB2aG9sc0dYdlFjOFJVci80cENNZCtpWnBzRHkyaGxRa1FCU0dE?=
 =?utf-8?B?ampqSUQvV0MyWVNCOGdrN2QrMjNHU1RmMFNTTU5wY1B6MG9xOUY5NnI5UE5L?=
 =?utf-8?B?NHM0SWZQWERKcWZySS82NmpqRStseWFldFJ2cGQvWXFBd3QvL0xWdytPMlI4?=
 =?utf-8?B?ZFhxVWRITEUrOHh0dWRVVkpiYnl6RXlVdlRTNmNyL2RVc3JLcEt3R0ZWa1NS?=
 =?utf-8?B?RTQ5YjNDTVgwbVBNQXBUMVVIbEd1bnVEVStuY1R0SWUyQk9KdmoxYUFLZEU1?=
 =?utf-8?B?R1U5czJjQXdWdmlDL2VkR01ZVUtaQTQvUGlUOUp1U3Q1TCszMzhRVElqeTR3?=
 =?utf-8?B?cmJ6dXNJZjBtQUFQTWxUTGE4NHJtM3ArWDV4RlBwWTJGWUl6aURlZUlLZEg2?=
 =?utf-8?B?MUllQkEwMDNkNm50dXU0dU1sK0paMUxHcGNySjEwQVJ1dmZpaWN4dW00YlVs?=
 =?utf-8?B?VEVwV2JvVnljZHJKTnBLSTNITVBsajRHandta1RvMm9UKzYvNDlybm1zY05w?=
 =?utf-8?B?dkJPcXR0bVY0VmwzMnZkUVl4RThqYS9YZlFoYUt0WU8vRi9YTzBDSnFSYmZN?=
 =?utf-8?B?d0YrdEpNQjMvUEdrSndVbE5XRHhKUUpGZnpCbkhlc2ExYzkxYlFnSHlONTA0?=
 =?utf-8?B?SmFhUVVFdFE3U2k5cncvUS9yYjFxcEdQdkhFVVJpUkI3VWdqMGpIZytkWENu?=
 =?utf-8?B?ajF3VFl6YTJzZVloa2MzdWJEdWNGWi9pYUlOUjlneXBoY21IT3pCbmZWS0li?=
 =?utf-8?B?TTF2bWl3YTU2S2piUVYwODg5WW5kY2NyRXgrdDhUbDlON0gyZVVJZ1FmM3B5?=
 =?utf-8?B?R243Yk01aithY3JqOVBqWjI4cU85a202TGtYRTFvaFZhaHpqYml1NHlydjdt?=
 =?utf-8?B?OHR6Zm5xeWdVaThXbkNGdzJnUHJQNGdYckRmSXpLMEl2MThRaDM0ZVBWTWlw?=
 =?utf-8?B?TENoa24vZ2o3RUNGbyt2cmV1Nlo2cTNzL3ROakV3N0xiclp5a0d1NGQ3Nkti?=
 =?utf-8?B?cTdxS2NjRklnT1BHc2NwaVVaMnZmbSt6SVNZamdLYlJlSDgycFhlNnJEN1Rt?=
 =?utf-8?B?c0JBNjJXY29BeW12UlZ5Z3hCcDhzVmhjTWcxLy9SdWpwV3p2Q1FBVDNEUGFU?=
 =?utf-8?B?bUdVK1gzS1F6ZkZCZHFBMm9OWDFMQjdZd1pqcmhZNE93aENFbENPbi9iZXRj?=
 =?utf-8?B?d0ZDdjZueFFTMEFwUHpSWFhWd0hYSEtUY2s5aEhzNUNYb3Q3S3JPTFN2dEMr?=
 =?utf-8?B?ZHA4ZGhrVTlPVTRRM1hjTHVtK0ZxODRWakJySlgxYlFvUnN5aTNkRDEzT3lL?=
 =?utf-8?B?bW9GVmRtL2ZRcFlOejRwUXVtcWIrdUpKSkx6UTFFSjE2SHJqMzkyRlV3UDUy?=
 =?utf-8?B?Q2w3VGlkazgxaXlMcXZ5OTdwVFk5dXZWb0ZKbjlEdGpzaTQ3cGlxQXB3WXpG?=
 =?utf-8?B?UkdMRWNWR3lwVjRVNnI4M2htQysyOGlob05UeCt3Nkd4S3NFcTd3V1EvSS9q?=
 =?utf-8?Q?PyQ3vl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 13:36:50.0253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a899f815-e37e-47da-d710-08ddc85ba581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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

The initial comment block before
amdgpu_fence_driver_guilty_force_completion() incorrectly used '/**' but
is not a kernel-doc comment, causing build warnings.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:742: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Kernel queue reset handling

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3f2080aecd5a..2c84d36b5437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -738,7 +738,7 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
 }
 
 
-/**
+/*
  * Kernel queue reset handling
  *
  * The driver can reset individual queues for most engines, but those queues
-- 
2.34.1

