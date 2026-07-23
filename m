Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E750C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E907910F1DC;
	Thu, 23 Jul 2026 20:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="geEdRR+7";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B1710F1E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7ueazqWDbJ89+mx1efMg5QMnlu7gIEY2cG9ZIM/+Fjb5mJPVusoqf837OZSWdNyRSno1rxJYDGTj3rGWUQFCHOc4ucsmMR7J2eOve1Zu1yajJp/E6tFkV/p+hX3WgdFWFZOnYro6UAAJ3tG2D1xiBmETRH+nVVaOXvSSqy2P38/5ubzpGSxgnSAFSE5i6Z8uZFd8v7nFpKRpQRW6zO6v+tZVbRKmkd2RRsH2H7Qi/WO6q/vWWMrtzYJgxCmEGXOMtwY+ofLVCruD0pNdxT35ZQpoijA/xIxIAQUtPA2ksSWbKMEr/PJDiUHpEyOgXcMiG3Rot/N7vVUz0hDNu93bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hDlvC9zKrKXd4sDsKF5FHziZvc51CmC91Cje65JpKQ=;
 b=W6DrWjXv8RBZiACxLN6EJiftYZlt7WjK0SjmZqrf/FJz8K/hvPx4w97KXMn5cgl3tJo0nUJ1aN4VtS9tMoAnz70LzywQFUZclt0yapwgJYOezOYHtgRMhgG5Yh1W+eKA3KnqHs54Pnfq2KrOootwolmbKHbaTuzuTv9ln0Vyx6KiHVf2s6BtHazNFpY5vQglU38P/rS0afYg/MkdBMC/Goj+l/u977IxSyOeOEq4g5uwo0X+K/tKOXj3+QpPwHvszCHTGaXnjynDz1D9zRRaWr2cwcexxOalJKu0bZfdfq7Maji2GnkdS3QIA6ooJB8nEQlgWHz1G/HEgD50Y9Mrkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hDlvC9zKrKXd4sDsKF5FHziZvc51CmC91Cje65JpKQ=;
 b=geEdRR+7dIuNxJp9k3V5V2IpPmCD/uZAkFvmRtHd+d5ffUipAW4g+QcYMqO5GZA7q08Is2DxrD+sd1Xj5gnh7Ck2ZTWm3Wdg4cygg8DSO3AFxYBCEh02/nxWwjS7aFWuP3SDEKlLUuMOuMFO2B5DrzVE5TF9KEwJx19jCubAELU=
Received: from BN1PR12CA0008.namprd12.prod.outlook.com (2603:10b6:408:e1::13)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Thu, 23 Jul 2026 20:19:26 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::30) by BN1PR12CA0008.outlook.office365.com
 (2603:10b6:408:e1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:26 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:12 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 32/49] drm/amd/display: Add KUnit tests for srm_data_write and
 srm_data_read
Date: Thu, 23 Jul 2026 16:13:40 -0400
Message-ID: <20260723201908.373300-33-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 10456261-a5d8-452b-27a6-08dee8f7b14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|6133799003|56012099006|11063799006|10067099003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 470L1xuf3X+F4uftav98fmWiUGUjgCdnAHm/keMyXaS/C1FNDDZs+KX74520x5XponH9XAyeXa+Zptp00hV/KN+fOAQ/PBc2b8wpo7oRKONNUereomCftRvf/zBvZPy1KVeX6VfJW3TavxS6KmPaXMOUSw91Wg9eddTInrbzOFtLvwupmFdY8ZhwdUQc1sax/WXjxq1gLIdhvpYsxm6uH4zzeOBtqWsNpI/t/Rn4Kjm0zprryAtPri6y7LkctlIoIS+KylYPwdXBpBubni09sJDrzuaxhFKIVvl10RtyDkyI7O5T5dEeUrt4y4KGUt6/hS+g4owLxr39e0uE4kaPziZzQRuwiJWiM8CrcCXMKTZSsEaUjEVmWXKCudvDbocRXclSyvb1XP0zfNgQX4nPgY4YTxl6/KHoG0QvqShbwMpskXDVHfjQ8ansjwVI+0rNJYEfA8/xsqIMJY9SSpHzGih+oYJGZB0Hl10OEn7p8ngZpWSBFb/fvJaghqlLz/fYXaUFShLtA+8yKqa45vjnRH/kxepueHrSIJ4IrlSSISZs0KARtWQDYQM37Fkjc2ADl30JgIa8qhWSN3nKDhtc4EKvysKe1pnbsnNMQUbHdLpgSaZRRIAoyiyh7qrMInHXU6H8Es5j/Z+tH8fBif9Wx6XCwLQqs5WGX6ViZiikVg2b6hkQngYy5/dKgdlLC/6AdLVNo5hlz+NHbHTHGAHM5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(6133799003)(56012099006)(11063799006)(10067099003)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EpZ3ERnejhqSswgRhKNqGGm4TCYO/MW5xmyHlbJzAL9qttPucyOkVUKSYvIecy47i+Jim3W8g77j7gqYOF2wOINilAAtAsKmeADS7/pMy4qD88DNlRdxiWzlVQq/FExfFyATFIjIJAyM69CAd0rpgeTVOrYx/YFEMtoJl9I9Bs6fOOLtSGROLVfFHFEZV41cqASV7xcsmWKm9tqbZcBONLoDTdGgOZt0rvtosJaZaEFTOWoLb3sj2m7UphsMAlDIKlm0ZmE3pry+kUK+FGtjHBUnwAc5wa5aSdDXhLar3eJeOUHJlEml+ScDnwB7cL454le7STZwvplUnRH201wVW/T1QKN+TdPNQqmM8H+oAm1Q4goqu3+YW603mdEmQNo/eglWTHz59Yqqx2kIVZe+KBCP3lheKylnf8SnTfY9/w7YvLj71YTGClxnuimK17AY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:26.1879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10456261-a5d8-452b-27a6-08dee8f7b14c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435
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

