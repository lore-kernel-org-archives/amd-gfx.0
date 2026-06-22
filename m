Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15ECCD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E50910E48D;
	Mon, 22 Jun 2026 04:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qiJoIZ2t";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4712710E48B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8NwDkiLDXwpK7aE8JU23gAdEEn4pZMIJzD8MQKoS5OPRmxCKZj7Ms6V+OdTuS+xpnBBO1rpMh+/EzT5Bu3pyiYyl/RpUFjoLXlAJeRbBglPclUV+VVC0m0rIwUq1261rSa/Dc6Mh8Jqm8XX1jLvBEgqXsGqsbhje+6v7hhXjgPczwetYWN2evBaFwEHBxqj/LHhEOOOx86jiz6QTfAmE0BCjnMQJ4s9mnAT42tbVembOHmqMNEMJVuV+OvozYkRUCQVo/3ofi/pROWpXDGSETBeLJDBHbVUPNbLPSxG9D1X3tMByx29ZgP0rRBDjYS5EJfcgwPjZ4w8//AnOKbkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y38DLTY51/DnTWr+JGPD+KS/J9vq4lF2kJMi7LmKRxI=;
 b=SSgyNEow7OK9bJpFjPwLzig0024OkFqt0NI7xaXXxWvrRlqlb/ujl69uxALnf9IVPjFoZ/IbFlFDsBfb667rfU495FPf/o9ko3WtfCQi5XR+hc4TlEeqW3XAaph2+5qP5gsqrCsj9NRlxcNgVfk51+r/DXH3p2M/EJV6V1cO/T+mdTzUg01k4ZHlLkLHbRBHeHY9jaPZ3UtxVNuApFRu7KyzrC2kLgJOZZCsjPf22vts9tP/kAC54KBu5are7ujBuAgwxHKUmK4PCmSlcjjUpNbv80j/4CyzrBPojDTRE6qlAsAa4Yk2b53svHrE54ylZ4vJWLOcTg/1OyXo6JtS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y38DLTY51/DnTWr+JGPD+KS/J9vq4lF2kJMi7LmKRxI=;
 b=qiJoIZ2tKT3pCeDl3Yeu9S0Afc/eMjEbetO0L9vHRzgBDWwC/tHYn/YtLwpU0PIOSXoLx3KRZt8odYAHVdEHplj32oceqZa8vX+XbP0KrKYPmITx6kd/jfygz7Ed6xMqvcvyXN72q8S4196mjehIKHEZUVAnkOF1B7sbr9xBcVE=
Received: from IA4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::11)
 by IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 04:43:23 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::28) by IA4P220CA0011.outlook.office365.com
 (2603:10b6:208:558::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 04:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:43:22 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:43:21 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 44/48] drm/amdgpu: retire legacy get_retire_flip_bits for
 UMC
