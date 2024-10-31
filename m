Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF1CD767F4
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 18:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4038B10E8FB;
	Thu, 31 Oct 2024 18:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eivMrG1p";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA1510E8FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 18:04:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6snh1etc/EB2XBO2Ub+wZeOVqAnHkmnqpoop+8E5LmWM51ovCcqPCMlDuCmM/tPgWRbgGPqbJDcXLcJWqLp/cWryocrGDGMUTAJYZ1XLP6pTkKLw7NrqjxHhc7GuEKaiw3wdlbf7IAHoXCFtky3760xS0oAm/+YylYmmgokdnOzEyWGWNQJkTxM9IkkZjtNjlBNfyGWqwJPeQXLqCZWAKxX4pTw/HrNQD+35khwtsvIPeLDNIBB5ZNxaOH6U5WQSZctZFdoHdNWOZ+UkONuHiMirDuFT7uRtIxuwwNrYCvg0lpcGmmD7ZyP4kjOXHv4FzHyqLnOHlrpxiLZwrZ3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBK6ITz7CC338utvZqChmlQTi3dwf/vx+OMLMSiIoYM=;
 b=gLdZbB8CKAeIIDf0WmLIV026adCRIAwjET+SvBfok1BMQ82qVdLJOkbCzeWNAIr+RHjsY87uSeY/eR+kINyuP0bmYMzUrWLOD0XxbgFRiutcc76ptJZ2FKDJ/r/2KG2mV4WSoX/bZeM8hYREvVGgkZUkH0rcNyqQc8ehkCIfUjXBZ4C0oITxJTfftSHxx3heyq+z0kdpGjBXS0TnVu50avvBU/QPJvOUgJwrjesNVQ8HZnyHXupi54d52zv74XrH7Iy+bxo5AcLRWhjFp20PBG77cp453TIPdxmoSJcO8yUQFwGYxm2ZIPSkwC/ZEmUEt1vsUTE0hzbTY0Bie28wlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBK6ITz7CC338utvZqChmlQTi3dwf/vx+OMLMSiIoYM=;
 b=eivMrG1pExByi8KCpaik64WRotz08YzxBc5syZ8FmyQXSKydCl3EfTlGVN1mhnUZGjS/IjnUZYeSXkXRmmwV5bfHmwOEuHPr7M8sK6ogjPPBsYF5njpbvPbyXa8+PQJX5bMG5SsFB6ZfleS6B/oD81EgEWNrhqo+BbIaXswfYsg=
Received: from MW4PR03CA0175.namprd03.prod.outlook.com (2603:10b6:303:8d::30)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 18:04:46 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::eb) by MW4PR03CA0175.outlook.office365.com
 (2603:10b6:303:8d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Thu, 31 Oct 2024 18:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:04:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:04:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH V2 0/4] Add panic support for all DCE/DCN
