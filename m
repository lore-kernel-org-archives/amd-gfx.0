Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7654EC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 18:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B2010E07A;
	Fri, 26 Apr 2024 18:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XTHwqqZZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595E010E03A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 18:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kya2uoNdcZV4u4nRkaTzYSiR7UWny5R0n+xEI+HP7gge/zVda0VJqI0ZWqWDGQpJs0u9MT4Nek6YAGFPRBYJhm4PXZGCzdJypPhl7Ngvqowa1G2m0JnnFfbuLZW8CUO9nNGQgWeVhfP2GEfuTlygPFHcKOrBs8qyLcLc8znvZphjm+qc1jiilBBiFNUAL/kZ/N8rvs232Ao1p/jhESLM1neKwBaBS5EkZKR3UvcmjQnJ0uR+a0VWPRS7kQmgfkQIG4wflNwad/6WF+04yP+fHlI0cvcM3PrrS4o8vZOx0jM09nPKSOanfwIFtp7sPJlBjjhV96K8vytuwrZeRpWOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvdFvm8RgHydnGALlAWCatCOqM51SpBusPDWcNYTSwM=;
 b=MnKe0H9GvBgvyLX3GrRL2r6SfYfo2Ro/mHzIBGrH0UvKh9Os3doBZsOC1k7y+HtTsFv1KDEUhn5Ve1OLbkzDq3cqk0l6xevYlbWLAxjDS3oEXtLFi1jck3eozbRW3bEypKUb3HZJgz2MqQp80gO28zJkyoZiwpO+KQ6Y+9DHc8DvPcWYQv20j2Rqih+DC2fAhlJGYN23m5PZL1xe5eN0lqSNwkst/XIAgCWDJ1+9l4wr0CJnPcyQw9nG7TQYUatyV8jVYrUgwTWkusgNE2YbdK6Nr6tziHIxxJLse8ssClpdW9fPkzBBxjyoOR3OT2xwXIFWpfjvXpzUBeBZUKGgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvdFvm8RgHydnGALlAWCatCOqM51SpBusPDWcNYTSwM=;
 b=XTHwqqZZVT8CGwXMbY0mZ+EO1HQlGiCbtdvKBpq/r88/clvl2LsZIGtwcbLBaQ0rBsZf6mn0koxkh9y1cWNvB0dvIw/Gz6ZiwHK0DKluzFOljneAkuZBGGYCFsyeJz7limXKG6fZbvGNQfdeNqDx8BZI3ixXPsPFYKhTFANcFIA=
Received: from BN9PR03CA0843.namprd03.prod.outlook.com (2603:10b6:408:13d::8)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 18:27:43 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::c9) by BN9PR03CA0843.outlook.office365.com
 (2603:10b6:408:13d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Fri, 26 Apr 2024 18:27:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 18:27:42 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 13:27:40 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, <felix.kuehling@amd.com>, <emily.deng@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v4 2/4] drm/amdgpu: Add reset_context flag for host FLR
