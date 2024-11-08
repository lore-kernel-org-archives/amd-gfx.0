Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BEBD43357
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321D110E965;
	Fri,  8 Nov 2024 11:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S2+HHMXw";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D7510E964
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4/Mh8pnc/EblGj1afn6ipglr+LKjlQLcdw9Lr3ixs2czLzz51Kbkrv4gCSJuZaKTroNTqmN2cIcesGbi+3Ywyl1QAlglOFw3ABsb556x4Nr2yke4qglP9sHti77El1OqWfQMlrj8gyVi3kJKLzMz75SAHTWjyRhfMlJ4MQaPUmrHZKQg9RY+HhgdMCILnvqGtoiO3cFtda8O97vBj0roB2t0OIdXfoHTTit9PYzOHHeXvWVvWKzlb3SU7Hje3yhtpMBbm83RIwbowLY17nnXYV07rpZLnrKZTApoigF7lnjR3ZdC9bNES4Ifjhdr7yN3eEETYWy8NXRaPBzqUXxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cmj7ovTB81LXZ71tuJpUIJqfVM6/iAnEj7DfnjrHNmQ=;
 b=aM+nFbc+pt/bMuTfoq5/qWvKH634TF73PfXyDXogY9ANrjCZMVavv7Ws2W6hDYqbJ9PQaqSJwM+Iio7JFiC70RwnxCYH+2Rvasz5oLsO1wdUfodrpt2fJyQ9r2pz9Bq/ct6/3x/LCC6i/h5wiybnyUJBpKWJURYc8PwMNXiYrLxkPsXkJ9N0UsWKz4h2IkLC+Nz5zRbrlKiISFT2+nVI4nXlbdIfNyLBF9mPd2sjBakyjqUNmBYAbJ2iSbj0LjklqMRcpdBQNmZHY1buXGKB8pD7hFmY5jpoyX9gRlTtOM2YqmI3P91lCnlVy9UXlINLGpF62QWTLO19THWFS4+sbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmj7ovTB81LXZ71tuJpUIJqfVM6/iAnEj7DfnjrHNmQ=;
 b=S2+HHMXwXzCuNK/8sYzP3o7B1SFr0lJ+bBCgYhIp6oI4ZoSktZdnbCHst2mdVY4eecuTPntjhlekn405g23oGJRs6SAWJDpYRJRiZ6IuxeK0lXhKlOjNRRs2lMh1V/FW6ggDz6RN9Ljnv4K+tL7YsCKkwjRyK8fhGvGY7+cyG3s=
Received: from BL1P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::15)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 11:14:46 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c7:cafe::db) by BL1P222CA0010.outlook.office365.com
 (2603:10b6:208:2c7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:46 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:44 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 12/23] drm/amdgpu: store only one RAS bad page record for all
 pages in one row
