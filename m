Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A18CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 06:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A406110E3C8;
	Mon, 18 Aug 2025 06:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LTApgNre";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0935810E3C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 06:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEA8jzgYl+Kq3bHAWw8uR1R/0cAM4g21CyR6QoRz7IAsxJXqUBpT8jyvX3gG4X+IU/UEb6KLHjidNl433PWs1N/XtSAmy5Sf/MQCRl+VhhbTD9JbjWk9zWVDT4YXNMWMPzkjlVKKLUxzE8Gw+PNKllaotgNZpoMwDqtfF5XeKP5KxayWLpGWrxpRolor1uQnrhK5AU9PcIlHmSznX2/5oNGKbOcV5hcjTWBtYG7SS4cCa1QKPcR6bpExZFnt4t0RF0Rf1T81mB9Wb3Bu60OKUTFmJoxDA7bq3Zds1S0n519ZcCGp3Dux8jTE5vK5Unsw3yU9Tx0fgUpSAMZvJxtspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsBcUCDBJcqHDjzZ42+Bnwmt7GVV468gmb9sc/5DQ+Y=;
 b=ngYtWqGaIwO1DanBk9xH7XLljSahDrgYrfqKES9tw3Cu1A7FQIrnTA+FK2btl/iWtGVKJQHIeWe3Yz2HHamGYC5H+DL5OcDBu9E5PMmG8UZa0QMBT9rCdtkNPHGYrW+FImXPZjcXSMhyzTeROmuyGQSAoGttkEW2lSlR+YTA/vHW6koh0GsfYTnYIXO8EFdAXbZSihiWLoGIBFe6fsgeTmuUxnDbPOboaRp5qeIIUklgARiE27Wi5W2tyri8gAkov9b6ttjFxwCuTvhTKF4H82/iNcD377D5P8I8nhgZpeizByMtWSRPHAmHqr+9B4hXuuhBRE0Izdhrse7M7kavRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsBcUCDBJcqHDjzZ42+Bnwmt7GVV468gmb9sc/5DQ+Y=;
 b=LTApgNreOgmGoP1kS2bMPfv0+H75eLYpaD7RBt+Zm/8nb7wf9uQE3jUSU0nJqVgEuVCaWWJX8f0VzpYE1PsQ0dF8Fw8Yt2DJuWuqPkySiHrDnu0Qh2s+QDEiSuRm8YIOH4pvnr2L5shiRh4oLZT/U4whzXu+S9cA+giNyeHFRz4=
