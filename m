Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3183DC3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 21:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD6610E422;
	Mon,  8 Jul 2024 21:51:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b5EGnMAh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD0D10E41F
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 21:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C//HVof9zdkNU5Pjzd9vBUPV5Tre19nkmWvZFMPiKuIAtG87J9QhW3bWCaG/UjsCilS9P80ukv7r+jSM1ioday4jkhRrVOIMshmmuybjTmo5P3/TKU2XdjZLvCh7ya27y7FQS3gmp/hSa4d4fXVLb9OJWUw1iJKpSPrs7x2KoGEaUTiA+tYpNAqkL9jkKgWJGLItpQAjxV5QwvrcfLshv9MXR6PHtWI4u2OhJPMxGC/mmgGDngc0+dl7Al5H5WwBQrbKiMCFoM2xcqRtmc9B8FW/XdwO6Dq9xuiAhtQD2xCHgz5IXVQd4GUIyTBctWhY2f28ufEsahsBVwP9LtIx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0uBnomhF9B7gCU3muYhjzWu3BhHfsBv9Qi60ZtpPdw=;
 b=JLlR5naxRoyL0khcYo2HxX4XO5o6l36LNc3zTv6oUKkjpRudqe8J/9e50Vs5Rsi1owzzbBDnbfLrr3fWgCWhD9NV5EDV/a6ujuSVzFo9UkSp5vWYIIplU9ZKE5jdvSu0Ie+oJk4fDRlJeWo+jO69METL8feGFSyFwe3BZXRDC6h3agX0Cx0YNTRNmK3O3MkAeHqkJUmwDL+ZtdMHA8cCRu+4AzKOool6O7jydPAvX85EiEclL1AuxtBBWabG/4xk3Uf9svpqqYoeH42JRxcrESdyYgf6R/6jILd35sQgKX2pBa3jye5BuHztKwGIogJRqh7Y1gMIiiAEvQUHoLI2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0uBnomhF9B7gCU3muYhjzWu3BhHfsBv9Qi60ZtpPdw=;
 b=b5EGnMAhewRPTyPS+/HmOPkdvlNE/u3Fw5c7n/q9GPPFRfRKjM9WFfad23NZYknkR6GwPL7jZ2fFI/Wtd0F8ENPR6cHp80uz4uYUtL7MLrQmw2b0Suq7szO1OIQDj4tbo4MMfj9uXuNjW4X2TtRzfipMi2nQKWh9sn8FcUwuv7Y=
