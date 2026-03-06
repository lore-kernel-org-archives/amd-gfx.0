Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E7FFCB61B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF0510ED57;
	Fri,  6 Mar 2026 15:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0AGu//C+";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9600A10ED54
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvs6Bs1TsZSGQ6Y8u7OTIyrzG3JnnaI+200REZD8Zbgh1jGzmhLMk0b2mjBg/zsCTf3xIMYgxfgkmQQJQAMswLBJ1f5guhSRA/sN/Vd/1718X3XhBkdWHg+4vBB2MZo0r8QVWOn60L2AIkVVlD/JOk9DP/rjTqanIBq0W4k3KaVCbQtSHF/huNrvUDQpHwII8Os/+JW0B/KM9Es0w0koPSU4EaiyDtsNE3CJFqfG8br+BdFvau1hInDtnEzZseoIHF3BDg7RT/Z/Cudh/JU5Uz+VGXUO5fYN+vsbmrFj/y3oZWJfh3s6+mpCZbMheU2rqALdtzg5a9MW3TPB/B+X9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTA/iufXAKylaRhYcBEC1aIvtNagBG55+qS5GRlVDz8=;
 b=JtAbUNMpsl8pPEhjNn3W91ZU8kpljXlGZnEvZdynOPB0hdni67UvsfwTTnyOKaaZ2+jdPen4MLJ/Mbq9ZxJeww83+4iWtMzKIJ51wnTA6H1L8vAgVe298UH/0wQbW2quRpbBbmANYPRJ3qwR6Udho9EBoK9NV8VQEmOn3JRIzoB5aGmiM168i37CUFEliAQVfDNBecJf3IE58tLErJyXKuImpOX5cFLAw9uugQkpPEaaIesM9LFval7Sa+mN7yUxpKW06sIcT/wo3q2vKdD1SXqabDkElbsdZYr21EYLFt+46Yazr+1UG8whVoBAgAXbRrNyB5LMW7xqusuTMvcXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTA/iufXAKylaRhYcBEC1aIvtNagBG55+qS5GRlVDz8=;
 b=0AGu//C+ZGiPUBF12PNk2QovtzMgzdbpiedHwNBZf7tC5FbKaLK+jLpha8a4LD0uhsEyZ8bwDUX9wJDObHkmQIE4UjHyyUr/5jMYGwHgMg6+iw7G84qMW2FaK0pXm+m/KvDaZ03sB5jZGSJnUumN2ez6SpoLnUOF/22Oh0p4cjo=
