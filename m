Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA3BEE14A0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 15:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4996A10E6A3;
	Wed,  6 Sep 2023 15:47:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5C610E6A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 15:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsgfabXc+18rtNrUqt/3W3vUfp7itB8kS4PBJn58RyEjiulm9h2MIhKz4rMnpkm2Ouqx+zmxDp47uiy57TFbYCvhJSWbcnssbOtnsHe6zNDtuaXcdvLwqxU+1kPtv5HHVYSTyxw3hv8RnN36C4JlDF+h2sXmH5oGUcmQ9Zgvi8vZj+uLeLHY7Nxcz41uz9CNvHqvPlo7wOfnJ2ZzeWTmHiUSHC2lvlZPSxQQ98lEraP72seLB0jDg8FBgj0S++KD/l3kCs97fjJuY/QKTmojdj9H3Xqg8d6qx0Nhn+kypvHToItdokCUK07u8t3QqCJpax42VvEOSAIyfyHrShrmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tVtAl+Jaf2Bp36HSylEIRM7+Px+zXHf9uswCv6CZy4=;
 b=kxIOxE7Sao8rAp1mePIoT5eDwQibuzM0JxwOLTUgS20/T7TSCJ9heAQoDbTsYUyhqs8RRDLO/XmjF4DsXY+fVBRHiGZ3o1+faqFVfm+TGIi4nSOwiPrCFwUSVwTNZcXAjMraaXVGQ0HXlxxYP4lqiX6NapbrvJ9jjaIZnw1f/YwLMEwnBy1jIQllz16iVT42EkPE1NGwQ87DqaYYT75nAAFC88WQEUwidAHP+sS6YCq5vsXmnzrDtt2PaoZQ+CcLKYX5XwFEz5xo4X7Ok7LYTZhJTyBo7ZDRMFoNiHVOGzCFIFG2xtpp3iqF/V8OigwNsHQSbHfEwcf7rXRPuHnUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tVtAl+Jaf2Bp36HSylEIRM7+Px+zXHf9uswCv6CZy4=;
 b=tQXhvn9+w5kaDi6LvrL/j/eRySsXJYd0dD9xbOHmrQFcGxllA7PkJkC5htV07NumFFb7UlXLEEjIyEbY4fQy6jxIhxkLbmnFzNgCv9zyDxIK11P14o1FShZE9F9v8BNHG1ZcHMvnEkUiva+bt8Wxp5Tx8VUi9hD0zsSZxhS3u7I=
Received: from DS7PR05CA0010.namprd05.prod.outlook.com (2603:10b6:5:3b9::15)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 6 Sep
 2023 15:47:39 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::ff) by DS7PR05CA0010.outlook.office365.com
 (2603:10b6:5:3b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.27 via Frontend
 Transport; Wed, 6 Sep 2023 15:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 15:47:39 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 10:47:37 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2 2/4] drm/amdkfd: Update cache info reporting for GFX v9.4.3
