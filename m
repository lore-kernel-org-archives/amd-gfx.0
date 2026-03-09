Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EE3EFCD73
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 09:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D031F10E1BE;
	Mon,  9 Mar 2026 09:49:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xocu4he8";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC6310E1BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 09:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwZKn03JSGFrPbajzi8lLz17TcWhX1JQ1upgUTWWMj3Npe62nRnwzrHYL2fpHEDaH50WWiajMKZqYMUMgPBCR1XqCDpAH4bnqs7VudeDhKVph7EXSAq7tZTkpybQDVGsujSDINQNR/+QspiRFhbPO2JzODq1PMFbBhbf46AWnve6990+jcv24uNbkqjMV4rJ0pp4cHaD92wg3vVUA2Jh1HFaUaSHOsKfvEsSM1fSoKIYYSYguplQiMqLji9sUWXMtAmnEMNKuHgUgzPmhxqEaL90NSA88fuUPDinrngFjE3gCZWAWY7HKygQhSSnqEPCbr3XrwNPdo1LTimcjHXJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iQKF9j7BU8lCQycidfuRmD60F09idFRUOAIwP+B3dU=;
 b=wePJ7MjLSVECqHQx7oabMe+aLsviKMOOYITIWAQAw0EjCVJrZ+NHI51H+G1AuNJVQRsB0AHldw3bB6nIonbwrGvYiL6y5Yuw3barZe1Zz8kUw6e62OgKrG/eFPVd57tqs8js6155zoK+OtUHsCCy1g4H6a0VkuQlhXpCR8Ayul3PvbtK4KeuA1Bd6d0jSXJ8G9DUuFKNUrpixiSXRSxc2/imyiYwrbtXWLVeN3ozc7WUNrXW2siftlCL+HGK2JBHQnTnqldNMu+ZrLRbGmA7BJqXdaOgriYawek6ypxakNokjqeEjaVKBsp6ModzCdWpZMpRM8Mt3npOHrnZe94d8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iQKF9j7BU8lCQycidfuRmD60F09idFRUOAIwP+B3dU=;
 b=Xocu4he8PGPIuFlHHQ1St5cJzk/2VvjHhJZno8H3PC/+gtF5d2y4Gpw9BMDAVAawVuM1lrxKs4gSCUp47JjajoZ69q1NsnJuHPU4fhE94szhef37tPQ+lNoqKQCdc0CpUWXiqSrEgL6zI6WKuZYOqoM9uULIYZK338SNZggWkoc=
Received: from BY5PR17CA0009.namprd17.prod.outlook.com (2603:10b6:a03:1b8::22)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 09:49:43 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::7b) by BY5PR17CA0009.outlook.office365.com
 (2603:10b6:a03:1b8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Mon,
 9 Mar 2026 09:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:49:43 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 04:49:40 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Fix xgmi max speed reporting
Date: Mon, 9 Mar 2026 15:19:22 +0530
Message-ID: <20260309094922.3486621-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2f90db-7f5b-4f15-643f-08de7dc130b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014; 
X-Microsoft-Antispam-Message-Info: N3IhHkBqJANNVXBwK18cUUx7RxIZ8YniNLZde9cdc9o534d7xvuRtjQzUaU3ogULUHOR8d4sZqdJ0K6SQa78RSIe2qD0/Ro1lqwJ+jvki6uvP6gN72EZig3d3+ITASeDTfTY+2Xj5cwWuWgaQa6TC51xeF9MoEQTnDYQ9RaY186ZMEXj1dIRKE+4s0whpXJTtUs8WMNpkGvkrx9TIYpgAVARbTxnYm2SkkV0vC71XW46VJX0bTQHAQxpQvL8EV3IBrCza5gfI8FR8fDtHCmfsNuCyaqERMytfi3Lun88rqrfsC9sG7bPYH1ufcg5EzAlHD7AzfU3YKMHdD1qpne06+Vm14sQU6J2Iq6ntGC7bWcBCs0/fZXPinXsDaD09lakUtSnpEj4j/i+vq5xiBYwVWYat3nRQT4t3nharMMBfb7ZTGgOsrl8UFjptv0BGz4W6lOLgLHPy29n1C2znoFc+cHUsU3nf+NmnKxQqoDav9nRlcy7ExYn3Tnh1bC+ccJzENTHj57EgsfPRsM7E1leUYHibpjiUqcZIW74wXObaG6/0ZYy8VlweM3Lc2qSAp6mpEGpZGoM3pLsg2DBkdgwjJ8nKQ0oLx1YjqzRUG09ODfYpmd5mBaEV6a0sfGAtX7LkVIINkFM6aL3FuV9qm6ajZN+fh3UiITvua7T5NY9EnTUCQrNCck+x6KlgYoD2kewJDt7E1j6Knt+7R6WIzdbQlkjHJZcScjzOrectjHr2OjfwIBlweH4W9H1bvemaH5asCGwsA1p94rHacvJpg9Ibw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 19/UoNDgn0NPyHkk0pwjr2/wyxrHEN8eQifgKsEa9Ts06qOwoRpDGF9HLFe2zziDgva7QGEyQ0oAimUOnPb1uc7hFmBRgl49ISbiOG4dOqeeKE8C5Uta+s1EtZWPkNZ/xMP3IrbjWcTOTFhmAkfVZ/GBjNHnYwDjz7a4hDOvKq36bJoB3BAoAsX0zXiNLllOlKPTEkiz6uv2VJmlWrlYC8P3xmIQ85Np8SIvSGv8xMzuxraiBe/gHaDaM9LhrzOn86V28J2Cb0MU+ucAOf9G+COOde8y9u1XyTxIEz7iZLrBmqEciIR9G+1bhmuR83L0mTP5x8XbB6FV4Lo8ID+Os6Kjekpj7GjEml3Z4FPI7PnW8rszaBfn7HQOfOa5Zrp0icdgFwYBSkTWWQk7cfdE2mg/Zw4yVXF+FcPTXadeO/lCni963WvZ0717EvNkAurn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:49:43.1201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2f90db-7f5b-4f15-643f-08de7dc130b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
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

Fix XGMI max bitrate/width reporting on SMUv13.0.12 SOCs. The data
format got changed when moved to static table from dynamic metrics
table.

Fixes: 1bec2f270766 ("drm/amd/pm: Fetch SMUv13.0.12 xgmi max speed/width")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index f2a6ecb64c03..29cdb479770a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -262,8 +262,9 @@ static void smu_v13_0_12_init_xgmi_data(struct smu_context *smu,
 	int ret;
 
 	if (smu_table->tables[SMU_TABLE_SMU_METRICS].version >= 0x13) {
-		max_width = (uint8_t)static_metrics->MaxXgmiWidth;
-		max_speed = (uint16_t)static_metrics->MaxXgmiBitrate;
+		max_width = (uint8_t)SMUQ10_ROUND(static_metrics->MaxXgmiWidth);
+		max_speed =
+			(uint16_t)SMUQ10_ROUND(static_metrics->MaxXgmiBitrate);
 		ret = 0;
 	} else {
 		MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
-- 
2.49.0