Date: Fri, 8 Nov 2024 19:14:12 +0800
Message-ID: <20241108111423.60169-12-tao.zhou1@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 252d2053-1e0c-4c34-8463-08dcffe68da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6PvFz/HZXYKs2lIRKmUNquGvlZ+ShJqpHwz/9DvoNqiR8uu7WvKkA7+e7KnB?=
 =?us-ascii?Q?tyk97AZldTRkLyuepBtND5uZ+jnINLUmqWwtHhKOx+EStLJRjlki7SN466KL?=
 =?us-ascii?Q?eyutjqluzWGa9MvHjrHEZQATORUHAAajRBKKTF6PARiql47qz46Un8JNSNO5?=
 =?us-ascii?Q?Yt2cS46o4aKmujDJWj+gkTrhrrHjBc49b0NjwI41n3iS4IUE5qvmO7S/iN1E?=
 =?us-ascii?Q?HM1CnggGpplDjowSH6HhumITBAFnCOwVWv32soJucCqHXnT1BCznQ8iPd00M?=
 =?us-ascii?Q?b1WWw22yO1PhTsv8yutNg3GZD5kmfCpWCbNyYxk8rYHq/j0hJdiTpSWjBwVW?=
 =?us-ascii?Q?VZBxgrA0/md9UKZ7TRdnrbg+kegO5yET0DGVQDvo8Zx6cPWUE84Pt0Zjn24+?=
 =?us-ascii?Q?CGEMLqlS+L5Z/+nkm/ofAn8RKaa48JcsBTqJ2mJYSrspxRmSny720OYVXpXC?=
 =?us-ascii?Q?qjle4gUAtVvFDtgOXVmjzvzgBWABRHjgH39WAzLUagbsPQKOU7UycRkzMlrA?=
 =?us-ascii?Q?Yc8fMA9XJRdUf7NNAXLlxAmsnoleqEEgiKi5xrmBBETyLz9FfaE8x+oCVFRz?=
 =?us-ascii?Q?Wp24jun11p9O6jft35Ifs12+iVAvBrBDXhdHcgXCdECRJFvNKNDRSlOJKodA?=
 =?us-ascii?Q?ySjfiTWf9E2CiVbzy54YbMluJSMBZN6MQsb3MpgHDtBkS3nyktqM8dvmn69X?=
 =?us-ascii?Q?ZQwn/NmlvbocOjOqsgRgXTpkbYTajTu8PE4AUgM66Mvxr3yRF9H6LfuK9od2?=
 =?us-ascii?Q?dkWl47ujhGEv0HjJvTA5wRyzxz3n1pNFkRjMr3UDjZveNmacSisGaxuUOPXM?=
 =?us-ascii?Q?RHeTMnJXVEskxcMtTUcswXTPjou3LgY3ATG3fNLcmIPK4ne0JNgKv//5kQEM?=
 =?us-ascii?Q?hMMt1eb+uwOWGHODtOP+REa6zSY+vZ+HxdSK02bC0G2wQ4ht6c23SL9OxRlN?=
 =?us-ascii?Q?sEcHMNv8zvsL5OcrxZCHW1+eQeNynb4wQS8eLKNe1t+EFDScFT64uaHYUYQB?=
 =?us-ascii?Q?lBHv4hUDDN4hntvArDGH24nO8B50Tx44TiWZvhzT4+RmDPu7wfOp5rkjQ7td?=
 =?us-ascii?Q?+o0FjxUR4TP4jYENqt7mBf/L8ZjiR9HaAG8E3riNaWlDOVlGqVC2dyjVQefd?=
 =?us-ascii?Q?NpGiqlH3XDFWYL6cfZLtxPc0UgCBiLMLWOJeopy6QionNsMPF9kp8IKuZMS4?=
 =?us-ascii?Q?beJ9kLZNYggxRd/qFWDIs6JrhCZxO+cXtew6MPRfjBtFfvgHjt2lUUMXrLsa?=
 =?us-ascii?Q?OmndSf5CD0sLKiISBY9j+20DG1cPMUcEbImXjMXgfiRZCE6Nu8LVLTV9iUR4?=
 =?us-ascii?Q?Ft64cWyCoRX891U7WbiyAolA9xlBsmNK7LapzYZ/7sj3Pv5U3fZA+giqwlmP?=
 =?us-ascii?Q?wpcyt1UVkBib+l1DIeRFFtmsMqmaVBIDMvnAH3tPjjxn7uUigw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:46.3047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 252d2053-1e0c-4c34-8463-08dcffe68da6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297
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

So eeprom space can be saved, compatible with legacy way.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 35 +++++++++++++++++++------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f31085c3a12d..b45344fe8cc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2789,7 +2789,7 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
 	struct amdgpu_ras_eeprom_control *control;
-	int save_count;
+	int save_count, unit_num, bad_page_num, i;
 
 	if (!con || !con->eh_data) {
 		if (new_cnt)
@@ -2801,19 +2801,38 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	mutex_lock(&con->recovery_lock);
 	control = &con->eeprom_control;
 	data = con->eh_data;
-	save_count = data->count - control->ras_num_recs;
+	bad_page_num = control->ras_num_recs;
+	/* one record on eeprom stands for all pages in one memory row
+	 * in this mode
+	 */
+	if (control->rec_type == AMDGPU_RAS_EEPROM_REC_MCA)
+		bad_page_num = control->ras_num_recs * adev->umc.retire_unit;
+
+	save_count = data->count - bad_page_num;
 	mutex_unlock(&con->recovery_lock);
 
+	unit_num = save_count / adev->umc.retire_unit;
 	if (new_cnt)
-		*new_cnt = save_count / adev->umc.retire_unit;
+		*new_cnt = unit_num;
 
 	/* only new entries are saved */
 	if (save_count > 0) {
-		if (amdgpu_ras_eeprom_append(control,
-					     &data->bps[control->ras_num_recs],
-					     save_count)) {
-			dev_err(adev->dev, "Failed to save EEPROM table data!");
-			return -EIO;
+		if (control->rec_type == AMDGPU_RAS_EEPROM_REC_PA) {
+			if (amdgpu_ras_eeprom_append(control,
+						     &data->bps[control->ras_num_recs],
+						     save_count)) {
+				dev_err(adev->dev, "Failed to save EEPROM table data!");
+				return -EIO;
+			}
+		} else {
+			for (i = 0; i < unit_num; i++) {
+				if (amdgpu_ras_eeprom_append(control,
+						&data->bps[bad_page_num + i * adev->umc.retire_unit],
+						1)) {
+					dev_err(adev->dev, "Failed to save EEPROM table data!");
+					return -EIO;
+				}
+			}
 		}
 
 		dev_info(adev->dev, "Saved %d pages to EEPROM table.\n", save_count);
-- 
2.34.1

