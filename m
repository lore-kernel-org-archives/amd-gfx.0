Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2892D31769
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 17:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6C510E075;
	Tue,  5 Nov 2024 17:44:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K3/hOaGC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E7E10E075
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 17:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pC/eFhgHtWSR1BWsAWbDZjxAB1UMvHWGB/SgsgRRCfNauWSZLJaKdsjaZ98+VD+DqeJLS7PnLTD7x3eD8RxvUAmdk7udHnqngdiHz83D3b7zcErusBE51RghFaMcIAK1JcNSikTUaPBmnA42VckyHV+SZyWkaNv12ny9t46DVnl1zy73/vLEjiNCWVmlpMeho55Gs8hlqvtHlqP3ZlvjdEImA3Q3oME2g5rmfwgEWqeqaR2nXGzaL1C9Klyv3oQGZKcnyTfPzpIWPVtDgnzyLqZ+h/F4Pw1drhGKKAEWiV9ZA4S8e8vB7Xz96JJGXGIbUYhGDZrOm1kNsCzrXJm9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5NQiYxxOHW9PpMkHfJZ0LtFrNF2iPpw1yV2Jkte93s=;
 b=sBtD0UeDnndqLghBxX0d96UIR3u3xEwKJmEqAajN1kkSgA6GXyv+VKcgyoKQs1vhf0NX105gmsoHQMPqdP4MuVk4dB5Ga0oAn6UwWZRyskgNTBreIYkhqrHSHu5kVSzHRW4nJSfHRVuCdIXoyeY5mXxOEX2bNXf86/iwMWIu0yG04vxF1JdyDHkwWn1NXE7ez5b+1AzwzQHbfp9G3x7jzCUPftfSA9M/lB/khm6i3W5RqtDhIJGrEZqg22JjQroxHlkWUqUbd2DqR1iVqwugMBCrfSX5ptbL8qwDW9bGBU4CofzIcgdUthtUYUk2KnKH2bK2QwcYxKkdPuaGnL7maQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5NQiYxxOHW9PpMkHfJZ0LtFrNF2iPpw1yV2Jkte93s=;
 b=K3/hOaGCtGGal35BAPpyv/Ci1fqEtGrObpTiFcUus6Z8lTy34OTu7uhYQ+kb2KENGIt4gs5C0NKNHWD09gxtO/tnYe7mBVgssCJvH3MvthS6vfkNAfdoWaLolNmH0GSBZYhvL6ZzWkI0a8dwW16bqmH13umhixHtOr1GLsejC+w=