Received: from SA9PR13CA0011.namprd13.prod.outlook.com (2603:10b6:806:21::16)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Fri, 6 Mar
 2026 15:36:26 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::f7) by SA9PR13CA0011.outlook.office365.com
 (2603:10b6:806:21::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 15:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:36:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 6 Mar
 2026 09:36:25 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Mar
 2026 09:36:25 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:36:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/discovery: support new discovery binary header
Date: Fri, 6 Mar 2026 10:36:12 -0500
Message-ID: <20260306153615.21854-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|IA1PR12MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9334d29b-ecbf-4927-5dc7-08de7b9620d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: MjqRAXw3xUTmi12G8MlS7dZ1pW7mXY4uCGYE8tWnCdBf14WxteARiH8yla0DLr1M37G4HE18cxvIoP6MBE3FWVZda9EKzTn2M14H3MGWJA/lyDhXzzjGc8bUY2TXdH9RFmg7WdHFhOu4dVOEYcz11rd8qg/uHGAaJfRQfuXLSHZQ12KngFZhYF28MW4hZfAO4C+4OFkO5fyDRkUbuFYeeHa/RoyMy5R4+qtjAJ/L3GRfDGfWzW6jgN7nSSAa3X/kqJXX1oADTLo7+GALPuZj2Rp4tslQ5GcUSqC9yJw1N/4+e0hwOEgujshj355wdU0P9+3n6azSPlORTE7QWeyDh2MD4oTXqmmv+OvrI8g7FfvIMLsNtB9yL89TtnDgLZa6GYuyo4zPAm7SnbCprOhdrfiEt2CU1S1nIDfuIEmuMQId3Jfc/a3Xzs0r0iTT7IyKqx3rR7OrW1qaQAtWUjkhH/T7xJSj9FU6wB9VjM2LchBd2HIsvqOcxKJCZ4SXBlSLsHXxEYKsXMvL0BpvhEzo5YDwKTxNEEAbxqHbtkt+AFTXMj6C8WuB0hPdFdB0J+5lGDhImwfi7iO/0lgzPxO2iej4+AXHnii6YjzzVUZX4mrk5sspr/kQAzqI64tvKGyur9IQ3o29vZzmqB4GKpPOAgwVEsZQLeYxKlY2cDGpSuEgGx+pGKqtW0SbVURcIEuZOxjjCl/KZHiTwDtkKpKQtlNkBDfNiBVogxWt518DA7qVbNJT3cdrxn91L8+kZqFdR/h2u3vr67RVArM46MisWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wYjm7oujPd39T9zr5GdkhRtjRJQtWby95BQ28zTe3hvWOphw0TaHch2iHFJeT2SMYGq1T+ktWKxuTpNSy4YL94tIhF4i1fEPdB67baxCG1jadauFaN4yHnTR3Gh6YAB2ODnAVmZvIN4PT7eKCWC/raIWy5Hr+8eECxvpnApXb1gTTW3J0nkaz0h2B1UvcNxTX4cZ9lshHH7zaaG00Kc46t9x8ukz0v/qId8SZk49wImDrV+DQ1YpapzAtdp7XgDcanqtfqrWHLXzpSuZ81GWthQzOPkB16FrR1kJ8cjYF4Kw9Z8YCQR8CeXTZLRB8WpQRmdUs20RaUsDMmhWGrdecrCXn6qoRcRfLqHCj+7c3iSmH/vEjQlkD9ApMHXToUezOuYM3yidQ3Ao99jX4OKU3xb8zcWWkl2Xi/hazLDD3vQAAnZt3McNY2lMJqmG5xSk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:36:25.8440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9334d29b-ecbf-4927-5dc7-08de7b9620d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465
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

Support for new IP discovery binary header version 2.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 128 +++++++++++++-----
 drivers/gpu/drm/amd/include/discovery.h       |  13 ++
 2 files changed, 104 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2f032a7d8e82b..cab5e643cf21b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -431,14 +431,12 @@ static void amdgpu_discovery_harvest_config_quirk(struct amdgpu_device *adev)
 }
 
 static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
-					   struct binary_header *bhdr)
+					   struct table_info *info)
 {
 	uint8_t *discovery_bin = adev->discovery.bin;
-	struct table_info *info;
 	uint16_t checksum;
 	uint16_t offset;
 
-	info = &bhdr->table_list[NPS_INFO];
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
 
@@ -491,6 +489,30 @@ static const char *amdgpu_discovery_get_fw_name(struct amdgpu_device *adev)
 	}
 }
 
+static int amdgpu_discovery_get_table_info(struct amdgpu_device *adev,
+					   struct table_info **info,
+					   uint16_t table_id)
+{
+	struct binary_header *bhdr =
+		(struct binary_header *)adev->discovery.bin;
+	struct binary_header_v2 *bhdrv2;
+
+	switch (bhdr->version_major) {
+	case 2:
+		bhdrv2 = (struct binary_header_v2 *)adev->discovery.bin;
+		*info = &bhdrv2->table_list[table_id];
+		break;
+	case 1:
+		*info = &bhdr->table_list[table_id];
+		break;
+	default:
+		dev_err(adev->dev, "Invalid ip discovery table version\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int amdgpu_discovery_init(struct amdgpu_device *adev)
 {
 	struct table_info *info;
@@ -547,7 +569,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		goto out;
 	}
 
-	info = &bhdr->table_list[IP_DISCOVERY];
+	r = amdgpu_discovery_get_table_info(adev, &info, IP_DISCOVERY);
+	if (r)
+		goto out;
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
 
@@ -569,7 +593,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		}
 	}
 
-	info = &bhdr->table_list[GC];
+	r = amdgpu_discovery_get_table_info(adev, &info, GC);
+	if (r)
+		goto out;
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
 
@@ -592,7 +618,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		}
 	}
 
-	info = &bhdr->table_list[HARVEST_INFO];
+	r = amdgpu_discovery_get_table_info(adev, &info, HARVEST_INFO);
+	if (r)
+		goto out;
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
 
@@ -615,7 +643,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		}
 	}
 
-	info = &bhdr->table_list[VCN_INFO];
+	r = amdgpu_discovery_get_table_info(adev, &info, VCN_INFO);
+	if (r)
+		goto out;
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
 
@@ -638,7 +668,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		}
 	}
 
-	info = &bhdr->table_list[MALL_INFO];
+	r = amdgpu_discovery_get_table_info(adev, &info, MALL_INFO);
+	if (r)
+		goto out;
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
 
