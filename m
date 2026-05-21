Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7A3CD5BAF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 16:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F3710E4C3;
	Thu, 21 May 2026 16:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g+XU/+vU";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD0410E4C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 16:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckCGd//SuI0J9+wtRci603hxERH4K69BJ3k2jFT03wmikWCRtmt2xbYvsYXC2YVVq4G3GE+/aFgjz/1PQMJOy4SUA10ND6anQBgwLjevl0LtunanqJhSA/heJjWOJ8nNkqh8Ub+wdcexSuXeWbcQjumEQxO4/LdD8yqBJybZjzuBhsq9g8Gbd6OactQjOyXL9T9tZqasdBEVdm5to4kVJQGwJAn1l4+C3ssRsHnZ8hUsvyO6sfIZs9qsQomoJKNBBia1KkzSWjTGwmaNm/7uIxWJc+2u2Exsorxx3oBdmHT/p6a0T1679Yvvku8ES8kANMIppi/87aJuuA9UrX8IpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31GtDdcW5BAv+eEz00Q7hVeZ7KkMmpWCQuz1hwGDOpI=;
 b=hjlJ8XgQyGyzdHY8Zy6+FRB2IF7llj8s0ZkE/9bXnW10s6M3ufapF40YwPVXhl+eUXzIljPA5veSQZ2S7aBG1BrMIqoeQfZFjik7KVI4ypJbibELQs6dInBa36a+DymqmEWGUeWWnx6urkZYY1vfru03l8qTsiOgD2KLnYBdsf7f3WWSg0xVepfSfA9kJk92DgSdYoSHZW1Q3NtVmeYApeRL61ClZw8ABTpN6Xj+WZB0LYMNqBlEq/LloSKeWGxRCY+A0fgF+wawNgakLEoNSlDgRPBE1kdoUop9eozAe2RZCqpar+cV1XvoRiDjegO1pzIrt6+cYBs3V2lTnGLcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31GtDdcW5BAv+eEz00Q7hVeZ7KkMmpWCQuz1hwGDOpI=;
 b=g+XU/+vUZw4WSVu1RgdoGZx4W5IVIE70bnRo+gUclG1FiDXFXSHXCAs5AofKq4gSZppbS8mxuqHFoZfzEcoxkDuMRvCudXLjFAcaSf/uuWznvOTkiqcIZuCYfNMBWPMkW8RcKAtkpZj9VVVWqt1Uc3tcd5Uds5ZkddgYr2u9TkQ=
