Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F960C531CC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0841610F1E1;
	Thu, 23 Jul 2026 20:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QntBAj7d";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A2F310F1E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1q8I6d9AufYZv+1daGSHwncS6TlZA6TauMqzeJtsZke/b1N0MCc57+PiQz7ksNHoiO+17Yvylm6pAWR9lgMrmax6ylo29iMq1qWyDedcJCd249vNfe0jhBnov3Byw6L9oPkuOdzekXQyonPzz5hh7QmDm3osDPpbTt9gxhkP8KiZhTJowV4ijFySQK6yamramBf15SiUg8ukUibaiIg1/EuV4T/GedtSoGd3JR37l8T/XaaD/UCGC3gsEkAgtqORdVdCdJNCzeYvj+dj8xPN4UzRmZOeQV2/xGIu3kKQgZHDLNi+bQCv/9h7zpccT6PKSAnemtKljPVCunXPvtibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEnjiqiFCFSrWh2HE9K7VR9NGAV3WU13S3n+0ZXL9ds=;
 b=BMdRECtqpgKc/tyLCsHUWq6TDe4My5YsIaRqo9eVpUlJ4xduqhty7jdgIe17eaIP49ZLnCngSwHH4K9hyhOildyDQLoJr0MY/rCqwWYyGVNIYdxECTFptKa4pyTkTasaKwt4N45EnbmWWKlTCRMqm0Ydxsv/IOs3zx0yo32KcDgSooQ0WqL05zr+pyvYO6oYJFXKKHsQVWrNdbrVVNOnEjdHiFIMt7vN2UcYpqz9Hi1TOQo6TKuUK5eNXB0vaXyE63CoSJzKFfWw84ol0JJM79ZMsZoODuYCG9fV8vJvjg/FW/i5PvCHRKn8c9Y+UDJ8/ODK/XtuAlYja90CQK0bLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEnjiqiFCFSrWh2HE9K7VR9NGAV3WU13S3n+0ZXL9ds=;
 b=QntBAj7dx6ebSLBh2ROQWOBIU0tS53A91zI17/mlKJX9fVx+72BCeHFE4FOvN+IF0dtYbdfxMjdHW9mKyRQtJlnRIg4GSdVbtw7J7L9fMmVgmDvBcJxJctusAGdPKBkrE9R+qhozSdP9BBXOtMAQ1Yc5gUck/aiagYJzzgTEkoY=
