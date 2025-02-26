Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB69AC021B2
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 01:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDEE310E827;
	Wed, 26 Feb 2025 01:43:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="adi5FYm+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E0110E827
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 01:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAnDjjjHEFj4cjt7evpXzDym3ARwCxZKCIrPtFxgvjKXJjYy0KyL2aTxH5u/Ey5SGvpqNkle738yCXEDJph5RlaJu8U5JODptOeFpa92wJyAowHxXKrpbu62d8/NhXK7hzgEtokX5vyCzwbnL9pLAT2iCDel1kWT+S2MWKRUQvohgwUp4QFR6dzdiO56hmCdCvrApL+3UAdEiocqVwrwL7cEebYOpXp7CpLV7sPdgurAg8vGE8JlpaenGe0ePZq/7XZT2r2msP6IsFg+9FDpi31VUsTznv6dm/6ulUbgH6MhbMBCX0bTCEV9ULkvUHKPO2st8ktt+/JXaQy3+9iseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHRUizQBQqTpY3/sTU+wfHVTM07CxN5O4c2jjpFkyKo=;
 b=k2tj1innhZSqSIlajdQnt3ZPJbzAAgxlSsgXJ+ltjszUC5XjaoMFDzSV4CHfQYyZSEEc9jhKxYuGutnsPqucJMXbtnvQAdL0/itEJpn3LLTCCLPF1tp2qAHseydVds7uJMZ5BnUG1e0TxhCC2VI8zuDqrn6Ey+sRwXf3QSjuWyWOXvMFwFPKoQRJH6obdV6Z8dNHOViaLsDZoYOErx8GDuRmItwspop7V2N3OkC+uzYfCPp0U3C6aGWYWuWHPtpG9RHs+8KPSXOnjYErGtftOAHlq5vaE+zoDhd493tw+OItb1yaLZVQnBTBqcBJAZtgakwb6osmgYVb+kCmKKlnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHRUizQBQqTpY3/sTU+wfHVTM07CxN5O4c2jjpFkyKo=;
 b=adi5FYm+j2y8ictw/8YM0WoqM8GcNCYSZI43XiDoKo/zlpeSLTR1Qs8IG2ApxVaJJI5gFnb/Iuq2Rg6mI1bqjPud9iioyV/0rf2Ph/PTGJIQYMv301k6MJzZfoJI4b80D4wYG+KfJtHbC3pnnWlZqmRhjPUyjrIMz0nU4extQYU=
