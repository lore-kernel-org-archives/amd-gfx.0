Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91764CCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 15:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2339B10E2D6;
	Fri, 31 Oct 2025 15:15:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lWmXqD5V";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FBCA10E2DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 15:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvDDTSpV89l+dZc1A/xyAn5kUQbxEGkjKbkqijp7NUyJ9d9gdwkeaib2K/omPx83BM4fW9qKtGGoyqfaCw6DDugBBehF1loNSXWsLNwU8zSncuN0UHd0t+mMb6jqd3aS3YEl7o0o5rCdmgm39Vt160/beNrT4w57zD/bSOyhSliu42llPfgt4LF/POC3kotkDlQ+eYLi7ZQ8bMCxRi/LjBsW9E17bzVo97Ls0yc8dzuvalPJ1fuxK4Z5v7qC5/FeqXbNHJs7jbA2rvdZUqdH698tU+PylMvHQ8iiOvk6YmD3cccfUxraQjQyo+fPZCC1KWDE9gaLdyFnSUscCxRucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Owf4Xm+xS12vZENitzcXzrIQViqKBMfdtUEt8jhrMtQ=;
 b=AtIUUyShxQ/r5HpOsNXoSjgdgSqEnKF0N/8pM7R8ODBndhuoNBwsDEbFQp2t3rIY61/EpHOSBk/ySukaczf/g9+Zz8pQbwyLQhPUHbgzopJwUNSfhik7HCwnzJCNZRQwdZvJR7N20Es381R9U4m588p30eF9s56nFT6CnBV3R64UE8cPtHud6bcjzcE7mPQ/7cA8v2Fn6rnAoAG6xaqCbRsnC9H18jOIzi/tcsM+pCuQF128BCn/i9f7bnohZwcrPgbto/ZKz6BSxPpvMD8EorAed2AnPsJIX7zHb7f2MSk9yR5aHyNSEz/P07+7KJeFMiXQhj7XssI4vHYFH9QvJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Owf4Xm+xS12vZENitzcXzrIQViqKBMfdtUEt8jhrMtQ=;
 b=lWmXqD5VdQADfCKHvFUAp7U++3NuBRPYG8p53/h3A3+4i4xBGA9lODjdetV7fHemmHXLk848Fd/T593rAFmPX40a4tSvSNfe8saWF1Y4N6Gb1OoZRLkaChobeK9aZO6q0nv5n5UgLMaqq28nQLJyr5d2CERfHkqFpNM4Ax1+e+E=
Received: from SJ0PR03CA0159.namprd03.prod.outlook.com (2603:10b6:a03:338::14)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 15:15:13 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::5c) by SJ0PR03CA0159.outlook.office365.com
 (2603:10b6:a03:338::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Fri,
 31 Oct 2025 15:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 15:15:12 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 31 Oct
 2025 08:15:02 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, <Gang.Ba@amd.com>,
 Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2] drm/amdkfd: Don't clear PT after process killed