Received: from CH2PR17CA0025.namprd17.prod.outlook.com (2603:10b6:610:53::35)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:17:32 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::3b) by CH2PR17CA0025.outlook.office365.com
 (2603:10b6:610:53::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Mon,
 18 Aug 2025 06:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 06:17:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 01:17:29 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Make use of __free for cleanup
Date: Mon, 18 Aug 2025 11:47:15 +0530
Message-ID: <20250818061715.2044236-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 938ee8d1-bec8-4d60-bdfe-08ddde1eea5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QHQholwXbflBYs+sAVt5fty+c1xlcaYKldmHUH5iu/i/YXzUPOQGgK8j9sCi?=
 =?us-ascii?Q?UCm6rg8KFft79UCpx5G+IoCMPrXiOnUzxcqnOEuktn5MsHQZz5Ftt6YbbEMf?=
 =?us-ascii?Q?KOX7/CeC1Tmsok3Nt6XnOl2TW58UOfUeb/LjwI3cBV6XQNznYW4WjRkoFu4i?=
 =?us-ascii?Q?hB/dQDxpWTrixRxSslKVkqHMRn7emLYmH9ZDxGrih09rwjYgb4IG8esQpm23?=
 =?us-ascii?Q?Kl5qcuwuMbVNRn4p47rTg2D+OKbl8ReWeSLhfSVQ2SVgRGenBAEqvVI4//dh?=
 =?us-ascii?Q?apq5+Yt5CyAyvaIybZHZmMGNBddNvkUdJfs+YfIwnLJ1cwyVZzcIZDw+4dUX?=
 =?us-ascii?Q?Uqn22cOv/LSGNnS/mXDmPOCVD1RnlGPMa4fQdjWceN+TMGjKM6zfh6FDG66H?=
 =?us-ascii?Q?C0+290ILcXmW4NUvnhsie72haaQWzkC+vkms6Bvn601OkicvcjaONCkYpdXV?=
 =?us-ascii?Q?+pHeRqdp8s9d9kqYhz37ktU3B4UCD5y95jJ2+xRjBWIXxiuKIzf74MluNNFL?=
 =?us-ascii?Q?Y33U1547OG20MZ6yXdOC2398MJ7NbLLD7Unglzg42AcUOzrPTdi+GxTZ7ml9?=
 =?us-ascii?Q?1oL9x1BqmApM+7deuSllcY+U6y2XGuARvaelTvzXfwTnBaYMhcICdcMdX3R5?=
 =?us-ascii?Q?0yPso3ZC6ejZocrtKBePyyINce4l6z+TOPkmaMyOqfy3TIwYKTV0+6ID5FPK?=
 =?us-ascii?Q?/z/iIZj0Km2fHvIB5SVL4pYAHRpmpvvOARlDdU9l7keVCqV+VKxAI12pTr0+?=
 =?us-ascii?Q?sHeLyODIr/JaC4lU4v/3jy7/VgiIP/KYra441dy1FsekkJD0m3N+/dkSwXaj?=
 =?us-ascii?Q?yBZM4Z7Bc24FT89+E9rRORFL8Cb3pn3YkGKCmM7ekMheOJ8RelLe4kXEdVlR?=
 =?us-ascii?Q?++H84RNGK1f9Dx5KGKfsrhwoVYpLUG1CJnkk59s99RDfyDKYvTdAYTbcdapS?=
 =?us-ascii?Q?2St6hcn2mYGWWgk82tC2IVHPTXhLhCbndr5Ej2GzX/LvMKzmzzeoAn8pMke5?=
 =?us-ascii?Q?BuBKEbiGQvjSgMX2ixJJ0W6bPVHPSllTY2Rf3OGskUfNSahikFSPNHHg6fJ/?=
 =?us-ascii?Q?yG0++UH0S2RejL8JRChBt66xr2iL55wGI2Iw/rGafaLAPxyHiDOZTXzeobDo?=
 =?us-ascii?Q?Ih+keASRPhYTA7pBwIPo8nMIEsWDOY7UigySThJuRo0G7xz+dYYYb7/a14s+?=
 =?us-ascii?Q?wbPMZydHf7efhmjLdm4tB3IpQXFR8qJD8BnJuLFR/6fExc0J+KtsrSTxOdQH?=
 =?us-ascii?Q?2xPYaxE+bEUF0oMeMtca0irtcxqf4/MiWgfHiy6uxm0SYallBR56PQNPplzz?=
 =?us-ascii?Q?lZMTHtcYdmmsqx7DsSG2hTKgJFh+wc5HjLo6PrXt2WtaL1MEQQMXsqHE57pT?=
 =?us-ascii?Q?mkEDhcENNRiIKWT8woamChb2xf6rd4fMHibU73ITEBrZE+B4CrTcFp5IUCRd?=
 =?us-ascii?Q?jy8X/pHjD7iH2jvwPZt653zGECUpUyXUaLVSLOQASy0NOaCCW00lLbRfRfdR?=
 =?us-ascii?Q?vQefzXwblwaaIzuE+m2w2RGZF4zihPOxkT4+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:17:31.8474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 938ee8d1-bec8-4d60-bdfe-08ddde1eea5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
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

Use __free() for cleanup during table initialization in SMUv13.0.6

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 627a8188d868..f9363edf16dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -535,6 +535,9 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	void *gpu_metrics_table __free(kfree) = NULL;
+	void *driver_pptable __free(kfree) = NULL;
+	void *metrics_table __free(kfree) = NULL;
 	struct amdgpu_device *adev = smu->adev;
 	int gpu_metrcs_size = METRICS_TABLE_SIZE;
 	int ret;
@@ -553,37 +556,32 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		       PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
-	smu_table->metrics_table = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
-	if (!smu_table->metrics_table)
+	metrics_table = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
+	if (!metrics_table)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
 	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_8);
-	smu_table->gpu_metrics_table =
+	gpu_metrics_table =
 		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table) {
-		kfree(smu_table->metrics_table);
+	if (!gpu_metrics_table)
 		return -ENOMEM;
-	}
 
-	smu_table->driver_pptable =
-		kzalloc(sizeof(struct PPTable_t), GFP_KERNEL);
-	if (!smu_table->driver_pptable) {
-		kfree(smu_table->metrics_table);
-		kfree(smu_table->gpu_metrics_table);
+	driver_pptable = kzalloc(sizeof(struct PPTable_t), GFP_KERNEL);
+	if (!driver_pptable)
 		return -ENOMEM;
-	}
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
 	    IP_VERSION(13, 0, 12)) {
 		ret = smu_v13_0_12_tables_init(smu);
-		if (ret) {
-			kfree(smu_table->metrics_table);
-			kfree(smu_table->gpu_metrics_table);
+		if (ret)
 			return ret;
-		}
 	}
 
+	smu_table->gpu_metrics_table = no_free_ptr(gpu_metrics_table);
+	smu_table->metrics_table = no_free_ptr(metrics_table);
+	smu_table->driver_pptable = no_free_ptr(driver_pptable);
+
 	return 0;
 }
 
-- 
2.49.0

