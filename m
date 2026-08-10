Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8B3C5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 04:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8848A10E5F9;
	Mon, 10 Aug 2026 04:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fHEJqIBv";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013069.outbound.protection.outlook.com
 [40.93.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A9910E5F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 04:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmTWMtrAvrEXxbpJBolxRlop/YYxHOfPhpBzJ9snT0xf053PaFcqlcMVkxuMqZD/0ngn7yp2fveQ8wq7JnXzEg7pXPefKt3f9xEJygBa+XTGVmOm0RXDx+kJ6BN2vOHOjToeV6RHphBTQxQwOqwxUXuU21oZY66DzG+saGyYQakOie2knF71Fi8mhpCbizNMYFfq9tTdeq51spHLYdxcC7+Hyhw0eIFNGEyKvkUXvBKDcAqeAPjbo0hGBYLu+yHJy5XdPJLm8XIyrhLsG9xOyr93f90LKauN8m5p1CSTjwJO4g6w3SKehIwdBkBTrhMEw6/8ayApDY1MCMFzdz8Nhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwZUB8X7PGep6OcpfkECaCDnukttpm1nyIjwlUAZ/BU=;
 b=eHsJlo4Ny4bHXb0PJBWIHSho2F4OHBBNJea4hVkDdFJCOLKGUJgCvCawLs0XzdewAIlo5Mc4btRk03k0p2eKbTs54NtJJG+Lr7+/xSZEj4hRIGO6fEZ2oFnEwxhp8AaMoHLNobnLltFMTsspnlHQ1EL+cMe1+rPxQhMVuUD6FKh3716drha+rNQWfDrUqS4KOQ/rCj8jNaKZqv+Min2YWOwwYFvhoiHZ2SUfTqagtMy2BPNFu0PyuKzRaEnOZ6Rcaw+QM65OLN/CRVp3jHA0X4uhMR/vNZwBSqt5a2dvqTjY9wcMmQ6cyLFkCABhpKWYWNaPOP7W93bcjfZt2un/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwZUB8X7PGep6OcpfkECaCDnukttpm1nyIjwlUAZ/BU=;
 b=fHEJqIBvQzaLg6rHOnWvWd1sM2lb5w47Wlw35HA2pdhtTOB3L3AgOk9KhjQJrYzK5ZJT+9zqMgKPCOVJNsCoFcdOqksjS34Tb1iq+bLmIHh6brLjmSAJumA/+v/ItoNBaCcKtrG3uC/y+0AbpbeA7lgwoaHrz+y4MbgHiBf4w9w=
Received: from CH0PR04CA0119.namprd04.prod.outlook.com (2603:10b6:610:75::34)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 04:03:06 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::82) by CH0PR04CA0119.outlook.office365.com
 (2603:10b6:610:75::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 04:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 04:03:06 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 23:02:59 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Asad Kamal
 <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/pm: Fix uninitialized clk and is_fine_grained in
 smu_v15_0_set_single_dpm_table
Date: Mon, 10 Aug 2026 09:32:51 +0530
Message-ID: <20260810040251.3819078-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: c82eda1d-6975-43ee-0b41-08def6944855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|11063799006|56012099006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: mErJZgK4234H93ilRhdxdztkJuq3N13ZGFhhnxmJlmW+4xpkTys1lGAl+fo+pr479Nqt/vWA479zHDOeQNS+SktvdWRF+2D56FJp1ZPryBLULqtFf9/pi3WXkBMapBkCqRAuhxEem0g1qxFFJz5ctBty0Ii+TLV4ouZHFC73OZ4YbDGGwrmflgEiDU8Rv1Tu60e3Oy5yRlordlMJx0Bx6kaDTPPOBCrByMJqP73y34aLRDgikKvk0sRG7HF+lrYnMJmOYl6UX4FO8CGLMzzTXVml+gkIbmkVHfCHkfyAIqw4sKep1/poXCEzoilcmxqzgXCONPdkyV2kKCVLeahymxuJWH4M44ayAbqfXQ+hTS0A7UUDdaEoEau5WJmvw1ESg9tiTqAe0UrEW3htlkv50WKujzbuHY92rLJypo3ut96FbPirN5ltLQB8aZ1NZd20ujz7fnVOnf6XsyPHJz3Xl0uzm5BmFTKNLXNA5UG9yhN0fQ8Hxm6g0srwOGXvKlVQwEmIBU6ABhRc8sLiWA1AlKZkGnrIsZCzec5TMnrOtDuDHEs0BE8aNr9cvAvDY9jYSeXrvmbt4665TFTln5auUa1JfOLLGCOOFSgTIfwoAAwT50id3dndSkaU+t5zAoTPxsMiA0hobNwDCb99+QabrPGmZ9vPpWoStIt6BBd6bcpPYC79tR8K6fqN63iCdGA8w/5i0KO005qzT8uoXjoftg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vGrhCaAGaL/rlQS4z5rFr2IrH7Ze4J6fMA79K0nNnI1jeFOo6qwUhrfleMckBou/hf4AESR+g58nU9kQZMlHI5SgId1dE2raRb1O0WG3SnAl4jpZRAFSyU/xdp8lPIccSfNgKmTUtcYsBxCQfEUXWnJS+nFFrT2KrnhIynxen1KozFe9ffa5mexTew8Axi7c994biPnQ6ErBXsBBAecxKVN2QGwuc3ohjeduPRPQcvdz5JMosLSCY39nxctRSkKtElsa/Rp87tDwPqze5BeMzm+q+ymFmbOrbWGw+QDnbiBwCfS8OMniibUwVs33NdjLP2itgloPMNiVATzE0H/biMmRHl6i7zBvZgqIAbZokKrj0GnICdxx3oFs369VYhnnpUQHomx2LZpC5e96ioF1yAl9c9HJ1sI+TVk1Vt6Yx7HoviF4SNSEleWAvMMuAFlo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 04:03:06.1777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82eda1d-6975-43ee-0b41-08def6944855
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224
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

smu_v15_0_set_single_dpm_table() queries fine-grained DPM status and
per-level frequencies from SMU; when DPM is disabled both callees
smu_v15_0_get_fine_grained_status() and
smu_v15_0_get_dpm_freq_by_index() return 0 without writing their output
arguments, leaving is_fine_grained and clk uninitialized before use.
Initialize both to zero to reflect the correct no-op semantics when DPM
is disabled.

Fixes: f7bee962d92a ("drm/amd/pm: Update dpm table structs for smu_v15_0")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Asad Kamal <asad.kamal@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index f1182305d707..29f444aea73a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1249,8 +1249,8 @@ int smu_v15_0_set_single_dpm_table(struct smu_context *smu,
 				   struct smu_dpm_table *single_dpm_table)
 {
 	int ret = 0;
-	uint32_t clk;
-	bool is_fine_grained;
+	u32 clk = 0;
+	bool is_fine_grained = false;
 	int i;
 
 	ret = smu_v15_0_get_dpm_level_count(smu,
-- 
2.34.1

