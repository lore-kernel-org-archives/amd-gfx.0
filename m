Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3010606A91E
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AtJjb6AJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C57310E0F6;
	Thu, 29 Oct 2026 14:22:32 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E4BC11232F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 14:22:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObXxkZ6jO+N86rQk+lBOK36Z/qRjlE+3xNmkD/SxhtLkWUioydqnCsyLpi896EufPwKWUS3Ujt+giZUBCgr4jOM/0CY/wMobiNpBKRfUNPD+LZBDfxmskGANAWcjVlKz+XL9C4uJy74tAXR4qnmzvG2zo/dsMnb9spDeMMMbjK+e+lCSH8UpY9aWuMdSn7i3moKiv6K97FwQNLZ+lhktzPcsVSc+ijMGKvY68erZu/FEAnsGBhPwJrE4QtmOSAvWasu78A2ZI9w+Wz1g19p4wenFji21v4+IjjkIlb8fAw1r+5Eedjy0V5dRzEhOs/d1aHKt0REhRSQuHNKAEgIwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0mcUxkkA2uHocNAZMVX4RRqIbZZcfvrov8uSXrUXmU=;
 b=kiMmmmBz180REnupocfc13O1NyBOXZnnrNSzyZ6otlyMTML+VcfiAFInxM/qSWT1mPOpxe0avdXQ+sMTURWRV6yJsWSLJWY3jmgm5UafRJ4suHAAvG3y4l5uu4D62Y4iRZv0LxyIG04XC4vEGKTyrPXkY//QElM30P8SmgzdGUlXYPAdkk3szkmySdoF62ZCfVwLG+9LzvbV7z6Ry7hP4jUC+d+OSm+Z56KHY7LDEmJAEm99UJFvZkaEVAD4G/2yKwf0TrXDWQ4gpmx6PQgzwewSlicsv86SnlkNps9Qamk2t4V/YsptCkxq4jgAfHBGcKME6M5iaoSCl8ihQCrkAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0mcUxkkA2uHocNAZMVX4RRqIbZZcfvrov8uSXrUXmU=;
 b=AtJjb6AJI2AIr8Cd2OGKV+JYN1KX7R5aiQxg9v4s6N/YG4bFguqjtRFvrg6L7whctii+drQb5382IG5/fLYfWYudSxoYqy+WZyusG3EYmCvAAx1d0E7rmN10nfGgYv/RPiu3+bL5HLW+nVyFoluQBXhNioTdL3rGCdZwfOi8CuE=
