Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07640CCD185
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 13:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E7A10E67D;
	Tue,  7 Oct 2025 13:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EVvfMtQj";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C8110E38A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 13:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfQwMg0Ha/jAySiHHUsy8uD6mDv/eTka42qPw2XhDKmOJ35MENz1tw/7B8K0ceco7HS11jxV8TF5TNZT/B0q68IW6/wEYYA4dg45oS7QYhVVq3RPVD7zjj8OAJ2+Zrc3MX39blRuXzzT5xpsiJihkJBGvcfxlLr9+WUmsvPsMVSAj5ASOniCpVYVkJjzYCmUeSyyZHnihO9nZIy2x3FBNheqwRWQtptK6CeRILLED3dPtJc2DJ6ioZf+g0ykrOB4MovOJJb9wTipfwJ9pm2lQuFxvU2tmiv0nKHzBvgOmDeRoEqHJ9tZ/N7u+8FbZYeuZgEOTDjwPrfCB6ZfaWQBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XySu4jpdUToG5WWhjvK3n9myZTLWXLu7qs+amYZmgRE=;
 b=GW1vUsFk7Vf8df2SQhlUv4ImQcEb1fqnrl6Fn97yiPupgdlEzwS1sxhvKOCaz3gR2umD8DlRXOVOlTeYrgDmtxJQT40o2hIoAPwV0Ot5cw3aw0TuiXoT3VWqArRapPsuQKeVguPglbDZW7E8iC9oLX1L0ZAj9X0RF4OmDr5GFHE9Qf+SyhNl/vmqf/bgpS0u/i52pY33ynqYwDx0dzZn+XwidXhDOpS/bzU033/7PUueTJfzTgM3O7kfHFKkLDv3HCTrE+4e82MIShoFkblWc1NbM154JqI6NrIjF49f2v63KS6osfGzjbl784usKzd3O6RCWXmbvskrZebPnn895Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XySu4jpdUToG5WWhjvK3n9myZTLWXLu7qs+amYZmgRE=;
 b=EVvfMtQjs5z8YERpNxXWvGlHhN1FDeTqyiWx7LfrDaGwuPUDZ5lkXx+fzCKNxs+KB1kvcbOGPZGb4jeAuIWopSR9wJsdDlXDoRtSL3Un+K8hyM9c1XxhTeTwvpslSVGyjJ4FEmnD/pUkf853TLv80dkyIilICPdAK1qcttk7GP8=
Received: from BLAPR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:32b::20)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 13:34:55 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::8f) by BLAPR03CA0015.outlook.office365.com
 (2603:10b6:208:32b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 13:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Tue, 7 Oct 2025 13:34:55 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Oct 2025 06:34:52 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 5/5] drm/amd: Adjust whitespace for vangogh_ppt
