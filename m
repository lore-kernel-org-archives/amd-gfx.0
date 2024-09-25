Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A10C369A9
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 07:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0A410E7AA;
	Wed, 25 Sep 2024 07:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pq9GH49r";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E043F10E7AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 07:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ek0bwYiPLPmWUzChxpDJz8tITvAhAbHgQW3507S3B04zOcZqvq1Dv04SzhUCwKdfE6+dZCHsoOgobivKV7ICryMpuP4YSofY1po3UEd2WR61v8ajwCLoafsCeBjNaztQCzIG7ZvTqFM088cjhYO7H/vbnw8fB7xy8dTsBlN+TfAoTVCl6FgLYaFiczZqFn6kNC/P1sIr2U3cMbSHQn1Dvv/pKEDOLOu6wNn3Si6bAyRqKgxJCkxuU27WrB3hKk4hcjBnLpY7WNmXWlUMsmdHprNGT0GVdTmRJnKFE6SFGUm5poeipWsTqhnt2wqsLq+1ztb5TrcBUN4c4uemaPUISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGowcrqxVnpVhjyVl4y3UHpPkoswPS489wYQalTScao=;
 b=q3jvpberQX0d2oeZrQq4EHysMmNEYbRpkRkXDVu3SAPmBbDVnRN1/tg2TZ+C4LeonrtAbluLDmltFZlU708RVGNDSLY/06ZPfSn5/b/RJfhEbYSV51HkEoiSxMBzGxodwmBy7Y1IcbwmyrFhO/8g3NM9/+8PXbibmMQ/Vq6c/pTm5wpzDYYDhxphJUVSmZmTFq9IwbEOptQKfRx3PZ+cb2ffcYj0zlfp0Yl93sPEoMJRHDWfcXCuKHyQT/tLKjm8wC/jr+xmlCYEbtPC2F8YT209QnW2pgUo1CATsB7QHY/Dc3qNLkHis4KoB0A7KaSUIRq9gHE0vhWlRa1U+sMqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGowcrqxVnpVhjyVl4y3UHpPkoswPS489wYQalTScao=;
 b=Pq9GH49rgrjDDB1yIsquBvI8RexLO+p6cuIEXUykWV0Y4zaIwu5UsQ5T/07osLi7jGC67I7xFQurhJ2Sk0+nlzqNIEfhKGTqHGlQSEPhXWt1gY8lZouKhpWBaw/IRfYr7S8KHlj0mqwRtMPQ/VsX6qUCxiwh3d2UGK5Pu6mQsXA=
Received: from BYAPR07CA0029.namprd07.prod.outlook.com (2603:10b6:a02:bc::42)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 07:56:34 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::3a) by BYAPR07CA0029.outlook.office365.com
 (2603:10b6:a02:bc::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Wed, 25 Sep 2024 07:56:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 07:56:33 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 02:56:30 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <kenneth.feng@amd.com>, <mario.limonciello@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 0/9] drm/amd/pm runtime pm changes
