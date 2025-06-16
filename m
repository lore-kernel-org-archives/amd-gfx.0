Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B70EC71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 06:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F2E10E2B8;
	Mon, 16 Jun 2025 06:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jTTL+Sbf";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF66A10E2B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 06:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4ASOJZf1VMS8gJ6FckQ6JVyLavHr3wNWsnsRpu9sVZadQl85m6p8jhevhvfLHysUmE6cgPwFtYFhdH2kJNEanuiz7368FHb5cYlKvg/S4FsARnVhNRhRu3OWka9wALw3GZRrJDxB0wd1m3Aq6b1GTzDWsj/AA6wGXowMpB0NKXy7XjBT5q9ex/1qzsRNxi1cplcYe3bDnn/UoN4O7L6S+QEYMczTIdmtgd6L3Oamw28C/WYq35lsXsuisjP2Ojv5BCH4FQ/HXQ8XNZNkGrZnwePnWdMvIRmlMIWpxVLQiuuLWxe7aItouQKMUHUxeED/vRYbRssLJ17+Pyf/yrq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yi4ZjHBQxmoYvoJBMa75fJxcT5a7CGklZ5mAdvrtCsI=;
 b=fNwQ7wtRvrhBeHgQMIsfdGKJlqwtgPOIrjtLsbn4RE39v2pOkDuOAjjzYZBUZCviFnhXvQJSn76GlfYlOrMypRRA36S1M2xb8Qx+xks7OyRkjTZbgeIETepNOjiDUb452X7ViDMmzWKCvmU77CT2AyS27KF+gD1YI4SUhewB2YFM5QfPh/9YgKL5GJGrrm7JEnpwzk6LdBsp8oINz2JPmgXIZ9i9l5jnWD7tgzo1BjsOFLB0ETbQAgTf6yU3U4xXSweOKBZwDQR2kOMao9Obkb8wpAIQniKxaNZpmMh+okgGssxEeGqZEJfWBrUbq3J/jkdTmTkbA5WkVfkWreF9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi4ZjHBQxmoYvoJBMa75fJxcT5a7CGklZ5mAdvrtCsI=;
 b=jTTL+SbfuLd7z1l5wU/nMP/GgFqzp4TJWyzRSVmZKzEL76BwMCziBEmz5SuO6ZqYqpcKeH0x1ss82nzm9qSAQn99VdEPbeeOEqvPZL9cHS53OuHsxgGNAbeDUYzwNO1vcKnT+nbI8eJ27MnyQYs9RteUODqDwWQnOYlYGYxgjNQ=
Received: from SA1P222CA0126.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::15)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 06:54:22 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::5a) by SA1P222CA0126.outlook.office365.com
 (2603:10b6:806:3c5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 06:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 06:54:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 01:54:19 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 3/4] drm/amd/pm: Fetch SMUv13.0.6 xgmi max speed/width
