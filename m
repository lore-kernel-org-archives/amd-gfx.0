Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4A3D5B84D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 16:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 826FB10E3C9;
	Mon, 15 Dec 2025 16:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yItK/Kuf";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA3D10E3C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:57:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HS5xBdSE83gcjYeO1creO59KWl8mJfaDLBUpw2Yo2sLmAxeW8d1LAR+0dtZ/Fda8g5Gy1ylVVZvcU6wDk2Mqt8BjjyGwbuBc9heAoVlrFP4zfx7KwJw0La+0WwP6YQ4Yn5iTuzm4cG8gKprWNEMtX01ECR0aX1S4zYHOwO+YkyIAR8Ldbzu9q4CdL2wu4zNWMcdyFOU0AFuvct7oR9XqSpUThkILUyfQyTlZRG8zu0FHXBURKeyuUDeDIg0BItLzfeLY+vfpLrRHOVVHa7LnGhWvyWSWfX1SKNo8xnnmYsF1hXZelbtRgn/L/x8INIYw0BwvS4Qrghupkjqw/SxIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtyArNgPcmnkD2w2VYsBCM3WD2xQMbdkllZ0o9g3x/s=;
 b=HFj3xu8YXrG5SYf1RCWJ4pPI8GpfXOTPJstT6MUj41XQ5GzLsXDf62eFZ9v4fe96Ktt/eXF4ekD81Zcmh6McAX3RwGUqUfeTDl/yRrseB51ogHggaFVphWnCv4SiCPJh8VcQFUKyTiEoehskG4aqgtkB/XgeUAeW3dHR9Lo8K5Z1ZSquOiKUyvLpXDQ5T4EFg7DqSG/ukrFqxC0yt02QUWV1HleV382abuHzPROrro9QToVUEiVxXkJ2hxwLapT9OJQhP0fvVSUpNyFmaoj6f7Q9IdXfb0Pl/aiM0byd77LwvqkVbI0NUxILV9xtu48OaMmTkiSjkfFOElt8nqeqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtyArNgPcmnkD2w2VYsBCM3WD2xQMbdkllZ0o9g3x/s=;
 b=yItK/Kuf1VXkbUPG5NoCeg3NH0iNl70VnAdDikrLHrljGmvimU7qNwgZzqm9OTS6Om5BGo1sJo2bTDR7AnsK4o6HyN0e4AXRGCqKmqA4U4Qx7xfTzzUsENqnJ81hK5yTkhk7fMJ+chgU+3kPmbwW+UYArUjPB5KBq+B6Eneetks=
Received: from SJ0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:a03:33e::33)
 by BN3PR12MB9572.namprd12.prod.outlook.com (2603:10b6:408:2ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:57:05 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::47) by SJ0PR03CA0058.outlook.office365.com
 (2603:10b6:a03:33e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 16:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 16:57:05 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 10:56:49 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
 <kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v6 2/6] drm/amdkfd: Bind MQD in GART with mtype RW
