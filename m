Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539B7C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E8710F752;
	Fri, 14 Aug 2026 21:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P8YzOQlf";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B7CA10F735
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXdTfkTlseUJCu7oHNcm9PfYMwkazZ1wAiL4vceJlDCFA8FYZwCQtMnHCnLtFVQv8TSRvVKN7OgWgrhfrXDASZfQvX8oXLn7r4p50xgVQNDju7hCg31aoXbRzT4+8k3g8nvVY4JzMyQCEC5FgYAUCKi05v2VGzym8h+Y7ebLGYs67QwPn8kNnTbzrRbpCh3E+u9QJWV1yhq/O05Zt7ntD8uV0TG2sfb8xDiZIQTKxxDbJqd93d7PedVj37fMpghsalvzdMp4JT94Y5gXs6lNOJ8Ac8RU4dq0hkfFKHQtZ5J1SPvShPJw9UdvOoyxht2vgfoX7kvuwn6Ykg/VTuxTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6QZoT92WFi5cSX1eQv6MNp5OCqYEgZOTffJTc6gbNw=;
 b=b7SQdvoxkLoMZN8mGAISCNaS0CB33pgGiPaeDhnaE4aYInnVqHUjbQKjzsewPfsJda1i/Afw8GtHHCz6zpiJqxbeRcMrLPKTOk3NCqtiYU2ZG2AjbXMWihQK/4n9sQpNuroIIqtLzNkAIJitJYwNffML8oSio1QywmJk2c8xbIPXYr/ieG7dsrCdoxBgv7+F0CO5yzzI66Mqkt5DZhzdK7Bzqvwn7zfSt1BehBAE7/fKRSMDoNv03JmXjUc7ZePQ1ySSE5L+xcvEUlWlsVOavjdXpke/PIJU/psvbLHaGTKCjhtJpVwDur26ODLIKpKoNeZD2F9Oef53xstENif1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6QZoT92WFi5cSX1eQv6MNp5OCqYEgZOTffJTc6gbNw=;
 b=P8YzOQlf+ubim8aWOWb38d9YhWc2RaqaviPXhCPk1vvI0Ib938be4eBpLhmovCYDqPlsEXnKdc3cPpsnsewc7VYQoXA2SMpj2yFwK0ShD3FMSE5yyk3m/0x5MU2byzlpA0FNVf9wJ/WTmj5IX/z860NZr4hwGYRD9zzkLHb4xwU=
Received: from BN0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:e7::29)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:04:09 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::86) by BN0PR03CA0054.outlook.office365.com
 (2603:10b6:408:e7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:04:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:04:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:04:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 106/109] drm/amd/ras: collect CPU MCE metadata
