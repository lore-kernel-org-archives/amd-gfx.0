Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0A3CCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5FB110E6D2;
	Wed, 22 Oct 2025 07:31:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xsZxENQw";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B1510E6D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYw6RGUOHLQv8Vl26WyUBfnSlTe6IMhjRUA3QB8RZ1evA9Pccu5dfmf9S4iktW/WR1sJe9w3i21X1qn7IEN73NNXdORWnyymPmVZUNv9kk2Lc6AOkaCj1XUrrDcedrYhF0oXFZBPP6Ybxl+23wQ85GYemdI0iG4n0jjGEqqkr73+kysd6yn+mXoIy3n5INm/SD15bEEAPdhZTMzpuqI1ZSiZDEVaUQN4qC16xD1o0ap7UJjuXxCNRE7em40/T7d2chFFOBsYMfNiTk5TRG7Y8yGOTh9+ZntW/qIOLxj87+0ez64OsGb41+w3sZpk1Voqt2IXLv7RaXG0NRQWebJYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dI+rzV9kCNOvBmUZY4ypXBUrcTTuKJ998+EdK+7bwc=;
 b=UosEZI4iZIExXL+MCYP5YwHxq9SYLP8meAwPfhctJ+2PY9No+1OfRFQsbk0B/8s5o0kSGCYHCryT05GbGm7yFqGSxHX9KNIzUSPzePTbF7JxpnRvfUPxsTKIUTVZy8oe6Hshf3kOI0KK4KAzW+WDG2ylXLVCJVR4ZwopXYk/TnDssO3PRzF2yG4Ue6iJrVYSMez6EfRB1Y+91m4I5c+P7jcMk5XwkCtGHk5hul002Ya4ZT7FjJQIdu+YU6BrEq2jOwqS36vDEf0b8MQhEWUKKWk+DM1ORLNYhfGtk2UYUcNa2CFhjdcRRWRdXcfzJ3XVgkZNZUBgQ5ubh/g7tPVFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dI+rzV9kCNOvBmUZY4ypXBUrcTTuKJ998+EdK+7bwc=;
 b=xsZxENQwOZeOzoflSzQpqs2PUs7N429DgZft7jn7DXw9lLfDDjJek+7jqWU1/hXThBDyT666fqLSeSdWHowoVZUJJNKBREBuyuh+fEeVjhCMeS459z2wvl6IEWYp/0Y94ovRJ4DiJHUIlCHlxbzzTdQxDhXYseyIeoed0QAIRlQ=
Received: from MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::15)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:31:09 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::69) by MW4P221CA0010.outlook.office365.com
 (2603:10b6:303:8b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:08 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:06 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 00/18] amdkfd: Implement kfd multiple contexts
