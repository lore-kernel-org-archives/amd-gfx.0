Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F14AC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 13:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1A810E489;
	Tue, 22 Sep 2026 13:54:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y7SMHoXO";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBD010ED02
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 13:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2p6xZKVmtwD2wszhcFonK3K+fYVY5T8N4q5aoGqmktFcUkgtAv6BYHmwpTA/Sw37+6JrYtW0PPEvbY2w8ermIYNYG6Fo1PmDnBUe1nvpQi35zegXKBLSTXh9yB7S84QjgJfoIWdG5AThPSDTaI1ZjTvesC7Jq13Ig3Q2sJ0XMZYI23hggLdLTxxkwy/1yTizgBWnn4yDQINPtPyyIpkKSMk9pJ2CR2DnWYdZArLeoAruziBnRX3yqYDDMnKrWSf/v1N73iEDuQpHquJv3bteomhk6uKhbMl5bNJCJStlFPGgoVNaE+g/FM7eUSoW32a0aXwqASVz0NaBM+tv05bSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yi6F3cevXN2aGP9PWIeMQeTE+RijFpfn69guEOKA9U4=;
 b=UeonHhSZjlx1RCjxqOkGVzSRpdOca41ccf0a59I5lG+UecbX82HNU8T9Qg3gUFXNnIiQ+koIYbQWOnC1f5pSAihc6JlRmm0W4i8KxR5TC5ws01KQH/+IEB2z8CO3khLUscysoPsLjv2keAsMt5Jr1MhuI42ih2TeSuDtEQlpRRhyTarcD3TPXHZrmqLI7OfJebhef58S3p39/9/1/Eio3PMdeBnwR7GwnmtRaDsiGGUXwbnzlFUuYG54bhV2XecKpzH0y/bZqfERBfz6jxIs6RYw7rTjJV0twG7xUvLJNsnz4410eH78BvmcwHXqYl1iPQkxaTfDYtwSF0jCSAnI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yi6F3cevXN2aGP9PWIeMQeTE+RijFpfn69guEOKA9U4=;
 b=y7SMHoXOyFTdjQvDMR5l/wSjVuzmNypZ+yC+5Xk05vcvCXppzrIu2jZDv2JDRUPHn5RWQDMtU461t+RVSoyB/BDaf/USL1qPmWP2ErGzZATBzWji0c5VWuGgoAM8BLwaZGWer90OnH+fMBS0ntsW6maPgA2gbCB3Tzw8L3N1rjc=
Received: from SJ0PR13CA0228.namprd13.prod.outlook.com (2603:10b6:a03:2c1::23)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 13:54:41 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::9e) by SJ0PR13CA0228.outlook.office365.com
 (2603:10b6:a03:2c1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 13:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 13:54:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 08:54:39 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 08:54:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/2] LSDMA v8.0.1 support
Date: Tue, 22 Sep 2026 09:54:18 -0400
Message-ID: <20260922135419.2145987-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: ae508a0a-505f-4f55-7ba7-08df18b10c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: +fdVWB2l3+YSsn0P3nNPA1B+QhGptDDEAiTYG6U52kl+r1DaGMkgN4nqUjuyBFv41lLG9AhNp5kZMR7qjNSdVz42M0mAc60bmnfcIxdhGA0Ai7daTsE6lXXov1lxCSe0coM1etKnKnzpvCf2VWBddczN91pAOgHXHhUbizLGz5GwPa9aVcv8S6ssOyOMgqA6z09OpuziA0nLeIq24MbXzi2QVieltwGR27hL9nL+wEeByOMm+ZWiuZUID2t4xXyw1kewlZBHBs/xndZ5/i3dLGQ+FjH2VyRyrgz63mKmlxG5dEuGfo8kRtYc1Rs95i1Szc9Hp40XVBQMDW5Co4hO1IaeVxp22a6447ECbhgLYafV2oTYiehzeIyrv8rpfEg9u+PvIjrngeVRkwHBnn5OHw2t/ohVi2tRQbFxCwPPu11KvsJ6IdhnozRbPZOHOFQuCy9vci5CLmlF7zE/Uj1/VKrbnTciKwvZEDM+IObUcOGcEyYIpTbvcdwvuujqhlhmDTdO/ToX1QEs1EznwjArYVcxlhs/0WrauSUoEFLSHWArDFuHjuV+dvmzVtaHzSnXExdF1b+FXnHkBi0R5qnHG03f0Tj13KSgJLCqyqh3NJhSZd3RJzB+6sDmsCBgLW2IartnDEXUnoArz1u61YNOSsCDGalFeGevzxKGptw0ibZUNDLbfgSGwxPbmTDz3iyC1E/C1uJHD7M4qpy5fge/Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qTanQWAayycv7vDlPbECIeQiUu+7RJUIehcXgJcZH53u6H2ogsNsFMT1fGqvNgZ3wRLcjonnSLgphJBtDSJESDFEScABFDip4LRlYc/oDIZNBG5Cw7WYkeE7Yll0JwN8lRbmgfZ1Na2QqiIjtp5teIItQlkV0rR1A2dJLL4T+I+UHw3GDbdvoME+sBTQFDpV+T1yDvEkmI6sMwO+80c+sldF1143ZMPKpynbttMxqKAvWffEuU30mMIEQso0cM620F40pAKFwPexOEJthEaBtU/xkGtA9hADA9M6K9N6WIG1ZjC4zBRSt0El8V02kkTFFEXhvwPPPYMbcaw5WrKC4O+yx4SWHo2Btw/S3uxaUsSntqvV/osId8IjhExtuHOFdAPhDMbOW4HJ5RqUAJ8O3Nc7i/Oc4aa2etkzzZAIr+wfLIcOnlme6FskzoioKsrA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 13:54:40.7505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae508a0a-505f-4f55-7ba7-08df18b10c8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
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

Add LSDMA v8.0.1 support.  First patch is register headers.
Skipping to avoid spamming the list.

Hawking Zhang (1):
  drm/amdgpu: Add lsdma v8_0_1 ip headers

Likun Gao (1):
  drm/amdgpu: add support for lsdma v8

 drivers/gpu/drm/amd/amdgpu/Makefile           |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    4 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c       |  113 ++
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h       |   31 +
 .../asic_reg/lsdma/lsdma_8_0_1_offset.h       |  385 +++++
 .../asic_reg/lsdma/lsdma_8_0_1_sh_mask.h      | 1399 +++++++++++++++++
 6 files changed, 1933 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_8_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_8_0_1_sh_mask.h

-- 
2.55.0

