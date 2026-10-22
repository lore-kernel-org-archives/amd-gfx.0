Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8246A606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QLGZK0ZG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E591128D6;
	Thu, 22 Oct 2026 21:58:02 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F301110E00A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 21:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNyHzK39bFQrYijyakwXh8101VpmEVbyx8phzivQaAd4Ow5Vv+42CLw7QvQNH5KGnwwQC3JoLe8zx8LH1WXrxqDpt72AD/8mNHCE8KxoXdIDF38yxn9NNuHOPZtUBmqBFENmmU0YCrKQps4AodjqOXIWWwOE/0Okxfi7W9ldCfFzqyBUbjdMEYXHNb5OeUKiHEd9iia3QYuKDVluveF2IDkKxvlC46iYwxtvPT86qbSjkTq4Q6pstto8HqUvs5iJHhRGVnbEIic+1l1g5ar9J6N9GL/ArshQfzBwDkLleRrfmOC3FqfPRrRkJ4GFJ322J6Mz6Oc3iW+17hZUX+gDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPrE9uzQeyygN1f3IPoohuC4pGnpQopBjE9YFZeVGeA=;
 b=YMF/AGcoch9wUWywVjsd3uKRLPHXvgvAcaLLNnaLs5o6FRqO1wysuXtLY4uWBxf7w5t4R4+NWsTH+qns60DqaaA4MbyQmlY0iviLyBd94xSiRKiZDGz0tcUPKh06wf0kAM8ehty/7L1mYKu/UZAk9PluqaK8rglaEhM50iicjmaLgwEkdfTUpdSYcI2FPn8NcGSwzXDm372sOhRA6iXFLgrUUzrR0N0akLJo5tQe222A5c2QYvskne0IZEt3tjHlndZ3abCmY9lP5ngoMkXBTA6OyYrWp/wcvTmGWZy10KcLFVS6Ljat5roVgIxj7PZ7jspxAfytxJEbv/Ru7wOKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPrE9uzQeyygN1f3IPoohuC4pGnpQopBjE9YFZeVGeA=;
 b=QLGZK0ZGxojndyjnlH8fr1+UpjEfdm7WmyK4n3sJ2FQ0OEdyxwrQjTdkAPzkmcjWlFT90G/LYbhQ7sTJqrOshjPy2HcqxX5vWysHacYd6HAZWrGNO/MyjVRZO02v2NkKtxywD71SOJqzXKzbK0Pld5sECUM/S3WraRJYBsNEln4=
