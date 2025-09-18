Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3435CAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 08:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5886910E671;
	Thu, 18 Sep 2025 08:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bozVmhyo";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81CD10E669
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 08:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNaL8OgQQVRLaOzRhIidQ1d/9O6/KMRC3VfetjqeYRbexkmRK9kKkVdB0Ow16te9SqatmzxD0GJ0Vq7I4Zs6s8TDncnVeSFKHTx6xuZgU6GZb2paedYNOTnkhhcsNV5373DnvYiFA85e41QYcVpwwawFY30AwhCImGDgqNp9e1xqy2Bt3RzXVqbUs1i3PmT5nS7UA6fZbDTGyT8b3dpWoTu70unOj+fLTkNLsljLLe2p08ZXuE/dty3QjqQod2sMdgqZRX1c5n2y7gDY+bnQNQEHgQ+A1QzsVJTo98fm6cTAOcmMr2WnRb6G1rH9n6gsrYxkbS5irw7MNWJcvKAsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVtyqWTgOluKIeupEJ1MECel7MIqTerVan0O10GqBb0=;
 b=cJW7myZ6jIw2i+ffGPiEftj9Edw2jxm7DCZ3lN9Vu7jvd0DZLs6OtuyQDgxPkYV9pL1kXZlj0SvQJWiZvgGThGC5vkojPmsaKdr/5sG29fOLdWbJFnyS2w+SDIrhv4829TNmE4nz+k5PfBaHXEYp728K3Pn4G4jU/jSFvf4v9dLXIApWU9IlaCmrUz9vdzjnEUfWTpEGsyMKfGcvl26EcW90hol15GFId/sWr2OYcKsjBYIpcwhaX1sHRvn2hR7e2mFilOzs868JVKkSR1h81Xayc018OjUdjwjPfCKC9Jpr9B3hsxCmNxccuh/5/tQwBtTNM5eXVTl/2GGIjTzlGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVtyqWTgOluKIeupEJ1MECel7MIqTerVan0O10GqBb0=;
 b=bozVmhyoz7fYiasrE9U8LwZ6nwkmbS9qiuEakUbn8mIp0XO8G9J588mCOlCfMZCDLecuLKU8CHOXKlv7cRCA+FIy5XMfY3uy+5MXDfOkF+F8fQJEyAVdTwUt6qcNjbk8f+iOF/7gbB0vxOMSYE4mPSYaF0VW3sZuhyA2bRji0jA=
Received: from MW4PR03CA0241.namprd03.prod.outlook.com (2603:10b6:303:b4::6)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 08:18:54 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::67) by MW4PR03CA0241.outlook.office365.com
 (2603:10b6:303:b4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 08:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 08:18:53 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 01:18:38 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 09/10] drm/amdgpu: validate the queue va for resuming the
 queue