Received: from BN8PR15CA0010.namprd15.prod.outlook.com (2603:10b6:408:c0::23)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 01:43:33 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::c1) by BN8PR15CA0010.outlook.office365.com
 (2603:10b6:408:c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 01:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 01:43:32 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Feb 2025 19:43:31 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix parameter annotations for VCN clock gating
 functions
Date: Wed, 26 Feb 2025 07:13:10 +0530
Message-ID: <20250226014310.2426713-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: 1662cf10-17ea-4826-2780-08dd5606fa90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTNRZzZzaUZKVGlwSHYranpIVytramhUYXlQTzF3SmtDbkJycGZaQ05Na3Vn?=
 =?utf-8?B?MFdtb1ZmYVBGemovUnhaN2VvR1FiZmJBdGMwSGhDODlibjBvdDJmMHRORE9a?=
 =?utf-8?B?c0RLMWdFRHFmdG1KWGVONXdBbnhlN291UENLTjRhclYzYllkb3llbnFnWHZJ?=
 =?utf-8?B?VG01SDRBb1lRWDZxMVNBckNNYWVFR1FlNThpN01hWjAreGdNNnMzcEZxMnYz?=
 =?utf-8?B?b1pYa3QyNEpGc1dtZHBXUG5pSFNRY3VWbHpJc3ZUTWxNVlV4RGJUNmM4NUNY?=
 =?utf-8?B?b254dmNNaVZIVDNzYng0b011ZmRYaFNrQ1kvVVFzZ0M4a1VocUFCOHJURkFO?=
 =?utf-8?B?b09pOENLdk8vZklCT1QvQkhBR1kvdEJsLzZlR2x5dVRkbE96eEx1aDUwd25V?=
 =?utf-8?B?NmQ2Zk9iSEVqejNYS005dnpFSFFSSzJ2WHh3WWlLVHFUQ1UxdU5NSUJta3d3?=
 =?utf-8?B?TU5hYmxpU2t0TzZYSmF6K1NVbXBBbWZMeXAwT2NEVnlFTnpLMWdsbFpGOXY4?=
 =?utf-8?B?S05kMnZaTi8ybFFleGtyWVdXOEsvdFc1OE1QTFZmTEJjKzNQMmJKVjNOTCsw?=
 =?utf-8?B?WW9mUHNjQjM4QXY2T1h0YVlucUNZa0srMWxvQlhZclpja2ZhUCtMZnJtYXV1?=
 =?utf-8?B?YWY5S1dacFlDNWN1YUpUaDNZQk1ZRE9oQjBsK2xXbGVvU0JnUHkxRjUwam5k?=
 =?utf-8?B?YWpxSXUzWnc0blNoMW16MDFTMzFUc1NLL1JpUGhTT3RadkYwSnY5Y2VMMWcy?=
 =?utf-8?B?SWtiN201bzRKZjg4WUVaTmpZNE01M1g4U0dpOGxSTXgvbjg0UmZqWUhLdGV6?=
 =?utf-8?B?ajZFd2Y4eGlMSjFORGhZRUlTTXVSUTFZTTNha3JsQjdweHgyWTduRmowVWtk?=
 =?utf-8?B?VDFxbldUQmVUNEZzbCtzQkNQaXJOd1paL2hldG5IVHhrWHBrck8wZUFRZUtZ?=
 =?utf-8?B?WmIyQkEraG5BQXUzRkpnYm9LN1RiOU5CeXhhVVY1djN3aW9ycE9rQXZia1Fv?=
 =?utf-8?B?NWN6cHk2bmxUTUw1c3VCL3VzYU1pcUVVcTNOUXlrMWYwUlRteWtxc3Z2WnY2?=
 =?utf-8?B?YVJWU3Q0b2orUFJxd3RRcDh3UGhxYjVxcFFvOGlHTTIvaDNMWFpvV1VYcmpq?=
 =?utf-8?B?aHBEYWFTc05PQlhDR0dEaWN4MHREcS9wbit5cVdvU0h3VkhzZ3lwdWdZY2tv?=
 =?utf-8?B?b29LK01kQU5sSFQ0b2lHeWdkckpVQ25IZ2hKYkhyZGtPTnN3NkxpdW0wdjhv?=
 =?utf-8?B?RkxITG9QSmsxTVAvZ0xRZ0NuajFWb1pzT0xlSjFMRUd5bnlQdTJ0VkgzMHg4?=
 =?utf-8?B?ZlAyK08xZEFGWmFuVzVWT2hldytPNDV2b2VVaG4zNDFjYWJmQWpqNjBiSGR5?=
 =?utf-8?B?ejljVThFaWZCRVRXWFFDZkFYdDV4S2E0MllLakZFeE5wWXBoYmtCaTZRR1Fa?=
 =?utf-8?B?dlFVU1hSWUtDTjdrNjFxWXFUSnpCd3Fxdlk4Y0NnVWlEVkhFMFFwekEvNmM0?=
 =?utf-8?B?RGtHSlBZQStJZm1IREVDS2VNMzJabmVqOFJPZ1Y0Vnk5SWhPd084R092WkVL?=
 =?utf-8?B?eEl6ejY4M1VTWlFXUjdZUUF6emJTWmN4QnpLck1wa2ZUa09EbC81YnVCeTVi?=
 =?utf-8?B?c1dXSlB1aUtRTXYyaDBwaGlvYlA4eFQzaUdJeHZudmh1WkhBcUNBMTdrM2FB?=
 =?utf-8?B?a1RGTngrOE14SUtXdkltQUlkcmc4WlUza1FvM0VvbjZkNXNHMzFHNVBjcE83?=
 =?utf-8?B?Z3laMmNLMllsY1VKMmRVenhvQjdsRkxIempCYitCNWs3bzNhK2V3Yy9MRTJJ?=
 =?utf-8?B?QzBZL1hoOFZnREZINGNOZStQb3Y2MHMveXhMczZRR3B3QTU2TXdLVlNaN1NR?=
 =?utf-8?B?c1hvWUM1bEZNV1pIQytrNmc5VGk2U25DdkNiQXBhSHRMVFc5Y0txcTh0M29s?=
 =?utf-8?B?WmE2Z2ZBQWZONkdmU0toTW10YkRWWE9uOFhSL2N3VXV3SGVmZFV6UU94V3ox?=
 =?utf-8?B?d1FKUnJ5WGp3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:43:32.9553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1662cf10-17ea-4826-2780-08dd5606fa90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223
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

The previous references to a non-existent `adev` parameter have been
removed & corrected to reflect the use of the `vinst` pointer, which
points to the VCN instance structure, in the below files:

- vcn_v1_0.c
- vcn_v2_0.c
- vcn_v3_0.c

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:624: warning: Function parameter or struct member 'vinst' not described in 'vcn_v1_0_enable_clock_gating'
drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:624: warning: Excess function parameter 'adev' description in 'vcn_v1_0_enable_clock_gating'
drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:376: warning: Function parameter or struct member 'vinst' not described in 'vcn_v2_0_mc_resume'
drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:376: warning: Excess function parameter 'adev' description in 'vcn_v2_0_mc_resume'
drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:776: warning: Function parameter or struct member 'vinst' not described in 'vcn_v3_0_disable_clock_gating'
drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:776: warning: Excess function parameter 'adev' description in 'vcn_v3_0_disable_clock_gating'
drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:776: warning: Excess function parameter 'inst' description in 'vcn_v3_0_disable_clock_gating'
drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:965: warning: Function parameter or struct member 'vinst' not described in 'vcn_v3_0_enable_clock_gating'
drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:965: warning: Excess function parameter 'adev' description in 'vcn_v3_0_enable_clock_gating'
drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:965: warning: Excess function parameter 'inst' description in 'vcn_v3_0_enable_clock_gating'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 8bad63282de4..21b57c29bf7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -616,7 +616,7 @@ static void vcn_v1_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 /**
  * vcn_v1_0_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
+ * @vinst: Pointer to the VCN instance structure
  *
  * Enable clock gating for VCN block
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index f53feb60772e..8e7a36f26e9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -368,7 +368,7 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v2_0_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
+ * @vinst: Pointer to the VCN instance structure
  *
  * Let the VCN memory controller know it's offsets
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index a3f16fd69927..22ae1939476f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -767,8 +767,7 @@ static void vcn_v3_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 /**
  * vcn_v3_0_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: Pointer to the VCN instance structure
  *
  * Disable clock gating for VCN block
  */
@@ -956,8 +955,7 @@ static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
 /**
  * vcn_v3_0_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: Pointer to the VCN instance structure
  *
  * Enable clock gating for VCN block
  */
-- 
2.34.1

