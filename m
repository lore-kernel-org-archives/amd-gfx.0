Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C2AC61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 310F510E654;
	Mon, 31 Aug 2026 18:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4m9xFnZf";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397D210E654
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+Rh8a0PbaScPmcA99qPkymKCYzwkZ7zbqx6gy3Ps0JHeDMz+xk6A5lGwJ4+MUJaeennK1LGILucH1C/vyCnjQPMGlxXE6AnwZqU4pvYV8dKDOi2OrBBdrB7bIlsOIWKX65unr4YYuNCp7l594CZ4pX4pVpIz+EqQrXhU2Y+Sx/fPUpdjBHRXfC4rC2Ep3rAC7kneHS5tkVQRClhIY5gkc++MiHujjmxWqAr/7O+/xWg4tM3XJOljyRX1b5kG6oBARz5aFwHUhTXVXs03WIOFbWI5EPLziGOPQVDFZiuWB3jlHUQ0zpPziMOhmwBQrO0kNyLxx9Qjza1l4mielOA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMEMH5ojplrHHzY9xgRaKwS8PKRGIqKeJkQfnWf927g=;
 b=fjdyhQjhBKzaluYxjqIt/HQkuz3phS14VHQqKiFT8g0TVKD/FY+T7H7L4eY+GvK7RTFJ030nWdzuKJNCfHcFR2QD4kdCgj8c/doyMTk4J6WuZFadEmh/XKtiK9KE8gWmXa/9KEcEHzhj0lARTh40lvcVVnQY/0VUQBBFPt0CaxNrRdPKLIQEE/KWEYOkBDnC3GgPdJbASFmilQ1tc0ZW8Tyy0mIPeaz7KPEmS0qKlNv5vVGsgnNidqDb8ZRh7OqxC882K9NFujGqfzxtjUCnJyx5GWFIQWDQRwWMmOMFIUF0hdIiDyxqcHZdM+MNeBle1PD7rksbhV1fk98MoJ6UwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMEMH5ojplrHHzY9xgRaKwS8PKRGIqKeJkQfnWf927g=;
 b=4m9xFnZfaRSwJg/IsvFw/TxyRulsIb7rzlYVSqdoNPGcD4IvpigZYkRSx9T+ygJwo2oIuhkbKZ7V9VTHPmT4oOaRzBqh5iXTs4cXp+JISedG2wkz4rgHi8QTpCGP8fCho41ynJl9TM2yb+L6lHV4OWzziQmv66fO/IfSXOZKVJk=
