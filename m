Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100F3CCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 20:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA5710EA3A;
	Thu, 30 Oct 2025 20:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="alGJANVZ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 530D110EA37
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 20:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjPgxybc1liMBHLcJvKGBf/8E0BrDRmSoGF1kT28pU+LnoHIOlByO0VWcJS5WJyS6MkZEhMw4phNRMt+vSKjhPjVeqI+CH0OZW7xeegn2Tgin8zth51gd37wFeS47xr4/ippgp/tKnihfj8F/twL3MlAjvzwBBjibqz6qT0mkrqa+51RVZKNaQcsrgpHOBPEQKL2rAbrcX+P7LVYnpL1/kmehAj4DKqSQbngsDofr/Qj3dV0onQgTtdKiGUQL4apyBGhvGDnqv6kJrS4zfd0hTzh/D2brH1gveAmsKol/h5v/rwKgefkuafomvV1w3vXZCpTnCwUw9xHV+BiM1nZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjBwEMRb8w2vDuEatKzelqBgAQ6NoP2Q0b9aMa+fe0Y=;
 b=byiLbU21b370b175bRzHbj3tO9axA31dOOqut6yefWOTtjui5IPOizQaKuJjfPFBHvFRrUCOqkyVUlsMpPyO+pcCET2Gf08jGyJZh3nhcKX7AW19usoXmPh9lyZJ7bnDfNVDWSkpkGB3ZpKEU4/BHGyoU2/Cs35S2PIeeT4uhwQwRg9kuYqk5awNISsardso4pMoaNpUFGm4GAjkCQUQ/FZa7QqQBFBixnrdXAkGHP3YQKOdC+FOh1zhTH4pZf+cHIvSvVPFsGENvk3hH8AeNpxtYuS9eF9JeosC6oXXwjJjhc8sORsb4H3I0shXQ8v3Q80Wb0y6qeBZkYDyloEFbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjBwEMRb8w2vDuEatKzelqBgAQ6NoP2Q0b9aMa+fe0Y=;
 b=alGJANVZAr5nF4Y0h+ctucfA1c0JvvnL8eZs3su/Ueb3iN6iLOE6Z1cTpyjJPiXcZycfJ5vSZcGDMOY7Ki4a4yNc4zLBZqHobHrAzNNWcpdP4N6FcGFEvkbXhWRMezQCHyC/U+luZdwuqtyhUny3QeEa3umRSijpojsEWvJN3kQ=
Received: from SJ0PR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:33b::13)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 20:51:09 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::1c) by SJ0PR05CA0008.outlook.office365.com
 (2603:10b6:a03:33b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Thu,
 30 Oct 2025 20:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 20:51:07 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 13:51:05 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/2] Add mmhub 4.2.0 support
