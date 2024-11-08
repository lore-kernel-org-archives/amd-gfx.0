Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6F7D5E15E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3234A10E967;
	Fri,  8 Nov 2024 11:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fxFh33al";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BC9E10E964
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCUNwEJPk84kIuYroyrSJU/VLHI716CEFnoaYrEfHjrvzWfPMldi5gqUKVQFmj0+pyinAPYATg6LREk/xxk8mfUNbSvzI77kpz9nH3o4x6bo57n8RWZWOkfWEuPgyuqEFQAYXmASV9mCAcJS/sTg0F1fdKhNtoGph1OEQiEzE8OhVP7QLJfdKI6TkVeABjAL2KtPsKvcusk18ZP7e9VWapwjTfeaC6He8yt1TF3D9ifZ7WPfAB+mpyZBxnez+90msiwCR9z3PQDQ0Z7fKh5JZoRk7XrbR67cgRe7sQdL9q3lFceO/twdqTL15P9Yb1B+vd/LG8ypFVoe4gS6wn+Wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVpYn0BLp4xjNQoXdNCqmkQcQu0JhjOrNaasXu4SwJo=;
 b=fKF+1YnWEBslPr16kzWU7x8Ez2XVP1agREuadqGZxY0io1m1yRqPkdRTurrVeogxnubEvRezNwRVKfUXjr6frX99oQ3uOf/j0sKXi8eIvgeb5a1Y+jwUHnGPul9TpCJOLstn98SKpN/ZY0QyBlPt17R4WtVoDFcAXYZ4B9KT2/t2ybOsfzMNRrjTeWznMV2Ld1KMyPUJFsGkXdWrt7/haQb9/IFokLw8Hrd5NwN92RlmwGfZ31iX5R3E7M+CT9BS2SXtat3NZ4rlVObxFBV259Bk451BV1+VF3N63tUkzMXAjEfMI7eIF2dx7uJQWHBIKDHJAJ9piWKJ5b4R9M/+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVpYn0BLp4xjNQoXdNCqmkQcQu0JhjOrNaasXu4SwJo=;
 b=fxFh33alvtzoad7oixkqnsGE38ac6Hwr+Y1P6ng8bWeMH5nJb9m/UHIYFdQRPt63TtbL3fz38jsJyzfg2skAdUwOW7n+aMR8+umklBSHvVojics1LIDnySzWiiBz7JZi7Y5oPjYpRUR2L7dVdEcWDvHKtp0rzm/kmq4as3sAOUQ=
Received: from BL1P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::17)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 11:14:45 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c7:cafe::71) by BL1P222CA0012.outlook.office365.com
 (2603:10b6:208:2c7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:43 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:42 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 10/23] drm/amdgpu: add flag to indicate the type of RAS eeprom
 record
Date: Fri, 8 Nov 2024 19:14:10 +0800
Message-ID: <20241108111423.60169-10-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CY5PR12MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c5e09b-97ee-46c5-59ac-08dcffe68c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?41rsfBWqlI2Odi0Xl/sR0zmDhP1wW2Y9Rr9ibDT1RqB8OizkQerX1JWezzkd?=
 =?us-ascii?Q?aI+zy/dZk6Wv21OPWwY+2jhNLlwPl2MsxCNtyNIYUJ9DvC4xfLerjKj8INz7?=
 =?us-ascii?Q?4/sO470U+2vWiYC/tiDFtWbfCXRLI/GE1OeMC8W03IPylXud5OqQZisVk4J8?=
 =?us-ascii?Q?auAXcPHl+G3+QkMw4qsIs5cWL9si665RjbiTBkcNxVTs+LtReeMfeGvIBm6Z?=
 =?us-ascii?Q?htNtjqyu/rtvqQqO7u6mPH3PHPShOUFFD2l1g3ZG1Q7ZNB5uPPzJGeVlXzgE?=
 =?us-ascii?Q?GoqgpUdLRT95sY0/vsdVMqhW/IttR6gaPqHd4AY19bdRtqI2/MXxGmjKA4qp?=
 =?us-ascii?Q?DqIGr9HXLfh/S8ymjdRlyjyRf5abMn/kmzzggGtyOiYt9O9sazCUoe1eAJ1g?=
 =?us-ascii?Q?dGzYnY5dcg1UhGE9KL+FkFm34D5oi0PThd13GrBTyA1f6n5FrjsIqqF2tpMe?=
 =?us-ascii?Q?e5KCNQskDPcxgBoxlVUgN+MLHut74gCj1kVf4CI2y/CHXMG1pkbVVhWkXfgC?=
 =?us-ascii?Q?kQRTj3ALHJgbBZZdR9/xaegRDSjtZJvYh8kr23A0w4F00ioGRUdB9E2B/cN8?=
 =?us-ascii?Q?6D/w97x3vXryUAVg0Co0osFA2J8Tt9mXGaMZ74z7saqlCrDy1LF7vKMuxB2c?=
 =?us-ascii?Q?mj45Qfr7SeZRdDf8Nu8Ayuw84m1Xgo78oVm+JjnOiTyWrfxtuLGcLpDUVC/W?=
 =?us-ascii?Q?k80PeY3fhHmQGiQuT8HqneuYOPoqC/rLrw2a9Lo2LeLfs1Mn4aAuII5z+ykz?=
 =?us-ascii?Q?rb+dnLF+0mfOlyMO6C+tcJleZ42wJ5fU8VTtmfc589NIA5dnQwD+dN/Vs2cm?=
 =?us-ascii?Q?z3IhbZWfW2Dbb7HvA5lnjWNBzg/6YCL4sm78NomlrILfglD8CbaqSF/wQNXt?=
 =?us-ascii?Q?FyqZmqyw0s5LCZEt2juyITQn6w2YfoHLyCXA1drMV/MT9GVEq7sfbYgMITRr?=
 =?us-ascii?Q?1WBd6Bh2hYLbG7gyormJWJcRUNlqEUk9INkjPgoGhstkGTnMo9eUjUYaTcDD?=
 =?us-ascii?Q?O4ql+nZHtDfIZVxjhG7oaDl19KJn0Y7TVI0m90nsJsiLnFwTRfDRU/miReIv?=
 =?us-ascii?Q?13J8ncLXA+nlbU7fu1JTFKiWHYYIb+0Yy8weBky9HNbmo6PLkcWj43kgTzAD?=
 =?us-ascii?Q?gPfZ2pColcpSYlvLwyrRKt8UpKyRwz3JGnCYAZRWuRySVJtGsGCT9ahPDBzI?=
 =?us-ascii?Q?iyve++NIvCEADr0Zg6dPhRfiCyE5Z8D5sFSXFjUo48EnRBu6CWPLcJt/L5ZI?=
 =?us-ascii?Q?6U93otWJYnReSgxB60RkS5E/TbD7tF3f5dIv+flkK8/Gfsz5yCG4z667GvXd?=
 =?us-ascii?Q?xWSi2S+wrFm/tK7oOX7xLUmgDSFgKxY2t7MZZHe848BsF+iv2AIBJAHHxjdI?=
 =?us-ascii?Q?PjtwvtJ9lbpcVHlh7qlkQdCBds+UOggNiWqeROti963n/te7Ug=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:43.9141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c5e09b-97ee-46c5-59ac-08dcffe68c37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298
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