Expose srm_data_write() and srm_data_read() for KUnit and add tests
covering the sysfs SRM write/read paths:

- write stages the buffer into srm_temp and returns count; with the TA
  uninitialized psp_set_srm() fails so the committed SRM is unchanged
- read returns -EINVAL when psp_get_srm() returns NULL (TA uninitialized)
- read returns 0 for an empty SRM using the SR-IOV VF bypass so
  psp_hdcp_invoke() is a no-op and psp_get_srm() returns a non-NULL buffer

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   9 ++
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 117 ++++++++++++++++++
 3 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 560bfa43dc8a..9ea0a120af6f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -743,7 +743,7 @@ EXPORT_IF_KUNIT(update_config);
  *	-if we try to "1. SET" a newer version and PSP rejects it. That means the format is
  *	incorrect/corrupted and we should correct our SRM by getting it from PSP
  */
-static ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
+STATIC_IFN_KUNIT ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
 			      const struct bin_attribute *bin_attr, char *buffer,
 			      loff_t pos, size_t count)
 {
@@ -766,8 +766,9 @@ static ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
+EXPORT_IF_KUNIT(srm_data_write);
 
-static ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
+STATIC_IFN_KUNIT ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
 			     const struct bin_attribute *bin_attr, char *buffer,
 			     loff_t pos, size_t count)
 {
@@ -803,6 +804,7 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
 	link_lock(work, false);
 	return ret;
 }
+EXPORT_IF_KUNIT(srm_data_read);
 
 /* From the hdcp spec (5.Renewability) SRM needs to be stored in a non-volatile memory.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 30c1e7b1af1a..e700d019f971 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -45,6 +45,9 @@ struct mod_hdcp_display;
 struct cp_psp;
 struct amdgpu_device;
 struct psp_context;
+struct file;
+struct kobject;
+struct bin_attribute;
 
 struct hdcp_workqueue {
 	struct work_struct cpirq_work;
@@ -125,6 +128,12 @@ uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *s
 int psp_set_srm(struct psp_context *psp, u8 *srm, uint32_t srm_size, uint32_t *srm_version);
 bool enable_assr(void *handle, struct dc_link *link);
 void update_config(void *handle, struct cp_psp_stream_config *config);
+ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
+		       const struct bin_attribute *bin_attr, char *buffer,
+		       loff_t pos, size_t count);
+ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
+		      const struct bin_attribute *bin_attr, char *buffer,
+		      loff_t pos, size_t count);
 #endif
 
 #endif /* AMDGPU_DM_AMDGPU_DM_HDCP_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index d95babb73711..a8bca05f47a3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -1348,6 +1348,119 @@ static void dm_test_psp_set_srm_uninitialized_returns_einval(struct kunit *test)
 
 /* End of tests for psp_get_srm() and psp_set_srm() */
 
