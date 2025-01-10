Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0048E7719C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 20:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 473AD10E526;
	Fri, 10 Jan 2025 20:12:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uxrEZhQV";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B562110E526
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 20:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wE80lynPcNcixXL1fL8IO3m7foRlE5ASA63Y0TIIuzvwTwLtdKP81H88iEZdm/cr8uoxvk7yC1cGGsuWkeZBi1gVaJecuUjSqaXkvJCpV+wSAT8iu1LE7o6G1fIkEeH1w3jO6xLUrr/7U2i9Rlqx4uhq7pBI/wLIcklcVrYXUNz8/PKDDPXbXUnYCnCJwjusE0tRKlXz5tNn2X+9Cxr85owGWO0fjoAIQS19aRhQMuM73MWKNlw/J7e/OGByrqoYfMz0zu4Cc3VLfD/Tgb44efTrfea/SWiBteHRB6e9rFaV0qqi4Mg3LkGy1FTf03lG1t0j7GaMd74NXvABL5xQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smRF8JyUpaqidSuZJDpAkylM+JzzPzO4YHWUYYCS1pM=;
 b=RjH5f7o5+4g3Co2/HYTfUPcEhNYGnvREDOrR6NPjuTr54LUMAtAISKZ2YX8ZF7ZlXpMhXi8FwWcogJlyCfMsFHzKI1I+8GH1e5qbj/ngpsDL5ecS4UmrMZdaW5SFPsVl8DQGypeaVqosEaTd9AMdJq7+G3ptZzab/NSFhGwSqs3fU9ugXS/SZBwK6cyx5ciQQvRH+3YE9zia6Tg7nPLwRv8BoVqP7U1ZUvG7FBEBBiG1YfviN28KxNDophi4oijKr+n0iz//8d8n0YCJ6PGc103Xe6pg82ly0PbzD7BYkwhynaiBbDUd6nC5YrnXBcBd8dMdwsiVdelkiiO18nwUYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smRF8JyUpaqidSuZJDpAkylM+JzzPzO4YHWUYYCS1pM=;
 b=uxrEZhQV3YrTsuJAZ38uDn7SqCnCUebyPjIK2DzFRIH861qnATTB94czbPH/psLQ0vj2VyoH1c5AaEns2n3l0ICn1vJ/LQVxQl6PmXozToYDKVvG76n9tmJ0aFU5WN8/bS6S+xVrjVxWGbwAtQroilActVwX8EwqbrTXk1z1AEo=
