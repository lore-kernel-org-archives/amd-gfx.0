Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DBDC433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 04:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472DC206DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 04:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dbX3myDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472DC206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8FD89C25;
	Tue, 18 Aug 2020 04:30:53 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770085.outbound.protection.outlook.com [40.107.77.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB47689C25
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 04:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDsBKQhwcMIBzeYRz6i6EWRliNM4/CzSF8j1IPqxVtQqupydjp3ptz/F3Ocum1BnZecgsOwQKQoDkSiysrx60KZAzo7xzoGYYw5NlZMPWHfOsGzNTw2xbCFJNb6X1gbWCU9pPkl7eXhprpQqdJ5crh7uFFmxzjmLnGsuQ0FZcY0OW5o1xWyC4vLnNwESWHo31PnAEu5fivAc+VTeTkNwJfU0zpq61BYKlGs7H+24Z1Pel0AKBJeN8/g20vqW/2JUASgIlYPLgsjZxZwtt8Rx/dYbs2opTKjHwe1J0rQz5daeq+XlIMg0ZCl52V+ychNdDlL/JoAF9n2XYwJKR/IcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5Noi/0s5suq9QyLrZ3DamGTF64UzXB7Mpl9wTmpSjc=;
 b=FyGVCS25rRzr0YKIQCMnC0CR+hbpuBlXiG/5zZvG+D57Ofa8EbASaYZ4X3MYax6ozaUPCjXkrEGoHM4VmKPbGQ2KNYA90GAmDYBZ4MN/7ad8x50WGITZOgOiQNzc8V07vqAumtfuK0wGVKpXvzBM0aKom2RiejIyYCsYzr73Be34z0vrvHjEQGJ1dGX7lpHyeQ/ItONSlLqSFxUKd5qxt4g8Btkcw9p8jCkUokvelQNozduykMt65xMY1Bm6O9e2rVDX4Hi8/32kIE1b1rPm8ef6r68mvu/7wy4GLKhvef3zmZ1JU+5OLzOKt7Jyi4Pyb0I6WfNKZuxZqO+dyrfKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5Noi/0s5suq9QyLrZ3DamGTF64UzXB7Mpl9wTmpSjc=;
 b=dbX3myDBIlpfcYo45mCEdyD2nbuYOcWvvjIfB4x2kJiYuAKj9aGZ5Bip3vHj8uD7LrTK4tuwdk5oaBON2SKnjMlXJHvqltflolqd7+h2smnglR963dz9MkvggI6pPYXxPW8A7/OWIKGM1d3JYZB/GEVXy3w3/2+kNYD/wC+75c8=
Received: from BN6PR21CA0003.namprd21.prod.outlook.com (2603:10b6:404:8e::13)
 by MWHPR12MB1663.namprd12.prod.outlook.com (2603:10b6:301:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Tue, 18 Aug
 2020 04:30:50 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::8d) by BN6PR21CA0003.outlook.office365.com
 (2603:10b6:404:8e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.3 via Frontend
 Transport; Tue, 18 Aug 2020 04:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 04:30:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 17 Aug
 2020 23:30:49 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 17 Aug
 2020 23:30:48 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 17 Aug 2020 23:30:46 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: refine create and release logic of hive info
Date: Tue, 18 Aug 2020 12:30:38 +0800
Message-ID: <20200818043038.29816-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1ac8477-2022-46b5-9c2a-08d8432f7c0a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1663:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1663FC6F9AC08842D5B00F2CED5C0@MWHPR12MB1663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHoKG9XB++MO+ZJTA2n8PISIdjE3s+R1SD+0ut0lHQ+LZF38lhyRWMAA5HVpApcwzHsuFcN+JmnsXZsiNIEyY5ybYFZECuLx7dPX5xKChmdFUBcWX+wC8X36O28IuPOeoq0osU/tbgmxUpgtG5LqiQoQ3/J0uPhaJjMgVP6gzPCl57L0cwrHsg4Z8xJFx/9ysK9k5EBPIRj/GJVAMuVGncs67ppFfm7E1Efiz5+izANcxr69lg4Ck9+pvkSIjJLvdF1x/SeCIJ2LxZDEiTjWlJGqaazKf9HZfQOGsp0VtaHj0wNZcJ4l5KpZvS5RGdSY4hnh1WeMspbi/n3Ih90lHhXQvttniIpcbt/huXJyZf5jOpjin0ULPZVbiRfFbPsYTZB+uqMMwPOSu/XOov/L5XyIyJ9/IptWmcy5RozPhSI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966005)(36756003)(70206006)(2906002)(83380400001)(70586007)(1076003)(426003)(6666004)(6636002)(478600001)(5660300002)(7696005)(110136005)(81166007)(356005)(47076004)(4326008)(82310400002)(336012)(30864003)(186003)(8676002)(86362001)(82740400003)(316002)(2616005)(26005)(8936002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 04:30:49.6089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ac8477-2022-46b5-9c2a-08d8432f7c0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1663
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change to dynamically create and release hive info object,
which help driver support more hives in the future.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8a55b0bc044a..fdfdc2f678c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2840,7 +2840,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 {
 	struct amdgpu_device *adev =
 		container_of(__work, struct amdgpu_device, xgmi_reset_work);
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 
 	/* It's a bug to not have a hive within this function */
 	if (WARN_ON(!hive))
@@ -2878,6 +2878,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 	if (adev->asic_reset_res)
 		DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
 			 adev->asic_reset_res, adev->ddev->unique);
+	amdgpu_put_xgmi_hive(hive);
 }
 
 static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
@@ -4286,11 +4287,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * We always reset all schedulers for device and all devices for XGMI
 	 * hive so that should take care of them too.
 	 */
-	hive = amdgpu_get_xgmi_hive(adev, false);
+	hive = amdgpu_get_xgmi_hive(adev);
 	if (hive) {
 		if (atomic_cmpxchg(&hive->in_reset, 0, 1) != 0) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
 				job ? job->base.id : -1, hive->hive_id);
+			amdgpu_put_xgmi_hive(hive);
 			return 0;
 		}
 		mutex_lock(&hive->hive_lock);