Received: from BN9PR03CA0914.namprd03.prod.outlook.com (2603:10b6:408:107::19)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 16:35:26 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::68) by BN9PR03CA0914.outlook.office365.com
 (2603:10b6:408:107::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 16:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 16:35:24 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 11:35:22 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>,
 <alexander.deucher@amd.com>, <chenglei.xie@amd.com>, <YiPeng.Chai@amd.com>,
 <Tony.Yi@amd.com>
Subject: [PATCH v4] drm/amdgpu: grow VF RAS bad page table with bounded
 dynamic alloc
Date: Thu, 21 May 2026 12:35:17 -0400
Message-ID: <20260521163517.1823660-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508180705.217683-1-Chenglei.Xie@amd.com>
References: <20260508180705.217683-1-Chenglei.Xie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: aacb75fb-5964-4a05-35a5-08deb756f5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Wl4kqmvJe6LnAf2D0AnAsukaLnZO3EBqX8LhC4xan1NBsKeTesy6Sa0QqIwfFj1jvo7sOFccgd11R2+3EWg366az9EO8P5eFNqotFYXSniSb+ruiLB75pY1DOVMgXzJP3Hrm7jsvRnZxfJAFwea/MbuLW7cbwZwmmEy4ubhfRXs7eoH0dWibJhwmNXoFmd8FjuNQ14aKonnB0fRwd4vRXYKyaRrq7aeRTJyOoA9zz51onQ5A9pXbIDaZjugf5J4+Pi8t3QGdJT4QodxyO4aPzFzhNuih+1eUh59x5nked6rfAM8s2iVphimm5ga9aI+uHDx5b1iU/KE7wICRJTQJ9ki5tnDPghc54OLc5n04SYrl94UOB2kCvIZeMI79ImBT04yV50cIN3U41Rj88PgnDIvqB8gQ+ozwKUmjviJDRRcIxw87fu1i4vFYzcaVI398mii/vg7eLjsXFjvkNpNGXFVtGJlstqf1aoaSDIVz9QueNkakqvSNBj0LHOxu7uYGB3PLx+hljAX6kz4EAeh2Mj6A1QL7p45Txc2lRVhUqolHPwERSmhCFxZpWqoce5hua8fXLUbWdA36df7NUzZcm5j9ZV9oShHUXhgFQ0g4H+LwK1Q/1Zhkw9Yv1KCoSBNxyfbxo9P0jmBDETxK6bQV57UTxE1SODpytkPZQ2lPGVgo05KL/BluU/4HM90CYXaJ8ocXaWKoZxEGrT1GuHg/gNmbnoX+6syVmoEjqzxsxT0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0GA556+71HGcqdayWZIhFJ8EH1IurmF20BkGgG2DmxfHsA2fUI/H5L+eFx5i/kqxqHjn67A8BrF34X1UZzEuxiQMRV4Fh282/gVTXukB8AxDj9WweKOvKJ8/SNBZ+j4xzbeiJOcbOfyeXQheWcQbVWl0oO5wuyvvnGzN1lLQckIjVKyib62wfpENhs1b7cMqQCPgwJfAyTTheYzajOLdgWOj3PFTVVM4P9rX+A1tSs9ofYTTmaH9L/dZvumAucjml50V5FEO6p6enI+yyhCzmNJJO9kWjmOSMMedCNmLm4yW1tFSx9BAAoOpU1fQOM2QVCTQi3bxKmIV8lJ9dbAi0aZlvPZ8arskw6rspkLbfxlexzcyCSEZzUulXUXcuGWr9BPp/39mT368U2Gfmw/VgK0o8g/aWe7q+4RQou28XbP3qrgD4ZeP/vhH55EphXeF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:35:24.9597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aacb75fb-5964-4a05-35a5-08deb756f5ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087
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

The VF RAS error handler used fixed-size bps[] / bps_bo[] arrays (512
slots). When the PF2VF bad-page block listed more entries than fit,
amdgpu_virt_ras_add_bps() could memcpy() past the end of those arrays.

Replace the fixed backing store with a dynamically grown table:
- Add capacity to track allocated slots separately from count.
- Start at 512 slots and realloc bps / bps_bo together when full.
- Refuse growth beyond RAS_EEPROM_PEAK_RECORD_COUNT, the largest bad
  page record count among supported RAS EEPROM layouts (v1 and v2.1).
- Return failure from amdgpu_virt_ras_add_bps() and stop processing
  the PF2VF block if allocation fails or the cap is reached.

Move shared RAS EEPROM size and per-layout record limit macros into
amdgpu_ras_eeprom.h so the VF cap stays in sync with EEPROM layout.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
Change-Id: Ic8dd487d91436759bee0e201ce90ea1f2266a161
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  17 ---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  28 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 110 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |   2 +
 4 files changed, 120 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index c61389a079822..c7a813e5fa0a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -58,15 +58,6 @@
 #define EEPROM_I2C_MADDR_0      0x0
 #define EEPROM_I2C_MADDR_4      0x40000
 
-/*
- * The 2 macros below represent the actual size in bytes that
- * those entities occupy in the EEPROM memory.
- * RAS_TABLE_RECORD_SIZE is different than sizeof(eeprom_table_record) which
- * uses uint64 to store 6b fields such as retired_page.
- */
-#define RAS_TABLE_HEADER_SIZE   20
-#define RAS_TABLE_RECORD_SIZE   24
-
 /* Table hdr is 'AMDR' */
 #define RAS_TABLE_HDR_VAL       0x414d4452
 
@@ -87,13 +78,9 @@
  * ---------------------------------
  */
 
-/* Assume 2-Mbit size EEPROM and take up the whole space. */
-#define RAS_TBL_SIZE_BYTES      (256 * 1024)
 #define RAS_TABLE_START         0
 #define RAS_HDR_START           RAS_TABLE_START
 #define RAS_RECORD_START        (RAS_HDR_START + RAS_TABLE_HEADER_SIZE)
-#define RAS_MAX_RECORD_COUNT    ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_SIZE) \
-				 / RAS_TABLE_RECORD_SIZE)
 
 /*
  * EEPROM Table structrue v2.1
@@ -116,13 +103,9 @@
  */
 
 /* EEPROM Table V2_1 */
