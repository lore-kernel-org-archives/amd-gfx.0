Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29E0C83F01
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 05:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3665A10E0D0;
	Wed, 30 Aug 2023 05:57:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F9D10E0D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 05:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVTJigvBeibX64qIn37J0K55DlYnp45Qt2Z6w/89RtPt4m1Fl1O5GXnxpfPaIgjIHP6awcP/4S5kcYHpYuRYA4SZ7UelDQ8ESVNVXXL40EVjlh66r6YVWni6AiL584tYD10zIzqj04SKvIgyYzIsWXFmD9yaxoLe0xz+cEFSWlxdvC9ezve+i9R9k4DgbwISIl5cZwc97M2Ul50/kHDCuNfj0R7qePV/JS83zbkZ9mRJ8i+qIQg4OC9hJ0fxdnsc7UbfuYUDI9J2ozUm9rprmme8GEKAfXSXGzX0pmZM0bjVEX62djrzBbaGKf2PKrpBKq+MGkQLgQVZ5W8AryEWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSME0dAu0Qufz+ZCazk7c5DqMcJIULz/twc2jm6Y66w=;
 b=Mm0J1G1VH54imuCEi++pLYKyzewYJWyMtjjAbtTgfaTuTzIdwwBmbxCV27d8SJcwORB5PvLRNqcGRpFLu4JcKQpQ2T2QLsBulE8sAbCOlOQJd/cMbeRn17lH7Wb0SpVsy63Tu3eJcFChj4Mzf8WPzcHdd6iXVbMjdFYUydB+mfB5+fWUCv7YGQYdOm6pFn8jh775TxaVDSuy1ax09AYal+cIlISOfosMTRJccPbFh9DOIYQJV+ogXpaldErIAMVgvfN9F/ObObRUCOVQceg5DpNCpeON88yBA81U/1VEbGtdnvTIUmFiGgLINxi4MYpXqiZoWvkMrhC7unlsoIwaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSME0dAu0Qufz+ZCazk7c5DqMcJIULz/twc2jm6Y66w=;
 b=YosjFy1E+zif32WKVRBApD4Q6rBkpF2zfIEwZFDIjHro1FyH1SV9XQIBfIMAWYRZ+ttDKCBodjJJl4JhpDc+kuP/NhmKzlTUmuEXe8y+oF2vojNxrrAFuMT6C/P7gyelunW7Ws+MtEUMH8IA/3mWVtAbcyOrklccVPbs65B8/KE=
Received: from CYXPR02CA0088.namprd02.prod.outlook.com (2603:10b6:930:ce::11)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 05:57:17 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::7e) by CYXPR02CA0088.outlook.office365.com
 (2603:10b6:930:ce::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 05:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 05:57:16 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 00:57:02 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V3 1/7] drm/amd/pm: introduce a new set of OD interfaces
Date: Wed, 30 Aug 2023 13:56:42 +0800
Message-ID: <20230830055648.477908-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830055648.477908-1-evan.quan@amd.com>
References: <20230830055648.477908-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ae5577-e091-4319-6715-08dba91df715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 802CCibOi4iFtHwXVBVz6A+x+qpufsLJAmy2lqAUiRaN9m8YDTfe0F94us5Gef/P/iolMwzI0xjaQdQa/EUqqD2xJqUGW8kPK++IDXFLaCSh/6sjoncajr/iHiIuxAritMADXki5f6rsjXoY8cwWbscIkYCIJ0HEenB5+SGw7AHBksqFe7PI+A5ZB7bT9k5o002EuNhTZx4wOZWpQmTgZ6SlkgxPzGnu9lskxAh28uA8mDrQIHqwx9+pmOIRVCTVwnF9bXOLt+4ej9nnT51pUEcHhoqAQtm0hZv39RurVimH35XJ+qXWZ4zUFPfWh5PVSPeWcGu3iB9/1zYR/bZVdrlSyZzPXm1o4xfrG8RysnBhHxP6WdbwRbuI9+wVH7VT3JmJ2nZzGrN4rRhhD39TPep875Yh/DZ07SHMC4AN8W4LzAVm/8bL95XevpL25AD7n/9LmrYSMpiEmttjNZ/kTUBDuJHDfu0sOWkGrsUBzPHg4mFPx+wMjftozPWCjMwZFjtVVL7df7eBykGdAgvcI+q6kUbyVYqVnwWml4sJ86K68jbgUhSRyh/jFhy3hf3f8M/0vmZBP4i6mA7orJ07Q+hmJ0oefFWsN6AdfpfWPswF3goy0NUPh4m56I2Nm4Xsmp4r2RNPLWOkFz2cVNBn+3zwgmrqVql3ZoR1UTYElR3RrqxSpwGW36OkA+K0bRnOeZxtbUWhY9AW5dYqxixiE1zFD0zMZaO9Oe/nqrT4s2tVZ3abZW6lO7qyrj6T+lrjXlW8MBko8+TolVFIkTv1MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(356005)(81166007)(82740400003)(8936002)(6666004)(478600001)(70206006)(7696005)(70586007)(54906003)(6916009)(316002)(41300700001)(40460700003)(26005)(5660300002)(36756003)(1076003)(16526019)(44832011)(8676002)(2906002)(86362001)(2616005)(36860700001)(40480700001)(83380400001)(426003)(47076005)(336012)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 05:57:16.6484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ae5577-e091-4319-6715-08dba91df715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There will be multiple interfaces(sysfs files) exposed with each representing
a single OD functionality. And all those interface will be arranged in a tree
liked hierarchy with the top dir as "gpu_od". Meanwhile all functionalities
for the same component will be arranged under the same directory.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c         | 264 ++++++++++++++++++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |   2 +
 3 files changed, 266 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b2bc5eb31a90..e588cf7a14f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3624,6 +3624,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	INIT_LIST_HEAD(&adev->ras_list);
 
