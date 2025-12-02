Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6BACFD2F6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 11:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020D310E623;
	Tue,  2 Dec 2025 11:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hd+SIZSm";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013045.outbound.protection.outlook.com
 [40.107.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0596810E623
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 11:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzFj1y0dSc1KnfEPNdA/NBJt5CpwEE3V9r/Tw8EHS8V9ehTokBmejnsCegRSfmWI6p2lsBsayGa6S4HAPB3/hoA2smOmuPw7NjE8ysizrf++kAioy7IGxPIiUfSP5Y5IJOiNLVjlDcCkMiRB9yQIpxQAixST+JHRJp29bkKdzLIaKqNcKsAG3ObDvjjOwVPVpSIO1kJJIqwIEwawmZXttS+isxDBmUzBb5nU2SB8RNjNVMBY8mufIidTG4jCevikELzchmZKQOQMOmtbt1dEW1Cc6BK2/5NxuPuSmeSdtK4WGdBlWGGguZWZo+23+gpxX7j1UuKNICvWuN9nx0P/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7PANhMwy97atZc2qTZUip+ZouBjdxXOLrRBcvCAWRg=;
 b=MByvYNnVyRRm/EXSgdUP9r6KrnjbA9ReFM6sUA/1LTfI7XCD7EkWI1dyjiXLkDNJlYdUqI3nOCETwcHRPxAvyPX6ose+ToAzzWTxsdyk5wcLrSXGlCL1ONfQNGvkk3lUbqHgXcK5JOc1tsc3pElKf9xILF4iutnBQNwhE2ngX9U0FUU90CqjVdB4X3Z6KnWtlIUuzdbGHEQcOYo4qj7cIgAsVVEXnhJ8t0fv2EpxfzIdPI2nraqu68+gwrDeMYnMxA8Vg6UT+cKq3/+eZbsH/wm97z59S4MpXVLUSc0xqIxmiuKJA5wN/+ELK0gWCbjTqDyHXJY64H9LhOg7SJXl3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7PANhMwy97atZc2qTZUip+ZouBjdxXOLrRBcvCAWRg=;
 b=Hd+SIZSmey+RLGW6Z5ls84uf1Bo9B7Bw1BCFzCacY7fuNcTo/Pj12opgMZnroVD7d50yq71+1rVWf+L1QBD899zqjlEBV27OHJRFajT6ZX7zjU2KKTU7bQnnUBMOUjy2o86F2oJODMXWx0qzEvJS6VQfTaPxG7/E4+nvPilX7wo=
Received: from PH8P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::23)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 11:44:24 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:346:cafe::f9) by PH8P221CA0043.outlook.office365.com
 (2603:10b6:510:346::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 11:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Tue, 2 Dec 2025 11:44:23 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 05:44:21 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 0/7] Add cache interval to driver tables
