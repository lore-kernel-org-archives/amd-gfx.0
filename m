Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F067CCF9EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 20:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1136610E305;
	Wed, 25 Sep 2024 20:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yP8vCI99";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 017DD10E305
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 20:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3gZz7KpbkAwi6Mn21oeCcUXRr/vt7QHhFpgm1fFcAhXabuZLS9QFgg97W+NqmboGLbe2SVFFKr7Cs/Wyfw8gnwvBWJ3PFDxTdUwaCzH26vbMJDaQPEIwCujYDlKKL+pVbiwVKSG6TpKVWbJFQZquMn/v1QXK9bApL3HeMDhrPj1xAPUstS2m/3zP20wubwsJyBH/gzfdZ1eq3leqYj6wqBmiCcPUk31afbBLI9UKjlVCz1bNPc8joPISlzon8cc5xQkoZByD1MpI0VDCnvsTG+8OB4WAonm1hVqdND2NTao39Y91Q64TL5CXfw8Be5Ygb+N/97ECd60rcdPg0eA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obnaVsrbisPhv+dbscUICpuLZJmt0ueVVpcGCNqSwSo=;
 b=DsHBhAntmSFHi3a9+3/j0tq8Hcvy2HxrO+FOjkOhtMoy2aNK9S0sqKbR3AyH2npBu2NpFYrBM5K4Lv2Mdj5OE+1EuXk6tUn7hVRIGErvJ1AUU4k9JKBFUS1vewbp9f6a01n3l0gG/gkEeozjIJhy+oNSohm/QM825FVXgdDdiyfzIiUVBb17kjWnWWDfNLG+c/5GRtEoTlYKoQgH8r/9kaXyw83/W53dFWjQhDhm6f0p49W4ED+XvwuXqp+W1d3ALZ4ndjjWBfnmfRh+84rRrrIoN83cxiWqhOepNdn2+WRyJHGIiBWp7Vruz/vrDVNmH1JHOY8ZB7xBeVR3JTBH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obnaVsrbisPhv+dbscUICpuLZJmt0ueVVpcGCNqSwSo=;
 b=yP8vCI99atDaYY9fHMMEsXEmPqxK7zHk4v44JvZ/DKGk5wQYRWcj8ZXYsnzGXfZpgDk6VxHWu7VVOiDd37xZEhBkPLa9B//Hy8twKnTtpVBemgm+qDVeiMe3M3aJxTrKcFcOvjd25h2RgnIMqIqiCnDQP9Q1XR//4suEAL50TQ8=
