Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC3FC54E67
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 02:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644BC10F194;
	Mon, 18 Mar 2024 02:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GyLP2lMi";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870C010F188
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 02:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9WFBMyKKn1MIK7JT6w88xcKwFSu00avoWozu3mLRVY3zSuJZsm9/A0+iI3QrW++a3/0yR2OFKVzTR2sCUJaB6KP428GJklUt9voccvoid2FtLfZFr0xUAniXmJ9gkAfI59zwUScJ1DeOhp6/tq+FB+77F4F4WaC7R5oRFEPrIglYZQqQuSNqEWirvD33DEAk/vEnetp4J64ExevgYQcSVIAs/LEI/fVVBb99OPiURqor7iYMfC05YbmA28YK6FEwggrrZG0Zu59mVMoygg4qLQoIOUvBHjXbYoKjoq0xjB3G7yomwO50Sib0EDNSAhzRf0d6Fq4dF7gmnRWZ87EKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nheGofczoeusYxe/W63Zi689LXkND21p85bYfbT6ng8=;
 b=F2GHgeY8Zu1SN3RcFrfPpeOTjGktocSjhjFwAlv+RDOPJLXQ9Hu4CyubceQE/5vnL0OvTm5xRlXL4idVA5jergPHfOBaLUBcudfayzTG+1Sp6c7o56+844CjpvSLea2zcYl4KFjLj0r6zSZ668rpLI/Km+Z3cG3alYhMj5iRdPMucRoUUOLS7c/I1fGJQHOZRvvRV5JMAvY0aeWPJnk1KAYSJJLwISEFJhG07C90DTqU1TESJVsV88AUf3ckofaz5JjioaIhi1kL5kHUAA6vlfoGMcZsLqoK2zefn4sY7ZNimPje00qfgOjXlQzGK8JDIHgnWN23aojzESm8nSf3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nheGofczoeusYxe/W63Zi689LXkND21p85bYfbT6ng8=;
 b=GyLP2lMipcICZX/2FwBc1Vssv+nlR81aJswc1oCT+WhbBNQlnjbFXCqxFqDn8PyXFdFs0nxTWCb4P1hMMSW9nFhpNt1JvfzkolYeIhtyVyN2I53UmyuVp5SnVXjnKuKOTSDpdQ5ecIP18hr79wzMAEeIgaW811C897UWqM+9wqs=
Received: from BN9PR03CA0651.namprd03.prod.outlook.com (2603:10b6:408:13b::26)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 02:26:15 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::8a) by BN9PR03CA0651.outlook.office365.com
 (2603:10b6:408:13b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 18 Mar 2024 02:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 02:26:14 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 17 Mar
 2024 21:26:10 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: add ras event id support for ACA
Date: Mon, 18 Mar 2024 10:25:20 +0800
Message-ID: <20240318022520.168079-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b19aba-aabd-4254-54b0-08dc46f2c8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ptieWkRBYEZVxetCeef+kDDmo2F5gEXNnvIeOLVC+5viMQABjbEstYRkOuheY/R2dcW/TYaf8LA56x99ExJ8AdieSjbJsa32jJKdhjVP6k4nLE5fRonDQ051hjHF68oMJE0lEbuEpDmx1gSw2GZzwh671w+1xM9g8nxPaYvvFcgFndW2GVf0irMLZoY4c0WaNjT1kRebkURNLqHOa1G7zikjg/QlAvrTeACbrHe/DRkseNup41wBHUObY6Z2DBW2lEgxMDaHlUFcSu5jntgZKm2tCZnO6z0KT6UNTVD80Cru5vFnuzKYp92FLCGLeV5p5HbCoTOqu6YfIRpSX0u6fSakDtILwBXNdyYzE1m2HXkBhJvzYb4mB9l5fW3mIOeBhTdKmcucIUPzWM5D+Lkv6a/xkg1pI1AGCQ8bNxMHsJTUHLwGn833hWxJ4/M1EI3vKOjkF8SjvlgH1+6J8fau3Wutu2IzOeFg5/qdKC8rkBi4/58Fs2wDoyWeRl0URNN6nzplxgVVzmc0eyO97w+KlpLAUGh9vTz3DAGThQrvDRATTVczDVILzFNkT/ssxTHaBXt4yz4I1+RN63C3GEwPbg632iWhjdBRTLTCx0anYgbtEi7r3HUBKw5DLm4KZeWcJ5bdsbpDAfncn/3MLh9n4xlMHTK8vJKHZX7QIKmPW3tt1fAS78iODcfqgseP9MgWqT1JqdSBIw7w3krfJxlP97m1oViQKFHY8xorBf/OB90Kg9bRR33zYx0C0Iq/0Mt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 02:26:14.7308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b19aba-aabd-4254-54b0-08dc46f2c8fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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

add ras event id support for ACA.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 29 ++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++++-----
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 53ad76f590a1..ddcb68e60a73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -116,20 +116,22 @@ static struct aca_regs_dump {
 	{"CONTROL_MASK",	ACA_REG_IDX_CTL_MASK},
 };
 
-static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int total, struct aca_bank *bank)
+static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int total, struct aca_bank *bank,
+			      struct ras_query_context *qctx)
 {
+	u64 event_id = qctx ? qctx->event_id: 0ULL;
 	int i;
 
-	dev_info(adev->dev, HW_ERR "Accelerator Check Architecture events logged\n");
+	RAS_EVENT_LOG(adev, event_id, HW_ERR "Accelerator Check Architecture events logged\n");
 	/* plus 1 for output format, e.g: ACA[08/08]: xxxx */
 	for (i = 0; i < ARRAY_SIZE(aca_regs); i++)
-		dev_info(adev->dev, HW_ERR "ACA[%02d/%02d].%s=0x%016llx\n",
-			 idx + 1, total, aca_regs[i].name, bank->regs[aca_regs[i].reg_idx]);
+		RAS_EVENT_LOG(adev, event_id, HW_ERR "ACA[%02d/%02d].%s=0x%016llx\n",
+			      idx + 1, total, aca_regs[i].name, bank->regs[aca_regs[i].reg_idx]);
 }
 
 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_type type,
 				       int start, int count,
