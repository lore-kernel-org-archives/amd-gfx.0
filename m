Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3458E83EED
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577C810E134;
	Wed,  4 Feb 2026 08:26:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y6LKv697";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E965010E134
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 08:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgvmbq/84GFf5lDEM05nw7MnCsEmuYcrijaCmZFBlZ4/1LGlHfCeEi+NbsVMSSH7qdqMdQcC4ACmyyV5/HsgRUQnmpEVYhH6SsTI9YE5VEX88y7XmlVic+YAOzLGDwAzeRSTRe5OwsgyksIghueSoCxLhqfCsktYtnFf3yg/R08TgwLBVkNc4C6EwLuVv+JQYqj42rdz+a6uuU6VknbA65q78mzRs726f+gNmQ0dIUO7vfC3ALuAcLdFEcXFv/LP9suc5fu4Bhoj/QRiSaPXETN5YDM3JyiP3wZhL/J5jRlPZRfN5n2PQwhS0IW9F6EzVEmFWhgyVOUVkuGu3kCxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHR4SYe83c3t0ouiXFOi0ep20lqaTypaZIf6uoO/TOI=;
 b=EEoYE33mtZhtSAVpJIHTUb4Aowb9Cp8l8msoCSEITtXYMgkX8q5mvZxb28RWCX645opeHm4pHRofvNn6POuBR6qFRjQ55aj6Qk9oB9gZPdcpNDwa369ZNd5FaZuV5k62owDOyKCZ2AXrEUFC7RPqFRsEmM7Z+WNKne2fjmeoPUOx3qQtgc2CxFmjmCWPaFNu3v3iZP8J6//QCJitvTEVhEs2nDQUcc/jr35JodQyO1qpLij2J5RtPZ61woBspXb8QPQQupuXD0wZIsFgZGxmfVl1gzthkNGB494QHl3rsIm4kqy6ZUgPpPzLEprDh2aQhKhZvIY6RYtwFG53kRLwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHR4SYe83c3t0ouiXFOi0ep20lqaTypaZIf6uoO/TOI=;
 b=y6LKv697YKKtRMVBpOw4YWNCQ5M/5Dnyi8Z+CGm5DQX10aZNLrzBErwiJwVJJCwFQq65Seq7E32yrlwL5dpctrXPzlk3DJeQW1/sr3ge3jJZR9Zkyr4XYLY7hZOMdcHZcP73aSzQGMaoTuZnNEaTrjXcE5z4EfOLSs43GhlqkP0=
Received: from BN0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:408:141::19)
 by CH8PR12MB9789.namprd12.prod.outlook.com (2603:10b6:610:260::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 08:26:06 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::63) by BN0PR07CA0013.outlook.office365.com
 (2603:10b6:408:141::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 08:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 08:26:06 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 02:26:03 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v2] drm/amd/pm: Remove redundant and incorrect multi-vf check
