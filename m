Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF36DD5E374
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 296E610E8A3;
	Tue, 16 Dec 2025 21:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/hwFB0C";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5385710E89A
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ay6R8ooPjlr9438OYUiK4jLuTea1bcnDXSUMLLFqZmzpZ66KTD3skK8bpASv5J97I4/G52IDbtQfUTHctvYZBBU0O05OTRdlkQhcAy5y7+cENwMnG/4fnX5rldETrTOnoacFhfA9uzhssBcKnzZBzGbZ9zfWXLFzcyGJ1JpVdKuSb+WoHMvS1VZZQxGYSuXH2N+MfoTDbsjyBhhw1ozIqpj49pUW97bhQGZ8a+yQcGOG1hATg9CP7NaCrnCTiBP4oT/TRvNK2msNQbE9JP+WIF60KtL/X4aAjjoT9jevXLva+W3ZoEKqKMk9xBRSAiIR1Ks3UZhR8Fy7lin2oPLubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zi8FWNy+BFhXS+DhTF0Z2e7NZRAZJEw3w2OPy25HwBM=;
 b=aRSfWGetqpCWJXKbAcRhqQidpQ5kGIxda3SDXymM9y7FM+GB+WrJB036w2I8hiemEYNxwYL6/xILHhLQBQ2jMjhHWY9+nufpf7RbxihwW1CtTJYzQuXsHOrmanEqB/e8oUb32dw6OsF+EWXwhg7oMuFceKTUHzvHCuNXb++ecdc0F1CJmV+w9RR2Fw79AezoS+c5DNTAYDkYW9KMTaXb6CLV8Lb9C8P/FvzvOocjfmSxji8hpiRbVsHMN/lWtTdYf/sbTHXU9qDERSvAfm5iLVJ74pwIz8PE8CBDltO89Z3vM33A5t9jygoTIPUweOl1nZzMlyt5Gvw1sBypuNRqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi8FWNy+BFhXS+DhTF0Z2e7NZRAZJEw3w2OPy25HwBM=;
 b=n/hwFB0CoCDn83SVcVS07CJ14mPV0+FzV3cVnQ+evGNLfMnVV1wWafEA2ouP7lxy9j05Dwi0Cxx8B1LOBjHr42NZDzJDgjZzL+AiFkX2TX/YMZL5HLKaaSMsRhmWBChshtTsUhEltKSuKDjWsQ6HFOR/kitXTvUaM74yN5v84k0=