Date: Tue, 2 Dec 2025 17:09:07 +0530
Message-ID: <20251202114358.512048-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a600d9-c55a-4950-f23b-08de3198237b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KLxppuGK99yTdnvUSayHN1Rt+F6pDMaspHMLFzr/QyHNiXa1Qnvxpc6dzjuZ?=
 =?us-ascii?Q?ULfoCUQHz/vl66DelvmSyJR7Kn4mV+tbPcgH4WVrg3I+BfPzA64+p/H/6Ias?=
 =?us-ascii?Q?Tr9Yxh+xz5pLM3odetbvmK7HTKf9nm9NCPKEeTaEGSZJr9WEBgCv5kzbgY03?=
 =?us-ascii?Q?A6W+mT6IRKf13oTbhmsVVV9HCMYxrdm3tguH8sm/icowM4bIFsJV3VqQci9p?=
 =?us-ascii?Q?9dOAWNKh65Ilh93JO/foNjuPrqWGhxFx+KC1mfM5yapeQaUu3wFUV3tu+oXR?=
 =?us-ascii?Q?Ful6ONNAz2Sn5sxU/vKrEAz2ME5NQe18zQzPecBl62/ISq/LxjUzBD35sEHG?=
 =?us-ascii?Q?/zvJYAgh1hfTr0shJJyOlzHPZKs8x5CxVD6cE11LZtLGiQM9MWnG0xAajPFP?=
 =?us-ascii?Q?DuzOuoaUzAg5njX3/UG6Mbwu62jwwUveQSOZKrJ+TCxpxaoYLkuqGRWSL413?=
 =?us-ascii?Q?EvsF6h+yCnPtJMPj9a2RHaNb1ymOMmqxslZijaD+C1DEnUQ34w0kzJaxcwJN?=
 =?us-ascii?Q?Lz1/zhsG41UNMeEkvKPhNErmOy5nzak7GMJ9LVB8fRl5l4Tsxz29VNltMxpA?=
 =?us-ascii?Q?eZ0RZoSf3/iqthjOYcnDL2oWpH4q1Bur0vD23NfQILfaQxS+TMIrVrptozn/?=
 =?us-ascii?Q?Ta78PrmxaO8gOq4O1pT7MUhsk2pKyHjXDMb88rY/ph5CojWR8hlul0+lgk5q?=
 =?us-ascii?Q?6Ucz3eKMV0tiz7eYGT2rHT+tTaw1xFGHIyQstB0At2J83DeHgyxFwex2wfrN?=
 =?us-ascii?Q?LpdzXwTksAdwEXLi3QM270OSdVpnZJZfPZQhFUyK3uBUcKKc9CYv4Nhmg7pQ?=
 =?us-ascii?Q?Fno6A0YKenjapm5PA0H708VnXCvzlsEy/xXzDtw8MaLO+soRVeMZA4bMMU1a?=
 =?us-ascii?Q?Gzr2VNpdft5tdgEJfrkSHemPoTgtogjOYqZcPM2B6fw74XWeJVotRws9hY62?=
 =?us-ascii?Q?dKnu0UUwa9+5J21KQY4vWFak/L23o/IEUGzsaHCGNXfam/Z1AoefkzDUY+nK?=
 =?us-ascii?Q?WPY4pOsKvXqm/vl5fXkKyAwRGqu06fUYSlFv7TJbskpnHsq+orqawrarfC28?=
 =?us-ascii?Q?9QKbqy99o3BNkbpmaE3Mi4XyzgxjiAL3vKO0lfO0KmxjsYSHc3LIeLzRm74o?=
 =?us-ascii?Q?QU7xTprvwfkiD7zFT5ujofC+urFw+wqAQZPX7gzCXlbqUZE4l1QchCh0nF8V?=
 =?us-ascii?Q?62DIOE/FDJ7Bfm5/hc8PELTcfulEXCAnjn4E/gzGealkK6MVje2wndTsjAFm?=
 =?us-ascii?Q?hzP9+ts/abW7k04/d5pdTK7EyRUi2lMyHl+dxGLdD7dqV62KaO5uhyw1VUbn?=
 =?us-ascii?Q?r96zcV32qblK8OyR7ElNLr3XvcEYdlzMf9bokuUBK9TWI4VBTfZwm7vqWz5o?=
 =?us-ascii?Q?xzTEt/Sr3NeGT90z1byt62s6RwonreB+i5eKuzw9iM5u6pZHUbzQd/cPM/Ds?=
 =?us-ascii?Q?WhUPKz6CcURPzhqMaUk9ZQtdwUGi0HttfVeGLQrrzH+jeWsJcw/9LPUph3qj?=
 =?us-ascii?Q?y1iiVcTZYEGpmixNx4CsZM4Kzo4hhPbg6uzKcmJBSRzZyB9e3BbtRIV1Dw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 11:44:23.2250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a600d9-c55a-4950-f23b-08de3198237b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588
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

There are different metrics tables provided by driver, and they are all sourced from firmware.
However, even with the same firmware table source, different classes of data could have different
polling intervals. Hence driver shouldn't apply the same cache policy for all data coming from a
single data source. This series adds driver tables with cache interval so that different tables
could keep their own caching policy even if the data source is the same.

Lijo Lazar (7):
  drm/amd/pm: Add smu driver table structure
  drm/amd/pm: Use driver table structure in smuv11
  drm/amd/pm: Use driver table structure in smuv12
  drm/amd/pm: Use driver table structure in smuv13
  drm/amd/pm: Use driver table structure in smuv14
  drm/amd/pm: Use cached gpu metrics table
  drm/amd/pm: Use driver table for board temperature

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  31 ++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 105 ++++++++++++++++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  16 ++-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  15 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  33 ++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  16 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  44 +++++---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  14 ++-
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |   3 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  18 +--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   3 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  16 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  49 ++++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  17 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  19 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  23 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  16 ++-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  19 ++--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   3 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  19 ++--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  16 ++-
 22 files changed, 332 insertions(+), 166 deletions(-)

-- 
2.49.0

