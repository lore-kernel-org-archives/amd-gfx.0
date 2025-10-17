Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D0CCCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F6D10EB5E;
	Fri, 17 Oct 2025 08:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Do7JRjH2";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013036.outbound.protection.outlook.com
 [40.107.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6375C10EB5F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sL894wWyJsRGl1UdnKRmzp+brCXnYXBeH9yoDXKEAZR4jq/xDVpsflCljGj7gswEouOibUYovaGKkaJf8icuAX8mfUCx93G6fDH4JKMZmuJfCidc3fOZPSN27xxwHBEj3dns3xKrsNG/CIxxDzVsaBifewowkoyOsruKe+VQHd4rY9M4gWH28P//Ny0cpwyV6X+Fa26oCp+zfks9x54DAtCWM5DDwVMus76V0fzH77NHxMpw/TofJlVjuM6s1OBT8q7QumYU7SmEbhcJj7ock5+b/qPIp6rfaPL8tzNmcVY1Ap6+KrV7xB/wIx1ZvtdP+/IWSQji3kxeY0smY/U+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8m9/jd4WehuBRd5+gMpdqO7+VPzNamD82ptOgZdCPc=;
 b=rJxmAGXaxSPVp097/9AJTNzWw71BRGhiK3/7r+eqVLwMsJBE2hmydMLiSKp8RaVLW+u7HmzpJHe1nDnf+Arwlyr1lujGKg44AbxPvfhizgz5fU9mwp4TW9xd8VpQ9Ll6nBl2l7jkrvfUel17l/+nzITFs2aX9zai3N/tntfJIK7V2sJMHArdYG1iDjU0Ni8Suft2OtR0zet2E/qhM9M8EgbDtgjZo6meKUWXz+2wm9RIB5XFExyuUbQXCWMqjNnCEAHvI+KxtvZiLM8FaBnl5OhCfRywPe1gvZ8lChww8rM2YA36N8/mBR54cJm9eSinoEy6BLi2sBaiXw1rRTKF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8m9/jd4WehuBRd5+gMpdqO7+VPzNamD82ptOgZdCPc=;
 b=Do7JRjH22t0W2rw5xlIUc9xXOYJsPq8UQ8HuMKjVcOwLvSQF+n/8pePfUsMNJUkQorUqfdjP1zmzLLE5fXfP3WeRuullBFvKOodmkwOPR+HkyZ5Vp0dN0+BsEL/bNdVm82NeFBOEoH3a4xduKcUwA3tTO3/qzI1TtR3SWDY0Peg=
Received: from DS7P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::17) by
 LV9PR12MB9783.namprd12.prod.outlook.com (2603:10b6:408:2e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Fri, 17 Oct
 2025 08:43:16 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::93) by DS7P222CA0005.outlook.office365.com
 (2603:10b6:8:2e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 08:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:15 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:05 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 00/18] [PATCH V4 00/18] amdkfd: Implement kfd multiple
 contexts
