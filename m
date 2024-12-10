Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6776E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 21:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5899810E00C;
	Tue, 10 Dec 2024 21:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iEAO7Ya6";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F396010E00C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 21:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bN4XHvuroth83je58lPp9qGHMEXs0ewSLPX98ChaTYlofhEHw9FDj6BgGCP9ZlBmF+iZ7MebFq6QmHRGgp0GcWulkImWdrbCPRetGGX8K/eq9QXgrJ+r+5mZzb1bt4lim4MoBSLV+Bv9HK+r9w0B8tj3o2z+gN5BK5nCNaPtDdJGhRq/ozqVY509oasCNctX1+SU/dwI7p3pvXmi6o7wIURkcFz7O44kELkNS6ZmI137/C24QlayitCQ+rRe+4+LKkPe5IQoldVyrHuIP39utvapToc12BVbp2fMdXzvLMDCPfMct/p6arKSPr3pvpPDE98NSgowMDwyH054dhSLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT+bm9KAhEBo17L8XzMa93G2ZsPesfsft4RXnOxj/co=;
 b=p7mHtryOUyQ8wReMC0JaHWezS5+yqii5zwXdJWXF/pMWjTs6lQb+l2lMdtabVev0HUNij/VYzPomEFXzn6sWVetBl2CVf3iQAXGQUVFdnag5AQIbkLyz2ZcOy23Db0WzH2EpEtWbAHELKHJR9yBGuukUa9Kp+swAshmrwEoUF0bg3kC72Hvxpy6rArWqV2m/G3HurU3z4/hFYuAeg34Z94zQD6oKKGa6a8IyUJ7qaEGq5FATUWBTCFlKEoBn5/hk2u22ShTru1kgNiBjgDNopSXLYcA03+rpSuyztZwkuQ1k+huJeOlzWHvMumwpPzaJrP1uHUUEE2Uny6fLgi5vwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT+bm9KAhEBo17L8XzMa93G2ZsPesfsft4RXnOxj/co=;
 b=iEAO7Ya64ABTr/F8obxhMtnJ/3hXY3+cmjywhUnFPdn7EXKnpqSy3xZF16Y+2ViaZNOdAn1hHIt6pJQps3Gp1YFz3TONSX99nGdhBHh9fTVEuQXBwxQCLlT4A47L13UTm72n12YzbiO0zOQHzK2mIvHvpw20h6nlfrGSRbBF9lI=
