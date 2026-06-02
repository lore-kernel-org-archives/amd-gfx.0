Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722DEC5DF71
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 08:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D35113965;
	Tue,  2 Jun 2026 08:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="msdLslhA";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75381113965
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 08:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blJeLVAVIzlPnLh4NfHlf4+7LKLtjKEQTp2AwfSUrk5TBAgJn+GaNCcfAD+tfdiwOqIhRDFf3GgfeHxOfbdgAH5hrLbs3Ll6KPUeNBt45ZaY9Uf9mr5LLGu6Azre1kgHU6RmnzySnHGnVmHfyM+ohdnQ4h2Ip9CExYmuaUOY10Iywx/739UBpeOAbC/WB6p+loKbntt0K3zu8dXSmlRUuy2h2TBfZbzpZk4S40yZdGkIGeeuevz4tSenVU9H//+HzKhRGNTzG8/DvOI+FWmOz6YtzTxGmo63YwGYERuBzXnDO42YHNthrKGV8DRdbToTMBKjSAMeXxWdaTALmmCPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meOMIaWeB27OBpQyLfip55YtHzIUaFr6p2Ph2egOqCY=;
 b=usPupQK8u6fj/Fzif6Su/pbgag7CzqHjlrmlECpgZOlR4s4Fk1cEoYBKh9LuvnZWtYuwOA48LSaRmVPHMqMIoqJzssqyXrpdQF+Of+oM5mvLdpzQRWoogpFhltbn7aYjSZLx976ELthhRESyoJA6vd+Nxhb1DQVPdZ/IOtMdRV38/DjlwMPOJgyB8TkuQBOZcUnPCZ70BN0DjEj+S0BFF/ent5lz3hjms9Bq62QcWIrBYHUE/ro39PUcMNozSv7qLTbZtr/kov5xVbRip9V7ywE21Un02isOt7dbPcrd+HSmjl985LB7ZYLPNlQNDJpEQRg0Nj5EJ6K4hw6tq1x9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meOMIaWeB27OBpQyLfip55YtHzIUaFr6p2Ph2egOqCY=;
 b=msdLslhAYoW26QWvtyS0lfnQHEW2o7aursc5Ab8dveyYNGOi9D10XBhCJpMcPsNce4annBrsNR6kpTEAnDkcvZzk9Ni738J5I+T/GtUcePQc0cDuiEt8y9ccBhPVNu43v1eN5m+skukXUiwJqbHt+4kALD+/o586j+Mk+CWqDC4=
Received: from DS7PR03CA0005.namprd03.prod.outlook.com (2603:10b6:5:3b8::10)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 08:43:28 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::47) by DS7PR03CA0005.outlook.office365.com
 (2603:10b6:5:3b8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 08:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 08:43:27 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 03:43:25 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v1 3/3] drm/amdgpu/ras: adjust the update of RAS bad page
 number