Date: Mon, 15 Dec 2025 11:56:26 -0500
Message-ID: <20251215165630.1172383-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215165630.1172383-1-Philip.Yang@amd.com>
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|BN3PR12MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c7536b-6a36-46b9-d586-08de3bfaf9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UU5FeTVoZzRjMEFVV3pPbVBVa0x3N3NRZ3dJTDJmT2ltS1oxd3JmckRzU1hH?=
 =?utf-8?B?TC80S1R6YTZxcXNvVGp3V2xPOW4vUFEvc2lMRXIvR3BZR2ZLOHI3eWdXV1dK?=
 =?utf-8?B?VHF5M3ZWZnVLaDJIdHdraFFaVUQ5T2FON2VpOHlEcFl3M1d0Y05oUG1aaURQ?=
 =?utf-8?B?YitCZGluZTNGU2thQ09rQ3Uyd3FUaERvcmp4WDlmNHpFOEd6SzRKbXFyblpF?=
 =?utf-8?B?d3NudmEvajJkYXY4RVVobkg1cmZUK2JYZW5hTWk5VnVwckw0UEhJMVA2K0ZU?=
 =?utf-8?B?d3B2azBzaWxFaTFkWDJ5MDhpMUxGYTBhdnFVLzdMbElxSUFxVEc0OHRXTWdm?=
 =?utf-8?B?enp4V0U1SDg3MU1rSFdCck9QbkZQVllETGxzQ2IxeVNGeUt3cTh4NlBJbUN6?=
 =?utf-8?B?QmtZeTNHU1preHpGMjMxZVNiUVRGaVVNUVRpTlB4b3g0eEhBQ1Z6R0NLWFFI?=
 =?utf-8?B?ZFY1elhOb1RGTlVQV2dtMjFoSUI1Y3Jnc3ZiYzVoUEliTmxjcUIwdVUzSnVM?=
 =?utf-8?B?WC9raTc2VE9tRlNyZU1QZjZhWHJsNEFLTDg2SmJ5Q1MrRmJvKys3TVJzSzhm?=
 =?utf-8?B?SGJlSzlMNVRORXJkV3AwRGpPYVVFVjNFNHphaEhPaC8wUUVuTHdWT3ZmU2Nj?=
 =?utf-8?B?Lzc5cGkvdER5eGVKMkNlSVlPejcwN0tMOWMvUWhDdzFBR1RYZ3YyMjlnUXVS?=
 =?utf-8?B?LzIyczRHVkJEclVtazdSQnlxOWpNb3JPOVd5c3ltd2dEcTd1YnZuWGRPdk1F?=
 =?utf-8?B?UmtvcElGUm02QUl1SUg2QmhaQXZVTnQwUTIyYk1ZRzNoVGpHYzN5OHRacGZ4?=
 =?utf-8?B?WTJldFkwNy9zOG5iUTBVU1Y1YitURm9vSTR4YzZkUmpKUkh4S25UWU90d2VN?=
 =?utf-8?B?eEI3Y0Fad09NbDBBOU1QTVEzbElSSW95UkVkcElVa0R6UG9xOFBScEhRTm9s?=
 =?utf-8?B?YVExM25iTm5zTnovWFNJOVdxTkJiYlN4VmdXcU1IaDdya0N1ZEoxL3lHclJX?=
 =?utf-8?B?NmFoVk1KcWxqbXR1VmpGRWg1V1EyZjhBTnBSQ3Y2TTM1UG0vaHA0dUxCczhQ?=
 =?utf-8?B?eHA2akJranBQeWMxL1NnR0hveXFSSGtPUUpkTDR0ZTRyNXVpQjMrQ3l3UGJn?=
 =?utf-8?B?dSs0blJpMlZNMlZRUDZqcjNqWHAvRE5XU0dEVWJCcTVYUWs5aEVid1JDY0Fh?=
 =?utf-8?B?NWtNOXd5bUJNV3VEaHJ2U0VoWG8yUG05NnJ5eS9GOGljSlQwL0FDTlRZdzV3?=
 =?utf-8?B?OExxQjhLRWVsaldsd3dULzFFZ3pHSGVhcWJnOWRxelBuaG45empoMVdjS2FW?=
 =?utf-8?B?S2FsL0llaFl0V2YwWlQ4Q2VqTERoR21QQzI0RzVzRGZjdWtzc0ZVajE1WGVE?=
 =?utf-8?B?c2FzclowQkpad0ZHZjB6QTQ5WEFvRmJKUlB2RWRVbko0blg0MjU4aTZCOU1i?=
 =?utf-8?B?RkpxNXRxWUNJRWZQOStBT2FvS0g1U09vcS9TNFd1NUNEMTZVZjlodmhNSUVZ?=
 =?utf-8?B?bjVtL1NjTnlYMFhMQldzNnlvQ0ZxbkxRc2FYZW9QUHRyK0x2dklKZkJqRGhw?=
 =?utf-8?B?WjVhaWxseDZsUzlBbXR1aWpYV254dC9IZVQyS1pMTkh0aEl6NENoK1I3S0ZY?=
 =?utf-8?B?OW1RZlhrYlk1T2JDM2ZqR3FLLytXSGJsMGYza2k3UFFaNU1tNzFka2h3bk1J?=
 =?utf-8?B?UU9RdDBFakIwMDJBMmdNUStoMldHNzg0dS81TUdyVlJRY2Y0RTI2ZEt1UGVm?=
 =?utf-8?B?a1RIYUc3VjAvc2RNRjJkSm1Ecklob3FqdjhqRTA4OTM0aGhiTHVaNDJUS0U0?=
 =?utf-8?B?THNEQ3pCVEZTdzdCazF5UDRTTXNuU2Q4bmJaN20vdmZsc3hKRTBQWXNKNEJQ?=
 =?utf-8?B?MHFmQTNyOTBQWW9teGdqREQ0eHFuZHRnVU5aSnZvaG5tSG1tUjZ5RjlWeFNL?=
 =?utf-8?B?YzQ0REQzdmpxdGRZdGhDRnFYV2hBWW9KWDVEaW03YXA4SUJtdlFtSFFLZWQy?=
 =?utf-8?B?Z2NXNVBxM3hXWUxyNlc3cUZ4OGxGajBEam9OSDhzOURVRWp2NnJQM2o3M1Vk?=
 =?utf-8?B?QUNjQThscW4xZUM5UzhpdFRobERKQ2ZhRlFsZG1OQTE0dVdSRzJhK29FMmNI?=
 =?utf-8?Q?Ponk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:57:05.1770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c7536b-6a36-46b9-d586-08de3bfaf9dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9572
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

For gfx version >= 9.4.3, bind MQD in GART with mtype RW to enable
caching, to reduce queue switch latency.

Remove the redundant mtype definition in amdgpu_vm.h.

Call amdgpu_gmc_get_vm_pte with AMDGPU_VM_MTYPE_ to get ASIC specific
mtype.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 3 ---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0f83d140b6ae..4f8bc7f35cdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -853,7 +853,12 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
 	uint64_t page_idx, pages_per_xcc;
 	int i;
-	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
+	uint64_t ctrl_flags = flags;
+
+	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
+		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
 
 	pages_per_xcc = total_pages;
 	do_div(pages_per_xcc, num_xcc);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..e34c8f854b2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -100,9 +100,6 @@ struct amdgpu_bo_vm;
 	(((uint64_t)(flags) & (~AMDGPU_PTE_MTYPE_VG10_MASK)) |	\
 	  AMDGPU_PTE_MTYPE_VG10_SHIFT(mtype))
 
-#define AMDGPU_MTYPE_NC 0
-#define AMDGPU_MTYPE_CC 2
-
 #define AMDGPU_PTE_DEFAULT_ATC  (AMDGPU_PTE_SYSTEM      \
                                 | AMDGPU_PTE_SNOOPED    \
                                 | AMDGPU_PTE_EXECUTABLE \
-- 
2.50.1