Date: Fri, 26 Apr 2024 14:27:05 -0400
Message-ID: <20240426182705.98131-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426035742.90560-2-Yunxiang.Li@amd.com>
References: <20240426035742.90560-2-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: c2db7126-b521-436a-e4b6-08dc661e8fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CaAainE+ZuNKbjFL++lAtRZt7BFJOd5O1VaeyTRTvGfu+XFZgJtyxmo4ynnY?=
 =?us-ascii?Q?DrBuzqzdFCJeL7ARtv+9tflOvIkvsS0QFBXNjYMIMC2qFcWOYqaF2Y/W8yW4?=
 =?us-ascii?Q?C4QZZoHr7xFFOrU05vR1DitwSV8svDj471NCzwdeY0bMMRCn1FpIrOsfWbWn?=
 =?us-ascii?Q?vxtw0LeO/QLxkSNzmb5ZTGbwXUJgJHOvGpN/bntW+TU84jV/ka0YhOysZ76t?=
 =?us-ascii?Q?8IeoxiQ8CMbXRkBYsj9GNqHBAyrHtOeORaxgU3KVrigohLvBfIxB01K4Iss4?=
 =?us-ascii?Q?chGfuxx1zJqvt8Kn4ML/qaaQeI6yL2zOGGfWatRsNkI9OuppLh/PoO1RebRv?=
 =?us-ascii?Q?LkLGl256BlN3skOy9Ae5c+oo4MS3zVW6f27IyVig6OlaMRAiqW7vkaaIiVlk?=
 =?us-ascii?Q?zZnVh60wiM6J+VQe1PKR/Ysl7GI27FrnhD3p7p3JN4OylIA41949lNoNuJIA?=
 =?us-ascii?Q?vb06CYTrxIj1cDc/MU5YQ1EAAseWBaNc7I2BN5vFyVI7Fwr776ch5daeSKfk?=
 =?us-ascii?Q?DvTjkPA0Jvpf+Ghgj4e4HEGYZpOol2/rVM7FAKIFWU0XjehDEi1dyRjk0gRZ?=
 =?us-ascii?Q?El14wQvWwb6DeW4cI0KpUEVAN8quvbW4vZe1ZoiTMeRdDOhj4ErRsPkXCFNq?=
 =?us-ascii?Q?ZUq549TUjmXyQu8h5OoBUDjxZUx8G44JeC5GsToOae0Hypzhi1PEAYJ3P9qu?=
 =?us-ascii?Q?PU7YrxHupMUxQfTUJGfkX4TBEOgobKoPMJti31cOKd8bHNvhkzdNVTPmn1pd?=
 =?us-ascii?Q?3z4RJzH8e6GtnepbSLopUDnpcjStlG4oP0egG/FlTH8KRA8rWEQcOkhEvAXe?=
 =?us-ascii?Q?C3ivatsLd/R0tsZr1VSPhyHwyQQDbcYvzi3+YaxYJOk5S1NmIO7/5zjVEziC?=
 =?us-ascii?Q?Bgvv72UVC2DnOFEck8kGvX3+UlPeUUWFtvH1DRi9rBqYSXPQLESmilO2jic+?=
 =?us-ascii?Q?uko9HCdFXkaGKR4P9X5WPPqNGpjou3y/mjwR35MIF6Ica3+s71QWHCiAcyiu?=
 =?us-ascii?Q?PFInQuVOtsRtSQiRMUQPOlDYfWj1iUXpBrVNEK10dukgueawPM8+Rr8SD3h3?=
 =?us-ascii?Q?QKOYtVCYGFjr7iWXhGaHL1n5pn4CclEoP1Jv5rtdxDf+sImxzyMMP8i4nbV4?=
 =?us-ascii?Q?arXm+BcO/M+cINZwi8fi8OYSI5txCf/oyzTyCAENt4HIrMDVtD7m50nc2fxY?=
 =?us-ascii?Q?B+F+6jGpnY5nXiSfC91Unr+Gfoeo6KPwsXjHkLkudGT6cVnsnVzPsu8W1qK/?=
 =?us-ascii?Q?69z5ypLwRWUD2Eqb6wiMYxZ/+2J/p+vMCLTCvSPtJSBxARkDEWqz0Wo214LN?=
 =?us-ascii?Q?eSB4BTLu46isf26WKCYcZXoOBHKmIeHLaJrJzOtDe/PvZnsCC0Vxxq1DrnUc?=
 =?us-ascii?Q?ifpMO+M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 18:27:42.7263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2db7126-b521-436a-e4b6-08dc661e8fd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
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

There are other reset sources that pass NULL as the job pointer, such as
amdgpu_amdkfd_reset_work. Therefore, using the job pointer to check if
the FLR comes from the host does not work.

Add a flag in reset_context to explicitly mark host triggered reset, and
set this flag when we receive host reset notification.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v2: fix typo
v3: pass reset_context directly
v4: clear the flag in case we retry

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  1 +
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8befd10bf007..33c889c027a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5055,13 +5055,13 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
  * amdgpu_device_reset_sriov - reset ASIC for SR-IOV vf
  *
  * @adev: amdgpu_device pointer
- * @from_hypervisor: request from hypervisor
+ * @reset_context: amdgpu reset context pointer
  *
  * do VF FLR and reinitialize Asic
  * return 0 means succeeded otherwise failed
  */
 static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
-				     bool from_hypervisor)
+				     struct amdgpu_reset_context *reset_context)
 {
 	int r;
 	struct amdgpu_hive_info *hive = NULL;
@@ -5070,12 +5070,15 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 retry:
 	amdgpu_amdkfd_pre_reset(adev);
 
-	if (from_hypervisor)
+	if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
+		clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
 		r = amdgpu_virt_request_full_gpu(adev, true);
-	else
+	} else {
 		r = amdgpu_virt_reset_gpu(adev);
+	}
 	if (r)
 		return r;
+
 	amdgpu_ras_set_fed(adev, false);
 	amdgpu_irq_gpu_reset_resume_helper(adev);
 
@@ -5826,7 +5829,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* Actual ASIC resets if needed.*/
 	/* Host driver will handle XGMI hive reset for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
-		r = amdgpu_device_reset_sriov(adev, job ? false : true);
+		r = amdgpu_device_reset_sriov(adev, reset_context);
 		if (r)
 			adev->asic_reset_res = r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index b11d190ece53..5a9cc043b858 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -33,6 +33,7 @@ enum AMDGPU_RESET_FLAGS {
 	AMDGPU_NEED_FULL_RESET = 0,
 	AMDGPU_SKIP_HW_RESET = 1,
 	AMDGPU_SKIP_COREDUMP = 2,
+	AMDGPU_HOST_FLR = 3,
 };
 
 struct amdgpu_reset_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index c5ba9c4757a8..f4c47492e0cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -292,6 +292,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index fa9d1b02f391..14cc7910e5cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -328,6 +328,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 14a065516ae4..78cd07744ebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -529,6 +529,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
-- 
2.34.1