Date: Wed, 6 Sep 2023 11:44:27 -0400
Message-ID: <20230906154429.216489-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230906154429.216489-1-mukul.joshi@amd.com>
References: <20230906154429.216489-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1e9562-6b5b-44fb-f8aa-08dbaef0999a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qt/J0sx8qkFO+IBfcC+30yEAc7cOc96XFw/dZs8sFaH0o/MrlBi7qMYWZTs1uRFoSyIBDnjynr5fWhs/QKkDiSaKpXBfMApjap886O658ktSf+Cr3K2ea+kkIHnETUXvOnDlWTzTT8zneAM0jAWWz733mERD4+N99spuQD+g2gVJ9kHtU6uFIq5ltHxV738oSNj2exGPdSvBi1kh3O3FrLAg2vm7N+IAv7dK5O+k26NgbD2+gzgJB84/ufgBwucHfwFK2SNLr8hqwAzIvPVkg5CDQMjk8l26kiDnMDa+BORKOj6Sppw/qbCAkWJ2RB5xhhJ+tkm+JpdpvTvM55ItgYCbcti6FcfBqJF9Z/BctX3buS42UG6iTrCfRT6AiiKTFTN5774KOb3KYuamaPLDjlUGws0kQy/gVeMv2t7FYNC5SRhviQkU1GVShaofwitTggLdWtv44tBeDRYuWy3Q90J+FCblY/DJRYjt01WIIj9s7ldjuceXIK58O9ZzVQUPKXguVyBq44t/j+GTXgpWjVND2jJUt8eib5aC+rB5EAdZWiIvn3ItF+eUrmLt7e8Iq957SXy6TyXMW2PRDuj2kxJiagzql9XttNeWSfQSGavDrNPHkI24NudtnLr3qu+0hH0fkUjTDjPq/pyiVCd+6PSo8lOievEuqzH4nLvwwhLm6nl7y+QGeMPYJDXhSDPbPUxWY5TyoITQNwU/6BU5z4JQI+1bSD9DvF3ZIwUNlMvbHQzGIUK+kqh4NsGMzpBGjGmxkzI2/C/RnnrUgiRp8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(70206006)(316002)(47076005)(8936002)(83380400001)(8676002)(4326008)(41300700001)(478600001)(6666004)(16526019)(36860700001)(54906003)(2616005)(426003)(1076003)(6916009)(7696005)(26005)(336012)(81166007)(2906002)(82740400003)(44832011)(15650500001)(356005)(86362001)(40480700001)(36756003)(5660300002)(40460700003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:47:39.4730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1e9562-6b5b-44fb-f8aa-08dbaef0999a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update cache info reporting in sysfs to report the correct
number of CUs and associated cache information based on
different spatial partitioning modes.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Revert the change in kfd_crat.c
- Add a comment to not change value of CRAT_SIBLINGMAP_SIZE.

 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  4 ++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 82 +++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  2 +-
 3 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index 387a8ef49385..74c2d7a0d628 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -79,6 +79,10 @@ struct crat_header {
 #define CRAT_SUBTYPE_IOLINK_AFFINITY		5
 #define CRAT_SUBTYPE_MAX			6
 
+/*
+ * Do not change the value of CRAT_SIBLINGMAP_SIZE from 32
+ * as it breaks the ABI.
+ */
 #define CRAT_SIBLINGMAP_SIZE	32
 
 /*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index c54795682dfb..b98cc7930e4c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1596,14 +1596,17 @@ static int fill_in_l1_pcache(struct kfd_cache_properties **props_ext,
 static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 				struct kfd_gpu_cache_info *pcache_info,
 				struct kfd_cu_info *cu_info,
-				int cache_type, unsigned int cu_processor_id)
+				int cache_type, unsigned int cu_processor_id,
+				struct kfd_node *knode)
 {
 	unsigned int cu_sibling_map_mask;
 	int first_active_cu;
-	int i, j, k;
+	int i, j, k, xcc, start, end;
 	struct kfd_cache_properties *pcache = NULL;
 
-	cu_sibling_map_mask = cu_info->cu_bitmap[0][0][0];
+	start = ffs(knode->xcc_mask) - 1;
+	end = start + NUM_XCC(knode->xcc_mask);
+	cu_sibling_map_mask = cu_info->cu_bitmap[start][0][0];
 	cu_sibling_map_mask &=
 		((1 << pcache_info[cache_type].num_cu_shared) - 1);
 	first_active_cu = ffs(cu_sibling_map_mask);
@@ -1638,16 +1641,18 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 		cu_sibling_map_mask = cu_sibling_map_mask >> (first_active_cu - 1);
 		k = 0;
 
-		for (i = 0; i < cu_info->num_shader_engines; i++) {
-			for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
-				pcache->sibling_map[k] = (uint8_t)(cu_sibling_map_mask & 0xFF);
-				pcache->sibling_map[k+1] = (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
-				pcache->sibling_map[k+2] = (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
-				pcache->sibling_map[k+3] = (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
-				k += 4;
-
-				cu_sibling_map_mask = cu_info->cu_bitmap[0][i % 4][j + i / 4];
-				cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
+		for (xcc = start; xcc < end; xcc++) {
+			for (i = 0; i < cu_info->num_shader_engines; i++) {
+				for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
+					pcache->sibling_map[k] = (uint8_t)(cu_sibling_map_mask & 0xFF);
+					pcache->sibling_map[k+1] = (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
+					pcache->sibling_map[k+2] = (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
+					pcache->sibling_map[k+3] = (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
+					k += 4;
+
+					cu_sibling_map_mask = cu_info->cu_bitmap[start][i % 4][j + i / 4];
+					cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
+				}
 			}
 		}
 		pcache->sibling_map_size = k;
@@ -1665,7 +1670,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct kfd_node *kdev)
 {
 	struct kfd_gpu_cache_info *pcache_info = NULL;
-	int i, j, k;
+	int i, j, k, xcc, start, end;
 	int ct = 0;
 	unsigned int cu_processor_id;
 	int ret;
@@ -1699,37 +1704,42 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 	 *			then it will consider only one CU from
 	 *			the shared unit
 	 */
+	start = ffs(kdev->xcc_mask) - 1;
+	end = start + NUM_XCC(kdev->xcc_mask);
+
 	for (ct = 0; ct < num_of_cache_types; ct++) {
 		cu_processor_id = gpu_processor_id;
 		if (pcache_info[ct].cache_level == 1) {
-			for (i = 0; i < pcu_info->num_shader_engines; i++) {
-				for (j = 0; j < pcu_info->num_shader_arrays_per_engine; j++) {
-					for (k = 0; k < pcu_info->num_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
-
-						ret = fill_in_l1_pcache(&props_ext, pcache_info, pcu_info,
-									pcu_info->cu_bitmap[0][i % 4][j + i / 4], ct,
-									cu_processor_id, k);
-
-						if (ret < 0)
-							break;
-
-						if (!ret) {
-							num_of_entries++;
-							list_add_tail(&props_ext->list, &dev->cache_props);
+			for (xcc = start; xcc < end; xcc++) {
+				for (i = 0; i < pcu_info->num_shader_engines; i++) {
+					for (j = 0; j < pcu_info->num_shader_arrays_per_engine; j++) {
+						for (k = 0; k < pcu_info->num_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
+
+							ret = fill_in_l1_pcache(&props_ext, pcache_info, pcu_info,
+										pcu_info->cu_bitmap[xcc][i % 4][j + i / 4], ct,
+										cu_processor_id, k);
+
+							if (ret < 0)
+								break;
+
+							if (!ret) {
+								num_of_entries++;
+								list_add_tail(&props_ext->list, &dev->cache_props);
+							}
+
+							/* Move to next CU block */
+							num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
+								pcu_info->num_cu_per_sh) ?
+								pcache_info[ct].num_cu_shared :
+								(pcu_info->num_cu_per_sh - k);
+							cu_processor_id += num_cu_shared;
 						}
-
-						/* Move to next CU block */
-						num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
-							pcu_info->num_cu_per_sh) ?
-							pcache_info[ct].num_cu_shared :
-							(pcu_info->num_cu_per_sh - k);
-						cu_processor_id += num_cu_shared;
 					}
 				}
 			}
 		} else {
 			ret = fill_in_l2_l3_pcache(&props_ext, pcache_info,
-								pcu_info, ct, cu_processor_id);
+					pcu_info, ct, cu_processor_id, kdev);
 
 			if (ret < 0)
 				break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index dea32a9e5506..27386ce9a021 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -89,7 +89,7 @@ struct kfd_mem_properties {
 	struct attribute	attr;
 };
 
-#define CACHE_SIBLINGMAP_SIZE 64
+#define CACHE_SIBLINGMAP_SIZE 128
 
 struct kfd_cache_properties {
 	struct list_head	list;
-- 
2.35.1

