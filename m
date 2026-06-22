Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC32CDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A65FF10E57B;
	Mon, 22 Jun 2026 08:46:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yYv41Zhz";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D82510E57B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWvpJwepN0/6ULbHjPxQ4zyidwf2gf2r4HaoIW8aBBj6d3GEFzPARIyNNOElmhqyosxm8Ra5HA4991vMqqZycBBxcxVI5V2M+UWY7X9ARRHMiCRjZgLj/r+NSSiFpL2XYGn3r9U/vdXI4PLP6i3mPY1vaRptLu4mH9ThR1Xf3iWgvytgNGk7hXqzZUGNDeYPtyuqJ/gct379Dn/3aK6RN8/K0SsPWh+o2ni8XcjmTo5ZXzmZPsaDdOq2mCbgRgnMIjfjISkM9KKfmSMwFxD4piN0empYDjBer0n7Mq0DJa8AbpkqdLjs5cQddjaHA+ke2K8KouDsCjBTSmf6nnswBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SuQwwe175OBIrVNQWK96vHd8cbyoyySSvhr6AVrdCc=;
 b=oyDq9iRR1V+CQCsJYGuY0ebsixe36V/3IhsN2nyCOzTrJ/JSgKKCKX272JYIqT72jpjaUu/Tyc10FHR1oX9Mxx4Sm6spJVWM75vQcaAOFau/X5q4FENUH1CQ0BKSb3XeQyVV1xioIsnxG6tccvwTq+VRZJ0/9ZWpbSQvnnslJjrYrx38aGfxhCnYlmdVgjJuA/ZSoQhX+HJJy/ncEbe16ktjY7xu4aIQzXfY1NA7sZN2LqrPXbDTqxpub1pC7ksWfoYAJYGkQ0dzBZOrr/ta9TijkESDUCyeqfm5g8W5i49PeJy3HcxPXKK4Yh5StfDKSgd0oF5JuV/KNQ6ai1f7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SuQwwe175OBIrVNQWK96vHd8cbyoyySSvhr6AVrdCc=;
 b=yYv41ZhzXj++9asKxUTsJmcUYbrWqo7aSElRRpSKX5C5b+08UkzoNfO62v9HMkLHHzJ8e2XHpIkaRLd6HUY/uLhnE/NdtgSBM455VpRw4F4a6XTs1XTWNqr61JoNQIyOYvDVaKx8mStxdXNo8rJk1M7lyL5UTgtIrNCL6kKL3ys=
Received: from DS7PR06CA0036.namprd06.prod.outlook.com (2603:10b6:8:54::14) by
 CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 08:46:24 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::9a) by DS7PR06CA0036.outlook.office365.com
 (2603:10b6:8:54::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 08:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:24 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:22 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 38/48] drm/amdgpu: retire legacy pmfw eeprom reset
Date: Mon, 22 Jun 2026 16:44:40 +0800
Message-ID: <045f848bda0e28c02c9d4e417f59bccda0fee5bb.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: da02b6df-a9ae-4505-5f93-08ded03abdc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mS6iUU3eDyMhRxZjp4sPbCw4fCOGPAZ/m4aIEbkJ6RNgFucU3eFkA68alm1b7AsMORWFQmSS5uBeFeRN8l7zsYFCykjK9aLByinScbFetuWalmCwHjlpLY8UWUFwI0Z9qK1IH1Qfpn4+HS7lj4sxZpCcBm16URmWCzPSiuvuJ4qdRf4ywQnN5Y/DyEFt51YquiX03sD2mw1FFcPokVyevKIiEEfgafvwslEcWs7McoBF2lE9CLijS4ZhUjGAI3zJTJylvU6wDpUkEyCTcxOc8Nz86lekmEUsBQO910+6SEIU+0GxIii0MGa8LHreMeGOhKHCt3nR8HlyymWxEiFCqUf7o6npawtgpQKhBFTjFAD5vsuCJBm+XA8kOO2WABGfv0CBeYUkve+MtdPHls3eGuFbAFdja7TlQd4SOjivpobLvHtOKe+pXlBi42KQ/mn0Bvy92TsKt2PVLuRciu9T0V6nPzNH/iCRTEujkBLfmFNqFcA2pO1XTFj2lYK/1+/TF83PYHOVGs+mWsfGavnQnTfJ1/urJpMdDXsImuVQCa/H/f643by362C6PKAXc+BIGRFGEDoA8YVM6dREe++t0nFGbj8xN+WIkTxRqKCg/KK4uaPj/7BGtJCLZRbfv4yZgFXev4VUeRno8ReNYKZ6x2ivr3tFJFpObzmPXlWSFU6kjzq7Ag+iiO0YDiIL5z2pLbaFYB7ToHiTmIVxMdsGHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cvlbdVSHQxCCSuyNy1Y1Wn0Hi+WotoBaompzsTYBFR3CCjxGZg5t/KpUcgobZeliZ3JgK+kvdDAbD+6MoTJtBj4TlZaSvo0Rg2BCt4IbEP67pJJCS+xwh+O06o9zaKwnZ/EevGkgb/206kMwL6BcqmaAVYHjoGcBfJDjsUu4mgUvw6qhuRh8QVBmEX2lNzfJSqtvTyv6m4C3LgURpe3a3QewycNwBC0iIgdeGVkVKAasJooJ1dhCCu9kWNFimIZTuwd2qvbOI2gW3MzGEthDu4AXp1BqbZ8GZydr2s+s+zlZkkik1nPj6zNdbTkqnWAniZzo06eDnxL6to/hYCR834XPA3EqzwcctZkupKnkjmGCBY+LZHGYALvpibuh7Zya2CSMXb/eQVaoBxm/KGCG+SqDHaBh7IAUfsydkhEaa/DoCC9mCaScT4xNRnEB6p4Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:24.3472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da02b6df-a9ae-4505-5f93-08ded03abdc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209
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

