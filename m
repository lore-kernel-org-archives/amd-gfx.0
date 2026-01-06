Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314DDC47BDF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E4110E4CB;
	Tue,  6 Jan 2026 10:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KWF918/2";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3690310E4C8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5QEQbG6ekIKG0lE3LP24LZVIEf2ziex5gNyH9/ShdRQJFsOa9CM38uKOCxt0+LUuX+yMFx2lHOFxCKG79VUIBqEdTguM6DjnB75ibvhI83jFAVes+xjwEcnctkhRSwsFAm8X0qxbBSy1ZYYWpoUKQIyyik5fkcM5y/DlXgCXpifld5Gr8WQarYGeUT/jxQnMSOsDLpOkPx4xyVtzt91+UzmFWnVEiwA8sSdvsTHti/OSxpRSHvobj6l+FkzoVtzYIXnbyhlHtnvVKDQHHsbX9QVoipjad4PfWDHWWZ/T8YJbAJimfV4Y+Ej3vT8O1xwtkIOTOoAqUkzgpEqQ6kUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raGkli1FrRpDo3ebAcHhKpO7Hy8tvJq7v+8j2LJtPwI=;
 b=O2wZsvf6MTeDddtRNoS/kBnOISonY9O98meazKhxUqrjo8c34pljboZRyqIllZqGcWnHWexRb4DDOVfyURvGiAaFvGC2ZW4Fw2+ypBfA4zy+3xZQPMsAXz0BASW5ORrwfQ31z9i+eh5SDn3qATgo/Eb2YFbdyNefnW7GImDDkUgVP5VtliqsYxv7YiwuIFC39lC6R7EcKtOfZL+1CUyBFF1IUzKH/+6YpDBEFOxzIdPcL7K7mhPxRTKJRBFPM0XrZFgJc/Y7aL8acEJvDugP0eXysY147jCARBSRPPgU3YseASRr+uCGU+XquHKv/ffWGsZo8nZgS8tYFbpLwOAWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raGkli1FrRpDo3ebAcHhKpO7Hy8tvJq7v+8j2LJtPwI=;
 b=KWF918/2HN1yqXK64ZS/Nlt7BilWnPPg9B9LVle5GvZGi/rMjwAHitlhw6jNvdME0ZyQXibjwBqe+vZnf9ShpGG7OSE7k6/OmsH90ckRD8KVMaWV56BoNaMmh9wUzCo7m+Yl1sNq6nIjnLZ/zY6A1t6vCnvXcjorBTcyFLAt6ng=
Received: from SA0PR11CA0176.namprd11.prod.outlook.com (2603:10b6:806:1bb::31)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:14:04 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::3e) by SA0PR11CA0176.outlook.office365.com
 (2603:10b6:806:1bb::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 10:13:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:14:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:14:01 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 13/21] drm/amd/pm: Drop legacy message fields from SMUv14
