Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4026BCAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 17:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D92BE10E3C6;
	Thu, 11 Sep 2025 17:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uWsfCmqg";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8C010E3B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 17:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddcmxNSKkpbL0eX6yBQupLHr8duHMC9HJ9g845LG+0JYmiM3b7UToRFuGfsMN6+1U/DDHff2OZPstjSDSOylou1j9liYlNFJQYBpif2LLXG9xj6pPCBVgvu5wO9OvLs4g/trcQNNG39QoWL9oZOcuTrmK6BvOV8pa2THFZhGxZYoEtTFMe5mZ3DyR1U4Ft1KFmPa0R9MuAvjYeCmugPg5Ud8DUqmEFYTGAXc2QPut8BAaJiOde2FBEkBkhQZp8YJyWdh5klP0u7+GckW0FEsACTN9/hRYeDMl0+oyKwRbdCOPdlj/aTcyo2HjcIB6X3av2BmSYrEvB50amCJkApQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azqXBQl7CKSJRlPrPJjjm1R0AZX3gWOLOsCwhW2CSQo=;
 b=NKytug4rrAdgDYaQKdubPAl85tsnUa3U+z/FdSzM5Ma3zP+7sCcnDjvBnu0zGDd8QVAcpnMeWN65LHxnWrwN8/0poC7ZcKfp5sK5qtWSM6BLbuscUOYWvs3nIwEUfm7dAu9LpWBV2AMnUwrRzTBd63dLmDnPsLb488mx7kvdm96XoHwx2zG4WGnhqOkGaHbbVixIDp1qkcAMx/RI9JgJBHsWvqBbraHVB9vw9W5MSVP+weA8pAhQfbecPWi2Nv1rghhQZdwYigFqjddw/To28Es9E5cr1JgBm/qTVgvN1VrdwpcAZ1yx92yAJLiPXZutV6XDfN2HxAgfw6iHCnWAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azqXBQl7CKSJRlPrPJjjm1R0AZX3gWOLOsCwhW2CSQo=;
 b=uWsfCmqgCOlGJxNobA/6PZoYbVmfFoqJWFYRdW2tCg+AMdOxCQwfF6JKqEn2e9GPZmZzwspHZvY9HSjrngc+FvCfiEOGgLmIqJhjchWtIV2+xxKB8gtN8ucm+qMkzkbV/qRwcUkIYImmvtZrfLC7LHgGL3OOIywnRmsmp9Qgf6k=
