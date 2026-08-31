Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBECC624C6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9501310EA72;
	Mon, 31 Aug 2026 18:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bLvx8CAz";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012033.outbound.protection.outlook.com
 [40.93.195.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF96510E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5NmCRcZsgFCRpn9mbfeb+Z51ne/8eX2mDL4G5x9S9IoRGxdVjvkoFFoX2M3WwWedfOq/gcAb0kACnpaOz0Q58Cgy7MV9FV0vjfHiVrXZQZ4E3xdUZC7mUxGtDThb4uccqR4qBxNKQ/VouCkmI1LdV2lkDXD2wj6BTGh+/1w3simO9F/qTX58FCkffAv6v+qBkQq4PcVw7yTWaWM22jqsZkSYUZD/TxjXw8g6vG2XoST7xCyM8fcu4pa/8HyysahQUBcCy9LtSo4bbqjTfyqz6EUoCrPS1vxI8ICqmU4vOxQf0vzabWZlZZdL9JRH7fWy6TNIe/9Gvr3PCVNHNBEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkkSDEY8Q8ApLqWscpDRZA0GSkZj+6GCzqSkrioEyAA=;
 b=o1v558ZVsLFmxj8qjy6gLiqGc6LdBXl+dMEmhZUIIrp0ep11zd9BF/pmlF07BshzflUSFW8/DDe2gNYSH2U2ooO82ATzCKa84Qp1mm/HmPCAtEauhk/Iu80mxHXuwaK27cioNaQgzyqmqEI42SZHMFgmu6xQbRc6DgvztYj24mRamroffi1XaQWMzYGdXeY7WmMM41dbroO0ffoPcJQL45/gZUi0KjmP+rDzejlxYoInVideqh5aJwtaREoYLOQPXx05ZY5FpUk8FlQlagQ+1Y53TQERDecobUFB+Rx8v9ynwBoet5jlTj+/ErRvA+J+v21Qtoj0XJwKcqaLDifLAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkkSDEY8Q8ApLqWscpDRZA0GSkZj+6GCzqSkrioEyAA=;
 b=bLvx8CAzJf+Q6wfoERJi0QM9WBbyn4W6DkULuLnCETaE0xfsNRpRFfIbrSacG+cTmAJ+tQ/nMXfQBKyrqJOHSR48hq5XzebStwuC94uC/5r7mQLw14lBrJlmJx6m1yBa1TaQDyF5N9tzCB+F8wZr6N+eS4HhwhHejq7u0COr78w=
Received: from BN9PR03CA0637.namprd03.prod.outlook.com (2603:10b6:408:13b::12)
 by PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:20 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::5) by BN9PR03CA0637.outlook.office365.com
 (2603:10b6:408:13b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/95] drm/amdgpu: Add sysfs API for UALink physical pod setup
Date: Mon, 31 Aug 2026 14:26:23 -0400
Message-ID: <20260831182754.1089811-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: c41b44a4-0869-4a74-fb07-08df078da0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YHTFGUw97jMWnzhv41JSC6AeTz+MvS+AOtHG3DSYcmioj9xVW5DEI6N372dKp3X/xhRiYoUKS3kJvtlkRsg2R3YVPfQjxWJxs+eDPwfZOQDGh46JWU93StetarfakZ6EnStgrOkUWpBVT7kqwXm1moqjxRH1dk6Kk25gPTq2c/zylz85SnoMtaK3is9b4tHLBcR3diNKHbKyDW9oDuouJP27kzuQmNRu50N2z42QSonwVaxG1eF7O/eqo6zB7eJvPxlertjdiULQ5vWyO/Ph2TRcwsNCnkU77GNcetG036YqMLKcgWrXQ+vdktBMD22tBbIU6tTSppDtlfngsxnzVZHkZmKX80lUNUCsbeo0erp4EN8L5t43rn2s8l/2rfrFbO/RUV7nPj4qtDPXomLI1G1VfZy4Bwk4ffbEkmBVSHaSRBAmoEOqkwuMy5I24HAHs6mjiHf0IjrCs64MqDQ5yp5RDXcvHYeVTb4DiwA0VY+2hdLlvCUGWE808rqR1wmdyQHiBU0yc2kVSHKVjFPBiXU61ff4TkHBCKjoGBTKkFrpRUn0iWPNZFKXffpcl11pV9TDnOY39MZkMz83HhHBHMBQVOkSHkySW1loPjs/9d9IBwyz/VUQmFxUReDe2HS5bXluMQtV/HFwBWCwSS4qvkbYHHSgL1iGghEtvcHvjwXcdilE1pL11814IOZkpveUEdW8rZAaMMgSZZtBxP2VIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SJpQGxPoUXqjky+0dQBRS4g9tvbWpIcJOAw4tcWoMdh3uiWj134HOitgZg9z8088CrH5Kx9l+xsYdpfqd3591qMflrpM7lWHJ7mAH4GugXlGmNHYm0FwprZrQq64D6XAmSJkoRA2NrZ0JCxCZ10x06yeCQxo05iWolCd8wTAj3HMFb78UbNjn/vpUn54wdGlBOT4AGYSB4igHmpFyvUgqktj7Bju9j3IvFUpcM2ZJnbQzJFjjjl6jiK2WrDlRDx3EkZAOScexNDJsmSkfqSrYElvlC82d+Y4H8llVl6BKkGL8y5zogiraJTUqiQHbMUHHVm0gIPl+UQg5o03MKDXwZIHe2lUTSGp/mSdo0Vs5nErdRuH78W0+O7igZZMBQpDnDjsK9rp82IbhzeWFSstFiNrL/P34pgqXMbX6U/mMAARMhdvwmT3zsGOmlFZF4m4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:17.9508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c41b44a4-0869-4a74-fb07-08df078da0d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977
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

