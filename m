Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D415CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 16:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F036810E28E;
	Tue,  4 Nov 2025 16:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yZDnbsgV";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7A410E641
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 16:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcU1EcyQEdhx5iunTXFXvA28LtGymf9jO91FpQLKkuE2EFirEKgnfWUscKFxZFg4bt1PQurkWpXH2SQDGYreDmUdMBH1CCOx+Ntz3EI3e+CilquIbB7hLQzTCjdQAwQRlOCLqmGTvgITRMpBbm8v95e521f0Ii/YNGKbqConaxktFB0fKDi5UQfuIdoiROdxbZdGq0oK8OEYYVwE0J8rzVrA0m7DtVLYRT+e53M2/L903hhVR5GT85wdqLTmrIM69neEDNJsLiLS/A2rNU5bsrhW1ZJ2rgeKw/RdcT8gd7iMzNuFAzXFgw369MKBtL+q1eanacYLZezVcXTzP95CUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzO8qB3WOfb48W/OeV6XEkCfE4xbvzn6NzMlkN4HPW0=;
 b=FnxMYk6k2sWu4TvVuuUjPttvtDcMrssEvlMbxA/jgsQuck2NVit1f/6QdMgRuBvkZ9R1+t3BQiR/Sf+kjaZAOIFZXICiKZej58kdeOmnTcqGVPTtRqgI6aL5hRKPXwFySv9r6tvyQnMb2l4G/nc2/V+JGkINwSbSbN6p8vNfHiI8lsP8BVdoS0QBO6rsWNk3QFskiV5K2hK6b/tMeDKQfC+dMiGy/NE5TQQv+kAMklzCbXitktPq/Ai/gddFbB3YcbZXOOc7ZnA1NqU6nLaI4mB6YLB4C2RjpeMOH91ly9bznw2WXjOLPBGS1E6PishKR3GuqTx7JaCsNDzku2Q8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzO8qB3WOfb48W/OeV6XEkCfE4xbvzn6NzMlkN4HPW0=;
 b=yZDnbsgVQDk4a0XnU6pBSQRz/DEKTM3AQrHI5cg8wd6ytM6XpUS1fjJhhz6lDEe6arI1Za/UN/X2xI+1yteUcq0DPhrR41irRgh8yHMk6+5tcdpX0UlH3ZQSonavHL+XFk7HCYx64uVDrRYqf3mv7SR0ss33jM0rnYTJH3oKIjI=
