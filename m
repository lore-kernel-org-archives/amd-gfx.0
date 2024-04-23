Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A290C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 13:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E20401133A3;
	Tue, 23 Apr 2024 13:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C+fvY2vT";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB0131133AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 13:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ajame4bg+nwLqIDo3nJpCUgBlpq0WMfNxVAtdrbafPG4+ER85AAJESkyYHe9VwomcepXw1ZV2Klv3j5sBfIEhb7kVYJK62HcbnYQmwNTPvhaAw/MutVo2bL7VLiED4h0p3z5lq4PrieGyBtiDhsT2YAllyAUAFZMiffdy4SUUqwi/ZNzeb9V4MBbQbThA08KYjgId9ZCi+HQfqsHH66nxa4z75Bc67jKXhuldmdB1V383hJQna2zr6q4M0h+Z4441niQtZbmWEpz7yiCkwzNNgDrVmnYuAuIzGtTkFzqIDNUMvI653HTttpq1+EGioW8oW0BfH+vu2ZLAokSgx6kGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceSBvzPQb+eT6ryhO/p4GXwpw8AAnkGq8otyQc8c58I=;
 b=YOPML00Tma9gm4OSyYOm/NPcorKz2VCgmuEvld8aFduDfYEnXYqUUjLDgJnM4Rem8wGYFPlUnbJhUwQJxdhwU5w2T/ylAQwJK/rS2Qkq5ZXv9C9C6PWvbh+JNJXXVZZ8Lq+/L8m2YqhvFY6mrb0tY7dW33ST/hJY0H3jsGH9rcWEjvVnknGZFGX6q9HXvJYvDU1QESQLdfp3k4w+zcECp0f1Hir/Ze3Qr9ANM6mG2HeYk38IYppCwuQ0xhdetK57jPHzZGRjjiuWShjUUF4t1Cr8eqqCc+ScylbGbiRAXPiaXrZY5NHDxp7NY92h20U+Cyu5ED59zG8rscVJQoObXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceSBvzPQb+eT6ryhO/p4GXwpw8AAnkGq8otyQc8c58I=;
 b=C+fvY2vTVH5hbKgNg11pyyJ5uue7IaDqtrkiY1Bq69GafVwUnOBv4bc4OZ/vnZxhqs5F0BVxqfhI3qMMBSsewIo9zVpbGiw68pNSUps4ULnTDRISxDnKR+M/F30NBTPANikzgxk7GXlWAMUtZ0c8yh835P3M2t2gr/P4blMvXyU=
Received: from CH2PR18CA0042.namprd18.prod.outlook.com (2603:10b6:610:55::22)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 13:05:40 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::7d) by CH2PR18CA0042.outlook.office365.com
 (2603:10b6:610:55::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 13:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 23 Apr 2024 13:05:39 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 08:05:39 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v4 0/7] Best effort contiguous VRAM allocation
