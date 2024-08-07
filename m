Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B0DC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 07:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B69C10E671;
	Thu,  8 Aug 2024 07:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0uM24zCi";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D6DF10E172
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 16:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXAQnwtFFNVGmDjC0xxnHRChZkW8/blETp6+kXIPitUeTQvRxmRgSkoqIASc9BVTlXMRBlzmfAJkXZ3o/yKDUQtBmNqiK7THxzzpO5X5WPBScwmNEZZJdX0fHSoySu61NipAT6na/dd7X4Ulh1BEJduUk02gl/sTHKbmeVPdXtCPppr4zbmXQHlgdy2Cdg1HvdapKUnTlPR/O3qnufXenVBuKT5aZAon2g0JbkwTAcOd5oeLpnKaWNbGYDyICiru3iCG0dIBaQyT3hoD5XQ0KEt7pxbJg9OmLMDu18VrBGnaf/b2B1j62jNPzcaXsLEBczLWzlLkhqOklAWciZEwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MOl10bWX9sjvrJKD2aG9EVjzXl+O0Az6tnhdfYJepM=;
 b=c6ez8OtnELSSCHy69WPEFgnm/Hzglf590HdCc7jJti1pHIFbpOnCNTHQVbXBrpkzdbq/8ZMSrnzlzIt9zh15vFza0rvxrNS03h5sIZPv0Wj+sOMN2imhxHZexI0wcYpyef78EMptPHVRruiDEQmX8Yb0knTQOxPUwUimyw16JEY5eycW1G9Q63Dty7e9pkq89mrlNxtZ7+suqhV24NuoIdDG6o9xfJ42bfDe6TSvFig3w306CqVyS+GXHlxVmSiGdAIHJTJL0gX7zKQlbLOcsv5pS0xs2RVjIsLOlPrwWHFpFRjd2z7exDMrYMi+SRGXbX9oO3xTb2LdgW+y1APxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MOl10bWX9sjvrJKD2aG9EVjzXl+O0Az6tnhdfYJepM=;
 b=0uM24zCiq+ryjdvtO+yb9gDoiQHUCrHweuTq+Jx6gRz1SGGUH3/xVCpN/5Td0ZCi1uPSwWV38SlKWRAK4BvTn8v/byqkaJ129vlG5Ej3/920RBm70O2aNqjvh855KZOS+wu8PCQt3VPBimKcPUK9BamKIeDKWv92ixgMzMigheE=
