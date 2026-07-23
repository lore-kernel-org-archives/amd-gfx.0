Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57892C531FD
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260B010F1D3;
	Thu, 23 Jul 2026 20:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F/1ygbZj";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013059.outbound.protection.outlook.com
 [40.93.196.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CC410F1C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2d+hhuS0r+8vxV5BtLnv2xJHwD0HIYog7UIzpAq3fX70rTAgQwazcHeZFYozKmOhkL17crQX2IXXWAo79a7v9QLcM2FrqKbX8DhuV1DnQVqsk5levg1Z3oqhXx2IP8ZPV1QMixzL149ShXEqOr333OvqyraYPTwu/I63A2lKw3L8K/60rsuM/xnaIQ4v+75Vq6YZyxZSiapYXbDJ7ovBx+B0BddLVChin5fVdhg6yzVOgOZK8htyxXbjwkaVKITG9urcIr8L/uwbfiuL2RYIhnpCcEbMnSUrxOKggVTet76xcH7e0uTCbnPgyVyW7P5596/uXyenztK0vrcgrnjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jEWHUWu371zJeIv0AO4FtiG0kBKQJOLmnjLHf6rzWU=;
 b=ecom5fdjTIsyF5/C8sGrDthsS8QrKkADHpDq509AaMfaC/7oL32+lGaBI0vTMDaEklUaMfUBN3bimnQ1pDmqqPCUeGFUtoDYo7pNgy94PtOZVgtP9fLbBaD0Y5ZjswiP+zVMsQQeV8uycbW8L8+THQS0YUL907mXrAFILpsR/nfuR9k5O0AVV6NcW+MSa/pOXgoLjR5T4ZXf6vreHHJt673B+s+BTuRekqiVeRR2vavWRiL1tkQuuBEuiiipv9n5ZfHPEmjsmFrwQ0j5Svha6XlwUkiILigQcHeU/z/BRWuCSsOzY5kR+dSsvP+IGp2u9rGjN7AaxT15A3q505kFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jEWHUWu371zJeIv0AO4FtiG0kBKQJOLmnjLHf6rzWU=;
 b=F/1ygbZjMSxDNyzi70NQojYF2oc07PGUggYFFDkguDK+cd90Lphc07cLhnJsvdiqkqZtp2cEE/s98fAXI0ELcyUimmirlyv9X7kg1D1BLThzHZP8lp6VtYCRicmcL8V1iTnMdwsy5pGN76cQ6vMs2FL7VhhKAePZAFoFEgh8+9E=
Received: from MN0P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::23)
 by CH1PPF189669351.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::608) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:18:57 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::52) by MN0P223CA0022.outlook.office365.com
 (2603:10b6:208:52b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:18:57 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:54 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 09/49] drm/amd/display: Add KUnit tests for hdcp_destroy
