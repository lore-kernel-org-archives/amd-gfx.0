Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65FECCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 07:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA4010E709;
	Wed, 29 Oct 2025 07:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YdnM0UNK";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012053.outbound.protection.outlook.com
 [40.93.195.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEDB710E70E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 07:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDs80skH7ASmb3Z24gjozqRGEytylVgKUECP6hJhXVCmYPTDx+mCuCE6MDd7FrhsYAqMEdda4qXS2V1slZCY63etinOJGbkOd3+xWGLWboU5GENf5bH6xQ8esDmlWThPaF8Soqa781LoPsHQWGSUkYAy6lnzQ5QAQZ1LezhXNtR7h5zGsUWcMd8RfpRaNRPRNhAnUORmJHVLNg2jmWiKvO5CvrdUopnkYb3Sxs9g0GmMD8LcswdzZd63KhXwm/MA6FWIwUj9r/P5t6pUC+nunHX9/2Htz5GrWwOkRZ4EJT104HiDUTTgaWvnyae6NwdIpeLeXZTggiW18wmwtzzNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrGZuMEC1oRjPeIcONvZu9l9XlyOz13+YVRoyEczK2M=;
 b=HwkluG2pmEVh2xnYWbP4PpJ9UtoqsXjzGLnDzQ+OBDd2/n0G2TBGkSwQjy8nvBELyoEXsWbzVnMbhDgcSwBtBFeVKcv09W45tLSRyeScGQhtH2kMkn90c9Uj4t09y/S8iyH6T4MpYDlVGMlZm1cLdwwOVz7LlItMrzFf2VVK+hBP//R6aEPywa1rPYvTe6QYEajByasyacolkZXa68SVyVe3OzeIto4m1eISRrFN/JFtNaOgx70jJFpxoMYwQjHLljotp94MTdJK17KWQWByVNQOnHJp2gkOCeo8bCJu/wqWlqeKV+rnPehDp+RjqHskvnQSYxrktvrVAHRvtHG/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrGZuMEC1oRjPeIcONvZu9l9XlyOz13+YVRoyEczK2M=;
 b=YdnM0UNK3Z37gXIckKKn3rFz/8kv8G2ng3jHOLRAc3Vja6G5WIlm/EECXaKAMiBbHdMs7tzC8yvrOTP+ZNiSLAwB4fyCsGxjRGroxAikqKX2fzRw4RY3KJPQnoFZuw/PxBN23Irw7cfFNYc/9TKnmnJ1jX4qedV76s5rrDLqeDE=
Received: from DM6PR06CA0090.namprd06.prod.outlook.com (2603:10b6:5:336::23)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 07:32:10 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:5:336:cafe::fa) by DM6PR06CA0090.outlook.office365.com
 (2603:10b6:5:336::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 07:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 07:32:09 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 00:32:06 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 07/10] drm/amdgpu: adapt reset function for pmfw eeprom
Date: Wed, 29 Oct 2025 15:31:05 +0800
Message-ID: <20251029073108.1698129-7-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029073108.1698129-1-ganglxie@amd.com>
References: <20251029073108.1698129-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: dd349808-27e2-4cc1-ffa2-08de16bd4534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6bScQpsdkXfe90EJdSY/NctKQ3SpW7S4EHNMXYidg2APzjc4BIfpgUZL4G+9?=
 =?us-ascii?Q?bJ/P9cNtZFJ8qQQ3DUZOQO1sSis86sIXoJPoL9cU8IQ7VugJCjEaA/U/fmJS?=
 =?us-ascii?Q?CipHM4wwzdk7jCsZmA4p4Hd4EilpDJ5tlLDcE/UtqdRnQoC0gqbcsYzgLa90?=
 =?us-ascii?Q?SIUkK0uMPqDO73hxOjvPD0ilLtlc+ZB0iFBkLD1I4wEQf6ka/Ijv4VqXbZml?=
 =?us-ascii?Q?/9+KJSotbKBQ+25VAvMp/V3qVZ7XfbNuZlwiT2ok9IgzQVPPU/Yco1xW4JJA?=
 =?us-ascii?Q?w9S15B7X/vXxDQrayU3nRX2n5YOi5ApW7qLMsfVl0tptzX1JSi/Fr+vtC727?=
 =?us-ascii?Q?1dWSDcc5ItRELuIQWBP7xcRwL/HUQ7zuaPRPGnFN/AtD41Z9eYHxfVZ9Ytk+?=
 =?us-ascii?Q?1//YKgOuHX9r6YBpWRAFKM0Nj5/xsByzptOodg/LDcI+P5oh4NoqdAft0MRw?=
 =?us-ascii?Q?1Kw2ooJNLzQgMNuK8JYgUeRUgVDSRahyQE2Bv3xSspsny2v4kNVL/5w/pAc5?=
 =?us-ascii?Q?igb6P+1WpTMqDtVvX5vnqdjfFlWygg5vBLLbHTk66I+dp/Fk4jfDsCZs2e4q?=
 =?us-ascii?Q?d6p5/y9oIMeCWeqzwOZp6IfPR7Q17uoAwjxOkfhYLt+sV1XW6X4KqZ4MXN2T?=
 =?us-ascii?Q?OI5bX0dX52fNYa+wn1VxkRe52qsROq8K6FNMobpxB4FLZWFh3VDCNtv7M7cj?=
 =?us-ascii?Q?QGW1rrdps0gTLjpHE1laq48w0eZYMf/3IvbuujYFZEsapwfcMXO3fNzFlZ5k?=
 =?us-ascii?Q?FFVUywP+s83nWoPm8lEr7a9oTdU1ZmIWnwDPa2cgSXJQM+mJ4qIecSIT1uB+?=
 =?us-ascii?Q?7wD/ne8N8kU04kvnslZed1hiPJ4UIwI1h04N416k0PDyvIO6Jm4EgklqbCNq?=
 =?us-ascii?Q?rsOLS/Ar9l458gL79Oh5OwME3SIAVkeWhpiOUQepT2kjucKucoWpnIMGL9W6?=
 =?us-ascii?Q?qvHO16NVFnIB5OsDNHFbwIMZWj3NtEFpFYFPLvs6NXBFm+Ub5bI/guMHoL78?=
 =?us-ascii?Q?b7yfCR7G3yZ7X0mnDJAuKZO2wHk4CTykpAKRd4qL7bsUNN1bJNPehMDsf6xs?=
 =?us-ascii?Q?fAbT6H4qgHo8z2U2bgz2nm6/l4MQh/KU440NRzHSrXmBzpB9e506jRxAbmF4?=
 =?us-ascii?Q?ufdMdcHYQLfRMsluHxY9u3vp9CcefJkqLPv+EaoTSOub0Ni6fDkUNJoubhCM?=
 =?us-ascii?Q?T3PYlGCVCQd4igjhEmFAxSDI6zxmjZLRqITH6IOplHs8pK97wNUA1rwjeSf2?=
 =?us-ascii?Q?I1XvBgSyL7zfhhP2nm0qNNIppYp5pxlVktGTxpCIgNHnlwIaM/lHH5gqQt0w?=
 =?us-ascii?Q?lHXP7RzHKCB1xBX7pt3eFhvTw8SL0U/VOFI8apL7+hqfFyxG0QbHe6gsMmjA?=
 =?us-ascii?Q?jED7coV7VjWX7E/aSZEJSPGfpoQWrWAns5MC2aePA8kVcyj7cIKv7PZCu8/A?=
 =?us-ascii?Q?Iq2J/Bvwsm5RZDDrrL2dwCQesVaEoIMDeqYRFAtdJsUx79KVFtdDcsaRbw3o?=
 =?us-ascii?Q?a2ww3uE9MUyhsmNAeZkwpLGeixQ625LNfy0i3eRbWTH6e4/uN3+R7mYYZw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:32:09.8393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd349808-27e2-4cc1-ffa2-08de16bd4534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315
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