Received: from PH1PEPF000132FF.namprd07.prod.outlook.com (2603:10b6:518:1::10)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:18 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2a01:111:f403:c801::2) by PH1PEPF000132FF.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/95] drm/amdgpu: Add sysfs API for UALink virtual pod config
Date: Mon, 31 Aug 2026 14:26:24 -0400
Message-ID: <20260831182754.1089811-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb23a8d-ec60-4b9f-00a5-08df078da0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: evKNlRt71jyfILYyjlETNcKNfsJtwPRLpUVZO8P+ausX7FAiIZuq61pZrxzVfwh/blYhXYRqanb7W8wj0GmfnDn9JyIh+CRywgm5CLdjtvmNJNfFSNT+2ClE8amoOd1/WotKjilZgjGM4eEE2cznRrGLf4Kdk1MK58HmV1Ta2YnkxPdy9gPdHLS1wNOjnkYyWIfOHAI6ynmfM52ApfxRHOeyJn9geV7m30/Qpx7cdHoD9V2Zbugo998SR6eyBhJ9oww7fVvXqSU2Ia/B7UFRYxDaRar2bjEE1x+FAU6vI3NerzVcGmol0ygs3BUQBtxwAgGqbEnbthVCSGGSGkKPUZU0UEizLiEAbc4UYqpyT3vL4irsvHy0mkpqZnh3P/mHwjVV+VlIIQ1Wi6weLuGVolglcGsL8mtYhD/G1nWYZfS8ZCCRh7P46XmEolS8fSVtA05DrrxgYktC47pamQQu7zIRobnm+E7RaOsLnkTBdOJePzUWwwsEKa+kTNMj0NojbOkkKqYPP4IksZP+d9Cp8ncVzLngqeV9LpOh4KluOodKAS0E5JW08Wr3EFsu78mGZU0/3hejpwJDROZVVB/Kxa6TXvl1cGKpEuQLxJNKs8TCfBo1STvaCwZRfacFLqP1NmTeMUtlAzQFP4C3gg9FzLbJ2PQ+oqESMnA7Itl5yJDd2dn94grgngbLbDAIR7CPy9QPCl1xmqEKoXKcx7wJdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pq75VLWcb2Su5lP21nlK6JMSX8Cw2xaANip/Z5bdVq7P2NNJs/dyjhGFqAn3OhaOqIsNfEOa4tFlKnVnj8KQXcOzioNPSwilIvuUcAg0n6x0ePAHXXJQY+R1YYIvZ+cW1fy6U9oH7ja/lJ6hW0leI0aMK5b/ZOzWYgdjmbys2NieorFdHYBAdZK20K3xLCtUj178PNzLOIpE7o1/AVhIQ/HR9GO8AsFOWdB5IwP56surYK1UluJK0RQGkZaU6lOpQoI2GGEMKZKW1o8wDXo/TjvX8PAc/B+cNL0rDVDaPGxAHEWaHifwDfC6pE0wdIo1J2JEi3jmZ4haRvShY9mYx0MicL6S44ngpSwp2la6OlUKFlxP5nClW+aNPvazJtovtv1OFF+Bpqpq5nWakvDucDzQvYSkU9kcCjbRlOBQUWPd5cTzhQvMwm8EBchnUxfb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:18.0238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb23a8d-ec60-4b9f-00a5-08df078da0e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
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

