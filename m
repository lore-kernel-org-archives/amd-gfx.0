Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE40D116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 14:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A59489D7C;
	Mon,  1 Dec 2025 14:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aCH0kCgE";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3507689D7C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 14:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osTUqmAnNU2hbCILfhxtMMNrxGJHehFyAtl6dVLA2UQ4NNp5obKJmgeMS13vTJA/AT2IQiTeOQoXulBgb5I4UM0tnIz7S9++R9DmD5UbZOtKo3KGJw6cQiHKvdJa4C2hsUuHAWt1jwnmYnybetgQmwXJ30PXK/U0yDXn5Y36ZF9N907QBWlBi0p+nNfgcuMZUjdcFPwp4w/APROfA/yUmnHcSW5dlGGrybj8HZ24FPYQe/PIj165+TmE5UFm5K1sZDXHbWy2Krou9+4iSZJjqIjTs8hD3LPjydCh1FrhRjqYrV1XG4vxG5cmZb6EPhEpxEulSXtvWcguwYF89OczGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlHt/PwZnA96ZtVwyix19ZRtyl8xTZKQobkrF+HwIZs=;
 b=Evg3eUBUSj0FA07WcvBCT5jK6yawPX8A5mNROYP3wId+tksAF7hVVPTVYAQhv4EYH0jPutx2+zW2HJ5cC3a4UFTQ6N4MgbrrZv4OOGh/4uhwbKdzVrfm+2+3NScaP4a7zepdAvMPde0IN6Mr8LNd67wlcNAGO587yWEWLy9TpfLevaKYHDWmcjuaw+EkYEMQQ/wfnBaCmisM87JOq5yhBICgcN8CZ/yD7Q/L9z34wEhZIsA3dbg5ZkrCwzD1vA+N9tL/6IfaJdUSF3TVGiTwnqt+FehkLuYWZfPTVgWv/JfGtZaBgDTNZ8WLcEG/reC+NdI8v/LlOS03kS3MF/5lyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlHt/PwZnA96ZtVwyix19ZRtyl8xTZKQobkrF+HwIZs=;
 b=aCH0kCgE4UiZTjTrGZARpIIh36yE91DW/PrFyq7fgWKrdReJ7wGL4W5gtwaQ+29RLdXWFO6WZa+voRKvhDH1PlYqoldDLnukik81TQfZSxOI1nMmLKMPG3FJgAWE4nLuYcRVcDnvCTXy/N1kVeqRibu8oP2VzrTD2z1PKE+T4b8=
Received: from CH5PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:1ed::7)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 14:28:55 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::6a) by CH5PR02CA0005.outlook.office365.com
 (2603:10b6:610:1ed::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 14:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 14:28:54 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 08:28:53 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 0/4] drm/amdkfd: Move gfx9 MQD to HBM
