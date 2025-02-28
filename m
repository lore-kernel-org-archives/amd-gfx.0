Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA23C282D2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 19:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD7810ED38;
	Fri, 28 Feb 2025 19:54:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y9gSu8CD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F05E10ED33
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 19:54:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXoFU7hkrmSCqVR1h9IDYS3JyySFJofix9n61nIK69KxbusRbWskRW+BC6PPVzLrYbtzo7G3++azAGjP5pSTpY65goDJjxhRO9I0wpapjjdzpzv+NwHqEZrSqe4JJcYXJ1OkAHoFE22qYMxlvYsyl14RffBLjEuab+7XILAXbCI1LIbS8MAPtDqU+RJ5V2T3fesJHQ2p7p+S6xpn58DFwLMQkGw+m2mIeNqsrXKGf+kTs0uWmnmhVHFjLbt676zOCuVw0q29Z/vH/PIRYF7N4/dwcE9EeOifbw++aPJp8qssEdUU/rWgVEPE4dJBOohn5mh/pY/eksmjn3HqgcgayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6smlrsAOUC+Gw5yYlPOIV/kgfPU9n8tjSNI6SaVm20=;
 b=cwli23wA1ueH+Ax7CGtqS2QcMbIXuR+rIof63K3MvyPMrf3PtNPoZCN2CSD20tpzqJdrdtxWfXd2vVPQy79mPDagYQVUFrUYxAzqJSy8Xxr61ogbQkRZs4jzbwysP0nzRHqjVOa7C4mUGGA2eibT6Y7d140Bg0rm6OdBiANNthB8w1yO3QCOZzLnmeRCeSuNujGuBBCAxrUhAG6w7B0V+GnKsK3yJk6wcDAJZtcWrfwfy5xb0oRgZtTLFVp5wMXMfBkcTZkZAgfBvS52MFWChnoez7oEIPWd2r4NkW9t5Ne4Seg6xck/2N8eewln95/JQ2fnaHrsU4n362r4fm/VJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6smlrsAOUC+Gw5yYlPOIV/kgfPU9n8tjSNI6SaVm20=;
 b=y9gSu8CDqbY90sVKFDRmIZZTnnqXP+ItElYb47apVKf6HIKyAuLiOn2FTr9uG7mIYvzhanuvrWQvVjIOieqvUVSuFkM/vtNpZCmNgcoP9CoV4pNm0vJXcyS9PJPiwKP6UcMHB4OJ8+SEe971OohE4fHwg8IYNFCbZ6ilrHGyKjM=
