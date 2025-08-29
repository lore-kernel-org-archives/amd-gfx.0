Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0748CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 05:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C0E10EB37;
	Fri, 29 Aug 2025 05:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NoWMD7ue";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2685210EB37
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 05:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3lt0ZAekeNMxjTE2RLbcXlf4zqcfUaLe8wIf8NHDn4Gb+1aEJVoj52LX4FrxrDtMtHW6DgebabG4tn1/8C7M3E+fXbuSwpGGHjXIjaeuF721vhVHt9f0+3cqoed712RokDWsuSmf1PHQe8kKiatZOkmHKEuMDuTLjeU+qrX2gjbNpChfCjjuGBl0FuF4m37Ol90W5JYPegZQeKVGR9jv63hk8bEY7O5Fss6HbEWBE5UdCpp9956Axc11SVIeI5cwDvEzkCQW9OtBQ6ChJ4DzRE7bQ1NJ33KYejm9ieaorN1aKr0wDMzhLsmnIkFZFu6FxJ9mDV2pstGvWVRijJOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FtSKdrbhM7sc5SBnTbKGx4g839Pqmn/OqnoTODfyXA=;
 b=KXZs870DVmVsl7bVqbNJhA8QWhDb278+cJYcJq4wRzdhZ/WquqR4ko6ENPOutnebCWD14EjuG8pEt6vSURDUFobmXNVqGh/ssnD73l8kJ+jgPEtd7iLUxhhxy24cD/B87JN16IfvNf8zVK1dQcCE2IqreP0+LDhV14Ug6Bp9RqNE9eUy+YvLJHr+nlKD+uNqu8ohU7UXWz0dMC/sN9UJ/qrikqSl4upgmXWmW6SZ8/mLR7j8ZMBGTtICfZwFFiObaIYU8TNmZNyUMhcFZ1QPyzerxCysJglAszOJ8OSa+AsADIT6NR/7LpoR2ZssZSn6mtUD4Xk7kkT+XbuQ16o6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FtSKdrbhM7sc5SBnTbKGx4g839Pqmn/OqnoTODfyXA=;
 b=NoWMD7ue4SgQa2g+SggV7fq8TnBCRGLGPjugEv5VCM4yqyGDGKenfexmRLewi8GQy2cs6bA9uBrX0n6VzrOTmOOl2M/Ad59lMI7YsCZ5XGnzy4HrOUVftHnqXeVBbvxFP8W/ektztvdtEHWgoIipSnupWhGmGLmtnrAlx98Jcc8=
Received: from BN9PR03CA0285.namprd03.prod.outlook.com (2603:10b6:408:f5::20)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 29 Aug
 2025 05:54:31 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::78) by BN9PR03CA0285.outlook.office365.com
 (2603:10b6:408:f5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Fri,
 29 Aug 2025 05:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Fri, 29 Aug 2025 05:54:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 00:54:30 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 22:54:28 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 5/9] drm/amdgpu: Add mmio_remap bookkeeping to amdgpu_device
