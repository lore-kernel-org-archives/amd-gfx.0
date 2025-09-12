Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D0DCAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 05:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8511410EBA2;
	Fri, 12 Sep 2025 05:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k4m1J7rZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6026B10E44D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 05:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQhT4kR4xx4ohIAGyhxbzyaGdJbQK9BzF76fFJRTIqIAfXLFvpQzEU82t+qbuC+DDlE+W2kXDhiu1nIUjdtd80tGgLWnnem2C1MvuPwWsLG64DQ0jF3qIQIYrZ36KWCKFkGsWOxdgyT1ClQaW0x0Nu1szvHM2JP+E56BO0KqO1E2RYhU7ype4f9BdPPtjq/tjFtTgxL0DLrQWt1W9xR1YpVDvDdj3Ufa3JaWoQtCsFQOfp8zVzR7Jx0Gs/tiizQjsQwdOxCRhok95KJ8odyFTImL1nMbD3O3yFansfZmNeWyufkvxYCnWCwFckqeAQxMesZ7og+NTTiQuHlNUepbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkKYQfrpiIwzhHHHjRKoKXsfntI3ODbOVIkXj0EYutg=;
 b=buy6clEblTnENxXpzUyZYCW4EotfNVSjIq/GGiXjTfI8Mdhkb3yvJatM//KveVz8TXivSXUroaOB67hBtlWWbnjbBiqygTazTF+U/MsbZPQgAN1o2VGBxQJEaySlZNiVETDGg3dkHFsvmNUjDWiKbAo/TBibzol5bVjMm+ARNjmQz052b9dW9lGJGqjE8crqfiXh74AdmKWO6ExnJMAnh2hzMXBhluhl4K2vfuzWlAPLTgx3r+EF6VrLhYlG+UzSBh0TVT/UH+lVoCv+2nNyXPhINX0s+L88fXpWOeZrCOEP1TYk/uOqQo5UZzVKjDcPx4TTflHmJNEp6kCuCK5aIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkKYQfrpiIwzhHHHjRKoKXsfntI3ODbOVIkXj0EYutg=;
 b=k4m1J7rZX8eDnwy0LJPehFTuK/5RUawCx6PzmwATozHZD/yvm9cVtqloAE5V1c+ygDfAXa0hnKqNrtdURD+iW6XCOtG1UTZTWLYUGBIzZhmxuwp0YyVSrV2AZRc3k0fFZJ2Y3fbZJxChtbPZLGLRA5l3GnirrL1mMPu0iPw2aNY=
Received: from BLAPR03CA0092.namprd03.prod.outlook.com (2603:10b6:208:32a::7)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.13; Fri, 12 Sep 2025 05:55:43 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::ee) by BLAPR03CA0092.outlook.office365.com
 (2603:10b6:208:32a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 05:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Fri, 12 Sep 2025 05:55:43 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 22:55:40 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v2 8/9] drm/amdgpu: validate the queue va for resuming the
 queue
