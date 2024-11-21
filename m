Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3182FD6ED26
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E085E10E933;
	Thu, 21 Nov 2024 13:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kijEEPZi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D057510E933
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN8YcrpHvnrTwGLgFVIt/yvxbdV9ejCTAjfjlLdQ9s2ksx3v518V3q9WwmbBO/OW9hIqLmLPu5kh1TNprh17L8WO2zdkq3kqVX3t5k0wblJakkrD6rWBqOAWtdghaHmDUvS6CzMTZ3UBw3nWOqnw3EHrgJgPQIKK71XAhw0NzSUq7Jr7sPu1pv9EbvN1pWcLGIjO7p9OcO+L8byhsiPIsPcDhSaSi5u3EgtJoCyLKBNYr/yBZV14uJz4+MWA7WJEf2HQs1PzAeQquJIO1O6eYWtN/kOEQGAKkt1leYB/blGe86bsXBljb919BAwnmmftotwRJSjBhPwOs5rhwWDzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLG7ijkreT8a3hevhG9P61qlDuNEYO6pkgZgCOBoNsY=;
 b=CnsoTwflFh88YEf79cyrYv9QKZHd/tkMu/VgLt3pGHp40oUMecM1PS4QRGEj6fg9y1ajyQggbU3TA8WtD6md02sZuS1suPjfk+6uLrN4hJmWGHOYXrPburR03YXkRzH32C34RDp9J3tPlseU2wX9UsaPWLW7nL/xOJ7M1TkvjHHMnmA5Jas2SvqSgAB/Ey+TW9uVP+UkZJkwQYaWJhu54adAGvJrtLSiTBBSWMXeZjc06JZ4M2IhlqHvr28AFips2s5GxAEh/GJmRh6zPoz6uFlzuEDoQfLqwawfzJuxiE/s+95W9FwxVL7JvCS8HU1xX3dVC4qe0piVJHjgSV+/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLG7ijkreT8a3hevhG9P61qlDuNEYO6pkgZgCOBoNsY=;
 b=kijEEPZigmJ3+TpqJuqqmpNh2jiuFrSXmoPHCv356XeOEkELLWcpvBtQJdNMVGVlZuB46jTkae5HecuZXHun4rXD8b5XI6jjszCn5fmHx3jR2Ue7NdHxqCHP7XdVppiKBR+V7Cy1otLqBevslupWv3jaN8nKnTkxmtCbmxNLBz0=
Received: from SJ0PR13CA0236.namprd13.prod.outlook.com (2603:10b6:a03:2c1::31)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Thu, 21 Nov
 2024 13:11:28 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::a2) by SJ0PR13CA0236.outlook.office365.com
 (2603:10b6:a03:2c1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Thu, 21 Nov 2024 13:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:11:27 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:11:25 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH 4/9] drm/amdgpu/sdma6: update mqd init for UQ
