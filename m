Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710C1CAC5A7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1040C10E584;
	Tue, 23 Sep 2025 07:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BNBlXrrZ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44BC10E57A
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:27:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkPjFgGAk50vR+4kmYFTillKIbks1dIjDBJfB79DkpQtu4gIY4QWZ91q6USXCUackDG7JHpv/V6uvePtL4dD0WY7gOXlK762wgLocC5YLRiSvxtoCOrmGb1iUiz6tsMkH1kIFKslwF63lF70YpH9t/9OQKPxsDJ4YQ8HUO/pF9C3XjGXLmwf6Wg3f0GAlYq6lu54NTFujoLRBujq+jUgzwhOX4dXB6BW5X5nagi61brcOGEhOR0uXfLE4n+27Qr2HY4hHIKUBqF7US2p0qzGsI+2V6JULQ9JQbsnR1qwe0KCtJOraSrIOUcHDWPMNdWjmmRMHFEegG3nH0GzSLUmng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQcEf3nlWFyXzqZAAmYjax4mPPjvHPjEPi2FwppaLIo=;
 b=I4XpCJaExCTH2jkPxmNQDPEUJrwCEfgHbiraX6SL7N+AgR9YK/ySTz5o/CESYJh6fQzkNzU3RwL2h7+AkvDCqSxqL0WAo0tRHaeRfnUB4PrcBCtzUS/l+B2XCuCO4J+05FkKUkcX0aFJN1krBO0lru8lew/1jiIesizD7ycSR1hhdfuQmAjAhS5zAWV1xdjHl4k1N/fN6Qd+AVVWIhjl3ysbt6CL+2bScSQ9Pd91qEa2xLcoYbp/A8losR/VdQdwhsvoSGmy8dnNwha+odjYA2IhSB9CQAft8uILgLv6ImRiikjLGGDlSb3XDOEIhifljZDA1dy7h22wkw8X0uzsNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQcEf3nlWFyXzqZAAmYjax4mPPjvHPjEPi2FwppaLIo=;
 b=BNBlXrrZVn/3JfUmP0rObDaia2yLJF3yilEKdyxspSpDGvXief0bSEW2Apnx2lrZ/RenGVm9chdX/BXLX9LISMzFKSsv2eHcunxZuNrAaTou+eMDlt7V3QIR21yJoEkJjfMtZUATenSoqOcITucWSGkDVg3Y4tzeaTriiLfdLKo=
Received: from MW4PR04CA0092.namprd04.prod.outlook.com (2603:10b6:303:83::7)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 07:27:01 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::bf) by MW4PR04CA0092.outlook.office365.com
 (2603:10b6:303:83::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 07:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:27:00 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:57 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 16/18] amdkfd: fence handler evict and restore a kfd
 process by its id