Date: Tue, 7 Oct 2025 08:34:38 -0500
Message-ID: <20251007133438.39411-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007133438.39411-1-mario.limonciello@amd.com>
References: <20251007133438.39411-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 701239f1-6dd4-4d44-6a2c-08de05a64d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Ez+lzODfpQR+Ms1M4/wsvmSEtkNl/Egc8DWLdD+0pQp6VSZvzuPFEL4uPTA?=
 =?us-ascii?Q?jG8B80KZ84cVecgOI5siYkm4LflQv96eWzkCZX2vtd74wzqN9IyDo0ENLBB8?=
 =?us-ascii?Q?CBb63cIa0xn9O02N+iEbGnQu7LTZYJZFxJxkZZUxzbtogo0jvXO/ba8ExoN3?=
 =?us-ascii?Q?BnDXQZ437qA+QWzUrv3REHd3kF2r6TuOgXMy6LkxzzwJHU6uQCmjV3DQdzbx?=
 =?us-ascii?Q?DHMvS19nAJQ4ZV6jtD0YOZ6x0QZhMN4AQ8SmHpIGObena4mR6tl7Dcs9jEhX?=
 =?us-ascii?Q?dMTlpaDESByraTPpTAtCdC6dC5et3+qoIXKhoUgOkMZL5qcaCqgW6w9NzOcb?=
 =?us-ascii?Q?+NNenCQVztHeV6O4RXU4miSdtuGQet6ArvDdEcH8+blcELMK7HbRW5J1zrZK?=
 =?us-ascii?Q?Eh87kkLzJANpY1nkmydQfVAckkDJUNgtzQXYvCdwPYWzFc9qS74yalzDq1rh?=
 =?us-ascii?Q?YAOf/01MyEv50/6mHADJ/nSko7jMeUrgSj7dHNY0uX9PVISxef1sblcHAH65?=
 =?us-ascii?Q?p6u5atFkRzL70G+MKNPblzRtkzFkjPX0Bv0bg6BdO9O/pp9UIr5ZOMTajcaQ?=
 =?us-ascii?Q?doxosnoqpM6oqPychuCPD7r8HFyJgJdOs04EE/2TwtelpTg+QejrEmncjSJo?=
 =?us-ascii?Q?1PSWP5eeodf6NlYya+Rnf/TolotZZSGVA3Po8IA0gDAlvWTNzoiVOU94dxYo?=
 =?us-ascii?Q?NYit4dG7G+REizDqgY6usJOEtnw/+6QjnFMtscubIVAIThip0N4lu3aIhzV7?=
 =?us-ascii?Q?e4/Me23FN3Dq2WufQx0EVEttDSMREdHnd1StVzqL+zGcKq4VaEiDUw4BCvkH?=
 =?us-ascii?Q?EQuESXxyx6oBQoMyhQVoc8VWGwafnvBtsCiNWtnad3XpZl6n68d//wOomB6N?=
 =?us-ascii?Q?Nxa0VZ1Uymc5zQ44+SDGzJgb39bLar0riVbfi4rZO0OvlgCuLH1LWPRPY27V?=
 =?us-ascii?Q?NLFpKKZ61xkx4qJg0YK/aLNqvjYEQMRV2EJHrAgZ92atDb0UOlDyXad9Or9M?=
 =?us-ascii?Q?P/b5Jm/peNOZkDoOUtPytq6k03iorqS1Y8HCVAPYhrHWhcjUHAw6rpEJ0rPc?=
 =?us-ascii?Q?LKDgdNQ6vA3+Yv/0Sm0zzISxOqVUU9yU6dPIQE4zdo2HEVs7XNgariKWNCfA?=
 =?us-ascii?Q?CLcaGqEDJVQw3xcSnC+gVxeJFIOMQbej84+jdQ+QWZbHI6jmjIDcfgV1QGgq?=
 =?us-ascii?Q?++H5gOOAh1/Yifjusnkm0zfXetmUFlhAJm+/IYfaq6y1eTq1jO5ek9tzXsZx?=
 =?us-ascii?Q?502fqQYSqY+reSJH1QKdBqpnBVxoxlwjXu0OOd0Q3caBoGdBoePctcG2Z4eJ?=
 =?us-ascii?Q?+bNgqaw0c2R5Oo2HBXMdYPaOJNEJopa4oaALX9GtsN0gmJ/Wp1SLgXSqAEWm?=
 =?us-ascii?Q?eXtfsR6HUikmL2RFrJlIWdZL09IlwZdxAoMJRylo87BvRWnEsDvqax2WXvwg?=
 =?us-ascii?Q?crbEu3exW22A/AjAcmkfiPy9mK3Foe+8DUGRC+pqis4r0yT9/PYNuK8cCrxO?=
 =?us-ascii?Q?QzcZyscitmER1w0sQuH286aiUfhz72xr21i0NpQaVYTfiHZ0IdpETaJaUiid?=
 =?us-ascii?Q?uMZXj1uLN+DlmkdUGeU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 13:34:55.3758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 701239f1-6dd4-4d44-6a2c-08de05a64d63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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

A few changes have more whitespace than needed.  Clean them up.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 81077a3969e9..1dcbf250f486 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2308,8 +2308,7 @@ static int vangogh_get_power_limit(struct smu_context *smu,
 				   uint32_t *max_power_limit,
 				   uint32_t *min_power_limit)
 {
-	struct smu_11_5_power_context *power_context =
-								smu->smu_power.power_context;
+	struct smu_11_5_power_context *power_context = smu->smu_power.power_context;
 	uint32_t ppt_limit;
 	int ret = 0;
 
@@ -2345,12 +2344,11 @@ static int vangogh_get_power_limit(struct smu_context *smu,
 }
 
 static int vangogh_get_ppt_limit(struct smu_context *smu,
-								uint32_t *ppt_limit,
-								enum smu_ppt_limit_type type,
-								enum smu_ppt_limit_level level)
+				 uint32_t *ppt_limit,
+				 enum smu_ppt_limit_type type,
+				 enum smu_ppt_limit_level level)
 {
-	struct smu_11_5_power_context *power_context =
-							smu->smu_power.power_context;
+	struct smu_11_5_power_context *power_context = smu->smu_power.power_context;
 
 	if (!power_context)
 		return -EOPNOTSUPP;
-- 
2.51.0

