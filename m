Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0199D606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sNFn09YM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DED110FFC9;
	Thu,  5 Nov 2026 00:05:55 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 375E810FFC9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 00:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faJ0rsxXWdyVmXhKmydNRQ0Im2sxJqMZ/yePuD0c3L2XvjxSl4W3c6AZ7ZyKms1iuY+Qth90GLavDzS18GAIeB6xfe5iBRwK+QPaRP0caA+S4P7/3WqgO7vV+U5VpWE2x/YZgCtyoz6HNxZ0nnp73YpTNFHFILGLAZQEvqAqJ/+y9kxLXlIbCw1D+AUxfRvx+7SGdeYOyWc5Na6FDa7uiYPuSSCMkQL8eMcHUPSM05MPk8JosmNI5HLABa/2iE90BIQWJBa5MApXLMcjopRXZgEBpM7/BYM0TbA1NnXU29JBr/k85aTtRUL3dCK4hXbM6WO/4iEWiJP15k3mHMPWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeAoM54317ufOxNbTOhlMGOKqAqiBazgHVZBLfTfDGg=;
 b=du7VGfiEWfeEF8sdw16t80+AAwMcc210x3/+oC3wKcI5Pr6x+aNRDa/Ry4+wz7fnOT7fBP6WIMGlVeOgCj+hkM4OMgd2sr0sKzSqVWN4JAdlIS0LgjuaFk+SFbIAOwlzGywDQK/krjXFmP5fJhvZsSp3JBvp5GOOCfd5BC4e7ewanvtj0ipIx0OwBi9H3+h4hBrjC9eUwudmKNkPjrijxJnh6bocm1DYtFIVFu/voHIKjcN5oiSFBbZ9uUucwcpNicPw9PcJRMOmX/z/Tsicq5dfxRvPeOcr2suAdAjMPx0a0eBJvngQgx+Ycy5kbro8kJFzAzRP4x0dev8WzHK6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeAoM54317ufOxNbTOhlMGOKqAqiBazgHVZBLfTfDGg=;
 b=sNFn09YMh+3cCKYAzKFXlAUsg5Q+iO65mgLpeN9D5SBMGb6HDjjCgfz0MGjcsIr8F6p3E7jA0+GidW1cEAIOzTeNBxuHJSALiNhfrzJSW+sbb/UIq0H/pPQskyxK4Zg05a86vmMk+QOoJzFm38MusPDvOPipbmK2SD7dICnT6ho=
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 00:05:44 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::9c) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Thu, 5
 Nov 2026 00:05:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 00:05:43 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 18:05:42 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 18:05:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <frank.min@amd.com>,
 <Hawking.Zhang@amd.com>
CC: Frank Min <Frank.Min@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: update table info retrieval from discovery
 binary
Date: Wed, 4 Nov 2026 19:05:25 -0500
Message-ID: <20261105000525.3850296-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105000525.3850296-1-alexander.deucher@amd.com>
References: <20261105000525.3850296-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1b7787-f5a0-4fa4-7ec6-08df3ad0894c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|18002099003|22082099003|261009223027099003|261021123027099003|261021121427099003|11063799006|56012099006|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: jhzWrMjktT0zzizI1iPhUIJ+GDvAixTTOvaSAfQURRcYrnGFnwSro+CWm5ppEvipjnP3kTDhJqPkSSXcWby/uZ/nGteE4QWwPUCAUZJhiplhVewN2tE5mzZU/CG1wOfZlwkEZLFSNMyl13YYCY5fgiKlPTdmekXX345jLASNcOYbQHlSAH2CacRVIucvms8jpAinZAqPCykBYMp+HWBv2cosHaaIP2k6MTtCe3ANPRtIHoDHmdvAwVCjMDZ4W5fIO2XQVXvRquVx44NuZ+GltUzSGA6DHLC/UoMyWWt1T4yGSfgqbVQOzv3nLzkJu+hHiDv1KyTTPyS1ajGx8sq8YKPXhbesBDgOyS1Nm7M7otrHTjCTSiyaCN/wm6dr7C7nS59nLkhEchC1gE5VK0w+c0mApZ86st7qluaoJcFNftC+tPOeJb8vXgFlRJ0odjq/+YanY8wlLTmUHBrggpJNy3XGaPaQ3EeGQ++jlIFGT6g0GfZ/sQXeUxiHClV5rq4R4pvy6UwO1eQyyd0T0qlzQi3WtqOTjaHQTR3QenPRGfmxiflUGEcDttcR/TZfRjfs4GElUE95fJy3dPZ9uvhOLEfFXKG3+Zod2vM65R6uWMv3gy+laurcYva65Kr9eSHgB7BlvtS0cqAFcqfGtklKTFqvidVNbE29h60CvTjedHJ7KStTTpeyjO134f51XymCmOTJp4dZUPsbizusEErQQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(261009223027099003)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d5C2hqFa4mJBpstRuavIZIR8LEsu19xjbtint84cYJ8imhfGX1T9ehTLIBhQlAul/g3EHDLKoX83TqndScMs+9T27oUYOFxzZwp0LmIjOqkQNh7s5C29r4aUqU8wyMQXYK7rN6k7UDosqCu9KtZa0yuQB05EMNRpwD5TrV6ZJS8zyUph4ogItxZt5Z5vcbKyoiDz31rpz1UkNC6NsaNJEMy5BdM3mddyGjGdorfEaSb7OW3UfswajPT0Uy3pejZXyLmjhZSgDE6wqNwmDE8BdJN40pnrc93m/HFNW6wts8tt4Lm42Mf2RSG/L9p5l06XG1Mmf21rtMAA9Kemt9U/l10/3oD62QN28jnxPm/UuDdQMKyO3904C72Row6GUdjlVeuVdj7TYLSVe7+hvJdpicJVeRf0MyIztNUh2qdZeu9h+kDdvMMcguNT/GoTOM6a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 00:05:43.9727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1b7787-f5a0-4fa4-7ec6-08df3ad0894c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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

