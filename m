Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4EDD78336
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 16:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943AA10E7BB;
	Mon,  2 Dec 2024 16:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fFQI3B51";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D936610E7BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 16:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqR0PYt9qUDxGnlNrXRxFlNcIKUgg03CsddkfPcAWP0muUnOtFi68AtOwgQnaAtt1ZkWEl+nobWXc0J8y0abUdIb4Ye98xzfY5ua/DUB+/Ghq+wOlpMXTrIHyhZxDTIZW+tPMgLPVjUoaZyyLZgKgPIQAtqxYvaGVrP2qs4S+ntVo1WGJcMoZezAExMmpGITHYNsEp4XqgIAIDie6QcsWnbiRsEvuN/yxJ1UOXui1MaHb0PM7EuhX9O6aQ3rCHVDuMD2iSOkT28c7R3tLyKrkrABwRlQbm0wfPsfqKA8TZuHiwdx8fDqk9uZsEUKRQiUO1ygCClLrFgugL6WBd5D5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+7mOikeSDplN5HoJImF0DQwBRIyEJW8yF4NKh/tuEQ=;
 b=YigKx/RynQ9Ql2XPBVrcZUOrKaPENuZiSyRwVhmDZXQXycEOiA5Q+EcJVFGvcPX+W9kItOdqEUltgpi6lnd6BbO7CMS6oDXzcJQkgLMTGOPUxo5gvMAY2E+630r5ihrFVgIarkYCSYFb0TaX7wzvN3g2u/u3G0uUKx1vuWUWfXPnMzLQgdz6cecAKiD9u4C9ocwjw+TkVZzIsrfUEDr6MqkwHcnrYlPY2W52Ov1irsZdNcFPA2MJ9HmKlXuX3AnLMdIniixwWW7zWW/DVTTJGEucvct8DIz28WoYgK5/Z2sD9pf2eIB0/kixQsFSiyXklcG3rP02XtP2lMY1ScivoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+7mOikeSDplN5HoJImF0DQwBRIyEJW8yF4NKh/tuEQ=;
 b=fFQI3B51nhbc8FYrr0WCwzOuxS6dcRkOqSYhiDVNFbqWGQKUbTp05ix3F1UD9KlQvJeK1g8RM2dwQUlz9uOAyjIQxGfb1ZW9dwxBcN7VUByQNsK5yuSGK5ag+cTqGwA0Ph8Sm6Z2JRyVU8WhmX1OwLRKgB/QfpgqLfYTPhDz4Ik=
