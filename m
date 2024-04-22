Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBBDC07C79
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 13:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61BC8112B12;
	Mon, 22 Apr 2024 13:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gCy+uvp6";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FDF112B0C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 13:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpisuLQUouTSLLdavuYP71kr5HU7fRtc0nMvgRoJhcykdmQn1W0/o4w9s8sQwD0im8QWZAtrb6pEMEIGmyiO4yMMLZEl5MRF1WrKcAY3wy/UP1zIolLMDz6uewoDUUQDOJxRndwHKOewVXzXIKTMv57d8z59/pLlcr90BrDi72UscjMeEraJbAAoQnAb5hT+trDDzEKDgcqBv3PwygTkZ6Tv8V+xCPch9aE6OXjb0gJtZtr2x0/o/XdJVW0Zt4aDwziznTPC6PnTZZPdsNflxnJznqFYBBGhYsNabQGZ0HARydGe8cjnh+0NaUyQCNrG0W+8CoGH6ZX/z48KkMc2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrlUWEft97pGmR6bliFaAMGmnwbdepXnZTIUFcCKT18=;
 b=I/G65aD2pBFTl6TJzZMLoiqLd3HSbjTyPxhyqP54sAt2lb2pmelw8R3XoZILaqyeozflxsnI4oHj0aJyMxOCy+W8vlLjrK1wgHc3kOvuANdKPGtYu+9IrtMUH0dD08mAnfPU1Iz1m+F9/QjxJWPfCYVeIfT3ktMvas4l/E94HHFlbhfZWa6kndAqSYlzsOgKxwViCHghQpQk0NTGdpBnP3qFt8Dn4drQ6d4153DXMI1Z06WIiqxbHGQEzPlOMqDQ/da0YIXFICFnt9jfFt0iZPsPd6nz+Tk6j6dGBdu+u+pP2AZwT/GF+OSAZDqxdIHYJMO9GieI2dpm9EufBg+KSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrlUWEft97pGmR6bliFaAMGmnwbdepXnZTIUFcCKT18=;
 b=gCy+uvp6NOi0nqKyB+pQoil/5l8hnGda1BiGDdiTerHwjuUDKKjThQoytNtLnxICY7x2FzpeTwiBb/Ugk6jYl0LPfCJ69DsdS5g4nCZSVxlnEzuVxbRtYG/BB1IJyNk8ANvw12I37D1fa/RGjwepgoeKHm9QM2kYoCZPpD2Ddkw=
Received: from DM6PR07CA0109.namprd07.prod.outlook.com (2603:10b6:5:330::17)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Mon, 22 Apr
 2024 13:57:52 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::e0) by DM6PR07CA0109.outlook.office365.com
 (2603:10b6:5:330::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 13:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 13:57:52 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:57:50 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 0/7] Best effort contiguous VRAM allocation 
