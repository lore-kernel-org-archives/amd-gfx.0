Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2BACDE006
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B5FE10F1A0;
	Thu, 25 Jun 2026 08:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3wimDuyR";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012015.outbound.protection.outlook.com
 [40.107.200.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B1C210F1A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlsupwatMo4NW4j64UKuF39bdI6mrgBPxB942d/bl0LGDCId9wIlRqGlcscNytL8KIIDTXnMTLZNejAfXTSeArWY0SXmtw7cMVChQxUN/xS1/bQ19R/6lMmcBOvnd2Ihin2gw99KdvC4T/DmXYTkP5em+EaUfN4z/2xBUkoWtq9hDksa/Pt2wM0pN4upKcYWa1urRIPYyudZuB8s7tOsXGfHivoDkuWKeZzBTGezqUjvVhrax9r91bEmRW/bXRC6GO2fT2Ct1xyeMkfzK4olKJrq/ybWX7FjE9OGk3aM8s8yN2/7aiauBJZWtctG63loIrlrLl+9LQ91jmOyYVVXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm7jDeaQ2hh3hhYck+6ipLrH/VyL+r6zqT3HLDdc/dw=;
 b=R4GIXHBlZsUqZqhst4qo3G+PMnDvBhvOQNZ27iOWosdHiDgs1ib9+GTcWhomYD41944SfpE1r5hJ0pWjBFnT+hwlmpHhDsNdbu0QOEqVfgA14T8wEDkiYnmPMB+67MoQS1eXReIDQYgcJu1ZL54ADlgPSDRwy8zEjdfpnJMMRKujpsxqQqzv+FPHsXDEWV3miAguIRO+ZSJreW575nwTL095fjPby9ygPMMcCiKbdKfr+5Z9vdkFFYGuUVjnUe0cKCutBLCbWMElD+RYJrG56D9Jp+tV4Rr9EOy0OPUGg5a6187pUkNloBxv4k9W4bfug0hNolVm96bn1WnfbnKhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm7jDeaQ2hh3hhYck+6ipLrH/VyL+r6zqT3HLDdc/dw=;
 b=3wimDuyRGucWc24ovTtfKTqegEF+qlCQ5lap5sl2KScmVtjmtVQ/BseSh77DAU57Ghoel8EEmjg0KbALC1K/ZeWp7Y9J063wPydw5LDBJA7ATjESc3JPav3ELZW4muBJzGIuavSJQsPN05uYOwMEQz/1SNr2wmnEfXNciG+8bQ0=
Received: from CYXPR03CA0050.namprd03.prod.outlook.com (2603:10b6:930:d1::15)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:21:38 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::70) by CYXPR03CA0050.outlook.office365.com
 (2603:10b6:930:d1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:37 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:35 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 43/44] drm/amdgpu: retire legacy get_retire_flip_bits
 interface for UMC
