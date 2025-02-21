Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18200C021B2
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 03:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE2A710E1D1;
	Fri, 21 Feb 2025 03:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z1px82xk";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58F510E1D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 03:19:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4DxKrF9S5TwMnAAp06Oeft1H4EbrM0jJMxEL8xguXxBENsuLD++D0WZ5o6SoGLZ91e4ekYbjyc3kmVqgLeOjPejorDgJP4IM2seRUGBUw+3HTKYBxxX105HBNxSYqJo1bhYd7iAbuuNA349nd6DCtYDZHSj0IVed/wmzdTCMqYGPYwKv/O0OwMnKMOgaKlM5z3Y1A4JTn204ybHZeWgeQgLLbF9MCS1kd2u+TPWHvnhDUEVg+E+2viNjpo50X6XMOWBZGJIUEx4OnEoHcIKv5J3yZ3p6lIPJpI0/GRW9SmrXF16YfHXX+oaWwuFrQwjKRiH1nwpqynUS1Dx1RQJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0iuBhSkEeN48xZjJqscHYfpwu7FOSp4IvGlgUTfLHk=;
 b=Ya9jn3Ur7bBxuoCJMlC831nkt86E5Vat2PuvqFCXfJt+C87cmQvDTa9hqiKu+5Nl7O7V/JLBCpVPg4XviONZwBqtZiTwdOownvs2DILzjmoYmbShwd8V/LBERzjTJfGLfhrHI+1X6qVQtGFrU5jX1BgFG8Vk+8O1ahkvXVgDl5t6HWQla9/ce1Ef/A5wcUw1aNue6nDspIZQkA6MigVZbuJhfCn6pqUtOGcIxpEPo5EwgZql2abbmEritD2b0q0Wq5hE/W4fO0yFQYcS++Yj4DAU9i++7JOWGPbRwmHg9Ss7KM5W2Dun24Ddfcdb9t9UcWKzCZTgwtk+DwBFmtdS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0iuBhSkEeN48xZjJqscHYfpwu7FOSp4IvGlgUTfLHk=;
 b=Z1px82xknNI6PqX67F0fLaPu/eE96MkCSefXK1/1sApEadb02/1xoWMVnlQQErcQVU8bo6qHuYjG2g/gC4RfJAaoV+wS0g2xLG5gkGbNFjYPlbgDJQzjlj21ntyskC3rg1MmoXBtrVZY4fnkbD4eUB7hf3QXS7A6YCp25BeONRQ=
