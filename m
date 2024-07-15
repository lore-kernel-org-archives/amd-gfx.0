Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6D0C3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 14:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A7A10E3F4;
	Mon, 15 Jul 2024 14:42:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4XF2eOGC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD6910E3F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 14:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvQftmANZh+FedwTUHSfjq5mqxnpb4YYSLGjQULiIfan2u8Ic8ImeoeZHNF/MRapavH4CYU/Hw95Mj96i0H6uLqOlDL3DAXKcmOKVNkEvjw+mvvSj/Y5/BjgiqMbRabNKBtyI98FbsMlDh+wY9ZmdK1yUGR+07DTyFOuCVjzedZb1VC8OIFFa7wqqnRkz9zB29QmYmiJJxTsGgCLWSPHsU+GAuDnny/2DUMQAVM4I3fl9rC/y4kipB1THRnncilXzJc0pNVIvprTO5Rwzoqt/jqKBvvoKfXTC/lefOvZ5KOKzYUzgVIBCmyn7Q0CGa6RIt4YmTx6ADoM/bAysGRuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCuSn3FCmAyFJU7wGdJanaxJTegi7J23yG8CbmnqNIU=;
 b=hI0jm80jp4aqttHWkB5iqetEPUVeplASGtvTUPZCi5PMMFvwMzWoZWAmW+8itMIk5WpGQ4jb70J5upimOr/81WdxJxeCvmpPTKREIXF8fGEeZDqdd9Za899JsN2lf8kuXv7m9Bo/x1+Iavf/jlBtAGuHaM1fSrQcIjuGp1TgqjEooPhlLmLV/R1URr8GsdSfFuLo1GLuWD2IIY1qZFDHcvqD67s4PrubyLpvBfwPwWD/VaiLgCg1opICyJi/ZJUU2wbyyLTrrWR25qT5l/CC9guSfmqMwTLmpwMJjZj0taXemcPbPtojsrRr1AvK9usIdUjX9BAoK1HdqYsVAgWJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCuSn3FCmAyFJU7wGdJanaxJTegi7J23yG8CbmnqNIU=;
 b=4XF2eOGC6ihGQVilo3wk3sXtuBTJDxw67NtNu13Q3s52aZQRf85RDjheyihzfAsdL5eVI63QvApotT8h4vkaDfmn2cUdIumDuI/GFZEGFNowC+6RiMbFY5Uf1jykn5Erl67DMciEJPOcW8rHeo/MRgkSTq6ZaSN8fsE1eQzOrAI=
Received: from BLAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:32b::15)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:42:18 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::69) by BLAPR03CA0010.outlook.office365.com
 (2603:10b6:208:32b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 14:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 14:42:18 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 09:42:16 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH 0/1] Add support for isp buffers
