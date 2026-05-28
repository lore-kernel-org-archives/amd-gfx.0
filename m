Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E529CD5BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 04:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2983810EBDE;
	Thu, 28 May 2026 04:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nm+GHpyN";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08AEF10EBDF
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 04:34:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoU3HALcj97nq2O6zTqL5LLtxkQW+f8JnjOm990qe8xpOqFPCWL54mGaodPvVqjTPSGOExTjHYiC20SWLBlrI6Hkb7LS14rJ22jmkIFOpJcoY85BnXBNqZUe9Q1dRPgjc8zJGzwAebpp82Qlp9GySqRFYwjQ3ertpIWMzUHcyBHNM8RinJD6BTCH8CvFQ/FUJ6GfWVmVzOt01mFTGlsufyi6BY/LRE8Vuaf/0y/8b3cTOOGrzOdSoJX5FE8S8c2SidQciMFAZ/6XnsVe4Fw2XHOgCkI1fUehapGzEFparO4gNbRtsvN/6m69D50v1m2jOF4mvbY3Uohh3fGj5Hi+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ob4ATQmkXdPmAX/kXzhXae0Dnu7Gjykhr8IzYSwwO5w=;
 b=xqr+RvPxMu5yACa02GuVlmHp4kjmysqLyAZ43ehYiQPc8S4jcRmWbpJ/OG3OdsPDXT2tT1fusfmEMJq7ReIr2xJ+TjjCJLAsSoPwWCfE2h9uiNzLzXS7b8RPubcxnmH8MN9B6hiZtXjgnE5hOCDK8vlHPTKSrKWzXXV1FoTnU2XsW7mUGUgLHlCrHjRxw5uc5lm2o9LZgJyomMrA08X76t8RMrJmxd/ddP3HcF8MmCyG2y5BxqD9WqT0u6hHZvLg8X3JUcNVnDMoM0qKWGGF4PxP8vKGCBp/ZjCEm2hiEn6jIK7CFyax8fAyxJPoYq5dkrBDTOIGm87rdxevQBMluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ob4ATQmkXdPmAX/kXzhXae0Dnu7Gjykhr8IzYSwwO5w=;
 b=nm+GHpyNBO+ug7Ye1+d5/1lbgaaM7XPd0/Th5VKRHrclEoBaW87phmpTZSity3J0NHQekYqVAZXuJ0bgZQuCTbYE72owm/J5ZPYjXN2PIoWgtGAeMMjkPkiVlWo7BrwSgkNPosqIeLsWScsSKwzKoSi+bfhB0cJZ93ckyBV/CNs=
Received: from SJ0PR03CA0199.namprd03.prod.outlook.com (2603:10b6:a03:2ef::24)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 04:34:39 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::1c) by SJ0PR03CA0199.outlook.office365.com
 (2603:10b6:a03:2ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 04:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 04:34:38 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 23:34:36 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Stanley Yang <stanley.yang@amd.com>, Thomas Chai <yipeng.chai@amd.com>,
 Candice Li <candice.li@amd.com>
Subject: [PATCH 3/8] drm/amd/ras: validate RAS EEPROM tbl_size before record
 count
Date: Thu, 28 May 2026 12:34:03 +0800
Message-ID: <20260528043408.237209-3-candice.li@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8944fb-051c-4b16-d16a-08debc726dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: M4fmOcSwQEJI0RPtZ4P0Ar6M44QgP1YhNzj9soPqtedpXkh8gkoDcNMsu9a0vCYVniikWsNIJ4jw3BgpFlUeegujAcI/smZQeECJl5l0AB2lpdHWjUmVp9b3JxtIRfLiobsI6pGhXTcB4tEARwEBtXKobLn4HY8JhJKLogpPrIrMjfq4dh5eoh86cGGblSktaEaeOLMkdmX3+r1dDnu+OSw1qk6CXAsfHHKZVZwG9wF8ZEe3M8aY/8A5Ch/q11tjBueVc/awWpbga13FsPqsWLVbcD80tqxlNMyIlhyiP16BlB5Dr/NE6XYSbjCjuHnoem5VzKXzHM93Fz+NHg6hOdRKKICu2szgrofEi1ysTrk5cl9nP13gWkKH31rChDXCoYcTY3I/HlAn+n6UI5tD8lu1HEiFM7A2Q+/zauE9Uo3jmXdc+LCdXn7ZyHZsIhmOxkbJb7W2HtHzEoS5zo9z1Hg7QzU0Llwi3Aq0tKKbQt//StIrEZmLK5PY0uV7Zya8oH6NfM4KzY8oqQCRD1HA4ij3In98sahdAF66JbY4q4SDuaOPGVTzztb7Vnd5jhD+oY9+OmPOugu6L4sar+xHjrTPOsRwiGfMsw4GrEhTKjYoeeKNDCN/v+qZx2C4y2UaOa7PJOAyPIpdR9eRuuBzO3TJYEgmVWr+qqdUv5HKcOYQ1pE2fpfsrBNG+HaTbFgllTjLVYtKCQ4DVaaQLtdZlMUl0NSo5c0dkH3FrCo3mXY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OKWymJIHG3aLfqc0+gMszukE/9My9YfahxR5vv0YVLE+DkVvkViVKphaW5NY38u5y96ZJBiO9LR+uk7QY+qW0UpOu+Sj8UH1Ur7lMS0MsgETG4zQGsyDpX6bI5MKPoNoNHTmEv0Pb+TIk72LKYF5b4L1MnoTdz9S8q30YNWUNlRhyR/iyeJ0Nc267WPJr1pdOxukJ+DmPux4frLxzW0bcEL5DVT5sMAMk1XLokBWh+mT5xbIkHpHkRXGgSdCM8cwy+ezIC0nwwXDt5902u3cY9U5wOw2U11FJ5F0+lkaE/P3gqF7xyZIbOtkikapOIDzTB8QAHr2yHeGT2q3WMp3BGKWN3ci1TUrVjtIwHDSmiRDVQC6b5b1qXH+dX1R/Q5z871QtiRmidnL2bddpRbFHm7cPgUrzQrZcQscIVPm7YFTdTf5S769ZRaGcdhP342T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 04:34:38.4634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8944fb-051c-4b16-d16a-08debc726dae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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

Corrupt EEPROM data can set tbl_size below the table header size.
Guard the RAS_NUM_RECS macros against undersized tbl_size and reset
the table during init when tbl_size is below the minimum for the table
version instead of trusting the header.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c | 30 +++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
index 34b798f45af210..9fecec22560995 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
@@ -141,12 +141,15 @@
 #define RAS_RI_TO_AI(_C, _I) (((_I) + (_C)->ras_fri) % \
 			      (_C)->ras_max_record_count)
 