From: Felix Kuehling <felix.kuehling@amd.com>

<device>/ualink/setup: Directory for staging physical pod setup
attributes. Write "true" to commit to apply settings

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 226 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  11 +
 2 files changed, 237 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 374242372eab7..92c449f2004d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -37,6 +37,17 @@
  * device itself or a subdevice.
  ****************************************************************************/
 
+/* UALink configuration APIs are being deprecated before upstreaming and are
+ * not enabled by default. They are replaced by a unified in-band/side-band
+ * approach through the IFoE driver. Querying of the current configuration
+ * will continue to be supported in sysfs.
+ *
+ * Uncomment the following line to enable the deprecated configuration APIs
+ * for testing purposes only. The code to support these APIs will be removed
+ * in a future patch.
+ */
+/* #define UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS */
+
 #define UALINK_VALUE_SHOW(prefix, name, field, format)			\
 static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
 					       struct kobj_attribute *attr,\
@@ -46,6 +57,21 @@ static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
 									\
 	return sysfs_emit(buf, format"\n", info->field);		\
 }
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+#define UALINK_VALUE_STORE(prefix, name, field, type, base)		\
+static ssize_t ualink_##prefix##_##name##_store(struct kobject *kobj,	\
+						struct kobj_attribute *attr,\
+						const char *buf, size_t count)\
+{									\
+	struct amdgpu_ualink_##prefix *info = to_ualink_##prefix(kobj);	\
+	int r;								\
+									\
+	r = kstrto##type(buf, base, &info->field);			\
+	if (r < 0)							\
+		return r;						\
+	return count;							\
+}
+#endif
 
 static ssize_t show_idbits(unsigned long *bits, unsigned int nbits, char *buf)
 {
@@ -89,6 +115,67 @@ static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
 	return show_idarray(info->field, info->size, buf);		\
 }
 
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+static ssize_t store_idarray(u32 *array, u32 *size, u32 max_id, u32 max_size,
+			     const char *buf, size_t count)
+{
+	char *dup_buf, *str, *tok;
+	unsigned int index = 0;
+	ssize_t r;
+	u32 id;
+
+	*size = 0;
+	if (!count)
+		return 0;
+
+	dup_buf = kstrndup(buf, count, GFP_KERNEL);
+	if (unlikely(!dup_buf))
+		return -ENOMEM;
+	str = dup_buf;
+	do {
+		str += strspn(str, " ");
+		tok = strsep(&str, ", ");
+		r = kstrtou32(tok, 10, &id);
+		if (r < 0)
+			goto err;
+		if (index >= max_size) {
+			r = -ENOSPC;
+			goto err;
+		}
+		if (id >= max_id) {
+			r = -ERANGE;
+			goto err;
+		}
+		array[index++] = id;
+	} while (str);
+	kfree(dup_buf);
+
+	*size = index;
+	return count;
+
+err:
+	kfree(dup_buf);
+	return r;
+}
+#define UALINK_IDARRAY_STORE(prefix, name, field, size, max_id)		\
+static ssize_t ualink_##prefix##_##name##_store(struct kobject *kobj,	\
+						struct kobj_attribute *attr,\
+						const char *buf, size_t count)\
+{									\
+	struct amdgpu_ualink_##prefix *info = to_ualink_##prefix(kobj);	\
+	u32 new_array[ARRAY_SIZE(info->field)];				\
+	u32 new_size;							\
+	ssize_t r = store_idarray(new_array, &new_size, max_id,		\
+				  ARRAY_SIZE(new_array), buf, count);	\
+									\
+	if (r >= 0) {							\
+		memcpy(info->field, new_array, sizeof(new_array));	\
+		info->size = new_size;					\
+	}								\
+	return r;							\
+}
+#endif
+
 #define UALINK_UUID_SHOW(prefix, name, field)				\
 static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
 					       struct kobj_attribute *attr,\
