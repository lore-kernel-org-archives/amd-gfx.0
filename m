Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B68CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 07:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382A010E708;
	Wed, 29 Oct 2025 07:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CovgvgGY";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013023.outbound.protection.outlook.com
 [40.93.196.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22C3610E708
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 07:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exPWnoHmBsZ8MXEjjOCBN7cYUtKCHwIruQhSMLvaqrLJ6sHv5SZPJwOgK3mdZ1qCvu9gNRaFe4kKiO5sJREjYpZryk+v4YXzQ/QOwc+PPoCdhW8kCIUvxoTBhO8PN1VvzTsEYQYqTlZL0zhCT2dcfUaIvUCutUZKR0cZwLrfDB1ykfLTEWuEyJBUI7TLY5q0e8u2Ol59Pu8iRgQnkuTSXe5r1/QkNzlMegDb7vVREYVD/5wPaos2xxlc4cZWd67COmxwilR989XSrnvNU8TaZCMB4yien/QhYkNlCeF/UDQNnQaNDx4VQKUhhiFslTVDsshe1qi12YIaVdxH6pxWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DolKB3sYqgGxbAwFo1Q0L9DyJegei97S1g1oCyVmro=;
 b=pPu5RdHmTh1xexyIjSMJ6fEcYqS4S+ca+Z5m5tuj3brBUqxQPMOnIKW7bDrS+fMJkMoOyghPk9qTf9SdYjENocE7FU0M1MLqmvCzUwjRi8akOOKtuoWRsGoyWxIgTIsgc+XS+IAb5ScnKcpcVdPlnBago0XDMmOtvBQIxeJ3/ssDHotOy3OY5860vm6+pI+y122+RUtl2L6Q6AuWH1TjEJTh1RzzRldeUl6NZG0w3QlEi2DWKAmCZwN/m2+qqy6brW4Ig0ZAPNvAz73HmfQtQd0CNrt0KByDkiQhfxiiWXu99LQIdrTk1aL/SGxEJCRWtZXJFMSnRvNNDdUPvMKWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DolKB3sYqgGxbAwFo1Q0L9DyJegei97S1g1oCyVmro=;
 b=CovgvgGYEg9rVdZZtT5Mss3tnATm3VNxYGXWxU9c5FQfOhd0kIEAPVwA/7yduVs8LyEVNrW6n3YDkMf4m2xKpW636/DjtHJNi5Jk0Ek+UiPQdvZcgriHFvSxXTsvIeh8FJem71VKA5uNjnv2X5tIhi0FRhoRXfCUnSiKDeM4VdY=
Received: from CH0PR03CA0304.namprd03.prod.outlook.com (2603:10b6:610:118::28)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:31:33 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:118:cafe::d5) by CH0PR03CA0304.outlook.office365.com
 (2603:10b6:610:118::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 07:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 07:31:33 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 00:31:31 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH 03/10] drm/amd/pm: implement ras_smu_drv interface for smu
 v13.0.12