Received: from DM6PR17CA0012.namprd17.prod.outlook.com (2603:10b6:5:1b3::25)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 19:54:27 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::de) by DM6PR17CA0012.outlook.office365.com
 (2603:10b6:5:1b3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Fri,
 28 Feb 2025 19:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 19:54:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 13:54:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/userq: remove BROKEN from config
Date: Fri, 28 Feb 2025 14:54:11 -0500
Message-ID: <20250228195411.2530147-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228195411.2530147-1-alexander.deucher@amd.com>
References: <20250228195411.2530147-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e09cd4f-b4c8-4ef7-c2be-08dd5831b530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?72BuI6kgZi0TC/KW0dp7b3Z1KXHpYiWKS/qVBttGH7o5r3Sens/a9iruGLLA?=
 =?us-ascii?Q?YuC0Frk7wqcyR9XwLSNJx+dhAyeaXrBAAYjAoaYPPOr/JimlIvRFSC5LK1w5?=
 =?us-ascii?Q?cQ2JaX83nT2/MFCB39V8omNyOlYlxoIUUvqJSLpSyGWRQxiRPg/YJ8JOnYTO?=
 =?us-ascii?Q?qMfK3rLCFBnz2ihLaf6ELsmWjH7zK8+aeKO45rr6QlcINtKq5rZGzrdO8uWx?=
 =?us-ascii?Q?7Uum/ETtlRECZhvNXPT9wTqhdZmTv/HZVQIV5rMjK7rKFWnFrQHfJn8pHIED?=
 =?us-ascii?Q?oNsjuWG5e0YQxXB9rVLwXQ+hNY45v0ya23TYX/cMthBj0xULEp1IxuGe0DN9?=
 =?us-ascii?Q?LmC6VE5dXfm1FrdD3P9oADb5vgR0BezdxvMYTsLh3eEbWpd4YpYIfBm2UwF7?=
 =?us-ascii?Q?KhKsb9zPn/4X37D+noTZPPvOL0X6dsVKF1/g96Q+UYMjkIRrBw8taXWtgTgJ?=
 =?us-ascii?Q?5W9dGIuD0IjhSuEIEghYRENUuRv3GlJ1VWzom+krS/6HwujmvA82Q6Qu54Zf?=
 =?us-ascii?Q?+SQp8yxM2HZg02zOzCE3kyUP8czzmjuXuQd3qKqG6VuRtTzyjTqIhHmOJcpx?=
 =?us-ascii?Q?IJmlH50Mv6DQZQwYkmrVGXpNtatw2x4vacZifIdjDHRPe8rgSrXOsEwTsceM?=
 =?us-ascii?Q?aosfCqzzTMebLd4jogr4Kk1PYNoGKcZnKVnnOgDEy4q+cJZsbt7eSbw6G/P5?=
 =?us-ascii?Q?/Ur6YxOWnPFeRrah957/ROJ+oKbqtzL2gJmK1YXhv+Gq6wtEqDjE2P6UcmFH?=
 =?us-ascii?Q?8KyIojDdJdGd1Ze/2LEnGhAhqSNZW7nLEvFKzCsqwGhpyzgqS8FhE0QnYTqW?=
 =?us-ascii?Q?4uKQ8wcXfMJBeGGwQixXJ6oiiOOAYr/02i5VIEoXR/7ULC7pH9XDSwSFYbY1?=
 =?us-ascii?Q?S+fA6gnXXfHEpE8+9t8zjRTNFGaR7Zj4uv/wDUl//mprU45Rmrwv5bQF/JHz?=
 =?us-ascii?Q?p0+XjmlBzG6wc2qSyHoSN0D7jvL6C6n8JqJ8YDuRrj6ai4PBRk0VkBJyEe7r?=
 =?us-ascii?Q?gFOLi3HIG8I5VBT0LAhtGSVOL5vU+M7xMkFFRKyJcCy4BxP2EC5D0/Di14lh?=
 =?us-ascii?Q?cbzT4EK5ajdZETrwJQiN2Tr9jPumPgRbAqEQj/DJclrUv/46ainMfFXwCebU?=
 =?us-ascii?Q?7ZCnn8QGKUV/EIVfCzbF7x7lew7s5U2RDDMYix4eE9COGAVHI47BWKJB7Kzf?=
 =?us-ascii?Q?J1sdni/t3M2pnQrB2rLE/gxpNp/DZ9YK9k+O4b0TAhR0KXW5guZfkdcphDDk?=
 =?us-ascii?Q?Fs6NLjjp/Vc6aD0edWv47/muLftajYnzw5mbYwDSKPn0/Q1prOaKH1h02tao?=
 =?us-ascii?Q?WFgXy+Ugby+PlL5Rj67SUOvIxZROVy8hCaM480Ymx9NvljpkqIv7mcjq0L3b?=
 =?us-ascii?Q?elOWGa6n5DaEdGqb+asaLH6n6PV1ME13+XZC39k3msfREW9qHOJmRZeV5fL0?=
 =?us-ascii?Q?ZDUcvKCbEzx/QaIb8iZUXOht11FrZ0C0dfORL2164+rQCwv1P0Kjfchst4Gj?=
 =?us-ascii?Q?DywpTZD0eulYBo8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 19:54:27.2210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e09cd4f-b4c8-4ef7-c2be-08dd5831b530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
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

This can be enabled now.  We have the firmware checks
in place.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index a614320114796..23c014da0f324 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -98,7 +98,6 @@ config DRM_AMDGPU_WERROR
 config DRM_AMDGPU_NAVI3X_USERQ
 	bool "Enable amdgpu usermode queues"
 	depends on DRM_AMDGPU
-	depends on BROKEN
 	default n
 	help
 	  Choose this option to enable GFX usermode queue support for GFX/SDMA/Compute
-- 
2.48.1

