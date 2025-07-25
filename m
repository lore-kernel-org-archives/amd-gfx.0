Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13D9C87FCC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 02:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1918710E0F2;
	Fri, 25 Jul 2025 02:43:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GgbQxAjm";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F052A10E0F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 02:43:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNLSo9LHWcVe7NxBVaQo88o2BMM8ywO+MgM5OP2xYCKIu0jhy6L5VrM+hP2c6n6WGo2nCk8QhbyZiN4cRnPL/75sJwn2FVfKbpgYZ6G4bYH8OGhvjN9CVlyNzEolKcJhBmbtia5zefm5qyfoL9JPHNexGaGux2FLlBwWGNVYb6n8RgIPD43diSgenLaQXY2EmQJjHP9nVcAU2/IIeIgEIN9tSxr4WDt4Nm2kMynZ+EianfOgdf4Bw6tSPA+e9Gjx4qCfeEtFCVJ9/MquqICOU+3Psfz8GQ9jhtxwEGsugxzeFQzy6MCcO+Y0eKzfJZOlKDomHmwlCXbzZVs3NmCGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GyZ6LFZFlQ8ejwf3TfbYSl38KlLvGRNOG+E5VlNri4=;
 b=pzbrMbXugP0dJvQYg4s01jpFFoWg9heSXCg+HgNBxGL4qOFD+AWLnj26a3htVyUHPZjrXW+fdB0DqEPryMTGrYfjxE3BY2wFa9efB2y8u21CJeyY9SbVpOwfsWPQ3IZtRS2e0JK6M+zRrku7Jq95go5mhlIDrxSNZs9lJKfQphfwrEiOD1xqUJZKuhqzR/WyqyLk8mWHnH7+hGQD9FXgLl4xrwqvTN/1j57E6qrZP4pQKjRRg41udf8NNwGvcI89hlLNV4q8dxnptUIVRrQF2f2X/RGgbUxWtCjiyp/yR2ZU9iALvlfxnK2yWFqXnP/j6RcWlf6Ka7WTDwWqjWweRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GyZ6LFZFlQ8ejwf3TfbYSl38KlLvGRNOG+E5VlNri4=;
 b=GgbQxAjm3pSmMBcyQ2bA0jyy77lv2wvE6pAGJbENfTo2CrPlcHAyEwpwagZfwHQw4Bnw+xdh5ZRDC5L8Nw9zoMGu5LkftluKyGn7K3yXQZn+1TMnjJT6QIp+aSPqpLsRdQy2hwuBvazX/OHN1yoM8jJD5Fyw0rhK/j77QSA75MQ=
Received: from CH2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:610:60::20)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 02:43:31 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::b7) by CH2PR14CA0010.outlook.office365.com
 (2603:10b6:610:60::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 02:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 02:43:30 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Jul 2025 21:43:28 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 0/9] amdkfd: Implement kfd multiple contexts