Remove the legacy pmfw eeprom reset adaptation function,
as the feature is deprecated and unused

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 71 ++++++++-----------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 09aa5655e3c1..baa8cc3646d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -450,57 +450,46 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	struct amdgpu_ras_eeprom_table_ras_info *rai = &control->tbl_rai;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	u32 erase_res = 0;
 	u8 csum;
 	int res;
 
 	mutex_lock(&control->ras_tbl_mutex);
 
-	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
-		hdr->header = RAS_TABLE_HDR_VAL;
-		amdgpu_ras_set_eeprom_table_version(control);
-
-		if (hdr->version >= RAS_TABLE_VER_V2_1) {
-			hdr->first_rec_offset = RAS_RECORD_START_V2_1;
-			hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
-					RAS_TABLE_V2_1_INFO_SIZE;
-			rai->rma_status = GPU_HEALTH_USABLE;
-
-			control->ras_record_offset = RAS_RECORD_START_V2_1;
-			control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
-			/**
-			 * GPU health represented as a percentage.
-			 * 0 means worst health, 100 means fully health.
-			 */
-			rai->health_percent = 100;
-			/* ecc_page_threshold = 0 means disable bad page retirement */
-			rai->ecc_page_threshold = con->bad_page_cnt_threshold;
-		} else {
-			hdr->first_rec_offset = RAS_RECORD_START;
-			hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+	hdr->header = RAS_TABLE_HDR_VAL;
+	amdgpu_ras_set_eeprom_table_version(control);
 
-			control->ras_record_offset = RAS_RECORD_START;
-			control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
-		}
+	if (hdr->version >= RAS_TABLE_VER_V2_1) {
+		hdr->first_rec_offset = RAS_RECORD_START_V2_1;
+		hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
+				RAS_TABLE_V2_1_INFO_SIZE;
+		rai->rma_status = GPU_HEALTH_USABLE;
 
-		csum = __calc_hdr_byte_sum(control);
-		if (hdr->version >= RAS_TABLE_VER_V2_1)
-			csum += __calc_ras_info_byte_sum(control);
-		csum = -csum;
-		hdr->checksum = csum;
-		res = __write_table_header(control);
-		if (!res && hdr->version > RAS_TABLE_VER_V1)
-			res = __write_table_ras_info(control);
+		control->ras_record_offset = RAS_RECORD_START_V2_1;
+		control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
+		/**
+		 * GPU health represented as a percentage.
+		 * 0 means worst health, 100 means fully health.
+		 */
+		rai->health_percent = 100;
+		/* ecc_page_threshold = 0 means disable bad page retirement */
+		rai->ecc_page_threshold = con->bad_page_cnt_threshold;
 	} else {
-		res = amdgpu_ras_smu_erase_ras_table(adev, &erase_res);
-		if (res || erase_res) {
-			dev_warn(adev->dev, "RAS EEPROM reset failed, res:%d result:%d",
-										res, erase_res);
-			if (!res)
-				res = -EIO;
-		}
+		hdr->first_rec_offset = RAS_RECORD_START;
+		hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+
+		control->ras_record_offset = RAS_RECORD_START;
+		control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
 	}
 
+	csum = __calc_hdr_byte_sum(control);
+	if (hdr->version >= RAS_TABLE_VER_V2_1)
+		csum += __calc_ras_info_byte_sum(control);
+	csum = -csum;
+	hdr->checksum = csum;
+	res = __write_table_header(control);
+	if (!res && hdr->version > RAS_TABLE_VER_V1)
+		res = __write_table_ras_info(control);
+
 	control->ras_num_recs = 0;
 	control->ras_num_bad_pages = 0;
 	control->ras_num_mca_recs = 0;
-- 
2.34.1