Date: Wed, 29 Oct 2025 15:31:01 +0800
Message-ID: <20251029073108.1698129-3-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029073108.1698129-1-ganglxie@amd.com>
References: <20251029073108.1698129-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|MN2PR12MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: f28b7ce4-c293-4ab5-8161-08de16bd2f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vhhE5jm9OhG546L3lcfesD5be6S7QcIpHcI3Tl8N4Bb+2Wn4LDXHLLhGdqGr?=
 =?us-ascii?Q?MKsetW7NUvFEgT2N2G2g6AFTKhPTzZpdQcEJ87J+RGVwe0ArOmnPo7rQzyGz?=
 =?us-ascii?Q?Yn6pJ42XbgdhBEu3aHqRZibcCjZxEmzNw8hIwdtpSxPajdE0lNl1emmKWJnC?=
 =?us-ascii?Q?U1qjoT1G3admEaLiAO/42IyZZYXSO2luQRUTW+Oa1+ygUFB1F7j4cne4V+Ym?=
 =?us-ascii?Q?O4hGc8PwtlcZxqagFQWPcCCk7S+FWpOG8+AUMxEwdXz2Ym4McWBQHqkMV2Ie?=
 =?us-ascii?Q?bviHA1ALX8GXKGDVQQZLZUz8723vXNIbZ2YkBxB3DJNiiAI8yAkI1tanRqE7?=
 =?us-ascii?Q?zHtg/Pjw0u5FJF3KtOG1EuAmVOUxR1UmHmMOJpgHdjl0qPdU6vylO7eV0jJ7?=
 =?us-ascii?Q?ndD6rvQa6q9YNP/uj7YJKQPkUV97o9AWwo+0hEpLzU00hqrcEgEcZN/CHCP/?=
 =?us-ascii?Q?tSzAGRom/p+KcVYSzztReYfZ5vgooKfSnS2Y7ITiCDU46xEOXDVCq3x6PWod?=
 =?us-ascii?Q?gK5xbLpBT8+gJKi8yUj+cnEYn9OhEKHLFtCW9ywH+MSoUi6dyPWnKJtDYIhX?=
 =?us-ascii?Q?JiGhIw4bVvLy5PNigCvsBUnQHZrcWcbqfvvtlrgiMKBE8LCLaC9lkFS243NM?=
 =?us-ascii?Q?jDQbMvC2ezXW71fh3W5Z4VxxSdcGi/y8xlk2fmaQAJG0Qr5g1sgURZM9I6O9?=
 =?us-ascii?Q?s6GTJFi0EbAMclCMV8rvBKUYEDZguf1XVh9/h1LleFyLK3S1UlHiLi21hGXG?=
 =?us-ascii?Q?UTCuIVLNud0N77S6iHySNaxzMNkcUOon7fKPf218Dg1zvpu9Wkccg/csD8HP?=
 =?us-ascii?Q?POJyGw2jSDeaO3GVu88ZaJw7yCxAKfJCxLgmVWGmXhPzDn++1DYHflHBh+9p?=
 =?us-ascii?Q?2h68IlSUp7EyaeyL7SU8CKk1DrOW5CF4n6bJTfihIqIc9rAZPUBiqdjB8Vn4?=
 =?us-ascii?Q?U6yeWflqYkk2QkyrpOQSq53UF4BKq2G/YTqsplWLCg1wqGHrWK3nWCm3lT1a?=
 =?us-ascii?Q?Pd3l8zXsh+aJZYHuIOTnVZy2FabAzH3IYsjFANCJObL2WRMBVO2BvsbkyqVB?=
 =?us-ascii?Q?/JCD4wIe3n64MikyAuYZy/t792ipF2voYyzj98LMz1sAoOB+mvvtZ/OHCxPW?=
 =?us-ascii?Q?iClDESjlb+WNvA49UcAi9HLGQlxgv6lSn1Z6LwIf+dulv3LPtlXIsly/AAWs?=
 =?us-ascii?Q?435y332Bhdt9COY+hZFmVbufo0nhZMrJ4Fb8cZSsVYDi99FP6o7u1kBqyof5?=
 =?us-ascii?Q?kx0K3uWnN2QCQ7xylp4YfZPVXx43ZvuQkXZsRKzd1ve0H00M6se9O92s312N?=
 =?us-ascii?Q?5P1b5wiHJFnSTMJnRF1l9OXXx60UYPT0d6difBJTIQamLUtpS5j6/9oIQhJL?=
 =?us-ascii?Q?4dOx7PUvvkh/lIJUdZsnI2wMI2ZTnyTtD+R3cuup3DWd9ery+1heuGvEHlaZ?=
 =?us-ascii?Q?zw1RVTS1tQWdMVkJdSkQangyLz2g+/hJYMp/gmbWVjwuOar1FPWpIX53+XnI?=
 =?us-ascii?Q?BsD5SB9s8R/jnTG3fxeuZQc+da9zppAjddDPD997bdffwHSP8GZLV/VEqjFN?=
 =?us-ascii?Q?rImYpt1MiD+WoKTSwg8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:31:33.3965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f28b7ce4-c293-4ab5-8161-08de16bd2f7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438
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

implement ras_smu_drv interface for smu v13.0.12

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  26 ++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 129 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |   1 +
 3 files changed, 156 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 556cf4d7b5ef..076e2280d375 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -503,6 +503,32 @@ struct ras_critical_region {
 	uint64_t size;
 };
 