Date: Mon, 22 Apr 2024 09:57:18 -0400
Message-ID: <20240422135725.11898-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: 84582cee-3a1c-48d7-a0a3-08dc62d433e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fR88Snjwraq0YogL/KSsW9FO+WIZMDHrTOoyGVEKdFOa6XLdKAu6ZYsP+Z8M?=
 =?us-ascii?Q?Th4Nx7o0ZNCfNExH6hI4gzy3Naua5sTa6bIpYc7ENbAObgw+Pynpk+UX4JGK?=
 =?us-ascii?Q?MhwCTNc3l9XbTQda0W5tuNnqIOo7hdTNpb8//fqGf1IDVJ00L8rnZ5S9EDKZ?=
 =?us-ascii?Q?MLiixHvLOB8s3ilkFQch7v2R1Jq9ZQXifLQrDrrWSrGTo9cY0/ColhJCf036?=
 =?us-ascii?Q?HskfduP9PUlK/Fs13JPE5vJAlnnwSHi+dcpD1X/yf6Wqgg3X5XV6WKSpuwNk?=
 =?us-ascii?Q?+/HyCGzzB1kpeQigxnSOcGpd1nlL2+IiU92zDJNM+yeWRD8OyTD7FKDu/9SL?=
 =?us-ascii?Q?pSOY9PEMlUhLLvOp1+wDkgAlrF/pMtT9B3qiopDOxQc6FaPqO//8wnIF3rms?=
 =?us-ascii?Q?s3fSQfK98BS9ybu/5w0cvb76E3IehK1KvfosDbhDHeaqcKWH/XEeXjd5yUpk?=
 =?us-ascii?Q?n2Xw97O71N7btfJHMFJAyywKEIKQBxwJKvYcme5StiB1iNXn8XAExU+9g61V?=
 =?us-ascii?Q?liBkH/dIrTcgh5v1JCfiRbrkZyYufWpEVbOLY+tg7aAfcRq3x35ouQmUPIhz?=
 =?us-ascii?Q?CNgn9qfici0TB8hhbFqWQuW0dWCWnwhNpRsnRwKMNExS+xYhW/fj7oOlsHRQ?=
 =?us-ascii?Q?HuBG73rDHaMYOFrtBmoRLxI3BUDxIK4yB1uhiznMtQEfipVQ6cKLV3+kqcfa?=
 =?us-ascii?Q?mk1XX1sOgzHl5qTfPJ0KH0q/xz2EHbAkN1DVby4+CfPCiC+BdsP1tsqS2l95?=
 =?us-ascii?Q?8Zfh9zoko5Ev/73EM60IyHRRHEr5wyx5xdYcuWXxbJndVVYY6qLEw4ineQM+?=
 =?us-ascii?Q?x25CVYosX/xx15IbaVRINxF5ynDMYhn87obO8JMRshe1Yl/fKdkHy9bIy3aE?=
 =?us-ascii?Q?aJB/bmC9ocfFWsC53nPwLFOi9roh2Wnr4VH5k+qjQ4ta2qGNWW84WvXK6WNq?=
 =?us-ascii?Q?X1Sa7Kcw6GMRMhV4mZtWfwnTG8VPh1lUxYHuR7U5k3t12epVR2M61HKQGCjO?=
 =?us-ascii?Q?qXopHvfrnbItKJmdZioxBHtF9eOczh4BnwZxUT6MyYK9uTMMy7ZbxCy9xyNk?=
 =?us-ascii?Q?PD33pEDxtghUwqHN54FQtSykHQmQCjMcYT9N5x1CHFV7LIGLhhiegK5x/B3K?=
 =?us-ascii?Q?jGBoUZDxtmZGbrXdBEVL9D00oiEM7DgGVnQb/tRhT9G3vcAOjbMOE5VHJCQd?=
 =?us-ascii?Q?FXuUYbAxFIDzdZCEmqZzvUlrpJOTOmzcXU3tOoL+AOqYu+SLn0YIP4d6rK9p?=
 =?us-ascii?Q?i5AlEAxw9eiKDKqCOldah1744pVxxepXAKRpHaN+pS8j8WQu8YH4BY7F2eYm?=
 =?us-ascii?Q?7szqJuAItD0bS7JdowTWx+UYu1ixQA9uV4z/NUHKRJoo/OoCi/R1JmMhwztO?=
 =?us-ascii?Q?+crKiQ2Jzhz8VwLsQbmDMGEVKEiZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:57:52.0583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84582cee-3a1c-48d7-a0a3-08dc62d433e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
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

This patch series implement new KFD memory alloc flag for best effort contiguous
VRAM allocation, to support peer direct access RDMA device with limited scatter-gather
dma capability.

v2: rebase on patch ("drm/amdgpu: Modify the contiguous flags behaviour")
    to avoid adding the new GEM flag

v3: add patch 2 to handle sg segment size limit (Christian)

Philip Yang (7):
  drm/amdgpu: Support contiguous VRAM allocation
  drm/amdgpu: Handle sg size limit for contiguous allocation
  drm/amdgpu: Evict BOs from same process for contiguous allocation
  drm/amdkfd: Evict BO itself for contiguous allocation
  drm/amdkfd: Increase KFD bo restore wait time
  drm/amdgpu: Skip dma map resource for null RDMA device
  drm/amdkfd: Bump kfd version for contiguous VRAM allocation

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 20 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  | 50 ++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 include/uapi/linux/kfd_ioctl.h                |  4 +-
 5 files changed, 56 insertions(+), 23 deletions(-)

-- 
2.43.2

