Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7015ECEBF76
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 04:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 208EB10EC0A;
	Fri, 27 Sep 2024 04:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B285CBG1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F260F10EC09
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 04:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPu7V1nAl01/9e2oY+BXRF/9st4/VMPtV3+kYRvVp4RQN/vV+Jehw5avOudl+1Qsv31LqiUMz1G3G/e0Z9jwSjXDB3o3nS34oOmsgwPKSglsZPRcydAh6q1dTtzFN9y+pgK4SHl81DtV19brb82EWX9JePia7KFncddU43fwy8Iqkvjk3q8wuTqjfwvBKmC7QSKcnyP3cClcKZIinoUVs6VqwtSVZ8LhtEtMpINjNeQt4JbJYDB6DWckU9MAGBF7/Dh6erBt+E4YIEES9H42tWi4selT3pD9AX+tXVtMGLUK5BXxxueNsHFDFligXui6pszXr4U4Z7YRpG7PtnhpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+oe8iK3k0npy6E0uOI6Cq5qiBphKTAsKj+zUGOYe30=;
 b=fu0RalQZ84t61ulvAPhmsAHJu6E+ZaqiHf8UkZpdq8Z8CaI/NLOVzWbGfxFGY9ss4LU5ogvmCx06K99NLJqDhbrzQv6/4Z9o58YTaeh1pacX4HtCtdpTRZWvfExwtXLFlryljZzlv8IL8uI+i8edOi6OHB6s8lCVyip8Kbk+PSw8zj0EKk352LoWsO5HdphEdtrVlmyU71Cu0DM9rckJAwVpEIlVXY1geEThf0VdGHNfZxy6XVdDR0/cZHJ3kuX6qPEdwpjK8qLY3WjBdkAE5EFWC+QGLeNDS3mVx8CAO5Y6/DoM7VEialijUybSEEn21Vs4ZbQdraG8Cfav0DqPkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+oe8iK3k0npy6E0uOI6Cq5qiBphKTAsKj+zUGOYe30=;
 b=B285CBG1rHjqbbAytbpx6QUxVFv4+fpsN6SH/iO7Xu/FB2OeuGJQXllz9BBaDh+KcXPT1OOjxJNRqyTeuadjQQN+2adF/KC6tDGLoqLTUjqIuxR0TBXu/bs/cy1+ZgvK7sUEn9rzXgBAqX5myvx2qLnfDHE73Jb7ffgN5fF60d4=
Received: from CH0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:b0::16)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 04:53:27 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::fb) by CH0PR03CA0011.outlook.office365.com
 (2603:10b6:610:b0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21 via Frontend
 Transport; Fri, 27 Sep 2024 04:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 04:53:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 23:53:24 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Vignesh.Chander@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v2 1/7] drm/amdgpu: Add option to refresh NPS data
Date: Fri, 27 Sep 2024 10:22:59 +0530
Message-ID: <20240927045305.2718867-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240927045305.2718867-1-lijo.lazar@amd.com>
References: <20240927045305.2718867-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2f0bc8-b143-429b-1368-08dcdeb0534c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tnO/OKJ0Ulozhv0fVQP+sDKmyLNWUAf0KMmoVxdqYeQvc64kbj2FB6FsVn5X?=
 =?us-ascii?Q?uSAqz5Z9RVopUTyZDfPMc3IjRSoYwoUcNWp4aGeNTpO7ByyWojz/57VG0uoV?=
 =?us-ascii?Q?ZTN9dmNEQch4mFlzRHZqywYaPkvVtnPpztQHEw9Fg2pZEjZ1EXhDg9ccsd4R?=
 =?us-ascii?Q?3d75hzo9Jj+CJYXqNpwj7y5yb0iacwaQ5Rl0WiByPPVqNTQX971R5tPRAk3E?=
 =?us-ascii?Q?zrwE9L+IaAy4XjEM82KgonTV9RnhvfGGCre26tmHUHdPXvzMdfx1Fg3OZUyA?=
 =?us-ascii?Q?jpAjCsaTBODo1xg1rKVhGMjxU42Edv8n5SHuySDTIsLctEv6tNstWco+FeZI?=
 =?us-ascii?Q?upTEm4oH0iVfJXEUbXUcR2hq3N/9PbGKmR9m1+8rruURCVokgGJMAjfD6S12?=
 =?us-ascii?Q?xEvA11c50S6sANGzldbUEEkzEvktDA0my3AIj9kvsU9d8UlJcnNICQQa++sv?=
 =?us-ascii?Q?JUWnQRU7OLHm8WbZddqvarSR+CoV1bnYiECMHWXSHI8WOuVTB9AgDFr4UMBj?=
 =?us-ascii?Q?dCJrgIdVF23HUHKj2AeTVYARvMIrIj3ebIhUJ7iQQA712tToC8pMvukrbioD?=
 =?us-ascii?Q?LcDgAi2AfCvhWyL/PrKPoKWb9UWAyLAgCCacIT1piKVfB8Mj3QiJAqgop9Yt?=
 =?us-ascii?Q?r8kwxj/NREfI9AX4yPer3dQte1slf/VT0qHx+SjA9A0t+MYXFdWwBxDxJUXZ?=
 =?us-ascii?Q?Y72CvALAtWFv/vRqUKQIgu6+O/b/MLjhdlaLMINRNNs8NJk9WOEm4Zq/CifA?=
 =?us-ascii?Q?euRPktbygPWI+cJuK3OT1i2BqchRkVRaGVvi2izFEvB2MLxxw8Eb989XCoME?=
 =?us-ascii?Q?LIqKOH58POI4mep6LBmjNrWPUnj6VMqVH4J+rq99LidcRHyOUrnYZ5oiNiLJ?=
 =?us-ascii?Q?IHB1DDEb/bTiyKqxNjGHoKODiD/9qa3kGZ2qj267XyYO20ilYhZXupNoPBDC?=
 =?us-ascii?Q?7+/7AR1m1exOz2hHqgOHYjUBsyTDFh+JB/3PKabI2yiZQJbei6GBsbU6S+NQ?=
 =?us-ascii?Q?nFo/F2D1sbsw9JiHzhdTfgKPSplnJ7sT70raRpa1VTeecjRH9IQz3wNqUKXP?=
 =?us-ascii?Q?fAIyfW47v2RBuoQmk5DpYIcGa5Ln4zvWGjfNyB1wfxiER24ArX7HeByPaOyz?=
 =?us-ascii?Q?SFWXegeup1DbCkpUM7mikbtMvm2u9pyOhYzarBg5XD87jDv19OWJ+hD4PqMn?=
 =?us-ascii?Q?dDBPvcRZHYsGCD1J9MVUpeQU9aZPqsK8OIe2r9Vqr66qklLNvb6zJIUCzef7?=
 =?us-ascii?Q?ljwvdXRxI+2X9c79hypL3X7lCnGDx02CGsJP080Dc8jZEOvQqvMapPi2Inq3?=
 =?us-ascii?Q?y9CPy+6wjUtPiAtE7N9Lh3ToaevbezLmkYa1l8sVt6OoBpakIkg9q0GOBvuf?=
 =?us-ascii?Q?ouwzD61npFucH8I3RVACkv44VZEaHSJjgPlcBbTXqYAaFnv0PfzLsYTNDUVF?=
 =?us-ascii?Q?CLJQ25NdzmtydC+QSyrQZOBcTOzvehIF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 04:53:27.1935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2f0bc8-b143-429b-1368-08dcdeb0534c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
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
Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
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

