Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1ECCCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 12:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6845D10E2D4;
	Wed,  5 Nov 2025 12:14:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AyyuTISw";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB4010E2D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 12:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGHr2mrXfIePTime6K9mN0aBt9WON1CwcftuKXhC50cfgBWbLVool8mDrLI/R4P7RPo4HGvIzHY8DGygQoAJEnre1tlWG7K7c1zeLSdsN4vdL8r7KCvpdWcBJjeLSlIJmcaD2vqM6vODO88Iq0TwTZA8nlfGbRxn9HGUtvVi4wJKvrcoTLc2uZMyz+VvX7dm4wnJDqwaocgzGN+EK0LXpLcnBFqe4FPjOoCWxPoSfoVjKPAPXZrmAHpQAF3FZ7Y1xawGFKPJyBojE2WY48S9bVk/Tm/Bt3a9XheiURZ09MAnAKOx1c2p9FazmoVq7xtShOxTRItCelDqGoO5zw6gPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/w0nMZ4KjFzERLiw6mkDjAXeQwBb7Y5KmtsmUGeJ9k=;
 b=M3KCvk8a81bJGZFRJFUJK+oK+RSoUUcW6WieSwomJJYm/chRuao0oDzpiVmUnbH/Nf1oXJQybq/UASMtFHKzOVQ+Rxe33BAiPiIQfx/DtrUkIFy9LFYleREK09tLIaycgbUW9lQjr8rSB+jQzemMUR0m6mogPhsZLvc1eA4i/3HcP9yIFW8emDp8bSCCm65WKRSCTeZvbcQ6227k7SIK6ZiupzwUWKdDRhmqiM74UwDxwxmpPap8NbX5ZZ5uMHe56i3Vb+XXHCxBBQKG7tZDao2d7ovGiIadLk2rpMLimVvsi/TwaZlPel/1Iai0C+QBMv5WRt7EJhZCipjMuYYvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/w0nMZ4KjFzERLiw6mkDjAXeQwBb7Y5KmtsmUGeJ9k=;
 b=AyyuTISwiz/wcwqmlKj6P46V0ZmbhQxaqUyf76HAJ3dK5agbLu45PU+6KnrgBNbaLWN/2f3FfBYQ1upJaAJqNyZsW6sydz13ZetPo3SrM74fbS1Ltvi/kwqk8cA9dOLx7QCd5SHv6KwotilqLQIKUJLYmV5zCHbU12Kx9nan7oM=