Date: Fri, 12 Sep 2025 13:55:17 +0800
Message-ID: <20250912055518.2719533-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912055518.2719533-1-Prike.Liang@amd.com>
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a2eb24-36f0-4498-f791-08ddf1c102a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHV6TWIyRkVkU2lPbkVwQTRyM0FMRDJYWHJkWURvUnhrb1JacGJEbnNXVUlr?=
 =?utf-8?B?bDFvaDUyTTNadUVMZmpNV2UxRldjalN1d2R0MHVFcEQ4bEg1cWUrUUhsYlBU?=
 =?utf-8?B?Q3MvNmNWRi9jelJ5U3p1OHB1WVlEbEd0NE9FY0p1VVdSWFBSYllXRWhHdm0y?=
 =?utf-8?B?Tk5CYm9IMTdiNEdVbG5jVHhTY2ZVSHMvU0ZrL1pBVjdPV3ZpMjBHeTB2OGpC?=
 =?utf-8?B?WGo5WWVTV29WVTdROUJocUFuSk9hcGdJTkV6eVdOd3RtUC92T3JCWW5HRVlj?=
 =?utf-8?B?SjJlK1FIQjZDZVRWQlNBcXk1OHMxL0xQN0ROa1JNZXRKdkxld1NoWGRzOEpo?=
 =?utf-8?B?Zys0VGRIc25mTTdDcXA3TTR1NmU2SElDYVhYZVdjb3FZbUQvWlQ3emdiaTNy?=
 =?utf-8?B?b1RBT0xBK1B4bk10RDNQZHBqemM4VXhRSlZBbjE3LytocEtMWFRVRWM4NkxP?=
 =?utf-8?B?d290S0FUMm9hNytScnEyU1hRaDFSY3FkN1ByK3B1c2Q3d09vYzF5L0VGSTR5?=
 =?utf-8?B?eFQwajgyZDFzamIycmV0U2xEb1Z4bHg2bXdSeFR0eFNNZnNlaVBGMnpYSmJy?=
 =?utf-8?B?Sk5YMnFzZjlOMCtEU1VCR2xZMjhHa1hvRWY5c3h3WXAwdnZNSEpBcXFGVVVV?=
 =?utf-8?B?MnYxb3hvR3J4MWREZUJmcTN4cjU4QmxlL0w3QmZRNXNsbHgwMldRaXQ3Tjkr?=
 =?utf-8?B?aWdGa3M2VGpzMVhPNVRzM1YxbmV2eHZ2UGlVYWtkU2wvL2hQZEphb3NpN2Rk?=
 =?utf-8?B?K1pNRGFjMVgzWnROM0ZZSTl6Wm5TM3V1N2lCL0Q4UDZYZUZZMTE4TmYzSFdG?=
 =?utf-8?B?d1hHTkxGNnV4QTZuMmQ5eC9CbkZSUXoxYklyWSsvdlJlNWE1dVFBbnJOS3RB?=
 =?utf-8?B?dVZ4ajQ0S0VMWHJRelJQQUJFbnVMV0tYbnUxcFB0bUhILzN6bTE4bFcwemx4?=
 =?utf-8?B?eVZYcmRoNlpMZCs5c0R5b2Qxdi85SlA4NEd3U0hpcnBZR2FSbWJFaUNFZjN5?=
 =?utf-8?B?SDhTOXJmaUJkOEhwODJyRDhpMGNjMzFrUUNTekFJdDhQVjR1RkVJVmdMbG5z?=
 =?utf-8?B?WDhpMkVEcFRqandlYlY2dSs5STE4NW5NQ2MrMXFWelhReHkyb3Vva1JPdUcw?=
 =?utf-8?B?WFpwMlZPN3phVHlleExnUWRZNWZNMytDSUVhWFRMTUJMQytrbTQ2YVNnS0sy?=
 =?utf-8?B?cEdyUWRUSkNNQnlKZmZvazJyNHZ3K2pvcUUxZHpPeEYwblVRZjNYZ2oxcjJo?=
 =?utf-8?B?MHpxTENVUTd2TmRrMjJQWWxoalFONmdDdjRJcXM0bHZtQnkwSy9nOCtRMkFw?=
 =?utf-8?B?b21yRFBKd2JoZlh0dW1lNlc1L2hCemZhT1ViNEIxNzhzR0FDT25pZ21udVdE?=
 =?utf-8?B?ZS8vcWxUcEl3Z3U3QytwbXZBNHI1TDdjaEZoTmhzT0d4eDFVVENzSnh2UVow?=
 =?utf-8?B?aDJEeUl0Y0M3Y0FRRzBCU29VR0NYRVp2OTkyd3BjbUJ0WkZVL3VXUFpVWGdk?=
 =?utf-8?B?cmp0Q2RTRFpIL3gvL0lHNktRQXRnaE4rL3hRTGlRelVmK0t2VUZtRjdBRGs0?=
 =?utf-8?B?c2U0SjVXZHIvbG1yRkdzSFFNSEw0OHdteEY5V0k2Z3hadzhNZ3luNGloMXBE?=
 =?utf-8?B?MVp5cTJOQlVicE9iQk5uZllwMmRPVnRQTE13QjdxS08veVNEbWpad0Qremo0?=
 =?utf-8?B?NVA3R042aDY4QU14azZobmx6eGdpNHdXVDBsTTJUV3UyVmZZRy9RQ2g4a0sy?=
 =?utf-8?B?YVJqY2YxQzRQMlhBaVV3YisrcG9IZndNeGhYM3hHa1lMRU92L2xmQk9naXgr?=
 =?utf-8?B?K0dhcVBKL1pxWGdvRXBNNis1NDFVcURtcTlWVnp0VDNxWUtlMGVpNkdqVGlo?=
 =?utf-8?B?cGNsTGxwZ3diU251K3dWYzNJSDlFQ2lwSGF3V0M4ZTJjVyt1alREUVNpWm5j?=
 =?utf-8?B?K3I3WUxhSUhsc21UN3REam5KdnlyMks4S1Vlb0R4T3RwTlJkNUtHeGxKYjJ6?=
 =?utf-8?B?NjBtRzlDTytXR3huT2dnaGt3ZDlQZEZjSFFOdGxlamJKRmlsZWR1ZzljUzRY?=
 =?utf-8?Q?zAb1Da?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:55:43.1596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a2eb24-36f0-4498-f791-08ddf1c102a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 24 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 957b26ca2eb7..a13f186f0a8a 100644
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
 int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm,
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
index b71fff65a896..8cd307be7256 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -156,4 +156,5 @@ bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_vas_put(struct amdgpu_device *adev,
 				struct amdgpu_usermode_queue *queue);
+bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue);
 #endif
-- 
2.34.1

