Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B65EE7716B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 15:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 011C810E1AF;
	Wed,  4 Dec 2024 15:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qXCVbwC5";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D2810E1AF
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 15:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sr8HWWm0fueZrX0yC4gN0h3aBe5m3j0zyzO4YUDeVxBN3c+0m9WGtU3Hhi+14TncOfSS9mLV+4CcYEFqavL3JWteITI1poeOhwQXEVxyA9TGjEGlCcmhK7aQorfGpIWfUAxDrpudUJ4l0SPM+ZWkVZfOkuDcdDWacLPAUlTgTxHnqGPPUnAZ3LeOVwaFiqR+VvpyAa5SYTwj7oCTJLEYMNgZ3ugLFeKy1kzsd2lY8clwJ0Rs+2pnp/Ccl/RYXANMYRfiX8apSecKRY9ymT6q5fvNjsCa0kGPy5o/kMxF0Ds5It/1Pfm4TblayoICyW1UTimym/eUoFXe2jjzQ0X7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VChmMFTa6YFMgPaRE5+YvkwsEsbSPM2G4EiULHlq5Q=;
 b=gLUvDoGXpxI1MDSdwh9i+yXXE1zEubLcJkfnIRAQnsqnaWcE2bu3s2SldvK16sphviZVO15ckEy9vrhChUMvCAf+xalGcVQ90LsY424OGqae7q3x7YIbI4nRpl46Wv6lDdw6+NMzVh0k53KcWPFTbBKyhuuXdZfE1ynhABdRZwmw0HKEcCmsUx/JuV1L+B08m2E6LEJyp7sMCrMl2SUPqn8BUiaOJgPoEiuvY4Cp/Re6JTGP5+RQY9KPODtsERRvUOOzsIZM7uZP4TozvbxllFKxbS7AHXnybVEDTFOWcQOAXsZxCRJ4WQhXm6IePLST5CrBsgqwI7u3EhDt47Qwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VChmMFTa6YFMgPaRE5+YvkwsEsbSPM2G4EiULHlq5Q=;
 b=qXCVbwC5lm+Lgj0ScNoW2GQqzmK7ChEH3FqbcEirIP+7evxqyEIQPw0zMhGHz0xR25vywPZTZt4i/Duq8djzHVeOwU1/xNr/j3bRLspu+qIuGBl/9rhtXthD/5K7ThezpbKJ9kN1eJQRzj3/WGCCqPe2yVjIdkFAMlC9IQ4WkI0=
