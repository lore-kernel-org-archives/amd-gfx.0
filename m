Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64241CFA44F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 22:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0098110E0D0;
	Thu, 20 Nov 2025 22:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RC0zQ8BY";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7CD810E0F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 22:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a80LokVvQo/j3QQ1Zj0jVLeTSB6PbOe2NvXCqknQKZfO2rTZ3N6QjkphCMxE3n/G4I9J7yqH8dDpGWvksZaWsucL39Tw5GPeFc2TBK435iF+//l74pQmrRD2vyk1+ifMGuxXcbBodf0iVxqgbRs7hIM4RGb9c7aivpo/BTIRuqcWKUsr5YHwBuacjx/ayTf4c6LHKHCnJ7u3eLbn5OiBMxnzZBLJGF/ic5lLE1w9dNTZGj0iqw7uys/rp+ZMzAxGgEMvEjUcFP2i5sVigvtyYaDRJwPgZzUZ4ATnpGKZzXIBc17AEZ7BHhzqRbPVv1xAaxxRx5kTVWrORwbSzTdUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ydT/RLFa/2hiSGq6UdLmF8d1TPs+aQW2laWtNdFFfg=;
 b=dRbJlEl1ByF2H0lhRmm7+bJCLanI653hgPFegJIJzLlfkt9tYcAFmJOSG+f3FiurFhlIAQi9esap69po9F0xhe5cpNUsRKka61mdoVKcUpA6vMiyIR81waG3ah66QnnEn4uGFztbEu26m87gWMu7YUINYAwZlufWwIGOteWi8nttIfiLEdM2gvvnqfGzvX2MTQVH7jB1X/PG9QMQg4tTfwalQbYBCds24bqTdjhF1sN8ZKCu0LJP6SeSMpNDINfKeKx+BnfahgiECBd/PSVWvZiJ3MlY0bMnZBuUHD3Jc9LMXm7YuKAdpPchdg+Ah3fF1Tl5CIXAs40x6cCTGAJGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ydT/RLFa/2hiSGq6UdLmF8d1TPs+aQW2laWtNdFFfg=;
 b=RC0zQ8BYO7w1xlrycHs7CMTlzFGZyLdz6ANvIfsQ7enQQDAesJxPuQL6Mm/50NeI+otvjaG1WhPXz7fCNSPPq2gIXwsWg6qO6hBfM2SWHboWoKBFev+Vnt69QPfKFlzqJhMfp5+DCejNxu7UN/E6JkD76KFWoZNE2HGH2z+6EL4=
Received: from BL1P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::21)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 22:52:06 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::76) by BL1P223CA0016.outlook.office365.com
 (2603:10b6:208:2c4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 22:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 22:52:04 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 14:52:02 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/5] SDMA 7.1 support