Received: from CH2PR07CA0035.namprd07.prod.outlook.com (2603:10b6:610:20::48)
 by CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 21:47:17 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::d) by CH2PR07CA0035.outlook.office365.com
 (2603:10b6:610:20::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Tue,
 10 Dec 2024 21:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 21:47:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 15:47:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/jpeg4.0.3: use num_jpeg_inst for SR-IOV
Date: Tue, 10 Dec 2024 16:47:02 -0500
Message-ID: <20241210214703.34668-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|CY8PR12MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: 95af123b-e147-4867-184f-08dd1964377b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nYguxI0ftyzIe1dNWsmuvfSw7MuL3JTl8NVDmArsB1sCDCFAchycf5HBoV26?=
 =?us-ascii?Q?LF4m9byzQl1p8EEOKuAKDNWF5Z0VXRCY1uGIFEMSQHbvLIZ3EMJlt6/bDL8F?=
 =?us-ascii?Q?/0cb1chdCHvwQ1jWcCKGaFroVeJINgnD2vICPjpppe0ypNW9j5KfD7BGfYwB?=
 =?us-ascii?Q?3TqZem4bR5Z19QmZs0xNKrhLaSBkxbr/bFkWY3UCTzut3WgZvwYq8tO5N8uW?=
 =?us-ascii?Q?8toynms8PNb+GQWHrvEAjB8k4rQDNgmR6CTCvFfn2/lKnA4TRaJq02961D/A?=
 =?us-ascii?Q?cyR2XBTgvKrlx8QNmDTiHjmKm1g1dvzvo7l7YTZtdNOtbPqhCwvJSuENJgHK?=
 =?us-ascii?Q?yFQ1nujAH6l9guaYs7YP3Jwr5p11K2vqAebBujr+lelco6O/Sc67h+jDEsSm?=
 =?us-ascii?Q?KINcYVtciuztz1s5cN77BuG4Qv8E+fw5IFfMPElVXGq1/4b8AQ1IMElg3dm4?=
 =?us-ascii?Q?0MdAISa367cUfytlyHYDYm4E4XgjVoFkLciVjfE/ixxlUNfkh5esMy9gxWlK?=
 =?us-ascii?Q?U0tXVFNZClxqGWwqMBNArIx+5uKN9hHnDCKxptLhXHMAZzs6KuWtC02hQD2+?=
 =?us-ascii?Q?P+uYEZxhs5mI1LXAHC2VNCgocgSC/anUmflheQ9XiXTSBPZEY983dFg7y5kP?=
 =?us-ascii?Q?oBiraKWpFZLwpLlU0OWuuFwj8yU2DEUOXXeWm7pKc+q5HG609fwAKEQr+K4I?=
 =?us-ascii?Q?uW85rE6vOOmR6uJOftzbyEHMBEhlIm+w3Fv6iraAI8Vs45ZsTq6h5Qu+NJXL?=
 =?us-ascii?Q?A+zaGuJLWQ/DsERXW61E204Co2UfPCGJVq46wqlkIplQQB6WY13L9P3XL00E?=
 =?us-ascii?Q?eF7NBI/17Q/jEUXwCBmD2q82hPCZqn44T8afJH7Q34WAaxcCGxbbnm2oOCun?=
 =?us-ascii?Q?Vc8nAxdQ5GA4RkvXfdksllfAQJx33ATK47SiksU8e4Xos0syl2uCnl2M/RqZ?=
 =?us-ascii?Q?ffeLFAoWK6P9fS7NAmBV6LtSsDHjgPAbgWQ39oIvKu65XpkIu8Q28IaMBJPy?=
 =?us-ascii?Q?TjUI1sGseOLChwzeBY9Rxg2UzLPtJcmCagcS1+3JnONdXzU+tlpJJs7lkofm?=
 =?us-ascii?Q?+tqeG+blb6+aX4PKXL3XbpeGgwjjxY7IZOE9F+sGiWORBYr3Ku+zDxT8K/z2?=
 =?us-ascii?Q?Ng+szwVAOONl1R6T9kKeTL9SXeqKOe5VDZcRhIVwkLsaOWz4wcyOxjsWmnrs?=
 =?us-ascii?Q?OMFLIl2mCr/aHkWZKROnWG1k5vaXytzvRhKBLXgWZF7zMxrRq4j4fu3u1k97?=
 =?us-ascii?Q?FIcMzZ7Wa4chDttc6RQREbbAgYpnvIMV1kZYQi3Xz+bBU3R7qz//oGyExDJ3?=
 =?us-ascii?Q?rKG2HNnlZSL4VVoI/QHtldPHS8JKEcP+PRmtq8RQ7A57FwuPqPauktkT2nng?=
 =?us-ascii?Q?+iM6dsaXPj7mXLgOu06ZEOyy4FGP+9bC0kCa5esKCz5FrwgqDHxUJet5y2vw?=
 =?us-ascii?Q?6uTDa4/BWNxW6gfpfuEnL9SMMKcYsfS7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 21:47:17.3935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95af123b-e147-4867-184f-08dd1964377b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034
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

They should be the same, but use the proper variable.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index fd0490934f912..88f9771c16869 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -321,7 +321,7 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 			for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 				ring = &adev->jpeg.inst[i].ring_dec[j];
 				ring->wptr = 0;
-- 
2.47.1