@@ -98,6 +185,19 @@ static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
 									\
 	return sysfs_emit(buf, "%pU\n", &info->field);			\
 }
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+#define UALINK_UUID_STORE(prefix, name, field)				\
+static ssize_t ualink_##prefix##_##name##_store(struct kobject *kobj,	\
+						struct kobj_attribute *attr,\
+						const char *buf, size_t count)\
+{									\
+	struct amdgpu_ualink_##prefix *info = to_ualink_##prefix(kobj);	\
+	int r;								\
+									\
+	r = uuid_parse(buf, &info->field);				\
+	return r ? r : count;						\
+}
+#endif
 
 static ssize_t show_enum(u32 x, const char * const values[], unsigned int n,
 			 char *buf)
@@ -180,8 +280,101 @@ static const struct kobj_type ualink_info_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops
 };
 
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+UALINK_VALUE_SHOW(ppod_setup, accel_id,  ppod.accel_id,  "%u");
+UALINK_VALUE_SHOW(ppod_setup, bandwidth, ppod.bandwidth, "%u");
+UALINK_VALUE_SHOW(ppod_setup, latency,   ppod.latency,   "%u");
+UALINK_UUID_SHOW(ppod_setup, ppod_id, ppod.id);
+UALINK_VALUE_SHOW(ppod_setup, ppod_size, ppod.size,      "%u");
+UALINK_IDARRAY_SHOW(ppod_setup, local_accels, local_accels, n_local_accels);
+
+UALINK_VALUE_STORE(ppod_setup, accel_id,  ppod.accel_id,  u32, 10);
+UALINK_VALUE_STORE(ppod_setup, bandwidth, ppod.bandwidth, u32, 10);
+UALINK_VALUE_STORE(ppod_setup, latency,   ppod.latency,   u32, 10);
+UALINK_UUID_STORE(ppod_setup, ppod_id,   ppod.id);
+UALINK_VALUE_STORE(ppod_setup, ppod_size, ppod.size,      u32, 10);
+UALINK_IDARRAY_STORE(ppod_setup, local_accels, local_accels, n_local_accels,
+		     AMDGPU_UALINK_ACCEL_MAX);
+
+static enum amdgpu_ualink_accel_state
+check_ppod_state(struct amdgpu_device *adev,
+		 const struct amdgpu_ualink_ppod_setup *setup)
+{
+	if (setup->ppod.size <= 0 || setup->ppod.size > AMDGPU_UALINK_ACCEL_MAX) {
+		dev_dbg(adev->dev, "pPod size %u out of range [1..%u]\n",
+			setup->ppod.size, AMDGPU_UALINK_ACCEL_MAX);
+		return AMDGPU_UALINK_ACCEL_STATE_UNCONFIGURED;
+	}
+	if (setup->ppod.accel_id >= setup->ppod.size) {
+		dev_dbg(adev->dev, "Accelerator ID %u greater or equal pPod size %u\n",
+			setup->ppod.accel_id, setup->ppod.size);
+		return AMDGPU_UALINK_ACCEL_STATE_UNCONFIGURED;
+	}
+	return AMDGPU_UALINK_ACCEL_STATE_CONFIGURED;
+}
+
+static ssize_t ualink_ppod_setup_commit_store(struct kobject *kobj,
+					      struct kobj_attribute *attr,
+					      const char *buf, size_t count)
+{
+	struct amdgpu_ualink_ppod_setup *setup = to_ualink_ppod_setup(kobj);
+	struct amdgpu_ualink_info *info = to_ualink_info(kobj->parent);
+	struct device *dev = kobj_to_dev(info->kobj.parent);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!sysfs_streq(buf, "true"))
+		return -EINVAL;
+
+	/* TODO: Send configuration to ASP */
+
+	info->ppod = setup->ppod;
+	info->accel_state = check_ppod_state(adev, setup);
+
+	/* TODO: If accel_state was ACTIVE, reset all connections */
+
+	return count;
+}
+
+#define UALINK_PPOD_SETUP_ATTR(name) __ATTR(name, 0600,			\
+		ualink_ppod_setup_##name##_show,			\
+		ualink_ppod_setup_##name##_store)
+static struct kobj_attribute ualink_ppod_setup_accel_id  = UALINK_PPOD_SETUP_ATTR(accel_id);
+static struct kobj_attribute ualink_ppod_setup_bandwidth = UALINK_PPOD_SETUP_ATTR(bandwidth);
+static struct kobj_attribute ualink_ppod_setup_latency   = UALINK_PPOD_SETUP_ATTR(latency);
+static struct kobj_attribute ualink_ppod_setup_ppod_id   = UALINK_PPOD_SETUP_ATTR(ppod_id);
+static struct kobj_attribute ualink_ppod_setup_ppod_size = UALINK_PPOD_SETUP_ATTR(ppod_size);
+static struct kobj_attribute ualink_ppod_setup_local_accels = UALINK_PPOD_SETUP_ATTR(local_accels);
+static struct kobj_attribute ualink_ppod_setup_commit = __ATTR(commit, 0200, NULL,
+							       ualink_ppod_setup_commit_store);
+
+static const struct attribute *ualink_ppod_setup_attrs[] = {
+	&ualink_ppod_setup_accel_id.attr,
+	&ualink_ppod_setup_bandwidth.attr,
+	&ualink_ppod_setup_latency.attr,
+	&ualink_ppod_setup_ppod_id.attr,
+	&ualink_ppod_setup_ppod_size.attr,
+	&ualink_ppod_setup_local_accels.attr,
+	&ualink_ppod_setup_commit.attr,
+	NULL
+};
+#endif
+
+static void ualink_ppod_setup_release(struct kobject *kobj)
+{
+	struct amdgpu_ualink_ppod_setup *setup = to_ualink_ppod_setup(kobj);
+
+	kfree(setup);
+}
+
+static const struct kobj_type ualink_ppod_setup_ktype = {
+	.release = ualink_ppod_setup_release,
+	.sysfs_ops = &kobj_sysfs_ops
+};
+
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 {
+	struct amdgpu_ualink_ppod_setup *ppod_setup = NULL;
 	struct amdgpu_ualink_info *info = NULL;
 	int r;
 
@@ -203,10 +396,34 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 	if (r)
 		goto err_del_info;
 
+	ppod_setup = kzalloc(sizeof(*ppod_setup), GFP_KERNEL);
+	if (!ppod_setup) {
+		r = -ENOMEM;
+		goto err_remove_info_files;
+	}
+	r = kobject_init_and_add(&ppod_setup->kobj, &ualink_ppod_setup_ktype,
+				 &info->kobj, "setup");
+	if (r)
+		goto err_put_ppod_setup;
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+	r = sysfs_create_files(&ppod_setup->kobj, ualink_ppod_setup_attrs);
+	if (r)
+		goto err_del_ppod_setup;
+#endif
+
+	adev->ualink.setup = ppod_setup;
 	adev->ualink.info = info;
 
 	return r;
 
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+err_del_ppod_setup:
+	kobject_del(&ppod_setup->kobj);
+#endif
+err_put_ppod_setup:
+	kobject_put(&ppod_setup->kobj);
+err_remove_info_files:
+	sysfs_remove_files(&info->kobj, ualink_info_attrs);
 err_del_info:
 	kobject_del(&info->kobj);
 err_put_info:
@@ -216,6 +433,15 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
 {
+	if (adev->ualink.setup) {
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+		sysfs_remove_files(&adev->ualink.setup->kobj,
+				   ualink_ppod_setup_attrs);
+#endif
+		kobject_del(&adev->ualink.setup->kobj);
+		kobject_put(&adev->ualink.setup->kobj);
+		adev->ualink.setup = NULL;
+	}
 	if (adev->ualink.info) {
 		sysfs_remove_files(&adev->ualink.info->kobj,
 				   ualink_info_attrs);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 9c492e7518d9f..1c1fb41e75140 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -87,8 +87,19 @@ struct amdgpu_ualink_info {
 };
 #define to_ualink_info(ko) container_of(ko, struct amdgpu_ualink_info, kobj)
 
+/* UALink physical pod setup */
+struct amdgpu_ualink_ppod_setup {
+	struct kobject kobj;
+	struct amdgpu_ualink_ppod_info ppod;
+	/* Local accelerator array indexed by socket ID */
+	u32 n_local_accels;
+	u32 local_accels[AMDGPU_UALINK_LOCAL_ACCELS_MAX];
+};
+#define to_ualink_ppod_setup(ko) container_of(ko, struct amdgpu_ualink_ppod_setup, kobj)
+
 struct amdgpu_ualink_mgr {
 	struct amdgpu_ualink_info *info;
+	struct amdgpu_ualink_ppod_setup *setup;
 };
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
-- 
2.55.0

