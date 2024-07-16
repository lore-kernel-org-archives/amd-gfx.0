Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838F8C3DA4B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 02:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ED6A10E45E;
	Tue, 16 Jul 2024 02:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tYYMogv7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3629B10E345
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 02:31:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buUwqdls7TipMKR28bKUiOCT4EAc7BHCb861f9JvE2qRbw84Tn5yJUKBf4EJT5gLRlZdYylMiRSQQsiOIFQvFbNbW5/sq6tGEasGtNGDtrvxE+QCuQAjDICDSXcntWsLDBtKyzOiLBRkE22Zn8T70/K3APszrJ4P+C5TIz2/p+ZRDkdQrWQB8HzPWV+cjBynTMkhU22JqMYrkFWweBGWIsCCFFFJV3z9LLlLPQOG+qigblA15/Ay6351SXF41NCYOzfHOwaNX57Fimear23VDsG7J8G9TWGDDqv3YzNlBxDOH9q7H/D5nTkdIhWvlYX32WAaAz2NQaCZMaq2/bNVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nzxRvmJQ5PHKAZIKylLqy9YfjoZAB8bDPmr9T/LIrY=;
 b=SziGcX3LciWA5fLDbIq+fU0g8c3xC52qgBY2c8lLYlRrE7tBlPLpq4zieqmnDwTS/4S6PEHRIYhpjcJePWK1x1XKeoEvOijFN3Z4C9XTa4N+lbERhwkIRtd3pQlXxpbM1trU3jOl+T32OKIoJ+o2gBb7uoq+uo3cElmbm9jK/tmbxyCSKa/8YEQJHXCanotsRqicuHnUmK7rycdNY9ImcoMXuUdKkLtWgfnB72ekLmA5fm9thXaTJWzVEMOuzWRaRJGmbY5LJYOYiE6fD8q170onzSYto+t6IhqT9/tFRPc4+HiGj0KDlAeGzutgI4PzK+ulIdKDqmfzfY8ZkT9CYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nzxRvmJQ5PHKAZIKylLqy9YfjoZAB8bDPmr9T/LIrY=;
 b=tYYMogv7s5Meyhp+FfrKQi8uXDCal+vOnIm59adhkDyfeaPqsN+i3A+cMlNc9GvsYy/VZKNHU32ka9YD3eubJETrOZLXcIjmPzn4RF7qErsmmZO43G8dZUdfst3unGvYTc23+h+nvGKIg78j7G1EZVr4QI0cF81d1ehKi9hlrs4=
Received: from BN9P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::14)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 02:31:49 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:10b:cafe::8e) by BN9P223CA0009.outlook.office365.com
 (2603:10b6:408:10b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Tue, 16 Jul 2024 02:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Tue, 16 Jul 2024 02:31:49 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 21:31:47 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>, 
 <Alex.Hung@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 0/6] drm/amd/display: Address kernel doc warnings