-				       struct aca_banks *banks)
+				       struct aca_banks *banks, struct ras_query_context *qctx)
 {
 	struct amdgpu_aca *aca = &adev->aca;
 	const struct aca_smu_funcs *smu_funcs = aca->smu_funcs;
@@ -165,7 +167,7 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_
 
 		bank.type = type;
 
-		aca_smu_bank_dump(adev, i, count, &bank);
+		aca_smu_bank_dump(adev, i, count, &bank, qctx);
 
 		ret = aca_banks_add_bank(banks, &bank);
 		if (ret)
@@ -390,7 +392,7 @@ static bool aca_bank_should_update(struct amdgpu_device *adev, enum aca_smu_type
 }
 
 static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
-			    bank_handler_t handler, void *data)
+			    bank_handler_t handler, struct ras_query_context *qctx, void *data)
 {
 	struct amdgpu_aca *aca = &adev->aca;
 	struct aca_banks banks;
@@ -412,7 +414,7 @@ static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
 
 	aca_banks_init(&banks);
 
-	ret = aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks);
+	ret = aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks, qctx);
 	if (ret)
 		goto err_release_banks;
 
@@ -489,7 +491,7 @@ static int aca_log_aca_error(struct aca_handle *handle, enum aca_error_type type
 }
 
 static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle, enum aca_error_type type,
-				struct ras_err_data *err_data)
+				struct ras_err_data *err_data, struct ras_query_context *qctx)
 {
 	enum aca_smu_type smu_type;
 	int ret;
@@ -507,7 +509,7 @@ static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h
 	}
 
 	/* udpate aca bank to aca source error_cache first */
-	ret = aca_banks_update(adev, smu_type, handler_aca_log_bank_error, NULL);
+	ret = aca_banks_update(adev, smu_type, handler_aca_log_bank_error, qctx, NULL);
 	if (ret)
 		return ret;
 
@@ -523,7 +525,7 @@ static bool aca_handle_is_valid(struct aca_handle *handle)
 }
 
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
-			      enum aca_error_type type, void *data)
+			      enum aca_error_type type, void *data, void *qctx)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)data;
 
@@ -536,7 +538,8 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *han
 	if (!(BIT(type) & handle->mask))
 		return  0;
 
-	return __aca_get_error_data(adev, handle, type, err_data);
+	return __aca_get_error_data(adev, handle, type, err_data,
+				    (struct ras_query_context *)qctx);
 }
 
 static void aca_error_init(struct aca_error *aerr, enum aca_error_type type)
@@ -853,7 +856,7 @@ static int aca_dump_show(struct seq_file *m, enum aca_smu_type type)
 		.idx = 0,
 	};
 
-	return aca_banks_update(adev, type, handler_aca_bank_dump, (void *)&context);
+	return aca_banks_update(adev, type, handler_aca_bank_dump, NULL, (void *)&context);
 }
 
 static int aca_dump_ce_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 674a5a9da862..247968d6a925 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -198,7 +198,7 @@ int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *handle,
 			  const char *name, const struct aca_info *aca_info, void *data);
 void amdgpu_aca_remove_handle(struct aca_handle *handle);
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
-				     enum aca_error_type type, void *data);
+			      enum aca_error_type type, void *data, void *qctx);
 int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);
 void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
 int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 357349fcfcca..41b9315099a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1269,7 +1269,8 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
 }
 
 static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-					 enum aca_error_type type, struct ras_err_data *err_data)
+					 enum aca_error_type type, struct ras_err_data *err_data,
+					 struct ras_query_context *qctx)
 {
 	struct ras_manager *obj;
 
@@ -1277,7 +1278,7 @@ static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum amdgpu
 	if (!obj)
 		return -EINVAL;
 
-	return amdgpu_aca_get_error_data(adev, &obj->aca_handle, type, err_data);
+	return amdgpu_aca_get_error_data(adev, &obj->aca_handle, type, err_data, qctx);
 }
 
 ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *attr,
@@ -1334,15 +1335,15 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 		}
 	} else {
 		if (amdgpu_aca_is_enabled(adev)) {
-			ret = amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_TYPE_UE, err_data);
+			ret = amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_TYPE_UE, err_data, qctx);
 			if (ret)
 				return ret;
 
-			ret = amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_TYPE_CE, err_data);
+			ret = amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_TYPE_CE, err_data, qctx);
 			if (ret)
 				return ret;
 
-			ret = amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_TYPE_DEFERRED, err_data);
+			ret = amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_TYPE_DEFERRED, err_data, qctx);
 			if (ret)
 				return ret;
 		} else {
-- 
2.34.1

