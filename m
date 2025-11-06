Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923E3CCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF0210E0B9;
	Thu,  6 Nov 2025 06:08:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tK286P7D";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011033.outbound.protection.outlook.com
 [40.93.194.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C77610E0B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkTcqFC9GJMQj58jtWPmmm6IgA8HThrND4hoKtPGYfXPteyIMjBVosmZO+goWZ8bZH1yorrxcrdctloDbJrIUGSFTm7zbP4xOEq3AjG+JJk0xuix+crovyubJbvkFM6ikft2HQmJWu8aZglm1C/f7dgG17HaSFvQVTjP3yNsFPAflwkS4WH+ca6j6uJdrRpyEA/AhZJ5s/LhU9degOxpwMTo+BxDLt0Sg9K3HTyM5RzW0o8BRkbDNZeTwVaSz0Iq5P6KBVVwOs+88VwWSJu5CuGMekwAqJkXH3qh58j6CnxfX0yVIAV7Q04z830ogl8fSTuvn5TqY5adVbgo5QFHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdw2Evw6vxO8576496WDo/PNZANTyhzjvbZ26eGsjPE=;
 b=tbp+HuqVnb9TT4IYCYMFSyQA0B/8BT7eCPSgnyuZA8XTOGEriWNPCNJKUmXtHW5pNxmibiM7Yxn+tlxPHef2NkKmPOWr2VWao1NeU+JxiGWLRtAGuO8QcyQo5Z0FteO5tdT3rLlS8HYfIv16+7GinsIAuMHz9m+8DlfGF+kKqgzi6NzjHILlZUkW6S+MHkcCm/N6yFhhX5HMlf5oSr6M/GG7vgj++g77PqRsHmvnvZBT4511YirnmqDgFO/M4bXpdjnmkqYgQtWgAnH0HR25ohc5mTtNjyaodzjBfccrw80Goy39wJtMZQnOUoIjJV7ugLDEetqv+N0EagF2gTGeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdw2Evw6vxO8576496WDo/PNZANTyhzjvbZ26eGsjPE=;
 b=tK286P7DEGtknYZFpd+vi+d4nQyTxGny8YIvOZ/Dl/YkiTKHswY7ZyS6iPPIU0MmDn2L0LwUX181LwgWc7Pwu8uNVVeKmveXR8NYq6KbNiF5nG2JPvuDWuSyGb1tL7Zkj2ic7V9j0+5vZPF7V3lURQefh3EL2TDj2ty5RhwQ1kE=
Received: from SJ0PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:33f::32)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 06:08:05 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::dc) by SJ0PR05CA0057.outlook.office365.com
 (2603:10b6:a03:33f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 06:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:04 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:02 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 00/18] amdkfd: Implement kfd multiple contexts
