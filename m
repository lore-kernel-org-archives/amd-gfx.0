Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E754D6ED28
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC17810E92B;
	Thu, 21 Nov 2024 13:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AdsmZ5vj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3950E10E92B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOuixAWLcwbTs6Q+t9q3bw3K5bI0cPEInfLQpLwUvrJzNR/6Kg6kthfq9Xnj4rWIrKEG1Ez81uDHKd/rsalQ1Bx1MCDxyyDdrBEI5RNIu8K4kXyVNM6P6I9odqgfzQueCuKMTClAN6Sa4hcpap3uMNqBhKHEvIWSYrvYR9cIRuZzQTvkkkJ1zeD9XE2F3j9gvhxNWBMoQiQusIWM/0sCXjlnFkOmh2KB02nBJFIh3a4mxJVSfJU+ED26lASkSoDqNycqTsKTOJ8VqR3GxiLFF1SU0+Y96nhNLhtjDJzlrsRF9UYHseUsE/UQ7h64xcVsHrYxfkLbQGC2RqnOIfOvjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwk2ZDvGsKHVr0mteA04DarBWq112Q/wBzf5FcptsO4=;
 b=Qz1UyT6z4ZLnXF97zIeavrnE3FriOl9SpfWVDQHNnkuAD+Fm2fiVreQsqlmTvvkkoM1zOU6fLIySoo7HEWIsPeP1fQflGC1azMqr9VfQHB95CtB6IcQ4zLgim9Ms/ghFhwItmcYchhGQg1aUvDdI0vvM31+/AdTTK+TxKBE156CJIovDxA5aceFqSaMsJuVOqGcwbC5m4bIZU2jW1GRi/O9of59uzro8pk3GhfX9Ge5V6eDx6zUlRVahM+w/sjNM78In4DrYfDSiD9Uq21TpD9qsxPZvgV+xVjbbJpA0QrkdcgHken9o70CTtSP9jxn0tPNU9Ct4Ln4TUFXtv/YkuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwk2ZDvGsKHVr0mteA04DarBWq112Q/wBzf5FcptsO4=;
 b=AdsmZ5vjb4wdGzK48HqDSS70LbCaupsX6CSm9J8xzoh6NSJTXYK9pUgds7+KLt+dJbsVdPiQqxFNQuyn3qN3WCm93pIaoaA1/YSRNPaQv8sY5lRhge6G0iD8uDzg19raKuVCd8NcFoK5XDpMFK3ZWerDJML3kIAPh82sOUd0mss=
Received: from SJ0PR13CA0212.namprd13.prod.outlook.com (2603:10b6:a03:2c1::7)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 13:11:23 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::14) by SJ0PR13CA0212.outlook.office365.com
 (2603:10b6:a03:2c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14 via Frontend
 Transport; Thu, 21 Nov 2024 13:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:11:22 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:11:20 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH 0/9] AMDGPU Usermode queue support for Navi4X