Received: from MN2PR01CA0040.prod.exchangelabs.com (2603:10b6:208:23f::9) by
 PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Thu, 23 Jul 2026 20:19:32 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::86) by MN2PR01CA0040.outlook.office365.com
 (2603:10b6:208:23f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:31 +0000
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
Subject: [PATCH 33/49] drm/amd/display: Add KUnit tests for HDCP DDC link
 adapters
Date: Thu, 23 Jul 2026 16:13:41 -0400
Message-ID: <20260723201908.373300-34-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc084f6-b0b7-42ef-091e-08dee8f7b4b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|22082099003|18002099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: cSHjQhvyg3dOP9cojrzZ52c+f4iQ3rDPQLQKWI40RZCWwQw/edlCjU17D8G2o2s08eCY4a5gcPEIY3H2jd9YWifBxDX5IS6iLY2mdXw5bPm9gtadovIjPNy8/7RlswRIORWA9G26cYlcZgF+MkJpP8CdiwTnHhnNR6hur/NyuHdRQyBvcNrmreY7EcxldkX03wNoqTM+QlLhOgRGk/C+i0WFVm/eyU+ZIFybJC7Khve92mMM19VktaKBNP9wus3azYo5+KD/m1o0Ty59gduWwQlsDGEYljelgc3pWbjexRVQa+r1c33fi75A1hFEjGhR5KsoNYn65YyVzekhn8XeRBQML7U5zJz7MkwrkAuk/9z+c95DURtTrBj/ts5tb6pvAhhYo6iK6ECormgTvCVBpOFUa20xuuvt3Bpc7DJg6UNpw3UHQJilw0asuxGPCRC1a/zJ2LPZMR36uko4iWeGyPk/syXq7/bBdAkAGEvD4HVY2i7oEGM+5yrkjtaw0iBQT1wGoDqSJkxzBdmWfTwYMRnnWeskZQ+PZU/BwBG0lBa4IA2TL2UKd4rmq4lXzTTA5zSkvMB1LUsrX9omMNPSv9gyR+dBabYwdSiEimTMm4utybFaM0UvX4VkqLMf89+dBZZkuaQa/jZvl3ZJLkHXBXKXsXHtOUmADhe85OC9zFP44odnTSp9GQURVflQna0Mqi8Fpol6bkC78zbCV91/PQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JPPtvwrNg65XzFAzmeet2+d5Ezf1MUBNMg/exUJIuZxzSkiARtT6d2iL7LOhHRWbJxTGPKhWx7PqjIyVzKZm3mJf9/YC2jlNmm7OyYmjB7jPSxJDTePvpFISDTfTUjsruVZ9rLqBAB6Dcz2337rHY5N9UZqaV635TbbALdDsnOXcBvUFEJMp0p0d+01dz1NWpSYd4FYQeGMItnW04kNMfbyc1UVPkksLERaKuOi/xaN1fGyatHa3CJr4Hzmkdmvkm7PD/wSml6sL3aPSXAqJoY2XIHfQ1cJrtiN/WSVAJ4n8LjkU1uJGNAdM7vtMpwsOD62Wk3bUATc+IdFpr7AH3N7xDo7e4czvmonroP9+ghQg+wyGh0KiV/YZncELMaA2+ijmKsljk/BLL8RsOhId66SeuMsOdW696TcQXG9PyjgJsSrJPWf1sJK5rt+RAp2g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:31.8584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc084f6-b0b7-42ef-091e-08dee8f7b4b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734
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

Expose the mod_hdcp DDC adapter callbacks for KUnit and add tests:

lp_write_i2c / lp_read_i2c / lp_write_dpcd / lp_read_dpcd use recording
fake i2c and DP aux backends to assert the built payloads (write flag,
address, length, buffer, and the read offset-then-data sequence), plus
failure when the connector is missing.

lp_atomic_write_poll_read_i2c / lp_atomic_write_poll_read_aux cover the
hardware-free early returns (NULL link and a payload too large to convert);
the success path submits fused-IO to the DMCUB and is out of reach for a
unit test.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  50 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |  16 +
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 378 ++++++++++++++++++
 3 files changed, 420 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 9ea0a120af6f..c887a70ae74d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -38,8 +38,7 @@
  */
 #define PSP_SRM_VERSION_MAX 0xFFFF
 
-static bool
-lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
+STATIC_IFN_KUNIT bool lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
 {
 	struct dc_link *link = handle;
 	struct i2c_payload i2c_payloads[] = {{true, address, size, (void *)data} };
@@ -48,9 +47,9 @@ lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
 
 	return dm_helpers_submit_i2c(link->ctx, link, &cmd);
 }
+EXPORT_IF_KUNIT(lp_write_i2c);
 
-static bool
-lp_read_i2c(void *handle, uint32_t address, uint8_t offset, uint8_t *data, uint32_t size)
+STATIC_IFN_KUNIT bool lp_read_i2c(void *handle, uint32_t address, uint8_t offset, uint8_t *data, uint32_t size)
 {
 	struct dc_link *link = handle;
 
@@ -61,50 +60,53 @@ lp_read_i2c(void *handle, uint32_t address, uint8_t offset, uint8_t *data, uint3
 
 	return dm_helpers_submit_i2c(link->ctx, link, &cmd);
 }
+EXPORT_IF_KUNIT(lp_read_i2c);
 
-static bool
-lp_write_dpcd(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
+STATIC_IFN_KUNIT bool lp_write_dpcd(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
 {
 	struct dc_link *link = handle;
 
 	return dm_helpers_dp_write_dpcd(link->ctx, link, address, data, size);
 }
+EXPORT_IF_KUNIT(lp_write_dpcd);
 
-static bool
-lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
+STATIC_IFN_KUNIT bool lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
 {
 	struct dc_link *link = handle;
 
 	return dm_helpers_dp_read_dpcd(link->ctx, link, address, data, size);
 }
-
-static bool lp_atomic_write_poll_read_i2c(
-		void *handle,
-		const struct mod_hdcp_atomic_op_i2c *write,
-		const struct mod_hdcp_atomic_op_i2c *poll,
-		struct mod_hdcp_atomic_op_i2c *read,
-		uint32_t poll_timeout_us,
-		uint8_t poll_mask_msb
+EXPORT_IF_KUNIT(lp_read_dpcd);
+
+STATIC_IFN_KUNIT bool lp_atomic_write_poll_read_i2c(
+						void *handle,
+						const struct mod_hdcp_atomic_op_i2c *write,
+						const struct mod_hdcp_atomic_op_i2c *poll,
+						struct mod_hdcp_atomic_op_i2c *read,
+						uint32_t poll_timeout_us,
+						uint8_t poll_mask_msb
 )
 {
 	struct dc_link *link = handle;
 
 	return dm_atomic_write_poll_read_i2c(link, write, poll, read, poll_timeout_us, poll_mask_msb);
 }
-
-static bool lp_atomic_write_poll_read_aux(
-		void *handle,
-		const struct mod_hdcp_atomic_op_aux *write,
-		const struct mod_hdcp_atomic_op_aux *poll,
-		struct mod_hdcp_atomic_op_aux *read,
-		uint32_t poll_timeout_us,
-		uint8_t poll_mask_msb
+EXPORT_IF_KUNIT(lp_atomic_write_poll_read_i2c);
+
+STATIC_IFN_KUNIT bool lp_atomic_write_poll_read_aux(
+						void *handle,
+						const struct mod_hdcp_atomic_op_aux *write,
+						const struct mod_hdcp_atomic_op_aux *poll,
+						struct mod_hdcp_atomic_op_aux *read,
+						uint32_t poll_timeout_us,
+						uint8_t poll_mask_msb
 )
 {
 	struct dc_link *link = handle;
 
 	return dm_atomic_write_poll_read_aux(link, write, poll, read, poll_timeout_us, poll_mask_msb);
 }
+EXPORT_IF_KUNIT(lp_atomic_write_poll_read_aux);
 
 STATIC_IFN_KUNIT
 uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index e700d019f971..665fa4839a25 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -48,6 +48,8 @@ struct psp_context;
 struct file;
 struct kobject;
 struct bin_attribute;
+struct mod_hdcp_atomic_op_i2c;
+struct mod_hdcp_atomic_op_aux;
 
 struct hdcp_workqueue {
 	struct work_struct cpirq_work;
@@ -134,6 +136,20 @@ ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
 ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
 		      const struct bin_attribute *bin_attr, char *buffer,
 		      loff_t pos, size_t count);
+bool lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t size);
+bool lp_read_i2c(void *handle, uint32_t address, uint8_t offset, uint8_t *data, uint32_t size);
+bool lp_write_dpcd(void *handle, uint32_t address, const uint8_t *data, uint32_t size);
+bool lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size);
+bool lp_atomic_write_poll_read_i2c(void *handle,
+				   const struct mod_hdcp_atomic_op_i2c *write,
+				   const struct mod_hdcp_atomic_op_i2c *poll,
+				   struct mod_hdcp_atomic_op_i2c *read,
+				   uint32_t poll_timeout_us, uint8_t poll_mask_msb);
+bool lp_atomic_write_poll_read_aux(void *handle,
+				   const struct mod_hdcp_atomic_op_aux *write,
+				   const struct mod_hdcp_atomic_op_aux *poll,
+				   struct mod_hdcp_atomic_op_aux *read,
+				   uint32_t poll_timeout_us, uint8_t poll_mask_msb);
 #endif
 
 #endif /* AMDGPU_DM_AMDGPU_DM_HDCP_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index a8bca05f47a3..838826d274c2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -10,6 +10,9 @@
 #include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/i2c.h>
+
+#include <drm/display/drm_dp_helper.h>
 
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
@@ -1461,6 +1464,369 @@ static void dm_test_srm_data_read_empty_srm_returns_zero(struct kunit *test)
 
 /* End of tests for srm_data_write() and srm_data_read() */
 
+/* Tests for lp_write_i2c() / lp_read_i2c() / lp_write_dpcd() / lp_read_dpcd() */
+
+/* Defined further below with the display helper tests. */
+static struct amdgpu_dm_connector *alloc_test_connector(struct kunit *test,
+						       unsigned int index);
+
+/*
+ * Recording fakes for the DDC layer. The lp_* wrappers build i2c/DPCD
+ * transactions and forward them through dm_helpers_*, which end up calling
+ * i2c_transfer() / drm_dp_dpcd_*(). These fakes capture the resulting
+ * messages so the tests can assert what the wrappers built, without touching
+ * real hardware. KUnit runs cases sequentially, so file-scope capture state
+ * is reset at the start of each test.
+ */
+#define FAKE_DDC_MAX_MSGS 4
+
+static struct fake_i2c_capture {
+	int num;
+	struct i2c_msg msgs[FAKE_DDC_MAX_MSGS];
+} fake_i2c_cap;
+
+static int fake_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+				int num)
+{
+	int i;
+
+	fake_i2c_cap.num = num;
+	for (i = 0; i < num && i < FAKE_DDC_MAX_MSGS; i++)
+		fake_i2c_cap.msgs[i] = msgs[i];
+
+	return num;
+}
+
+static u32 fake_i2c_functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C;
+}
+
+static const struct i2c_algorithm fake_i2c_algo = {
+	.master_xfer = fake_i2c_master_xfer,
+	.functionality = fake_i2c_functionality,
+};
+
+static void fake_i2c_lock_bus(struct i2c_adapter *adap, unsigned int flags) {}
+static int fake_i2c_trylock_bus(struct i2c_adapter *adap, unsigned int flags)
+{
+	return 1;
+}
+static void fake_i2c_unlock_bus(struct i2c_adapter *adap, unsigned int flags) {}
+
+static const struct i2c_lock_operations fake_i2c_lock_ops = {
+	.lock_bus = fake_i2c_lock_bus,
+	.trylock_bus = fake_i2c_trylock_bus,
+	.unlock_bus = fake_i2c_unlock_bus,
+};
+
+static struct fake_aux_capture {
+	int calls;
+	u8 request;
+	unsigned int address;
+	size_t size;
+} fake_aux_cap;
+
+static ssize_t fake_aux_transfer(struct drm_dp_aux *aux,
+				 struct drm_dp_aux_msg *msg)
+{
+	fake_aux_cap.calls++;
+	fake_aux_cap.request = msg->request;
+	fake_aux_cap.address = msg->address;
+	fake_aux_cap.size = msg->size;
+	msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+
+	return msg->size;
+}
+
+/**
+ * alloc_test_ddc_link - connector/link wired to the recording i2c + aux fakes
+ * @test: KUnit test context for managed allocation
+ *
+ * Builds an amdgpu_dm_connector with a fake i2c adapter and a fake DP aux, and
+ * points link->priv at the connector so dm_helpers_* find it. Returns the
+ * dc_link that the lp_* wrappers take as their opaque handle.
+ */
+static struct dc_link *alloc_test_ddc_link(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = alloc_test_connector(test, 0);
+	struct amdgpu_i2c_adapter *i2c;
+	struct dc_link *link;
+
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	i2c = kunit_kzalloc(test, sizeof(*i2c), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, i2c);
+	i2c->base.algo = &fake_i2c_algo;
+	i2c->base.lock_ops = &fake_i2c_lock_ops;
+	aconnector->i2c = i2c;
+
+	mutex_init(&aconnector->dm_dp_aux.aux.hw_mutex);
+	aconnector->dm_dp_aux.aux.transfer = fake_aux_transfer;
+	/* Skip the DPCD "throw away" probe read so we capture only our access. */
+	aconnector->dm_dp_aux.aux.dpcd_probe_disabled = true;
+
+	link = aconnector->dc_link;
+	link->priv = aconnector;
+
+	return link;
+}
+
+/**
+ * dm_test_lp_write_i2c_builds_single_write_payload - write builds one i2c msg
+ * @test: KUnit test context
+ *
+ * lp_write_i2c() must forward a single write payload carrying the address,
+ * length and data buffer unchanged.
+ */
+static void dm_test_lp_write_i2c_builds_single_write_payload(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_ddc_link(test);
+	u8 data[3] = {0x11, 0x22, 0x33};
+	bool ok;
+
+	memset(&fake_i2c_cap, 0, sizeof(fake_i2c_cap));
+
+	ok = lp_write_i2c(link, 0x3a, data, sizeof(data));
+
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_ASSERT_EQ(test, fake_i2c_cap.num, 1);
+	/* write => flags without I2C_M_RD */
+	KUNIT_EXPECT_EQ(test, (int)fake_i2c_cap.msgs[0].flags, 0);
+	KUNIT_EXPECT_EQ(test, (int)fake_i2c_cap.msgs[0].addr, 0x3a);
+	KUNIT_EXPECT_EQ(test, (int)fake_i2c_cap.msgs[0].len, (int)sizeof(data));
+	KUNIT_EXPECT_PTR_EQ(test, fake_i2c_cap.msgs[0].buf, (void *)data);
+}
+
+/**
+ * dm_test_lp_read_i2c_builds_offset_then_read - read builds offset + read msgs
+ * @test: KUnit test context
+ *
+ * lp_read_i2c() must build a 1-byte write of the offset followed by a
+ * size-byte read into the caller buffer, both at the same address.
+ */
+static void dm_test_lp_read_i2c_builds_offset_then_read(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_ddc_link(test);
+	u8 data[4];
+	bool ok;
+
+	memset(&fake_i2c_cap, 0, sizeof(fake_i2c_cap));
+
+	ok = lp_read_i2c(link, 0x50, 0x07, data, sizeof(data));
+
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_ASSERT_EQ(test, fake_i2c_cap.num, 2);
+	/* first: 1-byte write of the offset */
+	KUNIT_EXPECT_EQ(test, (int)fake_i2c_cap.msgs[0].flags, 0);
+	KUNIT_EXPECT_EQ(test, (int)fake_i2c_cap.msgs[0].addr, 0x50);
+	KUNIT_EXPECT_EQ(test, (int)fake_i2c_cap.msgs[0].len, 1);
+	/* second: size-byte read into the caller buffer */
+	KUNIT_EXPECT_EQ(test, (int)fake_i2c_cap.msgs[1].flags, I2C_M_RD);
+	KUNIT_EXPECT_EQ(test, (int)fake_i2c_cap.msgs[1].addr, 0x50);
+	KUNIT_EXPECT_EQ(test, (int)fake_i2c_cap.msgs[1].len, (int)sizeof(data));
+	KUNIT_EXPECT_PTR_EQ(test, fake_i2c_cap.msgs[1].buf, (void *)data);
+}
+
+/**
+ * dm_test_lp_write_dpcd_forwards_native_write - write forwards a native write
+ * @test: KUnit test context
+ *
+ * lp_write_dpcd() must issue a single DP_AUX_NATIVE_WRITE at the requested
+ * address for the requested size.
+ */
+static void dm_test_lp_write_dpcd_forwards_native_write(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_ddc_link(test);
+	u8 data[2] = {0xDE, 0xAD};
+	bool ok;
+
+	memset(&fake_aux_cap, 0, sizeof(fake_aux_cap));
+
+	ok = lp_write_dpcd(link, 0x68000, data, sizeof(data));
+
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, fake_aux_cap.calls, 1);
+	KUNIT_EXPECT_EQ(test, (int)fake_aux_cap.request, DP_AUX_NATIVE_WRITE);
+	KUNIT_EXPECT_EQ(test, fake_aux_cap.address, 0x68000u);
+	KUNIT_EXPECT_EQ(test, (int)fake_aux_cap.size, (int)sizeof(data));
+}
+
+/**
+ * dm_test_lp_read_dpcd_forwards_native_read - read forwards a native read
+ * @test: KUnit test context
+ *
+ * lp_read_dpcd() must issue a single DP_AUX_NATIVE_READ at the requested
+ * address for the requested size.
+ */
+static void dm_test_lp_read_dpcd_forwards_native_read(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_ddc_link(test);
+	u8 data[4];
+	bool ok;
+
+	memset(&fake_aux_cap, 0, sizeof(fake_aux_cap));
+
+	ok = lp_read_dpcd(link, 0x00220, data, sizeof(data));
+
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, fake_aux_cap.calls, 1);
+	KUNIT_EXPECT_EQ(test, (int)fake_aux_cap.request, DP_AUX_NATIVE_READ);
+	KUNIT_EXPECT_EQ(test, fake_aux_cap.address, 0x00220u);
+	KUNIT_EXPECT_EQ(test, (int)fake_aux_cap.size, (int)sizeof(data));
+}
+
+/**
+ * dm_test_lp_write_i2c_no_connector_returns_false - missing connector fails
+ * @test: KUnit test context
+ *
+ * When link->priv has no connector, dm_helpers_submit_i2c() cannot proceed,
+ * so lp_write_i2c() must report failure without invoking the adapter.
+ */
+static void dm_test_lp_write_i2c_no_connector_returns_false(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_ddc_link(test);
+	u8 data[2] = {0x01, 0x02};
+	bool ok;
+
+	link->priv = NULL;
+	memset(&fake_i2c_cap, 0, sizeof(fake_i2c_cap));
+
+	ok = lp_write_i2c(link, 0x3a, data, sizeof(data));
+
+	KUNIT_EXPECT_FALSE(test, ok);
+	KUNIT_EXPECT_EQ(test, fake_i2c_cap.num, 0);
+}
+
+/**
+ * dm_test_lp_read_dpcd_no_connector_returns_false - missing connector fails
+ * @test: KUnit test context
+ *
+ * When link->priv has no connector, dm_helpers_dp_read_dpcd() cannot proceed,
+ * so lp_read_dpcd() must report failure without invoking the aux transfer.
+ */
+static void dm_test_lp_read_dpcd_no_connector_returns_false(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_ddc_link(test);
+	u8 data[4];
+	bool ok;
+
+	link->priv = NULL;
+	memset(&fake_aux_cap, 0, sizeof(fake_aux_cap));
+
+	ok = lp_read_dpcd(link, 0x00220, data, sizeof(data));
+
+	KUNIT_EXPECT_FALSE(test, ok);
+	KUNIT_EXPECT_EQ(test, fake_aux_cap.calls, 0);
+}
+
+/* End of tests for lp_write_i2c() / lp_read_i2c() / lp_write_dpcd() / lp_read_dpcd() */
+
+/*
+ * Tests for lp_atomic_write_poll_read_i2c() / lp_atomic_write_poll_read_aux()
+ *
+ * These wrappers cast the opaque handle to a dc_link and forward to the
+ * dc_fused_io helpers. The success path submits a fused-IO command sequence to
+ * the DMCUB, which is out of reach for a unit test, so the coverage here is the
+ * hardware-free early returns: a NULL link and a payload that fails conversion
+ * (op size larger than the fused request buffer).
+ */
+
+/**
+ * dm_test_lp_atomic_i2c_null_handle_returns_false - NULL link fails cleanly
+ * @test: KUnit test context
+ *
+ * With a NULL handle the forwarded dc_link is NULL, so the helper must return
+ * false without dereferencing anything.
+ */
+static void dm_test_lp_atomic_i2c_null_handle_returns_false(struct kunit *test)
+{
+	struct mod_hdcp_atomic_op_i2c op = { 0 };
+
+	KUNIT_EXPECT_FALSE(test,
+			   lp_atomic_write_poll_read_i2c(NULL, &op, &op, &op, 0, 0));
+}
+
+/**
+ * dm_test_lp_atomic_i2c_oversized_op_returns_false - bad payload fails conversion
+ * @test: KUnit test context
+ *
+ * An op whose size exceeds the fused request buffer must fail conversion, so
+ * the helper returns false before any fused-IO submission. no_ddc_pin routes
+ * the DDC line through aux_hw_inst, avoiding the GPIO pin dereference.
+ */
+static void dm_test_lp_atomic_i2c_oversized_op_returns_false(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = alloc_test_connector(test, 0);
+	struct mod_hdcp_atomic_op_i2c write = { .size = 0x100 };
+	struct mod_hdcp_atomic_op_i2c op = { 0 };
+	struct dc_link *link;
+
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	link = aconnector->dc_link;
+	link->no_ddc_pin = true;
+
+	KUNIT_EXPECT_FALSE(test,
+			   lp_atomic_write_poll_read_i2c(link, &write, &op, &op, 0, 0));
+}
+
+/**
+ * dm_test_lp_atomic_aux_null_handle_returns_false - NULL link fails cleanly
+ * @test: KUnit test context
+ *
+ * With a NULL handle the forwarded dc_link is NULL, so the helper must return
+ * false without dereferencing anything.
+ */
+static void dm_test_lp_atomic_aux_null_handle_returns_false(struct kunit *test)
+{
+	struct mod_hdcp_atomic_op_aux op = { 0 };
+
+	KUNIT_EXPECT_FALSE(test,
+			   lp_atomic_write_poll_read_aux(NULL, &op, &op, &op, 0, 0));
+}
+
+/**
+ * dm_test_lp_atomic_aux_oversized_op_returns_false - bad payload fails conversion
+ * @test: KUnit test context
+ *
+ * The aux helper reads the DDC line from link->ddc->ddc_pin->pin_data before
+ * converting, so a minimal pin chain is wired up. An op larger than the fused
+ * request buffer then fails conversion and the helper returns false without
+ * any fused-IO submission.
+ */
+static void dm_test_lp_atomic_aux_oversized_op_returns_false(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = alloc_test_connector(test, 0);
+	struct mod_hdcp_atomic_op_aux write = { .size = 0x100 };
+	struct mod_hdcp_atomic_op_aux op = { 0 };
+	struct ddc_service *ddc;
+	struct ddc *ddc_pin;
+	struct dc_link *link;
+	void *pin_data;
+
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
+	ddc_pin = kunit_kzalloc(test, sizeof(*ddc_pin), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ddc_pin);
+	/* Only ->en is read; over-allocate so struct gpio stays opaque here. */
+	pin_data = kunit_kzalloc(test, 128, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pin_data);
+
+	ddc_pin->pin_data = pin_data;
+	ddc->ddc_pin = ddc_pin;
+
+	link = aconnector->dc_link;
+	link->ddc = ddc;
+
+	KUNIT_EXPECT_FALSE(test,
+			   lp_atomic_write_poll_read_aux(link, &write, &op, &op, 0, 0));
+}
+
+/* End of tests for lp_atomic_write_poll_read_i2c() / lp_atomic_write_poll_read_aux() */
+
 /*
  * Tests for hdcp_update_display() / hdcp_remove_display() /
  * hdcp_reset_display().
@@ -1994,6 +2360,18 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	KUNIT_CASE(dm_test_srm_data_write_uninitialized_ta_keeps_srm),
 	KUNIT_CASE(dm_test_srm_data_read_uninitialized_ta_returns_einval),
 	KUNIT_CASE(dm_test_srm_data_read_empty_srm_returns_zero),
+	/* lp_write_i2c() / lp_read_i2c() / lp_write_dpcd() / lp_read_dpcd() */
+	KUNIT_CASE(dm_test_lp_write_i2c_builds_single_write_payload),
+	KUNIT_CASE(dm_test_lp_read_i2c_builds_offset_then_read),
+	KUNIT_CASE(dm_test_lp_write_dpcd_forwards_native_write),
+	KUNIT_CASE(dm_test_lp_read_dpcd_forwards_native_read),
+	KUNIT_CASE(dm_test_lp_write_i2c_no_connector_returns_false),
+	KUNIT_CASE(dm_test_lp_read_dpcd_no_connector_returns_false),
+	/* lp_atomic_write_poll_read_i2c() / lp_atomic_write_poll_read_aux() */
+	KUNIT_CASE(dm_test_lp_atomic_i2c_null_handle_returns_false),
+	KUNIT_CASE(dm_test_lp_atomic_i2c_oversized_op_returns_false),
+	KUNIT_CASE(dm_test_lp_atomic_aux_null_handle_returns_false),
+	KUNIT_CASE(dm_test_lp_atomic_aux_oversized_op_returns_false),
 	/* hdcp_update_display() / hdcp_remove_display() / hdcp_reset_display() */
 	KUNIT_CASE(dm_test_hdcp_update_display_enable_registers_connector),
 	KUNIT_CASE(dm_test_hdcp_update_display_disable_sets_status_off),
-- 
2.53.0

