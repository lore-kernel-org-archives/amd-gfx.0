Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AA5CF34D0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 15:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1DCB10E655;
	Wed, 19 Nov 2025 15:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y9p5leuZ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A4C10E651
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 15:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQCP7tn5ouW+yPQ9J3A0hNlCLYnjkbfp2TpHz78RD43VrEo3Z6sNgIjMlx/W3BZqa5WBR+Ec8/+YgZqGwVBnsHhx4pY5+zlMwLstWw/VWQcUE1vdffskBUhmFnE2kxXJ8jaCDymRqG14olhJnOCGgFcXXFM3NEd90Hha/lQlztaGMTd4uHbNQHLDwu31dVr+rNO6YuAMA9pPn1+KnHzWDGvEmlQjBjtmCQB9uOymP4GDy+pwdk54+UM8EWNUd+Q+Sz1Va2vcIG0YIZEemu/ZBQTQwfRJxvjSd6/OOYo6CRr68z3QOJsyA3FN+BD5L1p42ldpddaqwhloOSjmBuXJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06Mg17Y7V3einS1NshRN81KkaPmADVXBPGJmOXCqw1U=;
 b=j687vrFPAJ15pVbvOd5BIwpkefWvnvnjHgwmQa4R5BCsOc6HxcLDdk000wUi0xWF9RkkFGbGb7ruBgO25kagwGvtGjFGySrxBtaIDWOojAB3+UZZwTZWxCt+I/8LDDb28BIC5ny15VZ9FNQ/t+bIHIHxqn8tPIRtU7vrw5YR6rAsD1WrPHLr6c5fEhQXHFrDOpSiopmp+oZe4QtNrUqxnOTzUKB4um+TNso1DoEF6U0aPyTmPQQVMc8nRCV2UOZTyeGnbzJ+soCgdyBHKg+lk6TJ4HbCfGABpITVx8nBAS8ch77oSVPoByStFyzqb3tDDGc4TZ0kRDzO0F4BnGG2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06Mg17Y7V3einS1NshRN81KkaPmADVXBPGJmOXCqw1U=;
 b=y9p5leuZbjMSLbH0GEWgvUzdhn3/91U9i3iO2LvNrcUZUZu6ZHKJmxL60Np6SGMKpZG71bpCuTs6s/LmMRHAFUleN7/OPx1SzgDt73W7B44FTZdFV5Eq6B2erhaY1IOhFYWzoGS9i+setMtv9P8BrWPp3DNFZjnvXYGnX5MJ5hk=
Received: from BN9PR03CA0727.namprd03.prod.outlook.com (2603:10b6:408:110::12)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:06:16 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::7c) by BN9PR03CA0727.outlook.office365.com
 (2603:10b6:408:110::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Wed,
 19 Nov 2025 15:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 15:06:13 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 07:06:13 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/7] Add gmc 12.1 support