Date: Thu, 25 Jun 2026 16:19:36 +0800
Message-ID: <46b8542d75b04d3b439bf0359de7d9d6253649b9.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: e7dac893-01a9-40b5-a95f-08ded292c6fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0YGQmbQ1wiOA7mW76HiNP0O1u1hnKwXhsQTXYTthDf+bMDmlpJ13ozKFA4PnXMwAwds+ddtMeuODZju8p3vfOZcy7DjvbH7uBvCRT9SUwDRdyk3jFGKkG4PWmfKHSX6TMAAdS9Z254HIaBdR32bpzXfhiT1QgQZPBifvJMfaNI44Y1gSDrNU06gnIHB4rD+XvWlMbJ+uRDY1xVncW56owaHJPBjT+0QzH5qpgT7IYkHopaMF6aCgOYmODQ/wXnI1GMjLNZaVKenjszMI7ZUmccjNsX81O4rddkp63Iq6ZWnT60EdHXZdGWbb1g8srF40iOFSeJrlB0zZdhiur1SXMRPbLZJU62nkfI4WwfJVnwCQPh1AK+Au8FBG99hGpdw46Z9FRAmXlul0EhsX3ixKd2TRevyUPEIFQfgiL/cFnTJ7ufJ2qFNVuQdjNloEC6WE+YOR0rjKsvg4W+twveyZzVCYBnBdrosMPUDQwD6/Wz629CGYAJnUhEtTb88v7zoofx7LDuTa5uW8VgIuzMwMe2lkDmQrlx1yk5Vmmctsf0W9dquaiotOevCOm7fLPYCkrXlkM5FnWUC+YYMDZj6NC8Q497pporg1/Rgp42UfXfLaqUVYbJTqpIOnHIDmjT08QURrJ1YlbRcvEXHXjcCc/5mGTqAh11ZFpLd9F/PeAh2M+3ED10iB6zeyHDGKDYdFNW7mP1WnDktmeeWoSFqIDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xC0e3nBOuv02ioxBfpr86bb7mHeqHnpY5Hy5fV6h08PtLgfgy5ilYdVxf16XQzlBY4yU5sBe1vyI0j6L3RJEAAizP7hrntMx3kLj3uKG1pX87JR5hklt1AIM29EvEXPiathQcNIkrxMHgtkV1qG3NoswAjp+BI+H2iHQAfRELkWHcku6inm8bLRicOMa/HaRHnKW+5ecLA3Geu/otkxjAhB1pBg3p0wlckmBmpPHsYu6uOO6RzlkRA6ztObL/vebD9TGdwQtgrL5hbmD7dCvhpHhJg0OyK4qH+hNbpq6OHf+CAL1mxwEt4scaXaqAfSEgqEfCjIw29ENip/Ah8iJNh2omJ3wUo2+RL/sDWHHo2xTlB7kHpFkvaSwoTzIK6DEVWrBktalCh5LgnbC/7OOovC1KRVcVKnu5PAv2UfW8xFOhgqBjfKvGNGalRwb/z/n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:37.7682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dac893-01a9-40b5-a95f-08ded292c6fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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

Remove the legacy general get_retire_flip_bits interface for UMC

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 15 ---------------
 2 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e9583e8f0863..90f746ee90f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3202,10 +3202,6 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 	ret = amdgpu_ras_eeprom_init(control);
 	control->is_eeprom_valid = !ret;
 
-	if (adev->umc.ras &&
-	    adev->umc.ras->get_retire_flip_bits)
-		adev->umc.ras->get_retire_flip_bits(adev);
-
 	if (control->ras_num_recs && control->is_eeprom_valid) {
 		ret = amdgpu_ras_load_bad_pages(adev);
 		if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 46c42997d314..b2a3db60d231 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -77,18 +77,6 @@
 #define UMC_NPS_SHIFT 40
 #define UMC_NPS_MASK 0xffULL
 
-/* three column bits and one row bit in MCA address flip
- * in bad page retirement
- */
-#define RETIRE_FLIP_BITS_NUM 4
-
-struct amdgpu_umc_flip_bits {
-	uint32_t flip_bits_in_pa[RETIRE_FLIP_BITS_NUM];
-	uint32_t flip_row_bit;
-	uint32_t r13_in_pa;
-	uint32_t bit_num;
-};
-
 typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst,
 			uint32_t umc_inst, uint32_t ch_inst, void *data);
 
@@ -100,7 +88,6 @@ struct amdgpu_umc_ras {
 				      void *ras_error_status);
 	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev,
 					void *ras_error_status);
-	void (*get_retire_flip_bits)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_umc_funcs {
@@ -132,8 +119,6 @@ struct amdgpu_umc {
 	/* active mask for umc node instance */
 	unsigned long active_mask;
 
-	struct amdgpu_umc_flip_bits flip_bits;
-
 	unsigned long err_addr_cnt;
 };
 
-- 
2.34.1