<device>/ualink/config: Directory for staging virtual pod configuration
attributes. Write "true" to commit to apply settings

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 403 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |   8 +
 2 files changed, 410 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 92c449f2004d4..d60cd997dd3c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -94,6 +94,57 @@ static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
 	return show_idbits(info->field, sizeof(info->field)*8, buf);	\
 }
 
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+static ssize_t store_idbits(unsigned long *bits, unsigned int nbits,
+			    const char *buf, size_t count)
+{
+	char *dup_buf, *str, *tok;
+	ssize_t r;
+	u32 id;
+
+	bitmap_zero(bits, nbits);
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
+		if (id >= nbits) {
+			r = -ERANGE;
+			goto err;
+		}
+		set_bit(id, bits);
+	} while (str);
+	kfree(dup_buf);
+
+	return count;
+
+err:
+	kfree(dup_buf);
+	return r;
+}
+#define UALINK_IDBITS_STORE(prefix, name, field, nbits)			\
+static ssize_t ualink_##prefix##_##name##_store(struct kobject *kobj,	\
+						struct kobj_attribute *attr,\
+						const char *buf, size_t count)\
+{									\
+	struct amdgpu_ualink_##prefix *info = to_ualink_##prefix(kobj);	\
+	DECLARE_BITMAP(bits, nbits);					\
+	ssize_t r = store_idbits(bits, nbits, buf, count);		\
+									\
+	if (r >= 0)							\
+		bitmap_copy(info->field, bits, nbits);			\
+	return r;							\
+}
+#endif
+
 static ssize_t show_idarray(const u32 *array, u32 size, char *buf)
 {
 	ssize_t len = 0;
@@ -215,6 +266,32 @@ static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
 			 ARRAY_SIZE(ualink_##name##_values), buf);	\
 }
 
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+static ssize_t store_enum(u32 *x, const char * const values[], unsigned int n,
+			  const char *buf, size_t count)
+{
+	unsigned int i;
+
+	for (i = 0; i < n; i++) {
+		if (values[i] && sysfs_streq(buf, values[i])) {
+			*x = i;
+			return count;
+		}
+	}
+	return -EINVAL;
+}
+#define UALINK_ENUM_STORE(prefix, name, field)				\
+static ssize_t ualink_##prefix##_##name##_store(struct kobject *kobj,	\
+						struct kobj_attribute *attr,\
+						const char *buf, size_t count)\
+{									\
+	struct amdgpu_ualink_##prefix *info = to_ualink_##prefix(kobj);	\
+									\
+	return store_enum(&info->field, ualink_##name##_values,		\
+			 ARRAY_SIZE(ualink_##name##_values),		\
+			 buf, count);					\
+}
+#endif
 static const char * const ualink_link_type_values[] = {
 	"UALoE", "UALink"
 };
@@ -372,8 +449,299 @@ static const struct kobj_type ualink_ppod_setup_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops
 };
 
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+UALINK_VALUE_SHOW(vpod_config, vpod_id,   vpod.id,   "%u");
+UALINK_VALUE_SHOW(vpod_config, vpod_size, vpod.size, "%u");
+UALINK_IDBITS_SHOW(vpod_config, vpod_active_accels, vpod.active_accel_bits);
+UALINK_ENUM_SHOW(vpod_config, addr_mode, vpod.addr_mode);
+
+UALINK_VALUE_STORE(vpod_config, vpod_id,   vpod.id,   u32, 10);
+UALINK_VALUE_STORE(vpod_config, vpod_size, vpod.size, u32, 10);
+UALINK_IDBITS_STORE(vpod_config, vpod_active_accels, vpod.active_accel_bits,
+		    AMDGPU_UALINK_ACCEL_MAX);
+UALINK_ENUM_STORE(vpod_config, addr_mode, vpod.addr_mode);
+
+static bool check_vpod_info(struct amdgpu_device *adev,
+			    const struct amdgpu_ualink_info *info)
+{
+	unsigned int weight;
+
+	if (info->accel_state < AMDGPU_UALINK_ACCEL_STATE_CONFIGURED) {
+		dev_dbg(adev->dev, "pPod is not yet configured\n");
+		return false;
+	}
+	if (info->vpod.id >= AMDGPU_UALINK_ACCEL_MAX) {
+		dev_dbg(adev->dev, "vPod ID %u out of range [0..%u]\n",
+			info->vpod.id, AMDGPU_UALINK_ACCEL_MAX - 1);
+		return false;
+	}
+	if (info->vpod.size == 0 || info->vpod.size > info->ppod.size) {
+		dev_dbg(adev->dev, "vPod size %u out of range [1..%u]\n",
+			info->vpod.size, info->ppod.size);
+		return false;
+	}
+	if (info->vpod.addr_mode >= AMDGPU_UALINK_ADDR_MODE_MAX) {
+		dev_dbg(adev->dev, "Invalid addr mode %u\n", info->vpod.id);
+		return false;
+	}
+	weight = bitmap_weight(info->vpod.active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
+	if (weight != info->vpod.size) {
+		dev_dbg(adev->dev, "vPod size doesn't match vpod_active_accels list: %u != %u\n",
+			info->vpod.size, weight);
+		return false;
+	}
+	if (!test_bit(info->ppod.accel_id, info->vpod.active_accel_bits)) {
+		dev_dbg(adev->dev, "Accelerator ID %u not listed in vpod_active_accels\n",
+			info->ppod.accel_id);
+		return false;
+	}
+
+	return true;
+}
+
+static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < mgpu_info.num_gpu; i++) {
+		struct amdgpu_device *peer_adev = mgpu_info.gpu_ins[i].adev;
+
+		if (peer_adev->ualink.info &&
+		    peer_adev->ualink.info->ppod.accel_id == accel_id)
+			return peer_adev;
+	}
+
+	return NULL;
+}
+
+static bool check_local_vpod_integrity(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_info *info = adev->ualink.info;
+	struct amdgpu_ualink_info *peer_info;
+	struct amdgpu_device *peer_adev;
+	unsigned int accel_id;
+	unsigned int i;
+
+	if (!check_vpod_info(adev, info))
+		return false;
+
+	/* Check that all local accelerators listed in vpod_active_accels have
+	 * matching pod IDs
+	 */
+	for_each_set_bit(accel_id, info->vpod.active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
+
+		if (accel_id == info->ppod.accel_id)
+			continue;
+
+		peer_adev = find_peer_adev(accel_id);
+		if (!peer_adev)
+			continue;
+		peer_info = peer_adev->ualink.info;
+
+		if (peer_info->vpod.id != info->vpod.id) {
+			dev_dbg(adev->dev, "Peer %u vpod_id doesn't match: %u != %u",
+				accel_id, peer_info->vpod.id, info->vpod.id);
+			return false;
+		}
+		if (!uuid_equal(&peer_info->ppod.id, &info->ppod.id)) {
+			dev_dbg(adev->dev, "Peer %u ppod_id doesn't match: %pU != %pU",
+				accel_id, &peer_info->ppod.id, &info->ppod.id);
+			return false;
+		}
+	}
+
+	/* Derive local accels from pod IDs of GPUs in mgpu_info */
+	info->n_local_accels = 0;
+	for (i = 0; i < mgpu_info.num_gpu &&
+		    info->n_local_accels < AMDGPU_UALINK_LOCAL_ACCELS_MAX;
+	     i++) {
+		peer_adev = mgpu_info.gpu_ins[i].adev;
+		peer_info = peer_adev->ualink.info;
+
+		if (peer_adev == adev ||
+		    (peer_info && peer_info->vpod.id == info->vpod.id &&
+		     uuid_equal(&peer_info->ppod.id, &info->ppod.id)))
+			info->local_accels[info->n_local_accels++] =
+				peer_info->ppod.accel_id;
+	}
+
+	/* Then check consistency of the vpod information on all those GPUs */
+	for (i = 0; i < info->n_local_accels; i++) {
+		unsigned int j;
+
+		for (j = i + 1; j < info->n_local_accels; j++) {
+			if (info->local_accels[j] == accel_id) {
+				dev_dbg(adev->dev,
+					"Accelerator ID %u is not unique among local GPUs\n",
+					accel_id);
+				return false;
+			}
+		}
+
+		accel_id = info->local_accels[i];
+
+		/* Skip this GPU, we are looking for our peers */
+		if (accel_id == info->ppod.accel_id)
+			continue;
+
+		peer_adev = find_peer_adev(accel_id);
+		if (WARN_ON(!peer_adev || !peer_adev->ualink.info))
+			/* info->local_accels we just built is corrupted? */
+			return false;
+		peer_info = peer_adev->ualink.info;
+
+		/* Check peer vpod info and consistency */
+		if (!check_vpod_info(peer_adev, peer_info))
+			return false;
+
+		if (peer_info->ppod.size != info->ppod.size) {
+			dev_dbg(adev->dev, "Peer %u ppod_size doesn't match: %u != %u\n",
+				accel_id, peer_info->ppod.size, info->ppod.size);
+			return false;
+		}
+		if (peer_info->vpod.size != info->vpod.size) {
+			dev_dbg(adev->dev, "Peer %u vpod_size doesn't match: %u != %u\n",
+				accel_id, peer_info->vpod.size, info->vpod.size);
+			return false;
+		}
+		if (peer_info->vpod.addr_mode != info->vpod.addr_mode) {
+			dev_dbg(adev->dev, "Peer %u addr_mode doesn't match: %u != %u\n",
+				accel_id, peer_info->vpod.addr_mode, info->vpod.addr_mode);
+			return false;
+		}
+		if (!bitmap_equal(peer_info->vpod.active_accel_bits,
+				  info->vpod.active_accel_bits, AMDGPU_UALINK_ACCEL_MAX)) {
+			dev_dbg(adev->dev, "Peer %u vpod_active_accels don't match\n",
+				accel_id);
+			return false;
+		}
+
+		/* Update peer's local accelerator array */
+		peer_info->n_local_accels = info->n_local_accels;
+		memcpy(peer_info->local_accels, info->local_accels,
+		       sizeof(info->local_accels));
+	}
+	return true;
+}
+
+static void activate_accelerator(struct amdgpu_device *adev)
+{
+	if (adev->ualink.info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_READY)
+		return;
+
+	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
+}
+
+static void deactivate_accelerator(struct amdgpu_device *adev)
+{
+	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_READY)
+		return;
+
+	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_CONFIGURED;
+}
+
+static void activate_local_vpod(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_info *info = adev->ualink.info;
+	struct amdgpu_device *peer_adev;
+	unsigned int accel_id;
+	unsigned int i;
+
+	for (i = 0; i < info->n_local_accels; i++) {
+		accel_id = info->local_accels[i];
+
+		peer_adev = find_peer_adev(accel_id);
+		if (WARN_ON(!peer_adev || !peer_adev->ualink.info))
+			/* info->local_accels is corrupted? */
+			continue;
+
+		activate_accelerator(peer_adev);
+	}
+}
+
+static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
+					       struct kobj_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct amdgpu_ualink_vpod_config *config = to_ualink_vpod_config(kobj);
+	struct amdgpu_ualink_info *info = to_ualink_info(kobj->parent);
+	struct device *dev = kobj_to_dev(info->kobj.parent);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!sysfs_streq(buf, "true"))
+		return -EINVAL;
+	if (info->accel_state < AMDGPU_UALINK_ACCEL_STATE_CONFIGURED) {
+		dev_dbg(adev->dev, "Ualink ppod is not yet configured\n");
+		return -EINVAL;
+	}
+
+	/* TODO: instead of just copying the info, call ASP vpod config API
+	 * and query ASP for the updated info
+	 */
+	info->vpod = config->vpod;
+
+	/* The integrity check makes sure each new GPU is consistent with the
+	 * other GPUs already in the vPod. All known local GPUs can become
+	 * "ready" at the same time.
+	 *
+	 * Misconfiguration of one GPU does not reduce the state of other GPUs
+	 * already in the vPod.
+	 */
+	mutex_lock(&mgpu_info.mutex);
+	if (check_local_vpod_integrity(adev))
+		activate_local_vpod(adev);
+	else if (info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_CONFIGURED)
+		deactivate_accelerator(adev);
+	mutex_unlock(&mgpu_info.mutex);
+
+	/* TODO: Update KFD topology for in-domain link */
+
+	/* TODO: If state was ACTIVE:
+	 * - If addr_mode changed, reset all connections, reset state to READY
+	 * - If accelerators were removed, reset those links, but keep state ACTIVE
+	 * - If accelerators were added, keep state ACTIVE
+	 */
+
+	return count;
+}
+
+#define UALINK_VPOD_CONFIG_ATTR(name) __ATTR(name, 0600,		\
+		ualink_vpod_config_##name##_show,			\
+		ualink_vpod_config_##name##_store)
+static struct kobj_attribute ualink_vpod_config_vpod_id   = UALINK_VPOD_CONFIG_ATTR(vpod_id);
+static struct kobj_attribute ualink_vpod_config_vpod_size = UALINK_VPOD_CONFIG_ATTR(vpod_size);
+static struct kobj_attribute ualink_vpod_config_vpod_active_accels =
+						UALINK_VPOD_CONFIG_ATTR(vpod_active_accels);
+static struct kobj_attribute ualink_vpod_config_addr_mode = UALINK_VPOD_CONFIG_ATTR(addr_mode);
+static struct kobj_attribute ualink_vpod_config_commit = __ATTR(commit, 0200, NULL,
+								ualink_vpod_config_commit_store);
+
+static const struct attribute *ualink_vpod_config_attrs[] = {
+	&ualink_vpod_config_vpod_id.attr,
+	&ualink_vpod_config_vpod_size.attr,
+	&ualink_vpod_config_vpod_active_accels.attr,
+	&ualink_vpod_config_addr_mode.attr,
+	&ualink_vpod_config_commit.attr,
+	NULL
+};
+#endif
+
+static void ualink_vpod_config_release(struct kobject *kobj)
+{
+	struct amdgpu_ualink_vpod_config *config = to_ualink_vpod_config(kobj);
+
+	kfree(config);
+}
+
+static const struct kobj_type ualink_vpod_config_ktype = {
+	.release = ualink_vpod_config_release,
+	.sysfs_ops = &kobj_sysfs_ops
+};
+
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 {
+	struct amdgpu_ualink_vpod_config *vpod_config = NULL;
 	struct amdgpu_ualink_ppod_setup *ppod_setup = NULL;
 	struct amdgpu_ualink_info *info = NULL;
 	int r;
@@ -411,15 +779,39 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 		goto err_del_ppod_setup;
 #endif
 
+	vpod_config = kzalloc(sizeof(*vpod_config), GFP_KERNEL);
+	if (!vpod_config) {
+		r = -ENOMEM;
+		goto err_remove_ppod_setup_files;
+	}
+	r = kobject_init_and_add(&vpod_config->kobj, &ualink_vpod_config_ktype,
+				 &info->kobj, "config");
+	if (r)
+		goto err_put_vpod_config;
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+	r = sysfs_create_files(&vpod_config->kobj, ualink_vpod_config_attrs);
+	if (r)
+		goto err_del_vpod_config;
+#endif
+
+	adev->ualink.config = vpod_config;
 	adev->ualink.setup = ppod_setup;
 	adev->ualink.info = info;
 
 	return r;
 
 #ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+err_del_vpod_config:
+	kobject_del(&vpod_config->kobj);
+#endif
+err_put_vpod_config:
+	kobject_put(&vpod_config->kobj);
+err_remove_ppod_setup_files:
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+	sysfs_remove_files(&ppod_setup->kobj, ualink_ppod_setup_attrs);
 err_del_ppod_setup:
-	kobject_del(&ppod_setup->kobj);
 #endif
+	kobject_del(&ppod_setup->kobj);
 err_put_ppod_setup:
 	kobject_put(&ppod_setup->kobj);
 err_remove_info_files:
@@ -433,6 +825,15 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
 {
+	if (adev->ualink.config) {
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+		sysfs_remove_files(&adev->ualink.config->kobj,
+				   ualink_vpod_config_attrs);
+#endif
+		kobject_del(&adev->ualink.config->kobj);
+		kobject_put(&adev->ualink.config->kobj);
+		adev->ualink.config = NULL;
+	}
 	if (adev->ualink.setup) {
 #ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
 		sysfs_remove_files(&adev->ualink.setup->kobj,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 1c1fb41e75140..01a36b058ea08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -97,9 +97,17 @@ struct amdgpu_ualink_ppod_setup {
 };
 #define to_ualink_ppod_setup(ko) container_of(ko, struct amdgpu_ualink_ppod_setup, kobj)
 
+/* UAlink virtual pod config */
+struct amdgpu_ualink_vpod_config {
+	struct kobject kobj;
+	struct amdgpu_ualink_vpod_info vpod;
+};
+#define to_ualink_vpod_config(ko) container_of(ko, struct amdgpu_ualink_vpod_config, kobj)
+
 struct amdgpu_ualink_mgr {
 	struct amdgpu_ualink_info *info;
 	struct amdgpu_ualink_ppod_setup *setup;
+	struct amdgpu_ualink_vpod_config *config;
 };
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
-- 
2.55.0

