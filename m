Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03DCC5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4661310F4EA;
	Fri, 21 Aug 2026 19:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N1g1RBdj";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012017.outbound.protection.outlook.com
 [40.107.200.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0003610F4E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRPGb9Ik6I3iebrcXqYLx8maIcTd7wL93h+R2lhqlnrrQNBeICTkxHMzoTfVDFIc3Z3Gg9ybZsZeaIFuNpFoOQv7t+EPxhYAHRUICGi/FEkt+c7AANYK3S5kHLq4Ie3KtcQwgv10UvdgiFvxAR4yJMGNxJKkXEj+9W5f9RtDGPj9eWncN7LaZFxv258FRKH18CDIIYrTcA8wyhkRxhOGBVhKrdtUd99yO7AlSm8GPq6Atha5UHlq8r3tSHeZMowp7PpYqIuumtVSoIzghdyx4Kp/F8jEQbZNe6t+glCZtrbAtdMV4+ri4b55ezrunBK0wG+oB7S5yrCQ/5lhGn3HzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kra6OP677ohVAdutg9cuOuCuzxhZxgwi9xD6k6iymig=;
 b=AQq+dyeuPpFwuoZ4gaIx4btM8htHXXLewTIMtVMYrHbA6Xk6rQ4xoggW3u4NO2fm5POTobjIRK1O6YfS3g/fqi1/w3mxYIymwK58hJNvInOKIASM4nvwXooTYtE+MEucf/UoA1cT76t8uFubsaCcG7fdEn8c90Ey0PT5oxu9ni1rj+tkd8k5I6ZbCU2rCqQgSleyTuDqoFi59DJ3QjDEWEn8HlgYtRJe2y0ds47r807P3x0vDy/Wjj1itbKvLTvBmS964JugLp74QJZ06tePGjcqm7B/9VJAb+GSy07JAAx+iOuk5P4TiwfRHit+Pr74KhzXExwFusTxmJiXzmRMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kra6OP677ohVAdutg9cuOuCuzxhZxgwi9xD6k6iymig=;
 b=N1g1RBdjbPOtejd8e5TuKxpQbCDdrj6HgLWzZtVvvh/gB15N58V0gGY/Zo0XAWQ8znsTePeAOV626bdbIALB/1dpQAX2CBNG28hgy9IpJwYKQwzT3inl2UeqRUAoysuY4GtpdtBF0ruaenWVz8mEYwia4LnJF0Ra+FMzpbvrITE=
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:22 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::8a) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/95] drm/amdgpu: Add sysfs API for UALink station
 configuration
Date: Fri, 21 Aug 2026 15:33:29 -0400
Message-ID: <20260821193458.808626-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 391a75b3-5bfc-463c-f72b-08deffbb57c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|11063799006|56012099006|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8r7mnD/f2zWfUt/3Ljpt0I5LiiPR452DQ4R7khJlErW21/kElOLLOQsCFA9czx8tArp3e/9D2sr2DKyolzJM9VJEGA2lkNOL4ntHFxj5L10Q7JvNkngRhEg2Q0hqZa4kQY2SOM32tnTosoj7SgVMRsONLRiq0A0XrFQjmcgo1KIHpPtHXkMSo6rnCebELx/6DUatw+wYWe/TpZ8+Wi8/BrVVRgiGVsJMA5x5CqLMPqvV0zPfGw5b/K/1mxZ+YFXf66m2jle+KFJyfSCP5AsG1PY0kkSSIhgMsMw1DYyQoG4U+ZL9vrVZcvwE7nP74CW6T5PawjeIvRXtJrwHz+jFaZw8/2RrBGbjbBQMzIjfzrWsy10qcSS1Eoblyj2i2q3o9NwC2H4aAiM/jNHnCAPIclqj8YPVphl1PuagrJ09jUeP7g0Q7F36pTk3AJFG4NHov/u6i62oM9Gu0QXeflxBoVTzDUYBcnyEcyAaosukYeVjxLEphmhbN0lWJruu+Fb1Z37G/C4q2XaROZDdHRgwDYovAcLGPS4DmY+46wX4qJxR3bBeydwbmuVhS1lOszfGZCwGuNTSAl2PHzHEUnqUlakw5FwYjMIE66DAkV3UBVrEQ42CzjgePiMlOvhT9ZaGVR6zL4mI9RsnrhbhVzFos2YniFEZByXwXmgaGfufxnngBWLlv6TLxolcNQNKQqmRhJrQpa74Q/9RTgXkm0f/SQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(11063799006)(56012099006)(18002099003)(10067099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CxV7FlX+QgH7rjwbt+CHKFaIw4ulhoCz5+Fe1a/PD47mFYgTZWyghXwiZoFfKKRE1Nrvy+HNKF5z6GG+TzJR/GRjc+jtEH/eA/z/K8g+1XoGHq75eqsFUjHgGpi+jTTDNTSLP3RYlnHHGbTwDEBwLkm96Oc7pdRjDjB0MZMU9HNDlBXk15jqnjLfFMhpr9emkinZGCEASTtvPOsznA3sfgLtEa18AcXgVuZ3X6Ci1nLKWz0skSFDRLn705kjRO7DpOPv2mVkmsKNYUG2RgDPnnn68cMNiy1RofcZPHbgBuHi5CFNd8F279UINHWe6GbOHI85yt/zpP14+J/6kDfzm5Vm8dcOQjw9mnfU3uDZHQnYZZMq1HqgVMKJfuu+Pmq+agZRqL9hjHHO9oPZX5cx9pP0qvgBrFwG3EdWxeXTkq3fupXwsYY5/g8yvhbLuKSS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:22.9022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 391a75b3-5bfc-463c-f72b-08deffbb57c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529
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

<device>/ualink/stations: Directory for staging UALink station/port
configuration attributes:
- station_flags (currently only sets the number of port per station)
- lane_en_bitmap (hexadecimal bitmaps of lanes enabled per station)
- write "true" to commit to apply settings

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 144 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  16 +++
 2 files changed, 160 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 420e18a658e83..4f50040a99256 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -714,8 +714,125 @@ static const struct kobj_type ualink_vpod_config_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops
 };
 