Date: Tue, 2 Jun 2026 16:43:16 +0800
Message-ID: <9a1346209f18c9525e24368f09c24e588a236bf8.1780389586.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1780389586.git.cesun102@amd.com>
References: <cover.1780389586.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0d7b0f-ce41-43bf-d302-08dec0830441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: B6gQk/lFnzH80SMHvc2s4ol+oCaC9hx54LO88cRRQNIcyymqgAIBIaidTUhMUGURnwqvGHWp24Odh7B6v5q+jZiiug+HXbXr4MMmByZ8aE/dNVGLrtc4xdqetN9G1DOP2nS1JwWWTpqD8e+2GqRzqnxKmsb73GIxEzMcHv/kvXjVSS2UZvn0sZWricZjoS7whVRl8frkH1xHXaC4Uryp/ULs5HAfK/hDGhJWN5q4lL7AhZAMoG1ewY/MY+SIWt9lW/I/CGO3RzOhsOzMwUHgu5dgwn7G1hZxUmgMm02DWnRPI3vjXzc0IVFG9g7z9zuej3VKSIy+ftn9/DYTvTHPGyVIgTuH6Lgw7IS66KeM+4cFOqXBAO2fwV4Be5cZ2F9LChMkfHUFTDexViFT7NpwNITKmCPGH10mnfFdxCELziIkDaV4GtvBiFQRRdMKfewbEA8CZ23B5ctXkE0XZhxRy0GiOpYb4cV4tM/3krBfFf0n04FtiCh3FaHZ9HQ4hW9yx6rSGi/fYRG1hlt+ACkCUMzKw1vkp61sIz/NRwcl4hjmjPysaBLsRXaiFB08Btl5CUfswn5JNVcPum4LhtmJhM2e5jx/PabUOCZOYV6GsRHv3F8toKAoFBOfzk2KYvAtRDT1byU61D2y6i+/T1dNWosSRHjewIkaLUXjwvGEtogx9+3LBsjVDFiqijQxzhtw5Cez6XPX3WZf9MbbIbRq6VSrzQ9ij5HrV9xFF79kYBk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BNqUonfIejv3jhNfJtzOSMOcMIfl+p+lyV6ncYNPLcYo31gljcmKmnvnYiRVumpTXzftR9DsqXd0uhyUn6PMOy13SnmsexXniJc9hPA2nMpw3O3qXSU8HI0m8AYlvNOOGmlVpfu5PEbOKN5/ueLisSkBepcvwlLLxuBlnFijhaeA8etBzuFH8S2e5ykdyMMWSHsuWKtIMakpZKSHozM1EKjysQbVhyOXXelKeZ0uuo3Krn2aPHyhiXuQ57elOust/Vo8ORmR1GJIgCCLGR+TZYb/yIuniD1ymB0wEiS0X3sJvh9WcXbaMR3Ctj4QkFKojRcvB63qWLuSeBbR13+qhbwUHSBb4ijUejKR/oy708TcS39QUw7Sl/3bLcuVlo1EVESQ+IJIwHQ11+O+emPLcylzxZoOdyodx4Hd8kJ2y25hCEH22XQdZym9JVde2VGH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:43:27.7065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0d7b0f-ce41-43bf-d302-08dec0830441
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
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

One eeprom record may not map to unit number of bad pages,
Correct the relevant update logic accordingly

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c       | 5 +++--
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h       | 2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index cff6245d8add..b03f72735878 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -525,7 +525,7 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
 	struct eeprom_store_record *data = &ras_umc->umc_err_data.rom_data;
 	uint32_t eeprom_record_num;
-	int save_count;
+	int save_count,map_save_count;
 	int ret = 0;
 
 	if (!data->bps)
@@ -537,6 +537,7 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 		eeprom_record_num = ras_eeprom_get_record_count(ras_core);
 	mutex_lock(&ras_umc->umc_lock);
 	save_count = data->count - eeprom_record_num;
+	map_save_count = save_count * ras_core->ras_umc.retire_unit;
 	/* only new entries are saved */
 	if (save_count > 0) {
 		if (ras_fw_eeprom_supported(ras_core))
@@ -551,7 +552,7 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 			goto exit;
 		}
 
-		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n", save_count);
+		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n", map_save_count);
 	}
 
 exit:
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index 4a693865a9be..48131bbca00e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -144,6 +144,8 @@ struct ras_umc {
 	u32 pending_ecc_count;
 	/* number of entries dropped because pending_ecc_list was full */
 	u32 pending_ecc_dropped;
+	/* how many pages are retired */
+	u32 retire_unit;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index a272e0d80cdb..8861cb0f01f4 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -110,6 +110,7 @@ static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
 			"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
 		break;
 	}
+	ras_core->ras_umc.retire_unit = 0x1 << flip_bits->bit_num;
 }
 
 static uint64_t  convert_nps_pa_to_row_pa(struct ras_core_context *ras_core,
@@ -166,7 +167,7 @@ static int lookup_bad_pages_in_a_row(struct ras_core_context *ras_core,
 
 	idx = 0;
 	row = 0;
-	retire_unit = 0x1 << flip_bits.bit_num;
+	retire_unit = ras_core->ras_umc.retire_unit;
 	/* loop for all possibilities of retire bits */
 	for (column = 0; column < retire_unit; column++) {
 		soc_pa = row_pa;
-- 
2.34.1

