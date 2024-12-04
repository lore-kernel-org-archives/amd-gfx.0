Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9979DE7716E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 15:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A5010E34A;
	Wed,  4 Dec 2024 15:09:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XyWCMBkK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3406710E34A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 15:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gbnld48TUaG5lqbNW3FJ7l9kRhzWuNl6KVlnHlX5D74dvJAqmZ0DtGcQiLXhMV5J4ycIRSZVCEgBFEtlfcO6tFUEP51Y40jyB/z5vJyFmAh6h2DPpSwY3yGt8YKV3u2z41Z/fr+12/5orojmxND6W0wsfB0G87jCzWHuri8P+Pj3frPAPVgt1wK4YufUm1NPj267U5B3iWnAgfxRBKGZFr6rFVlOFH7rXYOjr4xFYgCMe0j0S3I30e4/FCqbCHBxTlJv/yQ5Ow6raHL9Z0/ptjDWm+dv8O2BykfgYyeBT3nc8nLPdO5lS7aErdEF6kJ11g8VFgncE95ASX9NJgLzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXiXJ6jjBDl38nqVJDdJ0U79swMXMwlXff9O6Kp8bS0=;
 b=N4ttrauCJut8BqpPreNf6oNLnZafVnvYCe/suXZuuVPEzy/Qjvp5OZ0WVOIdueePsip+vEZ4FHAY/7r1Jz+soSOmCF2By3GyHNBHNTKEUIB/YkFssS02HZMoMc+qK6WvIGwEpTrLxELNLsMH01SuFZxmGBdAq4N0GOLMstNXJu2adMMAOlYwvn/TnqqEzwnzvj999MF5qEQMq7KNDOQCdG5pd02R2j2AD4RTrHMC3MzaEinMRU2gWZrSvjMO/M0dxWPnAQD0Gp7V7S7HS5HVcN9VIWUmVcZqjri76MgzYOlP+Hn21bkBhqQ3SWaGI8DLTZkIiIpNo5gmuZFa1+K9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXiXJ6jjBDl38nqVJDdJ0U79swMXMwlXff9O6Kp8bS0=;
 b=XyWCMBkKlmerIYSyKiy2Y1lfPKE7x+C4NT+sdzVf18RPwcPTt75w+N7gPHfK13AVJryLZCO+C42TbFp4z8c60ObZvTxCXSkNfv9QUif0Nw12wwD0zyxiU774RmaJhFKQhRRsh5ruTfKE9DQQjI0oe2ir7C12hlLYlB49sqYzPfI=