Date: Wed, 4 Feb 2026 16:25:47 +0800
Message-ID: <20260204082547.3799740-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CH8PR12MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: d85723aa-275c-4c1a-92a6-08de63c70a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YJ3mcEEJZ13rVsjIrVT7vYhstWeDOp0Joq7Nf/7u2nEqg8D1bw9MvIY1Voo0?=
 =?us-ascii?Q?dMdCOBkAXP03x22rojNUQ7RCvOuBW+cZLMGfuB7lUGKOM3AU7B7Pmngd1WnD?=
 =?us-ascii?Q?38V6sKdLjLDGOg8wdrZlAjBPMKLvWFvB1SkDegCmNKvt3EHk9fwELAtEyYqi?=
 =?us-ascii?Q?o1ofOfNnMZPcBFXoj/cNqiVscnEcFYeqSv0kLXNDFoqW7K9HDsSvw/RrjUyo?=
 =?us-ascii?Q?16AZIwpRCKG23lCf+DZBUn7//ntv2v3QtPfBt0rHNRrnC4/OUIKTl5wEqxhR?=
 =?us-ascii?Q?QTj5RpZX0UP0HNrSGT+Q9v3W4uzsR+Ebc98ybAIOuJWn2SJ/DaHBkbPyuEnQ?=
 =?us-ascii?Q?uyt/5e6YJqt+xr2b9hwVadvEoP0PMAbSYVz6sWL5i7YzWJfhuw5iN5OQk37b?=
 =?us-ascii?Q?CumKGQJwh+LhLclgzX7dMaRBZLTawWe50E+S0JH8PBYnS3jKNNrvZ7hQb3HI?=
 =?us-ascii?Q?qLiI7MNxTHi9xg6pejfmED97mxN48aeV1nHoVsNP5HVLhSQxdOtTYq8F6W++?=
 =?us-ascii?Q?+fbwvNkE9rw8/sid1eMbC+LxtLeaBheUirNNjL9axumR6UpeSwd035oXmbar?=
 =?us-ascii?Q?rxji4wws/Wo5ns6cbmrpsXYcRzuDxoVV6Q1nvl1pkNqeOPtaSfR8kiGrUEpT?=
 =?us-ascii?Q?kJugfJWYoi3tsUpVtNirPl6ou4DRwc8KJNQxLc7SjITpKtqB6lBz86NwySvG?=
 =?us-ascii?Q?EmQV7aEH5CFpwZ+OfF/e6EJ+SmY94+elk7AWhj6yIUjKXM3DHmkX+9MgG1Tr?=
 =?us-ascii?Q?wK8GEPvDlkJsx3TIxtYO8mdKSHdO8SMPzukdfeQ0RU8MScYqjZEMXd1gNyq0?=
 =?us-ascii?Q?v4I40mULZIbto2o0WbV3UD1NXsGavy8kLPN4oFdY7rpW1vNP8DbBVSgPs99R?=
 =?us-ascii?Q?vXXg0cz7lukVBydWfUcYZTnPqcSt3hfHZ1mrgWhTlVmMjo9YiklNNg5rYoeW?=
 =?us-ascii?Q?2hOCry5I5MPLvsaVA0KgM/mza6lfo4hSq5W9un8ETvy94lCJeRZpFbyZ/vrm?=
 =?us-ascii?Q?9ET4h9gcj2L8lRHPSAlBIpYkl2T3D1Ll/xJFHYxkgEvyq41v8cw6KQMQD5Nx?=
 =?us-ascii?Q?d8WxNK9LcoP6ES9oP6psGIz57X1LDdbm3ZTnoSvMjvjP6xfWazFRxBdqDzWP?=
 =?us-ascii?Q?jTin5zMYldBEKN8+nMg2Jzlj9hy7nD1nLh94AFenHnMSchnEc22qRXBXqyw4?=
 =?us-ascii?Q?4d/oSIHa+qniydUBqEOSnm96pCKuWogVYYCWnqo9Ki9l88PsK8xcqyjvwkQO?=
 =?us-ascii?Q?JJS8xzzA/km8iM26W0lQ1kv3OF4ax0jpwNifK0TLgVW090YLLRci3lwvtvyT?=
 =?us-ascii?Q?+EfFMwaGgaUojRcayItOoTRRExqOe7e5rZLXR5VjedIvSGGs6XRE6wMhBDrW?=
 =?us-ascii?Q?e1Rtt5is4nXsZ9iI/wAlgo18U6i6UEYqJyUhKHYKTjIUCxpIeaW3N7Xrp3yQ?=
 =?us-ascii?Q?bBR2Aw8ua6m+74g8BvWwc3BE6qTlIRJb5y/YGRe1FE7OVgkIKTQ6DCNqMDcH?=
 =?us-ascii?Q?NJq2NktJS3fDGSQUzC+Xrec9+q1uRmtSsrwfcfTqFCNCx5pl/ye4IBFEdKgI?=
 =?us-ascii?Q?Z3HZoJCsAl8rbovdHOEpww4iqO2LF5dg99XA9CybGsJYm21e7J8qUMN2xgDO?=
 =?us-ascii?Q?D75mlK65d1RS2lOWg8FYFMtSOCzXwVRUq7eszpYlYHdk/15zpzPZFWyWuiD2?=
 =?us-ascii?Q?D9dpAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kj0fWuOz8xBSwZ9u7jPUJS1wkzhaoeN9laEghzkaQfWMCw9Ps5Zx9DR0C9kwEug69CKUz4bnaugNz8Q3Wj3FE0TSYTyq0yXDyJrwYIdi9fEF1SrOWmjFmRu5Ysx7LHfORm7PR9PdlLfXdgEUWX03VWohD1JmQfp/3OVDYNa/Dys8QVf3HK0A0iA015TNSTEND8ayGtSxqQDpchHpuHrmr/R5iyBb0HJLoRWyXy8QHhlFkC3ToNgioKWJ9W7mUWEPJXDAkDNH2vSArcDKnEYDIgPbRCFOcssHcpJhnGJ2N4oMwhYeLK5uxRHw+b5UYKHeE0kOqI7/yPWDn6DgsWZE9B43SCU9S7pF8JcdIVNgOnFIesIKMN3/sWUOMGfNV7C8Pj3qrPA6/BLGVRPvAeni+KsIKYeV5sOyTnVOzWAEKg8ANzC25XU+EF2Y1BZBHnvw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 08:26:06.0443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d85723aa-275c-4c1a-92a6-08de63c70a9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9789
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

Remove redundant and incorrect multi-vf check for pp clock setting,
as the code path will never be taken. Mask check take care of same.

v2: Update patch title, Remove the check (Kevin)

Fixes: 166a3c735c95 ("drm/amd/pm: centralize all pp_dpm_xxx attribute nodes update cb")

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 07641c9413d2..81bef5c5aae9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2057,12 +2057,6 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		break;
 	}
 
-	/* setting should not be allowed from VF if not in one VF mode */
-	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) {
-		dev_attr->attr.mode &= ~S_IWUGO;
-		dev_attr->store = NULL;
-	}
-
 	return 0;
 }
 
-- 
2.46.0

