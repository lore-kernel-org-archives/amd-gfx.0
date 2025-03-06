Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A025C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D74B10E1D5;
	Thu,  6 Mar 2025 18:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aAB8Wzrx";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 019EF10E1D5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tK2UBdjkA/axLz7ujwdmXzbSBXUlQnBytAwMbhcNp/XcaiCSimzbFVetoQHYcIluKNFYzAK2VcxTrsuQCPZ+1Bt9G4vXMf9cvGQZNvhPt4h5lhlwv0f7N3+MU/EUSjr5EMocenh+2G77YW6pNFuXkHBPvRHGQsM3HYOY5g5m7c4d6z7vFZUDIZ6TsVMz2Dabiz7uNHuvP7sDEARYiEuG6aICykPRWm3h+2APpKLCkr2+0eq1zGH2KaWuwf0Y4vd3ev6MIm6Qd7qhkrLIEvpTyeHZQMAe6MuqkBUuymPcdhZqyuY9bSGrBH4LYgWzeOGIJ4YgT0pWooBrXpL9nqUKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzP9aUxX4hy3+gWadY1Z+uWyldGp9SpvlCYpZCz662g=;
 b=sUqQYPJpNPcjv0PkpVxNdveXiyZvYOuBUHhBXKdr2VvEBNY+eWi3FsNhQ8jlnkJsDMJwME4qFLf2KYHhdG3mck0+mVYohCJupyyIRBouabA7xXlEENi/tFqYYE2RUxaodrnPiBg7ld0uFtPYy6G15OnfbV5xDM3OfLEwYMhdzwTnPuwCaMmx6TAGUtG8ID6tg4Bnu1jVBVVF0MGEGfpROPbDbYseOzragsvj9qDNTUkIGaJ5ezJJTMzKune2GK/J/5VKRnVOGjgE5cstDrCb+c5miz3YDRV/c0S51qcYSWZNuuqkAUZN5NH79Pp2rsZMRrdtoILvFlsrMtpgm+40yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzP9aUxX4hy3+gWadY1Z+uWyldGp9SpvlCYpZCz662g=;
 b=aAB8Wzrx43d2gDfzBBt46Xu1s29YHsg+j5EDirMZCHwlj2jn7vUJDkSX9XIFPn+kefNdqIOrzXN13dHskFjiVbGhTdsHWQaTutnhFG6Wt8CuGwfLxsaJVB/isN/VY2cp1TuU2MG6lvQFXmQHp9X69vGfZDH1x4RX4sbjVDheON4=
Received: from MN2PR01CA0052.prod.exchangelabs.com (2603:10b6:208:23f::21) by
 DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 18:46:25 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::fc) by MN2PR01CA0052.outlook.office365.com
 (2603:10b6:208:23f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 18:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:46:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:46:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 00/11] Add disable kernel queue support