Date: Thu, 21 Nov 2024 14:10:50 +0100
Message-ID: <20241121131055.535-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121131055.535-1-shashank.sharma@amd.com>
References: <20241121131055.535-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c6a60c-114b-4de8-8cdd-08dd0a2e025f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L7Ft3Orf6H8mZ5WGUXCZ9DumytsJa1aFP+HrTVzP7Z8OvWH3aAqy62DRSWyr?=
 =?us-ascii?Q?BGhJXglU6MawCWzQmgTWglRZvuYJAmAyAP/FvSa+UIT1JsA17J7ESEz4UP0A?=
 =?us-ascii?Q?3l6xDB1ejYHpMy7sNAdi9g5TqXjUwyQLGT82njqNLVaQxfxy3CswxumtnXI8?=
 =?us-ascii?Q?kGAlOXzEkg+FmuzPQnabQE6R0VbPC7g6KOlWXWKZb33jO5bIinmWAYrrQDi5?=
 =?us-ascii?Q?Ck3dI6+cVDcUQ7JGKCOAU6S4mYOSNsdLNgVKwpQ2Gn6ygdQ+1HuPpp4gIuul?=
 =?us-ascii?Q?oUlx8CYQ1lJYU+O1tGVGql+BFLoWS6kgmERDkjSR2LVllHKW7qGoByZ4cjvJ?=
 =?us-ascii?Q?OcsVgGrRXU0WkOVUr4rLHgSPQsYCcNTVfC12slRg6wpcIuv6GQLiUpUrf/08?=
 =?us-ascii?Q?QI98mA6U9qrID5u1jHwyhD8UaJNXMA89lf7XT/nhrpp4vOGd7CzKDVkjrtpR?=
 =?us-ascii?Q?i0o0ykj3fLkB6umRFGQjsBn5UrQ5osXusHlrlm7bhKJWyc72J4ofKVsbHak2?=
 =?us-ascii?Q?AjhIOpdPrGB/hFYCQg8tw/pu99YBb1lO33cAyJxNrWR1G1h2/2/w2wWRFY/K?=
 =?us-ascii?Q?tyTx7aPxI/VeVCnvbUiV0Vwb5OgIbizMKjQi+q8LCg//bHHd0ZRMtbiLhp0h?=
 =?us-ascii?Q?N+5VYUnqnfuUyCIrZ1htkHOj/RswFk0jxIZOZX3oPNhzLqe8dkUn76D9GYIM?=
 =?us-ascii?Q?Zd8sdSzUSBrFCwfPIc4gHt5/qGeTf7JNVJF0GBB4yRzmMG9DyOs1vTjCmL4Y?=
 =?us-ascii?Q?RdOH4lvVg62SL1+R7MnpTpkKj//0qksExSSetr42cNg/SnjFq5X2Gs8jPr9e?=
 =?us-ascii?Q?hRc9H5j94+joNGBL8hmslrjKOu661iTA0+c4yTA/9ZkMcUEJwDw4jk0L0Wy1?=
 =?us-ascii?Q?aCEqjbDDNAYM1zg+9AMepTKm06rb0IQOBoWi6vlgyFiMBYDm6mryv9434Y64?=
 =?us-ascii?Q?uQpNUFn3rGbrlZ9RODMuR4kh7Ddvcvj8wVlpSW+sI3N1XSNowonnEu7M5Tij?=
 =?us-ascii?Q?46I18Ede0KqPCaswtTvBUV/6IPZPMMsylblbaRAl0IZ43mvPN8igeFM6VqPD?=
 =?us-ascii?Q?/wFCUMK8/feb1U5NfLv7adlPO8p0DUPuVnYQk511ERvAHX1xiEcZnBuF8PN3?=
 =?us-ascii?Q?YVLeqnOR6OWXEzdpMenKeso+Zsq9DHKwLpl0cppdFvoHa6qsGMOXtQP0dk7O?=
 =?us-ascii?Q?gcDGdAyqdTYoqm9zMqPRytrdP/WbTY0V5+PH7dPwbDIq7QmqEBUP13n4ilK5?=
 =?us-ascii?Q?X5dMPlRlk0PQxWGNOtuNhKK+S2sGwdmxEofHBfCpOqFmZDrt71n7pcQPXPNB?=
 =?us-ascii?Q?LbBDu+WDpzD0gDJOpLrs8aafC+wG7yWdeji42Ebdss+0CcRkg35P5UlRtZI4?=
 =?us-ascii?Q?PZXMfyuV4kpJRZSywx93WSMGTllKEKsMm4hrMgucwdHPGGsQyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:11:27.9192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c6a60c-114b-4de8-8cdd-08dd0a2e025f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
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

From: Alex Deucher <alexander.deucher@amd.com>

Set the addresses for the UQ metadata.

V2: Fix lower address mask (Shashank)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 6e9fa0bc89cd..9af6aeeca063 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -891,6 +891,9 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_aql_cntl = regSDMA0_QUEUE0_RB_AQL_CNTL_DEFAULT;
 	m->sdmax_rlcx_dummy_reg = regSDMA0_QUEUE0_DUMMY_REG_DEFAULT;
 
+	m->sdmax_rlcx_csa_addr_lo = prop->csa_addr & 0xFFFFFFFC;
+	m->sdmax_rlcx_csa_addr_hi = upper_32_bits(prop->csa_addr);
+
 	return 0;
 }
 
-- 
2.46.2