Received: from DS7PR03CA0157.namprd03.prod.outlook.com (2603:10b6:5:3b2::12)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 03:19:42 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::d0) by DS7PR03CA0157.outlook.office365.com
 (2603:10b6:5:3b2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 03:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 03:19:40 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Feb 2025 21:19:38 -0600
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Change page/record number calculation based
 on nps
Date: Fri, 21 Feb 2025 11:19:13 +0800
Message-ID: <20250221031913.1106015-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a88415-8a6f-4808-73b6-08dd52269486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/xRi9+kCCJh/eoMdbmTgEZZ7hO+C+0GhBP8KfA8OW9F+n6g8YiheL3PYDLJ5?=
 =?us-ascii?Q?CZmscRyj7lMImeJtAhv5T8jRFdonFSIFhkjxx7dGdjZhaG6WohRa53Ee2YgI?=
 =?us-ascii?Q?esrwhk1xLRArqMM0gxrgTcPfSlidRbh6V2TbHXVCcicTPAjngTCY0HEt0hhK?=
 =?us-ascii?Q?Pyl7WDOKav5WsQCiKUQAuP6zMlWzSHTTOr6dPGtIKxLAYiCy+qtmCPyHkNh/?=
 =?us-ascii?Q?HamFSQqco5kdI6UT8uTppAdYF2SUdVmOSrUz8xm2t/p47df1L1sd0i9lQr1s?=
 =?us-ascii?Q?4M3Uj/C0bXtlxq3E4gBq5hkqFYTEsiMgyxFR+F+pTB3csk3oEZHnyO0PzoBE?=
 =?us-ascii?Q?B0fsf5ndUyZIMoXS0X085VCnARrsIRYIc4vnGDFoMShdsYScnoBwcJ/A5n9O?=
 =?us-ascii?Q?WutjxuL/UVB8kQzrRoCzAr84t82JrdvAdABm5w0a/GJWoJEnBsvNSO8yblEn?=
 =?us-ascii?Q?/v9F8x/1cdcA+qg0aOcFQrF3/FrobPXEUy4n9oqz1Cc5An6cl0poDRGjmG4L?=
 =?us-ascii?Q?xLSUrMEcIGx6nBarxwDVv82dDfEeF+/Qtltpwgp/F93UAQ69Zk+nsQj70Llk?=
 =?us-ascii?Q?XKWe8qebJ/5Hj3ATVNpLintTQM+ySgR74QqYV3rIr15pWfQmWwd5nKZ+1Kle?=
 =?us-ascii?Q?/kruEK050HDJa2IMnpwmP66HSIkLKCjEOwvhPoTvn7ZjO60FuQi3ZEzfN+8u?=
 =?us-ascii?Q?ty6xh1D9g5InELgg77dlYFPBPe71Qwni/PaO8P28zDbyLEjN1p6u/xxIzo/g?=
 =?us-ascii?Q?JPdp72Wf30BmR2hsUEOterVF+KWT+RWXp3lEXY0XFgoah03mUXUbLzLNBnNZ?=
 =?us-ascii?Q?zuLL2emmv5/nUPUQ+xBszWlyJ+9OvJI0wDL+0FVcOw5vQG5ENLgXsJNbFEnU?=
 =?us-ascii?Q?BH5zvv+R/JNysi+Nu5bQbqy42pZdW2ArIQT4ZcGbywjkL0+jLMKTK44lrTNP?=
 =?us-ascii?Q?cU6Fv3m+KXupnBBDCm/QNnYx5fC1FAp+m0UISNGWok7pTmou68kkHFEz99/N?=
 =?us-ascii?Q?rl4fzYJEjTtNe2dw5B6KZOttBJ1XHKdaagB4W31hFkAgFPyEsGhjv92aHQbS?=
 =?us-ascii?Q?dUdLmToN7OPdiFfYVNqdR6b6j8P0WR0J3M8ullg1jf7LJ8JSoPrcKnLeWgsk?=
 =?us-ascii?Q?jEfz75iSRG6CMqrpL4FMk0RHMTUA+72113zSGCF2MtdZBlA7RBzjBNCw0wVi?=
 =?us-ascii?Q?K2Oy9B8zK19Joy+FMPZGneP/rbhsmPAoGGtHt2px2699h/6lzlVGo8TQqxRd?=
 =?us-ascii?Q?NjFoSET76xl9M+/ZvatGDFehCGc7u6NFWW+oULNrIsY/z9dGRBzb/fWq/laO?=
 =?us-ascii?Q?jdWpwG91qeA1lIQcl4YunvtY+4W67vrVzYQdCXG9r1P+BodpEQXG0aq2mBeS?=
 =?us-ascii?Q?XLX9eZ6Nyt7hUuETvcCi1/qzVqJ10B5w6tmKrF33oEtBgUm1BQTe2zlc2t16?=
 =?us-ascii?Q?Lgb3wLI9BvVwL9tDCvYKKSquewend0dV2mtf/fF5I21DrEryI3XCbVtIXkX/?=
 =?us-ascii?Q?KuZWAekJs+rj9sg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 03:19:40.8990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a88415-8a6f-4808-73b6-08dd52269486
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
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

save only one record to save eeprom space,and
bad_page_num = pa_rec_num + mca_rec_num*16

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 49 +++++++++----------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 17 +++----
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    | 20 +++-----
 3 files changed, 35 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 439841a2d1c2..c0e3d73bdc7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2985,24 +2985,14 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 
 	/* only new entries are saved */
 	if (save_count > 0) {
-		if (control->rec_type == AMDGPU_RAS_EEPROM_REC_PA) {
+		for (i = 0; i < unit_num; i++) {
 			if (amdgpu_ras_eeprom_append(control,
-						     &data->bps[control->ras_num_recs],
-						     save_count)) {
+					&data->bps[bad_page_num + i * adev->umc.retire_unit],
+					1)) {
 				dev_err(adev->dev, "Failed to save EEPROM table data!");
 				return -EIO;
 			}
-		} else {
-			for (i = 0; i < unit_num; i++) {
-				if (amdgpu_ras_eeprom_append(control,
-						&data->bps[bad_page_num + i * adev->umc.retire_unit],
-						1)) {
-					dev_err(adev->dev, "Failed to save EEPROM table data!");
-					return -EIO;
-				}
-			}
 		}
-
 		dev_info(adev->dev, "Saved %d pages to EEPROM table.\n", save_count);
 	}
 
@@ -3018,7 +3008,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 	struct amdgpu_ras_eeprom_control *control =
 		&adev->psp.ras_context.ras->eeprom_control;
 	struct eeprom_table_record *bps;
-	int ret;
+	int ret, i = 0;
 
 	/* no bad page record, skip eeprom access */
 	if (control->ras_num_recs == 0 || amdgpu_bad_page_threshold == 0)
@@ -3032,13 +3022,23 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 	if (ret) {
 		dev_err(adev->dev, "Failed to load EEPROM table records!");
 	} else {
-		if (control->ras_num_recs > 1 &&
-		    adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
-			if ((bps[0].address == bps[1].address) &&
-			    (bps[0].mem_channel == bps[1].mem_channel))
-				control->rec_type = AMDGPU_RAS_EEPROM_REC_PA;
-			else
-				control->rec_type = AMDGPU_RAS_EEPROM_REC_MCA;
+		if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
+			for (i = 0; i < control->ras_num_recs; i++) {
+				if ((control->ras_num_recs - i) >= adev->umc.retire_unit) {
+					if ((bps[i].address == bps[i + 1].address) &&
+						(bps[i].mem_channel == bps[i + 1].mem_channel)) {
+						control->ras_num_pa_recs += adev->umc.retire_unit;
+						i += (adev->umc.retire_unit - 1);
+					} else {
+						control->ras_num_mca_recs +=
+									(control->ras_num_recs - i);
+						break;
+					}
+				} else {
+					control->ras_num_mca_recs += (control->ras_num_recs - i);
+					break;
+				}
+			}
 		}
 
 		ret = amdgpu_ras_eeprom_check(control);
@@ -3452,12 +3452,7 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 		return ret;
 
 	if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr)
-		control->rec_type = AMDGPU_RAS_EEPROM_REC_PA;
-
-	/* default status is MCA storage */
-	if (control->ras_num_recs <= 1 &&
-	    adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
-		control->rec_type = AMDGPU_RAS_EEPROM_REC_MCA;
+		control->ras_num_pa_recs = control->ras_num_recs;
 
 	if (control->ras_num_recs) {
 		ret = amdgpu_ras_load_bad_pages(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 87fcdda3ec61..ab27cecb5519 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -727,11 +727,9 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom_control *control,
 				     - control->ras_fri)
 		% control->ras_max_record_count;
 
-	if (control->rec_type == AMDGPU_RAS_EEPROM_REC_PA)
-		control->ras_num_bad_pages = control->ras_num_recs;
-	else
-		control->ras_num_bad_pages =
-			control->ras_num_recs * adev->umc.retire_unit;
+	control->ras_num_mca_recs += num;
+	control->ras_num_bad_pages += num * adev->umc.retire_unit;
+
 Out:
 	kfree(buf);
 	return res;
@@ -1396,6 +1394,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	}
 	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
 
+	control->ras_num_mca_recs = 0;
+	control->ras_num_pa_recs = 0;
 	return 0;
 }
 
@@ -1416,11 +1416,8 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 	if (!__get_eeprom_i2c_addr(adev, control))
 		return -EINVAL;
 
-	if (control->rec_type == AMDGPU_RAS_EEPROM_REC_PA)
-		control->ras_num_bad_pages = control->ras_num_recs;
-	else
-		control->ras_num_bad_pages =
-			control->ras_num_recs * adev->umc.retire_unit;
+	control->ras_num_bad_pages = control->ras_num_pa_recs +
+			control->ras_num_mca_recs * adev->umc.retire_unit;
 
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 81d55cb7b397..13f7eda9a696 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -43,19 +43,6 @@ enum amdgpu_ras_eeprom_err_type {
 	AMDGPU_RAS_EEPROM_ERR_COUNT,
 };
 
-/*
- * one UMC MCA address could map to multiply physical address (PA),
- * such as 1:16, we use eeprom_table_record.address to store MCA
- * address and use eeprom_table_record.retired_page to save PA.
- *
- * AMDGPU_RAS_EEPROM_REC_PA: one record store one PA
- * AMDGPU_RAS_EEPROM_REC_MCA: one record store one MCA address
- */
-enum amdgpu_ras_eeprom_rec_type {
-	AMDGPU_RAS_EEPROM_REC_PA,
-	AMDGPU_RAS_EEPROM_REC_MCA,
-};
-
 struct amdgpu_ras_eeprom_table_header {
 	uint32_t header;
 	uint32_t version;
@@ -100,6 +87,12 @@ struct amdgpu_ras_eeprom_control {
 	 */
 	u32 ras_num_bad_pages;
 
+	/* Number of records store mca address */
+	u32 ras_num_mca_recs;
+
+	/* Number of records store physical address */
+	u32 ras_num_pa_recs;
+
 	/* First record index to read, 0-based.
 	 * Range is [0, num_recs-1]. This is
 	 * an absolute index, starting right after
@@ -120,7 +113,6 @@ struct amdgpu_ras_eeprom_control {
 	/* Record channel info which occurred bad pages
 	 */
 	u32 bad_channel_bitmap;
-	enum amdgpu_ras_eeprom_rec_type rec_type;
 };
 
 /*
-- 
2.34.1

