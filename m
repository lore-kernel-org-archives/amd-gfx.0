Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C170CAC5A7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1373E10E397;
	Tue, 23 Sep 2025 07:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dRHzHvL+";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BDAB10E0E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrZpl3MLeygFGu6W2UGK5kXA1TtWb/EtS4JoGXDlYl/i6UfL45xNXUDJ8LWaqZKX8j9Yre6OnRO1SQHj+Byf5hefJUjp9EJReBTmqsMglL7oKAa0iW/PTdinVI8wB+rfJN1/9VGk+fAhaNK0VF0GaF2yKgm9CeLzgg03LCq6cip4h5Buqhd+wr5WAB0j5OXV7guFMkRuz6eslentlE42ZZSM54UKJYrm+nVtb5y9ohgVbL2npgU9kbOIFjm7jUfhavXXJKX2tmlPJXnVv+FYeTAB2CCjpEkEM6SW1u//NiBsKer8av+imvyUoXy7ffTkosnpH88cEHKjYX9NqRPJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8hSI/ayMQcRP0SSYaUIxYYVss9RySgQS0lpWQzpn5U=;
 b=V0VG4+gkB4kF8na/HVuW+X+Mtge57o7dFv5ASO69OIoU+W++hWhTFx/VyPpHWe3NFTxmbHaYIe6Rblx0Ie7D16yiKlHxy2UzE5bjohKJ69Maxo/mn8isUQS8qm7AWBZHihzOK/latv0dmcUjHHZ/pKN3FcpphRlZ7JUgKqSOXT/jeSreSC5P0VfIcFfjpLKXUYnsuQpiToHWF8WSmufRFZoHakE6SxC+uFQN55xqbTfPnPcEyrFi/ErGxAo08uUqv86K4GgYWAKMVTRWdkQfNyxplrFAd65KJxNa1Cs9IxF4j73hH6avo16eDmFPRcPTQuFgmaRtb7lLtpb9vmy6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8hSI/ayMQcRP0SSYaUIxYYVss9RySgQS0lpWQzpn5U=;
 b=dRHzHvL+TFebrc/3pVUjZcoC4tCl7AHFpB8M8Fyegu/n3487tRV2o8/6zF8gjXW4IgcDqXr0sQDahnjANop/43yGc07ltAuZOb6nlq/5iZEZYxmMTcko4teTO/qOqIdeVkkoAXs/tI/HCfbFKfDEIYsH6y8jDPZW2QkggKeFJWE=
Received: from SJ0PR03CA0257.namprd03.prod.outlook.com (2603:10b6:a03:3a0::22)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 23 Sep
 2025 07:26:34 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::36) by SJ0PR03CA0257.outlook.office365.com
 (2603:10b6:a03:3a0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 07:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:33 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:29 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 00/18] amdkfd: Implement kfd multiple contexts