Date: Mon, 22 Jun 2026 12:40:33 +0800
Message-ID: <67b11d39d67d4a145ee8e206bcc00881a718019a.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ef5084-855c-49b1-dbbe-08ded018ca9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6mTu+Bz48GuIwklUvo6/9MmjjWVuVFyWs+Mw8rWdrqaBfsaKwsHmoabt6dxt/Mt7xBM9D0jkB4cqpxMRP0Yt4oJ9+jYIUZ9Rq97yWwTYeQAnZ/nuNvEF7SmBZ6hG2EkPK9DJdnXbSSVeujVk1pZV5LEnSvg8F+Duo3+74i0Aux5ZJTZBz343elscTKC2m+ka/sbNIB8s+31LOgjDkmzbUqEFasljnVZKwkFsILmYm2UtDfXWif8Vch2068AnqgfUklpN3fZbI/qzE4TKwXf9MNpX7yTwFfAjlyEkJVQFECQyaMDIsVZ3iYZ+ux9twR+csf1eNS4ejQt/EwxJ0mBKYRQhs/cXjzmJLzV8aq51DMKTYxsWzmk5iHl5L+ZokbdHdGWCvDXodvZoLihI27iL2/4syv2V2YIjiKVDHlsEMwzftDTeiIrg34jkcKoPz0W859WnjqZVlaYZNPVYTW82ejjcMYoeBw0Xm/lBEMrLOYchned73ZqY0vuPrYpkMcEfMA18UJDwdMv3xBzbwETOqxPpvVWyAc9KfT1bJ2NtojbDNQVYSIqQ2J2XEQWQi9Jec/2ZRFF3HxwS6vdG5sEM3epKil0L37tw1mtV/bo/urAAZeUivPJC63F16PVg7GkyPxDnDMWTGzv+PkzzlDlkbWsR23xbwhkqEerLRp/r1ACA6BPdqQYSAKJmMiJkh8CCoh/IbN2JFPj8g47glvQ5ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KVG0rAAmAHWuzA0D9Z4zMWjuKHcTAwci1HSxYSZf5gVPZlAaTUivX5k//Qy3M/5mn0SPG7c0cgWD0GdVFef4soZdXu+p5HzILyQmZZEPKOHAiJ5w/vGRW8KiXaOVCOih8IMcIkpR519T8hutqPybvWdaAX6SIXLXyIMQ1XemgLYbLFeFvenXWkag53mWPvxWtYEB77hOkT2WGqNx2axTpoK3hPWojMdwqiSOThKAbczRJ5h5qfbpCSBz2OfrETrwA9iUzY6u8SgGchJLm3KNpg20ivqvceFtNhooTO/5OFyoKbk+YaIRuxofUhDQx2DMzdamY4hv6W9wuPpR5yWHaPWUGj1TfnwbLNp8GQNKEqaRcYPPTF5YRVCvT26jcDojn6sMNGUfj5oze5vwHm2IpTJFd3K4gsWLkpkUs9MtBh4bFeYWPY7H2tli0wHLAgqi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:43:22.9793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ef5084-855c-49b1-dbbe-08ded018ca9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286
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

Remove the legacy get_retire_flip_bits implementation for UMC v12

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 106 -------------------------
 1 file changed, 106 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index d62712324940..d3eeaead7ca2 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -73,115 +73,9 @@ bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_
 		!(umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)))));
 }
 
-static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
-{
-	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
-	uint32_t vram_type = adev->gmc.vram_type;
-	struct amdgpu_umc_flip_bits *flip_bits = &(adev->umc.flip_bits);
-
-	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
-		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
-
-	if (adev->gmc.num_umc == 16) {
-		/* default setting */
-		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_C2_BIT;
-		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
-		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
-		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
-		flip_bits->flip_row_bit = 13;
-		flip_bits->bit_num = 4;
-		flip_bits->r13_in_pa = UMC_V12_0_PA_R13_BIT;
-
-		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
-			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
-			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
-			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
-			flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
-		} else if (nps == AMDGPU_NPS4_PARTITION_MODE) {
-			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
-			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
-			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
-			flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
-		}
-
-		switch (vram_type) {
-		case AMDGPU_VRAM_TYPE_HBM:
-			/* other nps modes are taken as nps1 */
-			if (nps == AMDGPU_NPS2_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-
-			break;
-		case AMDGPU_VRAM_TYPE_HBM3E:
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-			flip_bits->flip_row_bit = 12;
-
-			if (nps == AMDGPU_NPS2_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
-
-			break;
-		default:
-			dev_warn(adev->dev,
-				"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
-			break;
-		}
-	} else if (adev->gmc.num_umc == 8) {
-		/* default setting */
-		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
-		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
-		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
-		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-		flip_bits->flip_row_bit = 12;
-		flip_bits->bit_num = 4;
-		flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
-
-		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
-			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
-			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
-			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
-			flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
-		}
-
-		switch (vram_type) {
-		case AMDGPU_VRAM_TYPE_HBM:
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-
-			/* other nps modes are taken as nps1 */
-			if (nps == AMDGPU_NPS2_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-
-			break;
-		case AMDGPU_VRAM_TYPE_HBM3E:
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-			flip_bits->flip_row_bit = 12;
-
-			if (nps == AMDGPU_NPS2_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
-
-			break;
-		default:
-			dev_warn(adev->dev,
-				"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
-			break;
-		}
-	} else {
-		dev_warn(adev->dev,
-			"Unsupported UMC number(%d), failed to set RAS flip bits.\n",
-			adev->gmc.num_umc);
-
-		return;
-	}
-
-	adev->umc.retire_unit = 0x1 << flip_bits->bit_num;
-}
-
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = NULL,
 	},
-	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
 };
 
-- 
2.34.1