Date: Mon, 15 Jul 2024 10:42:02 -0400
Message-ID: <20240715144203.14563-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5764b2-6db8-4689-01ba-08dca4dc53cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?606hKHNz9n9XjBHqGisWYca/e+/hPTANbZB+4TnhcUnNylOuVzXEuQPms6Bn?=
 =?us-ascii?Q?SLk/9mMTIfslAOv42LQD6FLELfLr3Eo+IR9GLvImurjvkhIqe7FKEiDv03wW?=
 =?us-ascii?Q?qU/rGopkmBp4F2eYcK3tRVgAhA7vQX6bhm/vpiyV6/LB609zSH2ywfSFWJvP?=
 =?us-ascii?Q?iKQt+vgDh5/cOBRYzU2vwCjcR+5lqcbjQP0N1YijRy8G9EzZE7okpuN5Fe/F?=
 =?us-ascii?Q?r2kct2s/vZAkbb84zMQjyx1/e/QUlHJOWkvhrEVXRJFsOQTXY5tobwtonx0j?=
 =?us-ascii?Q?nA3Lgmlz6IvPi1xSAcL1SVx80dCyB8GGnhblCWg4wwdR6KKCYIng9Givq2DV?=
 =?us-ascii?Q?byiASQXneZpL5ArIXGobRBGQ6G0HtdUY7/oHwbxFXg/d866XjHMm+tAPMJnh?=
 =?us-ascii?Q?y+IFHiYA9r/dIMIeVOHgIBG8weZDZLVf48VY+zymLi9xUpmZ/vuK2hKB7Exw?=
 =?us-ascii?Q?8DokyLbaQQEACHVN6x+EFmVNLJOOgb1uWoCJV0IkK9d0ETTMYz17rgoPSfCn?=
 =?us-ascii?Q?rl9yEQZRxRowd/PuXBVHqSY+ZbfDKQdizyQyvd0nGttva6BlkYrXnWU6XDBQ?=
 =?us-ascii?Q?Z2eInHl3v4eO8LAOmFSZh6lyUVeFq3u9YRR7kKGRuhPiQfiBjjzEMSCb8wDc?=
 =?us-ascii?Q?EU4IEgKG5KmO/W9I+6QLFNM7BWQHP5GiD9BLBM7cLo8uls9qNf9ypzHeZafW?=
 =?us-ascii?Q?jLRefS0ZZB383gFw+VRFtPHUAHMWzq3rPC7TlmvHortMqz3rTgiIc6mQLRPw?=
 =?us-ascii?Q?mnRZelWDrrG7q2Y134dm4aTCYySOA4VsZrD8E2kmcHB+secOzs6gf+zYzQ3L?=
 =?us-ascii?Q?zEwsME57TCXdMpTAoanLAkSRem0orGuPDVJqn89uQCRH7m0eLbiD6HFAuttk?=
 =?us-ascii?Q?qiqsxnuk8HP7tRu2HczcYm/qzhUiUlGewhU90OPIsVhiFx0cAFUslOllxl4V?=
 =?us-ascii?Q?Af6YY+2ZWCUMSXGvLPMGc8aYIRL1OBXOrlzzGG8bR/wAxVOSCUihvNi8Ra6s?=
 =?us-ascii?Q?flMDelmPYlsTL7il5Efuf1BGk4bnUjVkRLlBg1SwuUi6v0v/AReLuqCTczNF?=
 =?us-ascii?Q?D7UZNnyo/AxMrBLBA5ENvTjNLoREDpLgUJr/V3E1+pwuCYEVH6L7X4C3Sjjd?=
 =?us-ascii?Q?+kt5Gk1OmI9FmfeOSBRzdIvANOEjmehsKJgIDdrzwBN65Xqu+uck/HMeFLJH?=
 =?us-ascii?Q?lVcSvD3cfv6CGsUzceYBIEfXF7aebllVO3Bvllcnn9/+uRlEb2zoFzll7/C1?=
 =?us-ascii?Q?kPCvA8X7i3Yc1ZmzmJRGRfwMUEJfruBSGBRzrhuEGDw7OeWvd0I74BQhcwvu?=
 =?us-ascii?Q?lpQ29lR8G81RcWHb1Eo+ISXpJUZNL7d5Trh4ku6KE3E2at6I3j4faq99GVEi?=
 =?us-ascii?Q?UzGFYKWuJeCJ4Fuzqa6qagdxXax1+hdyW93zXlc1QK87VJQPV8Y0Ok6DUnBQ?=
 =?us-ascii?Q?lgRxZFDoRT7w3HjPwTQgxPyzx8VekT2X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:42:18.4781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5764b2-6db8-4689-01ba-08dca4dc53cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

Add support to create user BOs with MC address for isp using the dma-buf handle of the buffers allocated from system memory in isp driver.

Steps followed:

- Import using dma-buf to create user BO
- Pin user BO to GTT domain
- Get GPU MC address of BO
- MC address is required for ISP WDMAs to write camera output

This approach mmaps isp buffers allocated in system memory for userspace access, and eliminates the need to export kernel BOs to userspace involving ttm->pages[] insertion into userspace vma region.

Exported amdgpu_bo_create_kernel() and amdgpu_bo_free_kernel() as well for isp to allocate GTT internal buffers required for fw to run. These buffers are always allcoated from GTT domain, scope is limited to kernel and will not be exposed to userspace.

Pratap Nirujogi (1):
  drm/amd/amdgpu: Add support for isp buffers

 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 103 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |   4 +
 2 files changed, 107 insertions(+)

-- 
2.34.1