Date: Thu, 6 Nov 2025 14:07:21 +0800
Message-ID: <20251106060739.2281-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: dbad92b3-78ae-4f0f-b6b5-08de1cfad97e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9TNnl/Cs7Yy7qvtfpolIWCqcXBRomntHWso2QRjlbBEeWLRdnPKa0ObO8muD?=
 =?us-ascii?Q?SNN11VHqBBEY65iEDDWI8/cmupshWyzcKbd61sywEVc4KKZGYO1FQ06G9wNd?=
 =?us-ascii?Q?fU2WSKhh04udswQU+8AAHN3s4HWTb7eHtBOcUABXYpFNVnSDaeOYSJipgeMm?=
 =?us-ascii?Q?BFFVyGKkxRAF+1MCCdST1K78sQRbNEkGkSS2Z0ik3gS7fzhfRTmzRWHddOxM?=
 =?us-ascii?Q?exfuaoDnvwwyFLTjOHTnepKeVXXZSCag+4X/ekgp8eZ1ICgBoS30T4A436Q7?=
 =?us-ascii?Q?NdyyvrixGx4glLs5qKq86YLn0IeN+3LNAn9DGeJa6RWRR9qgEuEPUxnBo/ta?=
 =?us-ascii?Q?qTcZyihY+1nDNWLF0UNkAcAi16KD9vK4BW/bYX+NGFWZhwgR1O9wmIhPhLDG?=
 =?us-ascii?Q?7DQ4ey0LsNrL1a07Fb6r/ympZ0GaQ0zDcKQ0H+ygUgzHadnvT2o5EVLAXveu?=
 =?us-ascii?Q?1KDUjga5oI1FCABy1v8HAdKptdCBjq/uk4hwaO9qkFv5CW9aLqNQc6suqusy?=
 =?us-ascii?Q?qcQHuOG2rCs3ZKc1V7mzIHfPkzYNmHEFCP1CqHtj8Y5/DuIVkh7mtnKK4tTK?=
 =?us-ascii?Q?YHw7TbFSAyV8fSGrcnHCjdZ+kf0dsui6GFdMOJLpSAKXThKDbOwft9K5MZDp?=
 =?us-ascii?Q?021IOYjK8TZ54a1PWZWSs1lKXyRxH82/dDIiqRG9NsYxfeOUc9Naao/QUypO?=
 =?us-ascii?Q?pJHBJHP41w+INRSYZ4KKzlXkKEciJTxTGhtipRZ+0TKnc5cHi9Qm6Y1ZBO7M?=
 =?us-ascii?Q?udMirPBLzAJaB0geIYOlskTzMPGwRTmCVNoTwiA5jEqIiRu9EQnRPjd4tKbn?=
 =?us-ascii?Q?yE4fP5GFEJOEwAqkTWjAUHj/CJerdZ9nhz4kiGGExR+Pdu+CwYtCDjiTUCWI?=
 =?us-ascii?Q?wNQrKLqaFTDJnnzMRhuUv/2gU+HQHL8De5lBJl3mZp6yg4QAltjTe8znloYF?=
 =?us-ascii?Q?EDr7uuyDox8YMScvbLUbaWtlFepPEgAiUPD6SndzuPKoC/MKrye05eV1UWnk?=
 =?us-ascii?Q?/xJmP7IPX41i9tp2PjTraSUcuW/HTaNWQGRyZLWfXdRglFsed+0cNpwXKHuh?=
 =?us-ascii?Q?jcvhy/LRIEDFRr9rdprn6ZU/RzGdqQcJ6gQG+yXp2kowGhcdcfowARgGK7Om?=
 =?us-ascii?Q?E8P8wMPH5I9GuXH7e+4W0zdTTxW9Isri0bZZD10Rdu3bRccfDljW84+LsxOR?=
 =?us-ascii?Q?yaGB+gxTjqclS51dhwC0YLfDFegWO2asbWklmfAC1IQa21BieOESXwmApVP+?=
 =?us-ascii?Q?neWhjIYs79hzNYyQgDFNXRpBN4P+RfjejuE6w7hjNpZbegmoDoNOzVamJUrj?=
 =?us-ascii?Q?DWKZgG9tZllrKq5Y7ZuT/8edYmVertxTWrYH/LnWZaDFBc1fUYiFR8Cj2u+R?=
 =?us-ascii?Q?hM9ob7A61SJoRpY9+oUBsxCspfWlXcwePJuUf0IGHJnxXiKD1X92WyRYrpR7?=
 =?us-ascii?Q?aUVcZJE6M5q/cJQXxaa1qOum3QMTSXmkLZAmomh/sDyQTDel3QbtZ6SY0VJC?=
 =?us-ascii?Q?9md6p4Z++GYSCCcE6JpASGvJGwTlifRXRerGNXmUZ7LykwDpprXO6W8NSq9m?=
 =?us-ascii?Q?Ay7yMldmp9lLCPbRhc0+RRUUb+1Au69N2rYcprnf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:04.8220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbad92b3-78ae-4f0f-b6b5-08de1cfad97e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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
https://github.com/ROCm/rocm-systems/pull/1701
https://github.com/ROCm/rocm-systems/pull/1705

Changes from V6:
1) Minor improvements in ioctl AMDKFD_IOC_CREATE_PROCESS
 
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
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  89 ++++++-
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
 14 files changed, 303 insertions(+), 200 deletions(-)

-- 
2.51.0