Date: Mon, 15 Jul 2024 20:27:22 -0600
Message-ID: <20240716023022.100811-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a3e3dc-4ff5-43cc-7f49-08dca53f71e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cmOv0cFSxTHkca1KNXFTc2oXR8IvuiBYixwC9hfx6Hhh1GdJkq3zNjSKLWAs?=
 =?us-ascii?Q?pWYOBNf6NMgvejo5QNI9vz8bVCPh5IInvxK6BnuvmyXeaTckAGo8x66eFlUI?=
 =?us-ascii?Q?+1TZGCZ9vnVwWCRgZQQtOyf/2bsUSifwZkYzdSb2TxUJnPWodtTmkfAcrqLW?=
 =?us-ascii?Q?FlMRjc9aDoFyuMTV2j0teCaULw12eXR6El4aA74c9b7T5eCpEqcDaEiWdEZc?=
 =?us-ascii?Q?Kaj8MEUaJ4SUu/WP5qt21NlXXFl1dXP7lvYI53wh2NDRvjPJhaeD+OMe11Am?=
 =?us-ascii?Q?aJet+eySuCgxzNdBYlcSz9P5xFhxaRKPDoa4vW2Sk5b1YFjs/LrcYIMBJ0gE?=
 =?us-ascii?Q?u2LK0E3gPgr0O1OSazD6ZDT7upuaoWfVImRz+vztcefXEY1EIkpyFrXzMJzk?=
 =?us-ascii?Q?w/rv8HxPy81n3IUgDaxwpQI7ALVpqoRh74bT8nhryCgsDYyupPh7hpm1lA78?=
 =?us-ascii?Q?Q8E2yFjjhwfIZg29DAPvC48W7/LbW+DS9texCfDFrzF4XcFmTpqjLy99YM+w?=
 =?us-ascii?Q?lxjK/1gHhTp5YtIEGTDjW3FXJM97ADRokVfam9hNLx8weh6SqGDWchw3hxhD?=
 =?us-ascii?Q?7FuP+64Yfk+VI3lbvek1skVrE+yyaOsbhdzI+SAriVD1LTRHdMDlP6N/3UHB?=
 =?us-ascii?Q?qdI2NFrT3d5bqSwVRNbV7EyuuhGiY5CLOWvETWOqDLriNsUgs/LrMPCKBomh?=
 =?us-ascii?Q?gJnL4wsA2iiIVgaI3pIIgGxw1trmFjVQPhzIPKxjmH4T2EAmDuEAnqhofpBy?=
 =?us-ascii?Q?5uBk9KglXlxgDc3AtFYYmV/dYQZd56bYRF2kv1ajvYAwheOTKI56GyvVds7i?=
 =?us-ascii?Q?FBfGMiXi9ohM+UABQWYzP7m0vYjFzTUriHQhAawibkezb3Ek76MGN6tSXkjM?=
 =?us-ascii?Q?qrWUVRiBlOgxQqSyFzDIZr5EjTxZRvCxXzd+qOcJxfcBwAvO1XYUNMbkTthQ?=
 =?us-ascii?Q?CW/hh4+1FmvCY0zfwOuOe9soK+9dNbga5nQcbj9YQEFYdNZaXABy7LPTx+fm?=
 =?us-ascii?Q?pSObTtsoBnn7eaPdUUMjgx7JafuZarj8u3f3YD2ZpfDQbZo1hzhj6NWRgSc7?=
 =?us-ascii?Q?6BxotVjsd0bAmbeTqHUjSyV/Q1Js+mejdfvWzkyOhtWfZSS9Vl20IypTykTC?=
 =?us-ascii?Q?uwr7f+9azce1JalT1+S+cIdqA3wXi++YpSFdt4Mb91RMTvX6d8fFd0di25WO?=
 =?us-ascii?Q?+i4nDDAIwBwQred5cDV2uxIwzBWWbY7Tt+WYKSkZGCZcuyVKLoV2GdmTzvNh?=
 =?us-ascii?Q?eEmTcLuryqmr2ThK+PTClhMHspn4VZFRlvEHA2QiPvQ0MysQWiFSWrHF1Mi4?=
 =?us-ascii?Q?S2AuVJ65gTsLyDAIMPit4oefCAkkN8Dr76fizVEwLunovgU3OfF3NGV94mTF?=
 =?us-ascii?Q?WoOx64mdBfbEMrJ2Raqh8eWRle17KGzgGlaZ64TrFyttcr5pCv6BN3gpbaTG?=
 =?us-ascii?Q?yYeImncuWW77ZzcMqHvOTh0JNyP5Ssrm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 02:31:49.1112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a3e3dc-4ff5-43cc-7f49-08dca53f71e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470
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

This patchset fixes many of the kernel-doc warnings caused by the
display documentation. This series addresses the following warnings:

./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/opp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/opp.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h:1: warning: no structured comments found
./drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h:1: warning: no structured comments found

/home/siqueira/Documents/Repositories/kernels/amd-next_dal-dev/Documentation/gpu/amdgpu/display/display-manager:134: ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:3: WARNING: Duplicate C declaration, also defined at gpu/amdgpu/display/dcn-blocks:101.
Declaration is '.. c:struct:: mpcc_blnd_cfg'.
/home/siqueira/Documents/Repositories/kernels/amd-next_dal-dev/Documentation/gpu/amdgpu/display/display-manager:146: ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:3: WARNING: Duplicate C declaration, also defined at gpu/amdgpu/display/dcn-blocks:3.
Declaration is '.. c:enum:: mpcc_alpha_blend_mode'.
/home/siqueira/Documents/Repositories/kernels/amd-next_dal-dev/Documentation/gpu/amdgpu/display/display-manager.rst:3: WARNING: Duplicate C declaration, also defined at gpu/amdgpu/display/dcn-blocks:101.
Declaration is '.. c:struct:: mpcc_blnd_cfg'.
/home/siqueira/Documents/Repositories/kernels/amd-next_dal-dev/Documentation/gpu/amdgpu/display/display-manager.rst:3: WARNING: Duplicate C declaration, also defined at gpu/amdgpu/display/dcn-blocks:3.
Declaration is '.. c:enum:: mpcc_alpha_blend_mode'.

I tested it on amd-staging-drm-next.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks
Siqueira


Rodrigo Siqueira (6):
  drm/amd/display: Move DIO documentation to the right place
  Documentation/gpu: Remove ':export:' option from DCN documentation
  Documentation/gpu: Adjust DCN documentation paths
  drm/amd/display: Add simple struct doc to remove doc build warning
  Documentation/gpu: Remove undocumented files from dcn-blockshubbub.h
  Documentation/amdgpu: Fix duplicate declaration

 .../gpu/amdgpu/display/dcn-blocks.rst         | 35 ++++---------------
 .../gpu/amdgpu/display/display-manager.rst    |  4 +--
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   | 22 +++++++++---
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   | 15 ++++++++
 .../amd/display/dc/link/hwss/link_hwss_dio.c  | 29 +++++++++++++++
 .../amd/display/dc/link/hwss/link_hwss_dio.h  |  9 -----
 6 files changed, 69 insertions(+), 45 deletions(-)

-- 
2.43.0

