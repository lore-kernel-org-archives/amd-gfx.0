Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709B5C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B46810E17E;
	Mon,  4 Aug 2025 11:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DeIttWA2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F3E410E430
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcOCE75O103HymWQR2zzTQw5JLtAyMuaHvq+MljCcQzW47Laky+I97H4pqGWP2kWdYhSFDSRnCoxiN57XW2kzBzmVX9xKTdUcmkrm6cX/9Yf141H/hk/vz4wfSbQcfsU2bDBPE5Q6SL9I9ajuZDpm5f8BBHUqIYE47cxezlBmgpm+KtbO3tOIsEmzgDw/nqMqaCFDJYZrplN12Jrfsxw8/i9mTTu4iTqeyZ7QwGhz5X8SbCh16k35LE7OSjBeEtdfMTP4gti/HxzaKMUQuz6qLEWemKM59ykO1lVj4yWtYFK8kFSM5y3MJ4E+JAIKgQQkBlo9ix4DPlTgIxC8loQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvh6Oaq6Bgp7rSEJRlgBo345gayXwhcgXV4k3CtCLJY=;
 b=LxDIqmwFzqr0D28Y0zGM4TQVoVzAiWQXETGBnNd2iAXJXOoPfw9hp9RlZg+C/Xycm901FBS3CmdVoKaaNqkuyy9y60GVo/6JhxNy/YTtMrsnTiFzOHrB+C2WTqIV2KOhBY+i4DRAyJYFJNIqlRyINK/HM2mbYz3ENpTVXIPHk6l86Xe47s5auuCAxQgWzdReCOgCt7/4/KyKegJ6UMysGeptfC3OomHJqUhdt9aM1fcrXmecev6JfeBLezBGJoG7NjMJkOaynBBvQzdWmvIUPe8UlzTnZ4rZ/vgTil6dPhifMa7Qe6V+bMzUq6WFK9GPuCHSVCHsaFNF5kbKlChAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvh6Oaq6Bgp7rSEJRlgBo345gayXwhcgXV4k3CtCLJY=;
 b=DeIttWA2EkudJdCTpypI41IGiZ7M3EXKN0Op59eATuzm3tcTBx+Y9DBPqs+UIsYYID4peHh2UgJ2kCwdcTpX+oeIA1+94xIPkBf27RPaWulmjkroGMIRYZcYjEOl+z9P1QwWfFPvqkD974G82GlQ8i2xF6lSmuLjFGuX9bZDw7A=
Received: from SJ0PR03CA0151.namprd03.prod.outlook.com (2603:10b6:a03:338::6)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 11:06:28 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::ab) by SJ0PR03CA0151.outlook.office365.com
 (2603:10b6:a03:338::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 11:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:27 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:25 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 00/13] amdkfd: Implement kfd multiple contexts
