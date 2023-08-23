Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023C1EE49AE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 06:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E8610E060;
	Wed, 23 Aug 2023 06:35:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257B610E060
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 06:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYdeLQwzdRrBxs8shvu+9d48Owgg4TywHsUkvzzM3yjNz81nOYE0zB+z5uZtP/6SajeXC7lbbOXiz5CV24wJqTliVNBC2cBzDoqMCK+4Tzw1fB3ldZIvtVP3SR3vjlwQUNa1QFS4PzHchBngEnhPA6zMtacSiQIdLq506RJtwxiGvH8qZE8v8PjR4YZgz+J6kX7A4Enp0pVYJKh/HRpzo+sN2EWoHRtrkg8rpTPpn/YTmAtw33V8vJZdS6Y9XLBo0ikR9nvT+bNN+yTBgHQ+dKjj7e022lR9XemTr589dDttQGp49UrIoM7+CbguNVyHnCQbPblA0Ejxfq6ZtOXzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BI+PIYMfu/tZM9JNNqNmA/IPkKnP5nKJtfVsnsRRtE8=;
 b=aLFmgrrBNzQUgpc5kA7LSMWA1bgvYh7+8HDTG2HvI2jDpcMcT9Jbjr7+P3e4YktY9kFBkxwIhQ0sxd6+3uq9aLPaTYMB6mWdxSf4naheDSuvSQHEWozBvfHwmHIu2mTzPSPBVbbiAdkhi3szc7kXB+YNrmUZYS+57YjjAsYsnLu2Sfe+OS+bsLCLdjWlJXuUz/DPTBs2sk7DFkPQQyamQVkkGNwme1KGER/jHesVfJv5vAclEus2F+BqCQN+pfm71qw9NQF3c+N7x0W6glA8xwjhpiY+39M9VhBpB+K5k2eXdWjTBndTmXp4MQqLqsMgMCKznSKzlB82G51ftUmWtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BI+PIYMfu/tZM9JNNqNmA/IPkKnP5nKJtfVsnsRRtE8=;
 b=Ji/poBYp2YQXTepur9A4hcPnDzx82Ej3FCy8d6r/uzpi3p9huiAhlrxQQUuCd+EegIuASDPc3cLDweTD60NrI60wmOHw6nFqx91lT44y02o6mDpm8bhVmz/V27p1pKbfbD5jyeQHkcQeXEXw8TH8dr/tpXHYYHX6O7s7/FZeS+k=
Received: from CY5P221CA0080.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::28) by
 CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Wed, 23 Aug 2023 06:35:33 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::a7) by CY5P221CA0080.outlook.office365.com
 (2603:10b6:930:9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 06:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 06:35:32 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 01:35:25 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V2 1/8] drm/amd/pm: introduce a new set of OD interfaces
Date: Wed, 23 Aug 2023 14:33:59 +0800
Message-ID: <20230823063406.1195151-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CH3PR12MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3fc731-5fd5-4411-b87b-08dba3a326e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNvcIbhA1pBdrDlsHtJSzZQxO4r4d6uWVAbYLgCnbt8rRCl+NQs2KL66AD5Xbbq3som5anXYpSkxCr7/IriC4Wg+2Dry5PRkN3EpirENkCjt1QyAYt+phWVJfwCr5ZpXoaFUR+xsa8GSKazLjQEg4/SP9bfoytDJKRmEvVnTLc5ylKzJE8pNqYbNomYJPu/G+8VBGFkrWYT+EefZhV4pB1z6DbEypk8YxJ8yz5bPc0q8aIOcSA89KwG/1fRMP+ndFZgE50wPUknLLoKm4bR0RKNwqfqHFZKmhTq7zJai8WaO83ZEMWLwoOIp5CIfnO/JpLKbz745CiYqPfek1LE0M3xpZVNtkIxNQS6VzAQe9CZqhwtkEJ30Fqq9CUSvM6DVcFzO5esb3WB24EFsiplMNkXpT0Eu2Zm7d9gTaQKtRnY7GB6kX/fRDw1pw6KRJgjb2edSpe8qLOAWD949DNHrc7RFF/PfV6amxGuWw1PApstJhTonoKeeRHkP18SAR0sUHFMYn+pKkSmmZLoSIta/Czjj/rLVGD7rc9rbqg9dTX0RmGg35oe7xCg80OO4teJJF4D3ahMJqFtC127lHkV3QW95DsKr7XjBbsn+ZSLgdWRkvGraaicf76Pxh/IUNcCORpnz/b1EGUq1GT2kmnVGTfqosSqBsbOCCx7Vl/FknZnTts52XCSjCISaN308s5WO9L9Y94uAzcu6ZfZkxZHRMW9IYSWVBbNew9/3lcW+cWrGfC7wYM3oyVBS8BTRer2h9wAiHdU5taW7C5EpMqiMuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(2906002)(40480700001)(83380400001)(5660300002)(44832011)(426003)(336012)(16526019)(26005)(36860700001)(86362001)(47076005)(7696005)(8676002)(2616005)(8936002)(4326008)(316002)(70586007)(6916009)(54906003)(70206006)(478600001)(81166007)(82740400003)(356005)(6666004)(40460700003)(36756003)(1076003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 06:35:32.9705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3fc731-5fd5-4411-b87b-08dba3a326e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075
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
index 533daba2accb..7aae2801b36e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3623,6 +3623,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	INIT_LIST_HEAD(&adev->ras_list);
 
+	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
+
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
 	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b0ef3d8b0ecf..beb3303fc832 100644
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

