Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60A3FCB619
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83F7210ED59;
	Fri,  6 Mar 2026 15:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3aQK1AUA";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010015.outbound.protection.outlook.com
 [52.101.193.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6743310ED59
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8lSWKACJEVEWBvDnhsCMplY9tfrIbWXGHmyNhjXrr8a9VbWmdaRcIFdHNtaRjjP7sX7yRB3L9HYSspOeUF/5lxRNj2JDH/kRwFEPPBp70YNHh1c9UOcQipfQVxi5L47ClXxGeVOE1XcsslqGuqrQ0AC1vgF4QSeGhJGP6cN2/5B+ltz8+Mo1dR/UtPnpGXrTvqGNS7RgEjuXmC3nk86yXlrm2uNfJXvb+8PmjOfTJ3D1sFjIww9WDdmKuy5VkrbzNSQ3GSAXLc1LfmJ5p+c+7v5uUZ/LZyd//6xSVy7FWtHxB53zU+SzuWOEA0qpLU0YzRAaMF4yrKqpjYgpNK8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JNSRDmE0i3+jd3+8CkUXqUcNU3G2ShPZ3+ybe88UVQ=;
 b=OGwTs3umBQ5QDob8Ebf3REQF7qZqn28KvvNlaZDf7IBpcoa/g6n7eXbubqbJ/eLnXMIIfl0AODWZ1+VzNMDvfu27GxhItNYvzhPN1t5ZCXT3xWjoCY5zU9qYc8E8RXI9xVhocWNV54f4cyAxS4VftnWnkaOoLyINNf6KvA1QpaVW4mtrylZ8veCmoKxyqrKa1oe8bWiSjYHWroUofofHC5RRO4WUwqUVIR+neFb8UrqNVCiyj8eH/VjClehNoeYUEDvK7Gki/OKFj9vzPP118e6TuCbJWgCyiE3Lyx+5ss0IXBqm7akZutNHlqVPs7EzOUkShD6xgYuqSKw0Z4Xn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JNSRDmE0i3+jd3+8CkUXqUcNU3G2ShPZ3+ybe88UVQ=;
 b=3aQK1AUAWvBGp6ByJKSVHA3zxpK+QJjlDxf36kJLi+Ys7Q89ic3E+Ont2CqbJvLjsaIGgqjouuCiSGChTHrx+vaI7rRb0IIDVHYubYc7aehPoeVyM/PtXAeH3i5I4cWBRlmh2HvoN1wWmxO9E0TTCMpyCp6HBR+B2E0Ggrv28gw=
Received: from SA9PR13CA0003.namprd13.prod.outlook.com (2603:10b6:806:21::8)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:36:27 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::d5) by SA9PR13CA0003.outlook.office365.com
 (2603:10b6:806:21::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 15:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:36:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:36:26 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:36:25 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:36:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/discovery: use common function to check
 discovery table
Date: Fri, 6 Mar 2026 10:36:13 -0500
Message-ID: <20260306153615.21854-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306153615.21854-1-alexander.deucher@amd.com>
References: <20260306153615.21854-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 0132bc8d-2acf-4a4d-0ca9-08de7b962130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026; 
X-Microsoft-Antispam-Message-Info: GisQGWrFIK60TWkD2BVH2QNU07+b6wv7uHR8/T+52YvHWi4BUOUzjwJ2Z4fUshcQBs57amlkI3Ci3URQfL7yQ7+Ta+DDK2O4HS2d2PAzjgTZvqfdE3HADZmmZjp9asQdEKC+jXM8Okvx5Ln+cxxpb+EMKU4NGlvwFsNxvW/LNaDQ1lrp54K+WFmvTimTHajn4IIPhc6W5T/gEbFpPj3pL2f7ejWTc74oPaSfBC9wiKDjvFEJX4aLKf+tqctlYGDa7lPGGMZTETuc4cEhr0Kg74gvO+WFqbm7aY+IPXI4OvTwFOUGGnfRNJx/ZbnPwc4cX7Ek52lyHBoWPCwxKPyP3kxEvvOQKHqb0n9sRoffKFHShit9d6UK3VhHtAXKuYwXuKztoYQTwExBJiGonn0qDYhFgJ88ZhPyWL9SvGEqdpgy8WBj5sgK+bbm4jZ+RWPSQuiVI/3TM4Hkt/95o18LxwMPKha1vO+EFLJFHkEwrvxDTrUguSdKje0vrB6+sFuOnF4U320h6SFYCfkhKGV1JdDRqdxoK3JaSxheQT2fa3KbVk5zLqqxFXRd0QZrf9EBAU/zopoL5fPtLHApVrWyVuV2m/XaSOxIGYqYnbEy4amdopWE5mqRpDc9Cq2yFJd5S0WhtXZ/N0hMLkD+S6XBokvzxtmayCy9XF3+QxCTH3RKTJr+mIyUjsBSei4EuJ++j2j9rhDHzsz4Cq7b6NWpFcO0HjkACGbuj6QZgyJyK0EsASThhX9Kt6WPsLdloUT524ow5auZrzHMMOM8bYnF2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y9xOEp3m1avD1fJIB3JhKoNrAQpc1IYzDZRwY/ysqSL5qYYfTo6IoU+t0cNiE+SNGmu7IKGbzQN74b/7FjoB7WKq6bBFuRzfigqfQyMZnc9zNjjpkF9tQ0ZhahgylvaJJza6CIZ4ZWGl6DYX+SY52z1N5cnb/ps6XVkyJc9t3ZrFhmZA2/0xPhA+iVR1D4KDBS4LjIGAjcRuRbxHv2ikcNGEHbLwKmufyLdsd+y+m5rVVunVR/MGxlClloNgjsGoEagCdmVwqBXqIZMd8ddXe/m6YjpItaYVDl1I6wo32F8jxaLUuVVp7wHjDVMxOz7Z5vWSZKPkSkbja8AuSiAe1TpTS19BlKqj5O3P2oOpBLxsXrFDO7smPejmAxw/k+OvXqcT6yZ6drjBfz4qdd2hp2Uez9h6fMjag3D7qlDUdplwESYFDXk5mdYIF633bAtg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:36:26.4946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0132bc8d-2acf-4a4d-0ca9-08de7b962130
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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

From: Likun Gao <Likun.Gao@amd.com>

Use an common function to check the validation of discovery table.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 206 +++++++-----------
 1 file changed, 84 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index cab5e643cf21b..415849bf568b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -513,15 +513,95 @@ static int amdgpu_discovery_get_table_info(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_discovery_init(struct amdgpu_device *adev)
+static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
+					uint8_t *discovery_bin,
+					uint16_t table_id)
 {
+	int r, act_val, exp_val, table_size;
+	uint16_t offset, checksum;
 	struct table_info *info;
+	bool check_table = true;
+	char *table_name;
+
+	r = amdgpu_discovery_get_table_info(adev, &info, table_id);
+	if (r)
+		return r;
+	offset = le16_to_cpu(info->offset);
+	checksum = le16_to_cpu(info->checksum);
+
+	switch (table_id) {
+	case IP_DISCOVERY:
+		struct ip_discovery_header *ihdr =
+			(struct ip_discovery_header *)(discovery_bin + offset);
+		act_val = le32_to_cpu(ihdr->signature);
+		exp_val = DISCOVERY_TABLE_SIGNATURE;
+		table_size = le16_to_cpu(ihdr->size);
+		table_name = "data table";
+		break;
+	case GC:
+		struct gpu_info_header *ghdr =
+			(struct gpu_info_header *)(discovery_bin + offset);
+		act_val = le32_to_cpu(ghdr->table_id);
+		exp_val = GC_TABLE_ID;
+		table_size = le16_to_cpu(ghdr->size);
+		table_name = "gc table";
+		break;
+	case HARVEST_INFO:
+		struct harvest_info_header *hhdr =
+			(struct harvest_info_header *)(discovery_bin + offset);
+		act_val = le32_to_cpu(hhdr->signature);
+		exp_val = HARVEST_TABLE_SIGNATURE;
+		table_size = sizeof(struct harvest_table);
+		table_name = "harvest table";
+		break;
+	case VCN_INFO:
+		struct vcn_info_header *vhdr =
+			(struct vcn_info_header *)(discovery_bin + offset);
+		act_val = le32_to_cpu(vhdr->table_id);
+		exp_val = VCN_INFO_TABLE_ID;
+		table_size = le32_to_cpu(vhdr->size_bytes);
+		table_name = "vcn table";
+		break;
+	case MALL_INFO:
+		struct mall_info_header *mhdr =
+			(struct mall_info_header *)(discovery_bin + offset);
+		act_val = le32_to_cpu(mhdr->table_id);
+		exp_val = MALL_INFO_TABLE_ID;
+		table_size = le32_to_cpu(mhdr->size_bytes);
+		table_name = "mall table";
+		check_table = false;
+		break;
+	default:
+		dev_err(adev->dev, "invalid ip discovery table id %d specified\n", table_id);
+		check_table = false;
+		break;
+	}
+
+	if (check_table && offset) {
+		if (act_val != exp_val) {
+			dev_err(adev->dev, "invalid ip discovery %s signature\n", table_name);
+			return -EINVAL;
+		}
+
+		if (!amdgpu_discovery_verify_checksum(adev, discovery_bin + offset,
+						      table_size, checksum)) {
+			dev_err(adev->dev, "invalid ip discovery %s checksum\n", table_name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int amdgpu_discovery_init(struct amdgpu_device *adev)
+{
 	struct binary_header *bhdr;
 	uint8_t *discovery_bin;
 	const char *fw_name;
 	uint16_t offset;
 	uint16_t size;
 	uint16_t checksum;
+	uint16_t table_id;
 	int r;
 
 	adev->discovery.bin = kzalloc(DISCOVERY_TMR_SIZE, GFP_KERNEL);
@@ -569,128 +649,10 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		goto out;
 	}
 
-	r = amdgpu_discovery_get_table_info(adev, &info, IP_DISCOVERY);
-	if (r)
-		goto out;
-	offset = le16_to_cpu(info->offset);
-	checksum = le16_to_cpu(info->checksum);
-
-	if (offset) {
-		struct ip_discovery_header *ihdr =
-			(struct ip_discovery_header *)(discovery_bin + offset);
-		if (le32_to_cpu(ihdr->signature) != DISCOVERY_TABLE_SIGNATURE) {
-			dev_err(adev->dev, "invalid ip discovery data table signature\n");
-			r = -EINVAL;
-			goto out;
-		}
-
-		if (!amdgpu_discovery_verify_checksum(adev, discovery_bin + offset,
-						      le16_to_cpu(ihdr->size),
-						      checksum)) {
-			dev_err(adev->dev, "invalid ip discovery data table checksum\n");
-			r = -EINVAL;
-			goto out;
-		}
-	}
-
-	r = amdgpu_discovery_get_table_info(adev, &info, GC);
-	if (r)
-		goto out;
-	offset = le16_to_cpu(info->offset);
-	checksum = le16_to_cpu(info->checksum);
-
-	if (offset) {
-		struct gpu_info_header *ghdr =
-			(struct gpu_info_header *)(discovery_bin + offset);
-
-		if (le32_to_cpu(ghdr->table_id) != GC_TABLE_ID) {
-			dev_err(adev->dev, "invalid ip discovery gc table id\n");
-			r = -EINVAL;
-			goto out;
-		}
-
-		if (!amdgpu_discovery_verify_checksum(adev, discovery_bin + offset,
-						      le32_to_cpu(ghdr->size),
-						      checksum)) {
-			dev_err(adev->dev, "invalid gc data table checksum\n");
-			r = -EINVAL;
-			goto out;
-		}
-	}
-
-	r = amdgpu_discovery_get_table_info(adev, &info, HARVEST_INFO);
-	if (r)
-		goto out;
-	offset = le16_to_cpu(info->offset);
-	checksum = le16_to_cpu(info->checksum);
-
-	if (offset) {
-		struct harvest_info_header *hhdr =
-			(struct harvest_info_header *)(discovery_bin + offset);
-
-		if (le32_to_cpu(hhdr->signature) != HARVEST_TABLE_SIGNATURE) {
-			dev_err(adev->dev, "invalid ip discovery harvest table signature\n");
-			r = -EINVAL;
-			goto out;
-		}
-
-		if (!amdgpu_discovery_verify_checksum(adev,
-			    discovery_bin + offset,
-			    sizeof(struct harvest_table), checksum)) {
-			dev_err(adev->dev, "invalid harvest data table checksum\n");
-			r = -EINVAL;
-			goto out;
-		}
-	}
-
-	r = amdgpu_discovery_get_table_info(adev, &info, VCN_INFO);
-	if (r)
-		goto out;
-	offset = le16_to_cpu(info->offset);
-	checksum = le16_to_cpu(info->checksum);
-
-	if (offset) {
-		struct vcn_info_header *vhdr =
-			(struct vcn_info_header *)(discovery_bin + offset);
-
-		if (le32_to_cpu(vhdr->table_id) != VCN_INFO_TABLE_ID) {
-			dev_err(adev->dev, "invalid ip discovery vcn table id\n");
-			r = -EINVAL;
-			goto out;
-		}
-
-		if (!amdgpu_discovery_verify_checksum(adev,
-			    discovery_bin + offset,
-			    le32_to_cpu(vhdr->size_bytes), checksum)) {
-			dev_err(adev->dev, "invalid vcn data table checksum\n");
-			r = -EINVAL;
-			goto out;
-		}
-	}
-
-	r = amdgpu_discovery_get_table_info(adev, &info, MALL_INFO);
-	if (r)
-		goto out;
-	offset = le16_to_cpu(info->offset);
-	checksum = le16_to_cpu(info->checksum);
-
-	if (0 && offset) {
-		struct mall_info_header *mhdr =
-			(struct mall_info_header *)(discovery_bin + offset);
-
-		if (le32_to_cpu(mhdr->table_id) != MALL_INFO_TABLE_ID) {
-			dev_err(adev->dev, "invalid ip discovery mall table id\n");
-			r = -EINVAL;
-			goto out;
-		}
-
-		if (!amdgpu_discovery_verify_checksum(adev,
-			    discovery_bin + offset,
-			    le32_to_cpu(mhdr->size_bytes), checksum)) {
-			dev_err(adev->dev, "invalid mall data table checksum\n");
-			r = -EINVAL;
+	for (table_id = 0; table_id <= MALL_INFO; table_id++) {
+		r = amdgpu_discovery_table_check(adev, discovery_bin, table_id);
+		if (r)
 			goto out;
-		}
 	}
 
 	return 0;
-- 
2.53.0

