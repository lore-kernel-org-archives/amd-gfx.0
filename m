Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13928C001B0
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 08:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E64610E159;
	Tue, 15 Aug 2023 08:43:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A3D10E065
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 08:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUq2ytlJEG0addhqJKdaziNboBc/tSwfY6lsVS558pFPzYNI0P/66EgCf3xlfApo98w4UU7dBaPaB+M+TTg7mi1jipFFyDjTvG3OJWOzoF5G74ENhc6g8R1atASKOM/+IhluS06/tBAKuCBYrk0coYnp3gKj1KQ9UtDNZwogdMF0aFuYP578WBvFi6QxdsOu10QZcn5+wktrdqs0QTV9WUmhE10pOXhZy+LuFchIbow5Nf8wu+aqQsgliq0cqayGgN0ZmWrwzdfjktYOBN0qI03vK7ZX8Nb7qsvXKWGkzUHg0zR3S03gxR1uP/J/RZwdUrHHH+Z0QiturPf9s1hxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g+rdhbgG4cDMFdkHqYS8TuHr3IMsUfcjb/72ef75KI=;
 b=irqztHnKdoE47y9QBQ45Q2KF2dvsOgWTCb7DGYFhDbAN47M6os1uyPjDg86/UFZZMYKjWrWg+54N0nTic2xM9kFhM22EeMaRzJA7wmgcvRI6Y0Q/n7V5zgedyROLhfn4TL9R3KZamnXEv+ZIk15N2LTi6b/V3h8318YfUteXxPIkD1TW10jsWnuYc8e9+CHNBWKH30QZfrzLisE00n67hM+p8C4KcmIHiHQJf+kEh2Xo1UYfHxysJ7R1Gi3HpJ/g4IBTzxEKAgFbmyJgxQWrgGi4ETCCCFARjU/LEwl63fjs2ZZk7SIB4ieBtxCD0HXByK08YHRAkEkhswqhrqUwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g+rdhbgG4cDMFdkHqYS8TuHr3IMsUfcjb/72ef75KI=;
 b=H497YyF8Xl76B4NOypVY66fCH0LPvIolM+TVk9VcmvdOFXw1o8nLpU9VAzVH0f4+OCughhNfwQAKyoEEkIoGzQybhfTWB7Ym7hPGWljCDL58kJKnNT6tv9+1UTq9rYrkJSG/E4GAizIQoB4chjaH4RlERfYMIocw4Du8gz/TUG0=
Received: from SJ0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:a03:2ef::6)
 by MW4PR12MB7381.namprd12.prod.outlook.com (2603:10b6:303:219::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 08:42:57 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a9) by SJ0PR03CA0181.outlook.office365.com
 (2603:10b6:a03:2ef::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 08:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 08:42:57 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 03:42:54 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amd/pm: introduce a new set of OD interfaces
Date: Tue, 15 Aug 2023 16:42:24 +0800
Message-ID: <20230815084231.3229009-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815084231.3229009-1-evan.quan@amd.com>
References: <20230815084231.3229009-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MW4PR12MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: a1431859-93b4-46d0-637d-08db9d6b9ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAyQhG9GNqoyjk13sQ02apkhaT3shuhCvP7AHnjTF7QVVB2Vmn4uxFbu9zE8Y5soNBwq7EGMmO0qJ/2XlA278UB7I906u2eXoGVbMrdDsfRB6qQuGyNCfE1Q8KeqvRLpnwuY4u/vW2Fko6m++hFfOwUwoE09c4jqN+09ef9kYee6jeQefVC3tEFsgGDMvwenFtiH18wI0gMQHCQtkpK7yvPtJUCr9hUdwWNvT068QeJON+5VWwMZQTBUEOP14UMChpmB+qOdrkA/QYKOxNemQDN0vadhfKMJ0O/LRYhykUtqvl4pZwWGKhKACkR7zr1gDO5SvXde5y+oTrulY30go2odqkDtp3rpJQyvJ8ypJ+MoxLZ2UrZK+b0GW3oWQqQ4O2AcsZaOCo9Vmq4jpBdS809SB3G3cazqLOn0g5SYH3sCOMSnXJVrlkYAB82nF0yFjmUrIZSubPb9HbYA/tshcYHFTL3zAbwtgDxKqEvn3pxRTZAwENL6F7asQuJHTDycSzocTMfB0igVz6zacpwB1BPf9NM4El8LubyCJNu5PeMYjdEPWtxx5e5zi41NUSLQ/fmKCxSZy8ZCXhZgZJY6i3s6/rB2xiNNvrSfUQTY3niim6pC3VwNM876Pag1H7DF2cexjuHVYs6ot+3vRdS4CyKuqgbLrDrxrXR633usCK5pnrYJ0Ew0vV2zdFQG/ug2hjvCWXJIKv5K2s87eNxHK2Poni9t5q7DF8HRxVhscpqnfTyppaXE4enDmA1NZacEIvgN0DhRRs2K67dS2bLA+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(1800799006)(186006)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(16526019)(26005)(1076003)(8936002)(336012)(41300700001)(8676002)(70206006)(70586007)(316002)(36860700001)(2616005)(47076005)(83380400001)(426003)(7696005)(81166007)(478600001)(40460700003)(40480700001)(54906003)(44832011)(36756003)(6666004)(86362001)(6916009)(4326008)(82740400003)(356005)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 08:42:57.2805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1431859-93b4-46d0-637d-08db9d6b9ffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7381
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
index 6809bf7dae57..77eb18447e82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3622,6 +3622,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	INIT_LIST_HEAD(&adev->ras_list);
 
+	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
+
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
 	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5aed023f7402..9352c0fbb09f 100644
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
@@ -3475,10 +3513,216 @@ static const struct attribute_group *hwmon_groups[] = {
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
@@ -3517,15 +3761,31 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
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