Received: from BY3PR10CA0013.namprd10.prod.outlook.com (2603:10b6:a03:255::18)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 15:08:37 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::35) by BY3PR10CA0013.outlook.office365.com
 (2603:10b6:a03:255::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Wed, 4
 Dec 2024 15:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 15:08:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 09:08:34 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add psp v13_0_12 firmware specifiers
Date: Wed, 4 Dec 2024 10:08:19 -0500
Message-ID: <20241204150821.3424757-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204150821.3424757-1-alexander.deucher@amd.com>
References: <20241204150821.3424757-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ebfcb2-4ffd-4568-7a04-08dd14758795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kwShlWdGQiWixj1BjuaU1uGXQLEsWVOAZKE2OMILTrtSA8ftr8qJ0ZCYyV6F?=
 =?us-ascii?Q?pNL30arXcFgZ13lfBE69Rb/W/C32pq6M6zNKWN7rzu/zAeOitcce/wvVGX1K?=
 =?us-ascii?Q?1PX9I45PtJe36hy87XNA3uOn3nHS+0vt2HZsVH5rVsJfqpIy2J8+mFJmvCPE?=
 =?us-ascii?Q?Ff+gGKqEJiFvv1DYzxpus7FupUxqbjC/8bFEysgmrWol0OiLivYuhVbQCXle?=
 =?us-ascii?Q?YZ0KzVwuwpCrwCdZGLAHFYhRYmHVscDtzh5ZzSDOUS+pmRA7wz3D8kxu5MDP?=
 =?us-ascii?Q?Q71ytePbbtaS10AdJJ1TASh2uOwkkXPyGcjasJvv2BkIhwsHFsZKzl0DnNWQ?=
 =?us-ascii?Q?VFQdGMnovnT4tWZSCDadlSk9aqGpQLbwzyqwfJAu/WhHJpfdEmKDLDnuGLMg?=
 =?us-ascii?Q?9ATPqNweYrVlWfE4q6TQU9HkAffrV6f5QcQmo8cHpswwJdOelSRmcgA9zsA0?=
 =?us-ascii?Q?8NOMOzGeDw9JvhkFEssyw7xAtcyv0Jv5B1hxplxSxJexQiZzCy3mdsrKdVXx?=
 =?us-ascii?Q?O+o4HHnLjvjPVn1wyIWHOPn1mnDZLuKHi1ahOcWumA2mGot+k2eyOzwQifol?=
 =?us-ascii?Q?WWR3xIcbbr8KN+7/N3InvXoKjcUtIl8tc738EFXGUT9aAXPA4jbIPqu48DDG?=
 =?us-ascii?Q?RTK3wr7H+ZCdR28rs2OS7hO5fhiNPkX2SOy73OQq5iIgI4GiRkgsgMKNdGz8?=
 =?us-ascii?Q?5OCqLPP9W6DDAsUtQY1/bMLZaj2S3rOsD9fNvXGgGMJaSQhLBN9T17S2Ap/2?=
 =?us-ascii?Q?MrkY043/tEqluVzBKiispOwP2cczxMOtip+m6f3ASL+XhP6vGxFp7jh7d0n/?=
 =?us-ascii?Q?how6FBYSEjT4XYZygo5tBloXjIRI3zfagUvR9zBlyEZD2jM2u9gKI/vhsiy9?=
 =?us-ascii?Q?or9LeqH4wwqsZHn64B2XLcL9wPk0/DESV9t3iaeca09+uOnhH3XrF2VU+bKE?=
 =?us-ascii?Q?s/Xo76aSx3yxvgU5H2MM+bMbXNfB6xbfuk9jIpxr7uxHmKFraKd8Vq03dZHx?=
 =?us-ascii?Q?gRGzrfOFGriMAiia5heuopGJ6HncWI40IelAVFU8XWERLu58tpXMprOkvxWe?=
 =?us-ascii?Q?VhavSzpTYxxUysux1Lz2NSPJyYjAFaeHkgq+p54/elH9vRaJ8BnMr7h0L9Zx?=
 =?us-ascii?Q?/6+J7Mxwe/Gv3qj+mQM1sJRQTC+4GuAVN8YMPxL/Y4gLYmtCC57TIqSV3brw?=
 =?us-ascii?Q?6m2JVXBQJB26ctnyLx1vktxG0NdKtkjOIO1295HvbZBT0V3QZauISxzTt1Bl?=
 =?us-ascii?Q?hEEFb6tn8n7N0lpo78yU1F5LUA2HB1BQ8yYwKEOrnDcet4hrqT1TCQzh8tNt?=
 =?us-ascii?Q?qIkPiU+yReRb2obdcuOvvnIL4DgAp+pUXNyQ2mrsHR9dMGJZqGXooB+9dOe2?=
 =?us-ascii?Q?w6TIhy1CXcO9tj+So+mwWj4l6NykuIwVVCWg+pXT9pK1YX+rF7/ocm3Zc/ga?=
 =?us-ascii?Q?wcNTRZJZ13yYoUTBvZmCMwvosmTN1TGp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:08:37.3209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ebfcb2-4ffd-4568-7a04-08dd14758795
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add psp v13_0_12 firmware specifiers for sos and ta

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 3c665ccfca642..337b9d204aa86 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -51,6 +51,8 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_11_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_11_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_6_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_6_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_12_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_12_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_14_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_14_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_0_toc.bin");
-- 
2.47.0