@@ -770,14 +802,15 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 						     uint32_t *umc_harvest_count)
 {
 	uint8_t *discovery_bin = adev->discovery.bin;
-	struct binary_header *bhdr;
+	struct table_info *info;
 	struct harvest_table *harvest_info;
 	u16 offset;
 	int i;
 	uint32_t umc_harvest_config = 0;
 
-	bhdr = (struct binary_header *)discovery_bin;
-	offset = le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset);
+	if (amdgpu_discovery_get_table_info(adev, &info, HARVEST_INFO))
+		return;
+	offset = le16_to_cpu(info->offset);
 
 	if (!offset) {
 		dev_err(adev->dev, "invalid harvest table offset\n");
@@ -1225,7 +1258,7 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 {
 	struct ip_discovery_top *ip_top = adev->discovery.ip_top;
 	uint8_t *discovery_bin = adev->discovery.bin;
-	struct binary_header *bhdr;
+	struct table_info *info;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
 	struct kset *die_kset = &ip_top->die_kset;
@@ -1233,10 +1266,12 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 	size_t ip_offset;
 	int ii, res;
 
-	bhdr = (struct binary_header *)discovery_bin;
+	res = amdgpu_discovery_get_table_info(adev, &info, IP_DISCOVERY);
+	if (res)
+		return res;
 	ihdr = (struct ip_discovery_header
 			*)(discovery_bin +
-			   le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
+			   le16_to_cpu(info->offset));
 	num_dies = le16_to_cpu(ihdr->num_dies);
 
 	DRM_DEBUG("number of dies: %d\n", num_dies);
@@ -1385,7 +1420,7 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 {
 	uint8_t num_base_address, subrev, variant;
-	struct binary_header *bhdr;
+	struct table_info *info;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
 	uint8_t *discovery_bin;
@@ -1410,10 +1445,12 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	adev->sdma.sdma_mask = 0;
 	adev->vcn.inst_mask = 0;
 	adev->jpeg.inst_mask = 0;
-	bhdr = (struct binary_header *)discovery_bin;
+	r = amdgpu_discovery_get_table_info(adev, &info, IP_DISCOVERY);
+	if (r)
+		return r;
 	ihdr = (struct ip_discovery_header
 			*)(discovery_bin +
-			   le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
+			   le16_to_cpu(info->offset));
 	num_dies = le16_to_cpu(ihdr->num_dies);
 
 	DRM_DEBUG("number of dies: %d\n", num_dies);
@@ -1586,14 +1623,15 @@ static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
 	uint8_t *discovery_bin = adev->discovery.bin;
 	struct ip_discovery_header *ihdr;
-	struct binary_header *bhdr;
+	struct table_info *info;
 	int vcn_harvest_count = 0;
 	int umc_harvest_count = 0;
-	uint16_t offset, ihdr_ver;
+	uint16_t ihdr_ver;
 
-	bhdr = (struct binary_header *)discovery_bin;
-	offset = le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset);
-	ihdr = (struct ip_discovery_header *)(discovery_bin + offset);
+	if (amdgpu_discovery_get_table_info(adev, &info, IP_DISCOVERY))
+		return;
+	ihdr = (struct ip_discovery_header *)(discovery_bin +
+					      le16_to_cpu(info->offset));
 	ihdr_ver = le16_to_cpu(ihdr->version);
 	/*
 	 * Harvest table does not fit Navi1x and legacy GPUs,
@@ -1641,7 +1679,7 @@ union gc_info {
 static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 {
 	uint8_t *discovery_bin = adev->discovery.bin;
-	struct binary_header *bhdr;
+	struct table_info *info;
 	union gc_info *gc_info;
 	u16 offset;
 
@@ -1650,8 +1688,9 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	bhdr = (struct binary_header *)discovery_bin;
-	offset = le16_to_cpu(bhdr->table_list[GC].offset);
+	if (amdgpu_discovery_get_table_info(adev, &info, GC))
+		return -EINVAL;
+	offset = le16_to_cpu(info->offset);
 
 	if (!offset)
 		return 0;
@@ -1750,7 +1789,7 @@ union mall_info {
 static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 {
 	uint8_t *discovery_bin = adev->discovery.bin;
-	struct binary_header *bhdr;
+	struct table_info *info;
 	union mall_info *mall_info;
 	u32 u, mall_size_per_umc, m_s_present, half_use;
 	u64 mall_size;
@@ -1761,8 +1800,9 @@ static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	bhdr = (struct binary_header *)discovery_bin;
-	offset = le16_to_cpu(bhdr->table_list[MALL_INFO].offset);
+	if (amdgpu_discovery_get_table_info(adev, &info, MALL_INFO))
+		return -EINVAL;
+	offset = le16_to_cpu(info->offset);
 
 	if (!offset)
 		return 0;
@@ -1807,7 +1847,7 @@ union vcn_info {
 static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 {
 	uint8_t *discovery_bin = adev->discovery.bin;
-	struct binary_header *bhdr;
+	struct table_info *info;
 	union vcn_info *vcn_info;
 	u16 offset;
 	int v;
@@ -1827,8 +1867,9 @@ static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	bhdr = (struct binary_header *)discovery_bin;
-	offset = le16_to_cpu(bhdr->table_list[VCN_INFO].offset);
+	if (amdgpu_discovery_get_table_info(adev, &info, VCN_INFO))
+		return -EINVAL;
+	offset = le16_to_cpu(info->offset);
 
 	if (!offset)
 		return 0;
@@ -1865,14 +1906,26 @@ static int amdgpu_discovery_refresh_nps_info(struct amdgpu_device *adev,
 	uint64_t vram_size, pos, offset;
 	struct nps_info_header *nhdr;
 	struct binary_header bhdr;
+	struct binary_header_v2 bhdrv2;
 	uint16_t checksum;
 
 	vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
 	pos = vram_size - DISCOVERY_TMR_OFFSET;
 	amdgpu_device_vram_access(adev, pos, &bhdr, sizeof(bhdr), false);
 
-	offset = le16_to_cpu(bhdr.table_list[NPS_INFO].offset);
-	checksum = le16_to_cpu(bhdr.table_list[NPS_INFO].checksum);
+	switch (bhdr.version_major) {
+	case 2:
+		amdgpu_device_vram_access(adev, pos, &bhdrv2, sizeof(bhdrv2), false);
+		offset = le16_to_cpu(bhdrv2.table_list[NPS_INFO].offset);
+		checksum = le16_to_cpu(bhdrv2.table_list[NPS_INFO].checksum);
+		break;
+	case 1:
+		offset = le16_to_cpu(bhdr.table_list[NPS_INFO].offset);
+		checksum = le16_to_cpu(bhdr.table_list[NPS_INFO].checksum);
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	amdgpu_device_vram_access(adev, (pos + offset), nps_data,
 				  sizeof(*nps_data), false);
@@ -1895,7 +1948,7 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 {
 	uint8_t *discovery_bin = adev->discovery.bin;
 	struct amdgpu_gmc_memrange *mem_ranges;
-	struct binary_header *bhdr;
+	struct table_info *info;
 	union nps_info *nps_info;
 	union nps_info nps_data;
 	u16 offset;
@@ -1916,14 +1969,15 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 			return -EINVAL;
 		}
 
-		bhdr = (struct binary_header *)discovery_bin;
-		offset = le16_to_cpu(bhdr->table_list[NPS_INFO].offset);
+		if (amdgpu_discovery_get_table_info(adev, &info, NPS_INFO))
+			return -EINVAL;
+		offset = le16_to_cpu(info->offset);
 
 		if (!offset)
 			return -ENOENT;
 
 		/* If verification fails, return as if NPS table doesn't exist */
-		if (amdgpu_discovery_verify_npsinfo(adev, bhdr))
+		if (amdgpu_discovery_verify_npsinfo(adev, info))
 			return -ENOENT;
 
 		nps_info = (union nps_info *)(discovery_bin + offset);
diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index 710e328fad48f..76c9f951bc1c8 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -64,6 +64,19 @@ typedef struct binary_header
 	table_info table_list[TOTAL_TABLES];
 } binary_header;
 
+typedef struct binary_header_v2
+{
+	/* psp structure should go at the top of this structure */
+	uint32_t binary_signature; /* 0x7, 0x14, 0x21, 0x28 */
+	uint16_t version_major;     /* 0x02 */
+	uint16_t version_minor;
+	uint16_t binary_checksum;  /* Byte sum of the binary after this field */
+	uint16_t binary_size;      /* Binary Size*/
+	uint16_t num_tables;
+	uint16_t padding;
+	table_info table_list[] __counted_by(num_tables);
+} binary_header_v2;
+
 typedef struct die_info
 {
 	uint16_t die_id;
-- 
2.53.0

