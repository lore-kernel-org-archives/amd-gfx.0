Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35DFCEBF77
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 04:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A00310EC0D;
	Fri, 27 Sep 2024 04:58:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C6MPiICM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 121BD10EC0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 04:58:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYYrDdZtEpt2y1vCas+e02H2nWW2XfVER5IFTVpLpcWK9SNJi+jhQcsBFvuSvjZGNsrvn9GbgDxlmZb28+IE3tuAxuywYFe/Gm6ckghKT6wswihV/7lEbdWD3tfn5FKLjTQahHuFj18jqeVrcurKyc8kXl5Z2nGI/d/yYKsKXxnVX3o9Tnp/Fkg2mPtbOieK7Tq6YUk0H1vT0MsMm1YtC3nSCHWbcAsdMqXsCSQOQ4yT/L3c9bFFbj6BAUq7x31jbV0QPJAaIQWs32lw2+ZVRll6VH1SVD8Jg46LuCRRMizWrv351nopIfAezrkEwZOYUkyBRN6/8gaXnk/N9QDOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+oe8iK3k0npy6E0uOI6Cq5qiBphKTAsKj+zUGOYe30=;
 b=o2sz+qXp4WQapdMhBLEm1wIsedkCURBL2b+bnCesyOEWBZGahsGuZb/cgAnMJlvBtHoVlByWlh76psJV+S4mCnbADWauWXJ3Up15sXeixClNv3/LtQii2C7Y22/NuTBzi5s+zrzMKJqCkK4oBdp/53fLjRQ83SvBo875sztWD0IOt0ma3KbJrQbJlWEtKRs+eKs1O53l9+I7crlOWCYhhbEgul1X+++B1+R0JAZOIwhdMiFdHI6zR48ryK9jdz/NlfBmIxcaCZAlp6+BxiSOOFwrKADp/iwh7aSBGw4Qbn/0M2Z5UbidesFI7a9Z4SLCRxURZyYhhi40xqNcD6Nsnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+oe8iK3k0npy6E0uOI6Cq5qiBphKTAsKj+zUGOYe30=;
 b=C6MPiICMrur2WtrEIH1HbaCCcu1TxBzQz/TWt8hGzwY85t/V0KqjdXdI8RoVMTJ8B0r88GUAur84K02a0wnwnV15OQpt3CETYF8n2Z/aA0kMnkGi5kmsJse/oAbPIPG8Rr90SdW6CJUAhUNT+Fg4gia2wd/IDmy0t8s6DAXQTx8=
Received: from BYAPR08CA0060.namprd08.prod.outlook.com (2603:10b6:a03:117::37)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Fri, 27 Sep
 2024 04:58:07 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::8f) by BYAPR08CA0060.outlook.office365.com
 (2603:10b6:a03:117::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Fri, 27 Sep 2024 04:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 04:58:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 23:58:03 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Ramesh.Errabolu@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH v2 1/7] drm/amdgpu: Add option to refresh NPS data
Date: Fri, 27 Sep 2024 10:27:37 +0530
Message-ID: <20240927045743.2718949-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240927045743.2718949-1-lijo.lazar@amd.com>
References: <20240927045743.2718949-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 030cacae-3ced-492e-dbba-08dcdeb0fa51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jX052cJ64l+tW51N1xth4zC6/lUYT4ztpeRN+w9vC0VhQ+7IQT308VH0eGuD?=
 =?us-ascii?Q?Bi1v8EUdwaAV7H0r20tLXukrmKPXHlNFclZIf0wBSOaNTZmNNb2wlO5I3/9i?=
 =?us-ascii?Q?70klXVruGR2NsSW5/Jj/MLAFZNwzZllQvKrn3TZaqM9gDb33CR9j1E6aM1HX?=
 =?us-ascii?Q?785zrIWZ9Q7r5cBUe0UVN+wRNGuj9NhboVDJiQyjZ5gJPy2FOYISIKfOcQrg?=
 =?us-ascii?Q?yYYDu/Y2I6Yc892IEtcgjIYm0LuLfHOJGSIwNMx+4cZqsI3KW0jwryIFuQ4c?=
 =?us-ascii?Q?qQKYa4Pchvtnn3rar6RnsaXIOFhuhEwoUYxmtaMg/rMbtn1HJGhOrYR1h4RN?=
 =?us-ascii?Q?uXGUVyYZl8i/z+pburNPvJfKKxRwA90GkMHH3s1jkuFOxd9nr4P50rUj5BUX?=
 =?us-ascii?Q?cIXDBBEcOPYhz+Ku1W5pNUJDkwdSia5iF6MNX6J3qxq+QxZ+BD1Tcl+B+8JP?=
 =?us-ascii?Q?stepPpBV989fn51Y/RjyNHB5+QQj+5ZC/hc599MHHChQPggbDwok12QaoB0K?=
 =?us-ascii?Q?4TpGTR/NVPijaEXdOmAsgVCff8WKZ8j5GfSstsDeYbF8RZwoVBmYZDp9qNnz?=
 =?us-ascii?Q?ngOMC7fRZMKwhqWMB65eQWhaF2vxTPUpY+KXnhX1k+vzF50kIUWz8lvUG5k9?=
 =?us-ascii?Q?TS1lXyHGArV0UjhKAb7tTjuVRW4pe9iyHIRBQ7sjSk1S87hLgASX7dmZdzpQ?=
 =?us-ascii?Q?1KhD88U+81W7CY9QhzytDncWm2Mpxw2ddXA8sPwhfDdSZYWD4kEXLbW95sM2?=
 =?us-ascii?Q?wzSJlHN05GkiwTx2rJ5hc+K74lyzmTfDY8HlKjW7qCqNKG4VxwSe55ftkPXe?=
 =?us-ascii?Q?VB+doe/VtbuCoazzFKWDb05G14DRnEuiOtwBBnXP2ehyBRX1leaS+FnADgZt?=
 =?us-ascii?Q?tXhIJw0c5GcWsCySgjYslsqE7cpOozDk8Sgd7KIIrpozoIg09yL1iATL+0st?=
 =?us-ascii?Q?DrZsm5/RGI3x0NeZ48cnmu5bkx1ZSyX+/rElwy6Zkwd5qyo9NVhL0Lw79SfV?=
 =?us-ascii?Q?5aX+zITRlx1VcMxuCqi9/5XEa0evlv286wDSm65XUVgfj8XIHq3bT5SQ0xWt?=
 =?us-ascii?Q?8hEurNx9xqWpwIpmfr7E8R4QCpVn75wASrSqSYbhNTjLmQ17WiTrFgpAbAhx?=
 =?us-ascii?Q?XUE4IFPN12zUM1eApF3Rg0AnNCJHbvSBdIuNpY+nI62ymzP3LJJHJ13F8D+4?=
 =?us-ascii?Q?H0u9RdxDRoh+KgauAtUkXkoXZNtj6jciYKXvWHwXYpeiJ8q77sLvQmV8ImKa?=
 =?us-ascii?Q?+NjqVQX/2J6ih6ypkOLKR7hgMKsXuPv/Dw0DSOwydHBPgUS+5+1lK9SbIFbV?=
 =?us-ascii?Q?wtAhxvkLjvzeqBk9ze2OrDcDjIQl1ruXrKkZcbgMeV9vyuheQdv4nZoUaahz?=
 =?us-ascii?Q?gbeopKI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 04:58:07.3640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 030cacae-3ced-492e-dbba-08dcdeb0fa51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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