-#define RAS_TABLE_V2_1_INFO_SIZE       256
 #define RAS_TABLE_V2_1_INFO_START      RAS_TABLE_HEADER_SIZE
 #define RAS_RECORD_START_V2_1          (RAS_HDR_START + RAS_TABLE_HEADER_SIZE + \
 					RAS_TABLE_V2_1_INFO_SIZE)
-#define RAS_MAX_RECORD_COUNT_V2_1      ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_SIZE - \
-					RAS_TABLE_V2_1_INFO_SIZE) \
-					/ RAS_TABLE_RECORD_SIZE)
 
 #define RAS_SMU_MESSAGE_TIMEOUT_MS 1000 /* 1s */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index a62114800a92a..4ac0d67f53743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -30,6 +30,34 @@
 #define RAS_TABLE_VER_V2_1         0x00021000
 #define RAS_TABLE_VER_V3           0x00030000
 
+/* Assume 2-Mbit size EEPROM and take up the whole space. */
+#define RAS_TBL_SIZE_BYTES		(256 * 1024)
+#define RAS_TABLE_HEADER_SIZE		20
+#define RAS_TABLE_RECORD_SIZE		24
+
+/* Per-layout bad page record limits (add new EEPROM versions here). */
+#define RAS_MAX_RECORD_COUNT		((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_SIZE) \
+					 / RAS_TABLE_RECORD_SIZE)
+#define RAS_TABLE_V2_1_INFO_SIZE	256
+#define RAS_MAX_RECORD_COUNT_V2_1	((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_SIZE - \
+					  RAS_TABLE_V2_1_INFO_SIZE) \
+					 / RAS_TABLE_RECORD_SIZE)
+
+#define RAS_RECORD_COUNT_MAX(a, b)	((a) > (b) ? (a) : (b))
+
+/*
+ * Upper bound on bad page records for any supported EEPROM layout.
+ * Extend when a new RAS_TABLE_VER_* adds a RAS_MAX_RECORD_COUNT_* macro.
+ */
+#define RAS_EEPROM_PEAK_RECORD_COUNT				\
+	RAS_RECORD_COUNT_MAX(RAS_MAX_RECORD_COUNT,		\
+			     RAS_MAX_RECORD_COUNT_V2_1)
+
+static inline uint32_t amdgpu_ras_eeprom_peak_record_count(void)
+{
+	return RAS_EEPROM_PEAK_RECORD_COUNT;
+}
+
 struct amdgpu_device;
 
 enum amdgpu_ras_gpu_health_status {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index f8e58d12e39ae..fa3df31d3c476 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -283,14 +283,65 @@ unsigned int amd_sriov_msg_checksum(void *obj,
 	return ret;
 }
 
+#define AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY	512
+#define AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY	RAS_EEPROM_PEAK_RECORD_COUNT
+
+/**
+ * amdgpu_virt_ras_realloc_eh_data_space - alloc/realloc VF bad-page @data->bps and @data->bps_bo
+ * @adev: amdgpu device
+ * @data: VF RAS error-handler data
+ * @pages: minimum number of new slots to add beyond @data->capacity
+ *
+ * Return: 0 on success, %-ENOMEM on failure.
+ */
+static int amdgpu_virt_ras_realloc_eh_data_space(struct amdgpu_device *adev,
+		struct amdgpu_virt_ras_err_handler_data *data,
+		int pages)
+{
+	struct eeprom_table_record *new_bps;
+	struct amdgpu_bo **new_bo;
+	unsigned int old_space;
+	unsigned int new_space;
+	unsigned int align_space;
+
+	old_space = (unsigned int)data->capacity;
+	new_space = old_space + max_t(unsigned int, (unsigned int)pages,
+				      (unsigned int)AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY);
+	if (new_space < old_space || new_space > AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY)
+		return -ENOMEM;
+
+	align_space = ALIGN(new_space, AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY);
+	if (align_space > AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY)
+		return -ENOMEM;
+
+	new_bps = kmalloc_array(align_space, sizeof(*data->bps), GFP_KERNEL);
+	new_bo = kcalloc(align_space, sizeof(*data->bps_bo), GFP_KERNEL);
+	if (!new_bps || !new_bo) {
+		kfree(new_bps);
+		kfree(new_bo);
+		dev_warn_ratelimited(adev->dev,
+				     "RAS WARN: failed to grow bad page table to %u slots\n",
+				     align_space);
+		return -ENOMEM;
+	}
+
+	memcpy(new_bps, data->bps, data->count * sizeof(*data->bps));
+	memcpy(new_bo, data->bps_bo, data->count * sizeof(*data->bps_bo));
+
+	kfree(data->bps);
+	kfree(data->bps_bo);
+	data->bps = new_bps;
+	data->bps_bo = new_bo;
+	data->capacity = (int)align_space;
+
+	return 0;
+}
+
 static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 {
 	struct amdgpu_virt *virt = &adev->virt;
 	struct amdgpu_virt_ras_err_handler_data **data = &virt->virt_eh_data;
-	/* GPU will be marked bad on host if bp count more then 10,
-	 * so alloc 512 is enough.
-	 */
-	unsigned int align_space = 512;
+	unsigned int align_space = AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY;
 	void *bps = NULL;
 	struct amdgpu_bo **bps_bo = NULL;
 
@@ -302,12 +353,13 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 	if (!bps)
 		goto bps_failure;
 
-	bps_bo = kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP_KERNEL);
+	bps_bo = kcalloc(align_space, sizeof(*(*data)->bps_bo), GFP_KERNEL);
 	if (!bps_bo)
 		goto bps_bo_failure;
 
 	(*data)->bps = bps;
 	(*data)->bps_bo = bps_bo;
+	(*data)->capacity = align_space;
 	(*data)->count = 0;
 	(*data)->last_reserved = 0;
 
@@ -361,17 +413,33 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev)
 	virt->virt_eh_data = NULL;
 }
 
