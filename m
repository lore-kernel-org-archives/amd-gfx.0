Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF70C25B79
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7217510E1B2;
	Tue, 14 May 2024 08:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RjQwdV0d";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681FD10E5F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRN27KxGC5xD8eCLMnljfCadERii1Mbkqys9q+BOtPaSfVsHnMQO56H+mQd8dm+AawP7VgUqbye3URku4UrEvNQ+QaAeCZbOWoRCvfmSB9SPg4i5ldShmzffR/euo+GoEig/oIGyYB0Z9+B7cV3cFgyNR7cGUGGmvUeVh7U5Y5QDjJPUXwV2x1rHyXBITigQ8HhFqhxg4jbzVkMNob2ibAgqeJ0sxepab9JSVj0tJjfsyy7gFWAslwhnz7IVAHjBxBUR4BqM+1DMPiGOZcexwtyotl693jAWm3LXGVmLPrdyB+KrQSe9EnQuUmjpXgpmILgiC1fzXY3QeSCZTXi0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmBAEmVzbGt8Cndz43E//KnKoY0f3GI4aMlbNoUqGlg=;
 b=PYY10flb86uqb5gJObkQa3hAqW+uvYO107f/HEtMxFLgTHXXI1rPudPub3dnKeomXBnCRLumJ36BtTDbZfSzKKjVKsYwXyBDFm15Vf7qXQJ9Cn3I0pmH6plAGh4Grlkp16Yy2DoZhl84h7uG7Ktqdek5LKIhacWzCyzuKzbNtP7fXZH5b4pJJfJGNzXnDwcrBVN5/NZKKhhSaCHMQeuakyh+kA4VRNUH+LESqH+yd4j51HJusnUJ9ySyC7FZQPTB4LbYXvoqAE+pMBZOGoTzdzosx7p/QkK/L44AiwkE2L66COi2qQyuSZJPzoeTAAb0k/s+Gc4YC4f99NwCLq28mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmBAEmVzbGt8Cndz43E//KnKoY0f3GI4aMlbNoUqGlg=;
 b=RjQwdV0dwbUhbnFXsHRaa/9Zc1Ypp1777DVliDdIy4V4pwAfw0NTODQIQ/79cVYtvMFXuEoAsrN6F9NpMPdjxvmHy0P1Epp8o7JGF8yo2Pv7U2ROA6Yp3gDxZKccGOCMpK1p+DNOsDxQQfeKzpEmRkqVPBLKe88xKDsg/1eukYc=
