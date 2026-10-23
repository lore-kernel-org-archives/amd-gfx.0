Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE1606A31D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=raIdH/iF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DF9112C85;
	Fri, 23 Oct 2026 17:13:19 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC9B310E5FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 12:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7NN8utuOeE+08d6X5uEJb+tBu3+zEvmdmDbiaR/RdR62qGInLpKgE8FwX964TjdiVUo1EDZ5qpBytnl7L3tK4nGc5pEODvNuEswib1BE9sZwWpm9rwVMrLg6eJH4yx/F6p4mrlyHbgTvqG2t2x3ZNI7+VvtpchlZ6f9KBwN1pwjK7WuEfC5l9sUzCrfbENH1YAPtYIaBkxkQr3/iUZVXRtTerC45QuoSAp7m4buuwB9alS0tuRTb4r80y/uTcwJBv8mqPdRnI+X0pZ9K7AickMf+Arl67Qn+AvqRX3Pum6e4JJlIKaIxiC205W8qVgxX5bpkdG9d4KeRhrKDL6TVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb6eFd1gLMjoFdhYLfn82Vt1nhlAbEIMSggxvknqwrs=;
 b=mOoojcejnVCgLPNFk+yxexr0n7Y9AvktQkMJKog6U3uNsnreRRACymDRRdVGCSGNX/bnRI779mVXdpSnKrsOEhiFUUTS0lvK9k5II0jJsKJZJDaIqo+FTbyjKi4wnRefIwOCLkly8NmMXm5Jn6xJAur6UmKc6B6cjn0ZXnKbm/TwCHe/+JQsxlD7tkn/J4TNJGKkTEm/wC+H37p8IJKtSfA+4tsgTolCCRRIvfCTE0GrCgrYkeBKtJf7sS+1ZkNtHXS2bXdz/PW8O6r8TOpVmJYbJoqMGxAB9yVkQloijfvDTd7jusjGUNguJozQW+mXDJpuzJnE4fNUHQPOfRVSbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb6eFd1gLMjoFdhYLfn82Vt1nhlAbEIMSggxvknqwrs=;
 b=raIdH/iFF7wtSUTHR2SKQupEgYBcfMcfueemEbyV32IHLGGUBqkAkVqDm1iv4KeUnOxURHTlO2QcHjpE1j40r4MW3ncmalGmYyS0FW9tFtZM0OTiCvo5Qy0Iql3KytLrImV3l6kOUHs1nxYOgR2RVGmxTuLbjCAdPR3gdAe4BeY=
