Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782E9C27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2642410E152;
	Sun, 30 Jun 2024 14:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cIFbs9F+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A7AC10E152
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krnj/Bgmqpo8OB3Ibz/GSWCgPVra+9wiSVrNbzr0vBFixdH5eDhefi+vG1sb7KeoVsbWiJ4Qeob15/wdmEdhFDtXkYhGsLITRi2JH20aQJeoSK1kpFjxhl98CnUSNGCcr69EEUvb/wm4CsBHtnDQjk8s53CJ2iju6qM+VPbgPonZhoFHmyZUh/qczKL37GfBgkTRf9Gxxob3LGzQdUVgq6lf/YgFuVYXJciGCDCXM6/ijIGIjgqLQAYtNXEkhssYJd8H2EpCZYB2DupXy41Ppx/ElRcHiXZTDO4nMMYWQ+H3oGNfFlCxp4p+YGigjcTqh8zPLOjLM8Y5Bvi5DzH6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OBj8My16IzZV/YCweKX7NYvXeTrcyjqpzPKcTdkGrE=;
 b=DjfQfSo9fZLDifEwoVBUqNgvyhCQMW6/8H6/PWGBfLsnJ34NYLQaz0VWtMe8dZClacEI18RB5dzE5wZjK7vA/u10bRPn/yzHk8DsilHHyIS1ibd5422OnfwPN6T3ZjzJjFotahp78erswPFq37oG4UmxYkiTza76r6bmunYGTyw9zAnDqVTJ8SEB81bWOh3+gOFNIHl5CYENROf6CDkHWCxZ5L0qH1C8ShIEsgmAHFWXE9iFMt5XJHZ9za81bXEJT0sOp7m3ZNSXSNZdxtjCaDJc/2/pQkpzAWcugLphtuX4Mp7iclF4iD1HV32/+T9ST+a6GbD8lcK1dkVnoNBXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OBj8My16IzZV/YCweKX7NYvXeTrcyjqpzPKcTdkGrE=;
 b=cIFbs9F+zbUhVVN0/bLphF5KuANwDUharA8RTORcARrGjNRcn3phIO6oTxwHH2BGZQNlQAJFBbgmjMFYbtHcP/8MslxKy0PBazYH8NAKVGwJXDDO8dOhLTsqPgP40c+cUeU+Fped6HHLiNj9AxWVPNoDnLB1qwGLZWeHjTNO7JI=