Date: Mon, 4 Aug 2025 19:05:37 +0800
Message-ID: <20250804110550.261311-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 2384e20c-dae4-485a-6d28-08ddd346f595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A/GyT35RQQBQio/1leXuubxwKd0kaZpieyu0zt/95qoYQs/sL3KJztYeFtAM?=
 =?us-ascii?Q?4ES19+HtgTASla+CV7wG/cq1KcKlpHp9cWKX4M5lO0T5g330MD3SUGobnyhG?=
 =?us-ascii?Q?oUER/HUE8swiU+ZrpMcecInYnkIs+c2uP0+Jn2ratKZM9pAjwqo220dnZOOx?=
 =?us-ascii?Q?CpiCOxRK8yCB0jsiB30CIJ1GJJibdoqUB6ikLszv5L2Ul0FVvzmT8a3htmIQ?=
 =?us-ascii?Q?q8fMezilC/el/+Mzf6MPUdP5iPkGRbnR1l+VhR8O0NLsuLxk62X5CkeBDt5f?=
 =?us-ascii?Q?VEjuO1EG4U9aJ6CuaRY3C4iyrBt0lhcOdyzYnJ5Ao1iI5BJbPZ/rIR+oL985?=
 =?us-ascii?Q?5h6rKoXYckhA1HutC9BLtAk8pslI4WyHnXcQNpDfetvrLWfnELNj7FE8LpEt?=
 =?us-ascii?Q?lYsmlhUKkL3a1Sxk/UUE06Arf4QPRrs/atLBK/1+ks45zd0a7GSSXJUCCDs3?=
 =?us-ascii?Q?lR8tPaY8H2JwCsznIm8q8bf8NLOUhgyMumYZ0RcRgctr5byYoRgLRlM0+Kll?=
 =?us-ascii?Q?262hGRRNcpfSBNEbxtdyycdjl2p3CfHFcKKTV/ePYsjYkmEqHVmZDUiuh1hb?=
 =?us-ascii?Q?DhI5DTR6xvXYgkYZ9JZmux6H/JiIi5tkgGCCxRFG9XvYiNxDy1pIln3pRtmc?=
 =?us-ascii?Q?Jf4mvIn9N+8HvqKyEv2EFbhKBP/HMWNvRIHNVud5OCD6/bIMjkrkRtCIpdvg?=
 =?us-ascii?Q?cTviDwPvHUY0mW06Srery2fDWx3T8SJfw4/GpgbTRJZcDzH3GpcVFgnnWouR?=
 =?us-ascii?Q?jReh4srzqqJ8ZhmBdN25rpPtcD6NyCz4nW63N4nPi228kcYAXn1LfDDFcQpb?=
 =?us-ascii?Q?LjLRCW0oJ3K93v2jNyF9m9OxoWfnXulaPnaATbWNevoAO9q9dSDC6QWvK/o2?=
 =?us-ascii?Q?VLDKLrNzNe+paE/6/SOGyRZab6554YPwkK/IEJlxdrAF5YfNlC8FH8kw0O6P?=
 =?us-ascii?Q?YDs7twA4vAmlZrFy4AgF0m2c5+u06ZjsNuvOpk9ZXtVURjjrLAoaDwd10zPF?=
 =?us-ascii?Q?ZMPb2cHAQ48Hdks/jAXwQH0KSgKYafsDf4cmOuRyOWJ1rMOEsUOctdm6gndb?=
 =?us-ascii?Q?TGUZySIHs5J8DBPH1e5FWStd+MI/fxOHrsGhb6VZmuA5LBsGvHa4KhUu8V2k?=
 =?us-ascii?Q?jM5v0/o1ecmxRY0P1sJmF3w8XRjuJldhQWx6PKBbyRyktbNah97sYLgAGboU?=
 =?us-ascii?Q?FGxsJHHZ1chu0bRRdZSvbSWvEVaQYrovqqdIO7awkicNyELMEHhVmlw9FKxT?=
 =?us-ascii?Q?ViuErD2G+MKBLTi54UiuoGgyHVEzi2FvCHsleSygx+CtHW88RPpxwgeTRlZb?=
 =?us-ascii?Q?1S/CYJ68W8vXX52pq1hL6kP3CMv1h9/XpYK9enHppfEkR+irH3jjPLO70GWU?=
 =?us-ascii?Q?exOxMp/CVIGrkjvVhO9TBBctueSSSsKK5WxJJHtO1guBZ+6T9Y1HBtP1bZAg?=
 =?us-ascii?Q?D1JOUe49Xgx25KrpuehMGVfSifAhj3bnZux3jf7meHj3f5zepO/Ei9x36jR8?=
 =?us-ascii?Q?T51jQ1uwyh+Dtnjv69FQFniMo13yoVdRwWo4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:27.6501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2384e20c-dae4-485a-6d28-08ddd346f595
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290
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
 


Zhu Lingshan (13):
  amdkfd: enlarge the hashtable of kfd_process
  amdkfd: mark the first kfd_process as the primary one
  amdkfd: find_process_by_mm always return the primary context
  amdkfd: Introduce kfd_create_process_sysfs as a separate function
  amdkfd: destroy kfd secondary contexts through fd close
  amdkfd: process svm ioctl only on the primary kfd process
  amdkfd: process USERPTR allocation only on the primary kfd process
  amdkfd: identify a secondary kfd process by its id
  amdkfd: find kfd_process by filep->private_data in kfd_mmap
  amdkfd: process pointer of a HIQ should be set to NULL
  amdkfd: remove DIQ support
  amdkfd: remove test_kq
  amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS

 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  73 +++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  60 +----
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   4 -
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |   4 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  15 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 223 ++++++++++++------
 .../amd/amdkfd/kfd_process_queue_manager.c    |  39 +--
 include/uapi/linux/kfd_ioctl.h                |   8 +-
 9 files changed, 248 insertions(+), 184 deletions(-)

-- 
2.47.1