Received: from CH0P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::21)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 16:17:05 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::5c) by CH0P221CA0020.outlook.office365.com
 (2603:10b6:610:11c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Wed, 7 Aug 2024 16:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 16:17:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 11:16:58 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <brahma_sw_dev@amd.com>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Jonathan.Kim@amd.com>, <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Add node_id to location_id generically
Date: Wed, 7 Aug 2024 21:46:38 +0530
Message-ID: <20240807161638.1647935-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d3b696-b3d3-4e7b-0bd2-08dcb6fc608a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z8/s3lfuW5hukJu+TqZIsaeQM0QUz0O/lVspVcSgBb8qSpSufHJFPW9ezyaC?=
 =?us-ascii?Q?J10GwyWqvMGReY2dASHnEbs0gMjHIO3Xp2AYlo9LsF4Xz4LZnPISTUgr+Q0b?=
 =?us-ascii?Q?tQwizpc1zncYB7t6gZjEzc4YLKe/l08rvMxALy+NPaPAY6glQc1kSM2HpJ37?=
 =?us-ascii?Q?Qq09mm0yfWzVBIgLtgESxL2R9datbYRs8P1Z337T4MKLVDun2skXRnZnw/3I?=
 =?us-ascii?Q?3qD5Bzswv9ePHuAA4fmnFLksIXAomHHvFz2t1jzjyHYwZbxVIPmo8i9RZ6DS?=
 =?us-ascii?Q?A3F7eBVedHR5a2aLLsIARk0OG/RJN36WmLOxKqjCQg3hnAgRRpvLtaCOBQ0z?=
 =?us-ascii?Q?32aZ4l8ut96yEcfimKvAm5ryn4gcbJlGnSTCvI1Y5fKucVEfW0NKUHHCu9xt?=
 =?us-ascii?Q?j14Xn04qmr16DYOER16z0PkFPGW4lHPj+CyfahdmNFLJWX2QF+pplMhPjRM/?=
 =?us-ascii?Q?8ecMlIrfjGysbevk2FsTpbRx7FoN6ZI7yQKmX7s1WldyFOt1XetNX7pvvD0D?=
 =?us-ascii?Q?n5yqTL3BbPAlTlAdBH4Hf18euf3Bd5tO2tD2XAdP2zLjTkBg5WQDEEaRLGPf?=
 =?us-ascii?Q?msxxOe7K1KNpqbrc9MTeGr8bMqoXCuJTpbtgUxtMZiuQMkTU7Ct7B6pgrqVT?=
 =?us-ascii?Q?BOLpPDKT7NMr61q+Mrgz6xFJmEZEU+FdQ2e88CBp8P2wUmNpL/oHrGDJ+Umr?=
 =?us-ascii?Q?gVq0VVvuqUD4kT11qjEVvsjYqw7bKaoFneUuwvYpJC47jLlE4f/ajBj9Hibe?=
 =?us-ascii?Q?zac5hTD1gWS8bytNChpu0Le+dpINI21HNzoecEnpAQD+0nwssWLM3v6MXxnm?=
 =?us-ascii?Q?MAoV+QsGHYKQ6a6mwRIKEWMpLxXGULt3wbWspMFdnUmDKv/cX5NAevY5Eps1?=
 =?us-ascii?Q?6e5e9/O9J5X+KwV2AriPldUzmeBQMfJIOhkG6w+ghrfbUTIBY62+xVPZwdYI?=
 =?us-ascii?Q?dngkFn0ifPwGVdEqFeukcdqtryElPZ419GaZLlvw0orqVS2M/VdNF7pwp7Ux?=
 =?us-ascii?Q?7bujYJabbWYWtLbMQeIEKnWB1QqaKUTmmagm1jVsXsX+o8hhKkGdHD8igVqY?=
 =?us-ascii?Q?Z3vU3Ah65YFmNrQzUZLWDg7V0Uh5By1fXHUJsN6JMrfN219QXlHeqs8mqF8T?=
 =?us-ascii?Q?XH0jiqvBIduUpqYe8CXJvE8vbvW7d5c3he/oxkEgB5D17mhsj0fWUGM6ODDz?=
 =?us-ascii?Q?8rs5f4bztiNwOmqCRP6ZcVYvhnwN9kAUzK1C4rExcXeQYevH7HVJbQig6uMp?=
 =?us-ascii?Q?lvz0yrYh9Cx1RkI9sgbsLvAxSEJTtGXa3JY+/zhp9pHTVzD1rWSLMhTvqNvx?=
 =?us-ascii?Q?eg3U3Fs2+2kRgj3iivawRrFTW/mKeFdfYx50A2K5ueQLdHYnbhfM64SeWLdI?=
 =?us-ascii?Q?N+Lk2d5DCuwWjXzS37S7UCoigwQdl7oWxtwUhqssEVVtF0yWqMu5cCFsEe1s?=
 =?us-ascii?Q?2aNMcL8iXVayDiZalIMI7/boDRDEovTg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 16:17:04.6347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d3b696-b3d3-4e7b-0bd2-08dcb6fc608a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
X-Mailman-Approved-At: Thu, 08 Aug 2024 07:17:02 +0000
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

If there are multiple nodes per kfd device, add nodeid to location_id to
differentiate.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 40771f8752cb..e6caab75e863 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2079,7 +2079,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 			HSA_CAP_ASIC_REVISION_MASK);
 
 	dev->node_props.location_id = pci_dev_id(gpu->adev->pdev);
-	if (KFD_GC_VERSION(dev->gpu->kfd) == IP_VERSION(9, 4, 3))
+	if (gpu->kfd->num_nodes > 1)
 		dev->node_props.location_id |= dev->gpu->node_id;
 
 	dev->node_props.domain = pci_domain_nr(gpu->adev->pdev->bus);
-- 
2.25.1

