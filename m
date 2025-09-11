Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D715CAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 14:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C9310E36B;
	Thu, 11 Sep 2025 14:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0USb/dP3";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 652FE10E36B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 14:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UC+JtyyQlDlf7WSWCIxzteVHLl/iQqEmtNtVhsKaxj+kVYIlFxNS4lw7tvUwv7hewYZzgVNKawqudJCuTTXQgiTCdev3mBN09TZk4F8SV+ikFKURF7Wr5fYIJUUt/wV3oReS1YsVO9BiiAuRfAeqb7xzfPxp0dR4ST0kKrl+muK3Pi1QoYg55IXqcLfjDfF8Khj9qQ0GRd8erqBuwJF/ChQx+PyLTh5NDKyTX8OulHD0V+bo6e3csuWbwdP63F2SdwCfmGaMwwm28MOJnM5EKPjE9qPRPq3UfUwG1JQeFS3bEgA6qJ1VhKxuMtq3kRkq/zllg2B2VEwZZbQR7ArByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8828RIFSHV9MIKv8RO3rDBe+FMGRHfBpMSDDxBkfA0=;
 b=IOVNJmuNskc6Mu3/Voa04B6AgYB07ERv+lXl9NeU/XcRvJ/pBgyp3ilUQPY1iDKNJBXz/TjIZUb6bDfIdev9njr3A5WFLKyv42QxklRhXbwXbE3V5AEWnnXWMQkoOjW7+9DaRejiMvfFEUTH+u00hxIeh1Q6/Tu+cjdIiE1qLtN5pd8iyowLGuxl83G667NcWn52Y5bW9nQ7ZBnEvZiypvLKWnGrr+BHVldFJ9BOdOI46H8zCsPPi9wu8yqGC4DmdDOhazf/Tgsh8T2QYdTd/Zd+BKxBhiT84AkgHnZ9+Dnt9phlzIO0nEsNxDL7qUvowvTohUL8J6+pi2Miuw+lWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8828RIFSHV9MIKv8RO3rDBe+FMGRHfBpMSDDxBkfA0=;
 b=0USb/dP3GHnwsmgjbQ7OxAuyc1wt6yF07Y4VlqxwQ0NS6vLC9LJO39jJkFXja0zkxR5vJW3qVXGL669RiekDOqnMt2sx1KTa6b+FekSrKLU4CEdKE1tk5spLGqNpurhcbY4j694bKHXeuujbiYTAG1/eAVN5AlQrZX+P8WOvncc=
