Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0BBCAC58F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 17:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C791410E3CC;
	Thu, 11 Sep 2025 17:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rT0Hf6zM";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEADB10E3C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 17:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/ePfBZr0U9yhsu00XxOITStYGPYQY4kAkLK3TKFuVuLcdhCcdOGvihOm8WuikNVJD+MiIAEuVZJ1gS9W5zRgEAUZgQ8Nkku6rOgV/G4Oz1oAqV+9Md7vvhWkXgMkvxtBiyc5V9qhXD37t2qTA05sl0ETHY1rabemyjLjusCxpZjkIt0DDbztXgP+JVpDw7u44PoxHS1Z8lRJ3quF7OlP8omecm6DzC3nNI+xWrv8BsA8tGOjIh91yPg4VH5I6w7yZcndJxFj5iUJq0zkanyfPr6L1qs28+fqqG6txVL1UYmDSWHVE92J6M4ItAMPgx6pm/B2SNik1ZYfmRbUH+UtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TE2S2M8bPSd0IC/HG14i6fUhU+f4BxnafINXfsYOCMY=;
 b=vz73FwnJzVBvffU77DvVJSUNTXrlCnCDxP7onmthyYSHsxTipB6UQ9NMqcnqpefs7fg6NU8gxTFoFpMLUuekinBSCrbMjdMqqJSN3HgzuKqEdVXbqZA3X56cnzkB1DjzP6UXsMy6OLlpN79VyJn8yrpk0JE64Vd6Txp8APMP67ewi42zjPabh1UCR25vxYq4HJrIH2z39ijXurBQ6aFcc5z4G4H2n2WIoY179Vgpj45HvBg6DpnueEfBhI8Thtx0Vjx6wltUfGegmQtORV9WzJq9QaGT9iC4LGrqJN5CMQL2FOEI4EU07oMmCazcNaQu7p7Ytz8mLpl6oXc3BpbWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE2S2M8bPSd0IC/HG14i6fUhU+f4BxnafINXfsYOCMY=;
 b=rT0Hf6zMizf+vojy0eb0/0PzotrsK7/rHkdQG6ofFAwK10gEHIzG7p4CQAtv5J/Tt+1SPVKm7pi8S9XKrPVtO9udf4mOhPW/WuMFMclCDReglV07ngHBRY0CjmzUbHgJ6ykzpZbMg/EstBlJLnTzEx0eo0Kgd1B+rRKBKfs4MSU=