Date: Wed, 25 Sep 2024 09:54:24 +0200
Message-ID: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 55742141-d1dc-4a0d-a10c-08dcdd379301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aiWYRmv35hmcihsfMBqLcNqHR/JhkkXFqcR1nGuYPc5Z9nju3mtZl+V6Y4LG?=
 =?us-ascii?Q?k9O190m4RqhKCm22BRKDGVjy25zwOh+gg5YnToQSpQ/H7IYaOjS4U4wJLu1B?=
 =?us-ascii?Q?2Ck9ZDlz93InDIBcIiRC4f2F1yQV5Nf/en0tR4PEYYL0+a2GNDlyPW835AxD?=
 =?us-ascii?Q?Kxbhv25BnSJ/Ti6Nnq4WeXzpcnWyrbnVLjGPko50/c/PdN7LunJceeSXKBG6?=
 =?us-ascii?Q?D0S2PUiumHvx8h+zoTxfMuO5wKShJRMxPtxj5tMB0VDn/X08VOH3sccBLcda?=
 =?us-ascii?Q?OdMiAslOTiGALx0MrFEr9hBiwxFmfQ5CEPJo75PKpIOWypDMS1xJlTaEs2+2?=
 =?us-ascii?Q?CFaJEwGgMD2MMC9ApwD69kBxz2IlkFL/thl3k/4SFeikG21L5omgYlp4qYp2?=
 =?us-ascii?Q?a7JnKxMYpKBJqRQunDTARAHPaWRgH9QZNmVxN66gQul2U9GpcfCQvKbst17R?=
 =?us-ascii?Q?Aug/bzUkPYOTf28cX1/6ZuE+WnS3TJsigW3+5PgLT6BuG9R+5WHe6BX57Px1?=
 =?us-ascii?Q?1xo4b+H80m/Krh7hN64w5SttPKW3DDITUJv8CII7kXNNKS0CnWtKtCSHpqJn?=
 =?us-ascii?Q?edShJSBNmA/cfhp9kOOO2xPaFlyHviLfk8aQjdeJaM93egxx/xSJ5gt/Odfo?=
 =?us-ascii?Q?LrFMzFz7GycJ+M5smmXCyiRcON2UQEDuQ3+AHy4KpicSTDlxCk08tddahu8s?=
 =?us-ascii?Q?Gckq+obQezAAl2miUYdK0DbtpktW42Wc0mxOG7WWe0w3TR88/qIChJprBRVs?=
 =?us-ascii?Q?9AGyJGMyrL/RhQTb1Lgn3A3VuY5Dh1RdaNXNo3nYfXZJReu8m/h6FPTpaBrc?=
 =?us-ascii?Q?h8n4ShZjcMRrw2cFgSAQIawoiz2CKVg/kNWlD527+oLMwHmnTjIe0rnzQLsq?=
 =?us-ascii?Q?PGvRLkG+DtNzT2C8ypN2MmacjW1ikdU1UAvSufCz3pnxJobn/PSSGc5Be5jZ?=
 =?us-ascii?Q?i6Uv8rROYX+IZCvtdtF18bGnyw1cPB0hmLHD41pSPag00LOkHC7fmLrurlIf?=
 =?us-ascii?Q?EuowPtmJ7y4I4D1sDAcykmpJdij29EbAxEhehzRQZ7NxX9f42JXbNxLRKrte?=
 =?us-ascii?Q?VSqCnGB0lfhfVJyCQgoTo4L7sWDEAnDPv94DdZE3uu9x4Odyk+xDBwAHidId?=
 =?us-ascii?Q?jXoK2fnunqdlKaT3gPFiSEHCU3c2FIFd64Oj53EBty/fjVtwbRt4DIGzddCQ?=
 =?us-ascii?Q?Qwx6X53k7Z/IEhLUFtnQ+DghlTf6fHBVmsl45SaaoQceRq47K/FtBEuym05F?=
 =?us-ascii?Q?Kw9n8tmfyjXyFz0ZS6MGBb4sfWsYVG/+iB442+pniJ0nrJ6u8yZEoGjKKt+F?=
 =?us-ascii?Q?xqnAmecJG0Kzg5FLclr5LXiX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:56:33.7502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55742141-d1dc-4a0d-a10c-08dcdd379301
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
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

This series rework how runtime power management is handled in drm/amd/pm.

The main ideas are:
* simplify code and reduce copy-pate of runtimepm calls
* avoid waking up suspended GPU when reading debugfs files.

It is similar to Mario's earlier series:
   https://lists.freedesktop.org/archives/amd-gfx/2024-August/113213.html
It's not a direct successor of it, hence v1.
Instead, this is part of a larger series that applies the same ideas to
the whole amdgpu module.


Pierre-Eric Pelloux-Prayer (9):
  drm/amd/pm: remove dump_pptable functions
  drm/amd/pm: fix rpm refcount handling on error
  drm/amd/pm: use pm_runtime_resume_and_get
  drm/amd/pm: don't update runpm last_usage on debugfs getter
  drm/amd/pm: use pm_runtime_get_if_active for debugfs getters
  drm/amd/pm: stop extra checks for runtime pm state
  drm/amd/pm: add sysfs attribute access wrappers
  drm/amd/pm: move private definitions to the .c file
  drm/amd/pm: use pm_runtime_get_if_active in amdgpu_debugfs_sensor_read

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |    9 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  734 +++-------
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h        |   96 --
 .../powerplay/hwmgr/vega20_processpptables.c  |  574 --------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |    5 -
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  433 ------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 1269 -----------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |   14 -
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |   14 -
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |   14 -
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |    1 -
 11 files changed, 208 insertions(+), 2955 deletions(-)

-- 
2.40.1