Date: Fri, 31 Oct 2025 11:14:44 -0400
Message-ID: <20251031151444.16251-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 860baaa7-7340-48b6-16c9-08de189049ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czk5US9zaUdva3daRWYvM3kwS3ZMNFFxYXg1WXZQK1VPMm9IRkJMYmR6RlQ2?=
 =?utf-8?B?akl0TTNKcUF5eTFMeXIwSzlwNUV0QzlqK3JKeFJ2K0I4U1lCeW82dUp2WHBs?=
 =?utf-8?B?emlqd0VxMGVCQy9ENWVFSVB4SCsrSXJNcGpzSis5eGRJcW1QRThtUWRSc05p?=
 =?utf-8?B?R2p6MjdwdTU3ZUs3Rmc2bUtCbEIyVHhjNGhHdGE0VlBSVFVoK2xodDdHZzYr?=
 =?utf-8?B?WUgrS0xYUkRWTHFJUHBqa3R0Tk9PeURzWmZLNTZHazhNZVgySmdldE5sek1h?=
 =?utf-8?B?dHNia1hLeVpnZGNWNHFHcHVVMHZyU2JvOVZoUmpjVmdJTmwxQS9iMGh3V0NI?=
 =?utf-8?B?MURaN0g2YWpva0JqK28xczBxMWNlZ1VXc2RQbmxhL3g5V0JiYkFwQnNlK0lY?=
 =?utf-8?B?K3FROUwvS2Y2QmlsVk94L2k0WHBEUnRqVTVJVWtoYXVRWlRSdVdmZVpsSyt6?=
 =?utf-8?B?WUY4RWJyTVdmVEN0MTUyUG9QR2lKcTZCUFZ5QzhXNUZ4NDdQeFZOUVI2eTgz?=
 =?utf-8?B?aEx5TCtMUVNJMHdDZDhWdTFMS2VvUHRFeUhMcWRvUGRDTjhnRmJGWEVVSXZu?=
 =?utf-8?B?Umo4TFpuQnBxLzM0VnIrclRjYnUzVzZLZE03azRtbHVLVkM5NDUvNEJ6R0N1?=
 =?utf-8?B?dXhpazlBZGczaE1teDdSYk54QjFDWGdlbExMd2o0ckpYYi9FZVVsY0Jva3Fw?=
 =?utf-8?B?UHBUeUljRUtSUEpac1dDU1pYYStIMDNQQUMwcG04NnFRZUJVUlp4clZhYkpW?=
 =?utf-8?B?eU9LekY2OE5CcVE5OUdvclBSTE8zVG5mNnN4c3BnRnozcWlrMlByRHVEUkND?=
 =?utf-8?B?STNCTVFPa3ozRE5uaXBBemZDM0hxSDVld3I4a2hlUGNzdlY4WHNrSGh2MXpj?=
 =?utf-8?B?dXl2MWRVQzZYelU4M0l0NXJlZDV0YnBmWHdYNFRwUDZhcjVuRjRKN29vejI0?=
 =?utf-8?B?SVZUWDB1M1JwSGlaVnhCTjFwUzVxNXFrNE1BYzNTUm5Mck5heTZtNzFCb1k5?=
 =?utf-8?B?cUxJd253blY0U2pqSmVEZXNoT1Vqd3FVbHVJbXBjUEQyZGxxdElONWdQNzdV?=
 =?utf-8?B?bTR2aTFDdkR5QzRPRnFlWU54cSs5clN5VHdHQzJ5aWdTQk1ycVpWRkNPbklm?=
 =?utf-8?B?ZFdOcndFdUlrVVBVMGdrcm9lRmY5K1pydG02aU90N3R6amc2dEhpVFIrcVl4?=
 =?utf-8?B?a2NoTjhKVGpxREV1N0hxNG5IN1FsRUl5NnVlT2VtMCt0aVNJRkVmV0FHYytp?=
 =?utf-8?B?bXp3Vk9wNXA4c3k2R0VvSEppU2RIU2U1QWFXN0E3ckdMVEpNU285WldXRzIv?=
 =?utf-8?B?OVVGT2hkMFhuTHgwYW96SVdCTFVMOTVTM1NlTnM0SEVTYXVZQUErVVY5RWlX?=
 =?utf-8?B?MkRyWGVjQktiTGUyQ3ZGaXUrcW5oN2NudEgzbzIxSVd2UDk0RmF3Q0hkL2Rn?=
 =?utf-8?B?YUxMRncwanBKZko5OEFqUFdJam42Q3lxY1NlYjR5YUk1am1HZWpXTDBKRlRN?=
 =?utf-8?B?Q2RZV3FBT2F1NktCM0dOZVlDZG96eS90cGdudExQTkxaZ2JWRTU0YVlPNTQv?=
 =?utf-8?B?RWZHYnAxS2srUUhmSUVIR2lINVhLMjNjLzVnUlhXYitZd1RxQ2N4bUJpeTNN?=
 =?utf-8?B?NlBXeEhqUEhLaVFTRFlUejlQakhVSWFKaTRTdUFTK0JzMUVoZ1VMSC9JNFRS?=
 =?utf-8?B?c0d5RjFPRUExdE9Wa1pZeCs3Yk9ESkc5MmVSMGhlRTRqUDFuSzVHUVB4dW91?=
 =?utf-8?B?Nm9IYmFYWW5IaFUxN3F6ZHBkd3RzZENMbktHa0EwLzFQMWllcm1YTGt4c0JK?=
 =?utf-8?B?Skg4Mk9aU1VYQjl1T2Z6OC9hSDhsNS92dTVZell3WXlOTUFqNkt0dkU4Z0I1?=
 =?utf-8?B?RnlQYTZ2R0VrM1VRcHhRWGxSdlIyYWlzUHJMdzJsSURWdmIvVUhxQit6RkpR?=
 =?utf-8?B?THA5V1pKWm1sbGsvVm9jaWJxRlRTaFg2aWxrRnFWTzE3dExwVEVNMWkvN2dM?=
 =?utf-8?B?WmJhZEdVWGxzcEJqWFZIS2lPN0JQR01KQVltT0tCUlQ3M1NlS2x2SGk5REZq?=
 =?utf-8?B?N25aOHdFNm8wSEEwWVN1ZzRmVEVJR3RFVUM4aEhrUXNJTDBSMi9KbjdZUFpV?=
 =?utf-8?Q?xhYM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 15:15:12.4185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 860baaa7-7340-48b6-16c9-08de189049ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
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

If process is killed. the vm entity is stopped, submit pt update job
will trigger the error message "*ERROR* Trying to push to a killed
entity", job will not execute.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 96ccd5ade031..b1c24c8fa686 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1274,6 +1274,10 @@ static int unmap_bo_from_gpuvm(struct kgd_mem *mem,
 
 	(void)amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
 
+	/* VM entity stopped if process killed, don't clear freed pt bo */
+	if (!amdgpu_vm_ready(vm))
+		return 0;
+
 	(void)amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
 
 	(void)amdgpu_sync_fence(sync, bo_va->last_pt_update, GFP_KERNEL);
-- 
2.49.0