Date: Thu, 20 Nov 2025 17:51:44 -0500
Message-ID: <20251120225148.23345-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8244c5-908a-4807-593e-08de28876cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6KJvupn9zRheQCs/BjBBldNFl58EYEN0EsMw5NL7SB8HJpJBKx7V7xalEDw9?=
 =?us-ascii?Q?DGHkMTEn68Az4kK2LcB1LStnhBI8MH6GrBNSUzrkhBTvUhmddPUhafo2Gj+x?=
 =?us-ascii?Q?MjCWyOsPykBZqGK+uVNfsdOVIfP0Vhp2QB67b+rZLIoVKSHMvtVE6A2DPunE?=
 =?us-ascii?Q?PBZXwGk30d81suE1thnyrwSI/Gf2hxDzyRkNUZYOxbc5l0FeoZklkLGhsff/?=
 =?us-ascii?Q?14Sno6GolFHzMV7GfVTTL/cfsGsN/PWZLFoZss101sa5KtUjfQKN7lmGS1Wc?=
 =?us-ascii?Q?klT9TP7V8kEObioDwuYNdKQfTOvXXT65wsk093CUVrDis8+j33f1hvNAGRLj?=
 =?us-ascii?Q?LTMQKAr6o3A3FXZ+Q0xX04xV+DdjRRP9AXdtBt/fEKdYMEIJyr3w3WUNlzte?=
 =?us-ascii?Q?4Bqli4zRIp3wSv95L5CWZcMtWhUy/hzOW3ccW21CgROwuuXiFolKjdDVKbRj?=
 =?us-ascii?Q?SRAjzsYgrOKlfZRWbxU3e4QJHxLhNGn3AObblET4uxVo+cNWEOkXRC6EoN79?=
 =?us-ascii?Q?laILBlVbys82L6pAdwNm6Zm4sIto+YS5HuO5EJlDIdlEj+xbRKhuedSUaMTT?=
 =?us-ascii?Q?WzIPB8yPThhVGTsDExZaZ2EU/fwadFfs5EBBf9pwwl159zyW7JSr4IMm4H4f?=
 =?us-ascii?Q?OhAJFtitAcR+i/WacdZqDq5gX3Tib0P9no0001I9CIw1YxH0Udz/oqLemNZd?=
 =?us-ascii?Q?ceShutnb+UE/wIgpdW+wy+Jaf4VRFEsPZLqwbXnfFcZzjo2wyw91wSAdG4Q3?=
 =?us-ascii?Q?PpP+VkHEUjC+kTs9H0cNDeSq5AYN1vTfbekjSZ5gXO2XWvGgId2wQVIRlGup?=
 =?us-ascii?Q?/pDhHo5RIZo0l0DhGhGCZTMiqe/aDotodKKQt7dGAJX6i4ybcVZ25AmM6zG0?=
 =?us-ascii?Q?4C1MX2chYaPdjQED/9SBqI5XYaoYFndxDm0e3mF75PcpLOM8MkVEHxPzLnIS?=
 =?us-ascii?Q?H4SAswdkxC+8ekhalHBC6ppB2w8HR5mtMdfk6fV8jdK/8bOOR/tj8wMaKU1F?=
 =?us-ascii?Q?RuTn9ZV+kLZJJkLqiLFoC2TP1ByQEDoyDUo1Q2AMg/NmrGDbvQtxkLrM0bO9?=
 =?us-ascii?Q?GLi7XDbAsRtdqx9Jo648A9IxM8AfhNrqPDYcoN0bYlXB01S/265nsWwlyj0y?=
 =?us-ascii?Q?bLz0Ynl2a1qta9Ipgu0LAF/TL8FUhPdZv/z/GQosC/EMKjl2vlClT7uVARya?=
 =?us-ascii?Q?dLUrudfMnO39v2QOtuKhN6M9M7gMGkCvtMW78sr9teYkfPQcr5WDDyewZAPT?=
 =?us-ascii?Q?QsfWVIHxSeLy5u57+7yaa06JHHunyRLPWceZbYE40l5RHFkTC66F/4WhEj3W?=
 =?us-ascii?Q?bKGNaFaTu1kLhhavKYcubIvdpGUt6PRT6DRjn61vYaELzqUFI58ZuBKveJaB?=
 =?us-ascii?Q?Plb+LF84Ltf/s9NjgmWfcyMQi2qcmshZgboJZNCsZ7O+MwB3Onk7V6sR5yvY?=
 =?us-ascii?Q?LORSlBQOkSTQ8Sr07qt5kFNZ05rP1VNS8lOdfamvk+q88DOhA7VZFczmAjPu?=
 =?us-ascii?Q?qlASR0ZrJNtdYij3uibdKZPR7/r5pBKkSDSHpbjW1Lz3eoTzCHbSXBu2jmLa?=
 =?us-ascii?Q?IlpGvm/LfQmqHj6Y+kI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 22:52:04.1942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8244c5-908a-4807-593e-08de28876cb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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

Add SDMA 7.1 support.  The first patch adds
the packet header which is large for the list.

Likun Gao (3):
  drm/amdgpu: create pkt header for sdma v7_1
  drm/amdgpu: Add sdma v7_1_0 support
  drm/amdgpu: add support for sdma v7_1

Mukul Joshi (2):
  drm/amdgpu: Update Generate PTE/PDE SDMA packet for SDMA 7.1
  drm/amdkfd: Add SDMA 7.1.0 support in KFD

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |   10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        | 1845 ++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.h        |   30 +
 .../gpu/drm/amd/amdgpu/sdma_v7_1_0_pkt_open.h | 5673 +++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |    1 +
 7 files changed, 7563 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v7_1_0_pkt_open.h

-- 
2.51.1