+UALINK_VALUE_SHOW(station_config, flags, flags, "0x%x");
+
+UALINK_VALUE_STORE(station_config, flags, flags, u8, 16);
+
+static size_t lane_bitmap_to_string(char *str,
+		const struct amdgpu_ualink_station_config *stations)
+{
+	size_t i;
+
+	for (i = 0; i < stations->n_stations; i++)
+		str[i] = stations->lane_en_bitmap[i] +
+			(stations->lane_en_bitmap[i] < 10 ? '0' : 'a' - 10);
+	str[i] = '\0';
+
+	return i;
+}
+static ssize_t
+ualink_station_config_lane_en_bitmap_show(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  char *buf)
+{
+	struct amdgpu_ualink_station_config *stations = to_ualink_station_config(kobj);
+	char str[AMDGPU_UALINK_STATIONS_MAX + 1];
+
+	lane_bitmap_to_string(str, stations);
+	return sysfs_emit(buf, "%s\n", str);
+}
+static ssize_t
+ualink_station_config_lane_en_bitmap_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct amdgpu_ualink_station_config *stations = to_ualink_station_config(kobj);
+	u8 lane_en_bitmap[AMDGPU_UALINK_STATIONS_MAX];
+	u32 n_stations = 0;
+	bool end = false;
+	size_t i;
+
+	for (i = 0; i < count; i++) {
+		/* Accept any number of \n in the end */
+		if (buf[i] == '\n') {
+			end = true;
+			continue;
+		}
+		/* Don't accept any more data after \n */
+		if (end)
+			return -EINVAL;
+		/* Don't accept more data than the array size */
+		if (i >= sizeof(lane_en_bitmap))
+			return -ENOSPC;
+		/* Accept hex digits */
+		if (buf[i] >= '0' && buf[i] <= '9')
+			lane_en_bitmap[n_stations++] = buf[i] - '0';
+		else if (buf[i] >= 'a' && buf[i] <= 'f')
+			lane_en_bitmap[n_stations++] = buf[i] + 10 - 'a';
+		else if (buf[i] >= 'A' && buf[i] <= 'F')
+			lane_en_bitmap[n_stations++] = buf[i] + 10 - 'A';
+		else
+			return -EINVAL;
+	}
+
+	memcpy(stations->lane_en_bitmap, lane_en_bitmap, sizeof(lane_en_bitmap));
+	stations->n_stations = n_stations;
+	return i;
+}
+
+static ssize_t ualink_station_config_commit_store(struct kobject *kobj,
+						  struct kobj_attribute *attr,
+						  const char *buf, size_t count)
+{
+	struct amdgpu_ualink_station_config *stations = to_ualink_station_config(kobj);
+	struct amdgpu_ualink_info *info = to_ualink_info(kobj->parent);
+	struct device *dev = kobj_to_dev(info->kobj.parent);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	/* DF reconfiguration does not interact with accelerator state */
+
+	if (!sysfs_streq(buf, "true"))
+		return -EINVAL;
+
+	/* TODO: Send configuration to ASP */
+	(void)adev;
+	(void)stations;
+
+	return count;
+}
+
+#define UALINK_STATION_CONFIG_ATTR(name) __ATTR(name, 0600,		\
+		ualink_station_config_##name##_show,			\
+		ualink_station_config_##name##_store)
+static struct kobj_attribute ualink_station_config_flags  = UALINK_STATION_CONFIG_ATTR(flags);
+static struct kobj_attribute ualink_station_config_lane_en_bitmap =
+							UALINK_STATION_CONFIG_ATTR(lane_en_bitmap);
+static struct kobj_attribute ualink_station_config_commit =
+				__ATTR(commit, 0200, NULL, ualink_station_config_commit_store);
+
+static const struct attribute *ualink_station_config_attrs[] = {
+	&ualink_station_config_flags.attr,
+	&ualink_station_config_lane_en_bitmap.attr,
+	&ualink_station_config_commit.attr,
+	NULL
+};
+
+static void ualink_station_config_release(struct kobject *kobj)
+{
+	struct amdgpu_ualink_station_config *stations = to_ualink_station_config(kobj);
+
+	kfree(stations);
+}
+
+static const struct kobj_type ualink_station_config_ktype = {
+	.release = ualink_station_config_release,
+	.sysfs_ops = &kobj_sysfs_ops
+};
+
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 {
+	struct amdgpu_ualink_station_config *stations = NULL;
 	struct amdgpu_ualink_vpod_config *vpod_config = NULL;
 	struct amdgpu_ualink_ppod_setup *ppod_setup = NULL;
 	struct amdgpu_ualink_info *info = NULL;
@@ -765,12 +882,32 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 	if (r)
 		goto err_del_vpod_config;
 
+	stations = kzalloc(sizeof(*stations), GFP_KERNEL);
+	if (!stations) {
+		r = -ENOMEM;
+		goto err_remove_vpod_config_files;
+	}
+	r = kobject_init_and_add(&stations->kobj, &ualink_station_config_ktype,
+				 &info->kobj, "stations");
+	if (r)
+		goto err_put_stations;
+	r = sysfs_create_files(&stations->kobj, ualink_station_config_attrs);
+	if (r)
+		goto err_del_stations;
+
+	adev->ualink.stations = stations;
 	adev->ualink.config = vpod_config;
 	adev->ualink.setup = ppod_setup;
 	adev->ualink.info = info;
 
 	return r;
 
+err_del_stations:
+	kobject_del(&stations->kobj);
+err_put_stations:
+	kobject_put(&stations->kobj);
+err_remove_vpod_config_files:
+	sysfs_remove_files(&vpod_config->kobj, ualink_vpod_config_attrs);
 err_del_vpod_config:
 	kobject_del(&vpod_config->kobj);
 err_put_vpod_config:
@@ -792,6 +929,13 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
 {
+	if (adev->ualink.stations) {
+		sysfs_remove_files(&adev->ualink.stations->kobj,
+				   ualink_station_config_attrs);
+		kobject_del(&adev->ualink.stations->kobj);
+		kobject_put(&adev->ualink.stations->kobj);
+		adev->ualink.stations = NULL;
+	}
 	if (adev->ualink.config) {
 		sysfs_remove_files(&adev->ualink.config->kobj,
 				   ualink_vpod_config_attrs);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 67fe40cd08e71..384959fbb36fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -29,6 +29,7 @@
 
 #define AMDGPU_UALINK_ACCEL_MAX 256
 #define AMDGPU_UALINK_LOCAL_ACCELS_MAX 8
+#define AMDGPU_UALINK_STATIONS_MAX 64
 
 enum amdgpu_ualink_type {
 	AMDGPU_UALINK_TYPE_UALOE = 0,
@@ -100,10 +101,25 @@ struct amdgpu_ualink_vpod_config {
 };
 #define to_ualink_vpod_config(ko) container_of(ko, struct amdgpu_ualink_vpod_config, kobj)
 
+/* UALink station configuration */
+struct amdgpu_ualink_station_config {
+	struct kobject kobj;
+	/* Station configuration flags
+	 * bits [3:0]: PortPerStation (PPS) - 1, 2, or 4
+	 * bits [7:4]: Reserved
+	 */
+	u8 flags;
+	u8 n_stations;
+	/* bitmap or enabled lanes for each station in logical station order */
+	u8 lane_en_bitmap[AMDGPU_UALINK_STATIONS_MAX];
+};
+#define to_ualink_station_config(ko) container_of(ko, struct amdgpu_ualink_station_config, kobj)
+
 struct amdgpu_ualink_mgr {
 	struct amdgpu_ualink_info *info;
 	struct amdgpu_ualink_ppod_setup *setup;
 	struct amdgpu_ualink_vpod_config *config;
+	struct amdgpu_ualink_station_config *stations;
 };
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
-- 
2.55.0