Received: from BY5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:1e0::12)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:36:49 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::7c) by BY5PR03CA0002.outlook.office365.com
 (2603:10b6:a03:1e0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 08:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 08:36:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 03:36:44 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Le.Ma@amd.com>, Le Ma <le.ma@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Use NPS ranges from discovery table
Date: Tue, 14 May 2024 14:06:26 +0530
Message-ID: <20240514083626.378626-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514083626.378626-1-lijo.lazar@amd.com>
References: <20240514083626.378626-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: a45ede1d-6b00-4e15-dbe7-08dc73f0ff72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?koUMH20rHzH7/1EWSt5f7H+Y/SQOTJNBU7ZWyO9yfCcFUBjkiwpXWDdKyTmV?=
 =?us-ascii?Q?0SVZtls0f3WZ1HMISCJ4ZFP7yYdkGHTdFSYF1ouzq/2iOwe6DODDF9EMCNE8?=
 =?us-ascii?Q?vwtnXAO84jUbbIx6qIHQ3ICnni4/h5zVGu4I7XOqbuuW4VkKfAhKa1d1T9H3?=
 =?us-ascii?Q?rs6oALb7f3ETJiqtP7UdRO9oLgY8luYfOus81gm1nnO6ruu0a+KoSxToO+6o?=
 =?us-ascii?Q?GIPfDdi0evfeQXH8IlgIUCKR1VxtxSMPjLkhmTSyyIkG73J2EtNHg4ha7bji?=
 =?us-ascii?Q?5EWtKCKETIgdQbWm8pAmQ6RO8I3xPq/9a1mF4E9Kh/ABvpB0ejRx57dK2sBY?=
 =?us-ascii?Q?3KQ+ax3WrBilWY1+tab7UT4dG2Vo2MjBB7IELO73LGRc9MvibxfjJckWShyZ?=
 =?us-ascii?Q?XSeEmWtRdXC2UdmtojxFYA1z63lYgEV14h+tA25THSk2EgFDJ/Ytauk7un/7?=
 =?us-ascii?Q?Ne+5MDHI0KzDMuNRNREUWq1x5xviG9fHhHsdwFbZzeMUu2KrKl/6uXy++ebc?=
 =?us-ascii?Q?to68e02LKFBLiVkoNjSutFqgJMdfYw3oavyr3BxVoRUYiAMjaYkpL06A7jXb?=
 =?us-ascii?Q?ZI2etJ8SsGkILEcmkcv3rIydGjtK2bGzQJZt+NnE+aKNSW9ZaxCrPE/Tz1Vw?=
 =?us-ascii?Q?qdoC+S4mxkzG0jjDEk47N7CC/7dtOSAuzs1/6tE3jOVSckyJg9+mnUFP8v+M?=
 =?us-ascii?Q?Y1Hx79h5SiJr+iC6QQmqww10ZUJDye4VqaOBmYjHIdOw8oMyat3zLAUs6cRL?=
 =?us-ascii?Q?hBa6BViN5VPx1OO1OL0UeYiU283nNzrj6kMZZ3kjnP6W0LeWMFryCq5YLS6D?=
 =?us-ascii?Q?UBp6ZernKzfhJ2sLCkBx2YBPWRX2hOsLGnn2AHV+JHODF9yMiZQeg2GOcrLW?=
 =?us-ascii?Q?AFmd9IXWGhWxs8ZCns2ftLGB9kWUfaBc9nRtmy5BYUeFy9xBAsQ2aBGjy5I3?=
 =?us-ascii?Q?oPiGdAxfuSJXkMVSy+4Qo3QE1+OB/5OG4cd/SVSs5MUryqnrkfrFJySaMann?=
 =?us-ascii?Q?Y0psLaCa6k5OlXgFMNRD99cUFekb+D86Otmnlj/3Qa49FcGIKDvuO31DQ0Lw?=
 =?us-ascii?Q?IiP+6peEqKfqVU3Qb7vAgqtAEpAXVntl5cATEZefExdAmFpbngx1B1WyyhFb?=
 =?us-ascii?Q?rQV+DLEeedg/l2zu0E3EEQJ/5/2VEmfkbheDm25RZrB69CJz7frSNZjMZY2w?=
 =?us-ascii?Q?/2WxWqzKQpdwsMjhaF3rqyTjXn1CjnHxF+XGNBXzLdZSWrZkHAE2/qC6gtW/?=
 =?us-ascii?Q?TedMIskvvNmh42Ica0gMn40p0Ab5Grv6RptaW4QbVerEBJDDU9ZYh4INNKkv?=
 =?us-ascii?Q?AwsSEETeZjmIuKWbPrXQSzqhe+AlIyyPwa21i5QqIu4UE3rHgnD4aypXQYAg?=
 =?us-ascii?Q?F/BELEU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:36:49.3424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a45ede1d-6b00-4e15-dbe7-08dc73f0ff72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
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

Add GMC API to fetch NPS range information from discovery table. Use NPS
range information in GMC 9.4.3 SOCs when available, otherwise fallback
to software method.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 92 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 76 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       | 11 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 40 +++++---
 5 files changed, 212 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 43528ff50e72..afe8d12667f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -367,6 +367,35 @@ static void amdgpu_discovery_harvest_config_quirk(struct amdgpu_device *adev)
 	}
 }
 