adapt reset function for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 61 +++++++++++--------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 8533f1b6ebe5..7ee1a758a051 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -444,40 +444,51 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	struct amdgpu_ras_eeprom_table_ras_info *rai = &control->tbl_rai;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	u32 erase_res = 0;
 	u8 csum;
 	int res;
 
 	mutex_lock(&control->ras_tbl_mutex);
 
-	hdr->header = RAS_TABLE_HDR_VAL;
-	amdgpu_ras_set_eeprom_table_version(control);
+	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
+		hdr->header = RAS_TABLE_HDR_VAL;
+		amdgpu_ras_set_eeprom_table_version(control);
 
-	if (hdr->version >= RAS_TABLE_VER_V2_1) {
-		hdr->first_rec_offset = RAS_RECORD_START_V2_1;
-		hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
-				RAS_TABLE_V2_1_INFO_SIZE;
-		rai->rma_status = GPU_HEALTH_USABLE;
-		/**
-		 * GPU health represented as a percentage.
-		 * 0 means worst health, 100 means fully health.
-		 */
-		rai->health_percent = 100;
-		/* ecc_page_threshold = 0 means disable bad page retirement */
-		rai->ecc_page_threshold = con->bad_page_cnt_threshold;
+		if (hdr->version >= RAS_TABLE_VER_V2_1) {
+			hdr->first_rec_offset = RAS_RECORD_START_V2_1;
+			hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
+					RAS_TABLE_V2_1_INFO_SIZE;
+			rai->rma_status = GPU_HEALTH_USABLE;
+			/**
+			 * GPU health represented as a percentage.
+			 * 0 means worst health, 100 means fully health.
+			 */
+			rai->health_percent = 100;
+			/* ecc_page_threshold = 0 means disable bad page retirement */
+			rai->ecc_page_threshold = con->bad_page_cnt_threshold;
+		} else {
+			hdr->first_rec_offset = RAS_RECORD_START;
+			hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+		}
+
+		csum = __calc_hdr_byte_sum(control);
+		if (hdr->version >= RAS_TABLE_VER_V2_1)
+			csum += __calc_ras_info_byte_sum(control);
+		csum = -csum;
+		hdr->checksum = csum;
+		res = __write_table_header(control);
+		if (!res && hdr->version > RAS_TABLE_VER_V1)
+			res = __write_table_ras_info(control);
 	} else {
-		hdr->first_rec_offset = RAS_RECORD_START;
-		hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+		res = amdgpu_ras_smu_erase_ras_table(adev, &erase_res);
+		if (res || erase_res) {
+			dev_warn(adev->dev, "RAS EEPROM reset failed, res:%d result:%d",
+										res, erase_res);
+			if (!res)
+				res = -EIO;
+		}
 	}
 
-	csum = __calc_hdr_byte_sum(control);
-	if (hdr->version >= RAS_TABLE_VER_V2_1)
-		csum += __calc_ras_info_byte_sum(control);
-	csum = -csum;
-	hdr->checksum = csum;
-	res = __write_table_header(control);
-	if (!res && hdr->version > RAS_TABLE_VER_V1)
-		res = __write_table_ras_info(control);
-
 	control->ras_num_recs = 0;
 	control->ras_num_bad_pages = 0;
 	control->ras_num_mca_recs = 0;
-- 
2.34.1