Received: from BL0PR01CA0017.prod.exchangelabs.com (2603:10b6:208:71::30) by
 MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 16:31:18 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:71:cafe::f6) by BL0PR01CA0017.outlook.office365.com
 (2603:10b6:208:71::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 16:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Mon, 2 Dec 2024 16:31:17 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 10:31:16 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Add Annotations to Process Isolation
 functions
Date: Mon, 2 Dec 2024 22:01:03 +0530
Message-ID: <20241202163103.1347287-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127194350.2085774-1-srinivasan.shanmugam@amd.com>
References: <20241127194350.2085774-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 8610e45b-1351-4ec2-226d-08dd12eebf77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tys3a2h2b3lvaFp2TUllNXQ5V2tocmFpNTdqL3FTSld3blpwSzFLUjFaVzZs?=
 =?utf-8?B?T2djaXhMMjlSNXJTbWd2L2o3WUl4QjR6bTdrVlNTSVhxNlFXc2tUa1c5L0tt?=
 =?utf-8?B?R2Y0eXVkK1dRc3BOQ1g2aTM2UmsxWTNpeHBMTlhacjlvcjl1Z0U5WlMwamFM?=
 =?utf-8?B?eEVEK090R3gxV3RrSGxkTUdYSDlYQjlLdmhZSG42WjAwdnBtekdZVnh3d3ZY?=
 =?utf-8?B?L3RTbkVDQm9qWXZxZHFtb1RMWE52aWdIekhhVVJOVzduRWtTR1ZxMktIMUFr?=
 =?utf-8?B?VlU1OUNaTzcrUFhKbFRSeEhLQWRaekRmcjhqRjl3UXFwdGcxRVU2WHI4ei9u?=
 =?utf-8?B?N1RUbmZHLzRIZExvaUk1VTd0SEdRUnNBbDFhNDlpNitjeGFFRTAwZ01qbGhj?=
 =?utf-8?B?MDFxdW15VXBTWUFWQ25maFVJNWQ1eDBvNFcyWko2STVhODltNjBOOUlQNWlT?=
 =?utf-8?B?Q2YxYW5uT1p4WlR1L3E2bXg0U21jR0ZKeG1WbUtoUTBmekJneXlQcys1b0Yw?=
 =?utf-8?B?WHo0WHVNc2FCR0E5WjI3MStDbGd4ZTZkVG04dnlLMmM2M1VZOVcxcE5tRTN3?=
 =?utf-8?B?MDhCLytXenJCWC83Y0tMQlRvOUxweWJVa3ZzMEFRUHA3b0V6dzl6bXBDL1Nw?=
 =?utf-8?B?VlI0ck9oY1AyWmMreDVrMDhoZC9aK1JGdG9WekVLa0ZRcTByWTRxTkhxbEE4?=
 =?utf-8?B?cjIrZDl4dVlQaXVZcVBBL0hMMUZZNHA1VXhEQlMvVDhTc2ZzOHpXb0JTQ0Zh?=
 =?utf-8?B?VDQySlJYazlGMHpuRm1veVUwbUNlUWtnaDE4S1ZWcVJuWHBiakIySlZqeWxJ?=
 =?utf-8?B?cTMrSnFYdUZhS0V0NVE1S3hiMWNBYjRJWHh2bHJRU2FaQ0VUcy9ZWEJROWt2?=
 =?utf-8?B?dFlWOHpUTEtpOFJpR2pOUDRraVdISXAvL2JIOGdsSmtpWnZuQlBrK281Qi9M?=
 =?utf-8?B?SVkvODlMN05HVXhwQkErT05tVit5NnJaT3RiNm9ucnA0eXdnenYyQitFWVJF?=
 =?utf-8?B?M0RjV1krMWdTNzYzcnJhNktyRUtrc05ZaVRjdHV4NzVLaVlic2xscUMwQzdZ?=
 =?utf-8?B?ZHdVQTVrbVhNNWNlVWhaZ2UwWTVxTUh2blJoRjVnUDJ0SE1WSkFuOCs5Tm1m?=
 =?utf-8?B?TjlNUG5SSDBYLzZuMkU4ZFRSbjVrVlZNb2tTQndodlRyd1FoVWxCK2pkeUUv?=
 =?utf-8?B?RmdEU2w3U0VDSndnT2lKM3JYdXhTM29CTGwrK2RvQWxKMnp6Ymdod3FqWklJ?=
 =?utf-8?B?UHp0b01FVFN2aXlDaG9SSHlzOWdPNTZiTDZJUlpmdGZoLzZFS09UaDEveU0w?=
 =?utf-8?B?MEx2RjF3L01PdWJLOWRWWGNDeUdseEpKVE5YbVdVeVdPT05tMTV2RzRHeE83?=
 =?utf-8?B?SjNCL3dGL2FSdEEzc0NZMmE5UmhLRVFUNVJNOFd4R3NEcStaWXpOSjQ1bFBO?=
 =?utf-8?B?dkhXTzdHdnp1Y0VJQjVENWpoLzU4QnlZNURITW1iTDYvSTR1cFd4aVRoZnZK?=
 =?utf-8?B?VEdaajNINmhTNFQxeEtqcmZzdlJ4M1hiZmRDUnFCZGNOd1Jac0tDSTFyNnFC?=
 =?utf-8?B?Y1pON2FxaUdJUDJGUTJFSVVPNzdRVVArV1ZoK3EzUHR5RFZIa1pMZEMxWkRI?=
 =?utf-8?B?d3E0OHY5bllBd3hDTlR6RWd5dHA1eFQ0MWRIWlBHZ1JobWR6cmpPZVBWcTdu?=
 =?utf-8?B?dWJJMWliVjBVaTdnbHNWa0ZhaFAwV3NFcjczNTZBUFpqalJhcWwxMGZDMlo2?=
 =?utf-8?B?SDdxWFVaYXV5UHBwRS82ZUdEcExFSWhEQ2pua1h5ZXpLV2sxQmN5YzY3YWlw?=
 =?utf-8?B?bC84eUpZZGo2b0tvamlpOW1yWTVFaXN1L2ZPNmswUFk4QTVWNytjWklLaSta?=
 =?utf-8?B?aGJ2cXVSeUJLR0gzb3BMUEZxd1kzVVUzNzJmd2htSVFTSmxIeFZGcjdMQUxW?=
 =?utf-8?Q?BkVzWzcehUcaPBjbNvcXIOjc3dHyn4SA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 16:31:17.9625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8610e45b-1351-4ec2-226d-08dd12eebf77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
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

This update adds explanations to key functions that manage how the
Kernel Fusion Driver (KFD) and Kernel Graphics Driver (KGD) share the
GPU.

amdgpu_gfx_enforce_isolation_wait_for_kfd: Controls the waiting period
for KFD to ensure it takes turns with KGD in using the GPU. It uses a
mutex to safely manage shared data, like timing and state, and tracks
when KFD starts and stops waiting.

amdgpu_gfx_enforce_isolation_ring_begin_use: Ensures KFD has enough time
to run before new tasks are submitted to the GPU ring. It uses a mutex
to synchronize access and may adjust the KFD scheduler.

amdgpu_gfx_enforce_isolation_ring_end_use: Handles cleanup and state
updates when finishing the use of a GPU ring. It may also adjust the KFD
scheduler, using a mutex to manage shared data access.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
v2:
 - Incorporated feedbacks for function descriptions (Alex)

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e54f42e3797e..b1b133affbf9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1940,6 +1940,17 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 	mutex_unlock(&adev->enforce_isolation_mutex);
 }
 
