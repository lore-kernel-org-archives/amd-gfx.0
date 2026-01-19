Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5917D29C36
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 15:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A4C10E48D;
	Mon, 19 Jan 2026 15:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oa554t01";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012011.outbound.protection.outlook.com
 [40.107.200.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473C210E48D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 15:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clAzaKF4C6Lbiu1e5WwS+r1ee7AAhRpnPM509rNeDBacS7YpOys9ySVogk4/yYuYBfSOIbDyLqiAxp5dvqeeo2+qKFn5EyLL71KIomB0MeNwaOZtyB4OyKPy72IeDM+fXHJV+pYXrz7pmISi96OW2NoChMcgHLjojoaOYgXwJG2XehuDKSuuSoYff6ltjXbQeF74DwjvQfdN9/hwNOSCB/NDha2D3m0vzFlFKLiUuuWkC7dgdOKsHpnm93baLSl72+ku6bVX4i99xmd4RpdVOp+MIUVO7lNKUixPvD9CMSMLD7F5rJcU6qIsGO+NMOS4vGPrS8BVetxjn0C1PA3SaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMDzQkLP4OZ7BvMmKjKrm4NObVDc5hv92MrcMcvcOUQ=;
 b=kN0tlVoON1LltY2wmTcD5w4ojy8Aitdff8BEun+OS5flQpC0B+XjsekYhBia8UeVscJeK5WoDIbRdLZpBrUjPt4gjnMvDTUialJIfKBlp7riWyUL23Cav5jibEZqXqaVJkUZuBITJ2bwhPZeB/lctIFQi/rZbtO+lqbYOJopYIpbYTx0/SEjf4PcDfYJ21tnOB9Az6YzKWoAl2U39wujwiiSD+JAhhJzZa3da6R5853mpFQiGif0QNknUf7eud4iXjeiO6je5WKk4EnsfG0LiZcLo9a8CZ6r8gPij91cKElINhgfBNGD2NWx5kSPnwAQO01yQHQL9RAaHJiV3bhoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMDzQkLP4OZ7BvMmKjKrm4NObVDc5hv92MrcMcvcOUQ=;
 b=oa554t01KXZpZnTr+Co1DxhVXQKb8Kz2UeBfOjbBAvysKZWKfHGrZ3yajC6VpF470Llx05WHA9ZZ8soYspZ7l99VZAVqKZ5wVuLqPXLuaXUDcH7VZXUlg+0QTJtSdaZbV2zB5mWEtHUjZamK1nH230aT9mqICK5idN3AvK77cMI=
Received: from BL1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:208:256::24)
 by DS4PR12MB9684.namprd12.prod.outlook.com (2603:10b6:8:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 15:33:34 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::33) by BL1PR13CA0019.outlook.office365.com
 (2603:10b6:208:256::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Mon,
 19 Jan 2026 15:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 15:33:34 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 09:33:32 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 0/7] Refactor smu feature bit implementation
