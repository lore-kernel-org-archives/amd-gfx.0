Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491D4CF9C71
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 05:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB82710E1B4;
	Tue, 24 Sep 2024 05:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="srhIqrRX";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB9FC10E1B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 05:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHQQ9MHLu6PP22gBTYoa2jhdEbUA1T596rVWvrncUSnRVt6EZCGvxZG55B0ZN9i6JVLbbII5cCypnfvfWiEgCwzmdW8YC1j+6kO/YOpX/oMnuHu8AGu+Jtqvp2ald8lRd97zOpNufSanBTmLX1c+LvyWJSPF9Zk+h3YlThVb38xJL0JUVUxDEB7paWnBb7CkeqZ+fal1IkiQQ5pA93ZG3DZ2WabSY3Yg0NcvOej154odUMicx2L2wPotvcONI2ihldV3ZPeb+0N7HkVonkw84PaCDtA43OTG+MKfIaSuSM1J+H26typV57C7H1GJUBES4VgshKsXLChwK2O+4b9xag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ob2q23P5eGDctV5s5vCl/XewAtr3Qaq3t0hZ5ljfc4g=;
 b=a7U30y0M0aMmjg13beluDhduyddqQ8lMANCy+DkzqsF2HxPuTsdKJ/BUsIAbtL5crNtS9rjbEsQ1PXRF2RTm2Fx7tXRAe7z5XwTwDZhvPBrqOSH5rok3kDeX7EXfolaQYxPJzXk3QxjVXyyTgr/BOxQV7GOhN4/YzZk9KJmI3dlV4/dG+JCKqUtBfUcAa8BmedZx/GsB1JW4dVHWc/crCjPq4+pLCaV5Cs/CGMF3/U51jFNCV45qM2XkOQyf5dKrJtVkAPZXniI2pT1x3tB5eBQfMUVanhWtYXPGF5ucM6n6EQWNJ5sKPyfLc6jv8RgO9sMAW27uTYv72AaCU4jE1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob2q23P5eGDctV5s5vCl/XewAtr3Qaq3t0hZ5ljfc4g=;
 b=srhIqrRXTz3nHTPYenYFlRTfm8f9xMDov4A6eZjDuNVDLOB0qv+Y+wz5fQj+pwTr+89Dso4jvAg1oBya9plJH79cRRH/V3rKahxYIcLpww/Lo7HLwumQV6k9erDO3++vh0YT8vcsTFHSY/Uc+oJxUr4r39d7rNaHinDIldcB2bQ=