Received: from MN0P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::15)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 21:10:31 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::ea) by MN0P221CA0005.outlook.office365.com
 (2603:10b6:208:52a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 21:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:10:30 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:10:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tim Huang <tim.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add support for IH IP version 6.1.1
Date: Tue, 16 Dec 2025 16:10:07 -0500
Message-ID: <20251216211009.1963990-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216211009.1963990-1-alexander.deucher@amd.com>
References: <20251216211009.1963990-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 3522ede0-e510-4990-4581-08de3ce78b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nRbqlRAEcF3rAFYxXV1BASYUk/+7c1IQKMMFifiX6VGBwQt0Y1lct8KYog3n?=
 =?us-ascii?Q?xFiqTGeIscbxmDesQ78k32SJ4kMyVUArIgQxj3SgVTFStAVbu1Me6LnRLg5p?=
 =?us-ascii?Q?TUKdzulBT9uXWnB9Glwh4P5iDnThSvomFCpyx5LQM5xCXvSrMmcr6RfZruWT?=
 =?us-ascii?Q?gI2rBQRPmtBA+BI4WRdyeLaOIcvixh0X2J16wxHtP45FhcCoTFFL73BEnLmL?=
 =?us-ascii?Q?dgXobRYmNG1GaZZZ2XMj2eB0DtdXMN1NzX1mJ/PyVJEAQdUIzcsD5vECQhS2?=
 =?us-ascii?Q?DEGv+hE656+PO7b9jE83IDMbnJIUCahSmg2whFiZcFi2pzPKbGefq54gSSqK?=
 =?us-ascii?Q?mfSmmYtiTfJ9EiJTrFM1F/FtsKRTVhwoobvIq2dFZ+RifNjg5ohNzeES4FJ2?=
 =?us-ascii?Q?ukKWdXlwr8WGnKXc8+mdfDdwLS8N2Gva8EMUvevXjdp+OImXdEhI8LbfXMas?=
 =?us-ascii?Q?SmTipsd8+bUkF1MtgAGFtsDSbkv8vL1EZGnv8ncqOZNHeZqtd3bOrKGOsNXx?=
 =?us-ascii?Q?sBwOwMbeqmOQiMTiMct6zVKd650A5cIYBoxIWd6Nu96fM8IWaAwKH5qv9RI6?=
 =?us-ascii?Q?Lz+71Mpnfs8pH/sYxMdCrCAgUVla2K9e2iNfgbp29jdnEqUbCWEBVgzhrGH4?=
 =?us-ascii?Q?Vb+oqy61LCeEMwh28TcPN3T9DACv8bsPzDm0smJzRiX8RukS3aKUlCtlreuG?=
 =?us-ascii?Q?NFPc7AMy+Wdl2s8srrAs9Kb4Hfdum95LVQ0Dxu0cwoyzamJpc0NoPTmBhSy3?=
 =?us-ascii?Q?UUdbtTJ5r2JE76WlBMcs61Y66cb/JanTo3Om2rz1Zn3rIKbordIU8G8NXEzZ?=
 =?us-ascii?Q?SVryKcg9d1+BKoH+yC3Ln3Ks51NA/hiwfRqeGxl6wc8XQJJr08zO/L1FMn0A?=
 =?us-ascii?Q?4+zUuYD4nfTHbiBRrRqRVCAHj9qzpcrn9Yr61M+6BgokM3YCwQ5+YNRiLbsY?=
 =?us-ascii?Q?HUkTysNYkjFq270qK3Ie3xns56N1qSCXyEqKMb4pxztxhqbggmov58jMEvtF?=
 =?us-ascii?Q?cTF38LsUawrVwZS7mMekOCOQQfPKaD5w7B9t/C4tI0OQMW9JeVyYCVpVK4dP?=
 =?us-ascii?Q?fCd5JGmfBm8RkJxWrGBfrVIKrLi5uHeKsLEo8opPO2+9HY06okRsaWfDsOQo?=
 =?us-ascii?Q?fc6GHtS4zLwWuf+wEaWzKkKXJTmuGiSc5RmCX4LS3M7Rv9qRGKVCwCthyfRE?=
 =?us-ascii?Q?Bqzzv3TZ6eqVlGAW01dh1XnxUs6b3akdhmDH+daZYY7d5cJraV5VDjDPWU6Z?=
 =?us-ascii?Q?Ok8TzWzaRkO2MmFgxauiQxlH/vppNuQsJ2j9lEeMSTcCJSOo7zSoq2yvpl3Q?=
 =?us-ascii?Q?w6lYIxYmji0ZBy0SGin3PnolCjyG/tgAq0v/rCb3YiL9P09wTIUMKOFdoZSH?=
 =?us-ascii?Q?CFHwhWt17NA7jyKFcmeiIoC9azDCShJ4GEBh7Yw2M1Sl6vdlgqdhH8roAFr8?=
 =?us-ascii?Q?wFUQuF85cSnFZLrgBTflR0bl6FGEP6HUBaN5KeYgDIYZeyfD0OOK8EViVwhh?=
 =?us-ascii?Q?reLxa9fo/gDJG3nl8e9jHZXvFzeyhdKseHnz8ZTJqhw62ZgPUP6Cbaj6xua2?=
 =?us-ascii?Q?7dpaTzs8L2U+WCoErMI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:10:30.4302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3522ede0-e510-4990-4581-08de3ce78b43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
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

From: Tim Huang <tim.huang@amd.com>

This initializes IH IP version 6.1.1.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 23f9df3ff850a..9f8ba97c3c148 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2095,6 +2095,7 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &ih_v6_0_ip_block);
 		break;
 	case IP_VERSION(6, 1, 0):
+	case IP_VERSION(6, 1, 1):
 		amdgpu_device_ip_block_add(adev, &ih_v6_1_ip_block);
 		break;
 	case IP_VERSION(7, 0, 0):
-- 
2.52.0