Date: Mon, 19 Jan 2026 20:58:17 +0530
Message-ID: <20260119153309.1234663-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS4PR12MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc2746d-24c0-4fd6-3a61-08de57701b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uOpBcYtFtp7UUHm5wj5ou77igwM/YPG6Af9QGYAl5+aEJkakHaqJlUI2zq9W?=
 =?us-ascii?Q?Dwhn86mPvrImqGM6HJLHiDq5tPemXYXOy4rDtKZLxiwepZmaVaaAtzhNI/W1?=
 =?us-ascii?Q?o++kYrrIDZ2xtedVIkH8qm9ZKyuUR7qKZMgDNZQ408EuuO7NcMdX9hjRyo8l?=
 =?us-ascii?Q?8rapu3DhvWIKUDsodmcySaT6fco5xeUfUNM1Tm4pQ3XuMMsZk+qZ863laAi4?=
 =?us-ascii?Q?vrtm+4bPQcVCURCbLWi7n3YKZS46NZSBjBUftjMjagNoL4Jzn0VMQ+1kWNhc?=
 =?us-ascii?Q?cla4Y5tarA/+OpCaLQRLoETg42U66f+zDLLv2w7j3dDUrQhM2gDKAulIrgPO?=
 =?us-ascii?Q?yFhVDw17nEtdqcrolCO1niZ6E+CDzeCSKYA8jcaBSxdNaV0msy37Pm7jij+l?=
 =?us-ascii?Q?Q2N7A7gCPI40687z/gw8n0sGpmQaFlKQF7MQp+Fz/2NXGR4hmJvrcWVJndbm?=
 =?us-ascii?Q?GYevdatPAq4KQMihm83osLusVoF6o50PCpROti7hPotBx0z0gUVAe9v1XXme?=
 =?us-ascii?Q?AhPVlvK63H4CSnuDwcr6CgBZ7thB+SbNLXwk4FZBfExlENcM7cbTWuul6BHk?=
 =?us-ascii?Q?XJ0DZMxmRavCXP638Raqsuaxm/euUDlesrN+wJMGpEsVSxffqbqlTLNYCi5l?=
 =?us-ascii?Q?Am1AG+t0QiZhpJ5oAGOWDANW4Y01NM/xMlWPm8KQ3xne0sMNcRCSNETTmdL4?=
 =?us-ascii?Q?yWzl5xaXuv/OrJOUB+yv/73e6b2Z6hM5anPjm/jMfmMcZ2gw3+nIjhwdyeLY?=
 =?us-ascii?Q?llvkYQrGQAkrRw4zpfaPBkIOK45ilv7dK1mv6CtwAoDcy2jhfYI4PKvPmA/l?=
 =?us-ascii?Q?N73nMvIsFYxSJYCwa009Sym+lep5CAyKieMK6/7WcShMCvCTJ5FxuqDRUezk?=
 =?us-ascii?Q?Z2nKSa7fUg8U6XzTFJU+Q275uYBs8IbbI/6lCvAXYStjT5lR17EtbA4P44c1?=
 =?us-ascii?Q?/nDcMyxH6oiwTJ9hptpdjA0rb/7Uod5tOOAIs5aFs6s6fCJH1q9rvFimdAR6?=
 =?us-ascii?Q?NBUBDsC+hpvwIToRoCQcXgjHLTvuL7wQdus2bYV9RmmoxXcKzoA2cF+HcmSS?=
 =?us-ascii?Q?XvQKc7mNK7iunLjRZ5nMHB4RwT9sf7a/WbX3RNwJyzZueqgti4DZazGIZq+v?=
 =?us-ascii?Q?Ot/RhqtziEq59H7GIQZ3nafX+Q1u00zjt83UnppiFyR8OKpSD07tE0yd2jT/?=
 =?us-ascii?Q?/h1UN7CN/VjSIWClM/g4ZmfpRkOMvTQIiEj1SlgiuuKpWrtf6Wa/qj1bBem6?=
 =?us-ascii?Q?l6qIAWcZOyYuPxM8XYZQUvVxp3SjV2aQNASwHCKO3x7ERZej+JN+73n6yMCV?=
 =?us-ascii?Q?nj/x5xdpvUn0g6f/UfhwUPTBsKPTeQDSXnejEsnc8B4ymekQOyk5rck6jK/X?=
 =?us-ascii?Q?2a/PKuIBftPgEFOQv6LmEWJdcKfqVxlD0KCI3bcpZBsNc972RRabUey7q7Jd?=
 =?us-ascii?Q?cGEwrTovZF3tjWCmxvE5CKFKcMW7nSBbAnpvKc2y2xYBE4aCQcmx0XdwlVzl?=
 =?us-ascii?Q?qOfBMv09IxcKPbZL2r7ktbV43M06ArjXEJ9MS6FUbKg2qDv/RCuWFVnAA4yr?=
 =?us-ascii?Q?JbnPz4tTRfGwbS0cDOL6eG6eu5w4m5jhOp5QNX67qKXFq8bfya9/bBAxTxnt?=
 =?us-ascii?Q?RYekV2c6rD9WaUffNbVFAxhu4fIgvB0wYpjTff3MBfo0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 15:33:34.0712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc2746d-24c0-4fd6-3a61-08de57701b6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9684
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

Presently a 64-bit bitmask is used to represent the PM features enabled/supported by SOC. The
number of features has grown to nearly 64 and could extend beyond that. Instead of using a 64-bit
mask, implement a data structure around bitmap and move the implementation to use the datastructure
instead of directly operating on 64-bit bitmask.

Lijo Lazar (7):
  drm/amd/pm: Add smu feature bits data struct
  drm/amd/pm: Add smu feature interface functions
  drm/amd/pm: Remove unused logic in SMUv14.0.2
  drm/amd/pm: Initialize allowed feature list
  drm/amd/pm: Use feature bits data structure
  drm/amd/pm: Change get_enabled_mask signature
  drm/amd/pm: Add default feature number definition

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  48 ++---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 204 +++++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  33 ++-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  24 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 119 +++++-----
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 116 +++++-----
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  29 +--
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |   4 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  37 ++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   6 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  58 +++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  20 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  34 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  29 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  39 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 103 +++++----
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  29 +--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   6 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  33 +--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  69 ++----
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |   6 +-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  |  33 +--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  82 +++----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   2 +-
 26 files changed, 662 insertions(+), 508 deletions(-)

-- 
2.49.0

