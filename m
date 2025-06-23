Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A612BC7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B0C10E340;
	Mon, 23 Jun 2025 09:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kFe/XJi3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA2D10E350
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2NTW3zOo+JKM9ANvcLappOFEPnkGfpAjP2y36qElNYn/j6XTndwfJXdRd3464Fg5I9rcXjDYxIJoI9572wqZzfTTKnZnVRdFwQ1/R4vKC8jMKTXmMsq1FRkVfPY173XocrqWdqApwielrAXqgqrfMhLwkXC3uPLxSGLOUT1xIbyebGFLmk8s0xxR8oKOSNBwZWuw+VNWuAunNrCAr/tH9wt5+0N9xEHk2wxY9TmUcwckDNlO+K1vnduZ/WzQxrgA+CLAuMjh1g6otKXntK/N70shqjbfiK9boASK0LfCHZ7+t6QVj850vQ7S2jn4v6IxJVsEkGwVR4cT3innaPT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb3hqHMnrK+26ly0oqZn4wyFrSDA9P8sPHAXTL1yY20=;
 b=ImFV04hsS3IL/oXBsnH7TBrio79kDgb8Yi4/IjncHWxyKuD5obPKk0nphP97MprrG7mXyO8xMVw28CnM22Kiy2lwhuz61uS8hnZ3QkwGp9p4oPKTLZOb32ispaePZFh4HS2nctYg2AFJxGDaGkhWiFPpdDrzg7c9VoIIZAuiiQlgouSM5h7EqO6nteZKDpVCAxeYi0IlWNIl3YKbU1cunhvAtmU1h/hYSolKsmfd3LyR/zZrkxsC088TUKMG0hXUcWHkCHDkaNAqxHqCreLPIo23WELAgR3xSeQHIKZIuucXdGp6JLokzbZv0cwsw1+REg4x54zgkXFLuh7oxYYGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb3hqHMnrK+26ly0oqZn4wyFrSDA9P8sPHAXTL1yY20=;
 b=kFe/XJi36frtgF5tG4NgDq4cSL8Dsera3ro1qh+ltF53qbRUzNRnYOcCKC2W+ljRGFl8GY5iVdfrWh0mdjPGwEuP/ti69grZUGnhGj8llhcnXDm+MyduXSQD30lsN/3ERbTVPoRu6DHSmGQzfeg9M2wJ3afcFrb4oy9FIOhJypY=
Received: from DM6PR02CA0072.namprd02.prod.outlook.com (2603:10b6:5:177::49)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 09:52:19 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::f) by DM6PR02CA0072.outlook.office365.com
 (2603:10b6:5:177::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 09:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 09:52:19 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:52:17 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 09/11] drm/amdgpu: validate userq activity status for
 GEM_VA unmap
