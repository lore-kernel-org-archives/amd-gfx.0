Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4B8FCC9B1
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 06:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEDEF10E0F0;
	Wed, 11 Mar 2026 06:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KnIH1sBh";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254B910E0F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 06:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHxOCTJfWvZ9l8qkxHAdZAHZsrG87l4TQgR2d/WYszyJH2bGg0GbRzapzojAybQWfmUiK7TfCwK/piFJEBao+QC51mimLIZ3D7hjffqLyRqzIMCHEJm75uETK+kStcgSJAKZ0IN2lLh6Zed/42WWsf3MHLt5uKuieLpJhA1Sp9OdSCTqDJZWidkvki9d154S30k/Q4C2CYro6E7hqNhyr76XW6X9F7JzJoiaMb6l5yaXqoq6hKSjlq69jPLJFTLp5wzWev8yBTvLxO/C4fg/TQHnrDcAkME7jQhCDV236bmpL6egCpenFu1XBPp/bU89p8Jl6b7Jtb3GuTBK5L5p9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EPEAT0aV3OR+njCFPhcAxSDk2S5z2OBOj3FeRsgRqg=;
 b=FnWlSmPB8q7Ib7XOQpGS6Lxz1U27oD5EtmQ+FqGOZp9TJwvbpQenAxHefEowecaOqVT8+ymtXRgyVVAYJI0O2ojRQXtYQsIXtVXGYjUitjpREY8Dq9s3mLFF7Rrx0wY4B3WfdxKA1HyeykiHkgXkUJckPQX4pqYbxX1aljaqGL36u6/eGhA85aD4+K8oZ54463hCbz9gsaClJrYYsExIghPuEewvV/F7EQcUxoNypDnMFZYiO7hynefvyFLphrOIC2EIXqvPOxK/4zKQWj9Q/UXHiZrYuwE9fkI3Mww3PcNDwD5mYpcyjCTo+7UtZI6RuPQHSlhWdXJce2f8CoKPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EPEAT0aV3OR+njCFPhcAxSDk2S5z2OBOj3FeRsgRqg=;
 b=KnIH1sBhktN3PNy7pwEVg9PeGx7IO3AV66NBTYSclyxDWoW7CHCEM0gXqhYL3lz+4bEK+rUAmvdhpvrMPt05QnA3mSkodPQDDAebx1mVCMRXlgtbkZwDcG7V525c1fo3pzAksNR+XXZZ/NaA7yl/hH6eY0OJxo3xvSF3aL0SuZQ=