@@ -4456,6 +4458,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (hive) {
 		atomic_set(&hive->in_reset, 0);
 		mutex_unlock(&hive->hive_lock);
+		amdgpu_put_xgmi_hive(hive);
 	}
 
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5680f7eafcb1..e18606e322e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1514,7 +1514,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_device *remote_adev = NULL;
 	struct amdgpu_device *adev = ras->adev;
 	struct list_head device_list, *device_list_handle =  NULL;
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, false);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 
 	/* Build list of devices to query RAS related errors */
 	if  (hive && adev->gmc.xgmi.num_physical_nodes > 1)
@@ -1525,6 +1525,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		device_list_handle = &device_list;
 	}
 
+	amdgpu_put_xgmi_hive(hive);
+
 	list_for_each_entry(remote_adev, device_list_handle, gmc.xgmi.head) {
 		amdgpu_ras_log_on_err_counter(remote_adev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 67a756f4337b..5315d16539f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -35,11 +35,9 @@
 
 static DEFINE_MUTEX(xgmi_mutex);
 
-#define AMDGPU_MAX_XGMI_HIVE			8
 #define AMDGPU_MAX_XGMI_DEVICE_PER_HIVE		4
 
-static struct amdgpu_hive_info xgmi_hives[AMDGPU_MAX_XGMI_HIVE];
-static unsigned hive_count = 0;
+static LIST_HEAD(xgmi_hive_list);
 
 static const int xgmi_pcs_err_status_reg_vg20[] = {
 	smnXGMI0_PCS_GOPX16_PCS_ERROR_STATUS,
@@ -171,59 +169,47 @@ static const struct amdgpu_pcs_ras_field wafl_pcs_ras_fields[] = {
  *
  */
 
+static struct attribute amdgpu_xgmi_hive_id = {
+	.name = "xgmi_hive_id",
+	.mode = S_IRUGO
+};
 
-static ssize_t amdgpu_xgmi_show_hive_id(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct amdgpu_hive_info *hive =
-			container_of(attr, struct amdgpu_hive_info, dev_attr);
-
-	return snprintf(buf, PAGE_SIZE, "%llu\n", hive->hive_id);
-}
+static struct attribute *amdgpu_xgmi_hive_attrs[] = {
+	&amdgpu_xgmi_hive_id,
+	NULL
+};
 
-static int amdgpu_xgmi_sysfs_create(struct amdgpu_device *adev,
-				    struct amdgpu_hive_info *hive)
+static ssize_t amdgpu_xgmi_show_hive_id(struct kobject *kobj,
+	struct attribute *attr, char *buf)
 {
-	int ret = 0;
-
-	if (WARN_ON(hive->kobj))
-		return -EINVAL;
-
-	hive->kobj = kobject_create_and_add("xgmi_hive_info", &adev->dev->kobj);
-	if (!hive->kobj) {
-		dev_err(adev->dev, "XGMI: Failed to allocate sysfs entry!\n");
-		return -EINVAL;
-	}
+	struct amdgpu_hive_info *hive = container_of(
+		kobj, struct amdgpu_hive_info, kobj);
 
-	hive->dev_attr = (struct device_attribute) {
-		.attr = {
-			.name = "xgmi_hive_id",
-			.mode = S_IRUGO,
+	if (attr == &amdgpu_xgmi_hive_id)
+		return snprintf(buf, PAGE_SIZE, "%llu\n", hive->hive_id);
 
-		},
-		.show = amdgpu_xgmi_show_hive_id,
-	};
-
-	ret = sysfs_create_file(hive->kobj, &hive->dev_attr.attr);
-	if (ret) {
-		dev_err(adev->dev, "XGMI: Failed to create device file xgmi_hive_id\n");
-		kobject_del(hive->kobj);
-		kobject_put(hive->kobj);
-		hive->kobj = NULL;
-	}
-
-	return ret;
+	return 0;
 }
 
-static void amdgpu_xgmi_sysfs_destroy(struct amdgpu_device *adev,
-				    struct amdgpu_hive_info *hive)
+static void amdgpu_xgmi_hive_release(struct kobject *kobj)
 {
-	sysfs_remove_file(hive->kobj, &hive->dev_attr.attr);
-	kobject_del(hive->kobj);
-	kobject_put(hive->kobj);
-	hive->kobj = NULL;
+	struct amdgpu_hive_info *hive = container_of(
+		kobj, struct amdgpu_hive_info, kobj);
+
+	mutex_destroy(&hive->hive_lock);
+	kfree(hive);
 }
 
+static const struct sysfs_ops amdgpu_xgmi_hive_ops = {
+	.show = amdgpu_xgmi_show_hive_id,
+};
+
+struct kobj_type amdgpu_xgmi_hive_type = {
+	.release = amdgpu_xgmi_hive_release,
+	.sysfs_ops = &amdgpu_xgmi_hive_ops,
+	.default_attrs = amdgpu_xgmi_hive_attrs,
+};
+
 static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -285,10 +271,9 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 	if (ret)
 		pr_err("failed to create xgmi_error\n");
 
-
 	/* Create sysfs link to hive info folder on the first device */
-	if (adev != hive->adev) {
-		ret = sysfs_create_link(&adev->dev->kobj, hive->kobj,
+	if (hive->kobj.parent != (&adev->dev->kobj)) {
+		ret = sysfs_create_link(&adev->dev->kobj, &hive->kobj,
 					"xgmi_hive_info");
 		if (ret) {
 			dev_err(adev->dev, "XGMI: Failed to create link to hive info");
@@ -296,9 +281,9 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 		}
 	}
 
-	sprintf(node, "node%d", hive->number_devices);
+	sprintf(node, "node%d", atomic_read(&hive->number_devices));
 	/* Create sysfs link form the hive folder to yourself */
-	ret = sysfs_create_link(hive->kobj, &adev->dev->kobj, node);
+	ret = sysfs_create_link(&hive->kobj, &adev->dev->kobj, node);
 	if (ret) {
 		dev_err(adev->dev, "XGMI: Failed to create link from hive info");
 		goto remove_link;
@@ -326,79 +311,89 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
 	device_remove_file(adev->dev, &dev_attr_xgmi_error);
 
-	if (adev != hive->adev)
+	if (hive->kobj.parent != (&adev->dev->kobj))
 		sysfs_remove_link(&adev->dev->kobj,"xgmi_hive_info");
 
-	sprintf(node, "node%d", hive->number_devices);
-	sysfs_remove_link(hive->kobj, node);
+	sprintf(node, "node%d", atomic_read(&hive->number_devices));
+	sysfs_remove_link(&hive->kobj, node);
 
 }
-
-
-
-struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock)
+struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 {
-	int i;
-	struct amdgpu_hive_info *tmp;
+	struct amdgpu_hive_info *hive = NULL, *tmp = NULL;
+	int ret = 0;
 
 	if (!adev->gmc.xgmi.hive_id)
 		return NULL;
 
 	mutex_lock(&xgmi_mutex);
 
-	for (i = 0 ; i < hive_count; ++i) {
-		tmp = &xgmi_hives[i];
-		if (tmp->hive_id == adev->gmc.xgmi.hive_id) {
-			if (lock)
-				mutex_lock(&tmp->hive_lock);
-			mutex_unlock(&xgmi_mutex);
-			return tmp;
+	if (!list_empty(&xgmi_hive_list)) {
+		list_for_each_entry_safe(hive, tmp, &xgmi_hive_list, node)  {
+			if (hive->hive_id == adev->gmc.xgmi.hive_id)
+				goto pro_end;
 		}
 	}
-	if (i >= AMDGPU_MAX_XGMI_HIVE) {
-		mutex_unlock(&xgmi_mutex);
-		return NULL;
+
+	hive = kzalloc(sizeof(*hive), GFP_KERNEL);
+	if (!hive) {
+		dev_err(adev->dev, "XGMI: allocation failed\n");
+		hive = NULL;
+		goto pro_end;
 	}
 
 	/* initialize new hive if not exist */
-	tmp = &xgmi_hives[hive_count++];
-
-	if (amdgpu_xgmi_sysfs_create(adev, tmp)) {
-		mutex_unlock(&xgmi_mutex);
-		return NULL;
+	ret = kobject_init_and_add(&hive->kobj,
+			&amdgpu_xgmi_hive_type,
+			&adev->dev->kobj,
+			"%s", "xgmi_hive_info");
+	if (ret) {
+		dev_err(adev->dev, "XGMI: failed initializing kobject for xgmi hive\n");
+		kfree(hive);
+		hive = NULL;
+		goto pro_end;
 	}
 
-	tmp->adev = adev;
-	tmp->hive_id = adev->gmc.xgmi.hive_id;
-	INIT_LIST_HEAD(&tmp->device_list);
-	mutex_init(&tmp->hive_lock);
-	atomic_set(&tmp->in_reset, 0);
-	task_barrier_init(&tmp->tb);
-
-	if (lock)
-		mutex_lock(&tmp->hive_lock);
-	tmp->pstate = AMDGPU_XGMI_PSTATE_UNKNOWN;
-	tmp->hi_req_gpu = NULL;
+	hive->hive_id = adev->gmc.xgmi.hive_id;
+	INIT_LIST_HEAD(&hive->device_list);
+	INIT_LIST_HEAD(&hive->node);
+	mutex_init(&hive->hive_lock);
+	atomic_set(&hive->in_reset, 0);
+	atomic_set(&hive->number_devices, 0);
+	task_barrier_init(&hive->tb);
+	hive->pstate = AMDGPU_XGMI_PSTATE_UNKNOWN;
+	hive->hi_req_gpu = NULL;
 	/*
 	 * hive pstate on boot is high in vega20 so we have to go to low
 	 * pstate on after boot.
 	 */
-	tmp->hi_req_count = AMDGPU_MAX_XGMI_DEVICE_PER_HIVE;
+	hive->hi_req_count = AMDGPU_MAX_XGMI_DEVICE_PER_HIVE;
+	list_add_tail(&hive->node, &xgmi_hive_list);
+
+pro_end:
+	if (hive)
+		kobject_get(&hive->kobj);
 	mutex_unlock(&xgmi_mutex);
+	return hive;
+}
 
-	return tmp;
+void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive)
+{
+	if (hive)
+		kobject_put(&hive->kobj);
 }
 
 int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
 {
 	int ret = 0;
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 	struct amdgpu_device *request_adev = hive->hi_req_gpu ?
 						hive->hi_req_gpu : adev;
 	bool is_hi_req = pstate == AMDGPU_XGMI_PSTATE_MAX_VEGA20;
 	bool init_low = hive->pstate == AMDGPU_XGMI_PSTATE_UNKNOWN;
 	bool locked;
 
+	amdgpu_put_xgmi_hive(hive);
 	/* fw bug so temporarily disable pstate switching */
 	return 0;
 
@@ -453,7 +448,7 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
 
 	/* Each psp need to set the latest topology */
 	ret = psp_xgmi_set_topology_info(&adev->psp,
-					 hive->number_devices,
+					 atomic_read(&hive->number_devices),
 					 &adev->psp.xgmi_context.top_info);
 	if (ret)
 		dev_err(adev->dev,
@@ -515,7 +510,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		adev->gmc.xgmi.node_id = adev->gmc.xgmi.physical_node_id + 16;
 	}
 
-	hive = amdgpu_get_xgmi_hive(adev, 1);
+	hive = amdgpu_get_xgmi_hive(adev);
 	if (!hive) {
 		ret = -EINVAL;
 		dev_err(adev->dev,
@@ -523,6 +518,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 			adev->gmc.xgmi.node_id, adev->gmc.xgmi.hive_id);
 		goto exit;
 	}
+	mutex_lock(&hive->hive_lock);
 
 	top_info = &adev->psp.xgmi_context.top_info;
 
@@ -530,7 +526,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	list_for_each_entry(entry, &hive->device_list, head)
 		top_info->nodes[count++].node_id = entry->node_id;
 	top_info->num_nodes = count;
-	hive->number_devices = count;
+	atomic_set(&hive->number_devices, count);
 
 	task_barrier_add_task(&hive->tb);
 
@@ -568,6 +564,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 
 exit_unlock:
 	mutex_unlock(&hive->hive_lock);
+	amdgpu_put_xgmi_hive(hive);
 exit:
 	if (!ret)
 		dev_info(adev->dev, "XGMI: Add node %d, hive 0x%llx.\n",
@@ -576,7 +573,6 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		dev_err(adev->dev, "XGMI: Failed to add node %d, hive 0x%llx ret: %d\n",
 			adev->gmc.xgmi.physical_node_id, adev->gmc.xgmi.hive_id,
 			ret);
-
 	return ret;
 }
 
@@ -587,17 +583,27 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return -EINVAL;
 
-	hive = amdgpu_get_xgmi_hive(adev, 1);
+	hive = amdgpu_get_xgmi_hive(adev);
 	if (!hive)
 		return -EINVAL;
 
+	mutex_lock(&hive->hive_lock);
 	task_barrier_rem_task(&hive->tb);
 	amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
+	if (hive->hi_req_gpu == adev)
+		hive->hi_req_gpu = NULL;
+	list_del(&adev->gmc.xgmi.head);
 	mutex_unlock(&hive->hive_lock);
 
-	if(!(--hive->number_devices)){
-		amdgpu_xgmi_sysfs_destroy(adev, hive);
-		mutex_destroy(&hive->hive_lock);
+	amdgpu_put_xgmi_hive(hive);
+
+	if(atomic_dec_return(&hive->number_devices) == 0) {
+		/* Remove the hive from global hive list */
+		mutex_lock(&xgmi_mutex);
+		list_del(&hive->node);
+		mutex_unlock(&xgmi_mutex);
+
+		amdgpu_put_xgmi_hive(hive);
 	}
 
 	return psp_xgmi_terminate(&adev->psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 61720cd4a1ee..148560d63554 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -27,14 +27,13 @@
 
 
 struct amdgpu_hive_info {
-	uint64_t		hive_id;
-	struct list_head	device_list;
-	int number_devices;
+	struct kobject kobj;
+	uint64_t hive_id;
+	struct list_head device_list;
+	struct list_head node;
+	atomic_t number_devices;
 	struct mutex hive_lock;
 	atomic_t in_reset;
-	struct kobject *kobj;
-	struct device_attribute dev_attr;
-	struct amdgpu_device *adev;
 	int hi_req_count;
 	struct amdgpu_device *hi_req_gpu;
 	struct task_barrier tb;
@@ -51,7 +50,8 @@ struct amdgpu_pcs_ras_field {
 	uint32_t pcs_err_shift;
 };
 
-struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock);
+struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
+void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
 int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