Received: from CH2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:610:5a::29)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 05:57:16 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::d2) by CH2PR08CA0019.outlook.office365.com
 (2603:10b6:610:5a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25 via Frontend
 Transport; Tue, 24 Sep 2024 05:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 24 Sep 2024 05:57:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 00:57:13 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <rajneesh.bhardwaj@amd.com>,
 <Ramesh.Errabolu@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: Add option to refresh NPS data
Date: Tue, 24 Sep 2024 11:26:46 +0530
Message-ID: <20240924055652.2678433-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924055652.2678433-1-lijo.lazar@amd.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 185ad98e-f4fd-4bd3-e8f1-08dcdc5dbe2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IzUlFq4IxcIAEJfhnQyyhGjyak+bC9dFp7Y8a2WEn0dsmovmwPCS4RO60JC2?=
 =?us-ascii?Q?xlaafOfpx5Wm3rXmlJtlDGir1c+gMUWIrgh0sfwnPtWU8bA9aIp36THyNmSd?=
 =?us-ascii?Q?ly0qXVgOhVl5aLLbKHltjLxTCe2olWvw7/9lYWwasGMYr8Xc/9i398wqtB6U?=
 =?us-ascii?Q?l8G8T/eSsnxgU/rT3Tvjketz/3kBzjNe2y2Gf87MB7VSBIQm5ngJrSACxJTL?=
 =?us-ascii?Q?880M9w1RM9MjdwRClUjkzNRSTmPyEszYWLSSysBtCF0xDm3ki4HN4ZicuxoS?=
 =?us-ascii?Q?dPaIJfZUE0eOrdVv6akq5Zb5pL8pC5cXhxVBAY5MFWM0DznkdQ1LGyWulpfe?=
 =?us-ascii?Q?sri8ve/qf5WorwTk8+BXKKmWK7tsomyJo6jH8TBJtUYIYUwK3Ttte+XzvVC7?=
 =?us-ascii?Q?J/lm0OUzbB7BHY5WVNEue3b8Bxwbox1FIzHIGpE2f3ZmfuDW/8T1cRS1hrIA?=
 =?us-ascii?Q?hinW6EO+KQRLsA0wM6lHurAUMVcebn1evhJNiTqOJYjPf7KjKL58qP3Jhkp8?=
 =?us-ascii?Q?aKR8nNv+qCoPFf2N0spWjiB2VgrpaFrP1+0ZmlNMDAr4M0SnkbILJzbiY+LM?=
 =?us-ascii?Q?iwk/xdcvAxEo8crjesbNzijAPkXD2TnrM0doCPdMp4M5o2GHaLBkvVJixwy0?=
 =?us-ascii?Q?+nmZIl6xLvxWcCZGD1lWK/pE676c0KIig+DI4a/+0EjoW+hlCuUXImPZk0EC?=
 =?us-ascii?Q?0bnMy5DHCPe2QK8qEJpyou2/7XG1mznht3MRFHctGfC9oSRg0DqxqBlg+IcB?=
 =?us-ascii?Q?maeM61M+GAjOWqbBGKubMFP1r2oCBoAmroFcRndMKg1085ZlFWqM0Jc3DTqV?=
 =?us-ascii?Q?qV0lM9xQVSelZv/+4q4Ys2jW+9CgMMLbqskC1VmZjvZ82CTGf7gnPr6RcXxh?=
 =?us-ascii?Q?ftusUVK5O3X75Ct82H5r+yZX6S0AIXla0HOBujrYX4btqcmozKC+QtNioU3Z?=
 =?us-ascii?Q?UMylIkiityyThRq3JSASTHqTpTZBOB6dMbQeciX0b3r0imlrxyHL0sd4tn6b?=
 =?us-ascii?Q?vEDzJdD3cZ2TXKKpLNecdcxL6MGiXqi5PF5QVAC9Xoh6h3AHRPk4LiRB5tui?=
 =?us-ascii?Q?FLVNl786DMP9M7labo+qguUg959LELS2UwHr2tE9BRD00jHuved4YlS8C8ht?=
 =?us-ascii?Q?CBrpvLHPNMERP8PdQk7Z8hSsBvMl3fIVqx/4XC+yjfjCF+YbdSbRed4t708Z?=
 =?us-ascii?Q?sPms2lghzTfGWExXZJPYfpip4310e/GziQXOH+o2CUdyTM0duFipZsRUv4io?=
 =?us-ascii?Q?DnnlD+KYSuQXsAS8EwZoUqkqBDAJe9APTt5MVfaw2ffOYS/1jwnrfZL7ouFQ?=
 =?us-ascii?Q?kVpm3RJfOnDKdVghiQD8BKl2kddec81UqbJ4DZ3HQUMvxPJ18m0xad9V6+BR?=
 =?us-ascii?Q?og25LF8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 05:57:15.9357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 185ad98e-f4fd-4bd3-e8f1-08dcdc5dbe2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
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

In certain use cases, NPS data needs to be refreshed again from
discovery table. Add API parameter to refresh NPS data from discovery
table.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 68 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  2 +-
 3 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4bd61c169ca8..9f9a1867da72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1723,37 +1723,75 @@ union nps_info {
 	struct nps_info_v1_0 v1;
 };
 
+static int amdgpu_discovery_refresh_nps_info(struct amdgpu_device *adev,
+					     union nps_info *nps_data)
+{
+	uint64_t vram_size, pos, offset;
+	struct nps_info_header *nhdr;
+	struct binary_header bhdr;
+	uint16_t checksum;
+
+	vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
+	pos = vram_size - DISCOVERY_TMR_OFFSET;
+	amdgpu_device_vram_access(adev, pos, &bhdr, sizeof(bhdr), false);
+
+	offset = le16_to_cpu(bhdr.table_list[NPS_INFO].offset);
+	checksum = le16_to_cpu(bhdr.table_list[NPS_INFO].checksum);
+
+	amdgpu_device_vram_access(adev, (pos + offset), nps_data,
+				  sizeof(*nps_data), false);
+
+	nhdr = (struct nps_info_header *)(nps_data);
+	if (!amdgpu_discovery_verify_checksum((uint8_t *)nps_data,
+					      le32_to_cpu(nhdr->size_bytes),
+					      checksum)) {
+		dev_err(adev->dev, "nps data refresh, checksum mismatch\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 				  uint32_t *nps_type,
 				  struct amdgpu_gmc_memrange **ranges,
-				  int *range_cnt)
+				  int *range_cnt, bool refresh)
 {
 	struct amdgpu_gmc_memrange *mem_ranges;
 	struct binary_header *bhdr;
 	union nps_info *nps_info;
+	union nps_info nps_data;
 	u16 offset;
-	int i;
+	int i, r;
 
 	if (!nps_type || !range_cnt || !ranges)
 		return -EINVAL;
 
-	if (!adev->mman.discovery_bin) {
-		dev_err(adev->dev,
-			"fetch mem range failed, ip discovery uninitialized\n");
-		return -EINVAL;
-	}
+	if (refresh) {
+		r = amdgpu_discovery_refresh_nps_info(adev, &nps_data);
+		if (r)
+			return r;
+		nps_info = &nps_data;
+	} else {
+		if (!adev->mman.discovery_bin) {
+			dev_err(adev->dev,
+				"fetch mem range failed, ip discovery uninitialized\n");
+			return -EINVAL;
+		}
 
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
-	offset = le16_to_cpu(bhdr->table_list[NPS_INFO].offset);
+		bhdr = (struct binary_header *)adev->mman.discovery_bin;
+		offset = le16_to_cpu(bhdr->table_list[NPS_INFO].offset);
 
-	if (!offset)
-		return -ENOENT;
+		if (!offset)
+			return -ENOENT;
 
-	/* If verification fails, return as if NPS table doesn't exist */
-	if (amdgpu_discovery_verify_npsinfo(adev, bhdr))
-		return -ENOENT;
+		/* If verification fails, return as if NPS table doesn't exist */
+		if (amdgpu_discovery_verify_npsinfo(adev, bhdr))
+			return -ENOENT;
 
-	nps_info = (union nps_info *)(adev->mman.discovery_bin + offset);
+		nps_info =
+			(union nps_info *)(adev->mman.discovery_bin + offset);
+	}
 
 	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
 	case 1:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index f5d36525ec3e..b44d56465c5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -33,6 +33,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
 int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 				  uint32_t *nps_type,
 				  struct amdgpu_gmc_memrange **ranges,
-				  int *range_cnt);
+				  int *range_cnt, bool refresh);
 
 #endif /* __AMDGPU_DISCOVERY__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 17a19d49d30a..4f088a5368d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1184,7 +1184,7 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
-					    &range_cnt);
+					    &range_cnt, false);
 
 	if (ret)
 		return ret;
-- 
2.25.1

