Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A7CCD6E5D
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 02:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D865E10E32F;
	Wed,  3 Jun 2026 02:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lOVOkxz9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012043.outbound.protection.outlook.com
 [40.93.195.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BF210E32F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 02:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iov2B4oj31hDswdHMq+FuTvXAVkxkuWsLtdCwCStSR+oIHVEQX6rj7Yh6tUJ2ZQbQdz0FReVs/fuXb+u1wpR9zOyEOER2VeiKmN8rU6ydHnSE7M6Cw46Kc1hOQ0LrMdoTyEL8O1pMyiKnI6QH+hsKMayjz3eVFWsNe3kLUzerphW1KWzQNj+cSamRN8vDpC101IMBdduHPk4c9TMXGcL3skghNfZjq2iEoZtbJ3I8XNW692mJy7IjKGIh65j32lQs/4pzT35U+gTRC24Qgrp7kXdM/Bs4Z6jdAclX4r5OLM2EA9pmGj4rtIdiShGYwsuhdFom7wBrcNtcUjnv/x+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQuWpPXbAd2RpOjU5IkM7lTzmGktYaHE2zYfOo4DXOs=;
 b=H3KPlRTLVaWthngPiHfNPVvPMLaaGccASJwG75PFvlX20e50uioRRQUluHUReB5RQnJ2Rlu/5Brnr3ya9GZgDOW1R+N2FQFV5ULuK1q7sU/necAJN88I6/CR3VRpFm4aagFo7wbyfDuj1izSe8ALKjjjCTHsdR1b3mf7e2NpN0v4Rbd15y9cdGlZc8hG8u3qt9yC5pzL6MgR100cus8vRQmBgye7VP3NUEIglH1T+Vj5zCkHorSYuFQ2GoNXX5QlXSFlbc5anr6fM+L0VRpkitzwDH9bjKG6Jl6a+RLBjPN51CyvsGeDnOnyoVh3NtIh5D4jpowaS262TzSRGKENhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQuWpPXbAd2RpOjU5IkM7lTzmGktYaHE2zYfOo4DXOs=;
 b=lOVOkxz9JUyr42cwkQr1eK/gbZoCdyk4GgspB1TnaKbUDdV7rtwc/6oTEUAzTBMihnTq3DEcodkAT0l4yRBsbVsCuakLapysWxZa0bPyGxV73P1ElflPX53USMHrE1SsE5Vs/laf4ohqDjmKz06CevuIPzuiRaeW7X82xlIXLRc=
Received: from CH0PR03CA0186.namprd03.prod.outlook.com (2603:10b6:610:e4::11)
 by BN5PR12MB9509.namprd12.prod.outlook.com (2603:10b6:408:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 02:51:52 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::49) by CH0PR03CA0186.outlook.office365.com
 (2603:10b6:610:e4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 02:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 02:51:51 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 21:51:49 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v1 2/2] drm/amdgpu/ras: adjust the update of RAS bad page
 number
Date: Wed, 3 Jun 2026 10:51:40 +0800
Message-ID: <9121837bc19d90122953bf4f398fd4c5d8206a1a.1780454960.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1780454960.git.cesun102@amd.com>
References: <cover.1780454960.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|BN5PR12MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: f95a49c6-9c2f-4bad-8add-08dec11b106e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: avDdmw5zSkUqJM/cVZiLazH0nyZS8O3BOlBag+/N8Xlg47UUGl/LnWYi2Y3H7Uq/wcN0aKSKpd+qLqpsPxgoEGk4fWASz42y2h2kEKwcVVwraZx1mNI4oOZ58J4pP3CAdau7R/sEZz2xJH6rXyAm4Y4KXEK1XzTVYxWwmdmlCiP25UwVsbDKb+38jk+k1SEt30psLfmCrTDD0xcKZYUocKMtEG44cGVCyz5qfNV5bXe5XmrnGwl2alDa6ooxElMuJugprp9TY33Kp96rKbyKVHVl5zcXZhW03+vNLhivVHo0psxTSXO9z5JFErevbL7ES3zdYhZxhMoGYUZa75CP/AGZWNsGbFDaf+HcnJVXjyeENEN6fMe24BFWDv9n0gU3Prm/8kFg25O3y8WFnYPFKcyqGSxBy3d7fTOBgjDajwZOyG+s4k8tc2VE/1Rsj1C0HqPHRumnGlD8JDfop9gbWFzZv3JeYOa3VMeYSY3tHvGg6KUlkODSFgPk9OV6M1REeMajBLxylVHqOQnplYF++SnUI65xn4RrcHL6QB8jhn+SsPFHBEa+PZnIkrp+0WG7iite1Ay4fELDtx1qMQD7Fx7tnK1u8fNpL7bHWPHTMswTwGu4axghB8A7qYGE2jpzFrB1fmac5qLxY7zuc5jzKPppkmfRRjbMKVgPPbDi6OmO9BY7At+yZDxuzb4K+EyXfaJRUPXOW56aroKNF+KzUZw+P27pFTrn59NY88MJCtQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p9RkKOc0Ub/Mf1LqSEUUzwkkmG14rtimUDc0JG40mL+u7KLE5L0ySO4PjLHdkwNns55jJAE+Jv1fE/AWDGwbawF9yaXfMiETBo5vrC7u+PKwgp9xke0yl2UpmXrTPDBVWUzlg3nF5GQeD+fSM/VRQfgIAV4FtKM2mUpnqSIAivuwGenkFoUtP/r5Z8RqYhA9sHI9gk0wOCwaoTx3TsXrXi4unCUApbtXzAjTvu25T6D1sE5h/xn6e+zRbami85tWD3vkG1fG/4bjZGU9h4sQcEOuBB1UrggPTrPUfQmgQ2WAJNoGMclRJoEnBO2XvWRDRjhbXMgNA1H5+4sBoZgR6LbRVMRdg9Tqs4hrGKUKNmAJpiF1WTkdTzIAYE6vV5BXJzR9zLXcWjYjarQ6ZgDYjoofUy/1UOmPsSOhUeojRmhYcT6UtKr5a3eYT7dfYdeV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 02:51:51.6359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95a49c6-9c2f-4bad-8add-08dec11b106e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9509
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
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c       | 3 ++-
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h       | 2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index e5971c3dd7da..11490048a282 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -548,7 +548,8 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 			goto exit;
 		}
 
-		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n", save_count);
+		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n",
+				save_count * ras_core->ras_umc.retire_unit);
 	}
 
 exit:
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index 237525b46b9b..e9e34bbdbd30 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -143,6 +143,8 @@ struct ras_umc {
 	u32 pending_ecc_count;
 	/* number of entries dropped because pending_ecc_list was full */
 	u32 pending_ecc_dropped;
+	/* how many pages are retired */
+	u32 retire_unit;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index b809a2f21d73..0064e89ac1ab 100644
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