From: Frank Min <Frank.Min@amd.com>

Update table info retrieval from discovery binary to align with
discovery table update.

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 47 +++++++++++++------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 79a2b1268b23a..351a1e61f525e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -604,18 +604,36 @@ amdgpu_discovery_get_table_info_from_bin(uint8_t *discovery_bin,
 					 uint16_t table_id)
 {
 	struct binary_header *bhdr = (struct binary_header *)discovery_bin;
-	struct binary_header_v2 *bhdrv2;
-
-	switch (bhdr->version_major) {
-	case 2:
-		bhdrv2 = (struct binary_header_v2 *)discovery_bin;
-		return &bhdrv2->table_list[table_id];
-	case 1:
+	struct binary_header_v2 *bhdrv2 = (struct binary_header_v2 *)discovery_bin;
+	uint16_t version = le16_to_cpu(bhdr->version_major);
+	uint16_t binary_size = le16_to_cpu(bhdr->binary_size);
+	struct table_info *table_list;
+	uint16_t num_tables, i;
+	size_t table_offset;
+
+	switch (version) {
 	case 0:
-		return &bhdr->table_list[table_id];
+	case 1:
+		table_list = bhdr->table_list;
+		num_tables = ARRAY_SIZE(bhdr->table_list);
+		break;
+	case 2:
+		table_list = bhdrv2->table_list;
+		num_tables = le16_to_cpu(bhdrv2->num_tables);
+		break;
 	default:
 		return NULL;
 	}
+
+	table_offset = (uint8_t *)table_list - discovery_bin;
+	if (table_offset + num_tables * sizeof(*table_list) > binary_size)
+		return NULL;
+
+	for (i = 0; i < num_tables; i++)
+		if (le16_to_cpu(table_list[i].table_id) == table_id)
+			return &table_list[i];
+
+	return NULL;
 }
 
 static int amdgpu_discovery_get_table_info(struct amdgpu_device *adev,
@@ -628,8 +646,8 @@ static int amdgpu_discovery_get_table_info(struct amdgpu_device *adev,
 	*info = amdgpu_discovery_get_table_info_from_bin(adev->discovery.bin,
 							 table_id);
 	if (!*info) {
-		dev_err(adev->dev, "Invalid ip discovery table version %d\n",
-			bhdr->version_major);
+		dev_err(adev->dev, "Not found table for header version %d table id %d\n",
+			bhdr->version_major, table_id);
 		return -EINVAL;
 	}
 
@@ -640,15 +658,16 @@ static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
 					uint8_t *discovery_bin,
 					uint16_t table_id)
 {
-	int r, act_val, exp_val, table_size;
+	int act_val, exp_val, table_size;
 	uint16_t offset, checksum;
 	struct table_info *info;
 	bool check_table = true;
 	char *table_name;
 
-	r = amdgpu_discovery_get_table_info(adev, &info, table_id);
-	if (r)
-		return r;
+	info = amdgpu_discovery_get_table_info_from_bin(discovery_bin, table_id);
+	if (!info)
+		return 0;
+
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
 
-- 
2.56.0

