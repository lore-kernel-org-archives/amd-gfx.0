Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B5F606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=txdYwX72
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674B1112C76;
	Fri, 23 Oct 2026 17:13:02 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869E710E617
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 12:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GE1yDVFnSMCKV8V8LkI3hFMD4Tb70e4yPP6nmvvn+0KP/EPTjtTaFiqcwwTU6BHDh+mEGOc1ONr2eZuEtsZv97Pz3Ro9Os+EhekoKR4JjOvFbY/F9NweBjdxt0JJx44dvJzes5uKagi+2o9ZkBubLxxit95mCZFJiu0bMIHjh6BDgcEBB7OfeA4caVYznZhNYqgvx97DBnjWIp/85BBJ1hlRqlSvLr0r6GIRwbXIAUf29F/RSlcMrUz0+0AYGC5C3g1H2JoXE7eQqPlU+dx/543WLe2Cx9X1xIopb8aCBlAnE95KHRYn1VitbnMG6r9t2qNW+tVftGnavxh30/HJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrE2QS5ml2l0UMYQYkIyFEOupIq1B8Xv1/AjSSC9Vvw=;
 b=Ip62LKrqPA0MjaP7BXV9B+MwzzVwKE7rQMkW0ydRiDgHEVPP3TkfumSZFfl5zRBOAEGK18VYI5qmJFdzlINm7hbrxAZY1bE18o/CivYUGGWMQyD+lIjCtvtSFjeKma3G15ZnOIG7esWxFo0HFHQtQ8uBknLlPShz/f62h6GvN6rgerzmaRrK57q75JlagnR/BgmHBuvouvQEThXvNmCa+gh1tttjHOYGEcG/jMnrrNCz2UnGoMWkzyYFY486zyviESW3V5cg3YsEaYaw3T9ybIxRkr5RzNDLip2di7o+MtvEswPUEeajLIF3Gn24/U2nk8Kzspj+6bR1uoYQnJt81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrE2QS5ml2l0UMYQYkIyFEOupIq1B8Xv1/AjSSC9Vvw=;
 b=txdYwX7213v4vGPpVYE97yQKYN+pi5nCI4C/f11++B/z2Tr3lIDRBv5pMp+YRxf/lSsdTrYR75evwPriAJE1l8dQPpBqh3Bql2mnkcJRFq26F8w/sbhWzQjsicfXjx9ARenzBoLA6lSCTfJ7Y/fus9Sr/sDEluqQuHJKNTz1N/k=