Date: Wed, 19 Nov 2025 10:05:53 -0500
Message-ID: <20251119150600.3663611-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|CYYPR12MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2a0cee-d040-46db-c4db-08de277d2e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CX4YWAHw53iAas6rV8Ns38/lRysRtEm4jQx/GbWD5XdkjqvLIPvidT7TBGk5?=
 =?us-ascii?Q?uvAQpyXHZT5hn5sMaWF1vcH7CxF8trG6p+dW5+kdYFwLJXVD3MpbSmkvL44X?=
 =?us-ascii?Q?bd3XcgTmdJ6fhAxukFCU5zMupOZDHAmDL3IWaSfZ7XXcKHRTA/vAv+HaO0AV?=
 =?us-ascii?Q?ItxRvWe4IzBk5eqvf6amLdEOKY7gUF/5DcOcYql3IHaN3DVSa8W6hVocsacN?=
 =?us-ascii?Q?X/tXHXxrNz+fDKw+y5PEY5R3rqQxeK0IyTji/K/4LB91KcR/SJyvrt8BsGbF?=
 =?us-ascii?Q?8C1Dt+8SxzClZ4jVCHNS+cbS/3qkUwUp89HWJF6+wkGgoSIM54VE0/vsA1aj?=
 =?us-ascii?Q?muw8wvZGrdLSRQINoI4sjoS7Y1HXNKhveh/ODDusnHmAiqCXlK+g1w8vCQYT?=
 =?us-ascii?Q?McdXQU7ZpXwBPP4nbVNJHUhIINLEJmXTPUGHq3nsryw3JHfiCnlQbroZ8WvF?=
 =?us-ascii?Q?NIHzGjAZ9+RVKk5i79ByR1aWR5CsDC6i45mq4oV6vTfaD3gAnXWoHYoTdAC7?=
 =?us-ascii?Q?S66yscahpeV9nK3L4hVYQLw4BzNrzS8CxVn0270ruJ5K6j7yN3rBkgegw2oS?=
 =?us-ascii?Q?2/MnNPTEHU268yWBbRg/q0s7VcCO+zUjy+gdkJCerCzyJ0Wu51qQhaduDTg/?=
 =?us-ascii?Q?mPcAu0etacBFAtAsiCsDcZMHaRk5jzQaovpkRu4nc6UYQR4pWSyX4E9Y2/aD?=
 =?us-ascii?Q?F8JSH9RjKHvWTRXRavQwNMt+lD2kCPMfuz1zW19p1/27qA4t/nEDwtJMqYNh?=
 =?us-ascii?Q?X49RIwL4WrW2se9c4jAvG7r+sxjn9bTJN6Wb9ZzBWo2yfR5D936Yh6J9qoBH?=
 =?us-ascii?Q?pgAgdpqB2wD3+/5o+ea/bmsdcl+juzyE7/Z//hVEywkEBmzPmKF7+xuBA8ZN?=
 =?us-ascii?Q?SEZYsxBeRGOzNV55joZcrktDt6i3NfG/yL91KPBoQK6BdsfzAdUAYLNqrkt/?=
 =?us-ascii?Q?np8YNkRVaFGwmk/VZbxySqP88aLr1aPslSCbNbu6RfrkPi2VATid+W2xSOZn?=
 =?us-ascii?Q?oXgSx/AuM3nXKUeowk+/33sWjm/MPrXxApwmxZfaLRR9X+tuvT7ckaUyWJOl?=
 =?us-ascii?Q?/lMJzjlRIFbPvj8uEVapQhOoURcrZhMxCLl/azSD2vg5NpFm5XzaKRAZmIum?=
 =?us-ascii?Q?WIUihGoIEK0G3xacwYMXEF1zhpwiUkns50UPY48oudAysattdeifxyG/iv7Y?=
 =?us-ascii?Q?u8vIxzM3sfPRuHKeUnFqDKnlOBJkSI/cjC5FCC2R6Hwe85/6SYZ6zqAu5TtX?=
 =?us-ascii?Q?aBcWk5NSEPHlTR0UAsBXF5ctZbmfJBWCpLOAqEGaDCiIMRjeK/ue3jL6F4Eg?=
 =?us-ascii?Q?SDvU9Va8Wo31e9ryZX+mG67A1mFca7zuzxI3cX66JrLlp7byv5pVUmjx3rLu?=
 =?us-ascii?Q?K75IJf7BXh7WuiXfG0304WLyQaVQ6vxKS6WIUS92sLS016QqW7RqmpVLlWcJ?=
 =?us-ascii?Q?kgYefLAhXHML7Okzzr5SVs1GGqsRMiUheaMVQ/wyclcfQCcdL6ryFmjVrJCn?=
 =?us-ascii?Q?uhORi7XaNjUtC9elax+lPofonMH9dwLeMiNubz87XYl3RE6ojEI9amtLTKgK?=
 =?us-ascii?Q?gP5b2iK8/m8KWRuUQxM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:06:13.7406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2a0cee-d040-46db-c4db-08de277d2e81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731
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

Add GMC (graphics memory controller) 12.1 support.
This depends on the mmhub 4.2 and gfxhub 12.1
patches.

Hawking Zhang (1):
  drm/amdgpu: Add gmc v12_1 gmc callbacks

Likun Gao (2):
  drm/amdgpu: Add gmc v12_1 support
  drm/amdgpu: Add gmc v12_1_0 to discovery list

Mukul Joshi (4):
  drm/amdgpu: Add per-ASIC PTE init flag
  drm/amdgpu: Always set snoop bit in PDE on GFX 12.1
  drm/amdgpu: Enable PDE.C usage on GFX 12.1
  drm/amdkfd: Fix PTE clearing during SVM unmap on GFX 12.1

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c     |  16 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  45 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c        | 325 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h        |  29 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |   2 +-
 9 files changed, 402 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h

-- 
2.51.1

