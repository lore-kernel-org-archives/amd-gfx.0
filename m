Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8969EC3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 12:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10ED810E38D;
	Mon, 15 Jul 2024 12:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GC+Net2/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2F5810E37C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 12:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yiwgj3QLrkzW4oWfsg7DjQs4MFwSNm3LChaAQXkyQww8RDB4pmBOEUbr5HCx7Cvh8gokHKJ0H5rKhyTWK+RSOlpObR5PjCeLIVaMTcktcX4ThKmUcWIK3Gtw/aZsS3bERRA4ecZnEMJnflD0fFwyuSOXRG+wm37wk65kyISrxdMs8eqNlYn/HFTTm4Qi9Il/ygH3e82xaKQyTCewJZe0+Q9rtQTc8qu7bQInUu1fKQkg2jC3pUfjyDEGr4CsWLmiQcEQFuWuOHLcOWtEUPWNKy8RLnDBAqE8hRctxhrIrTSpoLsO9I4xLsQCWgcNXLUwnK5jPYnxAfHtyvv2wzj2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RL0yH6F5sI3qpc8EGz87eXhVZmWkCrsXbjgGYlHOcks=;
 b=iLiVtrb6vOdwYHKlet7PMSAHLAJngBZiZXCghpOSPx1b3c1IkEOmMtrN4rRvmt326q0cvyY2xdwIPG7MVeva6KCwAG5k/EmY5opnPMvBl4Srw28gdVEW+9tAyVWCUrtGAckCUHRPrV926cV6QPfF6l1Na5qH+tqQEWa3I8ShyK+LPL7C4nRFKi3dWRQQJwMoVi85uAG/jSUmdISaatSl+55CI+jKTIypiaXy7aqnWGWHyiW5dG6UVWU1chjnjTvI2orV6KBOO6jkdEAqoChyh0o1lswVYFV99mhQWmts4nS+tlJvm2sVm2Gx8KwFyWIzKrJJr5SHW4jh2Lq4zH43nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL0yH6F5sI3qpc8EGz87eXhVZmWkCrsXbjgGYlHOcks=;
 b=GC+Net2/uSpqku14K2Lx0Mp69709OvNQV2sKVjincNtqMSHdL9Tw3i3NnE5I2rmLZ0lR6zYJ/a1gfoQoFbu8Rci8Pt5qI154CZWSDwMJw8f3my99QMYx4AmzbAb4cT4a5H3rUXORLNL5eWLZNmHzl7ecV3HNycWx+iX1WATKa2s=
Received: from BL1PR13CA0326.namprd13.prod.outlook.com (2603:10b6:208:2c1::31)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Mon, 15 Jul
 2024 12:36:26 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::9a) by BL1PR13CA0326.outlook.office365.com
 (2603:10b6:208:2c1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13 via Frontend
 Transport; Mon, 15 Jul 2024 12:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 12:36:26 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 07:36:25 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 0/9] KFD user queue validation