Date: Fri, 25 Jul 2025 10:43:07 +0800
Message-ID: <20250725024316.9273-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: a83672ba-b84a-4fef-be36-08ddcb250a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6cwanGV0VDhOwjach4s/IdvSY8ngRBklCYCaISJhrX/VgUHxLNlNKPN+hJq3?=
 =?us-ascii?Q?kYcwbCb26Z+gvVO8YE0VKwfMcQA7MJw7RogZc4VpWzRMe1Wih0wbbMPo/3ZR?=
 =?us-ascii?Q?uSCwfMY4ouscG3Xt1nZekSp1Rl+sLNx+9GeGLDlaS4gwMSAmFd+bpmkR2rka?=
 =?us-ascii?Q?fSZFJyS/50RZtMeVbDFl/7ofXM7cfnPUUTj3kYSIjvsF8DdLcGAEjY53mhEN?=
 =?us-ascii?Q?aaCVAKdpc7v4KgOQg3HbmfzGwDSBJz+iRexAolXff0l1HsMZg+9kkZQEv0F3?=
 =?us-ascii?Q?fWarCMn34lCnCoXY1lJh9S1R/LFdejiZf6oI6cKO/ve9s501qtpOKD9zaL01?=
 =?us-ascii?Q?iLDFY7PV3czJ+UmJj9UbZUSNFF6FCOdUbSSYuRPaTP4tWpJTUB0gRKw5sRwQ?=
 =?us-ascii?Q?wDtBcH0DD8R7zOqTIVRfnTecpib1Q4hYT3ZqOrA+3ytiu1B0+coUmwhKd/SI?=
 =?us-ascii?Q?drHvq3N3RLY1ibP4DNH8qQ6IdnoKoaJoTUOLEtRZG/SNkiaqAk7Vh4Frwg0P?=
 =?us-ascii?Q?jqoqwbqc5ReUnygaTc1/DaNCwougxIqJi7RUcvg8dB1yIRwuTnyJbXcON3MU?=
 =?us-ascii?Q?VBExoZQEZlg+l4lBi66Mfk1dq/UlSkbNb/A4wftEVTYOPFAXTSdkbty5+jyo?=
 =?us-ascii?Q?Pv67tBcaaa0hst8xtI0awf1lgQuPDG1jWoCaMjlrM26RZbc8b20A8XVomSXR?=
 =?us-ascii?Q?zBJASq2N0tQOS92Vg6MITOdfWaiLhwRhEkRqvWujeeILek2SpFMTsaxh8B42?=
 =?us-ascii?Q?dnzv0wduEuVBeZ63WlkS6ceKVuL2H8JIST/456PZe0W3+6g8FRWacx9InJ2Y?=
 =?us-ascii?Q?fQruKqgDzBbvf2bOi3JQbdPyFGCBqUeybjuhVjhHkaEivJ0mDs2P/TFd0Zck?=
 =?us-ascii?Q?bZOD3wLN2Z3l/KrP7/fx/nLdiBPakl1mcv1AO7nc4ZkMg/BxtD23UxA3kIAt?=
 =?us-ascii?Q?rMxmnZLc/4iWzScPpFakpXqLCMG95TI6L3e/knvYV5tmjZrHEnJyDTJkMnpZ?=
 =?us-ascii?Q?avsVPfPmle7r8yXho8cY9iiHe2NJguhx4NeyXjI73KJR2flucrnjTG7WGe/e?=
 =?us-ascii?Q?EIf4OF6Xegl0ADRcOf/8OgcedcRU+dTcXjFnnQxesSpxf05hkE9TZp0mfreb?=
 =?us-ascii?Q?vnd98qd5XGSd0dBxJr+5MKvnMGDTbCB3XFTJjyxvvfvr1fVatiSmmqzJKhQW?=
 =?us-ascii?Q?Qtd5JuAXJcaAcu03mrId4Bk0bhULzwMXIzZG1llGTRg5ksTrKaRGEoe5BDPN?=
 =?us-ascii?Q?WWxj/REiq2ghfGF/dqago6HCyJVCemhp43GzE4jaFbmjS8+jWdrtOQ4GP7XN?=
 =?us-ascii?Q?IfPFJ7nQ8p9I/J5iRtwmcusWcIseeKQ1TX8AhYyYpqzl4fj+hIF19N0gujXC?=
 =?us-ascii?Q?hOdH8+5KutTg9N3MgL1MbD4YcxLjWB3rDuUzl08rlC/lMDFgUXyiyRBSPr02?=
 =?us-ascii?Q?h+t4YkQ43z00/Xw90kgvoq5YdCR5KGcuRFwxUT0fZE5PtyCF6neYnz/nmOAW?=
 =?us-ascii?Q?/t/MgzgyUvgqohCInFehx499c/PeoiYS4IEl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 02:43:30.6035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a83672ba-b84a-4fef-be36-08ddcb250a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
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

Zhu Lingshan (9):
  amdkfd: enlarge the hashtable of kfd_process
  amdkfd: mark the first kfd_process as the primary one
  amdkfd: find_process_by_mm always return the primary context
  amdkfd: Introduce kfd_create_process_sysfs as a separate function
  amdkfd: destroy kfd secondary contexts through fd close
  amdkfd: process svm ioctl only on the primary kfd process
  amdkfd: process USERPTR allocation only on the primary kfd process
  amdkfd: identify a secondary kfd process by its id
  amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS

 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  62 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 204 +++++++++++++++++------
 include/uapi/linux/kfd_ioctl.h           |   8 +-
 4 files changed, 231 insertions(+), 57 deletions(-)

-- 
2.47.1

