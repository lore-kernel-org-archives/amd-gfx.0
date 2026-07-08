Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E359EC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 19:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 731AE10F254;
	Wed,  8 Jul 2026 19:35:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Id+kueS";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 500BE10F254
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 19:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KowAv+OYrfRvstcJPlF3z1ufDKRNJln09oyDcOReWxANfSXUKTJPMDf9dCWERCicHJd85aisvnwb9+5uQEZTJlFVKwGW3SLchHJW9dpVK0POb+3VU5wnNv18ybUMIouM34kBai6k/jHF0ZB2LqQkp4vwLLP8Bb9vpLUcmReAEKp8WLNUu2SykLZK0AqSusYnNdb/JKlq9T4vKF0wcFIpEFq2d0cOrJU9JKdq2osHuLSYoo+ZOhYIT/qCCR+/UcBY9LCdWe2nrizG7D9Kd837x5OBfMzBayo6uIUpo43WqRxCbQ9arL1mbHPzHIHZ1pAs4WBd9KNwky4WI/sKhnSh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXXAbLG5v1YcE61wWGXsgJ+8v6/4Atk9FAQpeFTJ0qc=;
 b=Oj73q3j4yO54+oHzDJtjWL7pwrxcyEs8dJr19PA9pvUlU3gXXxkhLySZCI7rXIgAq0eYGyDeEdVN1gqwQ5LJYpMeyf2T50O8yXw/dvZE8APkE2tH/CoRhinmQvnupWyZjkaE1wBl+wTWLzOHgyNkjF5mcPYVvwofcnJs4TyqjU5CXDVRg8Wgfrk53HUMMPS4OilmVdRVCPz4kp9tK/2ILNEzKz/tAxuwDfVkuA5gsqcQ1eQcUYEUEiTHB3rw0UiRO5Djo4OWVu6rNwgm/3s2PaMqPypGUcN/mJp7vuWL1ghNPZ09IVAz0v8xn1XYe1UKN2eJSDsZmAxd+rSTue9EUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXXAbLG5v1YcE61wWGXsgJ+8v6/4Atk9FAQpeFTJ0qc=;
 b=4Id+kueSPBf7JCvFqutp6/3K+u3Apcw+NTIo0x4rWP6eG0d2n3VrEKD1ie6fpdFI1r932AoA0FRvmQlmGwR/r5EBaz87UEPVuOIuZzl/1L3GmQ/To75E8JtfUtngfxSL3Ew7s5cBShJZR+SnDDVLp5aJe2Z8vmLRM1JdAxZfYNo=
Received: from BN9PR03CA0906.namprd03.prod.outlook.com (2603:10b6:408:107::11)
 by SA1PR12MB999253.namprd12.prod.outlook.com (2603:10b6:806:4dd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 8 Jul
 2026 19:35:31 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::73) by BN9PR03CA0906.outlook.office365.com
 (2603:10b6:408:107::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 19:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 19:35:30 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 14:35:29 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Oz Tiram
 <oz@shift-computing.de>
Subject: [PATCH 0/5] Allow matching devices with different bus numbers
Date: Wed, 8 Jul 2026 14:35:13 -0500
Message-ID: <20260708193518.702584-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SA1PR12MB999253:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff99999-ef54-42da-17df-08dedd28121a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: wMPBnZQ7nenLbwabtz/t4jEFMfPrS9/FD7jxy/ij7SR0iqml1XfoK9AEb9E7AGXapH4kYikL7vlgSJbeluv/6erpQLTouRPOKpwA6k7OtxTQy+isiQPHmr62a/J40SBqzTTK9pIhPLUKwLa6tJTwGuOXgF4phoyI8m7dTwSlRJOnsWcOLl/YL3VPff9fzZQjMoWiZAkm11i+vgYeqZxr1qYkL9cfHfhtbuybWLyu+sGleo4OC9wpvASiXPZAYoqVgHGjDG0e6ZfUtTZSssCnQm2Bbs4K1yDarY5wrkOdftTwokt3e2PHghd3eWN6tV65RO5CFRNhJqY8yPgScQrxbYfg30VN31aZ7tjd+d18RpW/+xP7SSnj2CIQ87Y4o8Q9Pcni2bWjJgFoE5uePyePzc3x4urgULtLgM5DVrXzSARgYJ/rsQGwytOxu8K7aa/Oi/TxbWUxwJ4jhrQTD4C3eZBhKfKcChQFnrExrSJ8nd0Ras8r1rPamo64U1DNTd146BUuSvyNuwUTCizrQ0H4RUdQ/m7sUYfyArxRYmYj/uwSc2AR/wjzBSnN6Ge+nj0j9KRZSDCtLe5CmT+0nvcnBaeDdhIb7HhnWAh7TpkBCjLoB5YjIGFubj0v0cobF/GeriL2bMoke8hBsTvb9UVNN7HL6l22zAgIwSCQWBydnxJsiZqAWPp5isxPmJHhPiwINPOmtDZTGvnBUqaR54/9NA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(6133799003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rIZp5MqIjVTOJskzNzftaC06279orE3lMVSIXyIRwkNQxv2h4lex1wA0W7f6Jsx8xMql9kzYWUX7nP8MaBMG8bv3GYHHBK5Oob29y13Rvp2eM9CwERFA3uGlLykZylPOd1bDELZG6HMbJJnA1/79YRQiNpifDWFy7ZF/B0mZafsyIXmSjGzUt+dPYAJQjeBJTCypM/BdaKV6lnBIUfcnuff+CBg7qIdB5/yNh17/sVTatSlEk3XDpUgFbkIwygtZE+o2WqMmpDRfKknZxZ6fdWUDNfYvV4G4cdJisuZJC4upbuo8k3g0fbxCWTTVZ+DqktU0YW3Yyp7tC29/qeQlYvEf0wYfdubMguB9oqLZxxRgjEHP45ah4CqPDqa1aHCWGeAfkcT91CphvC3UKRjJlCa8shlN8EA8A6uVCqMEsAEFG49ci4jpRBkrHXYxKH47
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:35:30.4901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff99999-ef54-42da-17df-08dedd28121a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999253
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

If a user has specified pci=realloc,assign-busses on kernel command line
then it's plausible that the bus number in the ACPI VFCT won't match
the bus number the kernel assigned.

In this case the device will fail to probe because of the mismatch.

Loosen the requirements on VFCT bus number matching to allow this case
but log it with dev_notice().

Cc: Oz Tiram <oz@shift-computing.de>
Mario Limonciello (5):
  drm/amdgpu: Fix VFCT bus number matching with soft filter
  drm/amdgpu: Release VFCT ACPI table reference
  drm/radeon: Modernize VFCT error handling
  drm/radeon: Fix VFCT bus number matching with soft filter
  drm/radeon: Validate VBIOS signature in VFCT path

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 62 +++++++++++++++++++----
 drivers/gpu/drm/radeon/radeon_bios.c     | 64 +++++++++++++++++++-----
 2 files changed, 103 insertions(+), 23 deletions(-)

-- 
2.43.0