Date: Thu, 18 Sep 2025 16:18:14 +0800
Message-ID: <20250918081815.2755437-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918081815.2755437-1-Prike.Liang@amd.com>
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 55233d67-f545-41fd-1829-08ddf68c017f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlluNTNLNFg0OGdST1J3NWZaVW1qRE5pbU9NSElDTkpXL0ZaTlJ5VFd5SjNp?=
 =?utf-8?B?SGxSMjdsQXpUdUZudVIxd05XM0JIUjhocXFKMmxDZTRUUCtHeVVsRS9rMGFo?=
 =?utf-8?B?SUR4Nlk1MWRTSW11M0lwbE53OUo4NW9paTh0TzIzM3A5bkt6LzJqWEFzbFlU?=
 =?utf-8?B?L01wdTYvcmpvbUU0NTZIQ2JPM2k2RmNNYitkQlROWkowMHhaekw2b0M1dFIw?=
 =?utf-8?B?VktVUHA2TXZScjRJMVZaNWRRNk9XeFpNNWE3eHpYSHNqWTllbzVIMEFnb3RY?=
 =?utf-8?B?VTNNVFhjNkltMUpHdDlVZDJRakdUNHFkeWJTZWRqbms2Mm1HZEdkSWpFc1ZT?=
 =?utf-8?B?YnNvOWF5WkRaSVJiZTJGZ1RNMzByL0F6Vjc0cXQ2Z3N3YUdPeERBY2Z1N0hL?=
 =?utf-8?B?QlZKYjU2SU9sWTNnR2Y1Ym9leUlPajhUdEhZdzlqTFd6UGliMlp5U0NvMVli?=
 =?utf-8?B?VzZVSmJVY3ZVdDhheUhUYWFQdEpIczdaZi9YdWF4TzRnYkdxZkNTYlJWRU43?=
 =?utf-8?B?U0lJSFkvQisyUzdzZm4vQlJWWEl6MmVTTGgwWVFWamdCWkhTT2dHUVM4bE5a?=
 =?utf-8?B?QVdvMDdaRXJnYXc5b2d5WDVhbkt3a1A3UUdNSFBFUnBralkybmxsNUZOSmhj?=
 =?utf-8?B?STl4cm9HUWJaUE02SUlCNjYyZlhZM3JrejN2K2dYN1VNU2ZoeGV3d21TdGhN?=
 =?utf-8?B?SCtMcDk5aldhTlFQYk1IajBKaXNyZ2tPVW9BTUFOeFFESThKc1cwZlNzcitq?=
 =?utf-8?B?NFZmWG9qWTJxYURQbExMeEcxNHRpU05XNVMvTFNFSWFuRElHNHVOWU9iRmNp?=
 =?utf-8?B?ZmYxZC9COVc5R2NXRW5vN1V6aTBXQVNZdExNVTJFRTQrQ3MxaTBMeXVLdm1j?=
 =?utf-8?B?QkhMS0JPVytXcFZ1YWhHb1ZobDg5WXk3dTFxMUlINmxDT3g2a1gzam1hcEk3?=
 =?utf-8?B?OUVMcGVqMXRwemYrVVRZblIrUHI1S3FMbDFvUUNvaTljUEx3akg0VTlzbmkz?=
 =?utf-8?B?bXkwS1VoTm5UQ2pyQ0hybkpGbGFiNk1kcjhOZW9wR3hyVTRVQTQ4Y2hFQkpi?=
 =?utf-8?B?OVJXWElpVEJjZU1MZFYvWFlDN2dEWGEycVVuVUFXekhxVDJyN1Z1cVM4dGxz?=
 =?utf-8?B?bVhzTUdOakROd3NZTFZ4dXllc054blIvZjF4VFdaRzczUk95dTFnZVNucnVs?=
 =?utf-8?B?NTQ4UHovY20vbFo5S1NlRnlNelZYR2V1a3FqQ3VLaHAxZTZWK0tqcmtqWndl?=
 =?utf-8?B?Q3ZkcGduejQvZFFLaU1FOU5YNjZZV2ZWNWN3Tm5QS2ltaHBPRG1rekEzMFFS?=
 =?utf-8?B?Z2IwM2ErZ2UwTktMWUpyck1qMTJnWjBOZHZXUDd4clc2RlZXODFWbExrOE1v?=
 =?utf-8?B?YTN3S1F0WTB5OUdCL3JYamNyNGQ2ckZWamJSU1JxWHcvdnA2bjE5OGZFMlBv?=
 =?utf-8?B?WGhrdzFNYzJpd1U4b1pXNER3cUpXeG5KclM3V1VlQWdLVU1lK3BSbTFsVkx3?=
 =?utf-8?B?M2oxWmZqYUhkaDl0RzZPTWU0WngzYmlvYkV2MlgybmJCT3RHS3l1MnlCKzhx?=
 =?utf-8?B?blpOd1hYcHd6QzRGbHIwdWc4b2pFbTU4T3RmdXpBK2lhbm1JL0FXNUpNaU5O?=
 =?utf-8?B?U2R2Yk1yUzEzOS93YWpzVmhudjE0RkhTc2xYOFVyUUNBRFI1KzhrTHFaaTUx?=
 =?utf-8?B?Slh4QVJma1dOcUFpVFBrRmNPM1lVMng1azVORzV1RGJjcmNpNlB2b1VrcGNP?=
 =?utf-8?B?eFJWUzlwWHM5dDF5ZmxvelU2dU5VTFdEakRUTVhYNzNuOXBhNEZsc1pjdGxN?=
 =?utf-8?B?M1o1T3UyNkh1VDVSZ2tWR1ErcUFrd1ZHOHEydWpKS2ptOXRjM2toT1VWU1BW?=
 =?utf-8?B?eDZTamZPdmF0L295dGJYYmNXNmErUlp6MDFOMUk5TE1Nc3hYRkxvSVF0UVUr?=
 =?utf-8?B?Z3B3V1dRd3FZMWFJSDJCYzBKQmxidWttbkxVTlJtNDhkNWVrOS9hSnlMcmdt?=
 =?utf-8?B?eFVlb2psSFVlemtGdElsWHFhOXVxWEk2QXpVUUM3YllseTduYzdUaEN5cS85?=
 =?utf-8?Q?ugj7LZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:18:53.6108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55233d67-f545-41fd-1829-08ddf68c017f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
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

It requires validating the userq VA whether is mapped before
trying to resume the queue.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 24 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 5c918faca776..6d21d02d7647 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -115,6 +115,23 @@ bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 	return r;
 }
 
+bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
+	int r;
+
+	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
+		r += amdgpu_userq_buffer_va_mapped(queue->vm, va_cursor->gpu_addr);
+		dev_dbg(queue->userq_mgr->adev->dev, "validate the userq mapping: %p va:%llx r:%d\n",
+			queue, va_cursor->gpu_addr, r);
+	}
+
+	if (r != 0)
+		return true;
+
+	return false;
+}
+
 int amdgpu_userq_buffer_va_list_del(struct amdgpu_vm *vm,
 				    u64 addr)
 {
@@ -772,6 +789,13 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+
+		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
+			drm_file_err(uq_mgr->file, "trying restore queue without va mappping\n");
+			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+			continue;
+		}
+
 		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index e03bfa38c9ce..2cb17d47d30a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -152,4 +152,5 @@ int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
 			       struct amdgpu_bo_va_mapping *va_map, u64 addr);
 bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_va_list_del(struct amdgpu_vm *vm, u64 addr);
+bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue);
 #endif
-- 
2.34.1

