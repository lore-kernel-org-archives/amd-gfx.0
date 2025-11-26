Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79790D111A6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 21:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95A110E667;
	Wed, 26 Nov 2025 21:27:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P+cPvLNJ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010065.outbound.protection.outlook.com
 [40.93.198.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0009810E667
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 21:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ulls/onlgyVAHd6jOG+wFMWdNWDLMD9k+nKv9fQxGqErj75JcN8Mug9Tvdr+OcCiE5IIEultw/rviEF3o+ikRWE1LmhLppJ7XTwCqLYvBuGgFrQ27HyOf8sOn7nRtyXdh5okrKK14DJkr4smF+VFvVv+TkEFq+R2LU8ICmffRV6wSq3UoiB+qV49DjfnlCLWIjJj31i5m6h9pOV8IpckJTSiRd3r5TTWF3FLzoNzczNB8Fsf4gVm+fgRweaXXG5++P4fbgZMUZUV8aD6WGuWTHGChs8IoEm5xkE5JCRkxnGV3oBAGIDAVitYUdvNhvitNaly3gHFXpoYi4kHYSJLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q2X7v1OpRqelCTKLXw+P5UKvOKKHukIsLj9XV5cwE8=;
 b=WnAPgh4J5K2zN5Lbh3dKDaLHVbDqxNxNCVhGUfqdCTomnjp+9vrHhY1xMFE6UdJmWyLrt8MF4YAv0fMCAYeN9s9jR9T27r06depJDMZcx4UhBUdAYuwjXQ30mpXKlGNrx3REfZEn/u2jShi681pkYyrwfL+zVW0X+BINEyF2lFft/IBJi3OwhLlWprfnD3zqn89Ps7lwNmQLnJVkFhTeN3vPhE4jCahLNXlEI5BSz/kIXKM22/yWUzMB35fTA05jcKb8U7ZUmNsNDWX9QIVkfvMw6iAZwoJYUOAnf4j7w6I2Ffyi0Foqpsi29JdhuhKpw+kk/NE9AtpO/FYTEGtx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q2X7v1OpRqelCTKLXw+P5UKvOKKHukIsLj9XV5cwE8=;
 b=P+cPvLNJ8AqwcIGuAPJ2reRTA9DZyhrqmhjdRV42Upd/6x/T9PKq8lU389t7LU1j8VSD3sojCKg/KBEP+7U1Rn+p5GYXITDlHGkMJ+CXrR/3DZmRrTAYGjoceKwRSNHnJblS2AgZ8hJyv5617/qp/+NtyYqU72V+wmzhvqVXHlk=
Received: from MW4PR04CA0087.namprd04.prod.outlook.com (2603:10b6:303:6b::32)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 21:27:15 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com (2603:10b6:303:6b::4)
 by MW4PR04CA0087.outlook.office365.com (2603:10b6:303:6b::32) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17
 via Frontend Transport; Wed, 26 Nov 2025 21:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 21:27:15 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 15:27:14 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 0/4] drm/amdkfd: Move gfx9 MQD to HBM
