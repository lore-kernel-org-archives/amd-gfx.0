Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F373FCFA746
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 03:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86FF410E193;
	Fri,  4 Oct 2024 03:45:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wQpBOAYq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5108810E104
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 03:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uf3BNG+NohuBB8AQnA43L1kVum7IiOF3EV2XYDki4xbnn9zQArbuJpmQvGzCkdaLzFXHLBVa9IxSH9/qVMZ3NAH4xEnfFu+/9NmTTajJHf5d3CAHydyom8rgmuI6qgWf26aiClPz0rT2x0QB2hzVaOxhzDb0zj++58rx+p3Agaj+wE012ayjEtg3pxqHaY5it0stkhzdLd4mIuUXIt3E9Ni1UzpSVB6T+cjv+x5+OvyFtlwn6zKhzX3Gb5Y0DcY1Q2LPRgs8831AJ2Itdd/EQ0ZefL2+v0VdGGmBn5kiGGokHhNSNO8NjAxnXqSNYGwgHYoPXOfn20CKU89fm2mtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j19Bcl/vKw+Qn1b+DxHcKS8swBenDygdPy+ckzrNZGc=;
 b=lpZghNb4fidTFJ25JM23DcOL69tshZNKnihEcndzhV5EDuJnNXJQgOSmKXJBYK3Z4mZ9LHPmuRlxx5JQwabhB2tCS59CTzJzxwitmkwi0ODJCTJPr0qCWpX1jDIHCS8+IwnmPqCHy+jL2t2moA7vjVibiD3Bja+VzKqKw4H1DwGgXCBlTOPZ6r4iCeTOxbcZswrYossKsXURSRUCTZtYK4a3hyOS77cTDpNwyZZdqjpj7ItMUuLOXvMMr8vs1JdnUW7THg+pcdiOhm9T9rcbkgCCp9TR9Accb29eyceWbwiuhGxTLHcsKccE8OBH8Wt/1mMkU7FaZmBTmodpnEfxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j19Bcl/vKw+Qn1b+DxHcKS8swBenDygdPy+ckzrNZGc=;
 b=wQpBOAYqZCFPzl9yVVYT7pTP/wCTsyZN9FHlNSwSWaLungBHLinNF7dWdX24PePshmEbzpTkwVZY+zoGQqUY9SX8q1UKY/bfB9HhhQ3nzdsBjKWR0dyxG+lp6XuudoUgTGP5ucQ4uAwfmeJ8z6veVbTYHvZ6ie7Ausw+34bxyxs=