Date: Mon, 23 Jun 2025 17:51:52 +0800
Message-ID: <20250623095154.1150830-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623095154.1150830-1-Prike.Liang@amd.com>
References: <20250623095154.1150830-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e816a33-81d8-41f0-f659-08ddb23ba49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h/WiWuWXtKl2jYaXRxofJ/ut8jcRkxpMsqgDAgdtOxgOC2uM4ErcTOQVGXMb?=
 =?us-ascii?Q?OX9txRYx5bL6Mi4FCnN1L+rRFovmJZPBGJocDw2QQmr9hqMUp9+6xukamHIb?=
 =?us-ascii?Q?DlxTEPMuDBGDFVQeO8A9cdpaXOt6yIyoeCoObHgNILbaR//UiHBVyLor80Rc?=
 =?us-ascii?Q?YK2yyezA7VdxH34WqHn7DWmNl4ZmRsEuqi+lQ//hLUUhBBTsHd502rdk8Xef?=
 =?us-ascii?Q?TRQIOUJ25q5Iy1Yk/j7AevMoVjEvX8dnk2Io30gR75dQwxyXWCLrFVI0d6dC?=
 =?us-ascii?Q?xeveAABQx72LlM7FAn0tIcMgmCvDCqtVWhJEBNlY3vfoMH7yVBust7Bft+J5?=
 =?us-ascii?Q?tEM0zO6mb31EBPkE9K+nFVTOz+pCyMXd1JnJbsm9L6hkVPhUa0P63fDjxxpj?=
 =?us-ascii?Q?GR+7vMx1KpQadkWbTy0yeoegO+VsiXplJCKhr4Xi0qN4wqZKMzOagc1OkOwA?=
 =?us-ascii?Q?C9zO4tj+MimHwyIyes6S8n/uITS18iAGC+bzr5O/K74On60UjzgBFU52yyF8?=
 =?us-ascii?Q?Z9rT871xIcEgvAoOT/bTZhun9wN51yWlElYyd1qmrbxrBPIwEkQxUYUAl4dS?=
 =?us-ascii?Q?DcDcvbEgIs5aeX/9eYrB8z8KKJyDSJWchWWdHnpfmio53/qMNWixruC4yt2K?=
 =?us-ascii?Q?MxvYjkFXAsJvoe/Ln/8PAf8szSI9QzRKiHRCp21FyBX0fiYmNsDvEf0UFBhM?=
 =?us-ascii?Q?9/qRCMqj1xXW0eXNhASp0e7EQeqrSGFCKWfz8Vrs3CIU9n5DjVR1ugX0DThC?=
 =?us-ascii?Q?/wdTBAIsnIBLUuWWBLiV0PkWHumG/d4nytcy1nYR9oliyyq3buZF/LOxlbis?=
 =?us-ascii?Q?SNr+Nm1QsbemX0gIveFTmiH1B4j6S0MK8fwOTwBbF0945TF8pmN4oPjdmCwv?=
 =?us-ascii?Q?PdfpY6eBblcoKmgqCElMacJXIRyDI4Lr8MCUVZIaWbpz3QZKIUjoimxW8e/E?=
 =?us-ascii?Q?3quDq3kAD1w89toprs062qYvmsk2I7JS2fyaQpEJ0z5eKBgnCYhIgIAwunsd?=
 =?us-ascii?Q?5kIsgufwibq8K2P1ZP56AQxJpZKnCq4SdwSPe3Ub5A9cNANsiTfTJRHhZn2q?=
 =?us-ascii?Q?ILKWd3rL8HwH/3xBBLk1SIb5roFlLkV1fiJqukUXEgJ4/PvcT66az1SlNlhd?=
 =?us-ascii?Q?nh24LncHq+q8tRfAATlw5DEoTuIwd2vvkIFCRX6ETz5iGa60tPWdODrDfMQU?=
 =?us-ascii?Q?UFuSK/i1xrmreRRN32F7LeeOfFN85kslnC6xs6zl6mmgk+6QPS6zXm9CQ5qs?=
 =?us-ascii?Q?xPa0qZGs8PxfWEfVGnGpm4eCKUwQLBUxvW1bIR3jA+I5wUjJV3HnFdw+PucD?=
 =?us-ascii?Q?jheJxwL2djC5aNMuRhNpwiS84GOSkgYk/jIWPKlkwj4tM0e/q1rvXzoQtpN3?=
 =?us-ascii?Q?FwG5JZYxZVXUSpOl9tqyp/hRY0GDtJ76z8nqC+3un6wFw93lAO0vUHJyE0+H?=
 =?us-ascii?Q?cQTCZR5o9L9NO34K2WCqiRTqa51avwxuTFM/HzzinxU1b01CDeVCKcYcc/jI?=
 =?us-ascii?Q?Mu9QmsPiMdf4tqwOB1vrfYSn3TBaqUE/JeoN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:52:19.0298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e816a33-81d8-41f0-f659-08ddb23ba49d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
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

The userq VA unmap requires validating queue status before unamapping
it, if user tries to unmap a busy userq by GEM VA IOCTL then the
driver should report an error for this illegal usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 534a9c98c011..5243512c9cec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -243,7 +243,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -252,10 +252,14 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 
 	if (f && !dma_fence_is_signaled(f)) {
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			return -ETIMEDOUT;
+		}
 	}
+
+	return 0;
 }
 
 static void
@@ -471,7 +475,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
+
+	if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy userq\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
 	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
 	if (!r) {
 		amdgpu_bo_unpin(queue->db_obj.obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 5e075e8f0ca3..afc493f43256 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1929,6 +1929,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
+	int r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1949,6 +1950,13 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 			return -ENOENT;
 	}
 
+	/* It's unlike to happen that the mapping userq hasn't been idled
+	 * during user unmap vm except the vm unmaped forcely from user space.
+	 */
+	r = amdgpu_userq_gem_va_unmap_validate(vm, saddr);
+	if (unlikely(r && r != -EBUSY))
+		dev_warn(adev->dev, "Here should be an improper unmap request from user space\n");
+
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
-- 
2.34.1