-#define RAS_NUM_RECS(_tbl_hdr)  (((_tbl_hdr)->tbl_size - \
-				  RAS_TABLE_HEADER_SIZE) / RAS_TABLE_RECORD_SIZE)
+#define RAS_NUM_RECS(_tbl_hdr)						\
+	(((_tbl_hdr)->tbl_size < RAS_TABLE_HEADER_SIZE) ? 0u :		\
+	 (((_tbl_hdr)->tbl_size - RAS_TABLE_HEADER_SIZE) / RAS_TABLE_RECORD_SIZE))
 
-#define RAS_NUM_RECS_V2_1(_tbl_hdr)  (((_tbl_hdr)->tbl_size - \
-				       RAS_TABLE_HEADER_SIZE - \
-				       RAS_TABLE_V2_1_INFO_SIZE) / RAS_TABLE_RECORD_SIZE)
+#define RAS_NUM_RECS_V2_1(_tbl_hdr)					\
+	(((_tbl_hdr)->tbl_size < RAS_TABLE_HEADER_SIZE +			\
+	  RAS_TABLE_V2_1_INFO_SIZE) ? 0u :				\
+	 (((_tbl_hdr)->tbl_size - RAS_TABLE_HEADER_SIZE -		\
+	   RAS_TABLE_V2_1_INFO_SIZE) / RAS_TABLE_RECORD_SIZE))
 
 #define to_ras_core_context(x) (container_of(x, struct ras_core_context, ras_eeprom))
 
@@ -1139,14 +1142,27 @@ static int __check_ras_table_status(struct ras_core_context *ras_core)
 	switch (hdr->version) {
 	case RAS_TABLE_VER_V2_1:
 	case RAS_TABLE_VER_V3:
-		control->ras_num_recs = RAS_NUM_RECS_V2_1(hdr);
+		if (hdr->tbl_size < RAS_TABLE_HEADER_SIZE + RAS_TABLE_V2_1_INFO_SIZE) {
+			RAS_DEV_ERR(ras_core->dev,
+				"RAS header invalid, tbl_size %u smaller than minimum %u, resetting table\n",
+				hdr->tbl_size,
+				RAS_TABLE_HEADER_SIZE + RAS_TABLE_V2_1_INFO_SIZE);
+			return ras_eeprom_reset_table(ras_core);
+		}
 		control->ras_record_offset = RAS_RECORD_START_V2_1;
 		control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
+		control->ras_num_recs = RAS_NUM_RECS_V2_1(hdr);
 		break;
 	case RAS_TABLE_VER_V1:
-		control->ras_num_recs = RAS_NUM_RECS(hdr);
+		if (hdr->tbl_size < RAS_TABLE_HEADER_SIZE) {
+			RAS_DEV_ERR(ras_core->dev,
+				"RAS header invalid, tbl_size %u smaller than minimum %u, resetting table\n",
+				hdr->tbl_size, RAS_TABLE_HEADER_SIZE);
+			return ras_eeprom_reset_table(ras_core);
+		}
 		control->ras_record_offset = RAS_RECORD_START;
 		control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
+		control->ras_num_recs = RAS_NUM_RECS(hdr);
 		break;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
-- 
2.25.1