Date: Wed, 22 Oct 2025 15:30:25 +0800
Message-ID: <20251022073043.13009-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a22c1c9-c53d-4815-72a0-08de113cf79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YvwK+vTu4mSOPIJ97sZVy6jVxeB3CEMCcbJHPwGHXYvrES0pn8xgHLi0C0lz?=
 =?us-ascii?Q?5a9dCdP+m1qAkedQSZ7LHgiGj+vrcEA9zz6H21SL0jJ9bF967FtK2pPX8NBh?=
 =?us-ascii?Q?XuGDiK+w8d9FtFQRFlHCjqgWkjm9gE1bZ3OHgNd/plbd8dnMArU8gjqaNXj/?=
 =?us-ascii?Q?huqfoueR99J9zAIDXJwjEWn/sh9NpDQkckn9UFUlJSZxllPMxZdxUiJFCZW7?=
 =?us-ascii?Q?3HBOUt36tX9aG441V20pbJ8xeTKKvSgJoU7sfgdtxReky/NipXSlYyk9PoLo?=
 =?us-ascii?Q?D+SHG/uwlV+EMKerrEAifcq2e1F7kgwm4Xiu8q5nMb3LiqeqJGyhIf/V0zZ0?=
 =?us-ascii?Q?Xjn/6SaUoEu+rXgqUoQO2zJR/Enh/tWVRpZqdfRQUel8BQQmxWlNViFlAUJq?=
 =?us-ascii?Q?qFJ/5qoF9o5wdjl8ig8D8G3S3b+G0JRNN2ubDhgO7ikMg7dQ6XBmxepu5qJ1?=
 =?us-ascii?Q?pILlTOjyVBsQpL8DB/djFtsD5xnYRZP8zClKMiJqZtcTHH1FTnTGQYjY3ZwE?=
 =?us-ascii?Q?lEkZnigMYiM5IxCre7n4tYO8GZaWcUbVQ5ETIH9xo4BsCndJExD+pnuX0kr4?=
 =?us-ascii?Q?UZ6+cm50qC6aC4lLqUKOaRcC1k/vXQhyzDeJdPvx4l/gh/pEstXCtK+VTN4a?=
 =?us-ascii?Q?oGyx9F2pzpeBUt9qqzQdYrF/VjsUsSnuHF/UKsgowoEYEggtE+OJxEBuqi3k?=
 =?us-ascii?Q?m1KTeu85RjW9w/DDnCKmEccWLLoDJM7kdrqphQ8xv+2zp7FIDYXq98VOwry8?=
 =?us-ascii?Q?3xbjM1AO294QC09hHW3OG8mzyHiuNakQM9K0wTf3pzlTt1Tud2d4vJcNjJVy?=
 =?us-ascii?Q?g+g+VzvRFpJExgHaazgziPb+67kYHUEZGvphMTwlqRIBV7FrtQIxJEOf+qgl?=
 =?us-ascii?Q?uh+pIhPVStn9BFyR90GcnEYEn+IMzYjwbvjQ+momftb4GcI/G++KTPz7ewp4?=
 =?us-ascii?Q?emxGbia0fOyVNdlJK1dnjhWONficdUUTerSmv7c/OHs1uK4zPlT5wPhqM26m?=
 =?us-ascii?Q?opTj7LHmDkjA8Ml8VFdX7BQGvN2mdCL6kat6lMwLRvHD50uo/b85dpZUALAQ?=
 =?us-ascii?Q?NxRuaFlzNsQ81oeChjPAn8bomzglsZCqgxra05Bls4Mz5yhT9no1IUoA42FP?=
 =?us-ascii?Q?9FKx7IXLnTx6+EHWWvefHlJ1I+73RgfhhUKaV8s94uOnrLjIYyYx0TRo6dZ4?=
 =?us-ascii?Q?lpT4jW88jFDfTxaM4mXYGk2lUACF4qgWGeOl5JIaXOA1OXPWkLna4C5l4nFv?=
 =?us-ascii?Q?5ZBi5m/EDsVeA9oq1WSX500/FTB9iNC8eBH2LCmwexkJsNpfWKEKpZJC5mpV?=
 =?us-ascii?Q?kCcGKERtZd4B6iEs/j4Xevi+8DKi+vDN4i/sfcDsVSENMjYnBMeIYnzO76fW?=
 =?us-ascii?Q?MIH2tocm/vmzNk7Jm+YMgmSXJVhrZdZSXXJfmWK3gQura2PH++z1XrXHqUyi?=
 =?us-ascii?Q?RJNA673hgVHKz8/5rWxzEfSD2mhLV7dpttECSJOrf81DRz9VYH2BIWxDlfAj?=
 =?us-ascii?Q?YGsm5IVgNBhzmpOxeogspGTG/i0Fas6sDbvfIYN1eaNHYMU+aBwK/Iu364n3?=
 =?us-ascii?Q?4jPWi8ReCXKGZimSMjKi8pOlwu55WB9rKWrXAm0Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:08.1975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a22c1c9-c53d-4815-72a0-08de113cf79f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233
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

Currently kfd manages kfd_process in a one context (kfd_process)
per program manner, thus each user space program
only onws one kfd context (kfd_process).