+static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
+					   struct binary_header *bhdr)
+{
+	struct table_info *info;
+	uint16_t checksum;
+	uint16_t offset;
+
+	info = &bhdr->table_list[NPS_INFO];
+	offset = le16_to_cpu(info->offset);
+	checksum = le16_to_cpu(info->checksum);
+
+	struct nps_info_header *nhdr =
+		(struct nps_info_header *)(adev->mman.discovery_bin + offset);
+
+	if (le32_to_cpu(nhdr->table_id) != NPS_INFO_TABLE_ID) {
+		dev_dbg(adev->dev, "invalid ip discovery nps info table id\n");
+		return -EINVAL;
+	}
+
+	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
+					      le32_to_cpu(nhdr->size_bytes),
+					      checksum)) {
+		dev_dbg(adev->dev, "invalid nps info data table checksum\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int amdgpu_discovery_init(struct amdgpu_device *adev)
 {
 	struct table_info *info;
@@ -1681,6 +1710,69 @@ static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 	return 0;
 }
 
+union nps_info {
+	struct nps_info_v1_0 v1;
+};
+
+int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
+				  uint32_t *nps_type,
+				  struct amdgpu_gmc_memrange **ranges,
+				  int *range_cnt)
+{
+	struct amdgpu_gmc_memrange *mem_ranges;
+	struct binary_header *bhdr;
+	union nps_info *nps_info;
+	u16 offset;
+	int i;
+
+	if (!nps_type || !range_cnt || !ranges)
+		return -EINVAL;
+
+	if (!adev->mman.discovery_bin) {
+		dev_err(adev->dev,
+			"fetch mem range failed, ip discovery uninitialized\n");
+		return -EINVAL;
+	}
+
+	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	offset = le16_to_cpu(bhdr->table_list[NPS_INFO].offset);
+
+	if (!offset)
+		return -ENOENT;
+
+	/* If verification fails, return as if NPS table doesn't exist */
+	if (amdgpu_discovery_verify_npsinfo(adev, bhdr))
+		return -ENOENT;
+
+	nps_info = (union nps_info *)(adev->mman.discovery_bin + offset);
+
+	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
+	case 1:
+		*nps_type = nps_info->v1.nps_type;
+		*range_cnt = nps_info->v1.count;
+		mem_ranges = kvzalloc(
+			*range_cnt * sizeof(struct amdgpu_gmc_memrange),
+			GFP_KERNEL);
+		for (i = 0; i < *range_cnt; i++) {
+			mem_ranges[i].base_address =
+				nps_info->v1.instance_info[i].base_address;
+			mem_ranges[i].limit_address =
+				nps_info->v1.instance_info[i].limit_address;
+			mem_ranges[i].nid_mask = -1;
+			mem_ranges[i].flags = 0;
+		}
+		*ranges = mem_ranges;
+		break;
+	default:
+		dev_err(adev->dev, "Unhandled NPS info table %d.%d\n",
+			le16_to_cpu(nps_info->v1.header.version_major),
+			le16_to_cpu(nps_info->v1.header.version_minor));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 {
 	/* what IP to use for this? */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 4d03cd5b3410..f5d36525ec3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -30,4 +30,9 @@
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
 
+int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
+				  uint32_t *nps_type,
+				  struct amdgpu_gmc_memrange **ranges,
+				  int *range_cnt);
+
 #endif /* __AMDGPU_DISCOVERY__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f8ed886ffca3..78cd31e929c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1165,3 +1165,79 @@ void amdgpu_gmc_sysfs_fini(struct amdgpu_device *adev)
 {
 	device_remove_file(adev->dev, &dev_attr_current_memory_partition);
 }
+
+int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
+				 struct amdgpu_mem_partition_info *mem_ranges,
+				 int exp_ranges)
+{
+	struct amdgpu_gmc_memrange *ranges;
+	int range_cnt, ret, i, j;
+	uint32_t nps_type;
+
+	if (!mem_ranges)
+		return -EINVAL;
+
+	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
+					    &range_cnt);
+
+	if (ret)
+		return ret;
+
+	/* TODO: For now, expect ranges and partition count to be the same.
+	 * Adjust if there are holes expected in any NPS domain.
+	 */
+	if (range_cnt != exp_ranges) {
+		dev_warn(
+			adev->dev,
+			"NPS config mismatch - expected ranges: %d discovery - nps mode: %d, nps ranges: %d",
+			exp_ranges, nps_type, range_cnt);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	for (i = 0; i < exp_ranges; ++i) {
+		if (ranges[i].base_address >= ranges[i].limit_address) {
+			dev_warn(
+				adev->dev,
+				"Invalid NPS range - nps mode: %d, range[%d]: base: %llx limit: %llx",
+				nps_type, i, ranges[i].base_address,
+				ranges[i].limit_address);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		/* Check for overlaps, not expecting any now */
+		for (j = i - 1; j >= 0; j--) {
+			if (max(ranges[j].base_address,
+				ranges[i].base_address) <=
+			    min(ranges[j].limit_address,
+				ranges[i].limit_address)) {
+				dev_warn(
+					adev->dev,
+					"overlapping ranges detected [ %llx - %llx ] | [%llx - %llx]",
+					ranges[j].base_address,
+					ranges[j].limit_address,
+					ranges[i].base_address,
+					ranges[i].limit_address);
+				ret = -EINVAL;
+				goto err;
+			}
+		}
+
+		mem_ranges[i].range.fpfn =
+			(ranges[i].base_address -
+			 adev->vm_manager.vram_base_offset) >>
+			AMDGPU_GPU_PAGE_SHIFT;
+		mem_ranges[i].range.lpfn =
+			(ranges[i].limit_address -
+			 adev->vm_manager.vram_base_offset) >>
+			AMDGPU_GPU_PAGE_SHIFT;
+		mem_ranges[i].size =
+			ranges[i].limit_address - ranges[i].base_address + 1;
+	}
+
+err:
+	kfree(ranges);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 17f40ea1104b..febca3130497 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -199,6 +199,13 @@ struct amdgpu_mem_partition_info {
 
 #define INVALID_PFN    -1
 
+struct amdgpu_gmc_memrange {
+	uint64_t base_address;
+	uint64_t limit_address;
+	uint32_t flags;
+	int nid_mask;
+};
+
 enum amdgpu_gart_placement {
 	AMDGPU_GART_PLACEMENT_BEST_FIT = 0,
 	AMDGPU_GART_PLACEMENT_HIGH,
@@ -439,4 +446,8 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
 int amdgpu_gmc_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_gmc_sysfs_fini(struct amdgpu_device *adev);
 
+int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
+				 struct amdgpu_mem_partition_info *mem_ranges,
+				 int exp_ranges);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 7c4e2adae7b3..094c08cb98e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1895,7 +1895,7 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
 {
 	enum amdgpu_memory_partition mode;
 	u32 start_addr = 0, size;
-	int i;
+	int i, r, l;
 
 	mode = gmc_v9_0_query_memory_partition(adev);
 
@@ -1918,23 +1918,39 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
 		break;
 	}
 
-	size = (adev->gmc.real_vram_size + SZ_16M) >> AMDGPU_GPU_PAGE_SHIFT;
-	size /= adev->gmc.num_mem_partitions;
+	/* Use NPS range info, if populated */
+	r = amdgpu_gmc_get_nps_memranges(adev, mem_ranges,
+					 adev->gmc.num_mem_partitions);
+	if (!r) {
+		l = 0;
+		for (i = 1; i < adev->gmc.num_mem_partitions; ++i) {
+			if (mem_ranges[i].range.lpfn >
+			    mem_ranges[i - 1].range.lpfn)
+				l = i;
+		}
+
+	} else {
+		/* Fallback to sw based calculation */
+		size = (adev->gmc.real_vram_size + SZ_16M) >> AMDGPU_GPU_PAGE_SHIFT;
+		size /= adev->gmc.num_mem_partitions;
+
+		for (i = 0; i < adev->gmc.num_mem_partitions; ++i) {
+			mem_ranges[i].range.fpfn = start_addr;
+			mem_ranges[i].size =
+				((u64)size << AMDGPU_GPU_PAGE_SHIFT);
+			mem_ranges[i].range.lpfn = start_addr + size - 1;
+			start_addr += size;
+		}
 
-	for (i = 0; i < adev->gmc.num_mem_partitions; ++i) {
-		mem_ranges[i].range.fpfn = start_addr;
-		mem_ranges[i].size = ((u64)size << AMDGPU_GPU_PAGE_SHIFT);
-		mem_ranges[i].range.lpfn = start_addr + size - 1;
-		start_addr += size;
+		l = adev->gmc.num_mem_partitions - 1;
 	}
 
 	/* Adjust the last one */
-	mem_ranges[adev->gmc.num_mem_partitions - 1].range.lpfn =
+	mem_ranges[l].range.lpfn =
 		(adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT) - 1;
-	mem_ranges[adev->gmc.num_mem_partitions - 1].size =
+	mem_ranges[l].size =
 		adev->gmc.real_vram_size -
-		((u64)mem_ranges[adev->gmc.num_mem_partitions - 1].range.fpfn
-		 << AMDGPU_GPU_PAGE_SHIFT);
+		((u64)mem_ranges[l].range.fpfn << AMDGPU_GPU_PAGE_SHIFT);
 }
 
 static int gmc_v9_0_init_mem_ranges(struct amdgpu_device *adev)
-- 
2.25.1