Date: Fri, 17 Oct 2025 16:42:04 +0800
Message-ID: <20251017084222.54721-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|LV9PR12MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: ea413371-cbf3-400d-3883-08de0d59369a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rfIEwydz2a6WjunoeZYIi2cv0BzJAorqed9OxGG6Qp3Ryj9tzQyGyGSX3h6P?=
 =?us-ascii?Q?9TC/bS1302k1DL3phzwxn+dUHXT3QkM1pHkPiLTpV68W4RvyVHRz54pCXMCw?=
 =?us-ascii?Q?IFLpH8Lxih2z/C8SbZsTq+ArtEbc+O0tif9IWWmxr1SKQAV2FSkqpN0QNh7i?=
 =?us-ascii?Q?8s3SX3KcAqBG2z9t14vhHdUM2/DNnui65c7t6hA62QCGGdPmHTCMlRe934BD?=
 =?us-ascii?Q?F9EifT4htDVK95tsd4vXL1ulr5jID63lo47Ot4w2eF/U1GlJADVEHgWYrdXh?=
 =?us-ascii?Q?OOEvFaJzIoLbyrRSF01usWr2GdI911QcyCihRYeRXr33s2cQ8KwaWkWS+A21?=
 =?us-ascii?Q?9OVsmIa4t+vKkFSBCtS6onxhsJyWOsOAFv01BSVc3kLrQJsJV4ckL5tLtZ5O?=
 =?us-ascii?Q?JEJ/mDGryfcyxHYnqRRj2f1YuKupFpHE3vOwGMAqjSle28Puq5Wx+1huOjFS?=
 =?us-ascii?Q?qxgSbl0B12XJRlF1lkITlfMGXxJlBBmO3xL5Zzz1i+zZm+qbNWWECsvbKATY?=
 =?us-ascii?Q?dRsHJzOwpf7n+qMm5id+woQGYErYC4Ug+y6I1+ozqo2Xfl7qDJr62lUD5RuS?=
 =?us-ascii?Q?DzLGumK1/sQUJK7UeZ2ZQwpQsTUgq5Ft+peelyopFmOppDwPzLrzHHWRS1zS?=
 =?us-ascii?Q?fEZ9ACV+VJVqCHw+G7CH3JYzcdeME4K1Iifdf+z3j3JSf2er3p+011q0+D5C?=
 =?us-ascii?Q?64qFuP3twu9HBhfISgPwDSzyPwH1maQEwG+pJHKwEHws6mwZmjGgmnH+MNEy?=
 =?us-ascii?Q?UsEYyCYH1eifnvSz5e1zYteTHVnsCwenciQpotjKGJ2iMxs4qytZXBPQIcxu?=
 =?us-ascii?Q?KBijmiMExHQRvom2YaNcfpNKGUCeVl4mwDZaL+31qW9AyR2yv82aV7GL0xKk?=
 =?us-ascii?Q?jiKWpolQfwx0l4gxTRXXCMEmJBpXV5jhV5UesktxB8jGLkBk8MH2YAojN4Yv?=
 =?us-ascii?Q?BiE/TvvRg2XMf3jqTIIGLFvE1HeUOGAMXBuE5ISNgGI57KNl0sxGmSrmd0Jn?=
 =?us-ascii?Q?cvLTC3WH4kuGm7WNVcegbSRP7F/6sn367QW1J9HPOWQbT0XLI4vGaUKB4Mj4?=
 =?us-ascii?Q?JVyN3MaIl+cILZ2Yv7jXVN0vSsaswv7ng0C3sRLf6HrPAHodRJNRSLjEz3EJ?=
 =?us-ascii?Q?bQbyBih33nTkLNdbmuqlM2TxLsY9l65pnKlqe9BBO4ntkhrGyTcNTdQ8pQXp?=
 =?us-ascii?Q?EddmaeTRcnvsiK386xqFuC12zFuLNyyJUFnJCNshbcLXM4FWlddHrfMF/PkF?=
 =?us-ascii?Q?4MDAhWrjbbCzFZOSDGzQ26vr7Lkx59e8uOQYqXX0VzkBcEbdwcjn2FqNP5KO?=
 =?us-ascii?Q?9jIW+98K6rzC0O7WTkhkqL45bmqDsO3nYYrKJx2hG8jGacTjqfXc4rj9AzaW?=
 =?us-ascii?Q?uhbgO4QCRGPL6I4eqfVW1lRnA2mLb6ysFEUuFldFLcoIG6To2C3roymMDMG+?=
 =?us-ascii?Q?qE/sqb93DSmg6tChWPGkJ1ActA3lgHIXI1vATgbwldFHR1BG6uvtRICZzrFb?=
 =?us-ascii?Q?RSA1QqqV8n5ikTMETQFUIDF/SUjgqaDn55JhfsDCvmu47mC06R1Dk58Y/kCH?=
 =?us-ascii?Q?Es/ucN/bb0PSvLSjacmRT/DAOSpIKVMLVHr9T+F+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:15.1721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea413371-cbf3-400d-3883-08de0d59369a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9783
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

Changes from V4:
1) rename process_id to context_id in struct kfd_process
2) remove primary flag in struct kfd_process
3) reject set_debug_trap ioctl request when
the target kfd_process is non-primary
4) other than default 0, assign context_id 0xFFFF to the primary kfd process

Most of the patches have been changed, so I removed
their signed-off-by tag.

Please help review

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
  amdkfd: record kfd context id into kfd process_info
  amdkfd: record kfd context id in amdkfd_fence
  amdkfd: fence handler evict and restore a kfd process by its context
    id
  amdkfd: process debug trap ioctl only on a primary context
  amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  10 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  79 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   7 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  61 +----
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   4 -
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |   4 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  19 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 239 +++++++++++++-----
 .../amd/amdkfd/kfd_process_queue_manager.c    |  39 +--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |   2 +-
 include/uapi/linux/kfd_ioctl.h                |   8 +-
 14 files changed, 294 insertions(+), 200 deletions(-)

-- 
2.51.0