+	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
+
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
 	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 06aa5c18b40f..edb52697c489 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -35,6 +35,44 @@
 #include <linux/pm_runtime.h>
 #include <asm/processor.h>
 
+#define MAX_NUM_OF_FEATURES_PER_SUBSET		8
+#define MAX_NUM_OF_SUBSETS			8
+
+struct od_attribute {
+	struct kobj_attribute	attribute;
+	struct list_head	entry;
+};
+
+struct od_kobj {
+	struct kobject		kobj;
+	struct list_head	entry;
+	struct list_head	attribute;
+	void			*priv;
+};
+
+struct od_feature_ops {
+	umode_t (*is_visible)(struct amdgpu_device *adev);
+	ssize_t (*show)(struct kobject *kobj, struct kobj_attribute *attr,
+			char *buf);
+	ssize_t (*store)(struct kobject *kobj, struct kobj_attribute *attr,
+			 const char *buf, size_t count);
+};
+
+struct od_feature_item {
+	const char		*name;
+	struct od_feature_ops	ops;
+};
+
+struct od_feature_container {
+	char				*name;
+	struct od_feature_ops		ops;
+	struct od_feature_item		sub_feature[MAX_NUM_OF_FEATURES_PER_SUBSET];
+};
+
+struct od_feature_set {
+	struct od_feature_container	containers[MAX_NUM_OF_SUBSETS];
+};
+
 static const struct hwmon_temp_label {
 	enum PP_HWMON_TEMP channel;
 	const char *label;
@@ -3345,10 +3383,216 @@ static const struct attribute_group *hwmon_groups[] = {
 	NULL
 };
 
-int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
+static struct od_feature_set amdgpu_od_set;
+
+static void od_kobj_release(struct kobject *kobj)
+{
+	struct od_kobj *od_kobj = container_of(kobj, struct od_kobj, kobj);
+
+	kfree(od_kobj);
+}
+
+static const struct kobj_type od_ktype = {
+	.release	= od_kobj_release,
+	.sysfs_ops	= &kobj_sysfs_ops,
+};
+
+static void amdgpu_od_set_fini(struct amdgpu_device *adev)
+{
+	struct od_kobj *container, *container_next;
+	struct od_attribute *attribute, *attribute_next;
+
+	if (list_empty(&adev->pm.od_kobj_list))
+		return;
+
+	list_for_each_entry_safe(container, container_next,
+				 &adev->pm.od_kobj_list, entry) {
+		list_del(&container->entry);
+
+		list_for_each_entry_safe(attribute, attribute_next,
+					 &container->attribute, entry) {
+			list_del(&attribute->entry);
+			sysfs_remove_file(&container->kobj,
+					  &attribute->attribute.attr);
+			kfree(attribute);
+		}
+
+		kobject_put(&container->kobj);
+	}
+}
+
+static bool amdgpu_is_od_feature_supported(struct amdgpu_device *adev,
+					   struct od_feature_ops *feature_ops)
+{
+	umode_t mode;
+
+	if (!feature_ops->is_visible)
+		return false;
+
+	/*
+	 * If the feature has no user read and write mode set,
+	 * we can assume the feature is actually not supported.(?)
+	 * And the revelant sysfs interface should not be exposed.
+	 */
+	mode = feature_ops->is_visible(adev);
+	if (mode & (S_IRUSR | S_IWUSR))
+		return true;
+
+	return false;
+}
+
+static bool amdgpu_od_is_self_contained(struct amdgpu_device *adev,
+					struct od_feature_container *container)
+{
+	int i;
+
+	/*
+	 * If there is no valid entry within the container, the container
+	 * is recognized as a self contained container. And the valid entry
+	 * here means it has a valid naming and it is visible/supported by
+	 * the ASIC.
+	 */
+	for (i = 0; i < ARRAY_SIZE(container->sub_feature); i++) {
+		if (container->sub_feature[i].name &&
+		    amdgpu_is_od_feature_supported(adev,
+			&container->sub_feature[i].ops))
+			return false;
+	}
+
+	return true;
+}
+
+static int amdgpu_od_set_init(struct amdgpu_device *adev)
 {
+	struct od_kobj *top_set, *sub_set;
+	struct od_attribute *attribute;
+	struct od_feature_container *container;
+	struct od_feature_item *feature;
+	int i, j;
 	int ret;
+
+	/* Setup the top `gpu_od` directory which holds all other OD interfaces */
+	top_set = kzalloc(sizeof(*top_set), GFP_KERNEL);
+	if (!top_set)
+		return -ENOMEM;
+	list_add(&top_set->entry, &adev->pm.od_kobj_list);
+
+	ret = kobject_init_and_add(&top_set->kobj,
+				   &od_ktype,
+				   &adev->dev->kobj,
+				   "%s",
+				   "gpu_od");
+	if (ret)
+		goto err_out;
+	INIT_LIST_HEAD(&top_set->attribute);
+	top_set->priv = adev;
+
+	for (i = 0; i < ARRAY_SIZE(amdgpu_od_set.containers); i++) {
+		container = &amdgpu_od_set.containers[i];
+
+		if (!container->name)
+			continue;
+
+		/*
+		 * If there is valid entries within the container, the container
+		 * will be presented as a sub directory and all its holding entries
+		 * will be presented as plain files under it.
+		 * While if there is no valid entry within the container, the container
+		 * itself will be presented as a plain file under top `gpu_od` directory.
+		 */
+		if (amdgpu_od_is_self_contained(adev, container)) {
+			if (!amdgpu_is_od_feature_supported(adev,
+			     &container->ops))
+				continue;
+
+			/*
+			 * The container is presented as a plain file under top `gpu_od`
+			 * directory.
+			 */
+			attribute = kzalloc(sizeof(*attribute), GFP_KERNEL);
+			if (!attribute) {
+				ret = -ENOMEM;
+				goto err_out;
+			}
+			list_add(&attribute->entry, &top_set->attribute);
+
+			attribute->attribute.attr.mode =
+					container->ops.is_visible(adev);
+			attribute->attribute.attr.name = container->name;
+			attribute->attribute.show =
+					container->ops.show;
+			attribute->attribute.store =
+					container->ops.store;
+			ret = sysfs_create_file(&top_set->kobj,
+						&attribute->attribute.attr);
+			if (ret)
+				goto err_out;
+		} else {
+			/* The container is presented as a sub directory. */
+			sub_set = kzalloc(sizeof(*sub_set), GFP_KERNEL);
+			if (!sub_set) {
+				ret = -ENOMEM;
+				goto err_out;
+			}
+			list_add(&sub_set->entry, &adev->pm.od_kobj_list);
+
+			ret = kobject_init_and_add(&sub_set->kobj,
+						   &od_ktype,
+						   &top_set->kobj,
+						   "%s",
+						   container->name);
+			if (ret)
+				goto err_out;
+			INIT_LIST_HEAD(&sub_set->attribute);
+			sub_set->priv = adev;
+
+			for (j = 0; j < ARRAY_SIZE(container->sub_feature); j++) {
+				feature = &container->sub_feature[j];
+				if (!feature->name)
+					continue;
+
+				if (!amdgpu_is_od_feature_supported(adev,
+				     &feature->ops))
+					continue;
+
+				/*
+				 * With the container presented as a sub directory, the entry within
+				 * it is presented as a plain file under the sub directory.
+				 */
+				attribute = kzalloc(sizeof(*attribute), GFP_KERNEL);
+				if (!attribute) {
+					ret = -ENOMEM;
+					goto err_out;
+				}
+				list_add(&attribute->entry, &sub_set->attribute);
+
+				attribute->attribute.attr.mode =
+						feature->ops.is_visible(adev);
+				attribute->attribute.attr.name = feature->name;
+				attribute->attribute.show =
+						feature->ops.show;
+				attribute->attribute.store =
+						feature->ops.store;
+				ret = sysfs_create_file(&sub_set->kobj,
+							&attribute->attribute.attr);
+				if (ret)
+					goto err_out;
+			}
+		}
+	}
+
+	return 0;
+
+err_out:
+	amdgpu_od_set_fini(adev);
+
+	return ret;
+}
+
+int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
+{
 	uint32_t mask = 0;
+	int ret;
 
 	if (adev->pm.sysfs_initialized)
 		return 0;
@@ -3387,15 +3631,31 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 					       mask,
 					       &adev->pm.pm_attr_list);
 	if (ret)
-		return ret;
+		goto err_out0;
+
+	if (amdgpu_dpm_is_overdrive_supported(adev)) {
+		ret = amdgpu_od_set_init(adev);
+		if (ret)
+			goto err_out1;
+	}
 
 	adev->pm.sysfs_initialized = true;
 
 	return 0;
+
+err_out1:
+	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
+err_out0:
+	if (adev->pm.int_hwmon_dev)
+		hwmon_device_unregister(adev->pm.int_hwmon_dev);
+
+	return ret;
 }
 
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 {
+	amdgpu_od_set_fini(adev);
+
 	if (adev->pm.int_hwmon_dev)
 		hwmon_device_unregister(adev->pm.int_hwmon_dev);
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 42172b00be66..4cab6a2efb63 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -366,6 +366,8 @@ struct amdgpu_pm {
 	struct config_table_setting config_table;
 	/* runtime mode */
 	enum amdgpu_runpm_mode rpm_mode;
+
+	struct list_head	od_kobj_list;
 };
 
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
-- 
2.34.1

