Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C261C531F7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F24B710E5F6;
	Thu, 23 Jul 2026 20:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p/A2NAGq";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D6D10E5EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4ArjuQ4djN7pIDXY/UKEU1J5V5E14weQXlCDlAOe4AR5/cICKeCxAyoPXuptv/7ZR/VQJyLTi4DqS84hPZqJ7DK+Qmv6HVQF5jR7nupTjcRpFscQ9gkXWfNisIh/giBqAZDv1tbqk+WvdyxnvH0lzDa7zTk1oyttfyY/aiIZj9lxrsZZ1ydyDnz/lwnSiHQVSwoW6ZxKu97mAgxnwl5Awt61EXfdcXi1trb2lvHoV8Ky8xOdI41mqcQJTZQaYiny6n0nFLsxMtNFNRa4JXFCZWu+CI7/cwSawRCu5p0OZo+piEIN4MhcRK7ki5iafiqSkd4V0Z3EoLJZDTIbayRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBOnuzHY2SYr8y9cSQ+FKZu7KB7U+aV7UFj0vg38MWs=;
 b=Z9dyS0AZUHmuiGHUTg5i7f4LNNQi3LPzi2BJ0PBqLR1Pu6YkJF7M5IS489SNbBmDG0KZK5jl/rZObgLnz+NfGV8ndq5daaL1FhdKRc5uNyo4jOakQRiO/PImOZaHPnB/3779RNpngZHBcwGgPXg+iDaUmI1rRa1F65DF5TGqPhS2B9DVDQeDJf8y/Nrb+Nz7BOpyGf4an+KWgrBa232E4fK9AGArUMn9nXD1FOoFWKO/cPoaF2+XwXLDigDSiHIByL0EepZdZYjDhS4lmwHLEC1OvdAyke1+20UhRA4AnqNMKvmugW7TESgACP9EwX3+p6IUuDcB6nAiMb1tqMZQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBOnuzHY2SYr8y9cSQ+FKZu7KB7U+aV7UFj0vg38MWs=;
 b=p/A2NAGqCkKnHthIELqMc4hiCF0ulCiO0n8IrCrGylefsk4dG8WJQpqsk77T9ddp/zAzaXiAuplRV2xT/UIlATA5Zvt2APbPEI2v0R8tHqJYo1N2S2+C+d5CFZc3a18CXg1uPgjCi1qi6+4BaNkKArUdFyfQXzx89326F6vUcHs=
Received: from MN0P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::25)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:18:54 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::55) by MN0P223CA0021.outlook.office365.com
 (2603:10b6:208:52b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:18:53 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:51 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 04/49] drm/amd/display: Add KUnit tests for link_lock and psp
 SRM helpers
Date: Thu, 23 Jul 2026 16:13:12 -0400
Message-ID: <20260723201908.373300-5-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: da7645cb-c0d0-454e-c3bd-08dee8f79e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|6133799003|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: lo1PGOps2dsrJZYYX+gNzEqhvi5iTavA+TS7MO4shiBfE0JfcN/P6TNdv2vXegkksmOL7wrHaX0ECQjptRCjhxo0b2QUi8wyyeIH3xNdSkJr+fH685amymF86c5D2PTd5QrsuFzxBCoXln2DkVMApd9CBGQoxtbDlWyVhn5kF7LahZzAUlxrwOgIC7u3cJw/LcueHZyNWzgTD62poK3DTkiF9S7or2NiAUkGh3MsrvZIOL5hjQFnyBfSGJ/QiyhpFooDjzbhrdh0YckKyoYBmrzCpji/Ky0XSpCcnS5HnWxXn23R5VNiCP/ct0r+o5czNtHvQkFoeLH8bTsgnKsTt+dBUj7DJbMGnFmfN6a6lPO3eqcdjZNUzcgcC2i/NPe4vHZ7vXsindDUm2an+XA/HqidU/LBpEViv7eHjK5zZDbho9tmwZXX/aVrK/zx+q1KIm9u8LKNoMZvaE1jsotTNqONBIetbP1QU09ENesaWgwoEaMVRVFeF2mdTZWDAQLMpVHBAx8b8Qr8p0eULnW7SahGn/4STVLglWRWe7eS1atx8MbRoEnKIBd9jIn/OjQBmW9ch6PKnz1o+k9fqE42yUNdJe3n1zZ1Hb2BVWAMbKZA2vk/u+GMy7TepuJ+XxaxAwzk/Mw2/2mGztarKvBk1lWdCc14bnXym5HDTItgI3s2qDVu5dG7WLCPKaVBgi+Q3Wtrc/MvdR3+aGsY/0T8Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rMoTP38Lzz8iGXdIKgVMxzSZwhaMF4peAo50VAQSn/qQoiCG1NFPwWDKEoVSlV44ty2AC9QPIxlffbgzc1A0wAwSjJ1KOZUfMIyJCpuSsmtI/Wye/Fl5nrMtll+RWHHO862qnL0q/IPgarzBWsE4KXbjqNcSDpBV6+nCSTq4bhJ790VaHw9sN15PGGnldKDfm7/aGKSQO3Q6/W4SutHf4SxG8Hb9Yp+yBMTXBDVgFigjvWW1jpHkdSMdukRos5nPzcvNfudgWsnK4lNJzHa9TbT48IeXII27KFraZwbMeK5VO/JRRAh6IT8lnMWlcEfn5XbNP2uminM2HEl+9jKwsEJcrM2qExaJ9zGZDpRrKLvnaeOsWsaB4sX+F82D4m02pFi0cP4w+W7JL8IyBlB9/0QRZfaYWYk1QWGOtt9/M16DYkcFUQiKNZGKBofEMqTk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:18:53.8230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da7645cb-c0d0-454e-c3bd-08dee8f79e01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
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

