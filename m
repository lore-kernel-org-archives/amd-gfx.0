Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DC2C19F53
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 15:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9DE112D1A;
	Mon, 29 Apr 2024 15:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xMP89kbj";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6203112D1A
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 15:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nn7iMIUpS/in0B7IRgwwco8FuKc7Q1mxxxosKaTARX1LSjXQ5AM7JJx7iew17R9C2Q574YUw132+0BfiBAiOfQLDa8SaOKfo/vE69tVN94d/GuV0JZztKbiYATgDSBpkLtpEhtY1ccgp82xCJoGD6+wk1v60T+GIISKXJHBnmaZgzvMWrRneLGc9ibw0GSEG6DOUbYJO5iLZAet/F6FaKp9RAB4dod/K/sduhS4y+h/hTyiD9PSr17bOOXFEZKKZVWvDu/IZbJfxTc6ak+DQPNeB06vGpItHLQIApG/IVwOSLpTEf1g0AxfNS+jztMrQDgJnNdmgurQiP+OcCQKDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trQPIlC7caIeHeac3V2jn7OoF+JAvbSaomMgsXU4L4I=;
 b=J9wBUimc3iWI4HQqfz5ShwCCAUquhgObFCk3QGxChsumIdKkw22nTAuJoh/Qmdj0o0zlt8l9VA3WQaO3LMf8ajTNkENDXuWaSKQXLQgsBd66l30JA3gKwLr4aG/ABvRVx9kXQnmOyIePVdCpdiHxl8D3J87r4P7O3U2+5qKz1whd4WD93baxsaLCAx8IlZT9G0TppFAeuzQHqxaglBNe1WrTU1nFIALhz3HddE+xTE0ZnN2XGqHtsoUuSsO0i45uqmcWLGNoVClnRIC1zACq+U+YVraJizlZkIHe3efQOORWREy0crgqt83+i5+r+yfGdjfzq6IvQJmXHH9HK0BhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trQPIlC7caIeHeac3V2jn7OoF+JAvbSaomMgsXU4L4I=;
 b=xMP89kbjl0IG4SZJNiSu+ub5e7rT8jQ2qkQB3g4+pMGqC8YMlQhwsxVfbNLf+pLvmg9FcVH8SfWPb9LVD6pu/etbo/EeYz7VORFPdqYDNJ+XmP8eittJ8CYVhpo/FAITGX/uNelByIkPz4mpLUasG2XhT7Z4O5pqwlhqV9OFOaI=
Received: from BL1PR13CA0203.namprd13.prod.outlook.com (2603:10b6:208:2be::28)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:12:44 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::1a) by BL1PR13CA0203.outlook.office365.com
 (2603:10b6:208:2be::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.22 via Frontend
 Transport; Mon, 29 Apr 2024 15:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 15:12:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 10:12:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 10/11] drm/amdgpu/discovery: add gfx v12_0 ip block