Received: from CH2PR18CA0034.namprd18.prod.outlook.com (2603:10b6:610:55::14)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Wed, 25 Sep 2024 20:05:35 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:55:cafe::fc) by CH2PR18CA0034.outlook.office365.com
 (2603:10b6:610:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28 via Frontend
 Transport; Wed, 25 Sep 2024 20:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Wed, 25 Sep 2024 20:05:35 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 15:05:34 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Taint the kernel when enabling overdrive
Date: Wed, 25 Sep 2024 15:05:07 -0500
Message-ID: <20240925200507.75767-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 624e07f0-d956-4fb8-0402-08dcdd9d6b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kH00Vm++qVn7WvSd0aTGKoD4wXuoLL+f3w3qzN2apO56i+uK/fJCwmVifjTN?=
 =?us-ascii?Q?aX++6oxK7hbZP90WXSfO3dPGwX54lQxUDA2DASQeQlMZpAJg3Lj6Sm5bMt7v?=
 =?us-ascii?Q?1o0aOATzjvBTrk8ushWeUouMcsl8dFzcHzAxNs/dbIxqCoEJvgHmmy7tFg9+?=
 =?us-ascii?Q?YuAoSuewzCPpspXbLF6+PVM7DOUCz73thpvDHD2H2l307PsK1dZkSEZOHXqu?=
 =?us-ascii?Q?jK/wOcrAjK6rnpKpbmLQa9d0/TlSkiqdf+iQwAZFv6zcUIzVbmWPk0M94bOH?=
 =?us-ascii?Q?utcBcfV91XEZ2vcIFAuYmzPBPrjzNATu9s/4AMx51d/I+vyCkRRTuy8FaQrY?=
 =?us-ascii?Q?lpQ5cAgaqPap5NeAkKTCex9axtvhF5+31+Y03MF6kI4Z4g80HbYrd8HRpUhc?=
 =?us-ascii?Q?wnfqOR/mnVtRDLvN4DJoK+AdUP6iCyRPQ/R1rL5PPbvs7OulQvuY/Gzu8NGX?=
 =?us-ascii?Q?m6TSLgi8iHBlvjqJ2oXWIH37SZ5ifKneuUVFBUmCoGqxI/PZmxF4iyWid3Qu?=
 =?us-ascii?Q?u9v7xjwxTk4RSU60JD6IJ9cwjyrxX0mbg0XDpu+9wgtbLxP4Wh87myxTrwRj?=
 =?us-ascii?Q?IylIfuxuwIl6Ggh/3muiu1PWrV9r33wcFwP9hkK//XINXkdcKORlaLzdJU5L?=
 =?us-ascii?Q?R3mobkNoG8/6Q67/9MjDr7yjhMG3Lb9pNfXLm+YG965SGCos2QHQSjkfsExt?=
 =?us-ascii?Q?wASbzu6eN/cn77Fneg5870yH/UejcbXJPxBSvbnk4Daylf5R1p29zwBgGsgU?=
 =?us-ascii?Q?mMn2W07rQ2FgMqORQQlWVOhBL1W2uUjr0kgaITSYf3tHvoqKYkXQVufUa6ko?=
 =?us-ascii?Q?rSlNyT1P0kfTm0+mZqwKuXFJPdbCgzJnOUxC1MC/jpAXMzawaDyrwtQKIS1y?=
 =?us-ascii?Q?BSRzeGiq70eIGTxMupVqonbQlTwxPAxqJVX2X8Taj8IYp2MqnPR86sCMGMmw?=
 =?us-ascii?Q?pv+yemNaMo/Nh0Zx5R4VKXrq5+nGzd7/03VfnYZhRZtab0jIvPAwR92fL4VK?=
 =?us-ascii?Q?cSB3JpzPWGCR0OLqWxttcSzMgvVT18ULGa7Vr0t5pEUhjmpzyy3dwgMT0KRJ?=
 =?us-ascii?Q?8qaCSskD6qduI5uHGjvoot20EjeMXYGH+PYD1Z8iRMmzkk5QQWO+IaQ/tQpS?=
 =?us-ascii?Q?lFZlOhD4j4mlPY7iiASZXdHrW7oepwlwgN2mBVPP+ulZPsra5+dw2gS/EdJ/?=
 =?us-ascii?Q?jtVjDbsrvJOcOt0zh9Gt7qvKlWdOz0JYtWPtSHKIxnzabRx0L/W75NYcoZnD?=
 =?us-ascii?Q?WrP+EYCENQutqyjG39I6BTty0z2tjgSPjJwKRgZaLg1UqRZmmPkdlmKAdRb9?=
 =?us-ascii?Q?mO6luJMF392RhLkMXHu7ngHgUd5TXwBAUFoh0ObKTEhdRRgD2p0xznFwxAtO?=
 =?us-ascii?Q?TaPrUh/QXLnj/qh5l8q20GO1MYDdnc9sy40olbrv3h7L7hR6pWtNj/jsh9HN?=
 =?us-ascii?Q?PkaUknYArg2nIBCn2jtVy7GxVK0FNVQy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 20:05:35.4030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 624e07f0-d956-4fb8-0402-08dcdd9d6b09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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

Some distributions have been patching amdgpu to enable overdrive by
default which may compromise stability.  Furthermore when bug reports
are brought upstream it's not obvious that the system has been tampered
with.

When overdrive is enabled taint the kernel and leave a critical message
in the logs for users so that it's obvious in a bug report it's been
tampered with.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f57411ed2dc2..99717a1d7f61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3067,6 +3067,11 @@ static int __init amdgpu_init(void)
 	/* Ignore KFD init failures. Normal when CONFIG_HSA_AMD is not set. */
 	amdgpu_amdkfd_init();
 
+	if (amdgpu_pp_feature_mask & PP_OVERDRIVE_MASK) {
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+		pr_crit("Overdrive is enabled, please disable it before reporting any bugs.\n");
+	}
+
 	/* let modprobe override vga console setting */
 	return pci_register_driver(&amdgpu_kms_pci_driver);
 
-- 
2.43.0