Date: Tue, 23 Sep 2025 15:25:50 +0800
Message-ID: <20250923072608.252345-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: 35591b13-2682-47d8-cf7a-08ddfa72860a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C/P8pu2XhZ0kpdDSWWs4kXWJVOO/qDAt+BrbYqUYS5lS8kJ+d54P9btXMf4z?=
 =?us-ascii?Q?rF/3QR1J1c7Pl1WIbUoPKWehpSEhj9mUFKX65tCGiO2hTrk8qyOHBSy1z6o+?=
 =?us-ascii?Q?2iDLSGSg+4bYCDI4Bx3UgzE/jrf4QwX8AJ7kkmpxUWTwNXrBXHunjKk6Y//x?=
 =?us-ascii?Q?AISBDrJFyWbknhnRoWtwqDugAjLJDO8FPw3CXIHEg7qoQvu3MqsEws194hE8?=
 =?us-ascii?Q?jPoFkl2gOB9Zqgm28oCn9aJU6CdL1aW2oj3FyGeGS9xHqPWBfFsiIfPovm6u?=
 =?us-ascii?Q?jhq8kz9+Hfl6Mb0zbFJWuSLFW/mnComBeheLtsiewNje6vjKazqHW2e5Lvv6?=
 =?us-ascii?Q?+wsdYR5CklUYkUScbZyW6I7iVSSZQ9hl4Xzar0GWQneVahvZfmVbQwdbUNbQ?=
 =?us-ascii?Q?91gGEUmcEjGVAvIAWBDb7ec74VylwNfwaXTCGlzHqiFbPaXXCuwPWQXWzHz7?=
 =?us-ascii?Q?O7TMu7JVtRnZaGZpN6DjH4rhe/++dUGqybQJjYbz3v1TLccWe8XXhFETvZxh?=
 =?us-ascii?Q?M/HaJk4FtzZrrefhHiGdAr5gc+AJCER1Scsq0GYd1hqUYyj9FE99L5iaBveo?=
 =?us-ascii?Q?o8OTud87mphtwBAeIRs4I0hmuFQKlWaR+XcmpHyycFDRwSerKe5YBEwWdZrw?=
 =?us-ascii?Q?nyKxt3imhOwiA6FDPUWI3G/2Q+wPEJEPe6/Kr5dj5VqNX/uZgfSRiQu1NS2k?=
 =?us-ascii?Q?dwcT9FbnSG3LVT0Phz72Uqu/6/GJuwCt17ouLgS0KRHVBEypwRiigcVxTqvX?=
 =?us-ascii?Q?Jh/6ZjOJ1A9uHp+Sui+jdliO4RfAcGjEqWxnfh1FVqogPz3qNzPKxjDWl2Ee?=
 =?us-ascii?Q?QR/NY6aBEJlIppEGzWqz3Yc5RQvKeagHR72ijJ+N/cV55uaeo9JlMXFPZkTR?=
 =?us-ascii?Q?XWxyShyBJiuG6HH4hICdUG1iYMMZR2Px0SRvbHKJdiot+Vd4XOdwlOZNM81U?=
 =?us-ascii?Q?iiNlP6TsC+XfQfw1kQjiEwbqEBJCVhziQ5bepZjmiTAW8PG+SRk0rJvXKy8e?=
 =?us-ascii?Q?8Mh8YPKANYNTlFX6MkoEHIKLpvC47WQdbZZfn5ua6r4/Hq6KfjW9W5kW8Ono?=
 =?us-ascii?Q?rx7YdcNkR3kdmNC9tRc3VNb2ytsFW6K3YDBmSrJM6k/uo82jeilp5TBX1GqU?=
 =?us-ascii?Q?K9QD1uhb+b856YXLoFFFVmFaLVCdTuhXLRuoARdDQNcgcN2sbtiwSur8/h7X?=
 =?us-ascii?Q?/vWxF+rXClD/h4Y2QSevr5rwglaXLwiK48qgtIeswS1+YAAuvpWEsqns6j4K?=
 =?us-ascii?Q?Ql7VNDEo1xkxfRExl/BzvlL3SKHOM8F2T94sQUx3JyeSwD0JKDMgegZDN0ul?=
 =?us-ascii?Q?EKYlvcILCfmER7gtPDWDI7FUcP2Skbg4D6pTMbxFp8klx79aZIASrYDtbbur?=
 =?us-ascii?Q?gJG/N64RhGPsAwSm1Y9Th4rJ7NVTzkinFriM4pPs7WnjG6p7xV2xQf6akYTC?=
 =?us-ascii?Q?6+PZE9s94ZL2yh+PmYQ61fP/w5FMfZG6SCaWN7B0Le/QPA7Nnh2Pa/RhHRyc?=
 =?us-ascii?Q?C8rFt3/z5NYDXT1Wjz6mjXL2mInI8UDcJFVVKAlSLlqAV0bczBn/KbUhjw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:33.7214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35591b13-2682-47d8-cf7a-08ddfa72860a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8
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

Thanks!

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
  amdkfd: record kfd process id into kfd process_info
  amdkfd: record kfd process id in amdkfd_fence
  amdkfd: fence handler evict and restore a kfd process by its id
  amdkfd: set_debug_trap ioctl only works on a primary kfd_process
    target
  amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  10 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 102 +++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   7 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  61 +----
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   4 -
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |   4 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  17 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 244 +++++++++++++-----
 .../amd/amdkfd/kfd_process_queue_manager.c    |  39 +--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |   2 +-
 include/uapi/linux/kfd_ioctl.h                |   8 +-
 14 files changed, 321 insertions(+), 199 deletions(-)

-- 
2.51.0