Received: from PH8PR07CA0031.namprd07.prod.outlook.com (2603:10b6:510:2cf::11)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 14:22:21 +0000
Received: from PH2PEPF00048912.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::6f) by PH8PR07CA0031.outlook.office365.com
 (2603:10b6:510:2cf::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 14:22:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH2PEPF00048912.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 14:22:20 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 09:22:18 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Mario.Limonciello@amd.com>, <alexander.deucher@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Ensure that harvest information gets set
Date: Thu, 29 Oct 2026 10:22:09 -0400
Message-ID: <20261029142209.3534836-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048912:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 48af5bb1-01d4-4a67-b6d8-08df35c80b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|261026140227099003|11063799006|261028144727099003|56012099006|261021123027099003|261026121527099003|261021121427099003|261022113327099003|261009223027099003|10067099003|261022105027099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5GfZMiUAF5eHj82+qe2SLh6zyLEFGVqzgGOLQszeknvYTjI2EkPN9yEO24Btm0bY+8ojySEEBAtRmxmoTaEAUg3ggOye9mgyqTDs88FOPxXIdhh5cek/8vr/Z/gnD1meev3yrdhLowlM67MrSxLlWV+SKUUQ6+sN62p6A5hhg8FJQx48T57PFHBCjvwpNq7WdSnMEbzJQi6DsoaAQlD8oJ1fgQb53v+ilVbYYaJbBZ/sISvgqg35F1JEJCbvwuZtsUgjtCKES8w2TftAwJCkju5ryZPrByCBUUXuoa6oXekXWG1bo3InnAUU+tXXuLdKcZ3AbAEuSvn3xIO/ewIUhFWH6FGB08EqYwJNYusQ9Ehop6CttwQH1LP5p3gW0cuoQELFfiU7zwVJABaP+BapFYnRnG2GOkmzkT1QVmXIhv4iE1ytlDyJr8+LBauOT9mhWk5U7vWjfcoEjPwIjeUXOCmTN0WD1C741xd1J6H01u+wV3f4p7cYUJAd3am93Ktjf/O7RCSH/DEz6apB0MXwT50tElv5qoTeNNqMORYt5plVXVwO7YYKBVMaVNFv8ZVKUnktz0To09N7hZntzY1vjyZIJ/D2gk9wYA6HgTwrMyMEwWfF+bhEbSD8/4Lv1iMKa0f8+vYivfZfRD1EgfJ3WoYXjbzfxgFjtBMIZRBIz/L6yXDRV2jeAt+7wHlzEF361sy/hFERMfzb49NaeDyoCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(261026140227099003)(11063799006)(261028144727099003)(56012099006)(261021123027099003)(261026121527099003)(261021121427099003)(261022113327099003)(261009223027099003)(10067099003)(261022105027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hynw6umik0qy5U9wyJ1rW4shNkiqM8f1niJBKnIGIrX5mnROPsPi7inP0eR07/y8I/1+2YRaadvaKgpdctOk0AJgtFv/6rkNQY8S+ddv6VeTtLMwIVs8HhF/9LYuV8kBnp+F5ay2lyMxc5sIWJhqTrq5BSjsdYTErYOegR6IklCEheEr4U19c4F4GR8hkRFqAfn6KU9GsFH1ZspqBrWu3MOrZxtv8rNt4j3e+vDATaa6TmL168y6rTtCho/HSbVrlFGb1Myrain0ByuBQxmsTpo1hiyv897mgFsGRKJ5wdoyt4T90wFHVtxlUZPUhB9ZD/xnhpxeuVfhzesaPuJjVfk29TiyxIIqoSoBVBme/NppkZ/Y5H5XjxtLwU8pxEHibaxuP7qdnQC1XPQmW9yxqtc9oldmRiDjBBGj/Ig8XGPn8qHdt4GtGuG72wTM2dZj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:22:20.9320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48af5bb1-01d4-4a67-b6d8-08df35c80b5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH2PEPF00048912.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After the earlier patch exported IP discovery on probe failure, there was
an unexpected consequence where harvest info was not populated. The
early-exit in amdgpu_discovery_sysfs_init meant that we never called
amdgpu_discovery_get_harvest_info, which is where we set the actual
harvest value. The first time we call amdgpu_discovery_sysfs_recurse
with NULL instead of adev, most values can get set. The 2nd time
amdgpu_discovery_sysfs_recurse is called, we bail early.

To keep the logic of the first patch intact, ensuring that older kernels
can still discover the IP blocks, add a separate call in the early-exit
section that sets the harvest information.

This should be the only functionality that is missed in this flow, as the
rest of the calls either work fine with adev=NULL, or use the discovery_bin
directly.

Fixes: 3ee1065e9830 ("drm/amdgpu: Export ip_discovery sysfs on probe failure")
Assisted-by: LLM Claude
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 44 +++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 16e3129db6a1..79a2b1268b23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1469,6 +1469,40 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev,
 	return 0;
 }
 
+#define list_to_kobj(el) container_of(el, struct kobject, entry)
+
+static void amdgpu_discovery_sysfs_update_harvest(struct amdgpu_device *adev)
+{
+	struct ip_discovery_top *ip_top = adev->discovery.ip_top;
+	struct ip_die_entry *ip_die_entry;
+	struct list_head *el_die, *el_hw_id, *el_hw_inst;
+	struct ip_hw_id *hw_id;
+	struct kset *die_kset;
+	struct ip_hw_instance *ip_inst;
+
+	if (!ip_top)
+		return;
+
+	die_kset = &ip_top->die_kset;
+
+	guard(spinlock)(&die_kset->list_lock);
+	list_for_each(el_die, &die_kset->list) {
+		ip_die_entry = to_ip_die_entry(list_to_kobj(el_die));
+
+		list_for_each(el_hw_id, &ip_die_entry->ip_kset.list) {
+			hw_id = to_ip_hw_id(list_to_kobj(el_hw_id));
+
+			list_for_each(el_hw_inst, &hw_id->hw_id_kset.list) {
+				ip_inst = to_ip_hw_instance(list_to_kobj(el_hw_inst));
+				ip_inst->harvest =
+					amdgpu_discovery_get_harvest_info(
+						adev, ip_inst->hw_id,
+						ip_inst->num_instance);
+			}
+		}
+	}
+}
+
 static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 {
 	uint8_t *discovery_bin = adev->discovery.bin;
@@ -1479,9 +1513,13 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 	if (!discovery_bin)
 		return -EINVAL;
 
-	/* If early init already created sysfs in standalone mode, skip normal init */
-	if (adev->discovery.ip_top && adev->discovery.ip_top->standalone_mode)
+	/* If early init already created sysfs in standalone mode, update harvest info
+	 * now that adev is fully initialized, then skip the rest of normal init.
+	 */
+	if (adev->discovery.ip_top && adev->discovery.ip_top->standalone_mode) {
+		amdgpu_discovery_sysfs_update_harvest(adev);
 		return 0;
+	}
 
 	ip_top = kzalloc_obj(*ip_top);
 	if (!ip_top)
@@ -1536,8 +1574,6 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 
 /* -------------------------------------------------- */
 
-#define list_to_kobj(el) container_of(el, struct kobject, entry)
-
 static void amdgpu_discovery_sysfs_ip_hw_free(struct ip_hw_id *ip_hw_id)
 {
 	struct list_head *el, *tmp;
-- 
2.43.0

