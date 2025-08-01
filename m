Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C8CC87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 08:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA2F10E3CB;
	Fri,  1 Aug 2025 08:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nLozsuOe";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D2510E3CB
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 08:56:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qe3dRHnQgblzWBo7aLp9iT/pPXtWsiq1U8zq6pcM1MPv0iBlU8wxkLBFZrbw7lXRfAqOOOsbHySoIkgIm1Tmw2xeaELUu436fgOebtBvnBtpOW+moYBHyPuPuukNf6/n4tzw7dv+xD5CZP59A+8NC0XBV9h5zNYQfq3sQ0xkBsS0YdnILVgRHqiYV+KAD+N9VmLAs09vSolLcmAgXACxPZjPtlVoqcfKXn4l7jMwVagF2OttCFKX8Vx2IaET1X8bshXbqVWwCwLEFZKQ+lghMJ5EnQWYqXMvQPgzyKb1/2p6upq63Awmd73vDM0kDwbGyUWFCGPs+1H4qhl6r7niHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWrvw8JeXlcWHXFjCH8TTWwqrY9mKEr18l8FlKc9HkA=;
 b=Sy16tY1IAVS/68o1+JUCQ3ubTtg5viCcHliOR5Zjevr2aUjUR5C6MbUDM5OTMoCGgFQyWdUolUQFh4WBpzNn4T454+xxej88i5w2R0ivfSUBOyvmvo5hUfUEeJtqvcZPsH85d7rdaGSpPRZ4akFlrfi3NMRhlxt2rIOuZI1K40nr/phLGxsLa9ZHts/mk3C6ZeigwnWQQj5NcNkcTU/JLTRroer+TJCG2gi86r3sZMGqGOx3PVNq1sEXC43Ie+N/+s4bljVVVpqAALWJsHWTN7KU0ODnDjJ+UViEr2EsttU5WLMaC0b5RDMS3mzdWfbJDrfSSvVAjEmyUg5bFi11Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWrvw8JeXlcWHXFjCH8TTWwqrY9mKEr18l8FlKc9HkA=;
 b=nLozsuOeh1vQGRu7jCQwQr7HjqhKkKOUtSIfZRz4WCstPyFmhVFw2fCkf9U0aUEUfF7W/N7K6QSN34P1Fk6L2GY26Dg5ISZIXl1VE8GHZBS0hjshRLzzwp32K/Z0epNxUhgRiS0dGfeFkwkFT823y34jdsyNF9FIE4BEUcuQglU=
Received: from SJ0PR13CA0063.namprd13.prod.outlook.com (2603:10b6:a03:2c4::8)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Fri, 1 Aug
 2025 08:56:20 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::f6) by SJ0PR13CA0063.outlook.office365.com
 (2603:10b6:a03:2c4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8 via Frontend Transport; Fri, 1
 Aug 2025 08:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 08:56:20 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Aug 2025 03:56:16 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2 00/10] amdkfd: Implement kfd multiple contexts