One UMC MCA address could map to multiply physical address (PA):

AMDGPU_RAS_EEPROM_REC_PA: one record store one PA
AMDGPU_RAS_EEPROM_REC_MCA: one record store one MCA address, PA
is not cared about

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 33 +++++++++++++++----
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    | 14 ++++++++
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index cbecf2380b51..77cb2d7bb0a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2769,10 +2769,20 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 		return -ENOMEM;
 
 	ret = amdgpu_ras_eeprom_read(control, bps, control->ras_num_recs);
-	if (ret)
+	if (ret) {
 		dev_err(adev->dev, "Failed to load EEPROM table records!");
-	else
+	} else {
+		if (control->ras_num_recs > 1 &&
+		    adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
+			if ((bps[0].address == bps[1].address) &&
+			    (bps[0].mem_channel == bps[1].mem_channel))
+				control->rec_type = AMDGPU_RAS_EEPROM_REC_PA;
+			else
+				control->rec_type = AMDGPU_RAS_EEPROM_REC_MCA;
+		}
+
 		ret = amdgpu_ras_add_bad_pages(adev, bps, control->ras_num_recs);
+	}
 
 	kfree(bps);
 	return ret;
@@ -3161,13 +3171,14 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control;
 	int ret;
 
 	if (!con || amdgpu_sriov_vf(adev))
 		return 0;
 
-	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
-
+	control = &con->eeprom_control;
+	ret = amdgpu_ras_eeprom_init(control);
 	if (ret)
 		return ret;
 
@@ -3175,17 +3186,25 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 	if (amdgpu_ras_is_rma(adev))
 		return -EHWPOISON;
 
-	if (con->eeprom_control.ras_num_recs) {
+	if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr)
+		control->rec_type = AMDGPU_RAS_EEPROM_REC_PA;
+
+	/* default status is MCA storage */
+	if (control->ras_num_recs <= 1 &&
+	    adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
+		control->rec_type = AMDGPU_RAS_EEPROM_REC_MCA;
+
+	if (control->ras_num_recs) {
 		ret = amdgpu_ras_load_bad_pages(adev);
 		if (ret)
 			return ret;
 
 		amdgpu_dpm_send_hbm_bad_pages_num(
-			adev, con->eeprom_control.ras_num_recs);
+			adev, control->ras_num_recs);
 
 		if (con->update_channel_flag == true) {
 			amdgpu_dpm_send_hbm_bad_channel_flag(
-				adev, con->eeprom_control.bad_channel_bitmap);
+				adev, control->bad_channel_bitmap);
 			con->update_channel_flag = false;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index b9ebda577797..d3a6f7205a2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -43,6 +43,19 @@ enum amdgpu_ras_eeprom_err_type {
 	AMDGPU_RAS_EEPROM_ERR_COUNT,
 };
 
+/*
+ * one UMC MCA address could map to multiply physical address (PA),
+ * such as 1:16, we use eeprom_table_record.address to store MCA
+ * address and use eeprom_table_record.retired_page to save PA.
+ *
+ * AMDGPU_RAS_EEPROM_REC_PA: one record store one PA
+ * AMDGPU_RAS_EEPROM_REC_MCA: one record store one MCA address
+ */
+enum amdgpu_ras_eeprom_rec_type {
+	AMDGPU_RAS_EEPROM_REC_PA,
+	AMDGPU_RAS_EEPROM_REC_MCA,
+};
+
 struct amdgpu_ras_eeprom_table_header {
 	uint32_t header;
 	uint32_t version;
@@ -102,6 +115,7 @@ struct amdgpu_ras_eeprom_control {
 	/* Record channel info which occurred bad pages
 	 */
 	u32 bad_channel_bitmap;
+	enum amdgpu_ras_eeprom_rec_type rec_type;
 };
 
 /*
-- 
2.34.1