Received: from DS7PR03CA0107.namprd03.prod.outlook.com (2603:10b6:5:3b7::22)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 16:39:53 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::34) by DS7PR03CA0107.outlook.office365.com
 (2603:10b6:5:3b7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 16:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 16:39:53 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 4 Nov 2025 08:39:47 -0800
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/userq: check NULL pointer
Date: Tue, 4 Nov 2025 11:39:31 -0500
Message-ID: <20251104163932.263193-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: 6049f95e-cf4e-4d3a-949c-08de1bc0c7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?89Cif6/nv5f80N8mdIrQ+7vsBEMIKotZbxK2lOsl38hDQXc0gdSPx+uH++sb?=
 =?us-ascii?Q?xvQfJqmxzj06nsxTg5nwiuy+9ldJqCLJC18K6oT+sFgbOnZvNHg2kmVw7l2/?=
 =?us-ascii?Q?WICd6b0WB+IjgX2D0fyJt5fwPcXWb8gNunQW3WKIWMELOwzvnuSbwRyvwp7E?=
 =?us-ascii?Q?wD4D6QknuydRQPw/imQQrYeHJHD2WwIHvtU9Yw0D6g9/lH3AsSSfDeAAjwKb?=
 =?us-ascii?Q?5dnNUNGpOztIN0cn9v206ItgUaNnT2i0goya2DY61r7KTWZiMuBx5W7iriks?=
 =?us-ascii?Q?BWip2dTupfeLRc29MT9jgJWpMk0LZfceiDj1t07mW8hXBjHxhKKgi1NLtygB?=
 =?us-ascii?Q?C+U0S2sdsYwzAC71eNVKeySsOmxOVigZuwCMgy96JpF+rWEsDZ9N6tD15g7R?=
 =?us-ascii?Q?wfrmc0ZqaQLSeKOuQ8AlwyAmj9Rv/elNcaF+FAqTUFUo0ZUkZajPTbJlEWIk?=
 =?us-ascii?Q?MO52ovRHW1J8ZphFHV4MQDVIu4P84pEZKPJgNUggJf9RqYVgK6+n9xheau8h?=
 =?us-ascii?Q?LzINPxP3E+/8qHPcJz6k4RRHECUL/DADV3e0i21KVqpaL9WKQYCkXB5nxFq1?=
 =?us-ascii?Q?ogw+zYr+ma590Z4qqSiecUEs3Uen8ZZua8H1hJtXG3fNQVJMEr8Aa98cf700?=
 =?us-ascii?Q?Nn8EuaUbRCS49nYKKuM/nw5NY8bTv2bcKxPKzA3W798mGe40jiw6iUpkujQg?=
 =?us-ascii?Q?FgxT1wHTcZUuEmXOe6bOR1qUUqQBlzjclxoT1oj8+WUG1UEk4cX/kjS3diyw?=
 =?us-ascii?Q?fCauM1bVWM00fus+SPRlKt9BCnxi9iWsWk1w/lDCjBHR11lmqAlQNraPD/uF?=
 =?us-ascii?Q?KD/lh8lJyo/60/eAfMl6uBebVuzlLAIFX1aayAk23D4ZzOdhTlNkjm5Zk/71?=
 =?us-ascii?Q?HFwBGMWck3BwuCTzoS8iWui9Av4v3pJrYaEP1JRSdb7B1PBhYbRJAW56T7kl?=
 =?us-ascii?Q?Rv8Tmu27wRQo54bJAeacofwXnyBj1dUa4S4B1FsrRrFoe/ND/2B5a+/nsiAA?=
 =?us-ascii?Q?4A+uoxQKL620wUiAV4YJ04wbX7rDecPAxcOqq+9AnUzD7Hm+lkwmqMpJHvSc?=
 =?us-ascii?Q?g3blLsfcz6WBnMyuXX1hCU4ZQVD2OJkMm7i3yD34cJopQaJDyscsdGbJaEh8?=
 =?us-ascii?Q?ruXT1danPGGsiG/WG6oRdfVglmq6QRNXARmqOfewgK55V5reKrbm1C8LB4Dj?=
 =?us-ascii?Q?tJOFPJnid/iMu5dpF8yFIszlBelGSFIGapFx3duGw7OuBdnnzVWjxAnG4y6q?=
 =?us-ascii?Q?KnGLoXrHh5YtYC2yrluZqLtpzszP/umpnbjoGYLAAgF4Ml0ZcTPnrq21dGez?=
 =?us-ascii?Q?X77BIKf/5bsKRgvifacQmbWFm+QQNGreC+vcj0yKAcDYBD1d1+a1Nzjmty26?=
 =?us-ascii?Q?QScfstDFVi+SKkftfo0w8JDlaHiVO1CnkPop2lDzDDb3uLF17FjR6WV2spJZ?=
 =?us-ascii?Q?cd+DbFrnzbgCmr0W9I1kAEgXa0SCtJEFTA7lb5a8cEExl38X3kO87LV43Nd3?=
 =?us-ascii?Q?0wiWim4vfsN6ZuTMVm+QmSQ5dwvHPs0szk+9xJ/BgRvEF+VGMsmRc5MTEaNO?=
 =?us-ascii?Q?NKoAetFo0QR5DM9+/KE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:39:53.5015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6049f95e-cf4e-4d3a-949c-08de1bc0c7f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316
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

bo could be NULL in the vm->done list and the
access of it must be avoided.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cc2f96ed7004..d0ff226c6dc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -943,7 +943,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
 		bo = bo_va->base.bo;
 
-		if (!amdgpu_ttm_tt_is_userptr(bo->tbo.ttm))
+		if (!bo || !amdgpu_ttm_tt_is_userptr(bo->tbo.ttm))
 			continue;
 
 		range = xa_load(&xa, key);
-- 
2.43.0