Date: Thu, 23 Jul 2026 16:13:17 -0400
Message-ID: <20260723201908.373300-10-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5d6140-8ec7-4e6b-50c1-08dee8f79ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: OKYd5j0i9cxzfArxtU8fjBZ3aeSwaTLjW+6qmWIvCGRFQUzU3ALgYpC2c6hkZLlil/NN1GhXDjeonZo4ivLQTpiI8ivheAZegiu+QyfrpikPTdiSQwqsvR/tjEao8VG2FUql8C8uTnPcHMprI6B4pQQEZ9zdUg3w7yhe4R2jMYSDPygk2CYzX80lcj7UNjWq9mihFRWtRF/L+LfUYl1f7hsGebUfobIVCbCYXxXEivi5ilBKZxkVauSCfyAzqLlbtdlPCe3VpCxc9g6XNKJYeWR8Z9C9RHq69RZbAyIDOmQlQUjl/ymsEUjN3Tae4D5fgRqsl35C73TsZGen0IIQvrktEbKSfKYVADVN2of/z7nUIDtTdxWFNO7JwdLVHCSyN7fLUmybozU+SApBS+rfyLBtujqMdHLb6bxQGnaYBuCQXhuOmR2byjodmOlrzrMgBTDUKczRo1fCnptt0HCzkSp4qHfgYcDXMNTMZmLrVaPcKgKoWcv+P1I+GMcBybydnf0OaTm4jHp8YHbg1L9CnSVYU8oMc6D5GszhaTk5Ou9NCU/nLp+NvX0erTfPzeut/JtdFNJD/cyXcHNtisca0gNlCI4xyQb0f03TqaYIHTSYgahf7Hz7HOYX+qaev1K3fSrZwVi1sKwttKEgoC2g8AyDqdqUNSkiu7e7Bja3P+SjtGRqdvoD/YoHwcBwS7CU5Y/04Nw0poBYJ6UZxHfywA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NoPnpnopx4JkPt1GvYUzbIvJ0OqPqLClsP3D/iVZDl1QPT+euZIpiyeFMYiZXAdo7Sbz4c3+qA2w9mhxOk1ZiNVgXuhydMXBgNpQbjTQaHqIhRH+MUzrxXVc1l9ZrEszCZg8V3dqlI7Bw4SMfLXKEYTa+YJEH179ReQGUhlMSGn7A8dEn6hTeXWzqpE9cJrej9ZXNyOeh/DDVUzxCzvke/qsYHjDt601MTGBxLu8Rq83YBMkzh68TpnZgQy7962t6gjcbNqtCK8cOtxa8NGtXFsHnPSZjopeHkxDZMkT9qsysJr7GH37RvPJ7VZJbGRKlq/doeufM67UaWPMB7hpwADg3bB/M1XQ70EP0ITmwzIP1Dfc//CO7ai2S7+5cRV/hIiyifIv1RpNsonwLnASOq8uKY/lIKSp/Wz/Fzo3mjvRz/aHiPSL5xj/w3mC6eCP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:18:57.1172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5d6140-8ec7-4e6b-50c1-08dee8f79ff8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Verify hdcp_destroy() cancels each link's delayed works, removes
the SRM sysfs file and frees the workqueue and SRM buffers. Cover
both a populated work-queue and the zero-link / NULL-SRM path.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 122 ++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 896668c92888..e704b6b7fc0b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -568,6 +568,7 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 	kfree(hdcp_work->srm_temp);
 	kfree(hdcp_work);
 }
+EXPORT_IF_KUNIT(hdcp_destroy);
 
 static bool enable_assr(void *handle, struct dc_link *link)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index a4097a4aec26..5eace7fa4100 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -7,6 +7,9 @@
 
 #include <kunit/test.h>
 #include <linux/workqueue.h>