Received: from BYAPR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:74::18)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Fri, 4 Oct
 2024 03:45:24 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:74:cafe::d3) by BYAPR05CA0041.outlook.office365.com
 (2603:10b6:a03:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.10 via Frontend
 Transport; Fri, 4 Oct 2024 03:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.2 via Frontend Transport; Fri, 4 Oct 2024 03:45:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 22:45:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "Harish
 Kasiviswanathan" <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Use dynamic allocation for CU occupancy array in
 'kfd_get_cu_occupancy()'
Date: Fri, 4 Oct 2024 09:15:05 +0530
Message-ID: <20241004034505.3759692-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: d5226434-8601-4427-d8a9-08dce426fa36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEVHM1p1ZFFQa3E3eU5MM05CM2hqeWZuMUFqUU54TUgzVitBUDk1QlN3SVJH?=
 =?utf-8?B?Vml2aU50OHlmNHIxZjFjWWtNR1B2V0t4Vm9hSzJEWlJEOGRVUGQ2ek1IYnpR?=
 =?utf-8?B?U2RQVGJVUXQ1OE4vVTVnVlV4N1hHR3lINXhkUXlMYzlZSUxWUklrQ2pLQmJT?=
 =?utf-8?B?TWs5MForMlpZbURpZUQvWFcxWHpoTXNvbkhTNjZ5WnMxcFpZck0vdUlwbURM?=
 =?utf-8?B?YnlBN1JMQU52azRZS0psWkUwbXlqS25JdEhzeEc2RmwwNFBpMVc1elVxbjIw?=
 =?utf-8?B?MGt4d28wOWVmNzZFY2RFS2VKSHMrY3cyZ0Z2YTVvZnlvMUk1WGJkU0hHR2k1?=
 =?utf-8?B?eTN6V3ptemw0b2tmaytsZXc1UFNQY2E2Y1hadFh5UERpY2Y5bStPY2tyZUlG?=
 =?utf-8?B?OVpmOXBaaEIwYXJrek1KdFIxWllHL0p5TFYzKzVrYWlQWUtHN2NHM3dqNnVV?=
 =?utf-8?B?WlZvV1hndmNsbHAyMlhnYmtEWjRROE1wN2QwRGdNL0N5SGIrdVIzOTRMdkw5?=
 =?utf-8?B?WDQvTEJ0TWJDKzBVY1V1eEtCVFBkbzRZbnhIOG1IMWYvZURTVEVjNFdiL3Zs?=
 =?utf-8?B?Uk4xWUkvUnViM2M2Z0JtV1VncXQrUjRsNm1hb01kbTk4eGEwenlvaWU5UWI1?=
 =?utf-8?B?Sk1EVmlYeXRseVhQaTk4elBlTUhwajJhZ1lab3R4MjdsMkkrd2g5dGkzckVo?=
 =?utf-8?B?ZGc4R3hsOGtFcVhHb0VhdndCeEhCVUpSZEZ5eFNnWXFIQ1RrY0czenppdFVj?=
 =?utf-8?B?VUFheWw1MEQ4N0xBRDJwMFpoaCtrR0FPSkJITDkzeFd4YTlRaEI2Z0QvYmRV?=
 =?utf-8?B?QWVJa2VvTGFGcGJHd2R1dWVOYzlONWdXV0xBQ05tdEVIbTJZVkpHbEtGS3pi?=
 =?utf-8?B?VVRVakt2VkNZSTRWSkVUd2ZkcXUvVDR2THhNTjVRUkx5RzJDMDkrTEp4VFBj?=
 =?utf-8?B?c2NtcVJCbVRHK2dqQ0hBZklqdHA0VHVlUUlVL1MyOFkxWldOTkhabEZmOGN6?=
 =?utf-8?B?MWg1MGVUVnVWcmh5ZzV1b0puU1FmS0t2cFV4NnlQaG5PZWQwMTdBR3hxR3BO?=
 =?utf-8?B?a1hoYnlPRlBxNWlnSHFOV2ExMEVlUDBmZ3dSQjF0dTdIWDRvSUR2SWtUNFRU?=
 =?utf-8?B?eEZYelc3bldqV005QzVsWVNpYUYyWks1N3NJY29zSXNwbDQrRVFIbnFPZmtt?=
 =?utf-8?B?VHVQMHNEZXZLRWVKVStwTmlRWnlQMWFIa2hCNVl4dmFmbmYxU1FqRmhzanMv?=
 =?utf-8?B?SWorcUM4YUErbGZaTlJETzJEV0ZEL1lPdjh4ejNnNmpVRjA4NjFVSC9MQW1s?=
 =?utf-8?B?REZCUUN3MmE2c09kV242eVd1ZTNhUnBtNlF6ZS9SVXZVMUlMYVVqdE53NmFJ?=
 =?utf-8?B?dGRpVFErbUx1YU50a1YvQU1hV1RCTzBZWTB6eVNkQ21oaUpGdjlMdlZteUtX?=
 =?utf-8?B?SXQ4My9KNjRsSjdBQlAxTlNBakJZS1VoT0dObzJ5TS9uODB4YVdEZWdhNDEv?=
 =?utf-8?B?R1VDTGFWcmtER0kxWHZPbThpSldheEExSm5LY2RlR2YxVm9nRVp5dmNPOGRw?=
 =?utf-8?B?eFV6K2JocDVyTUpPeG54VXFIaHZONG5qb0JkbjJkNmRFaE1ObTRXaDdFRWUy?=
 =?utf-8?B?aGpvRG1yRVpFbEgvMk1JaGhuL1B3ckV3dmFPT0dETkdKY2JyYTdwdW5sNTlV?=
 =?utf-8?B?OFQvb1NtZExqaWN6cVNtTXAwQ1k1cEZGMTVGMERZb0R3cms2NEFlazdTUWdy?=
 =?utf-8?B?Yi9VUVhRN1VMa1JYOWtIQm8rYW9QQTQrUnA1c3l2L2pGN3h0K2pOR3N3WTVp?=
 =?utf-8?B?OTIyb2dqVVArL2NSbk9ndz09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 03:45:23.5837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5226434-8601-4427-d8a9-08dce426fa36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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

The `kfd_get_cu_occupancy` function previously declared a large
`cu_occupancy` array as a local variable, which could lead to stack
overflows due to excessive stack usage. This commit replaces the static
array allocation with dynamic memory allocation using `kmalloc_array`,
thereby reducing the stack size.

This change avoids the risk of stack overflows in kernel space,  in
scenarios where `AMDGPU_MAX_QUEUES` is large. The  allocated memory is
freed using `kfree` before the function returns  to prevent memory
leaks.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c: In function ‘kfd_get_cu_occupancy’:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:322:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  322 | }
      | ^

Fixes: 6fc91266b798 ("drm/amdkfd: Update logic for CU occupancy calculations")
Cc: Mukul Joshi <mukul.joshi@amd.com>
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d665ecdcd12f..33109d9f6eed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -271,10 +271,13 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	struct kfd_process *proc = NULL;
 	struct kfd_process_device *pdd = NULL;
 	int i;
-	struct kfd_cu_occupancy cu_occupancy[AMDGPU_MAX_QUEUES];
+	struct kfd_cu_occupancy *cu_occupancy;
 	u32 queue_format;
+	int bytes_written;
 
-	memset(cu_occupancy, 0x0, sizeof(cu_occupancy));
+	cu_occupancy = kmalloc_array(AMDGPU_MAX_QUEUES, sizeof(*cu_occupancy), GFP_KERNEL);
+	if (!cu_occupancy)
+		return -ENOMEM;
 
 	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
 	dev = pdd->dev;
@@ -318,7 +321,10 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 
 	/* Translate wave count to number of compute units */
 	cu_cnt = (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
-	return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
+	bytes_written = snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
+
+	kfree(cu_occupancy);
+	return bytes_written;
 }
 
 static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
-- 
2.34.1

