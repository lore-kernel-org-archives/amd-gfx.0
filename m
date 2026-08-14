Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498D3C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6BF710F72F;
	Fri, 14 Aug 2026 21:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JKtTWRmC";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D3710F72F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ko4lrH+TsAithetI5h/4ksWKzl1BosJYCvopGGYTdUbKh5sc8yyZDQb3c9Dw9niq2QB2uh8IAInNg3gtKWpx9fXIgsi+KD/sK1xO8T/ZxQZrxm0vgJlh7BnBoT3bfLtRLAJG/GudPKwRyRf0L5p4cPCrpx9jgCNt0CGaH258ryogWZMDHogF8pGgDOV1LAO/2kjNqSOodKU5tzus9iCMbQPGuY8dMav0BQ6mPyxukxEzfHAj+i5/l03sgYHXGFamI+iosfmkZkgYhRTciakDPZthB9ipaajBQ3UPbZtaWdW5s36cYpiBV55eD80SFqxdxfwee+xjmVLDf8biBwfe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvU5dQunHi83kpJQaY08cDqx2VbzapSCKqGOBftIAb4=;
 b=IHsdYE+3l2NpRib8jfrOf9+7R6uXKMtNgSv4Q1g4uhNChGYj2IdroD6xKVW4PR6i3byNYYkDqU0e9DLyvxBELDf6su5iMMrYY+gFlL6n7XtNRajXg9RemYrMCGFSZ2YkMYqqY/BbXXX4Qnw6Yx9JvBH47Zvb2GALAxH6ZB19x/s/3rP9Xu/hDTnDELtZQGd4tjUWTzEGgXrjSIdqNucLN9kkLuj2VvNp0YUhnU0Lx12cp1d3g2R50kjoMOE0A8qrg2ar5ohT1djGSflOfvA1kbtzVox/79kfCO8Ur95XWCYhxJPu2qNJE34+qjDxX4xnRW1peW6qfAwvAAoz7ieBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvU5dQunHi83kpJQaY08cDqx2VbzapSCKqGOBftIAb4=;
 b=JKtTWRmCbPZyNPgLIUCClPXOz4gox6t3iPXXpnYGziVdwa/2gMHGCZC77q+KqtuJrVwofIe9+xwSdwREAC1JPHC3Yck3TWXvdo6x2YOEtyJdx1IDuzXDRHEUwx6pZSU+9BU8o1KJyyZ8yIpPNSsv0Hn4/+2rDf3RLyXqX2htyno=
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:51 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::1a) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:46 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 080/109] drm/amd/ras: limit eeprom ras table validation to
 init and post-write
Date: Fri, 14 Aug 2026 17:02:17 -0400
Message-ID: <20260814210246.3067612-81-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9b2408-b9e9-43a3-43bb-08defa478aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Cs2QRSlYP62H3s8++qQZ3dL9JDeUtWCbL9C8JDfz04Wmbxz9VfSHXCHSUklBqn409TXET8xgoUza0Yt3wS1+Pl052mHcvZBCsSTywt+GD8ypYF4FqeEXuIfq0IhbVW9snNcM7YtXDNPMqXEAOU4DCSZG2cHFj1Mtkln4pnknttljtQiQ4WVXsNbur/ciWvhoMFwKmiM9IpEhOQAZlE9twQs2J+ZJKCfgrmEvgFJO6tmslWAXHJ9pQy61nXsXnwLWYymRLubMc9uoSFSP3tfTDzAkf4Ei1Gdr6EOvASgJlCS7Ae4wVVLJ9f2THagJtm/jABsN6ccGJhLjz0HAQ1pHcD9CsRiHfpRx6bdTZ51rHOeMfDvlo+xHjfbnv/th7e92aSBMJqju384gGxGO6+DM1qOn+2egHMzwxiRZ82d2Pi5JQwJts5qJyB2vtX5odV0IHrIZW9L0HH+F/bbxGVSlUxR1+KFmmY6MeKnr19YydQdaps9ITraQ0TiRT5cJfUqPcrM66TGbWIPhROma+kyqffmZH4/jILRR5j6bFKolN2Oj2g7GO1uvoq3tL5P0NFJTYNX9L1RZvhtZ0rRBakPEe5H/RIk3uFRTO5oVr9WlFOPGk9ytJHIeI4fwHK1IfLW8WjRg/j3NdWII+PUKx5Hzcfcnuefj2P59YqoDhDb/z7/FGHAlOmwB9FBB5/mHAoRqQvRXKg3F82NSd+JOCdlLxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bDq5zO92vfdU39O60i9QaWGhallnUPpm6rUd/SfPxOLMxsQMIXchSuP+8I4HNodjIxfYDCL6WpadMw/yPcYXjVHmnn5uACZjX9GEUZLes540Q5C6mj3H2bI4XMC4E6W28FsHtH2c43JFCgkeoa4x797tNHnuGv0XxlOCfAHRDsj1JsTOMH8J94YeLIj3B9VPnHRe40HlLkDsQIlu/bAB22jb8xfcvwh4Ncj1vRwFyDG33uaSbjBBdvOP0pJB+ZOlj924N82WRKPQchgMYKe7svA08Rko6w70GjRQEK75XNq03tnHEIdAxrvr1dCLp7zZNS8MaEas8B0v7Uwt/TSIjXcu/KWnBKlx5AJ6udAhJif6vUpSEUr+WQ4dYFM0vZGmuN7xx5b1j2pqzgx2bNS2i1NIBUqDUhIJSnyjqgsGmElElMxVRaXKaC841HZZCzdA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:50.9023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9b2408-b9e9-43a3-43bb-08defa478aad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