Received: from MN2PR20CA0044.namprd20.prod.outlook.com (2603:10b6:208:235::13)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 17:44:28 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:235:cafe::a4) by MN2PR20CA0044.outlook.office365.com
 (2603:10b6:208:235::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 17:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 17:44:28 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 11:44:27 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <David.Belanger@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: remove gfx 12 trap handler page size cap
Date: Tue, 5 Nov 2024 12:44:21 -0500
Message-ID: <20241105174421.255188-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b21e81-3e63-4582-847c-08dcfdc17f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M+QdoP6I0eCMBso8qgo7KKXKY+XvH3To/4JV221UORzSRArDyMhnRu1o2Mie?=
 =?us-ascii?Q?71PHJgsjMKwCTPoFXOlKPUWEzWCKIKbA/NkOU2dwUmP+jzmqV2ByPfWOkxeh?=
 =?us-ascii?Q?gEtJUkgcvKLEr/MAdtrk5uQe5U2GvWQuQwjvs7gUFf+r7/NE82J2PWxFH7Wa?=
 =?us-ascii?Q?C0D0gs0SPa6hpGyhzgkZef5aH8ZA4bBtZtey52yaQojwcjO5Qtu+NVGobd7X?=
 =?us-ascii?Q?Psiq++zssFL1c5SazkISAgVjxVsJUsNAglu9EyKekuSKkcmom+Iqw95L3c7U?=
 =?us-ascii?Q?cMcBy8OoMl3H1b8UE/j/qleSyFiDlCxrMoxSECEyTlW9Qbiwf+5Uy1cmkXHc?=
 =?us-ascii?Q?jHSjnvFmAgMSfXXjA3xi3DFu/eeMXgF2j0OeAnTSXxAWTowRwkfLLxk+qrSl?=
 =?us-ascii?Q?U5xZ62P/RunGsjQIMWxZr0qA4jmURLhpHk+ClWqPRR1UUk5WN5jyEcyyQsOK?=
 =?us-ascii?Q?CFHZsBgU/biYGYMgn9phpPAl0bW/6cpXKoe4rwOSnTmSNj12lmJgKqe+O7Uk?=
 =?us-ascii?Q?Hs/qD/pSstx6QpvmmN/dU5hL7IhEGYiZUPhMpgA2cYzuq5f5Cq5TK0cer7Fs?=
 =?us-ascii?Q?QaQBBlzBaNwtBI19bA9A1TLl3ctnJZ7lO/3KzK3nnKF5cZCt1FYrmx8pn2y6?=
 =?us-ascii?Q?GBVlKvR9XkNMMj0c6ELAkyK/gXnscbPHuNbN6VAsJNg+28jHASUNK6rC9V0K?=
 =?us-ascii?Q?9ReliTaJNfU5TsH/VIkmu9hHc6NU9AL4GP8Mko+JigA5bjSU5R2N5YIwyBuP?=
 =?us-ascii?Q?mZqZbpxW/4YjFGRP6kejJSAM4wFPOqMHZR7RNKiN7mXC29lRQ2v11Yf5UrpO?=
 =?us-ascii?Q?xFtN714ZZxh+WHwYyzOiS5YdWbPwQRFGFs0qIeg73fdqr2NTz4VnKybRl6QU?=
 =?us-ascii?Q?c8l9QCsYuHurGR4oi/G2icSHCU00KUD1SOEi/pkfIPxPqV9c0ZjKJ+AxOD3X?=
 =?us-ascii?Q?HTyeGqDcOHP4HB8IJGna16g5lEPPQDPKB1rrGrP8QJe0thi3HIf1RJZq7SRG?=
 =?us-ascii?Q?5Gk21PQ78ts7kLptL/uhPHLWrsTwgQffF5M1WtXGnNSScTewl7FVjOHQXJRt?=
 =?us-ascii?Q?ModG0OgLOk6e/y+0zVAawcQIOY6U/mIKzxMBN6Yn6uKdpuGCVYZGPQaRO72n?=
 =?us-ascii?Q?+wtTd7zS2X5FaT/KExXrIJ/78xt6WksCo2yQLrjdZRjVE2zhqDWgo+Xs6cL8?=
 =?us-ascii?Q?xBSqazqYTvtcYZITLR/Or7z+ycpbvBGv78cu/vx+6tf4TEDqKCjj1faHGRth?=
 =?us-ascii?Q?XSc+jO4vqKNmVQGuseUghKI64WJevMdhoUMDGQsD9PE3nnx0VGMoIpqCmTqX?=
 =?us-ascii?Q?fQ5VWzha6Am9kZhBlO+FXmpA4+Z42YjwlQ8KBfdC0LFnts9ED0/7itN5jazS?=
 =?us-ascii?Q?/qP4wXr4R9rQji6TjZYdyTtMqq+LrI8h6NpfPesSgBlQYwOVWQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 17:44:28.5444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b21e81-3e63-4582-847c-08dcfdc17f4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
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

GFX 12 does not require a page size cap for the trap handler because
it does not require a CWSR work around like GFX 11 did.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 348925254bff..4705ebb07ba0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -534,7 +534,6 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 			kfd->cwsr_isa = cwsr_trap_gfx11_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx11_hex);
 		} else {
-			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_gfx12_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_hex);
 		}
-- 
2.34.1