Date: Fri, 1 Aug 2025 16:55:46 +0800
Message-ID: <20250801085556.8504-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a542c7b-a7c4-43b5-e594-08ddd0d948d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xTzmEge9rU8VWREqv+6Pp/2IwyexLLxOAx24zEKTTQIbCt79DAaRbcPjKhBN?=
 =?us-ascii?Q?bdbIziSMCcVlNNZEoxYkGauO8Pda84mypCVlq0hsw5NXDxtHrw5lGShb0O2B?=
 =?us-ascii?Q?+phQ6eo0j29xYA1aBWX0geUDAIEOpk6VDMjaM2ZFEHdmjTzNlkrtEP8w1eT2?=
 =?us-ascii?Q?raJdhVNnxRfZ15YpTZ0g2F5B3y5Wks/5cgIXgoxQ7FX3slBJ7Xv77eCMg+ju?=
 =?us-ascii?Q?xeBvp4e5fwBBiJ1YVQPCMoa5sEKFCK4LrDZRxLv3pXNFYM7keOI0xALAdRnG?=
 =?us-ascii?Q?3RFjXZgOWV5He6T87qhGnfMx6s40CkA1sRzKsdGp0L4/qxmfsKwM1hd0G8QF?=
 =?us-ascii?Q?OrdChro/+/hKeLs3zmsqzzlZPLh2gdQgubYHUlEttYncGlR5wAKeIrVoqo1u?=
 =?us-ascii?Q?T/jJCoPV56l4exFAWaf+vRJxbUROffHZGMDc8R5ZelRF/Lmfe1TVbhPMvGMD?=
 =?us-ascii?Q?sNnDvL3edvNzN7bnJfs4D/Esj86M1GqGDl1Bv+e4Izrb0dx3ZDmXPOJX9l+W?=
 =?us-ascii?Q?6vpS7/DNOPKUQs49KvJ35klgc6cHBCe+NoZBxN+ZxZ11i+tmhu5X5ZkKGTl1?=
 =?us-ascii?Q?NjJY60ubCVhor5ISpl1ZAkpKbkXovy1JDQqgC1FikdlbFLJhN5QnwYJWPG7e?=
 =?us-ascii?Q?l6qx+3hIZzvMM4dH3Km+Mxl15xj4lYzDrTwNgXUH2A9p1n88eZhM4mkOJNGL?=
 =?us-ascii?Q?TUo8IhA4/RYpNiIEThVG6E8l5r/+fdrgjW+BQ1KvGZ0pqZZWUsgWFKj+3vpt?=
 =?us-ascii?Q?n1eYUSxR1+n59wr252HgEzeYb5iu6NOoh7TN0bx2uBG33OK+7Z3Z+t+sWqnd?=
 =?us-ascii?Q?N0CFVHSGWuVl5ybwcNHEVKVGWu5kpD0Gtv1BVA6iK1ZCaFIYEKoQcMMayBqB?=
 =?us-ascii?Q?1FFMSHT1f0TsLm4HE4SJ2eMvfl2mRY2AkpaNL8xp4QBuFP3HsrbYnfGa2mwc?=
 =?us-ascii?Q?SbUFGBPXWVlYNLctm7EB8gvsvO43bF4VJDcE3TQWqmzxeLBphRqYgWkGvcGd?=
 =?us-ascii?Q?sTkuSEXccqKHB4BQcbRzVEqta1ozWz4TDlWtNSMV8TVHM86efGoj+dI1FuZz?=
 =?us-ascii?Q?OGlyPH0geIYsC3qtmTBmCa+KQ1ElPhswOYW9HQhEPkZgbcqg05qFtPqiwdHV?=
 =?us-ascii?Q?50spjczJvGaZ4fO/I/h5YfsW7S5CViAepmY9wpIIECKhEjjm89KqE2eOwjhL?=
 =?us-ascii?Q?nbebv581WuMzFkaLBmLzqVvtuDgJgYeQ+jGKWrsf9pRCKsk/trCVAe2gY+u4?=
 =?us-ascii?Q?XeHVuACN3v5Wi66WUJk8YrauxzWSzx9uVbytA3vNzCOY/Es+sityia81TEzo?=
 =?us-ascii?Q?ap8Zvt7pCH/ssBYnKcxwclvbjcmTcZcuyqwCv8/yWNJL91LYbOky4G2BRumk?=
 =?us-ascii?Q?qyDbQZui8TLWs4Az8m6YE/EwMo/BGUb/2MQtjDtez3AakoTaS+oBp1QzFDXs?=
 =?us-ascii?Q?AV5J8kpK12ofbKaqeNHAd5Eu+Iq/Hl5/vEOy4h3B3YrZ81o6QStysyuKI6L2?=
 =?us-ascii?Q?zBWHEzsbPbLoEXCmMN3Ov43SZ3eoRtlBW0jc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:56:20.3396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a542c7b-a7c4-43b5-e594-08ddd0d948d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867
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

Appendix, a minimal test program:
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <linux/kfd_ioctl.h>
int main() {
	int fd1, fd2, ret;

	// open FDs
	fd1 = open("/dev/kfd", O_RDWR);
	if (fd1 < 0) {
		perror("Failed to open FD1 /dev/kfd");
		return EXIT_FAILURE;
	}

	printf("FD1 == %d /dev/kfd opened successfully\n", fd1);

	getchar();

	fd2 = open("/dev/kfd", O_RDWR);
	if (fd2 < 0) {
		perror("Failed to open FD2 /dev/kfd");
		return EXIT_FAILURE;
	}

	printf("FD2 == %d /dev/kfd opened successfully\n", fd2);

	getchar();

	// create a new secondary context
	ret = ioctl(fd2, AMDKFD_IOC_CREATE_PROCESS);
	printf("AMDKFD_IOC_CREATE_PROCESS ioctl ret = %d\n", ret);

	getchar();

	// close FDs
	close(fd2);
	getchar();
	close(fd1);
	getchar();

	return EXIT_SUCCESS;
}

Zhu Lingshan (10):
  amdkfd: enlarge the hashtable of kfd_process
  amdkfd: mark the first kfd_process as the primary one
  amdkfd: find_process_by_mm always return the primary context
  amdkfd: Introduce kfd_create_process_sysfs as a separate function
  amdkfd: destroy kfd secondary contexts through fd close
  amdkfd: process svm ioctl only on the primary kfd process
  amdkfd: process USERPTR allocation only on the primary kfd process
  amdkfd: identify a secondary kfd process by its id
  amdkfd: decommission kfd_get_process and remove DIQ support
  amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS

 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  73 +++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  60 +----
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   4 -
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |   4 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  15 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 223 ++++++++++++------
 .../amd/amdkfd/kfd_process_queue_manager.c    |  35 +--
 include/uapi/linux/kfd_ioctl.h                |   8 +-
 9 files changed, 248 insertions(+), 180 deletions(-)

-- 
2.47.1

