Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E36C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13EFB10F507;
	Fri, 21 Aug 2026 19:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CRxT7S4y";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012066.outbound.protection.outlook.com
 [40.107.200.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75CBA10F4FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yX6MC7AupWdQfgxczalOBinKpUWpYELHM/Chl97MZSYSWHu1ha9XnsnOMzXOY+v19rVHzJpiyKYPJRN+++/Jg5kWIRF4skkiJdxUbk2oJpoP9utkAdibjHkiam+gatJqcCmJf2DkiC2sDGstQo4sN5wiEKYcakNZ0f691SgaCmglqrChmvgrPA0UhIjgQW/7BAIP969jjdfzd9pZYp5LGSvCUT7wCHVCY+4zG0lBrVcQm6beubw26O8hLCy0uOTXRRJIZ6AktI0L+JD+Z/NMK2lsdgr/KYLgIJBrNDKG6atBgc/U4Lt2x5BbJQTs6pJannauMGOTXmj2+URg/8H8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4HTOLyHpSt+Q1EqICoDZv3Qi2LvB0Ga5V2yvb4Cu6g=;
 b=fvzNDG/kGwRYERYliRSJfkXtd54Ry9nY64Q5f49INNWyXflA8G7UwyW1U7j2BXM2FByBrtC8WoPxM7uT6pgJhexAnaHOom1UmUUrfdITP/v+2XuY7UgauG/gqnHac8CdHsqRpTqjF77pV7FG1C8qG3VhnZFQ1C7ghvpocy3KR0cERVLCMUyg8bEOwR/zwW0JbVEvZOSltBEYryM37MPVOMekPR4DgVlWpMMfpIrLL4ZswGYjF0k556Yx8pPJolJDRq+ENdtdz+C8/LPFue4ORwwebXiadXy+cWryln8oU6JcPx2ocl0su+S+bkgz8KDaEEh0qmN/dPnQIW2b14bWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4HTOLyHpSt+Q1EqICoDZv3Qi2LvB0Ga5V2yvb4Cu6g=;
 b=CRxT7S4yq/ppfuN1AuKVadUWb/7ll8ftgWG9vrkAWnPS9njoDZckeZ9J7CB7shOIV4ekR6dGMpG9NrL2IlTWXx4KYSwqjUNmTTrmDBtlEW2xaMcDr0wM8Y9XDkWGZH/mM/hjcTAc1puINqqRmIHbKU1Cw1hq3zLrz2wrmX2Ej8I=
Received: from CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::25)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:20 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::25) by CH5P222CA0009.outlook.office365.com
 (2603:10b6:610:1ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/95] drm/amdgpu: Add sysfs API for UALink physical pod setup
