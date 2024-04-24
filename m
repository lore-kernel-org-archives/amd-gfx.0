Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD39C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 02:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E684211378E;
	Wed, 24 Apr 2024 02:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="idlljdm7";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B2FC11378E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 02:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMAFgxNlGk0aPUC84VMHInWkbatH7wl60j9Dl1XqJzlAPT9gTKYiI/cJOgHZQvl5l0oUICEE9XdUF95kr8xGWGUzJC0AWpa/rwEt0HohAkk8dfQFPN6p/z/7HUiA1zVPvx/y+qnYfi5RJ2VoMHd8gsQls905pYMNWTeDibY47JkNGgo3Mz2WZ+wFxErioEGnXEXq3w6i0DzVLjf97P0uEkemdd6HMZMhbYpq9s28YWgOrI9Mi6DVLiRxUPb0qT9l6PLopVIO9DB5TofehbpJetqoZM23OaE9cFA/CCXNa/W644hIw9o5HFPxUmhYOoXglhCns6Pp76BUWU8xY56iSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGAgzziazlWxv6ZUic79hyHA3E2RUZ1LeXnZApIuyjc=;
 b=QG/e6Z9Vtmk2scj5WaYL+kaZABNP2KeUWpxIndCzrgBmieGRPZtt3Gvt0fJ6ltwhZa/KQNTfDCbXbJpdY/Y0jJC+Quz/OeRxAKGDxbZm3pn+xSAfuSL7tX8z0blLrhP2xgzNzGbKbG2QziUmeLUed87Sryu+j4k/pb/SQTdRzOJf1Fl1bMzOMRqCH2Ix8xnuVav47Z7BcfMceJ8ZJkfw/byZiFLmOxUrPIzORaJR089CcewgXtnonvGxyHmXEaz1JnrLWUEJqEZ0gJxFLSdnhuO4+T1C3QLeWGTeQ5HRd77AFdKwi9p2m3mAEWTyKGg4ceRF8W/XNsh4HVzE5cEoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGAgzziazlWxv6ZUic79hyHA3E2RUZ1LeXnZApIuyjc=;
 b=idlljdm7RS1cpnlsL4tmWVUf5MpKOxXbjAJIqtADWxueL3U7SfrzSrVlDHgbFSffLB1mmMC2wufXmgNVVZeBFI08QQ7e9uC14mLz/Ve1QXPpOklzJl6GjZnKquoOsrQwOcRw95ist7VZShCbBSMOhmMoFqCk4xnQdrLyMLrgQ/Y=