Date: Tue, 23 Sep 2025 15:26:06 +0800
Message-ID: <20250923072608.252345-17-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a918f8f-fd57-4536-dbf7-08ddfa729634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EtpFXfVNeIX3JJQpxkoScDgQzaieWPbWEXCzSkp8gCfwUZbxuXea1XtRqvRj?=
 =?us-ascii?Q?eqt/mM/urU3VZGVIqcQIGS5aViArSy1jznM2MhinrQb6WFLGExDvVFIZp5aA?=
 =?us-ascii?Q?w/NFORgWW/CPN8IcIyRpa4sHwn000rjEBobjQBQ8IYJtDrdpx44MLZXE3216?=
 =?us-ascii?Q?RNzK87yQZSVhqZsKnesBl8cdoA+z6Kux2ECRCgImqNnxew4vpNNyx8rvTKzz?=
 =?us-ascii?Q?o3F0mSWPnESlHqoyqcGWWiA84Hmo8XR0p/4GcDcW1gWZDLi+29yinpcSNHOo?=
 =?us-ascii?Q?IVM/TFe1jWDvDLf/MIg6r0AMrJTpH200zaoPJqtS6IQ0hmmcXzu5EgQfUj7N?=
 =?us-ascii?Q?2PQgxhnEqZTHbYIICxWkWHalYKaeLu0VL3O6ATMmcLYOnqxS1DqscBEx/xGo?=
 =?us-ascii?Q?sPmcCIGcnr2CrsaDlEHSXUdvFh5mDkZAXrURIe3OjmO8TNmZmEKeQ+0KfTXt?=
 =?us-ascii?Q?dq2ciHqwCi4hu8liiOm3uqhXu9VZKGQ+51yVja6PaWsm4d1gPsebf+2kcdF1?=
 =?us-ascii?Q?h/V1ibzQiFGmksJbAn+u8kuO3EZspvF8XIBO6VQTrzIYuL5ViZ9jVGkGR+jp?=
 =?us-ascii?Q?lKaeqGtFczpQ/g6J6YBxENa0JnYP6auv9BJFETOYUobfsmNKgsWtOwtIJZzq?=
 =?us-ascii?Q?kQtTFJmFeCAbAzithkuYDMrKxWCesVbt3w3+UStTxme8qb2VQ0iJihxOGqbH?=
 =?us-ascii?Q?PMpE5uJGOKs1cGGV1j7fj2gGhuUeahyhxZRt+w2Y+voifPi3d6RYWqItOZXD?=
 =?us-ascii?Q?KjEAtUC8IM1cTW/0umDvkyyBYxfXn709CyBa961+37I+p4LBxKUHr2Ei1tRy?=
 =?us-ascii?Q?/G40RjN1/VOi/qHWSMplpea53Eg9wo2EskKDGcAhVJHKS3zX7lDzGc/Un1J+?=
 =?us-ascii?Q?/ZTiydg937lyWjdnoPWAnBIkBQ+UFfOvGmeG+R4xZ47x+U3YlA+pcQLEmowN?=
 =?us-ascii?Q?6Y1a/UXvoGyIpIr5jzE5uQmtbpTVHSUKDiInmeAVMLOl9yWrV1+M/P60SlQg?=
 =?us-ascii?Q?FYWn9zvk1PKnove1IXh4Z5n8ImSAX3+gbES3NkuzUjashJNIgAPL4LCxfLjn?=
 =?us-ascii?Q?yKTXaaYhFbkz0u/6/qK6kFgT3zTLBBhaZHAwPEfvsWvcTqp72yU/W3BdoqB5?=
 =?us-ascii?Q?WAJhMOBu5cJ6+/CciIyGQSdurPZER+C3cvBXjXJ9M6NFJg6xs04WMXWcI0B5?=
 =?us-ascii?Q?VMtx38BomMgQfjABhWKYCxDIXbXr7/GL/cqPe6o6TFjRjS+Zhw/4Mde/eANw?=
 =?us-ascii?Q?PKZZuXDgZoEl+rIc4b6WNttmIS8tFu4hRKhdHo4fnykUWN5Y5hmRIppEbenT?=
 =?us-ascii?Q?DkgmL7H2SvfIFKJzZcjt0EN7zHhdvTG/NT3foZ+sBgPh/j6ZtFfVGfUn5FA0?=
 =?us-ascii?Q?unr2L7iR+jhA9tf6FCvAbTLjgvYj4PLRAPhAl0Km8d05f2diuhxECBW9jOQT?=
 =?us-ascii?Q?ixVPpqvlo0Dd5/ZeP3o4XSqyIF7lTRsHHfJK9Bg2AsnobRqX7IgJde7m+CjE?=
 =?us-ascii?Q?9ftby6rBtXSwbd1o/D1jWLt4oe6+K/iaFNfs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:27:00.8395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a918f8f-fd57-4536-dbf7-08ddfa729634
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
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

In fence enable signaling handler, kfd evicts
and restores the corresponding kfd_process,
this commit helps find the kfd_process by
both its mm and id.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          | 7 ++++---
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f3e497da106c..0c28acf2fd07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -409,7 +409,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger);
 int kgd2kfd_resume_mm(struct mm_struct *mm);
 int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
-						struct dma_fence *fence);
+					       u16 process_id, struct dma_fence *fence);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 int kgd2kfd_init(void);
 void kgd2kfd_exit(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index a6ff4d82b029..1599eebe5c3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -128,8 +128,12 @@ static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
 	if (dma_fence_is_signaled(f))
 		return true;
 
+	/* if fence->svm_bo is NULL, means this fence is created through
+	 * init_kfd_vm() or amdgpu_amdkfd_gpuvm_restore_process_bos().
+	 * Therefore, this fence is amdgpu_amdkfd_fence->eviction_fence.
+	 */
 	if (!fence->svm_bo) {
-		if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, f))
+		if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, fence->process_id, f))
 			return true;
 	} else {
 		if (!svm_range_schedule_evict_svm_bo(fence))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 349c351e242b..3377b6d53e47 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1193,12 +1193,13 @@ int kgd2kfd_resume_mm(struct mm_struct *mm)
  *   prepare for safe eviction of KFD BOs that belong to the specified
  *   process.
  *
- * @mm: mm_struct that identifies the specified KFD process
+ * @mm: mm_struct that identifies a group of KFD processes
+ * @process_id: an id that identifies a specific KFD process in the above group
  * @fence: eviction fence attached to KFD process BOs
  *
  */
 int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
-					       struct dma_fence *fence)
+					       u16 process_id, struct dma_fence *fence)
 {
 	struct kfd_process *p;
 	unsigned long active_time;
@@ -1210,7 +1211,7 @@ int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
 	if (dma_fence_is_signaled(fence))
 		return 0;
 
-	p = kfd_lookup_process_by_mm(mm);
+	p = kfd_lookup_process_by_id(mm, process_id);
 	if (!p)
 		return -ENODEV;
 
-- 
2.51.0

