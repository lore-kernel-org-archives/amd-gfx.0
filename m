Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5498ECD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 04:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB15F10EBE2;
	Thu, 28 May 2026 04:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YNEvGetM";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D46810EBE2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 04:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxZWnqkVaMo3SRLUy24+dyfS1DSVvbHv/EC46LY65HK/Lfn+v+yypyQluHFGMto6ssN4iSWAc5PR9Gn/gr/76Nmi9RmIrJJ47qnxVzXP/JERqDdfFJKZSIpC8fEFEjD9fq4Y7YEZSaBVKrk+Was25PLLSPkCf3sTkfD7xMXYoUadj0gqT6C1nUqUjNUWPPEg60lCxNPoUAf7jIDeS7+2/onieb2YpTW1qdoGWPEMYNSCoGno36zMTN48jUoI8SS52P4h1n0sxTLkfuV5pys1H6t2ppKX0TSsqM52kmHzfI2vL977j0WoRVFiMuZwyFCm/DB5E0mUO4BNd91V2FgXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3J7pzhUCmh7CEYfEMFe9/KaJ8hKQ2URLBlFp/LPps8=;
 b=Mzv47pvSWNpXZKzzs6K50CaCaS/u4ERg4LRQ9ryhn+Z7ryUbSZMCq4NYhkP1hSLz0dacJr8CwFiLFkxjUbdePmwcHyEHsszTYKI4+3e55WXyUR/nPARDWTHjtaFzUPvmPFXo6fwMbgraMZR3eHKTybRmwLSK2vvUrTiTrnCe0F9nG+VfuYDHNqsIJR304PPQyAA4wmVDHn6aQG47NSQ5LFPuVF9dkZ6WKzQC5wTyud5lcNZhWBPUWVZQQqEjaiGFCmQMZxFJtyjCpDNQkZwg+LItfT303aWGlqHI0F23OoqB7CsPl8/4ZcxRmygpwUXs8sIHzd24Xay7txwF9HPI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3J7pzhUCmh7CEYfEMFe9/KaJ8hKQ2URLBlFp/LPps8=;
 b=YNEvGetMtVgCKqYi2rQgNx5RrDmAeRBRrA3R7PLqdNcf464eaq8z8l5frOqWiCMhU178AO33c8UlgmSzdVp8BTruarbmEGxnay9BFj4LrOUMHS+6ZCDGaeS1yC97ctIh4ZT7/KmKXgA7bA6HYIlZaXSLb2J6O8t//uBqFjFNedk=
Received: from SJ0PR03CA0195.namprd03.prod.outlook.com (2603:10b6:a03:2ef::20)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 28 May
 2026 04:34:49 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::5) by SJ0PR03CA0195.outlook.office365.com
 (2603:10b6:a03:2ef::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 04:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 04:34:49 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 23:34:47 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Stanley Yang <stanley.yang@amd.com>, Thomas Chai <yipeng.chai@amd.com>,
 Candice Li <candice.li@amd.com>
Subject: [PATCH 6/8] drm/amd/pm: use kcalloc in phm table copy helpers
Date: Thu, 28 May 2026 12:34:06 +0800
Message-ID: <20260528043408.237209-6-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260528043408.237209-1-candice.li@amd.com>
References: <20260528043408.237209-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae9496c-0f93-4ec2-bfcb-08debc7273fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: gI/2lXvWbZedbEWgiVb0exzUFwaBiiVkapKvjND04DwqRkmR2KJPBcscRM/jJc0D44IQpq19pAFDiCdfGCBgNXoFf7Iocayts0MQadjq+onsyz9N116BFGeK3e6VaF6KgkkXUpo0wHfbm4bfPZsVXkXwPF9N4EdBibKyeP5tYXkBAFaZYCt6rNMnitQCMaSXkV9BliY8r8BPuhy7ttl146/0zTw+E6umBPwk7qlgy3eAd6pQQlYXTSn87LSFBHCXbKq0s6wgnp5CxjOmR3nSeaY1osnb2IPDVfzoNMiqeZbrBijeXve5e+6p7kIpQJuH0RTe8p2tbEm7RcYMfn11+unQNmBsTSKU4lTWG3QDp0k2l9Bu3oHc42/u9UpNKRjp227IFSw7/H06uSyX+tvgxo3KXzoSxfF4K4mICrczFjVx5ZIMrOh9ioPU49pjlTfKUHWwRQ9M4KelitneLm8KUknmYz5a5HcAVDCBvIh0DcrYxEG12y3N2LvvvMBF2jC5IVnGp6NkIT9PiFIlHJ+ETvXb2M8xfGnuYZmsytrLsVFM6CmimretLKy5J1imoY4r1daCECe95pZAeaKApise1mFFIfl73VHMZu0a0TTcV4Fq44vMTf8P8kgxoFGIN3+uqS9RwXCFVGMgbTaLc05hLbshwCIlF315/mHU3d4JBr9TVlNJs5a6yToXGT6pzhN44auvrIOPd0wstAzwR63ChEgLNPJ2HU2ZCREj0KlLhTA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ItpxxEDm63wNscmWkxu+v8F9Y/BsheMF+HqsFsBQ+Di5Aq+2vrXTVAYy2R1YMkQHZvCOVlLrC9pWxK34J/hXuLu3vDLTXEWCE3LYZRJjfcOBz9c51sFcnWkHo6FkZ3F8if/eKbvvsu37eM4SIoV7wkJ7Ha1zQ934mCgG5SE22laW28OL0fu8yokWijdlCAFbfNL2YbbSv7SSLKAoVWXvEgt2ZxWfxjwfWcoXGxc2tIdwChX/dRhec/xGterY5EPDuDC9MNvqrAnLj6LOows+7Xz5Ur6WxwRyM8eWOVn/BjeVTnFu+aZAXFApjXeQP3MMMKU04jBK4q55fsrQSIEDIDP8KGNsqH89oIgwk6aBcE5tJdn4FzPRDBmoDh9VrlyAmtEHQ4+sDzgXnFbIVCl4UZKVmb7NYKJkD4akQ0NdEVFjVM5EBLaalp/VfvvBLZHa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 04:34:49.0330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae9496c-0f93-4ec2-bfcb-08debc7273fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
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

Use kcalloc() so multiplication overflow is detected
and allocation fails safely for phm table copy helpers.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index 5d454b18905ce8..3ee6f086d0c217 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -49,11 +49,10 @@ int phm_copy_clock_limits_array(
 	const uint32_t *pptable_array,
 	uint32_t power_saving_clock_count)
 {
-	uint32_t array_size, i;
+	uint32_t i;
 	uint32_t *table;
 
-	array_size = sizeof(uint32_t) * power_saving_clock_count;
-	table = kzalloc(array_size, GFP_KERNEL);
+	table = kcalloc(power_saving_clock_count, sizeof(uint32_t), GFP_KERNEL);
 	if (NULL == table)
 		return -ENOMEM;
 
@@ -71,11 +70,10 @@ int phm_copy_overdrive_settings_limits_array(
 	const uint32_t *pptable_array,
 	uint32_t od_setting_count)
 {
-	uint32_t array_size, i;
+	uint32_t i;
 	uint32_t *table;
 
-	array_size = sizeof(uint32_t) * od_setting_count;
-	table = kzalloc(array_size, GFP_KERNEL);
+	table = kcalloc(od_setting_count, sizeof(uint32_t), GFP_KERNEL);
 	if (NULL == table)
 		return -ENOMEM;
 
-- 
2.25.1