Date: Thu, 6 Mar 2025 13:46:00 -0500
Message-ID: <20250306184612.8910-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: f12ad1b3-37e8-48bf-7b4b-08dd5cdf32b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Jk/eFLYgPiTA0F/LmE4N+z5RzBRDtXCivySgg5QQLPED15Stq6peEbUttOI?=
 =?us-ascii?Q?3pFOWZasDrG0CtNhKcdbb8C0aOxj5axMgbmWieolSlXTo05hgcPYD2glfKnv?=
 =?us-ascii?Q?C4WtgPW9okMIeNHXwjfcXj8/b58Av2ptVfG2abBI5u0nvIE3ZFNfNUappdwX?=
 =?us-ascii?Q?4BthfcS/8hJRDrTSxe4H2KJGgqFuJ486f12u6A44E7gMlPrq5fSI6BV4e9Ws?=
 =?us-ascii?Q?AEsAzqbBJmWZEjD9uQrAcaSddRGUjwBTJ719nuV+SkhMfkCfginaK/bhMx/s?=
 =?us-ascii?Q?bBBs82ZSBObURrqWibXLJRftf8D1pASJVQeQ6ouyaegpCgNYciC2VhvP7JJH?=
 =?us-ascii?Q?dny5RY/7cF105zXgOJ3kJiyVStP7Ky9N7/2avT9zYAyKi7JCFVw8SMFRUkVf?=
 =?us-ascii?Q?wX8KZwFsaX2ibg0lczQjYY4EV+Eb3UmHQLbAoea38mIILapWAvqecG2PkJJ5?=
 =?us-ascii?Q?Jy0daYP63RZ5+SOJFheLZnsSz6Hz2SC2trxB5JxXSI1p4G40uaMz/6zPLWnv?=
 =?us-ascii?Q?7e4XprQoRxB18VawDhuE6fNAc4wFeivHKZjlJBw/ylQVaRAn/b9T4lOruieC?=
 =?us-ascii?Q?59nL2gSLSjYcyrxEt1pWx3uSne4q7JdhvMVYSjaMxD3xJED7VQBMJo8KZHkg?=
 =?us-ascii?Q?yVSUc82krtfQ3jXlfQcZ/ixy9YaZda2sKb59Z8uY0NOngSlCF8KoYr1qhPqj?=
 =?us-ascii?Q?L6xJtRGo3r8SOcQXBtT3bPDR31vQjNyJ3zMVNuqZ3Eh2tWU4wPfIdvmTzC6q?=
 =?us-ascii?Q?rtpf0GZcFlPvhSijsXFEr+XuTOO4V7kAPDGdm/pR6Pt0QAXK/BLKc3SHEUzA?=
 =?us-ascii?Q?83YiuOejM1M9KvQ/mp2DHiOD6Nc+qIbbg/uPXhwPQSL+kRhuFs5ETWuRSW9O?=
 =?us-ascii?Q?2iuEGp6EfQHRcbchwU+Rx/29nxbys8/J8zXtsAhF0LoobeZUaOYIDOxmxxji?=
 =?us-ascii?Q?fyVQ5qqfVYe9G8WtewT3xXI0fUmWl8MSBvKut5N2HKKAESIckP3vElBl8xA5?=
 =?us-ascii?Q?S1dVgi/Ty3S5yufc0624lbFedIqZpVX0YUNlh0HXV050POcEbna5jZNajN1r?=
 =?us-ascii?Q?3/4NzZ42BcdJYhSTKkXbAKQT0LBMyOW2Y8LrI3nlJZdjepkEvtvVAI4VCxLv?=
 =?us-ascii?Q?SQlzO9+R/5/t3z1APHTdAcaNVP7CFVz6R1nzMaw/9vtIuyFxKS0c5lHC+g8t?=
 =?us-ascii?Q?5VUYd02MeIJVej/NdFHZlSmI304sjZZLc6c3PTZ9p6KqPtupjEyXi/kSxsYb?=
 =?us-ascii?Q?t3AAfeMF+0gwtr3NbehQIha8lfj6KUZQRZiJo93CSTGngTb51BHWpMRt3lea?=
 =?us-ascii?Q?ByUuu3UDULpeApyd1G8vEddPgREzpRoiGY/HnjHyYWCzYqtbVrs0uh1ZAF1j?=
 =?us-ascii?Q?DDkKV0U1mlM87z7e3UL6vYWSPNpQ27Pc/CgguHbiLTVmdcuVCiwF7gHtrSME?=
 =?us-ascii?Q?nwtO2lWKivckhetCuiVX04wmqXDPh28wTvR5eR4v4OUEf5xELaWiQzsyXP/s?=
 =?us-ascii?Q?CGO3g0lSoHQvHAk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:46:25.4070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12ad1b3-37e8-48bf-7b4b-08dd5cdf32b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276
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

To better evaluate user queues, add a module parameter
to disable kernel queues.  With this set kernel queues
are disabled and only user queues are available.  This
frees up hardware resources for use in user queues which
would otherwise be used by kernel queues and provides
a way to validate user queues without the presence
of kernel queues.

v2: use num_gfx_rings and num_compute_rings per
    Felix suggestion

Alex Deucher (11):
  drm/amdgpu: add parameter to disable kernel queues
  drm/amdgpu: add ring flag for no user submissions
  drm/amdgpu/gfx: add generic handling for disable_kq
  drm/amdgpu/mes: centralize gfx_hqd mask management
  drm/amdgpu/mes: update hqd masks when disable_kq is set
  drm/amdgpu/mes: make more vmids available when disable_kq=1
  drm/amdgpu/gfx11: add support for disable_kq
  drm/amdgpu/gfx12: add support for disable_kq
  drm/amdgpu/sdma: add flag for tracking disable_kq
  drm/amdgpu/sdma6: add support for disable_kq
  drm/amdgpu/sdma7: add support for disable_kq

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 30 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  | 26 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 99 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 96 ++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 16 +---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 15 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  4 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  4 +
 17 files changed, 204 insertions(+), 112 deletions(-)

-- 
2.48.1