+/* Tests for srm_data_write() and srm_data_read() */
+
+/**
+ * dm_test_srm_data_write_uninitialized_ta_keeps_srm - write with TA not initialized
+ * @test: KUnit test context
+ *
+ * srm_data_write() always copies the incoming buffer into work->srm_temp and
+ * returns the byte count. When the HDCP TA is not initialized, psp_set_srm()
+ * fails, so the committed SRM (work->srm / work->srm_size) must stay untouched.
+ */
+static void dm_test_srm_data_write_uninitialized_ta_keeps_srm(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+	struct psp_context *psp;
+	u8 buf[4] = {0xAA, 0xBB, 0xCC, 0xDD};
+	ssize_t ret;
+
+	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+	psp = kunit_kzalloc(test, sizeof(*psp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, psp);
+
+	work->max_link = 1;
+	mutex_init(&work->mutex);
+	/* kzalloc leaves hdcp_context.context.initialized == false */
+	work->hdcp.config.psp.handle = psp;
+	work->srm_temp = kunit_kzalloc(test, PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work->srm_temp);
+	work->srm = kunit_kzalloc(test, PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work->srm);
+
+	ret = srm_data_write(NULL, NULL, &work->attr, buf, 0, sizeof(buf));
+
+	KUNIT_EXPECT_EQ(test, ret, (ssize_t)sizeof(buf));
+	/* Incoming data is always staged into srm_temp. */
+	KUNIT_EXPECT_MEMEQ(test, work->srm_temp, buf, sizeof(buf));
+	/* psp_set_srm() failed, so the committed SRM must be unchanged. */
+	KUNIT_EXPECT_EQ(test, work->srm_size, 0u);
+}
+
+/**
+ * dm_test_srm_data_read_uninitialized_ta_returns_einval - read with TA not initialized
+ * @test: KUnit test context
+ *
+ * When the HDCP TA is not initialized, psp_get_srm() returns NULL, so
+ * srm_data_read() must take the error path and return -EINVAL.
+ */
+static void dm_test_srm_data_read_uninitialized_ta_returns_einval(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+	struct psp_context *psp;
+	u8 buf[4];
+	ssize_t ret;
+
+	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+	psp = kunit_kzalloc(test, sizeof(*psp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, psp);
+
+	work->max_link = 1;
+	mutex_init(&work->mutex);
+	/* kzalloc leaves hdcp_context.context.initialized == false */
+	work->hdcp.config.psp.handle = psp;
+
+	ret = srm_data_read(NULL, NULL, &work->attr, buf, 0, sizeof(buf));
+
+	KUNIT_EXPECT_EQ(test, ret, (ssize_t)-EINVAL);
+}
+
+/**
+ * dm_test_srm_data_read_empty_srm_returns_zero - read of an empty SRM
+ * @test: KUnit test context
+ *
+ * With an initialized TA and the SR-IOV VF bypass, psp_hdcp_invoke() is a
+ * no-op and the zeroed shared buffer yields a SUCCESS status with srm_size 0.
+ * psp_get_srm() then returns a non-NULL (empty) buffer, so srm_data_read()
+ * takes the "nothing left to copy" path and returns 0.
+ */
+static void dm_test_srm_data_read_empty_srm_returns_zero(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct ta_hdcp_shared_memory *hdcp_cmd;
+	struct hdcp_workqueue *work;
+	struct psp_context *psp;
+	u8 buf[4];
+	ssize_t ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+	psp = kunit_kzalloc(test, sizeof(*psp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, psp);
+	hdcp_cmd = kunit_kzalloc(test, sizeof(*hdcp_cmd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, hdcp_cmd);
+
+	work->max_link = 1;
+	mutex_init(&work->mutex);
+	psp->adev = adev;
+	psp->hdcp_context.context.initialized = true;
+	psp->hdcp_context.context.mem_context.shared_buf = (uint8_t *)hdcp_cmd;
+	work->hdcp.config.psp.handle = psp;
+
+	/* SR-IOV VF makes psp_hdcp_invoke() return early without firmware. */
+	adev->virt.caps |= AMDGPU_SRIOV_CAPS_IS_VF;
+
+	ret = srm_data_read(NULL, NULL, &work->attr, buf, 0, sizeof(buf));
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/* End of tests for srm_data_write() and srm_data_read() */
+
 /*
  * Tests for hdcp_update_display() / hdcp_remove_display() /
  * hdcp_reset_display().
@@ -1877,6 +1990,10 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	/* psp_get_srm() / psp_set_srm() */
 	KUNIT_CASE(dm_test_psp_get_srm_uninitialized_returns_null),
 	KUNIT_CASE(dm_test_psp_set_srm_uninitialized_returns_einval),
+	/* srm_data_write() / srm_data_read() */
+	KUNIT_CASE(dm_test_srm_data_write_uninitialized_ta_keeps_srm),
+	KUNIT_CASE(dm_test_srm_data_read_uninitialized_ta_returns_einval),
+	KUNIT_CASE(dm_test_srm_data_read_empty_srm_returns_zero),
 	/* hdcp_update_display() / hdcp_remove_display() / hdcp_reset_display() */
 	KUNIT_CASE(dm_test_hdcp_update_display_enable_registers_connector),
 	KUNIT_CASE(dm_test_hdcp_update_display_disable_sets_status_off),
-- 
2.53.0