+struct ras_eeprom_table_version {
+	uint32_t minor    : 16;
+	uint32_t major    : 16;
+};
+
+struct ras_eeprom_smu_funcs {
+	int (*get_ras_table_version)(struct amdgpu_device *adev,
+							uint32_t *table_version);
+	int (*get_badpage_count)(struct amdgpu_device *adev, uint32_t *count, uint32_t timeout);
+	int (*get_badpage_mca_addr)(struct amdgpu_device *adev, uint16_t index, uint64_t *mca_addr);
+	int (*set_timestamp)(struct amdgpu_device *adev, uint64_t timestamp);
+	int (*get_timestamp)(struct amdgpu_device *adev,
+							uint16_t index, uint64_t *timestamp);
+	int (*get_badpage_ipid)(struct amdgpu_device *adev, uint16_t index, uint64_t *ipid);
+	int (*erase_ras_table)(struct amdgpu_device *adev, uint32_t *result);
+};
+
+enum ras_smu_feature_flags {
+	RAS_SMU_FEATURE_BIT__RAS_EEPROM = BIT_ULL(0),
+};
+
+struct ras_smu_drv {
+	const struct ras_eeprom_smu_funcs *smu_eeprom_funcs;
+	void (*ras_smu_feature_flags)(struct amdgpu_device *adev, uint64_t *flags);
+};
+
 struct amdgpu_ras {
 	void *ras_mgr;
 	/* ras infrastructure */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 27b950c126ab..14b46e110730 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -34,6 +34,7 @@
 #include "amdgpu_fru_eeprom.h"
 #include <linux/pci.h>
 #include "smu_cmn.h"
+#include "amdgpu_ras.h"
 
 #undef MP1_Public
 #undef smnMP1_FIRMWARE_FLAGS
@@ -941,3 +942,131 @@ const struct smu_temp_funcs smu_v13_0_12_temp_funcs = {
 	.temp_metrics_is_supported = smu_v13_0_12_is_temp_metrics_supported,
 	.get_temp_metrics = smu_v13_0_12_get_temp_metrics,
 };
+
+static int smu_v13_0_12_get_ras_table_version(struct amdgpu_device *adev,
+					      uint32_t *table_version)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetRASTableVersion, 0, table_version);
+}
+
+static int smu_v13_0_12_get_badpage_count(struct amdgpu_device *adev, uint32_t *count,
+					  uint32_t timeout)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint64_t end, now;
+	int ret = 0;
+
+	now = (uint64_t)ktime_to_ms(ktime_get());
+	end = now + timeout;
+	do {
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageCount, 0, count);
+		/* eeprom is not ready */
+		if (ret != -EREMOTEIO)
+			return ret;
+		mdelay(10);
+		now = (uint64_t)ktime_to_ms(ktime_get());
+	} while (now < end);
+
+	return ret;
+}
+
+static int smu_v13_0_12_set_timestamp(struct amdgpu_device *adev, uint64_t timestamp)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_SetTimestamp, (uint32_t)timestamp, 0);
+}
+
+static int smu_v13_0_12_get_timestamp(struct amdgpu_device *adev,
+				      uint16_t index, uint64_t *timestamp)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t temp;
+	int ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetTimestamp, index, &temp);
+	if (!ret)
+		*timestamp = temp;
+
+	return ret;
+}
+
+static int smu_v13_0_12_get_badpage_ipid(struct amdgpu_device *adev,
+					 uint16_t index, uint64_t *ipid)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t temp_arg, temp_ipid_lo, temp_ipid_high;
+	int ret;
+
+	temp_arg = index | (1 << 16);
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_lo);
+	if (ret)
+		return ret;
+
+	temp_arg = index | (2 << 16);
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_high);
+	if (!ret)
+		*ipid = (uint64_t)temp_ipid_high << 32 | temp_ipid_lo;
+	return ret;
+}
+
+static int smu_v13_0_12_erase_ras_table(struct amdgpu_device *adev,
+					uint32_t *result)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_EraseRasTable, 0, result);
+}
+
+static int smu_v13_0_12_get_badpage_mca_addr(struct amdgpu_device *adev,
+					     uint16_t index, uint64_t *mca_addr)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t temp_arg, temp_addr_lo, temp_addr_high;
+	int ret;
+
+	temp_arg = index | (1 << 16);
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_lo);
+	if (ret)
+		return ret;
+
+	temp_arg = index | (2 << 16);
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_high);
+	if (!ret)
+		*mca_addr = (uint64_t)temp_addr_high << 32 | temp_addr_lo;
+	return ret;
+}
+
+static const struct ras_eeprom_smu_funcs smu_v13_0_12_eeprom_smu_funcs = {
+	.get_ras_table_version = smu_v13_0_12_get_ras_table_version,
+	.get_badpage_count = smu_v13_0_12_get_badpage_count,
+	.get_badpage_mca_addr = smu_v13_0_12_get_badpage_mca_addr,
+	.set_timestamp = smu_v13_0_12_set_timestamp,
+	.get_timestamp = smu_v13_0_12_get_timestamp,
+	.get_badpage_ipid = smu_v13_0_12_get_badpage_ipid,
+	.erase_ras_table = smu_v13_0_12_erase_ras_table,
+};
+
+static void smu_v13_0_12_ras_smu_feature_flags(struct amdgpu_device *adev, uint64_t *flags)
+{
+	if (!flags)
+		return;
+
+	*flags = 0ULL;
+}
+
+const struct ras_smu_drv smu_v13_0_12_ras_smu_drv = {
+	.smu_eeprom_funcs = &smu_v13_0_12_eeprom_smu_funcs,
+	.ras_smu_feature_flags = smu_v13_0_12_ras_smu_feature_flags,
+};
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 7ef5f3e66c27..1506594b03dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -99,4 +99,5 @@ int smu_v13_0_12_get_npm_data(struct smu_context *smu,
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
+extern const struct ras_smu_drv smu_v13_0_12_ras_smu_drv;
 #endif
-- 
2.34.1