Date: Mon, 29 Apr 2024 11:12:18 -0400
Message-ID: <20240429151219.3466531-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151219.3466531-1-alexander.deucher@amd.com>
References: <20240429151219.3466531-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: b3787f20-1514-4e98-7ccd-08dc685ed24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hKJdufUyD3uRt5dpFq3RaCR1NLIEbSVi4CRM5jRaVti5BeB30LJIs0BGe2m1?=
 =?us-ascii?Q?iS+OSD6xgIWjn+f2sOrbL+CciCLeiKiYnU1R6S5DYCr6yQg0qErIPYQYg0DG?=
 =?us-ascii?Q?Lpb4sGa9fvs6m0FaOAv3PSHAPJadjsI9w6sHxC2OjPJhmBP+gHP0nJGlhIjI?=
 =?us-ascii?Q?t1jcVi98SlBzDoEE5A3CKVc2iX+2aG0IJnx5qu6wI+deRQhXVSa5bnFifBDe?=
 =?us-ascii?Q?Zir+W2Ss1zvHnKaqMgx2THijhYIFrvThTK1Jbrek4ePakykEJnWSBdF6UtyT?=
 =?us-ascii?Q?JEllMFh92alfBBe11B46tvzw4PaS4903Z9EEIEgRtQjd7JQ8Ge5sjXZC+dzH?=
 =?us-ascii?Q?3U7L5MLVD6Hdm7dkktd9rE1QeJZQ8iLyt5Qu7z3Wf0u6DKfwfWIkvF3wCN19?=
 =?us-ascii?Q?80DzOhamk2u4CRn5cbM5EbHUc+q8Pgjlz3XjeHhJ35X6GOqUce7eUwQsRo2i?=
 =?us-ascii?Q?/ZaktObB3M58UCxRj1vHWowGnLnQPq8r44mJ2/7tVaTc4CrEHfDWp+7pfzig?=
 =?us-ascii?Q?GtrSfLqEUjcby+473vdpLsUn13yc93jTxmK4wNDoNvc7ccRa5DwB1gWjDvPf?=
 =?us-ascii?Q?V+65+kPkAGD59822zsJvam4J1g2z8//1+rTPYKZguHDuXyISLxU7u75GpmfX?=
 =?us-ascii?Q?rfu/nSP+qnLGINEsmcPUT1PMtGSQN5kUc0+8c1g2PUbcVrPN1SKtPCWBKsHc?=
 =?us-ascii?Q?uJW4B6CElq4UDkyC7HCS70b80p7/Za+TWh+FmsqqcZ6Dt/BGfOD3Q/ZEYfwo?=
 =?us-ascii?Q?FSWB3oL+wFJ6f4inVtyudcLZxSAg4xijOgz4O6+G6S2c+LMz3nYXoFEpTxv9?=
 =?us-ascii?Q?3fdBif2uOTQ0D5QCZALfdm2Q5Lkk6mEan2aZqeXfu4jZe6kf7qYL1Yycmk/T?=
 =?us-ascii?Q?hDW4vQKj6jdKsByx/FxZUFL+fwHg4Zka0tkXMa3qBX8YQYnD6ApxlyunH/Bo?=
 =?us-ascii?Q?4/bD17iD7d7hFMYEzn2C+eNlSRT+yPmsWdS3BgBibzbq+jENodWNrAwjuEj7?=
 =?us-ascii?Q?0Ug13KZFtIVVqYdw9am6wHzBfhOoP5OyBWzcgqiaRyOyzGSYEoN5/6XiVUHi?=
 =?us-ascii?Q?bKCBpRQjDb44V47o5ZF35UoPyaf0Z6wOmURlb3m5jr+7xr6kICsddYuxwvZg?=
 =?us-ascii?Q?0NVJASB6Z/EYo1IruSy2btAwxc/bUU7K7KapQ0QVd3k5CJmLB5QKbAfULbwG?=
 =?us-ascii?Q?cU1bzvc1S3O/Ue3r75Vuvz8PO6iayAxVi8ARjyxspovaxJMaOWTKl492KllU?=
 =?us-ascii?Q?m5jl6uHUeUudLjQHH6RS/9W9uuWGZF7uf5ZLl8SP12qBwbkxfWggNDNGQ9F7?=
 =?us-ascii?Q?nrD+ugv77bVNRf1gJ/ma0yFoSmTbNXuuFX2eCR/l4I/jZzCSgzQ6Dzolf7zV?=
 =?us-ascii?Q?JaIQfUc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:12:44.2113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3787f20-1514-4e98-7ccd-08dc685ed24b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172
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

From: Likun Gao <Likun.Gao@amd.com>

Add gfx v12_0 ip block.

v2: Squash in update (Alex)
v3: add exp flag (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6b240f6e98b7d..3410fa7022fca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -76,6 +76,7 @@
 #include "ih_v7_0.h"
 #include "gfx_v10_0.h"
 #include "gfx_v11_0.h"
+#include "gfx_v12_0.h"
 #include "sdma_v5_0.h"
 #include "sdma_v5_2.h"
 #include "sdma_v6_0.h"
@@ -2037,6 +2038,12 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
 		break;
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		if (!amdgpu_exp_hw_support)
+			return -EINVAL;
+		amdgpu_device_ip_block_add(adev, &gfx_v12_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev, "Failed to add gfx ip block(GC_HWIP:0x%x)\n",
 			amdgpu_ip_version(adev, GC_HWIP, 0));
-- 
2.44.0