Received: from SA0PR11CA0063.namprd11.prod.outlook.com (2603:10b6:806:d2::8)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:25:16 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::1e) by SA0PR11CA0063.outlook.office365.com
 (2603:10b6:806:d2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 17:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 17:25:16 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 10:25:06 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/sdma5.2: adjust SDMA limits
Date: Thu, 11 Sep 2025 13:24:47 -0400
Message-ID: <20250911172449.3340848-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911172449.3340848-1-alexander.deucher@amd.com>
References: <20250911172449.3340848-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: de7e9969-bbe3-4d44-9f5c-08ddf1582c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IEC6SCu3FvTpvAXPZCvmAWSAANaHkMQwyrZgNJTw+mYfdmgLECKWEZAfvn04?=
 =?us-ascii?Q?lxH38W2Nbmgja6/Q7e2ilMBOYDygrVzuDWe5HizGX6mkw7t030xAf/99BRkj?=
 =?us-ascii?Q?whrXCxZ32O/WXCVVoSDY3XHXQGE358j/MEeuuCEJQ/E0WyIsiikblmMtIG9Y?=
 =?us-ascii?Q?LSenSi1AM5T8LjzdtvJD+z1UrNMUATiFniHz2SRlRHwK3Nc8jOOJ8WxsLV0f?=
 =?us-ascii?Q?NWuol96M6W5KdgPQ7Yji5TNk4tCW3UV14Wbx5L8pmEPdPY+adLrfiMIceWlI?=
 =?us-ascii?Q?pIGUH7877hImKgPM7T/yuhGSTyKx8omnG8GH/7wEAr5Lv6rJkLth+HGDNB8O?=
 =?us-ascii?Q?zJjbtpgo0vji7vB6jUluinkQGXoZhuVGmcuTZFjOAgWq6bK7iMMHHrugiUlD?=
 =?us-ascii?Q?PM+y2G1azZHPK8PyqPcZJOGDOyIjMezejkAsoO4WGDnbaX0F9tvbIJqWqJ6P?=
 =?us-ascii?Q?t9h5viqadaWtP1rsfsRbDl6n0ZtXbQFHC+Rs74bBGf4FMJFTWI/JKKOKNxH7?=
 =?us-ascii?Q?cNo+mMm+eDVDz5ZzlXRMOQyJFotpck8jmwjSLILvpPGSgFvnu2EQTbt01rAc?=
 =?us-ascii?Q?2DG8yAWq1ZKPnsQW5tTw5pZANy11pFznHOOn5ImSIhBvBOcKagaU4CQHK4GL?=
 =?us-ascii?Q?lkaCOFaP2nxea8V80gv6GsWjC1emsmlrAMfPa0Og889D8yvLogDmOnLaLktI?=
 =?us-ascii?Q?z6+Hjf6Vy+6Y56vYrFoqzOLoMQ5fWRd8eDEKYWmLUppq006zCdOGhmfg5oyV?=
 =?us-ascii?Q?lRnBZYY1Bg3Pn0BgHRFFpmRIJ0rRAIg2S3l5XmTHbfuKqECd+eR4QTPwpYgl?=
 =?us-ascii?Q?gLRnoviO6RkqnFvXXc9EfkEDUmC65bH58uoNyEKxUjnyFqcXwAedcF7e/Nog?=
 =?us-ascii?Q?HGXNqP6o7tqIERvFZaWbpITt0OtMlh3GcQ592mmU99i+bcHnQn7fB0CWkY7+?=
 =?us-ascii?Q?T8JWaP71/jt1rRg7xwy7FW+j2Xa2pf18XYy/QEM1RACxmYShQhBkv3Ggt09r?=
 =?us-ascii?Q?f7bmTqVBS3paAs8H7Cj2NfwgwlFwK8MvSlB1JZMaPX0pVib58dKSp+zamI8G?=
 =?us-ascii?Q?Rm188TNWmvd/ONuNkseVMhCtwWH2VSxZUVaEjfsB2jrOTxXcV99ZHPFSEuew?=
 =?us-ascii?Q?VU0ppsg727QAEUUEgRXjElmWYZG+UCzO1S2HPCW8yO3kTOGKlY9LxhZpmAl8?=
 =?us-ascii?Q?EqmReOAbXer0ojfLMR+xdi8sWwJwOhlfBvDiWl0c3MK+f0CqqR55D/IlBmGb?=
 =?us-ascii?Q?FTxPrNoU8hxkmqYLDtVn6RseHGEg24h7M0G8h3JDa9zBPYBb1T+KQm84h7DS?=
 =?us-ascii?Q?opGhbcSkxRQ6+CJQRayr9yWuU6v4Lrjy1mRpG/MkOAlJav6GF2sXK/zOdE2t?=
 =?us-ascii?Q?56hNJTUzsBOxaEFcn11RYgQMuP31/nJ5bdyj1QohgCHHDFDWl/lc7jEpQ+6/?=
 =?us-ascii?Q?oXI59R/en8Bt4hql47O+12JLgKrDUmTjkYK+2mLzkMLN2pFLeLx03gdYU4YJ?=
 =?us-ascii?Q?5xP/nF/R6t01m1+lqXPXeC8GZwowLw8VGUTV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:25:16.1864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de7e9969-bbe3-4d44-9f5c-08ddf1582c7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353
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

SDMA 5.2.x has increased transfer limits.

v2: fix harder, use shifts to make it more obvious

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index a8e39df29f343..bf227eadbe487 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -2065,11 +2065,11 @@ static void sdma_v5_2_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v5_2_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v5_2_emit_fill_buffer,
 };
-- 
2.51.0