Cover link_lock() across all links (lock then unlock) and the
max_link == 0 no-op path, checking each per-link mutex ends in
the expected state.

Also cover the psp_get_srm() and psp_set_srm() guard paths when
the HDCP TA context is uninitialized: psp_get_srm() returns NULL
and psp_set_srm() returns -EINVAL, both leaving their output
parameters untouched. The post-guard paths invoke real PSP
firmware and are not unit-testable in UML.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  12 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   4 +
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 127 ++++++++++++++++++
 3 files changed, 140 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 0dee603ecfaa..3b5e0e64adde 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -106,7 +106,8 @@ static bool lp_atomic_write_poll_read_aux(
 	return dm_atomic_write_poll_read_aux(link, write, poll, read, poll_timeout_us, poll_mask_msb);
 }
 
-static uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
+STATIC_IFN_KUNIT
+uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
 {
 	struct ta_hdcp_shared_memory *hdcp_cmd;
 
@@ -129,8 +130,10 @@ static uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint
 
 	return hdcp_cmd->out_msg.hdcp_get_srm.srm_buf;
 }
+EXPORT_IF_KUNIT(psp_get_srm);
 
-static int psp_set_srm(struct psp_context *psp,
+STATIC_IFN_KUNIT
+int psp_set_srm(struct psp_context *psp,
 		       u8 *srm, uint32_t srm_size, uint32_t *srm_version)
 {
 	struct ta_hdcp_shared_memory *hdcp_cmd;
@@ -157,6 +160,7 @@ static int psp_set_srm(struct psp_context *psp,
 	*srm_version = hdcp_cmd->out_msg.hdcp_set_srm.srm_version;
 	return 0;
 }
+EXPORT_IF_KUNIT(psp_set_srm);
 
 STATIC_IFN_KUNIT
 void process_output(struct hdcp_workqueue *hdcp_work)
@@ -245,7 +249,8 @@ void hdcp_get_link_display_adjustments(
 }
 EXPORT_IF_KUNIT(hdcp_get_link_display_adjustments);
 
-static void link_lock(struct hdcp_workqueue *work, bool lock)
+STATIC_IFN_KUNIT
+void link_lock(struct hdcp_workqueue *work, bool lock)
 {
 	int i = 0;
 
@@ -256,6 +261,7 @@ static void link_lock(struct hdcp_workqueue *work, bool lock)
 			mutex_unlock(&work[i].mutex);
 	}
 }
+EXPORT_IF_KUNIT(link_lock);
 
 STATIC_IFN_KUNIT
 void hdcp_update_display_encryption_control(struct hdcp_workqueue *hdcp_work,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index a82a20b80518..fb66f48d7297 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -44,6 +44,7 @@ struct mod_hdcp_link;
 struct mod_hdcp_display;
 struct cp_psp;
 struct amdgpu_device;
+struct psp_context;
 
 struct hdcp_workqueue {
 	struct work_struct cpirq_work;
@@ -113,6 +114,9 @@ void hdcp_update_display_encryption_control(struct hdcp_workqueue *hdcp_work,
 					    unsigned int conn_index,
 					    bool enable_encryption);
 void event_property_update(struct work_struct *work);
+void link_lock(struct hdcp_workqueue *work, bool lock);
+uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size);
+int psp_set_srm(struct psp_context *psp, u8 *srm, uint32_t srm_size, uint32_t *srm_version);
 #endif
 
 #endif /* AMDGPU_DM_AMDGPU_DM_HDCP_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index dbcff92672e6..43c7efcdd22c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -8,6 +8,7 @@
 #include <kunit/test.h>
 #include <linux/workqueue.h>
 
+#include "amdgpu.h"
 #include "amdgpu_dm_hdcp.h"
 
 static void dummy_work_fn(struct work_struct *work) {}
@@ -632,6 +633,126 @@ static void dm_test_hdcp_create_workqueue_zero_max_links_returns_null(struct kun
 
 /* End of tests for hdcp_create_workqueue() */
 
+/* Tests for link_lock() */
+
+/**
+ * dm_test_link_lock_locks_and_unlocks_all_links - lock/unlock spans every link
+ * @test: KUnit test context
+ *
+ * link_lock() should acquire the mutex of every entry from 0 to max_link
+ * when locking, and release all of them when unlocking. A subsequent
+ * lock/unlock cycle must succeed, proving the mutexes were left released.
+ */
+static void dm_test_link_lock_locks_and_unlocks_all_links(struct kunit *test)
+{
+	const int num_links = 3;
+	struct hdcp_workqueue *work;
+	int i;
+
+	work = kunit_kcalloc(test, num_links, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	/* max_link is read from the first element. */
+	work[0].max_link = num_links;
+	for (i = 0; i < num_links; i++)
+		mutex_init(&work[i].mutex);
+
+	link_lock(work, true);
+	for (i = 0; i < num_links; i++)
+		KUNIT_EXPECT_TRUE(test, mutex_is_locked(&work[i].mutex));
+
+	link_lock(work, false);
+	for (i = 0; i < num_links; i++)
+		KUNIT_EXPECT_FALSE(test, mutex_is_locked(&work[i].mutex));
+
+	/* Mutexes must be re-acquirable after being released. */
+	link_lock(work, true);
+	for (i = 0; i < num_links; i++)
+		KUNIT_EXPECT_TRUE(test, mutex_is_locked(&work[i].mutex));
+	link_lock(work, false);
+}
+
+/**
+ * dm_test_link_lock_zero_links_is_noop - zero max_link touches no mutexes
+ * @test: KUnit test context
+ *
+ * When max_link is zero, link_lock() must not touch any mutex and simply
+ * return, leaving the (single) entry's mutex unlocked.
+ */
+static void dm_test_link_lock_zero_links_is_noop(struct kunit *test)
+{
+	struct hdcp_workqueue *work;
+
+	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	mutex_init(&work->mutex);
+	work->max_link = 0;
+
+	link_lock(work, true);
+
+	KUNIT_EXPECT_FALSE(test, mutex_is_locked(&work->mutex));
+}
+
+/* End of tests for link_lock() */
+
+/* Tests for psp_get_srm() and psp_set_srm() */
+
+/**
+ * dm_test_psp_get_srm_uninitialized_returns_null - GET fails when TA not initialized
+ * @test: KUnit test context
+ *
+ * When the HDCP TA context is not initialized, psp_get_srm() must take the
+ * guard path and return NULL without touching the output parameters or
+ * invoking the (real) firmware path.
+ */
+static void dm_test_psp_get_srm_uninitialized_returns_null(struct kunit *test)
+{
+	struct psp_context *psp;
+	uint32_t srm_version = 0xdead;
+	uint32_t srm_size = 0xbeef;
+	uint8_t *srm;
+
+	psp = kunit_kzalloc(test, sizeof(*psp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, psp);
+
+	/* kzalloc leaves hdcp_context.context.initialized == false */
+	srm = psp_get_srm(psp, &srm_version, &srm_size);
+
+	KUNIT_EXPECT_PTR_EQ(test, srm, NULL);
+	/* Output parameters must be left untouched on the guard path. */
+	KUNIT_EXPECT_EQ(test, srm_version, 0xdead);
+	KUNIT_EXPECT_EQ(test, srm_size, 0xbeef);
+}
+
+/**
+ * dm_test_psp_set_srm_uninitialized_returns_einval - SET fails when TA not initialized
+ * @test: KUnit test context
+ *
+ * When the HDCP TA context is not initialized, psp_set_srm() must take the
+ * guard path and return -EINVAL without updating srm_version or invoking
+ * the (real) firmware path.
+ */
+static void dm_test_psp_set_srm_uninitialized_returns_einval(struct kunit *test)
+{
+	struct psp_context *psp;
+	uint32_t srm_version = 0xdead;
+	u8 srm_buf[4] = {0};
+	int ret;
+
+	psp = kunit_kzalloc(test, sizeof(*psp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, psp);
+
+	/* kzalloc leaves hdcp_context.context.initialized == false */
+	ret = psp_set_srm(psp, srm_buf, sizeof(srm_buf), &srm_version);
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	/* srm_version must be left untouched on the guard path. */
+	KUNIT_EXPECT_EQ(test, srm_version, 0xdead);
+}
+
+/* End of tests for psp_get_srm() and psp_set_srm() */
+
 static struct kunit_case dm_hdcp_test_cases[] = {
 	/* hdcp_get_content_protection_from_status() */
 	KUNIT_CASE(dm_test_hdcp_get_cp_disabled_returns_desired),
@@ -663,6 +784,12 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	KUNIT_CASE(dm_test_hdcp_update_display_disable_resets_status_and_cancels_validate),
 	/* hdcp_create_workqueue() */
 	KUNIT_CASE(dm_test_hdcp_create_workqueue_zero_max_links_returns_null),
+	/* link_lock() */
+	KUNIT_CASE(dm_test_link_lock_locks_and_unlocks_all_links),
+	KUNIT_CASE(dm_test_link_lock_zero_links_is_noop),
+	/* psp_get_srm() / psp_set_srm() */
+	KUNIT_CASE(dm_test_psp_get_srm_uninitialized_returns_null),
+	KUNIT_CASE(dm_test_psp_set_srm_uninitialized_returns_einval),
 	{}
 };
 
-- 
2.53.0

