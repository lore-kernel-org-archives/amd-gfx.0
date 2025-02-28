Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691C9C282D1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 18:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0669A10E335;
	Fri, 28 Feb 2025 18:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V3N46dJ+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC6B10E334
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jP0/gVnrtznYn4JMLuBaIMFrilTU12OGUluLMtyTAHT9MQGiLZXwvCeKlExIwCML7s8cCuVb8lI4UFVKq9g3oyauxCyYDAdNqlbzBoHdrAuuTbuFZRb4CNmJTKhJzXC/zqAB2JtOdjnjbflQ/kgmgTWVI0kA2N5eeXEN3OhbWIb9YjTMwDysN2w0JiOGgmja6VQLg/MOBgzPdLMK/ecY2px0LBdKELzUYrDjJPIRaIgruvmGHPXRN6dNDj4zc0W3XNtl/2CRqBAFvvneRlOC6VJat7wMjyxRSeMeVwPmhil6DHwKtUCw9XuL1a8Lrre6npIgpmPA4WQ5IgKCWStdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neUJlBhS1y8F7+X7yoDNS/u9mKbHEBxhMTF1H2TJlck=;
 b=T7GDabSV014X948qGQL26eBSMiPTMdbKXehZwEHRvvRbCsN/IgfuLgHkB3iDAqRUJA50z8vvTVbP4xYpVbtv2xXe/HOLBhdI4qjq96sSO8u0WZAq/P+R8BJ8pqLQxL9WyhLgXsRXrVz8DC+MnBF7iDWYkwEjdn789VVukMimSfxoRYwOg5nhfMaHCsx8ec0Es8t5aTXqoDOJEt7fDBpcCyX41bTW0sJHBbqrPAWaHDbH1bdnEtkw9WPs1JfvSsau9iPkjgXMZgMDanK1n7AFcCbOjK94OjS65QLgOvjVWK0t8tcXFfJR6mBx6DW26oNONbVKZCQWGP0BhXnn8P9ATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neUJlBhS1y8F7+X7yoDNS/u9mKbHEBxhMTF1H2TJlck=;
 b=V3N46dJ+ccH2F2tLvwhHI63V+ueEQMPV58e9jUYzQxR6ibAWxCq5XFgLhBFMiJ8yQkzSc8PzVTvlqBMX/Vkj0OMAR1JYI40jm1W1pGaveOxdpY6EIfzDVKkEY8a0QRComPPxFBZd+VybNnaxuA5s1xksCuBhg+sez6OxGIWCTKM=
Received: from BN9P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::16)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 18:52:01 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::2a) by BN9P222CA0011.outlook.office365.com
 (2603:10b6:408:10c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 18:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 18:52:01 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 12:52:00 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/5] drm/amd: Copy entire structure in
 amdgpu_acpi_get_backlight_caps()