Date: Fri, 14 Aug 2026 17:02:43 -0400
Message-ID: <20260814210246.3067612-107-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: d3809a07-5042-4d63-4722-08defa4795db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: PQ4kBdw3wMkORNsyRkiSZ4CKkW0YA41jNX8nxaIliT4D7pxVbNf+5S16K+agxc8rTYtq4/vprvRC5v7RgqJth+ZCxQxUFxSz7HF0JfEClgjpevAVKLVyse0JLXFw5UBVr96mLLNy6M4hsOptCjEjEbwov4LQO3oAg9s2grIfyXnKedlInYWoFSnbYSyEOhZYTQ33KJA35E/Bohpp6sgWgyWvIXfx0FkdjXHe8wgoAvl5zm+3fPwF90ohKF5D86xkw8SQ7CB7MSBRzP83omkc7S8JdddT9IK8CmhtPBH/gMovhMafOD/Uy/mULiYeVmR7vxkAhDwFN2mIMX14zRrq48tY1MyyH2fAuhUVgxQ4IZmEUH5K3UL5OE+V+AYDz++jfE+gitZ3+g+9GTd3OEK43uCiysXTiOab/9AVTHoIbY7OZc/mOoo7OxButQmn8R0LSQaNnznSXhWLUEGVpm9dyKCUtNmWrZgSXYyAhpgDZVjah+dPc/IoF6z9gi01OZ1d1lY6jBpBGxA5VXNPkDGbiwkdA6a7qY4n1wm3/BrzAYaiQFiJplczN1UOYY8sjI3ai183qE+VAQtynzyreqBpf7BXgJZ2Gy4dwAE/TsPGnKGeNsWsHuq3DGKwIv2yNDyI4cYaXehU0a4nC1hKSCu6/y/LxYzxDodmvlLUqbrbDAiuQJv3KsRJ/zA5MYE+WgB0Bq5GSSCvHJo4wxJMFfrbig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 03b724RKom04i9HuXlTij7XEPNK1OZ7WvQnJWrDQakUi2jmlu5jojo5xe5Ai/gaECOmUnxls/6rd0TwV/VU3FpsSi/OxfbDzt/jYrchNpz/6jf00EYF9mBOlJdHsJMDfBweWjiG3snzzSx1jDX5RtaA4FVH7nkw9VGCVueJqIQfeTM5AgUPBvH6oUbdrKgiq9TP9kAaekJUNSmYy2aLwIutQdvi57pHekAL1SEbfenFYaUIkSwaMTjXJI+ixsXUa01eABdyEmOL18Ilk2x24VLdBfp4hJSKyLNJWs0NMBlTleZcXtM2l6e5XOC3THe6m6GL3V8RMsCBA8Ua3L1awoUrxctSAVQdMyklWHOpL4BxUERba1Za1+7jayZG/SuOWL80hGQzrZYQ222PpVSwE29S1PrpD0jzM6k4WrsATROXmIG9siR0wgZy5iUETmxYd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:04:09.6526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3809a07-5042-4d63-4722-08defa4795db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956
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

From: Xiang Liu <xiang.liu@amd.com>

Processor CPER generation needs the APIC ID and bank number from the
x86 machine-check record. CPU banks must also be logged by only one GPU
to avoid duplicate processor records.

Copy the APIC ID and bank number into the rascore ACA bank and route CPU
banks through the first registered GPU. Keep GPU banks routed by their
decoded socket ID.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
index bc7a44618ac6c..ad978ed458437 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
@@ -133,6 +133,8 @@ static void __fill_mce_to_aca_bank(struct amdgpu_device *adev,
 	aca_bank->timestamp = m->time;
 	aca_bank->bank_type = bank_type;
 	aca_bank->ecc_type = RAS_ERR_TYPE__MCE;
+	aca_bank->apic_id = m->apicid;
+	aca_bank->bank = m->bank;
 	aca_bank->regs[ACA_REG_IDX__STATUS] = m->status;
 	aca_bank->regs[ACA_REG_IDX__ADDR] = m->addr;
 	aca_bank->regs[ACA_REG_IDX__MISC0] = m->misc;
@@ -186,9 +188,11 @@ static int amdgpu_ras_mce_notifier_v5(struct amdgpu_device *adev, unsigned int i
 
 	if (ras_mce_check_bank(ras_mgr->ras_core, MCE_BANK_TYPE_GPU, m->bank)) {
 		bank_type = MCE_BANK_TYPE_GPU;
-	/* For CPU bank, only the first registered gpu device needs to record bank */
-	} else if (ras_mce_check_bank(ras_mgr->ras_core, MCE_BANK_TYPE_CPU, m->bank) &&
-			!id) {
+	} else if (ras_mce_check_bank(ras_mgr->ras_core, MCE_BANK_TYPE_CPU, m->bank)) {
+		/* For CPU bank, only the first registered gpu device needs to record bank */
+		if (id)
+			return 0;
+
 		bank_type = MCE_BANK_TYPE_CPU;
 	} else {
 		RAS_DEV_WARN(adev, "Unsupported mce bank: %u\n",  m->bank);
-- 
2.55.0

