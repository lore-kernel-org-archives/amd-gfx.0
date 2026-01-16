Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE13C982FE
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 20:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAEB310E929;
	Fri, 16 Jan 2026 20:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PMMbLXgq";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0A010E929
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 20:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+2ATraprTBeg1gQBQmN0GzVO9+5BSnjHe7dtvt8AMkxwpB21UIikcbxNBRbWIhWTxIQu3YlUXGNddlmYjD9rF0d6zkIKY/u3OzABZ1D+CqvrDlPROF+3yDy6r6UzONy2sd53Zo5TjBgpuarSd35J0UB7Gzj5P+7RjlJSXWbLvNoqaTlP36im1uqeOnjvvDsnfHgxHpF+HH7yScBEqKrltIbGId/JbD7YyI98peM+7KJu89PJja3o9EOarecBA5/6X75apUW4yk7N/zLLZo4Yuzlsbsr656QniHH12vxjfT7ejSROVsaVF5i90um1EX3KaYfDLZOqaDDh6EohC0q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUjPd4KPdvvGgBMhFCgzu+3hlbTKs1eewHuMie+0Jho=;
 b=hA6NIrQLtdH+u/GtYrsxX2cNUP9XQMwKbJ8koQmtneOcySyLYzAXFW+hyxhzjBbaz1doK6KhmCt4ksR3500KuTxxtq8Tob0pnSdl7A1h8wk5MJRT4QlIvFpiuUF0UxumW/5go4ILVqJh1mpx3k8YsIhraLOwoTOYEvHEvoC6iJGD9xrlQTZ15AMb2ymccZ5GSAhWEEP9oHLlSMNTp/6oH3z1c68VWtwzrB4CO4Dl+dVkmUiDHZ2cyLAejXpfKlfK4TyaZ+QFxuSKIKTObVBG7ZT3KHJ/Q5slDaVT7riBi9P9unA2ykQkyApBNTOrfdpvlPdWDFaHANlqEatRVeehOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUjPd4KPdvvGgBMhFCgzu+3hlbTKs1eewHuMie+0Jho=;
 b=PMMbLXgq4SHlqmt5pBUDxtatv5bCP/pxv/FvnPf29fHhcFJrRClxVg8yXDq0X+EMGUtATYet2SYTcCq1lbaKjdWrhrM+v752yVXlb4758MTi/ww04RD6PVfF9J5AA1Zt0WNVNrUYkxtdywoWlyVyVjp2u9wzjielnZkIjg/dOMA=