Date: Mon, 1 Dec 2025 09:28:34 -0500
Message-ID: <20251201142838.1516452-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: fd640fa2-4f0e-46a3-17b1-08de30e5f49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?99zqT6O/K7vl/iq/x4gBC5c0wkD/a432JHvR70wkMeNJwte9/J8QGmJ96fyt?=
 =?us-ascii?Q?Wr1kjpZRa86rCML4RG+mM2m/dMczimOfepPUTOS/RxDn+D07ezlpYM2j67lx?=
 =?us-ascii?Q?fr+6DnJ6Rd3WqyU9jF3zHqRKspbjF7jYiJ+xIsE4e9kZ+XDB0KnPAmdwBZVo?=
 =?us-ascii?Q?GKLOuJsX9OfDv4cI6EXRFRnT5JzcTOBRbHVP4LYiwRk7B23ODtFhq/caQDZp?=
 =?us-ascii?Q?VYomNaCLtNsMwKDawyRUD5eYryqx7ukwK3Ctvtquy7MEmmjbT4E1w0rlHCd8?=
 =?us-ascii?Q?rGxkelXv9kZ3Lz1wCpD2XQLT+zLTugD+azk5Q0Aj3J0Opo/5Iov6DRMKppwm?=
 =?us-ascii?Q?PYnPM1hPrBXwxnCuT6loZAKZyGaUQsq5+x1Y1OsgoKN1SaSlD1hGBtviiQHX?=
 =?us-ascii?Q?blXoQwkU45ZSWi8RB36RQlPE7Jg8JXmJW81+L4Pb8/s4TnH/sJlSxm6EhOOF?=
 =?us-ascii?Q?QWvHmxeQb0VWOCcFFA2kEFC9wJeJP9karPQVmK7uVKz9TxaNt4i7mX/lYu3g?=
 =?us-ascii?Q?p8wqUxrz9gyzbeT8bIFqhjZIDjMmLHiNdnUycB7aTN1IXqSfc1muswxE3dEN?=
 =?us-ascii?Q?ChhV03ahIa3Lkqz5fbcIq3z4d83DeQGiEbXqJaLcLOJd9AVfNhzH7CiRoSza?=
 =?us-ascii?Q?F5MYjdH6JncScZtd96MRRXMakGdrkrQs/aaChN8j4KZAkGcBT7tO6eb6zUVO?=
 =?us-ascii?Q?WhBYAPIwsgTEqpNLt6GY1LbNS+cHhlvADLdiyL7rRlXVVflXtWGPnfPyeHRR?=
 =?us-ascii?Q?0d6jZ+//fHyOR3eKL+KvNq+sK/1A/aNJDN1WYthrJ3RN3bmGbxQtZbIF4q8u?=
 =?us-ascii?Q?7U83+O9UxOJlBlU6C3SVobK2PHtOKjGmmg01L6dvb9ib51j7h4RhR0vWNqnC?=
 =?us-ascii?Q?x6yDBTcO9MHY2ePBHJ5GQnuHctMmm/oLnaXI3oLnwMr1UesVelR8D+epX9F1?=
 =?us-ascii?Q?drlLhMAN5FnllzC+6ZSwrmus6DZkh/jwAmuHq5c8+yOZkDy0MULhrYGkTBP2?=
 =?us-ascii?Q?HbUYADQtiZaqOeUXvuvyiIrFZaHb3BDF0h0QIdoC9JgdFW7TnQn+9venc5MH?=
 =?us-ascii?Q?ZpmXG1C+X5PhXpZ+N/HTtda5aKevWZpDfMzlrx/X0clyP5q7PK2iRmBqV6ft?=
 =?us-ascii?Q?URRKKwfPlfFyPvTc+j/z7l+eV/M+Bch1bBiCXVXBSUGD+uXop1I0wRpPfjBm?=
 =?us-ascii?Q?fDoBeEyWQAi4rIuBociHoLScwQGfqLrqNbB/ivJLbvLoyvdy20+JbrQgjB5X?=
 =?us-ascii?Q?YAQURorYOAEObSXcDvAajGATfJ1giHXpjMrteMqlCVwuaAGXta7aczDZ5htF?=
 =?us-ascii?Q?nWMfzonKG9Cjp9k59W0yyO67n3S1bOV4zCHG5pqegKDpY4juaOh0Tt7QEaey?=
 =?us-ascii?Q?jNR6q+tPxDhk+VjYptjnWm1OHORqKGRE0EbaxttD+YidxoUhOnRSccHpBrWP?=
 =?us-ascii?Q?YAnEThbDFQQ/X/325PD0A13mjPAc9rK/B1vXXhtsPMvWqZ4eOX5N6adWka5g?=
 =?us-ascii?Q?nsYmI+cpMhLll/QRDmfz/hjcwD95EbtyqsTMd/C8fk7gwVGjdwAT/UN0JqqQ?=
 =?us-ascii?Q?A88aW+4PxoyP3u8AL+0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 14:28:54.2019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd640fa2-4f0e-46a3-17b1-08de30e5f49a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
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

v2: patch 4 GART mapping use MC address, vram_base_offset + physical address

Philip Yang (4):
  drm/amdkfd: Bind gfx9 MQD in GART with mtype RW
  drm/amdkfd: Add domain parameter to alloc kernel BO
  drm/amdkfd: Move gfx9 MQD to VRAM domain
  drm/amdkfd: Map VRAM MQD on GART

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 115 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   3 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   9 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    |   2 +
 12 files changed, 124 insertions(+), 24 deletions(-)

-- 
2.50.1