Received: from CH0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:610:11a::18)
 by DS6PR12MB732632.namprd12.prod.outlook.com (2603:10b6:8:4d3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 12:59:25 +0000
Received: from CH7PEPF0000001B.namprd21.prod.outlook.com
 (2603:10b6:610:11a:cafe::2d) by CH0PR03CA0341.outlook.office365.com
 (2603:10b6:610:11a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 12:59:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF0000001B.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Fri, 23 Oct 2026 12:59:25 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 07:59:21 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Create board/ as a kobject
Date: Fri, 23 Oct 2026 20:59:05 +0800
Message-ID: <20261023125907.3229593-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001B:EE_|DS6PR12MB732632:EE_
X-MS-Office365-Filtering-Correlation-Id: e934eb7f-a7e6-43ed-53c3-08df31057734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|10067099003|11063799006|56012099006|261009223027099003|261022105027099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: UB5CPsv9aKj5ImMxZi0qhbMr4pnRkOGCXgjLLIfhckzTX5ltSXwLpVdzbvVyGDDiEEO+RQEUNwwh4JojOfW6kcul2Jbl+zAPjBtlxEhEX2emG7fTH01YhjDe3OvcDrNnz/NovvIE5dwlYYjxBLdJTk0bamTXimpoM72UAtGR4o7Ztl0/RzB9Lfwb7CjPCcLv/jfEt+HnUfp5YytStsNm7C7onPcb6RFXSG+Q9SW8LJ/1ZxLeQAWPd/rHG6u0Mfy7WF0jewly7fJLOUzgJedJUAwYIUmjItf/lLA4EiSp7WhcQpYBWPmKZ2aoD8tEKgAUlG4dI3z8Y1Jya+cn224nanjbe0R01Rkdy0XfJIJ8Gdd7QyI9gh96X9BCcxRltfMLuc0rEgEYLdKOJhdMAFXWXXlz3nEW/apYcD/WdQdnnzYH38Z0eVHuxunSDaIPWZLYRfm5UaYPoZCM0iB4oho4sK25QieYuRQ6C1p08R/twu3Cawcu63Jnqs/M4H5w1jhLh4ntWMymJ+wR0PHVxn1QKv7YHCWtQOMRYjbH6jsAIQ3+6+vRbc87BpRnrtYkPyGoBT9P06X4pvZ4Nhap7Z/CPiN5Dtq53x+TAW5LZsO9f5K4DmBtT75+wpxELiagCvNMaQmWFrvxTdy5mEz+ZOUiGy4lA3nb0sTgsd7hmTBz72tNFZuKS4UfwYEqT2Ca9PSyCciU6EBcyIIjoHN7YgL/QA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RNZWKQGlG6igdN3oiEL6LbXwadQjmWfy4tBLSe2WtpgRFHlcA1e7dfBiq94qc1pZ0bDlgL1d13wsQaXKiVWs1P2933Uel5vor3VGraxpIfKk5XPu1F4U0NRuJL+MApn28WZsQn87CAQgUnq/HyzRnf+Rwu7xKvaaGC07lqX3edj79NqxYznYGdcMxU2IoeY0eV0mt+rG/Hu7Jwm2eVeY2OFDYx4ro9VNrJHFzHgRqUezlPLArvTThWHVgXFbUQa59GGADtfoS+0hdbyk0RaHMEOd0ddEWR+RBMLG9c+9PI6tUf5oH5WDimrJ50S1yd+kUj45OvCy9BE2i4vE0ErDmRV4YEcSykgdjjOmTRfNBwb0PgVeQP5YMNDxQ/a35R3yf7BLt8ZFfMMkuIn5b1Wvm59+nlVon6PG3A5CR7/y0kU+fKVLOX7m2EQVzffH6/Fi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 12:59:25.3685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e934eb7f-a7e6-43ed-53c3-08df31057734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF0000001B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB732632
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Give board/ its own kobject and populate it with the board attribute
group. Sysfs paths under board/ stay the same.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 120 +++++++++++++++++++++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |   3 +
 2 files changed, 108 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index af144b92365c..12d70fe5cc3c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2410,11 +2410,15 @@ static struct attribute *board_attrs[] = {
 	NULL
 };
 
+struct amdgpu_sysfs_kobj {
+	struct kobject kobj;
+	struct amdgpu_device *adev;
+};
+
 static umode_t amdgpu_board_attr_visible(struct kobject *kobj, struct attribute *attr, int n)
 {
-	struct device *dev = kobj_to_dev(kobj);
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct amdgpu_sysfs_kobj *board = container_of(kobj, struct amdgpu_sysfs_kobj, kobj);
+	struct amdgpu_device *adev = board->adev;
 
 	if (attr == &dev_attr_baseboard_temp.attr) {
 		if (!amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_BASEBOARD))
@@ -2430,7 +2434,6 @@ static umode_t amdgpu_board_attr_visible(struct kobject *kobj, struct attribute
 }
 
 const struct attribute_group amdgpu_board_attr_group = {
-	.name = "board",
 	.attrs = board_attrs,
 	.is_visible = amdgpu_board_attr_visible,
 };
@@ -4750,6 +4753,71 @@ static int amdgpu_od_set_init(struct amdgpu_device *adev)
 	return ret;
 }
 
+static ssize_t amdgpu_sysfs_attr_show(struct kobject *kobj, struct attribute *attr,
+				      char *buf)
+{
+	struct amdgpu_sysfs_kobj *sk = container_of(kobj, struct amdgpu_sysfs_kobj, kobj);
+	struct device_attribute *dattr = container_of(attr, struct device_attribute, attr);
+
+	if (!dattr->show)
+		return -EIO;
+
+	return dattr->show(sk->adev->dev, dattr, buf);
+}
+
+static ssize_t amdgpu_sysfs_attr_store(struct kobject *kobj, struct attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct amdgpu_sysfs_kobj *sk = container_of(kobj, struct amdgpu_sysfs_kobj, kobj);
+	struct device_attribute *dattr = container_of(attr, struct device_attribute, attr);
+
+	if (!dattr->store)
+		return -EIO;
+
+	return dattr->store(sk->adev->dev, dattr, buf, count);
+}
+
+static void amdgpu_sysfs_kobj_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct amdgpu_sysfs_kobj, kobj));
+}
+
+static const struct sysfs_ops amdgpu_sysfs_ops = {
+	.show = amdgpu_sysfs_attr_show,
+	.store = amdgpu_sysfs_attr_store,
+};
+
+static const struct kobj_type amdgpu_sysfs_ktype = {
+	.sysfs_ops = &amdgpu_sysfs_ops,
+	.release = amdgpu_sysfs_kobj_release,
+};
+
+static struct kobject *amdgpu_board_kobj_create(struct amdgpu_device *adev)
+{
+	struct amdgpu_sysfs_kobj *board;
+	int ret;
+
+	board = kzalloc_obj(*board);
+	if (!board)
+		return ERR_PTR(-ENOMEM);
+
+	board->adev = adev;
+	ret = kobject_init_and_add(&board->kobj, &amdgpu_sysfs_ktype,
+				   &adev->dev->kobj, "board");
+	if (ret)
+		goto err_put;
+
+	ret = sysfs_create_group(&board->kobj, &amdgpu_board_attr_group);
+	if (ret)
+		goto err_put;
+
+	return &board->kobj;
+
+err_put:
+	kobject_put(&board->kobj);
+	return ERR_PTR(ret);
+}
+
 static void amdgpu_pm_npm_sysfs_init(struct amdgpu_device *adev)
 {
 	static const struct {
@@ -4763,7 +4831,7 @@ static void amdgpu_pm_npm_sysfs_init(struct amdgpu_device *adev)
 		{ &dev_attr_npm_status, AMDGPU_NPM_CAP_NPM_STATUS },
 	};
 	u64 cap = amdgpu_dpm_get_npm_cap(adev);
-	int i;
+	int i, ret;
 
 	if (!cap)
 		return;
@@ -4776,8 +4844,12 @@ static void amdgpu_pm_npm_sysfs_init(struct amdgpu_device *adev)
 			continue;
 
 		attr->attr.mode = ((bits & BIT(1)) && attr->store) ? 0644 : 0444;
-		sysfs_add_file_to_group(&adev->dev->kobj, &attr->attr,
-					amdgpu_board_attr_group.name);
+		ret = sysfs_create_file(adev->pm.board_kobj, &attr->attr);
+		if (ret) {
+			dev_err(adev->dev, "failed to create sysfs file %s\n",
+				attr->attr.name);
+			return;
+		}
 	}
 }
 