Date: Tue, 23 Apr 2024 09:04:43 -0400
Message-ID: <20240423130450.25200-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 81566c96-f633-491f-3a3d-08dc63961339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?luBbVJSLopER9bK9/QMDe0KJFQeMVFYUTSwSFM+0Uph6lgtppVNRZHxl8ssX?=
 =?us-ascii?Q?DBsTsy4JsYmE1QjLJZmLb8VZCDxJ1ph+ZNLli+KeJ7ik3zEIVlPSij4Ftfmm?=
 =?us-ascii?Q?vDWVgdlTzOd1iyN10Dss5c91PibD3zlBpAoMOnrqANcfaSk77WXAM2HSmJA4?=
 =?us-ascii?Q?pu37mioFXhKSMpntwHxbdU5M/uH24gXho+84X3KtLixjaS40He9by0bN6SoL?=
 =?us-ascii?Q?Lx1wlzDNbhjZmwWMLPbQGSmp8VmW5wQy7HViqIjSr2bUEw/wughCEGDJf4tT?=
 =?us-ascii?Q?QL/Qb2Bhf/89GGDgmL3L5NBuTJZwpXjoRlKiHQORgaTWSInYKlEqO3/R7a7P?=
 =?us-ascii?Q?mzIx2mJx9QBjdw2TCbkGytJagXZ3w1S4dUJGFJVs9ox9CYAiHZvb9Yx64mLu?=
 =?us-ascii?Q?YdX8gkz4DHT4iHil+76vS6IwHpvVf7rM3bnHipHe0TKJ43hl9AfFqKBgmUwf?=
 =?us-ascii?Q?CQ6r8WXeC9alHvxWLc1e69orPZNRbmmZcRVHjZqMamhF2LxEsdBIjF6LFcmQ?=
 =?us-ascii?Q?x1XeIOA+fsT28mDJZkR0Gl09tf+LsEOukNZpfJ3KfqB7edpKzV14wjW19XO5?=
 =?us-ascii?Q?zSQ4N1Ea0ftFZEdAOjrJMheOcbjYSUpVcd8m6TM8T92XHg4lc/4ZsJmOKLhV?=
 =?us-ascii?Q?U4lUqswYfvbj9qGnTD600tw5c7gMCVn68DwQGcY0w9abznp4/SBUqagWqCMI?=
 =?us-ascii?Q?2oKMSSa2ji0plqfoBbizduESrjI1Lb4h94dwRYpH7k0eMNRjQtoQY1wS+oY+?=
 =?us-ascii?Q?xAlH3O3HpROazROK97uXfKKyh7zU86f9TyGGLSRlT4HOM7xL+hmr031Yujuk?=
 =?us-ascii?Q?a3gp447CwumwRzRIZZmbgbuBXdp/J0Ob1TOcnfFyNFoita9Zt+GAzFEaZHeC?=
 =?us-ascii?Q?SasNirMozLgruQbhADWs0ypdLDiQCEFRYPTNIMEZjJerVesQiDUo4NCMwF3t?=
 =?us-ascii?Q?UC7n6KlbCYfuqwIASeFl2Z1X/Bz0OxWbuBV5SqHn1AGXkNu2T/kTJFBN9r+c?=
 =?us-ascii?Q?6hsQslY9SU+yykZhr261CNOMQirrMF+UZf3005/otAS6pQPbOk5hD+ks1qXe?=
 =?us-ascii?Q?bQVs78vFZrgXb3vson4CcnIbECWPMFAelW0NfZqcAo+CFOmNxQtDE2lRhzkH?=
 =?us-ascii?Q?ewV1mtndOMjdxnn7Xnpus0zwxcW3kJ9qdhrlINZytfzIug3efz9rKOx2/phx?=
 =?us-ascii?Q?fJ5RICFLYTYC8KrHGuWScb0YPzRc0RxLKmjypDOalpht+h4qzqeDsfSfZl7S?=
 =?us-ascii?Q?ahFXnpOAl7+1Nf+wOtZJkB0LnD/jBlVuo33O+SEcssmkudPn9C3tjc2l0n0m?=
 =?us-ascii?Q?Fpdcx3i/C+71v2JFZcPf9FV3CpX2hod/Ao+HdRdlpSZ5wjjdzKiuV2dNxnL3?=
 =?us-ascii?Q?LXhHgCwIVxMIyHOLdIVt2LBZkQZQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 13:05:39.7904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81566c96-f633-491f-3a3d-08dc63961339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
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

v4: remove the buddy block size limit from vram mgr because sg table creation already
    remove the limit, and resource uses u64 to handle block start, size (Christian)

Philip Yang (7):
  drm/amdgpu: Support contiguous VRAM allocation
  drm/amdgpu: Handle sg size limit for contiguous allocation
  drm/amdgpu: Evict BOs from same process for contiguous allocation
  drm/amdkfd: Evict BO itself for contiguous allocation
  drm/amdkfd: Increase KFD bo restore wait time
  drm/amdgpu: Skip dma map resource for null RDMA device
  drm/amdkfd: Bump kfd version for contiguous VRAM allocation

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 20 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  | 45 ++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 include/uapi/linux/kfd_ioctl.h                |  4 +-
 5 files changed, 50 insertions(+), 24 deletions(-)

-- 
2.43.2