-static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
-		struct eeprom_table_record *bps, int pages)
+static bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
+		const struct eeprom_table_record *bps, int pages)
 {
 	struct amdgpu_virt *virt = &adev->virt;
 	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
+	int need;
 
-	if (!data)
-		return;
+	if (!data || pages <= 0)
+		return false;
+
+	if (pages > AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY - data->count) {
+		dev_warn_ratelimited(adev->dev,
+				     "RAS WARN: bad page table at capacity (count=%d pages=%d max=%u)\n",
+				     data->count, pages,
+				     AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY);
+		return false;
+	}
+
+	need = data->count + pages;
+	if (need > data->capacity &&
+	    amdgpu_virt_ras_realloc_eh_data_space(adev, data, need - data->capacity))
+		return false;
 
 	memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
 	data->count += pages;
+
+	return true;
 }
 
 static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
@@ -443,20 +511,22 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 
 	memset(&bp, 0, sizeof(bp));
 
-	if (bp_block_size) {
-		bp_cnt = bp_block_size / sizeof(uint64_t);
-		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-			retired_page = *(uint64_t *)(vram_usage_va +
-					bp_block_offset + bp_idx * sizeof(uint64_t));
-			bp.retired_page = retired_page;
+	if (!bp_block_size)
+		return;
 
-			if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
-				continue;
+	bp_cnt = bp_block_size / sizeof(uint64_t);
+	for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
+		retired_page = *(uint64_t *)(vram_usage_va +
+				bp_block_offset + bp_idx * sizeof(uint64_t));
+		bp.retired_page = retired_page;
 
-			amdgpu_virt_ras_add_bps(adev, &bp, 1);
+		if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
+			continue;
 
-			amdgpu_virt_ras_reserve_bps(adev);
-		}
+		if (!amdgpu_virt_ras_add_bps(adev, &bp, 1))
+			break;
+
+		amdgpu_virt_ras_reserve_bps(adev);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index d563deec0916b..d8500c3e48a17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -265,6 +265,8 @@ struct amdgpu_virt_ras_err_handler_data {
 	struct eeprom_table_record *bps;
 	/* point to reserved bo array */
 	struct amdgpu_bo **bps_bo;
+	/* number of slots in bps[] / bps_bo[] (always >= count) */
+	int capacity;
 	/* the count of entries */
 	int count;
 	/* last reserved entry's index + 1 */
-- 
2.34.1