Received: from MW4PR03CA0087.namprd03.prod.outlook.com (2603:10b6:303:b6::32)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:46:00 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::eb) by MW4PR03CA0087.outlook.office365.com
 (2603:10b6:303:b6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:45:59 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:45:56 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add firmware for SDMA IP v6.1.2
Date: Sun, 30 Jun 2024 22:45:21 +0800
Message-ID: <20240630144521.2016551-3-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630144521.2016551-1-Tim.Huang@amd.com>
References: <20240630144521.2016551-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 948082a5-e82d-4182-3030-08dc99135b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rcWmMB44cx9FgHe6rJf9hOiYbNbnscluEJp9gOJheFKkDf7/zCxXUDHXQdTM?=
 =?us-ascii?Q?SQgLscKw/U6ew1+FFWRy6q8w1oAce9dvCMBKgV8oV1c5Bar7fbKq1KPRrv/T?=
 =?us-ascii?Q?/+te35zlNL0LxA/Re9NFB1CMNpBXD0w8f351s715NocItzseWk+N4g8+z3g8?=
 =?us-ascii?Q?XMUsAaO7HYWpp3YaX17VrChggiNk8RYuoQY+M0qZ1zWmlXBjH5XUqbRSalki?=
 =?us-ascii?Q?MO2vZYTK0eTuKlz+32SZ24d8IucbpezDlnPDISsSh3jnh7OzP9Wd5dHvt86x?=
 =?us-ascii?Q?7iKrJAj2mCnBL0JgJWUM57RVy+Ly+I0S1ywzgsAbSVgR+xH8pab3oQVVAYoA?=
 =?us-ascii?Q?Dlvez+xGP+8/cgl/sY4NAKtoinXH5VHxWTyNOlAixqouTutb3mV4x5pEX6dW?=
 =?us-ascii?Q?KKXwJi4Kf3a0OJxbMFByWvwhdbe/eKokkhKfywHBtgAy2MK+iKnUasNNpJUw?=
 =?us-ascii?Q?wYge4075QF7YjCxKC5JytkzJXZqI55BruYEAkR/zkmCNfYnNODO2cIzwEJu7?=
 =?us-ascii?Q?OcXTK+384GQ118XnTJvbelVJSJokMWA+NH914H9cZql0qupey0RPe2pHdme0?=
 =?us-ascii?Q?NsVSLuUBFFt2F1BoxeMN7ia1LJ8znmujO2WPZ0Ri26GniJmWxzRPOfFJoPZ4?=
 =?us-ascii?Q?qPckS8Xfz6Ziv3MlMs1zQZb6Idt7LWI/2P1N8+xU1dfCV01l1w/ArO2jrLQW?=
 =?us-ascii?Q?qCc2hoXSVqjnV2jDOtbOA8PP0UAH5dS686aEXzGaffTECqZAqesAObUlehjS?=
 =?us-ascii?Q?9d/UUQLfniAFSgEeClLC1bFEVEURl8jFv00tKDKQLZKVW20hDb8l8eSCth+O?=
 =?us-ascii?Q?bldf5GG0A4eTSEF0LRMCQmMY+YvtStbx09FUujiP06wLvBqsnS2WrG21yQ3+?=
 =?us-ascii?Q?ZRFJYr/qyZOWNyg4/mNDnKILG196bwAe83YJYi9VlpW/uuyCBgRV/dttPgUB?=
 =?us-ascii?Q?6mDg7P4cS7mpaREd5Ik6i2r8ASHbT2EDK7MLYZVl7oOh2VytJljJwN4X9L23?=
 =?us-ascii?Q?JAQlZJ4Uqe7Jj01ELl6YOJfxklrhZ8kxxbS9Gkb10OfzFL+FxCf0w4qgrhv0?=
 =?us-ascii?Q?Ns5ogbvl7s5COMqoFEpR/nJcjXboEKOgn4RX8bV8UEsToFDCB28okjHTMo4s?=
 =?us-ascii?Q?9aNY4T3B5PDGrirZGLemlY2nsDQriFptpu2x8YdMCJc2IiRNH3p+AqXgrDAg?=
 =?us-ascii?Q?NPRC9suyvYxvkgxnv5EVSTXiv25Lna58rTvcgku/0JPNZlG0RH9KcKO6+3VJ?=
 =?us-ascii?Q?eZ3JHEHq9zIlRUsz0QoKmYq7MbG2eYFVxDsKOTsUxdY5pBQfnstjcMao5pC1?=
 =?us-ascii?Q?NgWN0g0VQ4HGvjk8gC40l/AnGEXuNkUAWUalb0wLWhYkLLk/vFRNm+f4q79o?=
 =?us-ascii?Q?AWz6WfhGMuyJXOw0yw+N2h+M6jVBHlYOjPVlfRaP6e0gGxx6KkuM+UlwjP5Y?=
 =?us-ascii?Q?dq9OWdJXipgTwYRwgHUQI0Qh8QW+jl0T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:45:59.2844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 948082a5-e82d-4182-3030-08dc99135b49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309
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

This patch is to add firmware for SDMA 6.1.2.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index c833b6b8373b..dab4c2db8c9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -50,6 +50,7 @@ MODULE_FIRMWARE("amdgpu/sdma_6_0_2.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_0_3.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_0.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
+MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
 
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA0_HYP_DEC_REG_START 0x5880
-- 
2.43.0