This model works fine for most of the programs, but imperfect
for a hypervisor like QEMU. Because all programs in the guest
user space share the same only one kfd context, which is
problematic, including but not limited to:

As illustrated in Figure 1, all guest user space programs share the same fd of /dev/kfd
and the same kfd_process, and the same PASID leading to the same
GPU_VM address space. Therefore the IOVA range of each
guest user space programs are not isolated,
they can attack each other through GPU DMA.


 +----------------------------------------------------------------------------------+
 |                                                                                  |
 |  +-----------+      +-----------+      +------------+      +------------+        |
 |  |           |      |           |      |            |      |            |        |
 |  | Program 1 |      | Program 2 |      | Program 3  |      | Program N  |        |
 |  |           |      |           |      |            |      |            |        |
 |  +----+------+      +--------+--+      +--+---------+      +-----+------+        |
 |       |                      |            |                      |               |
 |       |                      |            |                      |        Guest  |
 |       |                      |            |                      |               |
 +-------+----------------------+------------+----------------------+---------------+
         |                      |            |                      |
         |                      |            |                      |
         |                      |            |                      |
         |                      |            |                      |
         |                   +--+------------+---+                  |
         |                   | file descriptor   |                  |
         +-------------------+ of /dev/kfd       +------------------+
                             | opened by QEMU    |
                             |                   |
                             +---------+---------+                   User Space
                                       |                             QEMU
                                       |
---------------------------------------+-----------------------------------------------------
                                       |                             Kernel Space
                                       |                             KFD Module
                                       |
                              +--------+--------+
                              |                 |
                              |   kfd_process   |<------------------The only one KFD context
                              |                 |
                              +--------+--------+
                                       |
                              +--------+--------+
                              |     PASID       |
                              +--------+--------+
                                       |
                              +--------+--------+
                              |      GPU_VM     |
                              +-----------------+

                                 Fiture 1


This series implements a multiple contexts solution:
- Allow each program to create and hold multiple contexts (kfd processes)
- Each context has its own fd of /dev/kfd and an exclusive kfd_process,
  which is a secondary kfd context. So that PASID/GPU VM isolates their IOVA address spaces.
  Therefore, they can not attack each other through GPU DMA.

The design is illustrated in Figure 2 below:

   +---------------------------------------------------------------------------------------------------------+                    
   |                                                                                                         |                    
   |                                                                                                         |                    
   |                                                                                                         |                    
   |       +----------------------------------------------------------------------------------+              |                    
   |       |                                                                                  |              |                    
   |       | +-----------+      +-----------+     +-----------+    +-----------+              |              |                    
   |       | |           |      |           |     |           |    |           |              |              |                    
   |       | | Program 1 |      | Program 2 |     | Program 3 |    | Program N |              |              |                    
   |       | |           |      |           |     |           |    |           |              |              |                    
   |       | +-----+-----+      +-----+-----+     +-----+-----+    +-----+-----+              |              |                    
   |       |       |                  |                 |                |                    |              |                    
   |       |       |                  |                 |                |        Guest       |              |                    
   |       |       |                  |                 |                |                    |              |                    
   |       +-------+------------------+-----------------+----------------+--------------------+              |                    
   |               |                  |                 |                |                            QEMU   |                    
   |               |                  |                 |                |                                   |                    
   +---------------+------------------+-----------------+----------------+--------------------------+--------+                    
                   |                  |                 |                |                          |                             
                   |                  |                 |                |                          |                             
                   |                  |                 |                |                          |                             
               +---+----+         +---+----+        +---+----+       +---+----+                 +---+-----+                       
               |        |         |        |        |        |       |        |                 | Primary |                       
               |  FD 1  |         |  FD 2  |        |  FD 3  |       |  FD 4  |                 |   FD    |                       
               |        |         |        |        |        |       |        |                 |         |                       
               +---+----+         +---+----+        +---+----+       +----+---+                 +----+----+                       
                   |                  |                 |                 |                          |             User Space     
                   |                  |                 |                 |                          |                            