+#include <linux/kobject.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
@@ -1007,6 +1010,122 @@ static void dm_test_hdcp_create_workqueue_zero_max_links_returns_null(struct kun
 
 /* End of tests for hdcp_create_workqueue() */
 
+/* Tests for hdcp_destroy() */
+
+static ssize_t test_srm_bin_read(struct file *filp, struct kobject *kobj,
+				 const struct bin_attribute *bin_attr, char *buffer,
+				 loff_t pos, size_t count)
+{
+	return 0;
+}
+
+static ssize_t test_srm_bin_write(struct file *filp, struct kobject *kobj,
+				  const struct bin_attribute *bin_attr, char *buffer,
+				  loff_t pos, size_t count)
+{
+	return count;
+}
+
+/**
+ * setup_destroy_sysfs - create a kobject with the SRM bin file attached
+ * @test: KUnit test context
+ * @work: workqueue whose attr will be registered
+ *
+ * hdcp_destroy() calls sysfs_remove_bin_file() on the first entry's attr, so
+ * a real kobject with the bin file created is required. Returns the kobject,
+ * which the caller must kobject_put() after hdcp_destroy() has run.
+ */
+static struct kobject *setup_destroy_sysfs(struct kunit *test,
+					   struct hdcp_workqueue *work)
+{
+	struct kobject *kobj;
+	int ret;
+
+	kobj = kobject_create_and_add("amdgpu_dm_hdcp_test", NULL);
+	KUNIT_ASSERT_NOT_NULL(test, kobj);
+
+	sysfs_bin_attr_init(&work->attr);
+	work->attr.attr.name = "hdcp_srm";
+	work->attr.attr.mode = 0664;
+	work->attr.size = 16;
+	work->attr.read = test_srm_bin_read;
+	work->attr.write = test_srm_bin_write;
+
+	ret = sysfs_create_bin_file(kobj, &work->attr);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return kobj;
+}
+
+/**
+ * dm_test_hdcp_destroy_frees_and_removes_sysfs - full teardown path
+ * @test: KUnit test context
+ *
+ * hdcp_destroy() must cancel every link's delayed works, remove the SRM
+ * sysfs bin file and free srm, srm_temp and the workqueue itself. The
+ * workqueue and SRM buffers use kzalloc() (not kunit-managed) because
+ * hdcp_destroy() frees them; KASAN/kmemleak validate there is no leak or
+ * use-after-free.
+ */
+static void dm_test_hdcp_destroy_frees_and_removes_sysfs(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+	struct kobject *kobj;
+
+	work = kzalloc_obj(*work);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	work->max_link = 1;
+	INIT_DELAYED_WORK(&work->callback_dwork, dummy_work_fn);
+	INIT_DELAYED_WORK(&work->watchdog_timer_dwork, dummy_work_fn);
+	INIT_DELAYED_WORK(&work->property_validate_dwork, dummy_work_fn);
+
+	work->srm = kzalloc(16, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work->srm);
+	work->srm_temp = kzalloc(16, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work->srm_temp);
+
+	kobj = setup_destroy_sysfs(test, work);
+
+	/* Pre-schedule a delayed work to exercise the cancel path. */
+	schedule_delayed_work(&work->callback_dwork, msecs_to_jiffies(10000));
+	KUNIT_ASSERT_TRUE(test, delayed_work_pending(&work->callback_dwork));
+
+	hdcp_destroy(kobj, work);
+
+	/* work is freed by hdcp_destroy(); only the kobject remains. */
+	kobject_put(kobj);
+}
+
+/**
+ * dm_test_hdcp_destroy_zero_links_null_srm - teardown with no links or SRM
+ * @test: KUnit test context
+ *
+ * With max_link == 0 the cancel loop is skipped, and NULL srm/srm_temp make
+ * the kfree() calls no-ops. hdcp_destroy() must still remove the sysfs bin
+ * file and free the workqueue without crashing.
+ */
+static void dm_test_hdcp_destroy_zero_links_null_srm(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+	struct kobject *kobj;
+
+	work = kzalloc_obj(*work);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	work->max_link = 0;
+	work->srm = NULL;
+	work->srm_temp = NULL;
+
+	kobj = setup_destroy_sysfs(test, work);
+
+	hdcp_destroy(kobj, work);
+
+	kobject_put(kobj);
+}
+
+/* End of tests for hdcp_destroy() */
+
 /* Tests for link_lock() */
 
 /**
@@ -1373,6 +1492,9 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	KUNIT_CASE(dm_test_hdcp_update_display_disable_resets_status_and_cancels_validate),
 	/* hdcp_create_workqueue() */
 	KUNIT_CASE(dm_test_hdcp_create_workqueue_zero_max_links_returns_null),
+	/* hdcp_destroy() */
+	KUNIT_CASE(dm_test_hdcp_destroy_frees_and_removes_sysfs),
+	KUNIT_CASE(dm_test_hdcp_destroy_zero_links_null_srm),
 	/* link_lock() */
 	KUNIT_CASE(dm_test_link_lock_locks_and_unlocks_all_links),
 	KUNIT_CASE(dm_test_link_lock_zero_links_is_noop),
-- 
2.53.0

