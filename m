Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AA6FEDA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92FB610E63C;
	Tue, 17 Mar 2026 20:13:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rU77nvU5";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6919610E5E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IehfxzJeYg2jQbUbGyGRBYruk7hLy5RGvLKW9FrukWrHlxvSixwEkIcwCP3L54+opFgJqYOYUfmy/PZRoVcWKmfchs/ivkYB2gto6aDSN5E3tEuVG8K527n6j96xyyZgeqBi7jXh9sSrKk38LJOU95HmAX9WIqGmkSF/KbphIP/ZVFXwYvy4NRfCj50eQPtW7ELZu+nlG/yN1AqvqxdVYzn0DJcP47N4DvR3BHJNK53/rHawl2nNZ24rJsuNBTmAseOsZviR4hbLPVi1bBVmPnVfieGuFDIB55LSwX94XyV6ETQiGvkyOS04DtmQChfUSTTLJwIukXggkvZH2KOO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxOk+jCgJ7hJ0jCeO06gMh2gSnhJVpYVP6qrZ8BoxWw=;
 b=HNDVpka/PHtKyYRo+wOpgXW8BR9O4lXwHCwgayEPa5qQ2n0vYRLj2Zq7vXZak1bY8D6YEN6EiB00wd8Ru/3rQ2pRsMxCpSzEbhX4+fL3+O0tHDwvoEJa1AiRRCDlTUQdzn3WF7iYbfbannEZFzA58Ttit9oP+sN0CSx1YG0kqR1rcwVUcfhEnrCPci20UsV2gedx8X6/ygHMKXOKcbcQGecw0HRi9KK+EPRyfd0rgsRbwkuIagZAZHFax+jclLtq/honkHahIZaQptL80wLq2dvq8PriHAh27zOf78mSboSODQN43szgcnWmXINuGbChYerS2snBApZZr5L24+URbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxOk+jCgJ7hJ0jCeO06gMh2gSnhJVpYVP6qrZ8BoxWw=;
 b=rU77nvU5Dii4MZUyax8/5VBXYjKYPFQFRcinnAvaOTOmm44JlJcST9e75eA4ASr43zsffyeC/Uv6ZujSZL3rO7rQulVOBILwyBfLllFh9apfPrhiMScUFUvQ9Y8cPJOFMUBEOIDnoTwANgthZVGkN0Gwinud3PENpY7z3HVxdAw=
Received: from BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::14)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 20:13:13 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::8a) by BY1P220CA0022.outlook.office365.com
 (2603:10b6:a03:5c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 15:13:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yang Wang <kevinyang.wang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 12/25] drm/amd/pm: add get_unique_id support for smu 15.0.8
Date: Tue, 17 Mar 2026 16:12:28 -0400
Message-ID: <20260317201242.3808136-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ac77eb-5139-4a02-7444-08de84619e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: S7M9lz4YVgjt7+qnHSw9QsytjtVREFFM7U07SfNzWjU5nVgVPUxlP60mYD6Pc+jbMdd9svxMyN4phCjsjMwIHc0jsUqBSqJBFf9ca2ee1VBUrzeKONOJPmTYDOI3nPVBcIFapWrj4COqzOOeIOhFVdbISJ1N2dVwpmrNdRxoJL4nnR9nYx++JogYuNIG6qejRTX1TjMk4zDvfS5AuC2e/c7mKbrAfpaZufncnidopHQY3cbpTlPhzOQfgi4FhF7eBUutiAzD04KYal9UZoYnaZElmzjFNrT6UrpWKERMcsy0YiD7b+aa3aBVqi8ieGp2DEI9YBnaAyLCYkViK2S0gaC5uvNtxp+i0TXCgFSegJwz5TcYxAVPpPe1CHQiEUlqW2v28rVeSodd7k4ohtm8C2YLxNJBpwjoTvkZzZ8rwDTnhx0YwjBe8vQpTP5fejEgrLhAgZqPNfVVNU4xWct5rswGkd93Zg9WYapQ9nRkGThZgie1E5+UEa3ogmRT83NKhLKrBQ/YFl7sV+M66ymj483nLA5gjozbv7QxkSdZNrxlR0TJgDoaiav88B1LjrLK8yekTyM7k5BRPHl8xsCaaA944Jpvrjk3N0l8+bm8sIZZG9CgnqWYFXs9WYrZ1N4cIWrKAtSH5dXJEZCvP92F19QRPoTjNnVUh3xXb2MIardOHbxDNBi/UEIhLob5gGzfsRRBMIGRb+hwJWyxzmP11tYf0u7xRoAYLAZlldmYW63KxSnmNUI2/R6MXET2j9GthBG54G5EbL++n8rA9yraBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7YJGplx7FxcDP4mf1Q1UMGwDWctqXy/h5pJTftyhjCZJbP/3cENaCSQx7tJ+nlokEBHWNvCwPJ4TRJcXVsnD4zXNOj1cqGfKstFSfGv8tsG1WUMrfY5ovQzG+6ybdXqYwwJ9L5TdidoZ/lgwsuqg1GgJExzxdWFbAcGqXkA+ZaXP0i/JcVl2PoYxzKADB7X1/A9Qond2h6SESJjt3DNiBS/oh/QeWpiCqbi70J7pbUONCWVbytv92NHWQXKafIpw/lWoiyGbSb39IXD0XbcNlgWLFu5jTZYlrLelrCVM7yJw62oQ28tWa3HJIxBBxuAk0nLxoFykO/7DDJqhjs77m/CdRdaUZwAWQoBjRxwS/lhQ/lW8YXLgyuassjFG+A0Vu1pZDAtFLibMmWCc3kRgeyJzx2xvbpT0LrniX1wUsOPVZPULdUeNkdJWA9jToo/o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:13.6106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ac77eb-5139-4a02-7444-08de84619e6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075
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

From: Yang Wang <kevinyang.wang@amd.com>

export .get_unique_id interface for smu 15.0.8

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index c13804c32e706..5fd22b145aea7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1138,6 +1138,15 @@ static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table
 	return sizeof(*gpu_metrics);
 }
 
+static void smu_v15_0_8_get_unique_id(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	PPTable_t *pptable = (PPTable_t *)smu_table->driver_pptable;
+
+	adev->unique_id = pptable->PublicSerialNumberMID;
+}
+
 static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.init_allowed_features = smu_v15_0_8_init_allowed_features,
 	.set_default_dpm_table = smu_v15_0_8_set_default_dpm_table,
@@ -1162,6 +1171,7 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.mode2_reset = smu_v15_0_8_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v15_0_8_get_dpm_ultimate_freq,
 	.get_gpu_metrics = smu_v15_0_8_get_gpu_metrics,
+	.get_unique_id = smu_v15_0_8_get_unique_id,
 };
 
 static void smu_v15_0_8_init_msg_ctl(struct smu_context *smu,
-- 
2.53.0