Date: Fri, 28 Feb 2025 12:51:41 -0600
Message-ID: <20250228185145.186319-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228185145.186319-1-mario.limonciello@amd.com>
References: <20250228185145.186319-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbf4a90-7066-49c5-43dd-08dd5828fc9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YQ/jgHrI1FJFtDcBYrJHkwQNqmV/8yur6qtgcauo2bwkx7AnHxOR+Q0CLrVQ?=
 =?us-ascii?Q?QHhqT5o9WRn0w9PhQ2zuZTEhTBan5VJZoyl5UfVXboC06cTZefqck0An5bA/?=
 =?us-ascii?Q?/VT3ZWAzwsH7OtQZVs/k3VYR+gel2zazJzIo5UWELNSoXu/cpkAUJPr39RGd?=
 =?us-ascii?Q?1f0QOd0ppn/tV0tMtX3pRyboNCp+kSQ3IZZ97/8iznZRVncV3pM52bI+VjO6?=
 =?us-ascii?Q?moIUYlnheT1FwTWGGn9lNxvXYQQPKRAITHoWWnYAZqZHcSKe8w3ERcLnJm9c?=
 =?us-ascii?Q?Gv3+hZuNR0L4Cbndyg5NU6EkrzBTk1cNbrY5/leU9z3SC1rknI6PbLUiT2QM?=
 =?us-ascii?Q?it4TShke92m2Jsx1Kp/lOadlPA4IFAfV3XPe/KHw7l6CKmIOLOvK+/C2wVvJ?=
 =?us-ascii?Q?DOMwk/bVJaNOZD6jwzKYpo8/CZBT7LyGbB9oKzlslPfhcPw+190BQhyeYqM4?=
 =?us-ascii?Q?oRlnfj5InA3sAbE1NYQlLg+NrFDDj7SywGQmi608SZRXYVsetqQgiAGKnAbH?=
 =?us-ascii?Q?ZQ5hQBzCDXE64+JFncNmAcklwbtuM9FmlLeKzMsX4F3ZYLbNa6vIvQ/oZjqn?=
 =?us-ascii?Q?lk36uv2q6CTKQyXLNAH+cImKWAYVe48t8CqT+KOZ9LgUJRLX0cHtxEH/Isax?=
 =?us-ascii?Q?exoRqqn4Z9yuYB4DmdKUMna5UX24tFMXQJ4C3lXAVmgYSnrRc66FTGMJBStf?=
 =?us-ascii?Q?Uz5o4Ro/ynXw04trOzh1ib6C21EThEbdDvbqSaSq2fQEsd5Cwfar6D7b1IIA?=
 =?us-ascii?Q?n6d7UuicWKB5yCgrB+Wnc38JT7RjYS9sjYGpwf/O0fAGeo8CTFgB0B6JJr/g?=
 =?us-ascii?Q?O6uOm+SjmF6wse1UhXSUjR2+roWD1cNfqKQUdWey8VR9K8tMrHH7qjh7SX6h?=
 =?us-ascii?Q?gVpfsrxt1tV0KfJqw1y1+MBla0aQvdXW06XSeKWOwMbY1C6PIzUfbsYFiIhM?=
 =?us-ascii?Q?BN/SQzRrRC7icW4JTqq+Y58r8wv/Q+6HWiHAK2dLgmI9deqC1VzW1UDEviTw?=
 =?us-ascii?Q?Ar7aXeQkjpg9/ojLATpu3GbywPF/XLSbNQEQi5Hv+hq0dPDBMINHGbGJ9dxO?=
 =?us-ascii?Q?ZdWr0vdDRuZU/Tn/qWJpsUtelJggi3Fsr/gsgI97WzlZYfJI/tB4rpPXVdnO?=
 =?us-ascii?Q?FGOW/GuAlr8qqpeoc4laHgkqT3naGHdtKaJLgV7qwftLiv+MDaiKLd+9+eoa?=
 =?us-ascii?Q?VB2hjX+JJMheVO12Y4Po74d8J4IV9Fyam5k0isFG7vLQUfrU234Vq/V0AGDr?=
 =?us-ascii?Q?68P51dE1VUOOjJ9qCyvjpuzeeQ3BCXvKdySZzjOCPVcQ98p7Wqi3zwyQMcCI?=
 =?us-ascii?Q?J0NWBeNhUL38k9dQPxtu0lc3iGKtWWZPxz4IqbEYpeQgFfAE4SIRmRjGUkn2?=
 =?us-ascii?Q?CGGDD45r0U7nOESOzK93oDyX+pDz5Pnlp2KEfoKqgg4wl+ZV220ZWOnBgVwu?=
 =?us-ascii?Q?S7vd4Or36QW1T/uyU/2PC9BVZopOsHjxvp4LtWdpmZvW/i6ka5ouFHmY2GNe?=
 =?us-ascii?Q?nYNwpDRQMuHnrn0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:52:01.5823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbf4a90-7066-49c5-43dd-08dd5828fc9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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

As new members are introduced to the structure copying the entire
structure will help avoid missing them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index b8d4e07d2043..515c6f32448d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1277,11 +1277,7 @@ void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)
 {
 	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 
-	caps->caps_valid = atif->backlight_caps.caps_valid;
-	caps->min_input_signal = atif->backlight_caps.min_input_signal;
-	caps->max_input_signal = atif->backlight_caps.max_input_signal;
-	caps->ac_level = atif->backlight_caps.ac_level;
-	caps->dc_level = atif->backlight_caps.dc_level;
+	memcpy(caps, &atif->backlight_caps, sizeof(*caps));
 }
 
 /**
-- 
2.48.1