Date: Wed, 26 Nov 2025 16:26:28 -0500
Message-ID: <20251126212632.1522315-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 133d4218-44f1-445d-0b1a-08de2d3291ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GRUloIykPCWbRsk1ELe+Pq4KmZCT+sImz0VIrGmqbqo64WYKhJ8BXPPMHjvH?=
 =?us-ascii?Q?bi1RYBR8CRqlJEIOZFjwogh9di2tsWQXXpzSBL5J88jt13x0+CZsM5i+rc/f?=
 =?us-ascii?Q?JGZx0fF8RKF5fKfTHAfg0Ks7r6HWCjTxSp1PUaqY7m5DGWDTeWlv6Q9Irie5?=
 =?us-ascii?Q?yYt3qCukz+WZIKgnwXKTPMYTlshTdmno8OYBjnHzmM0OZA0n9hTw9gU3N57+?=
 =?us-ascii?Q?1nJGJkYl1ulb6iMEkeACQnmOx/5GhmdKMkQQtMmq55udtWozVNxLiieMxL+e?=
 =?us-ascii?Q?7CzvZHgeZjueacFafZbnQQ6JbEV7LwtvhCzO9vu9v3BR7ThDRPaBaqPauK9F?=
 =?us-ascii?Q?IHHbKf9/nCjNgEfCA3P+JUny2AdtiLbDz87WGOGq1uAo4gi5ZUCXZcSOpGFa?=
 =?us-ascii?Q?W8vXN44mGJ8xfx0b466i0C1anXKE4CWFDsuap1zfni12aKaR/9FKrQVx/mSk?=
 =?us-ascii?Q?BkrlBg0xFFdOuzfMBYfcKdAr2fg4I9SiexB2NXG0MUyuhPcRmVvRlLtQL4HX?=
 =?us-ascii?Q?lm/5nJdKZqzJvG51dcxmVsrhP1qEHipwIoQd7ZWyucSSKCl3Qki0rjXGLZaf?=
 =?us-ascii?Q?Zk4LOIVyXizd/jrOhIr3jDtcK+BNVNYdpE/tNzZFwIw/zUu3J+ARus0/Kecu?=
 =?us-ascii?Q?vvieIuFDhiFtuJghjPs6Keg3XAQkrB6Xm3gdWjO1QCY7fUTAOjhc37G3LItn?=
 =?us-ascii?Q?9et7x9s19PcTQno1hdPnvU1Bg3Yh8gmrdbvy9IUbJc2cf033wdQ/1k6F76Ao?=
 =?us-ascii?Q?zXFoDRx97gtRTm56FAkHVXKT9PFm2pbQJVtJYkbVlxgXsFzEPNyBmGfcGRSm?=
 =?us-ascii?Q?kmFbhUUR3RNmWnylkvbLTN5YSHg3zBmcJdHLVLaJHPh6ciBW9SXPqhZQH2oe?=
 =?us-ascii?Q?JA5EGdeaPQeGaorfnf7srLS8lhlDBWTCrNqyAtMFoH1suNBropcdLWNsW4rW?=
 =?us-ascii?Q?G9qoFziuTMbUOp1u2KNXrGz0pk/v85fgVvl/oEua0u9kkY6Q/Zdq5bVMtoYW?=
 =?us-ascii?Q?H7wRKSBa+JTlUD/yElybNm5QO4fIPIf99ByUoy3YnmPuSG5V9jJejciHNJqd?=
 =?us-ascii?Q?6v91obIMuFMu/ffs638T2DMRUAz0IvN243W7zd4lCjiFsJjkh5HnkQcgeN9/?=
 =?us-ascii?Q?xcnFCWjyCkV6O3TxPLw+ak+gJLd3rEgDk/Vq/RM1Ey49kvn/q/98UUl1EUqe?=
 =?us-ascii?Q?aRfX4L5bYkJxIKytrELIqlfshgWqcgGd3bfSHBWxAGfHFVREv7i7ZOfeY6KE?=
 =?us-ascii?Q?QbQQ6iPkFzNVPYyEsjcq0d9j97qFaGqlF5F6Br+zjs8fWYZuR2sUiSscKGsb?=
 =?us-ascii?Q?S0S3q5fJ4Dm2OcC5xV4nK8cmrj7MzM2HPpDNZiE2kBT70Awyp8G5fFjvCLiL?=
 =?us-ascii?Q?Le10wSoqVhNLYY2gQpYj38uvCNOcuFAKg/sQmdGXkrfhc75N93mpByDftn0A?=
 =?us-ascii?Q?UUogwQ6pgq8uRkB/onBHRjdMN+V8nOxlAlASX12Wkc7Pzq2xFLqOFtIDEbu4?=
 =?us-ascii?Q?iyKhMiV/wBQB0GYcpjMttNejjJVUO0307DCbjNAtqlWVlRfFpI5tW8WEhi1x?=
 =?us-ascii?Q?ZhTvorp80MG2KCuEeS8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 21:27:15.1500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 133d4218-44f1-445d-0b1a-08de2d3291ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045
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

To reduce multiple queues switch latency, move user queues MQD to HBM,
and map on GART with mtype RW.

Philip Yang (4):
  drm/amdkfd: Bind gfx9 MQD in GART with mtype RW
  drm/amdkfd: Add domain parameter to alloc kernel BO
  drm/amdkfd: Move gfx9 MQD to VRAM domain
  drm/amdkfd: Map VRAM MQD on GART

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 112 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   3 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   9 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    |   2 +
 12 files changed, 121 insertions(+), 24 deletions(-)

-- 
2.50.1