@@ -4848,18 +4920,27 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_GPUBOARD)) {
-		ret = devm_device_add_group(adev->dev,
-					    &amdgpu_board_attr_group);
-		if (ret)
+		struct kobject *board = amdgpu_board_kobj_create(adev);
+
+		if (IS_ERR(board)) {
+			ret = PTR_ERR(board);
 			goto err_out1;
+		}
+		adev->pm.board_kobj = board;
+
 		amdgpu_pm_npm_sysfs_init(adev);
 		if (amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_UBB_POWER_LIMIT,
 						 (void *)&tmp) != -EOPNOTSUPP) {
-			sysfs_add_file_to_group(&adev->dev->kobj,
-						&dev_attr_baseboard_power_limit.attr,
-						amdgpu_board_attr_group.name);
-			sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr_baseboard_power.attr,
-						amdgpu_board_attr_group.name);
+			ret = sysfs_create_file(adev->pm.board_kobj,
+						&dev_attr_baseboard_power_limit.attr);
+			if (ret)
+				dev_err(adev->dev, "failed to create sysfs file %s\n",
+					dev_attr_baseboard_power_limit.attr.name);
+			ret = sysfs_create_file(adev->pm.board_kobj,
+						&dev_attr_baseboard_power.attr);
+			if (ret)
+				dev_err(adev->dev, "failed to create sysfs file %s\n",
+					dev_attr_baseboard_power.attr.name);
 		}
 	}
 
@@ -4868,6 +4949,10 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	return 0;
 
 err_out1:
+	if (adev->pm.board_kobj) {
+		kobject_put(adev->pm.board_kobj);
+		adev->pm.board_kobj = NULL;
+	}
 	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
 err_out0:
 	if (adev->pm.int_hwmon_dev)
@@ -4878,6 +4963,11 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 {
+	if (adev->pm.board_kobj) {
+		kobject_put(adev->pm.board_kobj);
+		adev->pm.board_kobj = NULL;
+	}
+
 	amdgpu_od_set_fini(adev);
 
 	if (adev->pm.int_hwmon_dev)
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ba8624d28f28..698e0def69be 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -23,6 +23,8 @@
 #ifndef __AMDGPU_DPM_H__
 #define __AMDGPU_DPM_H__
 
+struct kobject;
+
 /* Argument for PPSMC_MSG_GpuChangeState */
 enum gfx_change_state {
 	sGpuChangeState_D0Entry = 1,
@@ -387,6 +389,7 @@ struct amdgpu_pm {
 
 	struct list_head	od_kobj_list;
 	uint32_t		od_feature_mask;
+	struct kobject		*board_kobj;
 };
 
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
-- 
2.46.0