Received: from BN9PR03CA0448.namprd03.prod.outlook.com (2603:10b6:408:113::33)
 by DS5PPF4ACC15C0E.namprd12.prod.outlook.com (2603:10b6:f:fc00::64c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:05:38 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:113:cafe::24) by BN9PR03CA0448.outlook.office365.com
 (2603:10b6:408:113::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 06:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 06:05:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 01:05:35 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Use stack variable to fetch nps info
Date: Wed, 11 Mar 2026 11:35:17 +0530
Message-ID: <20260311060517.4010519-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DS5PPF4ACC15C0E:EE_
X-MS-Office365-Filtering-Correlation-Id: da9340f8-c6be-4dce-cab3-08de7f343757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ft2t0b6ZrIdfFNoxOK2APFFNO07GgW1sEg6/UvunXIwsOT1emQVZ0H/FD0Q77j6MWQ/ryrkVqv0OhOBTc+ON99iWA6vH+pWrNgNBHbJXuENgFofSO9SupU1Z34whengYBBG2XqokGQ/qdJETLhqJHG1B1nNByiotBIuSMYzmC3SrlkMpaFRa2wQY221BN88wZwvre4JtXM1tVX1t3452E/SUvaG7J6hMz2dlmareoU1k705qMkbAkvbzAk9JHolZSZ8PhJNwbqKmUBOSk4ARdxrWcj+bdN5XUrN7R4an0Zv4fV5N6SvoNxXBTPsCiQ/qu8Or7WXW4Xu25xX/WZZK6vrAdRcmZkMVpBP4DZSl8ut/asr1FMr7Z+/HI0/rLAr1mGJBuWmhgTh3RENK/QhhR095AZFNZLCSftNjCJSkzusLvgXQ1FRvse8R53sO0c8HRO14Ek3uCpmsouPRdILCy3OCk5yUvWtbdZ2k80fScncgr5pRdLyKHP4qs6qI8hQPczpJrbqsrVImqfDwGfEksITVzA7wcH9iyXhXSvrDlk2Oe9CjKbez/5UEJHH0MfIDBtk8DNgjwislIt2TEF9CBerSyuqEdW2qnOc/KyQ3chmCQWjh/kmb1JWPVLG4my6ke6aycxV4gw3qA6/pNWitgznzzhR9cxmc1xoS6KQucm4nrgQj6ztY5VXwN/T2xsZKVs7vxRNRzFoycR2Awcu9/XzvhbeEMHaIKzRmg3yVCWUhq03U51UQK7seTVh+tCwgPMFhS3tE9RRf9OEw0u4Abg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: khdaPK86yybxKq5ZqCGvrAG93YVS+YTz1DbtSernqN1p6oUk6ebfk4/EB+TBmgvBqBL9G0SMl2T+3JMiNKsfawbo8cl0Dk4vZCDYppq72QlSXMgInIPQoEfnOFFO4ENFasaxnGauU1mgcEBqX0oIMm1YEPRLAiPDL3f9zyum3HJ/sB1oHsJs6VeATfPQlFw+uIKzAzDafyRb87x9FwIfv7TjPNkFoySYUzB1ak7n7mkk3e3LuJUeoLQbdjKG2ry6ecOlfmRX7icyB+yqggnWscWEExQ9RjH4ZW122x/Qnnrq5yt3kDpuPFVnjl9FUbaMPYuCEHnrBCcNaLLL6lYTIO+E27GFZEtf1wiQUWKykhJnztLZcPmQt8BO/k7xxfWIVcFSMrV4btKeZ9YRBL5nXOCcy8Duqut9dDWBhPoPXigVYj3GmaAbf+HRu/BNw2Uv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:05:37.6322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da9340f8-c6be-4dce-cab3-08de7f343757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4ACC15C0E
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

Instead of a dynamic allocation, use stack variable and let the caller
pass the maximum ranges that can be held in the buffer.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 23 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 10 ++++----
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index fad53d8344b1..948c5f40f366 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1932,11 +1932,10 @@ static int amdgpu_discovery_refresh_nps_info(struct amdgpu_device *adev,
 
 int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 				  uint32_t *nps_type,
-				  struct amdgpu_gmc_memrange **ranges,
+				  struct amdgpu_gmc_memrange *ranges,
 				  int *range_cnt, bool refresh)
 {
 	uint8_t *discovery_bin = adev->discovery.bin;
-	struct amdgpu_gmc_memrange *mem_ranges;
 	struct binary_header *bhdr;
 	union nps_info *nps_info;
 	union nps_info nps_data;
@@ -1973,22 +1972,22 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 
 	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
 	case 1:
-		mem_ranges = kvcalloc(nps_info->v1.count,
-				      sizeof(*mem_ranges),
-				      GFP_KERNEL);
-		if (!mem_ranges)
-			return -ENOMEM;
 		*nps_type = nps_info->v1.nps_type;
+		if (*range_cnt < nps_info->v1.count) {
+			dev_dbg(adev->dev,
+				"not enough space for nps ranges: %d < %d\n",
+				*range_cnt, nps_info->v1.count);
+			return -ENOSPC;
+		}
 		*range_cnt = nps_info->v1.count;
 		for (i = 0; i < *range_cnt; i++) {
-			mem_ranges[i].base_address =
+			ranges[i].base_address =
 				nps_info->v1.instance_info[i].base_address;
-			mem_ranges[i].limit_address =
+			ranges[i].limit_address =
 				nps_info->v1.instance_info[i].limit_address;
-			mem_ranges[i].nid_mask = -1;
-			mem_ranges[i].flags = 0;
+			ranges[i].nid_mask = -1;
+			ranges[i].flags = 0;
 		}
-		*ranges = mem_ranges;
 		break;
 	default:
 		dev_err(adev->dev, "Unhandled NPS info table %d.%d\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index c8242992c912..1220c0327275 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -45,7 +45,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
 
 int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 				  uint32_t *nps_type,
-				  struct amdgpu_gmc_memrange **ranges,
+				  struct amdgpu_gmc_memrange *ranges,
 				  int *range_cnt, bool refresh);
 
 void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer *p);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 20e1395b3988..f165d4e401e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1374,18 +1374,18 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 				 struct amdgpu_mem_partition_info *mem_ranges,
 				 uint8_t *exp_ranges)
 {
-	struct amdgpu_gmc_memrange *ranges;
+	struct amdgpu_gmc_memrange ranges[AMDGPU_MAX_MEM_RANGES];
 	int range_cnt, ret, i, j;
 	uint32_t nps_type;
 	bool refresh;
 
 	if (!mem_ranges || !exp_ranges)
 		return -EINVAL;
-
+	range_cnt = AMDGPU_MAX_MEM_RANGES;
 	refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
 		  (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
-	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
-					    &range_cnt, refresh);
+	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, ranges, &range_cnt,
+					    refresh);
 
 	if (ret)
 		return ret;
@@ -1446,8 +1446,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 	if (!*exp_ranges)
 		*exp_ranges = range_cnt;
 err:
-	kvfree(ranges);
-
 	return ret;
 }
 
-- 
2.49.0