-------------------+------------------+-----------------+-----------------+--------------------------+----------------------------
                   |                  |                 |                 |                          |             Kernel SPace   
                   |                  |                 |                 |                          |                            
                   |                  |                 |                 |                          |                            
   +--------------------------------------------------------------------------------------------------------------------------+   
   |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |   
   |        | Secondary   |    | Secondary   |   | Secondary   |   | Secondary   |            |  Primary    |   KFD Module    |   
   |        |kfd_process 1|    |kfd_process 2|   |kfd_process 3|   |kfd_process 4|            | kfd_process |                 |   
   |        |             |    |             |   |             |   |             |            |             |                 |   
   |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |   
   |               |                  |                 |                 |                          |                        |   
   |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |   
   |        |   PASID     |    |   PASID     |   |   PASID     |   |   PASID     |            |   PASID     |                 |   
   |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |   
   |               |                  |                 |                 |                          |                        |   
   |               |                  |                 |                 |                          |                        |   
   |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |   
   |        |   GPU_VM    |    |   GPU_VM    |   |   GPU_VM    |   |   GPU_VM    |            |   GPU_VM    |                 |   
   |        +-------------+    +-------------+   +-------------+   +-------------+            +-------------+                 |   
   |                                                                                                                          |   
   +--------------------------------------------------------------------------------------------------------------------------+   
                                                                                                                                  
                                                  Figure 2  

The relevant reference user space rocm changes could be found at:
https://github.com/AMD-ROCm-Internal/rocm-systems/pull/78
https://github.com/AMD-ROCm-Internal/rocm-systems/pull/110

Changes from V5:
1) change upper limit of ida_alloc_range() to KFD_CONTEXT_ID_PRIMARY - 1
2) in set_debug_trap ioctl, check whether the target kfd_process is a
primary one after checking validity of the target pointer
3) in set_debug_trap ioctl, check whether the kfd_process which
the ioctl is processed on is a primary one
4) in AMDKFD_IOC_CREATE_PROCESS ioctl, place filep->private_data
and related code in the critical zone that protected by kfd_processes_mutex
5) add Felix's reviewed-by tag to the series except patch 8,17 and 18

Changes from V4:
1) rename process_id to context_id in struct kfd_process
2) remove primary flag in struct kfd_process
3) reject set_debug_trap ioctl request when
the target kfd_process is non-primary
4) other than default 0, assign context_id 0xFFFF to the primary kfd process

Zhu Lingshan (18):
  amdkfd: enlarge the hashtable of kfd_process
  amdkfd: mark the first kfd_process as the primary one
  amdkfd: find_process_by_mm always return the primary context
  amdkfd: Introduce kfd_create_process_sysfs as a separate function
  amdkfd: destroy kfd secondary contexts through fd close
  amdkfd: process svm ioctl only on the primary kfd process
  amdkfd: process USERPTR allocation only on the primary kfd process
  amdkfd: identify a secondary kfd process by its id
  amdkfd: find kfd_process by filep->private_data in kfd_mmap
  amdkfd: remove DIQ support
  amdkfd: process pointer of a HIQ should be NULL
  amdkfd: remove test_kq
  amdkfd: introduce new helper kfd_lookup_process_by_id
  amdkfd: record kfd context id into kfd process_info
  amdkfd: record kfd context id in amdkfd_fence
  amdkfd: fence handler evict and restore a kfd process by its context
    id
  amdkfd: process debug trap ioctl only on a primary context
  amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  10 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  90 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   7 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  61 +----
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   4 -
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |   4 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 239 +++++++++++++-----
 .../amd/amdkfd/kfd_process_queue_manager.c    |  39 +--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |   2 +-
 include/uapi/linux/kfd_ioctl.h                |   8 +-
 14 files changed, 304 insertions(+), 200 deletions(-)

-- 
2.51.0