Received: from BN8PR15CA0029.namprd15.prod.outlook.com (2603:10b6:408:c0::42)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Mon, 8 Jul
 2024 21:50:58 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::f) by BN8PR15CA0029.outlook.office365.com
 (2603:10b6:408:c0::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 21:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 21:50:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 16:50:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes12: add missing opcode string
Date: Mon, 8 Jul 2024 17:50:41 -0400
Message-ID: <20240708215041.529979-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708215041.529979-1-alexander.deucher@amd.com>
References: <20240708215041.529979-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 75caf3b9-6424-49b8-cff2-08dc9f980cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z4baGQk6jjmnFTFERiBlU4vwyZwiAT0/QO13njUKyKXTJl0/UrlEitqC4aCW?=
 =?us-ascii?Q?JWQWFyFE5Fr6vrfuSKGa9Q0H+gsgQbd7ve4E8PtNStMhqaPJPit0Y1+tdw3j?=
 =?us-ascii?Q?m7V8jDMntGkHSsx8qLa2wDpHks/svF4uhPb0Hm8rzgYLB5u0ZpcJGnAlflG+?=
 =?us-ascii?Q?U7KJcp0HVzYgE5HW0i1FtVW46yzMhvFTgXM0i6Tv3MUIs/tPCCFPUPiO39dv?=
 =?us-ascii?Q?jiREit8b8/hOulXK0A3lrRjetLvSsNmse3sltQT6+ug0H1O4YFTF8h9e9V+T?=
 =?us-ascii?Q?Sw1K9k5H9OcG3pVsGlCNITty5AkUcWWucOlP1XscrfKrcjYhJIZLtoBfATko?=
 =?us-ascii?Q?s1/eIaFOwYqOuymLLuMepkFjsmZsiefJWw9cBaooaENZ/iZZ4mltA9F2/+jK?=
 =?us-ascii?Q?QztAL1JWDhvAVyJFPzWhbd/Ag0jOpaLRy21uvsofKVfdbYLgFuYemGQ5eT9e?=
 =?us-ascii?Q?Ln657H9N8V1lGbTWl6x5OrVmxIbflcFPG1WHakqjKC7iSZxyH3HRbTV55p8c?=
 =?us-ascii?Q?iMp86gjbydvRmjEgCZ+fILsfhayRH4Q7tIVnn1aM/uefeODnWNzwV94f35ed?=
 =?us-ascii?Q?hNztMUhk0DiQ5Lk+m+yYDDpCDSfoAL4tvBfXQI3f9nGXw+eBUwcM8wwSi6ns?=
 =?us-ascii?Q?jRtqB9/UoCSt5MZI20SC7K5EVKhqCKVzcVQjaPsmasochNn4t6zt4vpTmnYF?=
 =?us-ascii?Q?udoJh0zWk/n2yRsgRBB2yeRqiSAt5Kr4UngMU1RIdweRxbkF9ejAANFR4TVL?=
 =?us-ascii?Q?SWNIaQ2kluEIBVgAKtm188G2Vr38f3HPrG4r1BUUqPkJhSLTBRq7+qH1JXWZ?=
 =?us-ascii?Q?ECTxcqwSwWRHr/Co1s+TYl4bUCmrxPUpxFrJfIowzeN/ImOfl0mQlMlPJZd7?=
 =?us-ascii?Q?ZNC9U+KLubfoqbL6G21bUDhcbTvXcxeBcyvEenWqnyWk2Vh3Z1V05Ia+MS/N?=
 =?us-ascii?Q?RQlQZatFZba/9TqEE6XUtp/NMHNZOtlcLmVzSQEUM6ONThcV6bs46cAs7SWx?=
 =?us-ascii?Q?soaVP/tyLlm2ae1zrdKI1rzVlteklFKlSsywyIfvJyih9lvv9mCCxAXG7drE?=
 =?us-ascii?Q?TuLnFyNVzi/1/ovEveuGROJ61W+Sob2ANh3TnKIaIPE0B1fE8FxMu4vZ5ieb?=
 =?us-ascii?Q?X5/tqj4qxXgWEu/D4ekXPhjzq9O+Q576Wjq6sGsamoksOJuw6ZKrmuqkGFmu?=
 =?us-ascii?Q?1uSvU60jFFMOUWZprFs0pdNSCg49paHJN2LJ/dsBSEt/RxBxBE+mmav2cZcY?=
 =?us-ascii?Q?fl0qRaDTMcjLGuSLBAyXToDyC8s9Sew/qwyZGqYUw4uArj5A8amAKwA41oy0?=
 =?us-ascii?Q?xd5jtjERhgbs5tp1vsRcW0cHEKFMnzp/eUWCt6MqrefgZUzvrZ5lZ0RJga9m?=
 =?us-ascii?Q?w3+pDaR5nS8CWNNM17ToTyiSVaEJF6DAzZV8e0EiRBhad4AV2UIx2Kz1QFBr?=
 =?us-ascii?Q?RwDPEGrg3v0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 21:50:57.7187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75caf3b9-6424-49b8-cff2-08dc9f980cc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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

Fixes the indexing of the string array.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 106eef1ff5cc..c9f74231ad59 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -99,6 +99,7 @@ static const char *mes_v12_0_opcodes[] = {
 	"SET_LOG_BUFFER",
 	"CHANGE_GANG_PRORITY",
 	"QUERY_SCHEDULER_STATUS",
+	"unused",
 	"SET_DEBUG_VMID",
 	"MISC",
 	"UPDATE_ROOT_PAGE_TABLE",
-- 
2.45.2