Date: Mon, 15 Jul 2024 08:34:53 -0400
Message-ID: <20240715123502.7013-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: c725064a-ab09-4391-e1d7-08dca4cabe66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dSdjo/PTol0DOFf0oTdBy01KB6KznCOHVUxQoSCf33tZevmq7/B2GAlGcrId?=
 =?us-ascii?Q?tfxfZQ8UQv07Xpn5ckAH5X7R3TTh44/wKi/J66X1I9CAKiwsj0VHrnaKR7Pl?=
 =?us-ascii?Q?FfVLAO2q5hsA46E1jjUI4ZlNiQ4ViU3t/mpiLGIMwCWjwkwrhauWClfgBqWG?=
 =?us-ascii?Q?KfzvEOzThTIwh2cJznPLTTHug2gxltNheyxlbLlqzxZQ9E42C3SC84U85whr?=
 =?us-ascii?Q?Nr4MQr81wA3TW2lbk1QTawYY5hvAYdxBYK2tjFfRY/XrYTYCw7evh7b5jA8A?=
 =?us-ascii?Q?J22fcBHvA3P/lj67JknWxdKRZAfub3sbRKU02vK2v1HdyTvI3TSyz3rERoe+?=
 =?us-ascii?Q?c43WhIJOAH4lE8vmsyENdWYz7VUh3J8yTbVjRQFF/nvezUdeuSr9eekEztA2?=
 =?us-ascii?Q?cVei2AV97YCJ6NxYNB0cFktGG5hPO/bv2IGbrTNUnQBeGT7Y+QiMTXaMr1xI?=
 =?us-ascii?Q?5Zv8C1Hrrx+9D7rOSq2cPVbXySHmuFUpXlCNSQNhPprKLDBg85Imqe1ia7SR?=
 =?us-ascii?Q?d6u2YTPu5htz25JRdbMfdjdd1f9HP5Cj09U/YCjO2hqtfB05wXWIzzsry3YZ?=
 =?us-ascii?Q?dPUxacnYwb34AMgukEsFAnb8AnhTHWItPdPmL2GeZmqmk1CWYCqcKeOJm7Th?=
 =?us-ascii?Q?4Kj2HIqJaE1u2Ph1bZoaoKAbqt3OKqdgI91EA8TR9PSXSZx750Lm+ZL4e0FR?=
 =?us-ascii?Q?PGthdp8492QxDyYjMAyFaE4EDcwmriO4/IMqjtcS3cILw64O5Ol5YFBIvXNe?=
 =?us-ascii?Q?sbTYqqwOjtv2bNVSreEREK1hBwUChy5M/nmgH9nf8LUP55nVBKxanf+xnZKP?=
 =?us-ascii?Q?KJ+9tPqGryHMVLVjSzx8IGcMf8YZOLIOZTQ0aMqyeoTTBssacE3jv6B4opr/?=
 =?us-ascii?Q?Ry3Mjhw3KLyLYQycZ2FgZtUAtbAXhG4PGFN58X3L+t0o1MDKFS+RAIXl+7Xs?=
 =?us-ascii?Q?T/AVpA+i9CaD9l/BfftkTveAYXMvJ2wG72eQ4LR4J3Mzk59D61phW2jG6Nho?=
 =?us-ascii?Q?AQkuPuNJHJghKA/9/uz2XEOHeldfQYzm4qmG6e8vPi14r9iHFdRvcZY6s7I2?=
 =?us-ascii?Q?WNjPmH1+3b0C+P7iUi8YXwGmasZB1bgxHh497S9IRt87AyOem8SO79KCYScQ?=
 =?us-ascii?Q?4gw+g4mKV7M3uLeFbn+LRXr9wq86IKz2mqgVz3xENRi49K1TQMaHnXwkXbsw?=
 =?us-ascii?Q?0BRVkiFTonhY29iXblopGTmQVPgQUwU1ec07Y9Gf0UhAt0cvV4XMRFin/XQa?=
 =?us-ascii?Q?ObSQQ7B43DewIWvIQoYVBM8upsTo6ynTGwJMqLITzEA5epVZSgtsXCPwTooq?=
 =?us-ascii?Q?JJk/XaHOcRzB7/eBGbx6kF6MVIgkzk7XPIlBJ6YBzDVfzU2S7xjk5Ei4yVn/?=
 =?us-ascii?Q?CNABVdRjZFI/DGMJ0gR/aQjsGoWLZ9JQi92S0oGuUo4mm6+LPNGwQfMBxJsN?=
 =?us-ascii?Q?4FL+s0LQLt3shkVbWy+yLAACu1J0hh0K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:36:26.3124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c725064a-ab09-4391-e1d7-08dca4cabe66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
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

This patch series do additional queue buffers validation in the queue
creation IOCTLS, fail the queue creation if buffers not mapped on the GPU
with the expected size.

Ensure queue buffers residency by tracking the GPUVM virtual addresses
for queue buffers to return error if the user tries to free and unmap them
when the qeueu is active, or evict the queue if SVM memory is unmapped and
freed from CPU.  

Patch 1-2 is prepration work and general fix.

Philip Yang (9):
  drm/amdkfd: kfd_bo_mapped_dev support partition
  drm/amdkfd: amdkfd_free_gtt_mem clear the correct pointer
  drm/amdkfd: Refactor queue wptr_bo GART mapping
  drm/amdkfd: Validate user queue buffers
  drm/amdkfd: Ensure user queue buffers residency
  drm/amdkfd: Validate user queue svm memory residency
  drm/amdkfd: Validate user queue update
  drm/amdkfd: Store queue cwsr area size to node properties
  drm/amdkfd: Validate queue cwsr area and eop buffer size

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   6 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  61 +---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  20 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  79 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 336 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  12 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |   4 +
 16 files changed, 489 insertions(+), 92 deletions(-)

-- 
2.43.2