Received: from CH0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:610:11a::15)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 12:59:26 +0000
Received: from CH7PEPF0000001B.namprd21.prod.outlook.com
 (2603:10b6:610:11a:cafe::d) by CH0PR03CA0353.outlook.office365.com
 (2603:10b6:610:11a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 12:59:26 +0000
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
 15.21.569.0 via Frontend Transport; Fri, 23 Oct 2026 12:59:26 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 07:59:23 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Place NPM sysfs files under board/npm
Date: Fri, 23 Oct 2026 20:59:06 +0800
Message-ID: <20261023125907.3229593-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261023125907.3229593-1-asad.kamal@amd.com>
References: <20261023125907.3229593-1-asad.kamal@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001B:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: fa971664-13e5-4552-e7ba-08df310577ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|11063799006|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: MVcwA8OJCCAcYif+mIGekzWem+tXWDBtDn8w1NNMLYibNEoWwunUYGzbRJIDfdAKkn8/a8cKo+UdbmoOfV1+PY9UOoEFnumVk+L2ueW9tN1ym4epb0Kq47ilQLrEpq3N3B9iNaFY5/DiQVG49Qkl9CqL0GDU0N/hhA09cWBaW4C9hdQ3A//+4lu5wZ5/XN+cfYXgeGAzWSPcPvtk82oeZioLwW7YbZYO29HzrottIhyKQ9NlbI2fJAit/S6iMPaeKMQdABzgl8zot5ivJGuHg+zC4NUzsPRfylNJxndkY/hWmLpiClXRwyRRlSbEsTQ7UwLvrp1UzX4DH1X67uyU/J00ywLuXh1uRcCPR5mrhRLuEQwduw2AyS8UuwgPyO62mVL5cWUTSSeXL9ON2vfFEgfAMi12kCXynjxMolUx5xgYLDR83G0OSprFaKvc7KQySFgCRuK+CvXJi6wWR4qBC7fdapxqSWS8+zEu10qIgtDUu7PU+SvIthozhlSrIZ4qaXVS7KQzbh5ryOc6LS68F9WxzT8Yi0ZHL+PiWIgeAQqONp2J58rLYzNXzWuszWWb1MPtjVO1MLV/jYT/r/AEdzaCvup9/wWnd4AqAKnoahNc1voZ8hbxctKp/F7JhXSFdAexKuP1Tk30IDlnw9iqDogeUvSA473iTv+wzptsG+o4HwiJJrmApdnwwftXgExW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 64zdWF0POl26Gi0G756z+KXzc7ofrlv+whk4LQ0ASqBBzq94lVcWzx0wtTLyKsRVL96RqQVT/N4Y5V8dBuZW7D06+teJiUnfoYfarA8C660LtVFItzMnTgi7jbx/o2MZ6E5FzTdg6hM1+mIS42GfhYH9ZugA+6i6WUDB/Naywd8nbB2CscsB6LLo9H6lMmwWDO0OwSWh/eBukgAvEOfWQkCgxNU/Q9XZl/xgUb3Dd9P/NFZueldaoN++jRsewR/6IemmlJTkj48jPj6TbTpVMg5l4ljD17hrIJnkKWgIdqS2C9kvBNVkuHUGhde4bXhD8QwE7YRcPlOOrdoTWbLs6qBKYw/2bNFrTrM7wslPPA7T/o+y7PJZZsxk9RPolL/QPcQpJVeNRYE2zlU4BJ7bFAfXdQsYclfS7ecPeOhwFm0SQi+rIL6iH3GIJt5KpONR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 12:59:26.3823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa971664-13e5-4552-e7ba-08df310577ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF0000001B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
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

Create board/npm/ when AMDGPU_NPM_FLAGS_DIR is set and put the NPM
files there. Devices that do not set the bit keep those files in board/.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 71 +++++++++++++++----
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 3 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 7db44fa24042..45d68ffe6c59 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -190,6 +190,8 @@ enum amdgpu_npm_cap_field {
 #define AMDGPU_NPM_CAP_R(field)	BIT_ULL((field) * 2)
 #define AMDGPU_NPM_CAP_W(field)	BIT_ULL((field) * 2 + 1)
 
+#define AMDGPU_NPM_FLAGS_DIR	BIT_ULL(63)
+
 enum amd_pp_task {
 	AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
 	AMD_PP_TASK_ENABLE_USER_STATE,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 12d70fe5cc3c..d2babb99bda4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2109,7 +2109,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
  * nine types of attributes are reported. Baseboard temperature and
  * gpu board temperature are reported as binary files. Npm status, current node power limit,
  * max node power limit, node power, global ppt residency, baseboard_power, baseboard_power_limit
- * is reported as ASCII text file.
+ * is reported as ASCII text file. When NPM files are grouped, they are under
+ * board/npm/. Otherwise they are directly under board/.
  *
  * * .. code-block:: console
  *
@@ -2117,15 +2118,15 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
  *
  *      hexdump /sys/bus/pci/devices/.../board/gpuboard_temp
  *
- *      cat /sys/bus/pci/devices/.../board/npm_status
+ *      cat /sys/bus/pci/devices/.../board/npm/npm_status
  *
- *      cat /sys/bus/pci/devices/.../board/cur_node_power_limit
+ *      cat /sys/bus/pci/devices/.../board/npm/cur_node_power_limit
  *
- *      cat /sys/bus/pci/devices/.../board/max_node_power_limit
+ *      cat /sys/bus/pci/devices/.../board/npm/max_node_power_limit
  *
- *      cat /sys/bus/pci/devices/.../board/node_power
+ *      cat /sys/bus/pci/devices/.../board/npm/node_power
  *
- *      cat /sys/bus/pci/devices/.../board/global_ppt_resid
+ *      cat /sys/bus/pci/devices/.../board/npm/global_ppt_resid
  *
  *      cat /sys/bus/pci/devices/.../board/baseboard_power
  *
@@ -4818,6 +4819,43 @@ static struct kobject *amdgpu_board_kobj_create(struct amdgpu_device *adev)
 	return ERR_PTR(ret);
 }
 
+static void amdgpu_pm_kobjs_fini(struct amdgpu_device *adev)
+{
+	if (adev->pm.npm_kobj) {
+		kobject_put(adev->pm.npm_kobj);
+		adev->pm.npm_kobj = NULL;
+	}
+
+	if (adev->pm.board_kobj) {
+		kobject_put(adev->pm.board_kobj);
+		adev->pm.board_kobj = NULL;
+	}
+}
+
+static struct kobject *amdgpu_npm_dir_create(struct amdgpu_device *adev)
+{
+	struct amdgpu_sysfs_kobj *npm;
+	int ret;
+
+	if (!adev->pm.board_kobj)
+		return ERR_PTR(-ENOENT);
+
+	npm = kzalloc_obj(*npm);
+	if (!npm)
+		return ERR_PTR(-ENOMEM);
+
+	npm->adev = adev;
+	ret = kobject_init_and_add(&npm->kobj, &amdgpu_sysfs_ktype,
+				   adev->pm.board_kobj, "npm");
+	if (ret) {
+		kobject_put(&npm->kobj);
+		return ERR_PTR(ret);
+	}
+
+	adev->pm.npm_kobj = &npm->kobj;
+	return &npm->kobj;
+}
+
 static void amdgpu_pm_npm_sysfs_init(struct amdgpu_device *adev)
 {
 	static const struct {
@@ -4831,11 +4869,20 @@ static void amdgpu_pm_npm_sysfs_init(struct amdgpu_device *adev)
 		{ &dev_attr_npm_status, AMDGPU_NPM_CAP_NPM_STATUS },
 	};
 	u64 cap = amdgpu_dpm_get_npm_cap(adev);
+	struct kobject *npm = NULL;
 	int i, ret;
 
 	if (!cap)
 		return;
 
+	if (cap & AMDGPU_NPM_FLAGS_DIR) {
+		npm = amdgpu_npm_dir_create(adev);
+		if (IS_ERR(npm)) {
+			dev_err(adev->dev, "failed to create npm sysfs directory\n");
+			return;
+		}
+	}
+
 	for (i = 0; i < ARRAY_SIZE(files); i++) {
 		unsigned int bits = (cap >> (files[i].field * 2)) & 0x3;
 		struct device_attribute *attr = files[i].attr;
@@ -4844,7 +4891,7 @@ static void amdgpu_pm_npm_sysfs_init(struct amdgpu_device *adev)
 			continue;
 
 		attr->attr.mode = ((bits & BIT(1)) && attr->store) ? 0644 : 0444;
-		ret = sysfs_create_file(adev->pm.board_kobj, &attr->attr);
+		ret = sysfs_create_file(npm ? npm : adev->pm.board_kobj, &attr->attr);
 		if (ret) {
 			dev_err(adev->dev, "failed to create sysfs file %s\n",
 				attr->attr.name);
@@ -4949,10 +4996,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	return 0;
 
 err_out1:
-	if (adev->pm.board_kobj) {
-		kobject_put(adev->pm.board_kobj);
-		adev->pm.board_kobj = NULL;
-	}
+	amdgpu_pm_kobjs_fini(adev);
 	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
 err_out0:
 	if (adev->pm.int_hwmon_dev)
@@ -4963,10 +5007,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 {
-	if (adev->pm.board_kobj) {
-		kobject_put(adev->pm.board_kobj);
-		adev->pm.board_kobj = NULL;
-	}
+	amdgpu_pm_kobjs_fini(adev);
 
 	amdgpu_od_set_fini(adev);
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 698e0def69be..550d11fd7ffb 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -390,6 +390,7 @@ struct amdgpu_pm {
 	struct list_head	od_kobj_list;
 	uint32_t		od_feature_mask;
 	struct kobject		*board_kobj;
+	struct kobject		*npm_kobj;
 };
 
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
-- 
2.46.0