The eeprom ras table can be quite large, and each read requires multiple
smu i2c transactions (max 24 bytes per transfer). Limit the validation
to avoid excessive i2c traffic and CPU busy-wait overhead.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/eeprom.c | 31 +++++++++++++++++++++++----
 drivers/gpu/drm/amd/ras/core/eeprom.h |  2 ++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/ras/core/eeprom.c
index 61cc0538f4622..e7aad113b98a5 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
@@ -153,6 +153,8 @@
 
 #define to_ras_core_context(x) (container_of(x, struct ras_core_context, eeprom_mgr))
 
+static int __check_ras_table(struct ras_core_context *ras_core,
+			struct ras_eeprom_control *control);
 
 static bool __get_eeprom_i2c_addr(struct ras_core_context *ras_core,
 				  struct ras_eeprom_control *control)
@@ -801,6 +803,9 @@ static int ras_eeprom_append(struct ras_core_context *ras_core,
 
 	mutex_unlock(&control->ras_tbl_mutex);
 
+	if (!res)
+		res = __check_ras_table(ras_core, control);
+
 	return res;
 }
 
@@ -1123,6 +1128,7 @@ static int ras_eeprom_hw_init(struct ras_core_context *ras_core,
 		struct ras_eeprom_param *param)
 {
 	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
+	int ret;
 
 	if (!control)
 		return -EINVAL;
@@ -1133,7 +1139,15 @@ static int ras_eeprom_hw_init(struct ras_core_context *ras_core,
 	control->i2c_port = param->eeprom_i2c_port;
 	control->i2c_address = param->eeprom_i2c_addr;
 
-	return __ras_table_init(ras_core);
+	ret = __ras_table_init(ras_core);
+	if (ret)
+		return ret;
+
+	ret = __check_ras_table(ras_core, control);
+	if (ret)
+		RAS_DEV_WARN(ras_core->dev, "Invalid eeprom ras table! ret: %d\n", ret);
+
+	return 0;
 }
 
 static int ras_eeprom_hw_fini(struct ras_core_context *ras_core)
@@ -1167,10 +1181,19 @@ static int __check_ras_table(struct ras_core_context *ras_core,
 
 	mutex_lock(&control->ras_tbl_mutex);
 	res = __verify_ras_table_checksum(control);
+	/* Update RAS table status only after an actual table
+	 * validation has been performed.
+	 */
+	if (res >= 0)
+		control->ras_tbl_status_ok = res ? false : true;
 	mutex_unlock(&control->ras_tbl_mutex);
-	if (res)
+	if (res) {
 		RAS_DEV_ERR(ras_core->dev,
-			"RAS table checksum is incorrect! ret: %d\n", res);
+			"RAS table validation failed! ret: %d\n", res);
+
+		if (res > 0)
+			res = -EFAULT;
+	}
 
 	return res;
 }
@@ -1185,7 +1208,7 @@ static void __get_eeprom_status(struct ras_core_context *ras_core,
 		return;
 
 	hdr = &control->tbl_hdr;
-	if (!fast_mode && __check_ras_table(ras_core, control))
+	if (!control->ras_tbl_status_ok)
 		*status = RAS_EEPROM_FAULT;
 	else if (hdr->header == RAS_TABLE_HDR_VAL)
 		*status = RAS_EEPROM_OK;
diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.h b/drivers/gpu/drm/amd/ras/core/eeprom.h
index bf721c2a11f1e..1482450c2781f 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.h
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.h
@@ -134,6 +134,8 @@ struct ras_eeprom_control {
 	/* Record channel info which occurred bad pages
 	 */
 	u32 bad_channel_bitmap;
+
+	bool ras_tbl_status_ok;
 };
 
 /*
-- 
2.55.0