+/**
+ * amdgpu_gfx_enforce_isolation_wait_for_kfd - Manage KFD wait period for process isolation
+ * @adev: amdgpu_device pointer
+ * @idx: Index of the GPU partition
+ *
+ * When kernel submissions come in, the jobs are given a time slice and once
+ * that time slice is up, if there are KFD user queues active, kernel
+ * submissions are blocked until KFD has had its time slice. Once the KFD time
+ * slice is up, KFD user queues are preempted and kernel submissions are
+ * unblocked and allowed to run again.
+ */
 static void
 amdgpu_gfx_enforce_isolation_wait_for_kfd(struct amdgpu_device *adev,
 					  u32 idx)
@@ -1985,6 +1996,15 @@ amdgpu_gfx_enforce_isolation_wait_for_kfd(struct amdgpu_device *adev,
 		msleep(GFX_SLICE_PERIOD_MS);
 }
 
+/**
+ * amdgpu_gfx_enforce_isolation_ring_begin_use - Begin use of a ring with enforced isolation
+ * @ring: Pointer to the amdgpu_ring structure
+ *
+ * Ring begin_use helper implementation for gfx which serializes access to the
+ * gfx IP between kernel submission IOCTLs and KFD user queues when isolation
+ * enforcement is enabled. The kernel submission IOCTLs and KFD user queues
+ * each get a time slice when both are active.
+ */
 void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -2012,6 +2032,15 @@ void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
 	mutex_unlock(&adev->enforce_isolation_mutex);
 }
 
+/**
+ * amdgpu_gfx_enforce_isolation_ring_end_use - End use of a ring with enforced isolation
+ * @ring: Pointer to the amdgpu_ring structure
+ *
+ * Ring end_use helper implementation for gfx which serializes access to the
+ * gfx IP between kernel submission IOCTLs and KFD user queues when isolation
+ * enforcement is enabled. The kernel submission IOCTLs and KFD user queues
+ * each get a time slice when both are active.
+ */
 void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-- 
2.34.1