Date: Thu, 31 Oct 2024 14:04:26 -0400
Message-ID: <20241031180430.3993389-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5a61ae-02a6-49d1-3865-08dcf9d680cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b9aLUAHlO60U40F7k6c9sL307LgNZ7XVJXEPFnlTxpcNTOm6/UmLhKqtILF9?=
 =?us-ascii?Q?BXm/tGSLRhqiMMvJw53pfYckTf/d/msSMX54w6iVdPvXDorh+yzylMENfYFZ?=
 =?us-ascii?Q?ylWJeSKFgh6HIhFr/4IjADzEeCOS8rmWoXh1LbErdX6w5NfW8ZRsCKOjqvUW?=
 =?us-ascii?Q?wRy28yeN2QuaFcnXMfvKLoV/XgUbz6BGX2l9MMQHPX5lG1Qk4O5ThWditiAF?=
 =?us-ascii?Q?8Lbx0hFhGr25tjAHDgVFxh7hhKgNP0Z1GBOYCTcg8kbGXAGyAJOXi6jukkQ2?=
 =?us-ascii?Q?Jv8Wt40TsomTTpMKPPZbIrjvEORt5nVyc6ezJxA0eEZdBufFy+F3onU6nhQo?=
 =?us-ascii?Q?ZfSmrR1MZ2lKq6+A92BDM7hF6KuQ8tJAri7kCKPn9sChxIy1neR+T2GUoCWU?=
 =?us-ascii?Q?nEU1/aTO5L69DskIIsLGmFaxfunejgX16UBkqSdHJJTgGeZVZlGmvqnM5RH2?=
 =?us-ascii?Q?1NwUAQ7/sVyFs//2CczpEogO6BoHPSe4aoQKWqjXHWXEFJs63jgsOGMrGiCb?=
 =?us-ascii?Q?6D1mJRnfgvY25k8NnnIchkc+IvzeCn7AypWsoec5g5kGnpSqLudADgBYQ4i6?=
 =?us-ascii?Q?KgoH8yZIO7uy8oomoK3cGL5+s/nW2WohN2t38LCco+R1VOHJh88OgmHhMOwX?=
 =?us-ascii?Q?M2OjxLAII7W819CL6qUI/7oN/oL4O+qT6HOvhLRIwp0ULYUiX3Vfu5e2KUGf?=
 =?us-ascii?Q?5JRMJaB0BE2m/GsVLHt4YUpV3MRimapDSuzcowjyxIOGQqLRziEDxUpaJdO7?=
 =?us-ascii?Q?7Ztgz9Z/DX7/CFJHP6Wx0elb7Y2KC4kEzYfSYjGzfJXXw7wykt5MfDFgnt+d?=
 =?us-ascii?Q?o5AgNe/jVIAKUOa0GjjYFjhbHE5+u+vbTPZep57xrxI8qmCVIjhQ/XsKSBcQ?=
 =?us-ascii?Q?m3xObr5u81dK+zZszU9i6TlxUE4czdjs2GrwIj9X4Lc6XddIVvO4qhNJGpfT?=
 =?us-ascii?Q?naqc1Ipsz0pc+RL3UYMhpeePWPMHTTFgqonJQqoelQx6oCS0qKO41RpaZEci?=
 =?us-ascii?Q?oKtK2mCYxA/bQtTsDQpBYWOZ8ugFWMMordbGtyQULN86BTa3UJnItoXKveju?=
 =?us-ascii?Q?bNp29wmLX04qveQfIusAWt8DfhX2aZPmP7ha/8ExKO56vRPsESw+c6SDcNbH?=
 =?us-ascii?Q?iXLtXGaxQWr/xp8vw13Nt69KyPP9ztEx/UgnMnf8xAq+FoeILu3uTmM1YkoH?=
 =?us-ascii?Q?MRb/ANASW1Wpl+JfV6R3y2/Ce7DBiw0VE9P+z5mqwUyCRC3u5wDl6eUGgrc0?=
 =?us-ascii?Q?d3BP9Kjxols1ywQR/k/XRxX6Lpn6mXub1+/hhhQiqXhLcSgNQE3jH38fmTkG?=
 =?us-ascii?Q?gdRmbW4zBfp2sC3/4qfZfRuxvK9tyKWrsOvslcX0KstcrPb8ts+QPvzsom3N?=
 =?us-ascii?Q?4iVkuGLq7WTI8AmmxB5SGdtQrOrAGAvK8l6RpJ5A9UOfkPyXvA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:04:45.7586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5a61ae-02a6-49d1-3865-08dcf9d680cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
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

This builds on the patches from Lu and Jocelyn to fill in
panic support for all DCE/DCN variants and code pathes.

v2: refactor to provide cleaner history and share more
code to provide a more consistent experience across
DC and non-DC.

Alex Deucher (3):
  drm/amd/display: add clear_tiling hubp callbacks
  drm/amd/display: add clear_tiling mi callbacks
  drm/amd/display: add non-DC drm_panic support

Jocelyn Falempe (1):
  drm/amd/display: add DC drm_panic support

 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  27 +++++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  27 +++++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  27 +++++
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  26 +++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 103 +++++++++++++++++-
 .../drm/amd/display/dc/dce/dce_mem_input.c    |  34 +++++-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |  15 +++
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |   2 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  15 +++
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |   2 +
 .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |   1 +
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  17 +++
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   2 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |   3 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  15 ++-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |   2 +
 21 files changed, 316 insertions(+), 8 deletions(-)

-- 
2.47.0

