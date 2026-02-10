Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FF1EA8127
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 14:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A602E10E5A6;
	Tue, 10 Feb 2026 14:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oBktFTdX";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 865D710E5A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 14:55:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uen3XKdlvisXlVSyCHs9EPh6lhzfXtCKeHZRJt8hDyK3rSDTf3Sja4uBXb5nnA0n4IMAUZeP6q3SmLq/g2g4MR1H1PH1hIStO3pmotSDQtUhs/bHENig5i14tsDPOzjwwW5N+hRqxL3wnNVL5WwhTNHpHXTrw+GdO4YU9ZBGScgsC6RJR5YP5CfYeu5YEe2A+/V/2XXWnHfclxZkD7MMtXISAekhJ9prk90DiG0n3Yd7pZqwsdUQXrVuZxH5L0A24bJYq+tZFgaCV+0t9TWEoW3DlD9+viyM8+L8wvB55zZ3GFdRctiEaiJndZp7Z5FPVIODSb99c7LCw3DqzYbjbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJ54sw3Wl9zt96hig8artKZWC7ExEa49VRP9vYXZDK4=;
 b=ojMKa2+ry7OAp08CIQzDAfouBu30PZ4PP3GhOok9cL4h4dlku9H4k54UsG4quhjF/UGlUuDkSi0Vt+IK0EBjr86PJs0MtJ2WgdB3u1MLxNgYWIRZFcTMLor7EFtHOg+V/OxkrgkmK6XDNxZPzkxKDtE7N0SMVOisRavmQLwOgWnX6rS/fFD8nK/69ywq3rNtbsk+2WZ7Yt2cER8if1BP6xHXSd6heZMEt59BtMeE2S28ktySBroUo+OdU33RpfKruPwUh3wmjTJc1vjud9diqyJGSTeE4HOBXVpL97yisHyu+Kai3BrptIen3CTuMCFRj8byxgdv2Yg/wpu9iWJiEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ54sw3Wl9zt96hig8artKZWC7ExEa49VRP9vYXZDK4=;
 b=oBktFTdXOhe62/hP5Nz37bdf/AeqVul6QEdCofrPOhaUYMlon+Sky1CxBDWouqLWQcP99/vqStbvPdLCq0YT5FTaP+tGHtLYl24SHK4fH/VFhSpY/bD6qSpMJq5e3aHvu54IkXebE7Rgrtq6dXfrzqeKLvtops5xU2amQb4bsoI=