Received: from BY3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:254::29)
 by BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 12:14:15 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::5f) by BY3PR05CA0024.outlook.office365.com
 (2603:10b6:a03:254::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 12:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 12:14:14 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 04:14:12 -0800
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: attach tlb fence to the PTs update
Date: Wed, 5 Nov 2025 20:14:03 +0800
Message-ID: <20251105121403.4154169-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec392eb-d0af-4a15-64f5-08de1c64d5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFBPWGxEN1I3M1E2dzlYdjZoSm1PV3BlRlpIeU1CU3AxVkZ2bU1JVlFRUGtS?=
 =?utf-8?B?a1QvQUE1UFNCei9RUkU1Z2Q3T01RU0RLRVk0THlkVTlqRTVDNE1kaC9LSlRu?=
 =?utf-8?B?RTRkUUFaanZvR2VHdGpBcS96YlA0aDhKdkY2WVNuVUQwVzFuMktPYk8xajJs?=
 =?utf-8?B?YU9YbCtxa1oyTWt0NWNHUjU2WHNaRHRiMml2VGQ3ZkV0WXpZMTg0WVJGY21Z?=
 =?utf-8?B?aURSODd5Yi85OXdYSFlGdDNaeXc1L0U2WXFiZkk4YnlzbktVaStwWGlqYnNE?=
 =?utf-8?B?YnFrYnY5a0d5SDJpZGNjbkVSSU11SmNLS3dyVE05NTFpS2FreUFneERuUEEv?=
 =?utf-8?B?UFJkZ1FrMitKMXVFWUlvY1gzV2hEejR6SHN3T1RQM2tDdXZ1bzhMNVNHUkY4?=
 =?utf-8?B?aHQ5RVNmQS9Xc3VFaFl5ay92TXFzN0VYUlRWTU1SaHVCdW5MZ0F0ckRhWkgz?=
 =?utf-8?B?QU5WOHZXVnV3NmNFUlZ4ZmprSlNwV1A3OGNkZ282R2puaForbTZmNlhXLy9I?=
 =?utf-8?B?MkZqLy9tb3ZRbVNkYXVUcmJMeWRwc3EvN3I4VHRoNm91R3ZDdStqaDdpSU5U?=
 =?utf-8?B?bTdFN2lvTkMrUFJ4eHU0bU1NaDBXelQ2bExXRENqQXlnNVF5RjNkQ0ZQVkRm?=
 =?utf-8?B?djV1NFhUVzJPTzhneUY1aDI4VzgrdVFSOEFNcXVEcE9MTFNXSytvV2JRRDNQ?=
 =?utf-8?B?bG5sMXVoTHJQd0xlSVl2THRxODJ5a21EaFQ2SGtRUkgzQ1Z4L2lFYUx6dHFY?=
 =?utf-8?B?ZGZ5ZlNEQTZXNzJqcHBlZ3d0QVZzSUVQK08yUlk0aVJJeDh3akYxTEk1ZDk2?=
 =?utf-8?B?b1czUjhNbWdGa0xUdEhQbGtFakNRaU5TcUFteEphMCt4Vkl2c00wWEg4WDlp?=
 =?utf-8?B?aE80S0syYnJoZWtuNGpFVkJxZHFMTjdhQUR2bnpGb0dRV3haS3lGTlFxZHVh?=
 =?utf-8?B?cmxnbDdJQnpuYktLaE44WWtrcDdtOHBIanpzWHplTHpwNmh5Ni9jVnFNVWd4?=
 =?utf-8?B?Q0tUUEdtSFVsSHY1bFp4KzBBYlo5RHpOT2FXNGl2RXM0Q3Z1UENhQytFSVhK?=
 =?utf-8?B?QTVnTVIvQy82eWNlYlB6dlVPTVFabkNyUXcxaU1MZml3blppdUh5bVhuRXhv?=
 =?utf-8?B?MlFKSjZTQ2lsdVhSTEk2a0U0T0Y4dDlkd1IzbWJacStYeHc2Tm9KMk9MRW96?=
 =?utf-8?B?eGVydXkzcFJwaFhjQ0xSMDhvMERPRjk4VlNBelN0TGl1eWZDZytuWGlyNzRQ?=
 =?utf-8?B?Y3ltNTU0dExoUnozUnZsc1h4dENWV2lCbnR6clZHOG1iR0pmVWdjQW5GWGNM?=
 =?utf-8?B?SVVVbjUwTjNBOUtIQVRKMUkyMCtJSElxSFBvNG9xVlAyVzNtVHoxd3Fmamgz?=
 =?utf-8?B?MkFVTkRJenNBL1Q0Y1FEenVEMU9pcWo4bDNqVWtVWHU1ZjZrQURVR0UxVElZ?=
 =?utf-8?B?VEFQUTNEaFF2UnRPOXZFUFlvUUMzYjU1SitFM3hWWGtDYUcvVzhlR015dU1L?=
 =?utf-8?B?b3dUUTVFSmxvUEE1R1A4Y0JOOHd0UFVqQVJZSVdEMHJIYUk0enBOeURmUjl5?=
 =?utf-8?B?bUk5SGkxdGNQVDVUN1M4RWtjYWZPREJlclptanVWNmdZT2Y5Q1BYeXltdisw?=
 =?utf-8?B?aTQvMnhRU0xpNlZ4NGhYUnJYUWM4cGI0N2VlUDZNbzJ3ZlFNQnlra2U1Mmov?=
 =?utf-8?B?SFBTdzZ3SE5SZXpZTFhPWlVXRW1GVzlmWDUyRFJIb003aUsvR3ZCQUVJYmNz?=
 =?utf-8?B?YWpIZjZsM0o3NjkwZTRYeGNYcWtMTW54Y0drNFZCWGowM1NYNnVBbG14cm1k?=
 =?utf-8?B?QkxCUnFJZkJhV0ZiaXZWQXhWR3UxREN4SVJ0cE44Mi82RmVVTUg1bGE5Zk8v?=
 =?utf-8?B?ODdKaFhvTE0vRk1nTDNTQkhFdExsY28vL2NIcElDTEowSDY0a1d4RzE1azhY?=
 =?utf-8?B?T1dWcElUNml1dmlQdkJadzZJaDlNVWE5bllOZkFKNlBuSW9uRnJzL1ptQ0Jt?=
 =?utf-8?B?Qngvek93TUtyZ2UvMzM4ZlVWUmY2QlhQWnJCdzlSclo0MkFxV3IyYnVCOHNn?=
 =?utf-8?B?VHlaRllxLy9uVjJITTdDYTVPRC9WWk41TllqdnAxVGo3VEwrVitZb3pOb0s1?=
 =?utf-8?Q?mbmM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 12:14:14.4438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec392eb-d0af-4a15-64f5-08de1c64d5ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481
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

Ensure the userq TLB flush is emitted only after
the VM update finishes and the PT BOs have been
annotated with bookkeeping fences.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index db66b4232de0..79d687dee877 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1062,7 +1062,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 
 	/* Prepare a TLB flush fence to be attached to PTs */
-	if (!params->unlocked && vm->is_compute_context) {
+	if (!params->unlocked) {
 		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
 
 		/* Makes sure no PD/PT is freed before the flush */
-- 
2.34.1