Date: Thu, 30 Oct 2025 16:50:50 -0400
Message-ID: <20251030205051.590971-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8a187b-dd39-439a-3069-08de17f60cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UfQpdyY6swy722BnQC7Jy5FIZeKgNnitrmt1ja2ak7Z/DvuWZIehpQkwztbZ?=
 =?us-ascii?Q?UBOCV9nGd12g+gIAIb0z0RxMlYB+Agz59F+VrqzX4QIkgjMyLXMj/o/tWsvJ?=
 =?us-ascii?Q?7C4eXqbUeaJwpbX/B1VWy0p+d5esB1HZjMlehQUI+5yH4FcCtkk4wX4V7MFQ?=
 =?us-ascii?Q?k6tfPO+LZK04T9o9WAClvDWU4fHosZz+qHnwazwqNC9Bd8lXRuoNEI4+/Ibg?=
 =?us-ascii?Q?IYZVs+PTx0mU5kqrJty3kOLGRB49/VJfzoaYEusVrSu0eIYeHVx0e7Mtu+Nl?=
 =?us-ascii?Q?QLSXHls1trIDkk5KU4yqcr+HSZrUF+Xa5fohuNuH3p6xe6Tdo+XG/kZIUfsF?=
 =?us-ascii?Q?ksuoZiC5KrA6mIuLzVIwEmeUmDq1xX51OItgpYORMmMnqeghz0cWqUEZPwVQ?=
 =?us-ascii?Q?36MrO17dSPubtV0oUUEoNgxNjb/4PwtpGTtUnfH2sbZYGTteV7O57OtbKiEA?=
 =?us-ascii?Q?/I1/yq9jtKp1xIIQtZkOD3HKaVAaecbsbUEYI61i07oy7pIjq7H3EWLtEx/5?=
 =?us-ascii?Q?p4SwUnriFTeVLmUVR2TM4ddvxA8y/fj6b001Wo1y72vyNfkSDOtqKB7A8Geu?=
 =?us-ascii?Q?8UGNp+l5eC2KLI4o41/V0PKfU3crrKbPhDzih3/2poWKoiTYlV54Q4CaXMuE?=
 =?us-ascii?Q?iRCuMNB6iw0T6nwjP943m1PYjC3v1j62viWYIaDdMkvkWPiEwwE1FReAL/S7?=
 =?us-ascii?Q?TDTM9YrgvJRA5zAvm80vzSNNACLdDHmtCEMIU+wp5DPtN2swYqFWoc0SpiNC?=
 =?us-ascii?Q?hWWBETciPd7QJYvbEI8bcBE91r5OVS7eyuX1D/7rx9Bzo/5y3YmZLLrl3DoV?=
 =?us-ascii?Q?kgMBqsuwfd1AYkl4vhD0tRkMtjpMY3M4Q/qLg8vazYnchRKI8EFP5L5M+rI3?=
 =?us-ascii?Q?TmnbrKWi5CxQrtf05b5DwxZtHWSD/2e5iyFevH8tST7RXImQQm1kBl4sBTQm?=
 =?us-ascii?Q?BkiXNEsuS/zBpAL2GVygjjvLtoaUesvs2opDhr9kIjtAds77a5aaZiw/HRV6?=
 =?us-ascii?Q?RRzj/EhER9yx7KtMOPvSscgVjgowWOkhUwglx3GF1h8ZqZvpehuXv7MCVio1?=
 =?us-ascii?Q?Yct5ItcQ1KnnT4/VdAxVJObjv818EwIHsNQGX0WdegUmpuoHweIk/citCdLg?=
 =?us-ascii?Q?zby3+FpRIpBy83TRVHvofCCrXyxHybXsJMkL7ahFhiqdD+XksFFtMg5Bdpvp?=
 =?us-ascii?Q?RPdfODtMalr12qyiSi//x5yKU/wK71jWplDQNA0MVfY6grrkf9HhQ2jTSNqv?=
 =?us-ascii?Q?7bjbloTqxZtLzFp+wtSMf4NpswP9B/HILgYuUodM63JgVrFftN8Q3iZhbh4O?=
 =?us-ascii?Q?qK2sZ0o2bQDxKQr1akHI5+7qHZ0FdlYlNHTx135ZcSUSIwa7Cmkgv+6vNwwv?=
 =?us-ascii?Q?xG7ufpgHZBGOShaZI1J4HPFpLbpUTrZ1GEDQ/z0i8bXlBDWOXr5sJR6DWYlM?=
 =?us-ascii?Q?G91nzvPbiGBGl/7p77ifK55fTpC0VtCbmiw1+9Ni3T3u5PB2j9BkCTgp1JHX?=
 =?us-ascii?Q?zyX9a1hCMzkGcgTSYIf/qK79IFlO8E+XhKdkYAVBkm6iXAVFB+Ei9g/3zQp4?=
 =?us-ascii?Q?VlMBCMCU6fL/pALc5RA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 20:51:07.6483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8a187b-dd39-439a-3069-08de17f60cd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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

Enable support for a new mmhub.  Patch 1 was
just register headers and was very large so
I'm just sending patch 2.

Hawking Zhang (1):
  drm/amdgpu: Add mmhub v4_2_0 ip headers v5

Likun Gao (1):
  drm/amdgpu: Add initial support for mmhub v4_2

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c     |  915 +++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.h     |   28 +
 .../asic_reg/mmhub/mmhub_4_2_0_offset.h       |  802 +++++
 .../asic_reg/mmhub/mmhub_4_2_0_sh_mask.h      | 3013 +++++++++++++++++
 5 files changed, 4760 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_4_2_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_4_2_0_sh_mask.h

-- 
2.51.1