Received: from PH7PR17CA0028.namprd17.prod.outlook.com (2603:10b6:510:323::8)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 14:55:47 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::12) by PH7PR17CA0028.outlook.office365.com
 (2603:10b6:510:323::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 14:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.0 via Frontend Transport; Tue, 10 Feb 2026 14:55:41 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 08:55:38 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Make amdgpu_vm_flush() non-failing in
 submission path
Date: Tue, 10 Feb 2026 20:25:06 +0530
Message-ID: <20260210145506.1539775-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210145506.1539775-1-srinivasan.shanmugam@amd.com>
References: <20260210145506.1539775-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|BL1PR12MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 1618ea7c-dcd8-4e53-6d65-08de68b47607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Lys1WHFCMFc1SFpuQm9zdGxVUGtCbUloL3l4ZnM5OEh6YitKT0VzNXpLRWE0?=
 =?utf-8?B?SFdpYkl0YlVlVVlKYmcwNkpwWU03TzNHc1E2S1c2a2o1UFVHb21NMTVIY1Ay?=
 =?utf-8?B?VnNHZ1lHeHExQWRiWEpnNUJoWUs4OVYra0paN0lzTzFVYW4vdm1xTDBKclhm?=
 =?utf-8?B?RUg1SHU2TmYzUGUvVVVFM2lMdnp4Z0ZiRFN4cHdidkdjckd1Z0RLLzl5RGFF?=
 =?utf-8?B?V1VQQjlCamExeVB4MFphaGhHWElDTmcxZVFibUZISytKQVRwS1BZb3ZWS3Fp?=
 =?utf-8?B?bHhqZHVlbStXRGExT0t5SkIzRm5wWG5aRkY1eEx2WENkNFpGcUNPQ05HUFoz?=
 =?utf-8?B?MUdWUzA5cmVJSHhvc2dyWkZSbDNsNkFQNFEzVlBPRnp0M2RNemNFKzFCcUJ1?=
 =?utf-8?B?eTJVN2tKN3M1S1RiaDIwVURwOHowVXQrZFdNVFBDaWNPOC81WW1uK1lHU2RT?=
 =?utf-8?B?cmV3dlhob2dKMTBWbXV1TDNiOW1rTjFXaXhITmVmMVBZY3A4NUdBNlp1ejNu?=
 =?utf-8?B?M09JM3U0V3d6WEJZU3pkQytGTWRNL1BkdnlPTCtES2N3ZkNyNmZ1VzNUcDlv?=
 =?utf-8?B?dEk0clRFOURxNjk5STBaRGNOSVpCeUZxUDZLT0dJUTBVZVkxWkpkM0g1ZjdL?=
 =?utf-8?B?ekVNT1JMK0FLS09QcHN3ZDEvRlY4OXgrQ2RTSTlKMys5YnIzbHZEMDYxRXFo?=
 =?utf-8?B?ZUJPNWJ1MmlzVk5FVVhPRVEzQmhHMkRQT09iays0dS9rVFdwVVFsaTJ0ZGxI?=
 =?utf-8?B?UkZCOUdsWDdjTXNxZ2lFd0o5dFFPZ21UN0Q0eFpUY3crTmppSDhoQUlXQlRC?=
 =?utf-8?B?Z1ZXWndCYXpkYjN0cDRFbnFIRG52UGNFc2hQT2FEczNQRUdaK0hZTEYrck9t?=
 =?utf-8?B?a0xvYy9MeHlTaHVBSzg3SDd0TzZiazRrQm1MUUdNcG5Xd3NtWFkwNnRHb2JI?=
 =?utf-8?B?UXVMRkYzRXEwUUZaWlN0L3FkRUpzN3l1SWlrd01jcU5NUTIvWDFnRXVtR1R3?=
 =?utf-8?B?bnNyUWM5Z3pJeWtGelNtdHpzOVdVNGU3Y1BTSzZ2ZDB0ckpUY1luL2owdGU0?=
 =?utf-8?B?Q3QySjZyK3puN1Q4ZG15OWxIYkQ2aURuWU9RL2w2TkQxamE4QnFrZ2JJUTVX?=
 =?utf-8?B?eU5iMHEzeUdGbDB5dmlsQWpUSmNoSCtLK1VxQit6V2ZMRDZDeWQvTzY4alBE?=
 =?utf-8?B?ZEJtc3ZOOGFDUmY5VXUrSkpxUk1TZFV4Y2pYVTNJc3hnUlhrQ0JTVE1JUy85?=
 =?utf-8?B?bms4NEQ0dDYySE9rejFPWHNXN25hMXlWRyt4YlptaWRhNmErdWhrbkRndlZi?=
 =?utf-8?B?ZDFaNmpkY2dlc1NkUW55T1EvYnFJWm9xbElFSFJneG9ZNEJrNkl6VU5NSi9V?=
 =?utf-8?B?enVQSzVkM0VDVmdoSVJSQm9IeVNTRFA2V3ZvQzFrWXhrQlQ5UlZVSENqRjNh?=
 =?utf-8?B?Wjl3eXNuRVRTRUNKWCtaM3Y4V3pTZ0JxT3ZzdU1pclJPTXhVUmlhQzMxSmtX?=
 =?utf-8?B?TFhPMHRZTjBRZGVURVNLSE1LNjJhRW51Zkd0d2Q1cU5TcS93alRIRTA5WEdG?=
 =?utf-8?B?OVhVa3JldFRucUlJVGFPWTFZRFJManl6KzBLd1dCSDJPSG5aa0J6bUJHa2hl?=
 =?utf-8?B?alNBbW5JZjVaSjBBNHZ1ZEZPYU90TU1Vb1hISGVuQ2tuKzgzSXJLSlI4UjIr?=
 =?utf-8?B?cmJrSE5ZK0Y4TUtSZVhjYXQyOXBMWVJ5U3d3Ny8wNmRLb200U0x1akw5T0lq?=
 =?utf-8?B?RUJyaXNNeCtNUkVGbmtRWHYvVDcrZTZUUXVEUE4zbk5IYkxwK1Fad3ZZRlcv?=
 =?utf-8?B?VDU0TnJ5bWk2azBidWo1RWI5M1h5dnpkK09OUDBnZENPbzRjQnJvTEFwL0FV?=
 =?utf-8?B?Vm11NTE0K084TDRZeVVMcjBCTy9Cay9JazUzV3lTQ05tTWttTXJ1UzMyZmdu?=
 =?utf-8?B?ZFNzYkZXZDVHTHVIem0vUThHblhEUklKSkg2eitwcHlNWVZXMThpbjVuaGJ5?=
 =?utf-8?B?TE8rWjFtNFplUkxIRXloL1Ywcys3OFB0TU1Obk53K0hHNEU2eU1Dcnkvanh1?=
 =?utf-8?B?SldiMzZkS0src0o0VUl0a3Y1MllnanNSS0JpZ3FWSURmSHVTTUNNY1gyQVZi?=
 =?utf-8?B?Z1duQWEwbzJKU2hKc2hyMGNDZS8yelpEcHFMOUtXZmJSWHA4MXJnK3N0WWdW?=
 =?utf-8?B?anZxRHo0NzVUam14elA4eHBwK0FPL2drVWpYdWtvMFFXSlpVVWhGUnRVRFVh?=
 =?utf-8?B?Y1VTMUdCWXdkbENjekNCZkVwNkF3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wv0D3PIyEJBGRYMHxDTM5xHqCUZmekCriMEYnZ9wwsq94Z7IzmTBeUiG6jMkv9Ez1wfk1/tECB7rVGJz8rHRxKUmmjRMdgaufhZfznNTcxu2LRsqEH3vgz+wGgHXBjW+Tokx7LjFoSdAIinWqTezGOFrrFY7But+6Yf5Ndi+glJp5Mu9GrzjjCXv/7gzJ97TnM6sxfi3SR9wFjGwzkBpJpDQNoe5LsQYuYUFhZfAfu8Nouikv5r5wGFia+g1CRl8mAOjkTxEApdA9g0MpQscTAv2qop+O5X101U61IclYGNhwoXILcfquzVe1e+pFMXtHEg1CGO73UyBs+C8w13t9pMQNemz95ixfIBkLuzPjthxn5aOkvPoo06+xgaYQYRQYpPV2xaxyZ4PX+W58nJwa37aMgn9yuDHt+X9MFRwoJ5JnQ0Z06LzlxzD4OZX8f6C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:55:41.5448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1618ea7c-dcd8-4e53-6d65-08de68b47607
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899
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

amdgpu_vm_flush() is used during job submission and is not expected to
fail. Convert it to return void and simplify the caller.

Initialize the COND_EXEC patch location to 0 so it is safe to call
amdgpu_ring_patch_cond_exec() when init_cond_exec is not supported.

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 +++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 07b43a498592..a27a72728857 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -225,13 +225,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
-	if (job) {
-		r = amdgpu_vm_flush(ring, job, need_pipe_sync);
-		if (r) {
-			amdgpu_ring_undo(ring);
-			goto free_fence;
-		}
-	}
+	if (job)
+		amdgpu_vm_flush(ring, job, need_pipe_sync);
 
 	amdgpu_ring_ib_begin(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2be65bd6b39c..ae448d8af719 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -764,12 +764,9 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
  * @need_pipe_sync: is pipe sync needed
  *
  * Emit a VM flush when it is necessary.
- *
- * Returns:
- * 0 on success, errno otherwise.
  */
-int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		    bool need_pipe_sync)
+void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
+		     bool need_pipe_sync)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
@@ -811,7 +808,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
 	    !cleaner_shader_needed)
-		return 0;
+		return;
 
 	amdgpu_ring_ib_begin(ring);
 	if (ring->funcs->init_cond_exec)
@@ -889,7 +886,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 
 	amdgpu_ring_ib_end(ring);
-	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..322193b97d3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -512,7 +512,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct ww_acquire_ctx *ticket,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
 		       void *param);
-int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
+void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
-- 
2.34.1