Received: from DS7PR03CA0104.namprd03.prod.outlook.com (2603:10b6:5:3b7::19)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 20:12:41 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::58) by DS7PR03CA0104.outlook.office365.com
 (2603:10b6:5:3b7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Fri,
 10 Jan 2025 20:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 20:12:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Jan
 2025 14:12:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Amber Lin <Amber.Lin@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviwanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Set noretry default for GC 9.5.0
Date: Fri, 10 Jan 2025 15:12:19 -0500
Message-ID: <20250110201219.3826922-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110201219.3826922-1-alexander.deucher@amd.com>
References: <20250110201219.3826922-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: e602582a-d305-4c9a-0046-08dd31b32316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0ez9LzdjKPfCCi0tnuDjlGDq9QEav2C5ky1liM83jlm6csQ+Rh740gZLmBUe?=
 =?us-ascii?Q?XAni2OKTt1fLqmbIZTU1iOr79Xch5L1ZVcU3UxizkWFUACt0XfGSSsBnivIP?=
 =?us-ascii?Q?u/beYe/5TSkUhZjwRVLjtt5uF50J3imxENu4pyW/YhrUKeONUiYSI5AWg+Eg?=
 =?us-ascii?Q?IKuoearjJWoyZvEq1kTh1Ua4FJCvbfa9S8x0gFoI1lVM5NPB+9qyy7EaHoHn?=
 =?us-ascii?Q?ejNHyM68IRysUTH3+Pj4vdxGX8St/aebvJX8EL+/5ybzX683Bm/X1QpvbOs3?=
 =?us-ascii?Q?igr/NGJZOg5fKO4XJskGmu5VQ6WWPRfL/1GfXkyOfeIQEZldfN5e8u6xgfn1?=
 =?us-ascii?Q?Gy3sPLM47p6fO+QR8WMexMAxnPUSo2S4EXnkTHEeRCMADfHoYRpNFznKzOyh?=
 =?us-ascii?Q?9/5+TZLUmcVk+w1YqceQCTeN7bqkXrupXkYfL/85kX293VjHdafCOeodRRa/?=
 =?us-ascii?Q?LPzBPU8uUYxpEWe/7/YR0uiAUiUbu/Y2tL/semcddIZUKiT515wciFScyT1t?=
 =?us-ascii?Q?Dgd2K8Cb0qevm+6Ff4zwv5ziqguYi6cztHM97GVgqEnJnrlGc11YIX7YkmL9?=
 =?us-ascii?Q?KHb+/vA2iau0Isuga2hs5bIQOtuIqv4lGh4czdEZmfkqp8qx7Se2DBRQPWKF?=
 =?us-ascii?Q?Y8XFhBje1xoxteopYNLWyz8NBFeffJaTD7/WX0ijefenKA9XOnVjfzFzHwif?=
 =?us-ascii?Q?PBqnTXkX8AoWbE6yvSrcyRlBvAw3oipCRqs4/psU2mNqK8UfwgARgmAiCu/I?=
 =?us-ascii?Q?jG1Wn48xpPmpWd4aU0M5uuwGMI2xgXaH3vc1bLBlQE2oH4BIwIOhDsXfpeCT?=
 =?us-ascii?Q?oTJ/Ia0lqxvczudGiWQHl+iwctmOi4t5pXloozcXuwne5pI5FeF38j5LBnSG?=
 =?us-ascii?Q?ukp0VDDh9UANXQDTNdk5wla9aD3duIMQIbTBeO2xbc8RShAQ6IU/cehgBjzN?=
 =?us-ascii?Q?RXCThLOKGDh3MOSsYBMbmvq27q36RwkNjYPubkgoM6ey6itjIxe3szsQMHLn?=
 =?us-ascii?Q?lG1/2ILHuYGoLPaVIgTprJ4NrNc0yz0gynJnStOrh56RkGcaIYxpTOLwkcRq?=
 =?us-ascii?Q?kOT81KF6YJ6zZNKf+UUOopxF3MoOKv8d06H80p0LjAYlyORZYVlK3k09FFuv?=
 =?us-ascii?Q?gEO4k09UgN0SZ4it2QEf0U19vDNQFbr6vJh9wDfy4c4nzYWLOVWCLgh1bqWT?=
 =?us-ascii?Q?GJVCGBNQDNb8oPSM1ywHmF54tjNbkR41LhpwB/+4D6jOM2ZtZwgh0f+oUFFb?=
 =?us-ascii?Q?kEF61NuHnPzd+1yJKaZPRxQco8P7FSWiSZ/8Ndzru/IuypTH+1YOyQR+IQLb?=
 =?us-ascii?Q?2ArkHT8fft+y8njks+C74/sR8WrO78hDnNVBR3pJpGLzznSvvYF8ouQgC6hn?=
 =?us-ascii?Q?Nfpu2azojMxjhgC/8wqyN/wzAOoEkKYDAtdehlpR9Uv+RKUuIJxSl+QPTXJz?=
 =?us-ascii?Q?XzlnhAqKD0iC1hxrVwKqpE43arLW+EAm8g+p/vRNv3LeSYEWeIYpjg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 20:12:41.2936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e602582a-d305-4c9a-0046-08dd31b32316
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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

From: Amber Lin <Amber.Lin@amd.com>

Set GC 9.5.0 noretry default as 1 for better performance. It can be
changed by the administrator using amdgpu.noretry=0 or by the user using
HSA_XNACK=1 environment variable.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviwanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 1c19a65e65533..4649dbc5d8715 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -888,6 +888,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 				gc_ver == IP_VERSION(9, 4, 2) ||
 				gc_ver == IP_VERSION(9, 4, 3) ||
 				gc_ver == IP_VERSION(9, 4, 4) ||
+				gc_ver == IP_VERSION(9, 5, 0) ||
 				gc_ver >= IP_VERSION(10, 3, 0));
 
 	if (!amdgpu_sriov_xnack_support(adev))
-- 
2.47.1