Received: from BL1P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::23)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:46:28 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::8c) by BL1P223CA0018.outlook.office365.com
 (2603:10b6:208:2c4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 14:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 14:46:28 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 07:46:27 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/sdma5.2: adjust SDMA limits
Date: Thu, 11 Sep 2025 10:46:12 -0400
Message-ID: <20250911144614.3338953-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911144614.3338953-1-alexander.deucher@amd.com>
References: <20250911144614.3338953-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: ea53450f-8e6b-461a-e811-08ddf141fd96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BnXYes1tf2BVyfpJcyN6rZ4mwqywbwDFOrLuEPUtOmhBhIdjeXSID3KP/aw/?=
 =?us-ascii?Q?5TprceKPvfyZcP4v9GP6D+H+83C9a3HdjSAb82e8ATJoDuGmmEzmft/HQobH?=
 =?us-ascii?Q?fV7qaYAczoZYl4SjtY81AehkzDQmmIQ48/Ge5I5mg9VTUZHgWcmiNtD7Ao6V?=
 =?us-ascii?Q?MkIgubl6O6LiOwcgOf9t8s6ws7frcnjlEEW9ku4jBBMufDuo34ktpFK7GGTa?=
 =?us-ascii?Q?1HeBnQMtU3pIWpPr5WGNmo9L9HLRiMXh85l/s0FP3ukEMz45Cfx1E3DhF7ip?=
 =?us-ascii?Q?nW3bbyE3MDs5ecCP8kx4C0UWgnwYHusW62uAKdvMMAgxwUX2HkXERRCdhYj1?=
 =?us-ascii?Q?bg0oDwHTJNA0LSfJAyG2i2KLONQnbjNBQQfKB0Qvpe0XmKkCd0eAD4ALtO3p?=
 =?us-ascii?Q?Yhee1K4UnRwQdc7OEfbjK+DirI/HgYvZxHtkaH7QiU8yE6tA3KR1UDt3w0l5?=
 =?us-ascii?Q?8I7kE3BoYSjo1pXVnifE90XBFp0ppScV353yRyUFRSy/aTwwhQRYVKyO+G3G?=
 =?us-ascii?Q?ves42QeB0qqO/snXJXQGsHSiHmEwx1iQIWTWj5B9kLCud+1pKghRjiECf6NW?=
 =?us-ascii?Q?MiPmfaqlBkQYB5EacCCpXCBNibBHhp3eqrKtivyyKlt39mNIXGEs0Bgpm7v5?=
 =?us-ascii?Q?EBnKk0+mme8zkew0/zZGDsqLau8VIKkDhFhII8MqZG0C2x+opJTnHfzAlUfn?=
 =?us-ascii?Q?MwWCB/zfrl7rHMcO1qPPs1DxLQuWpptXA84esvNM/W02m9HEyeBVOVeI6Ot/?=
 =?us-ascii?Q?5WHVtMAfXVA9MRC6ferzjbSZjQM68RkZeOTrjdARJEbZZKSEkUGsvMYoQT4c?=
 =?us-ascii?Q?HmYpfONRaU9sORQ5WH5eHgrCFAJZezt5ny+nMve3rPXuXmDxT0YB3cuVK+8J?=
 =?us-ascii?Q?h4Okl0ugowdUkayXBaVA3rxLgDNmqKyGWPYU/DRzwU28o2eFHNHMBgkBPmKC?=
 =?us-ascii?Q?0iVSRHjeQr//hl9IkZfolAwiSCgdUyiwvLPqzNOZcySGOZhNE2mv+Es44n4o?=
 =?us-ascii?Q?bI49fn1AZgaFudJM2afg60g5WdJ1amv/nZp4YDp+uBVjRD0i3FA86BzJa4aZ?=
 =?us-ascii?Q?qt+gq3O2rb3VFvIfVUeVn8wqPxMYm/cIBpdETPjhB5Pd3WEQ01sFaXtw5OJ4?=
 =?us-ascii?Q?azg7PBxfVduOAP4ybGApk9iANizX6AIIQvEyNgNld6F43XA812skba0bTXrL?=
 =?us-ascii?Q?hiawpWzEfmxA1jlVwxyqjuxdFFa4LurVEZu2mV3wgziGdl1amqlDineagflQ?=
 =?us-ascii?Q?+VQSUc3e/RgfanV0FeS6rTaZj0rI+9UakRa4+VUy3nDbKPbvoKtc+l5c6TB7?=
 =?us-ascii?Q?xplJ5L2vomNbF/+56xW5/Yjl1v27HCr+mD/JlQ74AWfttHpFnASnIngHe9vV?=
 =?us-ascii?Q?aZut4ehdVDijH92cSYS8F85k+BysqKNXs98JE2YnrTWFyUB8mxJKIgh6twlu?=
 =?us-ascii?Q?q6Ek/RLwPLHqIXerZPq8eV8PH3N4yVFOB94PUQXhtuAe8eVuRAysvlp28Nv7?=
 =?us-ascii?Q?nixkX+yjbUArLSyct499/GYBplE4O8LB2lB0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:46:28.5737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea53450f-8e6b-461a-e811-08ddf141fd96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index a8e39df29f343..da19d93845739 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -2065,11 +2065,11 @@ static void sdma_v5_2_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 0x4000000,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v5_2_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 0x4000000,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v5_2_emit_fill_buffer,
 };
-- 
2.51.0

