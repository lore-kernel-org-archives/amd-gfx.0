Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6707CC27C78
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 22:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09F910E08D;
	Fri, 21 Jun 2024 22:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jGc8TqRk";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FDF10E08D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 22:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wl1fuuZI0jpkjAegN8ZQ8qzrj1xFZG+QbCfTmetMpWpliafAZqkzvFJ2CyR2ihvul74oeyhH1Prre3eujLBYsNlvle51qtERTwXQuuA0XefWie6mxiL92V76jf/52+WSd0ufyOGHS8iL6kjyOiQdmoniFv1zI9x0kTabJQd0VvBR3HLNCu7hP8dOSU8z1k0ce5IhmGVuMuJtgEBM9ciYVburVF/B7RQcZCGmE7DTCsg3fio0tKM0ZtO2Qqwu+Se2wLG24PP+tiuEkuUk3gsa72Jzydw78+4MS8Hy7uqwwV9q5kxv7L25oIVbQF0Q6khjR2hdyS9mF7AhqpN9t2DR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o765qtDOrTpvyDXCdV20iYkbDdY1lcvthPJMCl1lJlM=;
 b=gm0k+fFu25j5gzLnfEQCIZZzf82L1QnY7DH+4iBU8tEdghxduv2KhFNqXHrv9UgZObU+L6StsiGpQFLuFgxXIHUpiM8rAZxK0DyOy595aHznjEZUcciPdx9YoNxxxVhldoHcjwwoMM0hoSOsWnYFkamVqeyLSib8o/2SkCQyAL2NXj99ab5bwUsoqwlUC5Rm/Y+33V/EtvHNfUTtT1ASO3Q9WYz8hSfWaK92CEjoxe4kBPcNX1I19apl2QjVUvSth00iiBR5+7x9jdwQAg4EC5eIxlUBUK1b/RfD/kZI3gWYSeNTzFQeqYIW1MAm+EQK3l4IH6HOqMKCx/xImxt2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o765qtDOrTpvyDXCdV20iYkbDdY1lcvthPJMCl1lJlM=;
 b=jGc8TqRkF0PT76XCGMmyJrWuWyihVk0ZbFx/KNP5b+gKD4v+cIFZZj/86yV+8GoM0FvUOSHCxleCr0Th+HFxtzs/h2aBmkqMdz9eKnC9S0AZ3Vcm45UQ+EztXDRkX0UAyN550beoZqOMt+EbUDuPvDK1vdmZTgrXcu2KxGIfYWQ=