Date: Fri, 29 Aug 2025 11:24:20 +0530
Message-ID: <20250829055420.3983491-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be05203-47bd-42cb-419d-08dde6c085a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUw5NWt5Rlp0MS9xNUFwdEZLcDczRUtLdm51T21rdlpNWEFYUXJIc0lJOXpt?=
 =?utf-8?B?WWFJY0NwSXVUUnVLM0l5RHNZV1gxRUdneEtIM0hxY3IwallUSUJRTk1oQ2V5?=
 =?utf-8?B?WEhSenNzcGhwQjY5VEczQUR6YWZIS1IyUGgvdUNlc0JxOFVINjk2aGdUQll3?=
 =?utf-8?B?a0F4MENmaDd5YXRmNGJQaXlFZ1pqYVlaeTNPZUhKMVNqUlBEZVZidUc2bm8v?=
 =?utf-8?B?VERNOHJuK2xWbEk4UEF5L2xEYzlkakk4V3F2WWdHdWRoa1hWV1lRS0RWRmhB?=
 =?utf-8?B?OEdVZnNKVlJUSHJ4bXRoUFF1b0w3N0gxZkJ6b3NZczZ2RW5XcHQ0ZnA0cnNY?=
 =?utf-8?B?MENONkRVNlBWVVN3WThMcys3ZHdIbVh0am9ld0EySFgyVjA4U252a1lBYmlx?=
 =?utf-8?B?V0FORGY0dWJCdFcwK1VSQjdFeHArY3V1OHFvNEt4YnNOeTdodE8vTEUrV0dN?=
 =?utf-8?B?VDh0WmZGY2tRaEZaTitVK0oxSWIrUFVVRHNHL1Z1d3BFNDViVlhYZ01MVDk0?=
 =?utf-8?B?R2FNdjVDWWd6MU4yWTFRbW9sY0JxVGRsVExrbERycktGU2x6Y2RWWWo1OER6?=
 =?utf-8?B?dEg0VXMyMWdXRjZYWUw4TGg0OEZGS1NhaEJLcVBpaUhRQ3UySk1uelNGbVQ4?=
 =?utf-8?B?Q1J1SG43cVNIOCtnVFhxL3p6cXpPVEl0UEZNZUkzU1VUSW5jV1lqb2pQbk5N?=
 =?utf-8?B?M0lzNXZNZHZTYW9odFl6clBJdWt5cmxDRXRMdXNVemZvMm9UM3htNEdkMGFI?=
 =?utf-8?B?SVZpa3VEVndTVzI0R251MXVNUmlPeXlyWnRmd3Era29KQ2hjenBQcGZxNlYz?=
 =?utf-8?B?QkJndkp5T3NaS2xkU0ROMTBXMEdDQURqRndxTjU4RVBmNk41dzhoZUxSMldM?=
 =?utf-8?B?dGFqdjBuMFY2LzVFZEl5Ti9Yd2orYmtzLy9XUWtmUjA4NFExbk5XR1RRMGl2?=
 =?utf-8?B?YVI0a2pjekpNZk9aWmorbCs3VjlsZEdabkViaDhkTmVibVNwYnpnVVBoZVNC?=
 =?utf-8?B?L2RVdTk0eGNScjZXdDZzN1dxenRSaVpBQnFuMlB3aTFTaVA2VG9uajN1S0hz?=
 =?utf-8?B?cnI4cC9QRmZVbXZ0S0dDcVFFUDVYcGh4c3QzL0pxbGVtNjB4a1RBWFErMmpp?=
 =?utf-8?B?cWZISFdiQVg2Qmdiekt6dW1zK2txbVMxTXlPWkJ0VlNOZTBXN2ZpbHNWTnhr?=
 =?utf-8?B?cXBueEM1YmVZUjIyTm0rNXFlS1NETmxNTXUrb090OWV5OTdacVMvUGhaa1c5?=
 =?utf-8?B?blhQbytPYXdqQjJxcUZJdmxvc2JnSVhTL3JQamdvSS9IT09ScVFQb1RGc1NF?=
 =?utf-8?B?dStiU05DMjJ2U3lIcWczUFFxdXZ5MERGbGVLYTM0QjZHZHhLWGMxRy9UQU5a?=
 =?utf-8?B?MTZNZGh4YlB1alJCMVovL2h6OHg0YUEzMENVNzFiRStDSXdLYlUvNzhmMXZT?=
 =?utf-8?B?NFV5b09BYXZMdWhpeUlrMVBzZWJKQlNvSmVrWm5JUHkyeE0rVGZxK2liL1l2?=
 =?utf-8?B?dDhqbHZoakJ6TXVzMkluUVVLaTBMT2lZbDM1b24wT2xCNVJ5Umw5bHYydVdF?=
 =?utf-8?B?RnlhUUVibXJuYzQ1S2FQcWIrbDc5dFBKL1pFVVlnS0IvVTFBU0lpVkpRL253?=
 =?utf-8?B?NFd3T253WmQ4NXFHYUtaT2RpODhONWkxcC9mY2JvanF0UzBFTnpVKy83cSti?=
 =?utf-8?B?NWFldFMxa1RzaU1tb1JlMjdOVjBtU2c0c21oRzVyR1BmeUp5TGhOZ2FidzVm?=
 =?utf-8?B?eHRTYk43MnQxUzlucUErbGl0K0NSRDJlZS9pYzBVZGVtZVZrQnZOOGtrd1h0?=
 =?utf-8?B?RWhUTk9oUHFjYmlJZnJJeVZ3KzNzQnpRQ3gwSHRGWmxpOEtwVE42dTU5MDRm?=
 =?utf-8?B?eStZdkhrbWFlQUxwWEwwdTJUM2NlQmVMOXlmNGwvV1QvanNGU2hZNnJ2cHMv?=
 =?utf-8?B?SGwwTGM0RlZFQTJ4cHRWVk9iUUMzUnduOTdja1FaYlhGTVNoYWRBT25IYXVO?=
 =?utf-8?B?dmNNOGNLK3FPRXNyQ3RJWlhadXRXaVNYYWgyUE15MTZyeThQV3lVZG5LeEU2?=
 =?utf-8?Q?SCicBr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:54:30.6573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be05203-47bd-42cb-419d-08dde6c085a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
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

Add bookkeeping for the remap page to struct amdgpu_device:

* bo:	kernel-owned singleton BO

v2:
- Use existing amdgpu_mmio_remap container; remove per-field members
  (Alex).
- Use AMD_GPU_PAGE_SIZE (always 4K) per Christian/Alex.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ddd472e56f69..24501d3fbefe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -752,6 +752,7 @@ typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t, u
 struct amdgpu_mmio_remap {
 	u32 reg_offset;
 	resource_size_t bus_addr;
+	struct amdgpu_bo *bo;
 };
 
 /* Define the HW IP blocks will be used in driver , add more if necessary */
-- 
2.34.1