Received: from MW4PR04CA0337.namprd04.prod.outlook.com (2603:10b6:303:8a::12)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 4 Dec
 2024 15:09:30 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::e2) by MW4PR04CA0337.outlook.office365.com
 (2603:10b6:303:8a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Wed, 4
 Dec 2024 15:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 15:09:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 09:09:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Add smu_v13_0_12 support
Date: Wed, 4 Dec 2024 10:09:11 -0500
Message-ID: <20241204150913.3425270-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 90211cf5-500b-4cc5-f7e0-08dd1475a6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aPJi3Tbu2jvLM0owgHTchJb9/YkRd+jfsSMbw9jpSpOd4nr7hHzwgb1roXfo?=
 =?us-ascii?Q?SdKSWX/K2pGgVVX4lDE1Q8/9O/y9B8lzzofnJu7bBNj9D/BxUVczieRy62PO?=
 =?us-ascii?Q?fWnyFQLNZIUT2Gz1uGcDy+Hu6U5SXpFgQ5EnEMHkmfIIjJV3CkOPl8scWdRb?=
 =?us-ascii?Q?0gQV7Kc9tM3sn3W+dQPZcrj0LGmj8BLuhxDbWRDZNeL/OHWrWR1fVaWmMsd6?=
 =?us-ascii?Q?ZIfrdMllbIrari3sYa9f3SHEjBeC9G1yS2Ae2D9SV4ck+aHDO/sF79s/nILf?=
 =?us-ascii?Q?34th2q0RGnfF2Ktmh3siAJZLZau3vzHR2ULyuCT00vHd0IVEBfZP/x/ppVAn?=
 =?us-ascii?Q?uo6H/YHPeRRK8ZbuXcVOzxns0aJay8LhNnIa/sPtuw0seUC7RHYxTQOnruyP?=
 =?us-ascii?Q?YRUyVX8oztzfL23Vay/X0Bcgq7ApG96VEJQq/VjGfr+YIy42s2W3L6Z2OdOM?=
 =?us-ascii?Q?CZkrfX7NdIqyKpKOfBpY/5lIdD8R9Zd0ceubbflsiUgqhuuzyKJa4Rm4k/dy?=
 =?us-ascii?Q?rACCpab5OqZbOkj9r4ogQJ/q2JdqB9NP1tVH29vaFqTllii8OTEfh+l12Xnt?=
 =?us-ascii?Q?sTN6tIm46ZrxNgzK7WQIW/oAiNxCDQhQ/hTZz98Nsb0e5lXuwn/QaYxxi75X?=
 =?us-ascii?Q?tyxdiZ5zbSQ+ImSquom4oqpnJChhoAIAh7S/AwI+/xDNym5HavjTaOnoUdFZ?=
 =?us-ascii?Q?sSRK0q4t+IcGzKIfmqz6yaxVfTr7iJaIPSQOhlRzz2SyqEyS58FjQIYaPL/b?=
 =?us-ascii?Q?6doVNzCL03tE+9TKzJEhgwElrR4X5cDO4u8Z3hIgcmZnsrIah56td1af6dce?=
 =?us-ascii?Q?73cAwJIc+6TDYXES7dIlcNOAh2wwl+GlIopeZ3oYtunuHsq2GvBogXDCNlaW?=
 =?us-ascii?Q?FeySH4CII+wAOjxXxj2O6dSUCg+tBwJsYlACnaZlVWkYR47yf1wutUUOgA1T?=
 =?us-ascii?Q?Lkcbx+kURVnDaZ/hLHsD6vpymJf3XH28ZCs5gL0zDp13wnCbOpoMMJrhF93F?=
 =?us-ascii?Q?XpnatNMB3hCqZkKUb2sGgFq9a6K5ufIbly5sDZpsk3PbVQhYVa13QX8OaHTs?=
 =?us-ascii?Q?YB9ni3xgSf9ympL6V0vrvYLhZ5GNx/atsmscDD4lOTFpyfx36akPx7jgIqsj?=
 =?us-ascii?Q?KpDbq/kX0RKS3013w89mqTu+Hp/2DKEsgtqC8y9AySbHF6LdZ8zCA0FFNYNi?=
 =?us-ascii?Q?FRbfGNLygZFyEKVaUZtwd7ORPjkTdKi6E+HhO4nYdOx7MR/guNYvOM64JAJW?=
 =?us-ascii?Q?+EUhIXfce3JfnNiXL7rIGmdfnBZQFCok4IcgR+LXZiJVFbjBYzGu4A8yOzKZ?=
 =?us-ascii?Q?km2m+ZN+rjj+JJFbJPt6/yUKgKQMjkqi+4/HCxQtL9fCGxorVpBTrKkKQ/pV?=
 =?us-ascii?Q?dEhZvQzFCQi2EF4qIlrDzs1tDcHdJ35zubmJDuTIWu0UXPidn2WW4e0pF6RY?=
 =?us-ascii?Q?2UFi/t1EYOvbCgBZIuCaosWa22bPQl9w?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:09:30.0110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90211cf5-500b-4cc5-f7e0-08dd1475a6fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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

From: Asad Kamal <asad.kamal@amd.com>

Add support for new smu 13_0_12 version

v2: Updated subject & moved skipping p2s init to a separate patch

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d1bab508ade21..1d6f8696d2d3e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -727,6 +727,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 12):
 		smu_v13_0_6_set_ppt_funcs(smu);
 		/* Enable pp_od_clk_voltage node */
 		smu->od_enabled = true;
-- 
2.47.0