Date: Mon, 16 Jun 2025 12:23:59 +0530
Message-ID: <20250616065400.868818-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616065400.868818-1-lijo.lazar@amd.com>
References: <20250616065400.868818-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 879df9cc-99a9-447a-9c39-08ddaca29fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PLND8GW90UyoUngngXr+PVdn8jx0h5LVTLH26v0S2mSnbG/B3syXJtLVQEA7?=
 =?us-ascii?Q?lpLh/KZWZQkwHg8h7B3aiuJJxnwm/ApFI16UihFm1Uby2biE1baNeUdvdBDA?=
 =?us-ascii?Q?1NG489wS1HrGyZWx9zA/ExOVnYula+4fKLdJgC7DzHFqsAvBKeHvSqqrsrHp?=
 =?us-ascii?Q?Qd28kaqIOrpR/jGLCtk78U5nXDhSg7+oIWsrofjtu51IxnF4/c1d1bpwBh97?=
 =?us-ascii?Q?xLImE6D7zgVZlQxPMIueQpzi8uvDAooH5d/++1oKYki3FoPv5Wo1mFh8oAMS?=
 =?us-ascii?Q?QA8jSEbRAsAKYHDj6iUehy/NCems/z3aMPnbka1PnuVhg96QfyK+NWALNNCM?=
 =?us-ascii?Q?sr2EQ2HmAAsSKgf85IVfitKWelRGLhuUqkNade9ppTP2wVVZk65mmnqrpw4a?=
 =?us-ascii?Q?OzwzJ5Ed1k/LBypyRgKZcq/wT5MqbQJDaUh9qGjaMz6JdXmXy2bIlauKN+pO?=
 =?us-ascii?Q?xxoq0FN+N25HhZj+3LkDpJJTN+gyphYaVZ0E9Ys/M9bLnKfR5FbvqStuNics?=
 =?us-ascii?Q?zulU1pDbyuL1fGrl1on/Sjz7ooZ9aJLmEwc+YMwcPl/bGikSxI0BrskOWXhW?=
 =?us-ascii?Q?0orEqBOuicxIphBFtIXLKrtmbY7iSzp6+8+IwT9SsGUAEr4RZipT8M8InYtl?=
 =?us-ascii?Q?RzqtWU1Nr/1smOn7t7+CC3KHhLhHgx2msKO7KuM8qB7RTDqfQPjonalVX2zE?=
 =?us-ascii?Q?mJ9zYTjpyyrFAJP0AFc3vFuS7nYDZH9V4XkGWBGkcQB3rpLu8Ldnsydp11pk?=
 =?us-ascii?Q?bYkjoixcs7xBLdYOY0hqbtyOK2PHqGyFGP1KLBPs3PzfLYO4tFZsTcZqL+e4?=
 =?us-ascii?Q?UuKrP2ipYPOOEfjmhdoOXNtdAYSW4KrqvYkWItIyrr1aB/RM+phGIDQiJkyz?=
 =?us-ascii?Q?pqrw2NfsjfIoq2Hxzs/fO6Ulx0xSeGm8+nExM/p9lZeFT/qEbe5Xp+xEd3bo?=
 =?us-ascii?Q?OZCwRVxzCebmtUnVyL3QiXIhj4hGFX5edaixHvHEhHeK0LeLDzeNkri5NP/f?=
 =?us-ascii?Q?4h/T6+u8HexpFXS6cad9eGu/Em/cGPl27+wma2CuullfRa2iDuTkOzYv18nV?=
 =?us-ascii?Q?vgSJvwityoHSPNcOy0N1IBbWhJZ6SfjEVF020Wv+zjBcNfa7URKt2FWSZOqA?=
 =?us-ascii?Q?eDhrXJHnWvxaJd8OSn+aZiJEG18yWA2ls6yBMyvQtqAiR9CWxmOVNJg4rVch?=
 =?us-ascii?Q?OAwAOkvQHEX0UP6kRBsDyaUpi5TELAawuBpObs8DTPmWwUWDe1IjaIJTD+I1?=
 =?us-ascii?Q?a98xR5OLYGATnXJ9cHFzBUeuIF1RA4ojHv1bfWmAKAlRrLFRQvBM75YuXFgM?=
 =?us-ascii?Q?WLrUcvzXnzXw/yVUKkURfZLRkmt5HvytIe7Pm9cUdJ6UtGW0dmniLTzudqQO?=
 =?us-ascii?Q?yhVb0gG8/hETHir1VFV25CBBsdfF837nlcJxmaWNbo+SyFpnI9swhtnLzxSJ?=
 =?us-ascii?Q?tVEpJq13Um8RlXXrqduh4pwz9CW+YoONh6QAnqKCnxzm4u/OpKWbkn4R8cog?=
 =?us-ascii?Q?OoG8YTuOIIvn9986Ox8j2pTA0YCvmuTPDXcn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 06:54:22.3460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 879df9cc-99a9-447a-9c39-08ddaca29fea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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

On SMUv13.0.6 SOCs, fetch the max values of xgmi speed/width from
firmware.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 44daea9a07fa..55316c96d6d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -805,6 +805,8 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	int version = smu_v13_0_6_get_metrics_version(smu);
 	int ret, i, retry = 100;
 	uint32_t table_version;
+	uint16_t max_speed;
+	uint8_t max_width;
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
 	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
@@ -840,6 +842,9 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			SMUQ10_ROUND(GET_METRIC_FIELD(MaxGfxclkFrequency, version));
 		pptable->MinGfxclkFrequency =
 			SMUQ10_ROUND(GET_METRIC_FIELD(MinGfxclkFrequency, version));
+		max_width = (uint8_t)GET_METRIC_FIELD(XgmiWidth, version);
+		max_speed = (uint16_t)GET_METRIC_FIELD(XgmiBitrate, version);
+		amgpu_xgmi_set_max_speed_width(smu->adev, max_speed, max_width);
 
 		for (i = 0; i < 4; ++i) {
 			pptable->FclkFrequencyTable[i] =
-- 
2.25.1