Received: from SA0PR11CA0082.namprd11.prod.outlook.com (2603:10b6:806:d2::27)
 by MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:25:16 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::33) by SA0PR11CA0082.outlook.office365.com
 (2603:10b6:806:d2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Thu,
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
 2025 10:25:07 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/sdma7.0: adjust SDMA limits
Date: Thu, 11 Sep 2025 13:24:49 -0400
Message-ID: <20250911172449.3340848-5-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|MW6PR12MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 61fffdd6-d1ca-4be0-0d52-08ddf1582cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Omk17Z4BcFR2ujl9S3Quw5YSvVshgOpE/r6d0MS3ZVSuuRc2NzHOuQSo4g1F?=
 =?us-ascii?Q?iB/W9MWFRnFt+Eo9e+ibr7KsYP4I7JLW469HxU6midDv15MuFvCPbaEs5wH7?=
 =?us-ascii?Q?9SdWuW5Zph3QsbERrXj6xPFiM6DbB41JZsw31iAbt+KGaIex5LoTxy0mjDX9?=
 =?us-ascii?Q?CTM+A+ae4qLPUokI9wRGnwQoDiboD6zozlvxB/js6va+xwsu2IJnmLlR8m0S?=
 =?us-ascii?Q?HA2yapzIVisQG4yqnINY0JJtS7H31MCc5nS6luuW5EpLhmfwYxrB6/yDCr56?=
 =?us-ascii?Q?92CUQNIMT4ug5Zi3XsyGeYYFtbg1c/jOFv0W9ij4ZNADfHfAmSEXk49HURmj?=
 =?us-ascii?Q?a00wN3PQ8wkGCxNrZtzIa6hKVu94z8ch36F7taOvoGgq0J7imciia63rBqCK?=
 =?us-ascii?Q?QmDTkj8lb41OeYMXQeD8gU3JHW99D5w3xoHCQA6sQO1TmXZ012I/oe0uQQTs?=
 =?us-ascii?Q?XJCUXdqG/Qfk5ttcvBO+x+9EPUFLoOJM6Kb6d49lDkYSpZwuzp2zIpV9m4bd?=
 =?us-ascii?Q?tKDjgEoO/6CAZqjiE2knBVeBl7o/TXeLxkfAH0nVTXGpl/GA4cOD+kHs9YZE?=
 =?us-ascii?Q?HSAj+wi0GvApdA98FhKHDdSbge5dSVlCFvJw8UXN9A2Q4g1ZYGvAmlWFg2XR?=
 =?us-ascii?Q?S4dwr5pV6LBo4DSaDsZDQvCMIWjI+NGBtHBPk/ApCpVR5o5d6wv2WVVOoY+h?=
 =?us-ascii?Q?BPn4DU5IooQmA1+flqUMuO31P4yF6EM0bQt/ftW1YJAaIYJHiCuYpzDg1Ym5?=
 =?us-ascii?Q?alsZNbf795lVafqtk/OmzyOC4HWSXkVfPm/GbI6LmtqmrFEZHhPLC3cm9Bke?=
 =?us-ascii?Q?RJTc6apZFTkYbDWMIyoN+mFLKF2Gec0l7T/+JZjpnvQZ8tg58YAVa5h6phBj?=
 =?us-ascii?Q?+5yfXMIFgdZOkVvpjyrzZ+hruFXvt3YXWD3mZuNMn5DrwH+vD+h1YwCh4DSI?=
 =?us-ascii?Q?i58Tr3GL0PicMiOMXQEofTBIFpsdh+0/X7zZ/mJsC+rEaH28RLGie4C3iWsV?=
 =?us-ascii?Q?TdC8iSeRQ79wAQjkRd8RkGTSCJVuZml+Kj6vWl98PV0DXStT2m8X7nWT1d1b?=
 =?us-ascii?Q?2Ft9Fs7mHYVL0ht6evTjgw1jbFIgxU8Smg5EbsbRwSDVmqOXS66iAWzk+MIv?=
 =?us-ascii?Q?+Zvl+kbBiD9o660qd2CKffcnK0lai2ZAaovflJKEtcOJFE/6UUYZsSiCS/7d?=
 =?us-ascii?Q?mU1kxP1smEF7jp8hPVrjoZlHhDXFTdumc1+qmGsMz7GN88FB1sfa6JHz+O4c?=
 =?us-ascii?Q?+5gNCd24QTYFhLEEJgOnfn7IuhDCksN7Gs/8uJ1QAEr5UP+5iw3bmzChbwyA?=
 =?us-ascii?Q?LMJyDfznUuohS6dO7TJ5GJXGHA8/Tul4j8wO1fzryWYDkfn5ryLx7XCLsxhu?=
 =?us-ascii?Q?u1U3yCyAeJafav+ipGp3TgX1lzJ9JhQLGGVJLw+ma+w8K+pE1aLXjXK8xnuj?=
 =?us-ascii?Q?78IbUxOBhai51bITu7kfQYAqIwzfdzPHqvl8KpZ0Vgp+DJwjdXdoGzHCr15w?=
 =?us-ascii?Q?TnUQWjHseuXQo/w4SkWEgGN8s0eNnFfhPzZr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:25:16.6988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fffdd6-d1ca-4be0-0d52-08ddf1582cce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759
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

SDMA 7.0 has increased transfer limits.

v2: fix harder, use shifts to make it more obvious

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 326ecc8d37d21..cb5a9daed63ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1816,10 +1816,10 @@ static void sdma_v7_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 8,
 	.emit_copy_buffer = sdma_v7_0_emit_copy_buffer,
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v7_0_emit_fill_buffer,
 };
-- 
2.51.0