Received: from DM6PR06CA0011.namprd06.prod.outlook.com (2603:10b6:5:120::24)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 22:04:17 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:120:cafe::c9) by DM6PR06CA0011.outlook.office365.com
 (2603:10b6:5:120::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Fri, 21 Jun 2024 22:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 22:04:16 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 17:04:15 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>,
 <lijo.lazar@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Disable compute partition switch under SRIOV
Date: Fri, 21 Jun 2024 18:04:01 -0400
Message-ID: <20240621220402.578671-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b544aec-bb95-4eb8-f7d0-08dc923e1832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|1800799021|82310400023|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dtc51XKfiTXZyBJh/lpVzRy3vVZWUjN8zPYUcHy++PjdIKsqFcoK2/spYfZp?=
 =?us-ascii?Q?FHXZ4Hk5Im/wF7Q+NzSJB7F0aAoqcT3zyS4yZF8woCi2r4Rluox10Np3Jp40?=
 =?us-ascii?Q?pQJdnQ6r6bdD7k/4MeIUcB+7vN6gtROop8fZ6zxUuoe3DYJwJnXEsUs7o8Ex?=
 =?us-ascii?Q?pxF4vIE8rKUa3pKuOxs9TtZgq5AnoixQCSpNx7AQopX9uF1jDT9hnBhsQDca?=
 =?us-ascii?Q?1F8l2v76oHKq7H7VFm+L3jZ7jpuYXxZK7cLVXB21ho3tAkEoNNfzLj1+4Bxp?=
 =?us-ascii?Q?9JI16YdL7MxrPtH1848fYNbaiksM2A8SeUFkLLM931TV+IYqsvxlRwpur/wq?=
 =?us-ascii?Q?W5JebbulMT27ak3O6ov7JsvVGt9vtlVXadkTjrYgjqCTBbchwxxzgkjwqnCq?=
 =?us-ascii?Q?GaE91UUWGWGFdvp9ksiviLxQnDgB09AvNygEHtVCBM5EWNz9bkFmEJy9mOSF?=
 =?us-ascii?Q?qZkV+jNqtGsOddoLEx6262DLdYPYCFUlaeCLKN/NkLwi5hhPvfzwHIqhusN5?=
 =?us-ascii?Q?lnLsWIuFcc06EoljY9YlH2GeSrYIWS092TsuROUijv5NUQgWeiOH1kJfwDZh?=
 =?us-ascii?Q?LRQjsLhnDS1jZauj5cic7ZJAGNnQnkvqTa48Cxc2zugc+luLnSNtC3zjiJxc?=
 =?us-ascii?Q?zGY3rM7A2S/vCuGBQSYb/Cqi1FZFPGX7XHN5cUECkbDSj5XX0VInsX2PIVMs?=
 =?us-ascii?Q?EZBwhzWGCF+QCV3REDvpouFc1ZrXIud/Wa9o7clPSCWPsbtUY+1A3tAGLwGg?=
 =?us-ascii?Q?WUwRrFIRv/AewHM0zi0LfIosq5DTpZlvJlYYkmKmNLKVEmsS5n+O6YkIvUVz?=
 =?us-ascii?Q?UJlEhcna4/Zf/5zJsmg52C45iX5B71yC5x2gEe88BTcjWZzt4H1X4fcpbxKr?=
 =?us-ascii?Q?IbzVfS/VbwiyiyEQayQrSKgQVgqsrqso5WDATrizZqvtC4gI3XQjSewQELam?=
 =?us-ascii?Q?CCPeYJ4WPBQyR+tcwAyK/8b+4R1bAAqqp4jUs0NKPH2CHTWWV6dxNRP1PRU4?=
 =?us-ascii?Q?/5dsfs5D6euRX+hq+mazn6ItEiO2HhxyHNGC3aBRrN7rBCjnr2UqLXsc/39L?=
 =?us-ascii?Q?0kF1T5+ztC7E09vm9z8OGKWiXI0bVjhkemDjSDD6ynxCiRNO6GUmIRkgQ2Kk?=
 =?us-ascii?Q?Ll0ZK77qJ7A6ezK0erC7TvQatnVKOQ4tjc6z+P+6JKydXnWSkBG9wchFBbmA?=
 =?us-ascii?Q?GlErTOvDJ9MnoGeHE7ZSRvKV93hgfy7Q5as25gHbpH2O8hBOn27VcXKosTkv?=
 =?us-ascii?Q?IIw1wwT3kOkyVj1issvRyjTDiGOY7NjsApOgcHXr8d/sIFxr3kxsewRKx79E?=
 =?us-ascii?Q?kp7M/EBrvroe0341TU4LmhvTO4BHAyowTq9DCFepSoMonXnCkwQxXbculj8t?=
 =?us-ascii?Q?sb+eV+7aXJNQ/h0fWzdxq8RHqsGV+ZgCVH7aDADVkm2MFt7UjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(1800799021)(82310400023)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 22:04:16.9201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b544aec-bb95-4eb8-f7d0-08dc923e1832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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

Do not allow the compute partition mode switch from the guest driver.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 82452606ae6c..722c3fef09a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1292,6 +1292,9 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 	enum amdgpu_gfx_partition mode;
 	int ret = 0, num_xcc;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	if (num_xcc % 2 != 0)
 		return -EINVAL;
-- 
2.34.1