Received: from BN9PR03CA0317.namprd03.prod.outlook.com (2603:10b6:408:112::22)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 02:50:26 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::90) by BN9PR03CA0317.outlook.office365.com
 (2603:10b6:408:112::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 02:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 02:50:26 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 21:50:25 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: skip to create ras xxx_err_count node when ACA is
 enabled
Date: Wed, 24 Apr 2024 10:49:58 +0800
Message-ID: <20240424024958.3290503-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 174074f8-51be-4152-bbd4-08dc64094ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UCegLc+MufLXds6DzZ9NHXhfNWJnWeJGDmlec3kxYu65VPgYnwuZHvZ6XlpO?=
 =?us-ascii?Q?0bjXyDVZVgvuXFMg82Ar91Yrqc+Jq0jw1T1mLFxePPqCxCPUGXMmMCI2ONv6?=
 =?us-ascii?Q?TGg/I3eGwf/SdKA7iM/qBaaq/EUrNUvvWJ2dKJOxAW6itZeYSykNRbF8jVt6?=
 =?us-ascii?Q?68Nnqh0JQ5nLcAOkMh1eVGZvHLLhPkWnlsHU6azFTxKiMVRAZ2LusMHiji8D?=
 =?us-ascii?Q?GXsOZIYp8zKkBmCn/LH4eCv2pFeH/reP2U8jxyURGvszbBKMWCvUYpYBHWw5?=
 =?us-ascii?Q?wCMXydj40gZO1vIDsBBQofvfNeEwvjFNqqMTGzhnUgAgv+tC3lJ8oCVHmn9G?=
 =?us-ascii?Q?/r2wzB9g32B45GoCkab5IutVpgxLd0K+D/Zq4S6XJNLjzP0ToznlN/yI4bBq?=
 =?us-ascii?Q?BbOx2DWOBhupBmpqtIeJwWSkepVNF6IdctUGdfbLVb5pRr0KY7E+r3wCW8W4?=
 =?us-ascii?Q?DBj2Ib9Lk5v2l0g4TnVb/cnZbVxCSTZ4PJzNixhyIHSXUMGg2tc8tl2ap+5B?=
 =?us-ascii?Q?IgZ4OhPeUTD5W9T+ZY2bF3ZBtix/IyeREQkGFFJjmfDmSXLyLQyWJh0+MqPx?=
 =?us-ascii?Q?ntcpCmQsb6EBOwWtle4zW6x73/WeBWiFJkUkI/wSlF9kLiHy0vLeieggsByS?=
 =?us-ascii?Q?9+6wV8jq5d4EIIBUKSG0q8HHvKUOy8Rm7bMKhzzgyz2ALko8yKqxYgCddG5A?=
 =?us-ascii?Q?hLgVHFMtmCZHvFHD/uD15gPh+1HKKVfUmv2t+oTIY0ulMNIkeUZYfHOUUxSi?=
 =?us-ascii?Q?bWQlKwRbr80zwuNn0u+XGJxY39uMHcjUowQPCv+B/9tjrA7DD63dGpGGZich?=
 =?us-ascii?Q?8RGZxj2GPasCupqWV7whEfkC6xbg/LO7csId/QIBASSZigHvOOyadnEnZEZy?=
 =?us-ascii?Q?h6wDmnPTRe//P13chus8kUL6Z7kQ2tOc3hUn0cmfIAgR/Ri5MSA1wcyQCTVD?=
 =?us-ascii?Q?vighmIuWQzJ6qsGYG03HtlJFETXNZVEwPGMYb7QQ4N7h0E35Pyw3eNSRWMe+?=
 =?us-ascii?Q?PBL8qLXg6W+h2T/vPakFAhVHbVUKPbuDNzXdSY9bAENCFUOnoZ3Gnmxhtm+i?=
 =?us-ascii?Q?DvOlLUBY03HBeARDCJhAimpu0Elo2CH8vpZSKM8zc8IX5nnPpE7flF612uR3?=
 =?us-ascii?Q?iazsFV3zncFAPfsPpUi7/AUj8wlP5rDyolTgmlDco5iVswW/QLD35OBOibHt?=
 =?us-ascii?Q?21XVQJwPPln/5Leao0QfIPbbHLnrxja7+RZNTv4qdvD5/QVbqe+EZG/bzAkw?=
 =?us-ascii?Q?4bDuL/3darzVE9KEVhKVwbVLqP463uiLTpWrcZHNslJaHwdQdTuUlzZn3ubH?=
 =?us-ascii?Q?IVssIVdN+9tJCH5xc/23YcgCJsHZWZB4uHPU3cs8rjrOZL9ocgckDCLD9dN2?=
 =?us-ascii?Q?W4zafFpkC8LcVo+Qe7XXmLzi6T8R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 02:50:26.6287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 174074f8-51be-4152-bbd4-08dc64094ba8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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

skip to create 'xxx_err_count' node when ACA is enabled.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1e2b866751c3..96a8359b703b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1756,6 +1756,9 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device *adev,
 	if (!obj || obj->attr_inuse)
 		return -EINVAL;
 
+	if (amdgpu_aca_is_enabled(adev))
+		return 0;
+
 	get_obj(obj);
 
 	snprintf(obj->fs_data.sysfs_name, sizeof(obj->fs_data.sysfs_name),
@@ -1790,6 +1793,9 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
 	if (!obj || !obj->attr_inuse)
 		return -EINVAL;
 
+	if (amdgpu_aca_is_enabled(adev))
+		return 0;
+
 	if (adev->dev->kobj.sd)
 		sysfs_remove_file_from_group(&adev->dev->kobj,
 				&obj->sysfs_attr.attr,
-- 
2.34.1