Date: Tue, 6 Jan 2026 15:42:33 +0530
Message-ID: <20260106101317.3856153-14-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: d955f7f9-885b-4195-4551-08de4d0c51fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bvOvy4aD2VEacINsfYKHWqvdYK0NM5NmcQcUNY011eKb0dz3lL2YOapH6U1E?=
 =?us-ascii?Q?nnfk8csL4gUQBjRFWzyBOj/lFYL8v77oHGKAx1HMWG60KGr9N1+tX59pL6/O?=
 =?us-ascii?Q?2V2D542FozqeRc4N7ewKZo6vfgMCVxnqTfCg4obJxIhyuf6Laltxit3n6xm0?=
 =?us-ascii?Q?kI1An8GdqONaGzIBMIeiw2qHG1kZL8A142ke5K6nww7JileDKyGCe2BH2YVa?=
 =?us-ascii?Q?N6+fU8h6opE5P+6Mr+CvvNh8tEWnBBCpnMEetlqplLEJUB5BgrewFkJHOCt0?=
 =?us-ascii?Q?lJ4hwH+404nCvnUW4l33QUfjvDj7qJZpstyV4gzYJG70m2UqlURfAIWu16pm?=
 =?us-ascii?Q?tohoQKSdnjOlGfHu+WNwpzGWpOEO44IZW9TcBe19h2xGEjIDmGwBzLGvGNj0?=
 =?us-ascii?Q?ZtzMuBcXxvmQJppQ93ecmzGtt9HehI4lj3a9PMpvQhth0nJLnHuzPPIGgC7b?=
 =?us-ascii?Q?zd8TdWCbmG093g8bkJr7augMvxxE0EXESVNykdxzJ56lMG5hwTSbjGz78DuN?=
 =?us-ascii?Q?PX7gQYO+VqYFscR7fHZwzJ4v8h+xrywWO2ejuRd2qcfwv3IVS7SUr35tp8uG?=
 =?us-ascii?Q?PpHLlYIk1r9bWB7QTX9g8mLOTS+cZgnakIp9UKH2pravdwCVt992ZrnFXU8t?=
 =?us-ascii?Q?h8enZzJfpnNiMJCZcYwn0k8mId58JmiWPAjtjHD6xqE2KOkgv4crqEWPFTok?=
 =?us-ascii?Q?5JptYeFAzqjWITYn/sOn+Yg5WjqElGBEp9oJ+y7/vsV1onN2BcdjePbIkjA9?=
 =?us-ascii?Q?Y5qBH3iY7ctt+oWq64/O1+NR52tq2DWTSOlzsuVB0Q+dD5a3ESDuHkJYAlwL?=
 =?us-ascii?Q?vQlO8Blhw+phfaI4haRwZ+7W3KNsTJ2FDIKIk8NKPSWk6MCrF8ETHCvvf8ZV?=
 =?us-ascii?Q?tpa2ILd3KmIoBOnq9E2dbZMvNJKtRIum6hL+v2GrxnAxFrGHa+0Chaz7brdc?=
 =?us-ascii?Q?WZG5QWIS3T0sXNaV1iTYvKH1zfnMNG13TasWO2e0hncxV96LY7rCMyAiNOE/?=
 =?us-ascii?Q?wWs6ff0q5Uwbp8Hcw8FJTbPwc3pGakbmshBAQyfayAdxMIq4o+nyNV0kHdZE?=
 =?us-ascii?Q?KcPNjgY2cf+Y08MUsgBotOyREilynRCpspexQQhrfrMtS6jpc88UWnG0U3NQ?=
 =?us-ascii?Q?NXyVYdfAGPF+J6PYBbgYPa6oXnwN+IdS4YlkmjyUJID50G4+mIISo+1Xfe6+?=
 =?us-ascii?Q?t1uyBDqQ7lWjviXxZwIsv9B8lKbIKUg9GW7qUN+nJqzTfZF8OgVt0AlBTG1B?=
 =?us-ascii?Q?5Q8RBkRchH6y6c3mBnZ+rhjjSNGNvdN/TNYs1sxoSjHzHOkt5BeLpkfhpYvQ?=
 =?us-ascii?Q?RYUxHCmFCqp0UU+OzsjEtCwyyA12usOhtdQLUTR6oH61Qs9zoZhyQKhoLFms?=
 =?us-ascii?Q?AnrCyIE5t0udVWS4L3EmpdQMttGJQTSyWN4xZ/o+2hDtLFcqvQ9/UZyYhkIY?=
 =?us-ascii?Q?Ib27dA5gevz1sklsiwJCKfAm/H69QOsVjqj7r9Vgxfkbke3QF7VqZQp0l067?=
 =?us-ascii?Q?uXdIlwCGI6K1PXh+nLiDI5loCn5AyGWwCcdGE7JhDzLVWClqy0m7exLl0cUo?=
 =?us-ascii?Q?lzypkFK4JYp4peGl8qI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:14:04.2971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d955f7f9-885b-4195-4551-08de4d0c51fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485
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

Remove usage of legacy message related fields from SMUv14 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h         |  6 ++----
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 12 ------------
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c |  5 -----
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 4ecec85b8404..613d4d36f32f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -215,10 +215,8 @@ int smu_v14_0_get_pptable_from_firmware(struct smu_context *smu,
 					uint32_t pptable_id);
 
 int smu_v14_0_od_edit_dpm_table(struct smu_context *smu,
-				enum PP_OD_DPM_TABLE_COMMAND type,
-				long input[], uint32_t size);
-
-void smu_v14_0_set_smu_mailbox_registers(struct smu_context *smu);
+			enum PP_OD_DPM_TABLE_COMMAND type,
+			long input[], uint32_t size);
 
 int smu_v14_0_enable_thermal_alert(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 9c15fccac2b8..0a509fec2180 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1731,15 +1731,6 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.set_mall_enable = smu_v14_0_common_set_mall_enable,
 };
 
-static void smu_v14_0_0_set_smu_mailbox_registers(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
-}
-
 static void smu_v14_0_0_init_msg_ctl(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1758,13 +1749,10 @@ static void smu_v14_0_0_init_msg_ctl(struct smu_context *smu)
 
 void smu_v14_0_0_set_ppt_funcs(struct smu_context *smu)
 {
-
 	smu->ppt_funcs = &smu_v14_0_0_ppt_funcs;
-	smu->message_map = smu_v14_0_0_message_map;
 	smu->feature_map = smu_v14_0_0_feature_mask_map;
 	smu->table_map = smu_v14_0_0_table_map;
 	smu->is_apu = true;
 
-	smu_v14_0_0_set_smu_mailbox_registers(smu);
 	smu_v14_0_0_init_msg_ctl(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 5bf10555effd..e414dfd6f644 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2111,10 +2111,6 @@ static void smu_v14_0_2_set_smu_mailbox_registers(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_90);
-
 	smu->debug_param_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_53);
 	smu->debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_75);
 	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_54);
@@ -2875,7 +2871,6 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &smu_v14_0_2_ppt_funcs;
-	smu->message_map = smu_v14_0_2_message_map;
 	smu->clock_map = smu_v14_0_2_clk_map;
 	smu->feature_map = smu_v14_0_2_feature_mask_map;
 	smu->table_map = smu_v14_0_2_table_map;
-- 
2.49.0