Date: Thu, 21 Nov 2024 14:10:46 +0100
Message-ID: <20241121131055.535-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|IA1PR12MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e11ad3-cf9c-4a3c-ed0c-08dd0a2dfef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?utBhCLhT4zs1kav9Zd2ektNW+328FCQq+B/hGxn3geWr5zCGRMw2bcm01IVP?=
 =?us-ascii?Q?8MEZJhMrOE5MUirRWrEdI4hmWUHTLdOc8OodpZQ8CQObzfOgU8WPZyu/gup2?=
 =?us-ascii?Q?cN6/OHnb5EF+7BKZGK33gTZ9BxlL/p9IetDdsbr0q9VzS5zINpTFj3hVzUWD?=
 =?us-ascii?Q?+EYZEzqIwmgZjSwu01tdtjvyH5lBFLjTWU8cdDs/1eaPlsuOKHZbQxO1BxZO?=
 =?us-ascii?Q?wi5esWKqwaUDzEWKmLjUtMT9i1C2ZA9r500TPnudDm26aIZbT7OOhGRjZmMA?=
 =?us-ascii?Q?LhGn6D/58be3XTkp1YLLbiTlJD+M2+DhVuQdMnNoi23Q9c/3DScuhQcNjoWB?=
 =?us-ascii?Q?wZJDzzTMisTH5KbYRfiBY62Y7LIuBpEbZI//Wl0htOtd/ZjCHKdVgNUms8/T?=
 =?us-ascii?Q?+4it2WZHanQwCOIhBP1d84qXOfqPvFPoOLM1QtosX1HbYSSa6ZIPUGmB00hk?=
 =?us-ascii?Q?QVk4QrxbwPDCcsRMVgc0360auYsk1SCESmcEQnRv4X92l926C9UidTY01hgH?=
 =?us-ascii?Q?wlQH7OTXTSW2kWAjXyf5s90+Fj+WEWLk7usX1eue5eefnmIOnMgwK8l/nN1d?=
 =?us-ascii?Q?qn+qNbkDBXcxznny7f+Gu81hF1gWWXsZ3AFEBdTrorw8GynjJdJyPAGdEWBI?=
 =?us-ascii?Q?zNJA7NBDAtr3woiE96zCQf5rQVEnKqOU/xbJZuqkoZnNVkmXUH0rzHGjDtbG?=
 =?us-ascii?Q?B1IGikQcuM4bcHYLDIfwCWGFGByWqGsiJApCik/W7+nqiRv4V9vESSXU8/66?=
 =?us-ascii?Q?UMl1wWOWIVj/vtP8Vt97htrG/Fn0brbfaoRQtk1xwfFJbsWFEMHVLXZBEFCM?=
 =?us-ascii?Q?PBBrTsjyvrwSm7e8nmD3DMq7srHVcFBGcmZNGIFhNRqp8T1PupNJmVi+q59g?=
 =?us-ascii?Q?/9Kzl6Wt+gOuRc/anJYANfFogBQMsP6FTgw9So/Pw9Dc1ACtAnXTsyaZh1xE?=
 =?us-ascii?Q?A36OHMe8LtgiZY8KM1b0/JdMGV+Me3p3Q4Q3IwapXJszNOvJXS7KlZijqNuM?=
 =?us-ascii?Q?p0m5AtQhWhGfuwiEP8IWhM2mS0WR+6lYvt9UdGAcalg5IkYUFLF3tTcMuBS6?=
 =?us-ascii?Q?Gl34R2MxcjzxSkElukfMUrLTypZWsJG5I07ZPYO9omDqHgkNmd3z38kW6AXB?=
 =?us-ascii?Q?S5EmTVmtI7ib47Ppz+66JGAv32pywiIiSJuCst4RATqdy4jV7CoerIoP0Acv?=
 =?us-ascii?Q?rYJEaMGOB9bJmPh1iE3jqiOt/Gk6z7bNh/uWFn9QURBmsDdHhP22W3jQW7lr?=
 =?us-ascii?Q?67B4Y22U9mD5fHVmHXqtLOalZs7yDFPasDHGy03g7TS/Upn28KYcBQ37/SKU?=
 =?us-ascii?Q?ytxKSboL98gd3eAqcZ7G52pkVzMGy4DFn5NtsG4KlTFkPJDaLrfYVQaFsi0N?=
 =?us-ascii?Q?pMe8ob3ys8heRgkXnBtt1Yuq/wjcY8EO2Qaa/P06VrJBUFsGXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:11:22.2004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e11ad3-cf9c-4a3c-ed0c-08dd0a2dfef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640
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

This patch series adds code to support Usermode queue on Navi 4X.
Most of the base usermode queue code (for Navi 3X) is already merged
into amd-staging-drm-next, this patch series does some clean-up to make
this code generic and reuse the existing framework for Navi 4X as well. 

Alex Deucher (7):
  drm/amdgpu: add some additional members to amdgpu_mqd_prop
  drm/amdgpu/gfx11: update mqd init for UQ
  drm/amdgpu/gfx12: update mqd init for UQ
  drm/amdgpu/sdma6: update mqd init for UQ
  drm/amdgpu/sdma7: update mqd init for UQ
  drm/amdgpu/uq: remove gfx11 specifics from UQ setup
  drm/amdgpu/uq: make MES UQ setup generic

Arunpravin Paneer Selvam (1):
  drm/amdgpu: enable userqueue secure semaphore for GFX 12

Somalapuram Amaranath (1):
  drm/amdgpu: enable userqueue support for GFX12

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  20 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  38 +++--
 ...{mes_v11_0_userqueue.c => mes_userqueue.c} | 143 ++++++++----------
 ...{mes_v11_0_userqueue.h => mes_userqueue.h} |   6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   7 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |   9 ++
 drivers/gpu/drm/amd/include/v12_structs.h     |   4 +-
 9 files changed, 126 insertions(+), 107 deletions(-)
 rename drivers/gpu/drm/amd/amdgpu/{mes_v11_0_userqueue.c => mes_userqueue.c} (78%)
 rename drivers/gpu/drm/amd/amdgpu/{mes_v11_0_userqueue.h => mes_userqueue.h} (91%)

-- 
2.46.2