Received: from BN0PR08CA0011.namprd08.prod.outlook.com (2603:10b6:408:142::33)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 21:57:49 +0000
Received: from IA0PEPF00000044.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::38) by BN0PR08CA0011.outlook.office365.com
 (2603:10b6:408:142::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 21:57:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000044.mail.protection.outlook.com (10.167.249.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 21:57:48 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 16:57:47 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Mario.Limonciello@amd.com>, <Hawking.Zhang@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Ensure that harvest information gets set
Date: Thu, 22 Oct 2026 17:57:38 -0400
Message-ID: <20261022215738.3248641-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000044:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: 939c8f74-5c04-41bd-b7a9-08df30878302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|261021123027099003|261022105027099003|56012099006|11063799006|261009223027099003|10067099003|18002099003|261021121427099003|261022113327099003;
X-Microsoft-Antispam-Message-Info: lhJvzzWEF9gh9KMTCtfdgijG1XmCLmjjfA5E+tn4vknnHD6GcxaU8IJ0l9E+UKjKQUWve+ZocCgvFz5HsFB8FyTeLgYoJMgW7DbnexgtSLwA3ZFiXPb8X7fjJPQR96t54s2GAhEVtxcaudUYqZjPfE8+JBAsBVFCvhnDG6eNNPoVV1wD2L+B1tyH87qew67LWLsey29SK92AjeDzSfinAeVTZ5oYqUfvibJnBdFd+/J880yf6MpVFThp0NYRQWDbuBSag50nqPUoIecY4sEzPdhDQ58hL2Rx1vJ193uaXrxAurR2WAa7p/3HKW49vqzRU/8m7xnsvISfctFTGy3/Rtvvkf4tLdLcZ25WZpOTEW5bGJknR8zUCk5OpDq+6JqPkiumLGnXvEBGxQqelUV9NBNqXBAvyAkyDnnOMfyI2z5IMdQLVsP4lt5cgvJFKYbnz+6MHdVaiFPZnpA+iJmrYX5iTgTNQGsZEF2byd5i31Zxp85ycks1+7PKbcAm6hrlyP1VEbZQvOO1q2eOGXCX7A+YXramvJ8/mfp/0+ynyR50vgXAce7/NRwCRi68feygiGagF9Ulm13MSE8XbVlZrvmxLUDp3FoShAtY7Gc4d4CLBVaE1SZRFQIuECjWTe/lntxJcyFkbt7ytnxgRBQlstlmD3mjGfmCMgqyji+ldXplBaelCksLZ0v6e6GewfJkKsajgqVCHOeOGs7dWG9tlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(261021123027099003)(261022105027099003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(261021121427099003)(261022113327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UsslfbYZBy1PJUg7QF2FVdxtocEK924teNZ8vy0XQZTx7nsp8BeUrTP+7Gn+8pVdpQsEWKM0lj1XdxdmjXjFjk1L3icvRE90WG7NSBxuHh+m5LfBJX9pYoQl9rlyPK64x1yzAmGUei9r6oZj7Q65/+v448POK/VYVvPemddZg2qtci95Nqg+NV9B9wslZwEDIKfCK1gCC4p43mTCFgRoaUpiT4O8MQ8OM2332RG9eRcAr3HjTrQqznk4f3KfXtxn/lfGfgStGAI77eVypYIlPgaEf5ruqrcS/h1bUgC1zY+58EnCiR6N001dHjdYvFx2+a8ElMu+KMbCjOkpQMzgmkqUbWK30Ar1ngD+MikqH2WRaoVMf9O8tlSkY2kify/k16uqYDcrvHJr8cZIipu38D8byKTWS9dnDu3XXILYqRJkCqMd3ARog18GsZSfYH21
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 21:57:48.6156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 939c8f74-5c04-41bd-b7a9-08df30878302
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000044.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050
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

After the earlier patch export IP discovery on probe failure, there was
an unexpected consequence where harvest info was not populated. The
early-exit in amdgpu_discovery_sysfs_init meant that we never called
amdgpu_discovery_get_harvest_info, which is where we set the actual
harvest value. The first time we call amdgpu_discovery_sysfs_recurse
with NULL instead of adev, most values can get set. The 2nd time
amdgpu_discovery_sysfs_recurse is called, we bail early.

To keep the logic of the first patch intact, ensuring that older kernels
can still discover the IP blocks, add a separate call in the early-exit
section that sets the harvest information. This should be the only
functionality that is missed in this flow, the rest of the calls either
work fine with adev=NULL, or use the discovery_bin directly.

Fixes: 3ee1065e9830 ("drm/amdgpu: Export ip_discovery sysfs on probe failure")
Assisted-by: Claude:claude-opus-4
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 45 +++++++++++++++++--
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 16e3129db6a1..342edbd02880 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1469,6 +1469,41 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev,
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
+	spin_lock(&die_kset->list_lock);
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
+	spin_unlock(&die_kset->list_lock);
+}
+
 static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 {
 	uint8_t *discovery_bin = adev->discovery.bin;
@@ -1479,9 +1514,13 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
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
@@ -1536,8 +1575,6 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 
 /* -------------------------------------------------- */
 
-#define list_to_kobj(el) container_of(el, struct kobject, entry)
-
 static void amdgpu_discovery_sysfs_ip_hw_free(struct ip_hw_id *ip_hw_id)
 {
 	struct list_head *el, *tmp;
-- 
2.43.0