Date: Fri, 21 Aug 2026 15:33:27 -0400
Message-ID: <20260821193458.808626-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 244fefc1-74cd-480d-a91d-08deffbb5533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|10067099003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: zIf7SfEO5oyXAouf6wMgi5ZWmD1xC1yx8WGgKX/UCqZO+iSDAdyFOS4lMwHjKOkYpAhCJweKVyE66D5GwZfyuqrJ3D/cZxTthxYX84YtdyVaehVrGgwoszXKL0fAAQgvG0RFVWs57A/c2vUkNGAnH7i05iLpGelZa70hj+eJuigjtEdSdMw5joosTb8AeWxjWmgnY6I1G0GktHEQ9buoZ4kO3dI8aTNpnW+Oe7tmLKjUYwTLzD8AQMJr2MV1HH3eTu4D6iWvIIC53uSxMpMCWVvYMlO9E1KLPBnHUAoJGLVhUlwr7zTq7YhnRoJNtwNvaH/cd8p7HtaA3foMErLTR1Wd+1Vo+576YLMfqeohHPPam037VgnkeyHJSP6maKdi/MR1Sj4SNPqL/gLfdYNyVk9PdqyCR6WjXz2liTjEw7DutVQ6cUYG3rs5coA1tezggo0zaU0WEwsvWAVnlJqv28lt2N1GGKM/kpzWM5iHS1H7lpOOHBfN/oPUwK+TdVgbD/yhMwVMo8i98P+ZsiqalGClrz7mm2YKVKMV1JzZp40rnxFNywjBnotceOPBL4jatN1AGqHpun18KgNqmfBAO+PdntAhsXNLkXyZpWdYgP1XYjPnbARDVfzpL2GxtyUM1bmOOys9SbRQhN+jYUEhdQHHYZ1VPDRT28mQ0kUgvIiogXdI8R0lGpKbt51rUtiboOQ6q+sZJt/fV0clLGJdyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rt1BbADTgUJf4R0j7ekkH98yGIvatnHf7ToBbOKv62x6dCCQU9gfkj/IlDvVSZr9tVgKN5WowTup+3Ll0VvT0OSs5alh8/dvuWHSf6VEFvchPG4eAMLDjxpd3rdVF9Tft5XrVYTSGe5wzq6V/JyQAIuN2Wb5HR6/m735Je6ReSPUnKzEGLDND5RHZAiTkBJbtOHjAI3Fyi+ECzyc/yeuM6Kwp9F7/yKFXsQEQl/AmFssNsMya5euOZphdewhJ95C9ddKvT/lzAW8YgIdNbEVKF8GS2wYau5MJKMyXmdOcZ1MVK/gxSFYYcQ+cGvdHDmbfLjJyqRkjnekmI3VzMcsAC6M1bjYNqRWEumQU0ggqdPZ2vUN50xUh9PbHdhPQUgynkK9O2G4l3qcuxbzJ+ixAUSFB4hpHL6sYzQfeicoFeIpTAHsFc67gTxeSjZc3VBv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:18.6041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 244fefc1-74cd-480d-a91d-08deffbb5533
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 201 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  11 ++
 2 files changed, 212 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 374242372eab7..6c9905b15e93d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -46,6 +46,19 @@ static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
 									\
 	return sysfs_emit(buf, format"\n", info->field);		\
 }
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
 
 static ssize_t show_idbits(unsigned long *bits, unsigned int nbits, char *buf)
 {
@@ -89,6 +102,65 @@ static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
 	return show_idarray(info->field, info->size, buf);		\
 }
 
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
+
 #define UALINK_UUID_SHOW(prefix, name, field)				\
 static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
 					       struct kobj_attribute *attr,\
@@ -98,6 +170,17 @@ static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
 									\
 	return sysfs_emit(buf, "%pU\n", &info->field);			\
 }
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
 
 static ssize_t show_enum(u32 x, const char * const values[], unsigned int n,
 			 char *buf)
@@ -180,8 +263,99 @@ static const struct kobj_type ualink_info_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops
 };
 
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
 
@@ -203,10 +377,30 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
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
+	r = sysfs_create_files(&ppod_setup->kobj, ualink_ppod_setup_attrs);
+	if (r)
+		goto err_del_ppod_setup;
+
+	adev->ualink.setup = ppod_setup;
 	adev->ualink.info = info;
 
 	return r;
 
+err_del_ppod_setup:
+	kobject_del(&ppod_setup->kobj);
+err_put_ppod_setup:
+	kobject_put(&ppod_setup->kobj);
+err_remove_info_files:
+	sysfs_remove_files(&info->kobj, ualink_info_attrs);
 err_del_info:
 	kobject_del(&info->kobj);
 err_put_info:
@@ -216,6 +410,13 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
 {
+	if (adev->ualink.setup) {
+		sysfs_remove_files(&adev->ualink.setup->kobj,
+				   ualink_ppod_setup_attrs);
+		kobject_del(&adev->ualink.setup->kobj);
+		kobject_put(&adev->ualink.setup->kobj);
+		adev->ualink.setup = NULL;
+	}
 	if (adev->ualink.info) {
 		sysfs_remove_files(&adev->ualink.info->kobj,
 				   ualink_info_attrs);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 390fb5653aaf5..ea52dcd44d088 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -83,8 +83,19 @@ struct amdgpu_ualink_info {
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