Received: from BN9PR03CA0291.namprd03.prod.outlook.com (2603:10b6:408:f5::26)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 20:40:17 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::2) by BN9PR03CA0291.outlook.office365.com
 (2603:10b6:408:f5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 20:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 20:40:16 +0000
Received: from jc-d.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 14:40:14 -0600
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>
Subject: [PATCH 0/5] drm/amdkfd: Trap handler fixes and gfx12.1 support
Date: Fri, 16 Jan 2026 14:39:27 -0600
Message-ID: <20260116203932.988704-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d4b6ec-ad81-4128-dc30-08de553f74e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MuUudVs3wyQF6uIGqcjeU2dF1Po6Mk4EePM92NZALN/AQXtuIw9B8ioviEil?=
 =?us-ascii?Q?MtkDG3Wu8Y3oCljKOTgtKW5uhR8DS+8ERd4om7ntBUP8fUoAHg6tGShFS3Yr?=
 =?us-ascii?Q?V0Tif6thjBY4g+Ybnuq+tcMfST5cGIyCSd0Ft66o5cppKUQucUHpOTiysfK8?=
 =?us-ascii?Q?dqW/vHFvc84andGrageDlWSX19O+REpliLSL94tGKrmOKedwgqnSuKdNsu69?=
 =?us-ascii?Q?y3e1KZqbQinP4Ctn7fBLFSMNMYnlGuSaEEYkpQ3kJIQhmgqI2rxRIeT0d1s/?=
 =?us-ascii?Q?59xz6bSPA1desV70T1cGgebPAAzA5KwyapYDJ014veAbZcFS9Fopk9OPFot8?=
 =?us-ascii?Q?4XY9XCQ/bKKWGANpjx7lVh2qWWfQ4DqMLksHl9s0eH4ldjGGnCeB6yMiisTq?=
 =?us-ascii?Q?NvnfSSBA2b1v82h5EmSDDLS3sXUSaUBu29eBtK1JhSG+t7ezw45jvSnTewTS?=
 =?us-ascii?Q?9V9iV1suOj6jGILZQgkQ/e25YNCxpEpoiXDbZ4FuYcJYu99wslBUDuL4QLp+?=
 =?us-ascii?Q?lgwRAH6vNbNgLQadyh6ckr0vaxB6EkZXOd31/uIkqgkaNZtkE55XxqpiLySz?=
 =?us-ascii?Q?JmTLt8P1TCd/KWhduYuOrAuBgaoJk7Sikvbmd9D4EwrLxTWi9zEL5giqAHJf?=
 =?us-ascii?Q?dlaLhCHqZtKgD+j/dc6xKrvwcg9Qrm7wyorCaV8Ee3TmFeM2nnDo5ePzASAi?=
 =?us-ascii?Q?80vl7RfLpQEX6eQgwhMa87vbBV5OlR82iXDRDSHIgYV+FjaCfqK5im4xACNn?=
 =?us-ascii?Q?QOdPRM/+Ch2QngA0jko0XfrpEBxQ8Jx9TSdO4nESw4yH74tJbcmz06LVU9zl?=
 =?us-ascii?Q?Db7bqKVwqV/solH1fEWbzbmsLZ/9nymRhKomNyV6mTmw0QitWulwczwD303j?=
 =?us-ascii?Q?pLtaOxvySVAhC3qKvwGDgbZRd9kS44iYD4C/tALu3n63eUm59la/2KxRDuVY?=
 =?us-ascii?Q?DMfgW7zlFoO3pJvcKwRGwPj3wSxN+ZByr13DkqTM6FDc1CrObjRqIflYAKle?=
 =?us-ascii?Q?6BJygLxCU83ywWHENQuVCtuDiAYaF0g2mQ5K9WzoiB+KRnOtI5ubMHr/f9LF?=
 =?us-ascii?Q?yvNAIrDKWr57B9pNM5G6G2jNaUSLsg9MGHVFCvZNq+wUTfjt6oM0ncaypfCo?=
 =?us-ascii?Q?jjdazpPl/06aobmDj26qYZJIqNjLOI8zCapsY+IXqH+joOIqiXJy1TD/bFhY?=
 =?us-ascii?Q?V+vgnLCGj8ty+57fagdXRq/K95OtKGW8DfYmK9c574fagJrBObvbymWymEZU?=
 =?us-ascii?Q?A1heRJ2MszGUgUvGkLc2/3fJzdy/AN8nSFX0zXvhym8LNFI6P6dyvo4aUnnU?=
 =?us-ascii?Q?GsUfwJ5c7bK65IN+0GOGdjVxrQXL9TGX3vMgyccgkJSdliQHrKrTtVoTho8A?=
 =?us-ascii?Q?vlCJF6iZIq3vTwdlbVhWgHvGBa8c0jKbp3pU0qZVWjvA3KSfdZQ6cz87Dx5o?=
 =?us-ascii?Q?zwCL0xfTXHGtnqUyP+DKeJzgoGJJNzB/Xq6e9hX/+Tg/oeBU0GejPpIhpvw6?=
 =?us-ascii?Q?1hihtbLswwuaWflhQS2WzBmzROqOBqkevhVe0vjXLf9e9wN/MrstLFlbRd19?=
 =?us-ascii?Q?acd8IAEabb2QD6SVF7Mknh5qqeWW7ZpEQkYxh4bnbIwB4AGQ3BmwE0XKZwkh?=
 =?us-ascii?Q?VcN2oe6G94bls7Fw6r0nqhCqYv+EdhJZgo4+2Di56Exw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 20:40:16.5436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d4b6ec-ad81-4128-dc30-08de553f74e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
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

Fix a broken merge and upstream missing gfx12.1 changes.

Jay Cornwall (4):
  drm/amdkfd: Sync trap handler binary with source
  drm/amdkfd: Fix scalar load ordering in gfx12.1 trap handler
  drm/amdkfd: gfx12.1 cluster barrier context save workaround
  drm/amdkfd: gfx12.1 trap handler support for expert scheduling mode

Lancelot Six (1):
  drm/amdkfd: Do not include VGPR MSBs in saved PC during save

 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 1435 ++++++++---------
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |   73 +-
 2 files changed, 744 insertions(+), 764 deletions(-)

-- 
2.34.1

