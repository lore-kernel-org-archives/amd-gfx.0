Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB2ACFD2F6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 08:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A183610E5B0;
	Tue,  2 Dec 2025 08:20:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lEohYmVX";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC1210E590
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 08:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r90dGse9j5ccDBOol1aqYq2mo7z8uW5X4V5Qkv/bjeVBy22cCqSdamQ+9tDWD8MT5XeSuJl3Kapm/5OxjgH29U33/qM5gcrxm17c0mjjgEjqrBGuwUY3Xu0cmo7PCqzLkZ7/RY6XX9k6/9qjLMpyc5Ui0zSWlc8LDj64plxe7lBZv8stOBpT11tdmbEH2Y8xfYsQF5B29Ipug3ie2XicprhHkI3kiiDcTL3FBdw/kfjUQwxJ5VPfxiQW82CcUMWzbXPIODoQuG6Bn1P+Bw5x77c+NgEziutYhYZLardxQMFMNHuzkpMHfE6BUSDR2qLMvrzzBIBaSnc/wpgFq7j1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/E8dO9vkmtAJ/3TrrB98JOrSh7aK4Wn7JQSSdMs6sE=;
 b=EcskRAc0+Vu/kJo2yN+0JT5lxv8tXKa4cn97L4nJjDv1wp+mv34iRXzGANP9wkADz+xADaqhvaScqQj0scW/mKSzet3E9mhIo0+gMuZPo6w4r3Q4ozo7ga4s+b5KNDA3jBE3/uvtrG5kmjcA75uHwaWHFWOUVELBxZnBb2JIImY5XE1omBtrJZ8n/8wRzfo6t3NXQVGNZZz4K3KpNhDFi9zhCRY9ibZpp5TykSOPmBA+eCRO74Fr/grSZAce07XXaaG+kz6zE/VGm7ysJrMYq7S602meGmh6r3N3crey3htP3NmbgxvvwgumUHEH/CbuM2suXb6alSEq88GCQUSJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/E8dO9vkmtAJ/3TrrB98JOrSh7aK4Wn7JQSSdMs6sE=;
 b=lEohYmVXFuMzxumDFYCdNFB68zhscpeeQEh2dwcv5l9k8t8/dxHs+XqTe48NEfqmg9gxorfUXb8x8yokupF7sOJpkky3x60oPRHWbwnYNt6tyKfKU6lJDmBes7s7aKOCBW6vE6JBgHunBDSQqTL07xd1BoZLQ90oZihW25grMBA=
Received: from BY5PR17CA0018.namprd17.prod.outlook.com (2603:10b6:a03:1b8::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 08:20:28 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::ea) by BY5PR17CA0018.outlook.office365.com
 (2603:10b6:a03:1b8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 08:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 08:20:27 +0000
Received: from jenkins-joe.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 02:20:25 -0600
From: Jinzhou Su <jinzhou.su@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <stanley.yang@amd.com>, <tao.zhou1@amd.com>,
 <yipeng.chai@amd.com>, Jinzhou Su <jinzhou.su@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: Support physical address convert
Date: Tue, 2 Dec 2025 16:20:04 +0800
Message-ID: <20251202082005.1184954-1-jinzhou.su@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 027eddb1-196b-43c5-1286-08de317ba689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DSG3KscjJVSNTVX4AWp1hfcfzvCPYKN/QWRMrQJZe7IPdjhQg+rzLEzxYpId?=
 =?us-ascii?Q?8yL/GailrsdV2Nsc7Ov85jcFMTH6+3jTMGlxU9++GjMoABLHtQGCP0eZbKwU?=
 =?us-ascii?Q?aTyoXM3TEzQFM6ZnnwwIa4nVCXa1lBfEFhgTXGHJadbr2eaFWvEHPHfJ+gav?=
 =?us-ascii?Q?8KdfsQorj4fds/l2yq2IZdQdiqk1X4jQs3UIgQE3K21DFPbSIDjfvF+9TkQ2?=
 =?us-ascii?Q?b+JP/jwpXFvOsThrEHEp3JYMEnCKm08hi9oUvuCneywqOeP1SOFe8mmljEcY?=
 =?us-ascii?Q?NHmxuanBhlT8sRqE9g+zie8tfwLSA7AaFxmxeS/Hz1xbS4VivRGRFPKGgny6?=
 =?us-ascii?Q?WEA/tX5A/KqBxyGt8s43aB43133vxqNBIUdcnpa9IzTzhgvz0jzzzbwLZLzn?=
 =?us-ascii?Q?bfAVPR3x6Ut/Fqownz9GjExq2g7xs7eeVFHqI+9qOFppawJzbSxspgRh8Ixv?=
 =?us-ascii?Q?05w/kV63W2QIVT7ArppOv1fG9wKYuGpQEoSm//VDun9bNrJXWjAtagqvCwea?=
 =?us-ascii?Q?T6XTFggrm02+cB/WwF+EFxpKMRtAW983EA8vc6gmvBbagF4ZWXJXISEcRDj7?=
 =?us-ascii?Q?MK5JFAes6cuPrRhvZuSyWUnhcNQskn0q3LmVDeY2W+PctFdV4EUhGH4AE+0j?=
 =?us-ascii?Q?N1tQsvlfts1IQxNsria63TCvJIPa4ncTsEu+tqUK2ciQnYMxy/cxImd2byMp?=
 =?us-ascii?Q?xE/xOPXvFeHIyrLUIEN0185pkCDSFFAFlA8CfdefT1bTpyYQ60+FQ8FoUj3f?=
 =?us-ascii?Q?eXk16Jb6vqnd35Nof3dXZgqNscu5MQfaZJTx1MsR0Y93OIYRYTX+l/uflXx4?=
 =?us-ascii?Q?+5ukrLwGe1AXaW1DhoQRZqBhpw3zOFly2aGMLnFrLyyaUe3opTRnk2WI9sce?=
 =?us-ascii?Q?tqtuwqblUX6w9TAJmibWWyBMKRwnF8tS1Hk2jdFusnwP8EA9Igwb7dVviGWz?=
 =?us-ascii?Q?udrubo9WYtn/tnR7zpkLh3M5CMAJACX8NHvxlyeY/tEsYJlwFzPRjKQgttUj?=
 =?us-ascii?Q?YAkNsRIMe29+xI1xwcvMwP+5g3Bc3XAY4sfVpWozBYT/Gb5gpnOyIP5G6FDL?=
 =?us-ascii?Q?kdRTuouaiW+ArtuWLqjos/nRqTALtQJattx1e0uqbUBXBUFtLr43rwFDCCuk?=
 =?us-ascii?Q?GlAaDpsW5WbMuZxWo2Arq6VLDRYHIiHOSAUpbMvPxNemJTOlO9m/H44bwYxx?=
 =?us-ascii?Q?8HQPx6aLRXlaSfit+a/lEzFCYCwYuDRjG3iRRaozXFp+gMCxN/quiQzx+Orn?=
 =?us-ascii?Q?pmNV6xCoXWhg1YsI3c7yobaqYMwH1YXVzVPQHKsil7Vv+9CTNMxgOMu5R+yZ?=
 =?us-ascii?Q?EM31jsQAM0rDKTuuqNsdBvIWd9EG2p9/eRRIzUQHcTtqslVaimGLoJZ4r4bH?=
 =?us-ascii?Q?pksqiD8NPKamRJzXYdh0be6F8ZgaRURk5kAHfFewIsiyUpV03Na/sPICM+Ey?=
 =?us-ascii?Q?FSm4+w4YzQbpxjYuIo/sYRv+T2MVx8y7dHTc6wbuU0nsdsA0Pj1CNnE0u2Bz?=
 =?us-ascii?Q?HM9UVKts+TfUig6XsORqFEEzGQw6rL8+7vawWPDXxI73Y+fwYiayabHmL5QQ?=
 =?us-ascii?Q?sSgG4fvNhcBkrzeAfSk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 08:20:27.6601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027eddb1-196b-43c5-1286-08de317ba689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

Support physical address convert to current NPS
pages in uniras.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 15 +++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  2 ++
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    | 23 ++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 31 +++++++++++++------
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |  2 ++
 6 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 923bddd0af3a..d1f0152f7855 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -670,3 +670,18 @@ int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev)
 	amdgpu_ras_process_post_reset(adev);
 	return 0;
 }
+
+int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
+		uint64_t addr, uint64_t *nps_page_addr, uint32_t max_page_count)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (!amdgpu_ras_mgr_is_ready(adev))
+		return -EPERM;
+
+	if ( !nps_page_addr || !max_page_count)
+		return -EINVAL;
+
+	return ras_core_convert_soc_pa_to_cur_nps_pages(ras_mgr->ras_core,
+			addr, nps_page_addr, max_page_count);
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 080ac84fc5a5..23c411c98231 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -81,4 +81,6 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
 		void *output, uint32_t out_size);
 int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);
+int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
+		uint64_t addr, uint64_t *nps_page_addr, uint32_t max_page_count);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 3396b2e0949d..71d807e8d2a7 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -367,4 +367,6 @@ int ras_core_event_notify(struct ras_core_context *ras_core,
 		enum ras_notify_event event_id, void *data);
 int ras_core_get_device_system_info(struct ras_core_context *ras_core,
 		struct device_system_info *dev_info);
+int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
+		uint64_t soc_pa, uint64_t *page_pfn, uint32_t max_pages);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 01122b55c98a..7e70560b590b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -601,3 +601,26 @@ int ras_core_get_device_system_info(struct ras_core_context *ras_core,
 
 	return -RAS_CORE_NOT_SUPPORTED;
 }
+
+int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
+		uint64_t soc_pa, uint64_t *page_pfn, uint32_t max_pages)
+{
+	struct eeprom_umc_record record;
+	uint32_t cur_nps_mode;
+	int count = 0;
+
+	if (!ras_core || !page_pfn || !max_pages)
+		return -EINVAL;
+
+	cur_nps_mode = ras_core_get_curr_nps_mode(ras_core);
+	if (!cur_nps_mode || cur_nps_mode > AMDGPU_NPS8_PARTITION_MODE)
+		return -EINVAL;
+
+	memset(&record, 0, sizeof(record));
+	record.cur_nps_retired_row_pfn = RAS_ADDR_TO_PFN(soc_pa);
+
+	count = ras_umc_convert_record_to_nps_pages(ras_core,
+				&record, cur_nps_mode, page_pfn, max_pages);
+
+	return count;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index 4dae64c424a2..c6fb375fecf1 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -154,6 +154,21 @@ int ras_umc_clear_logged_ecc(struct ras_core_context *ras_core)
 	return 0;
 }
 
+int ras_umc_convert_record_to_nps_pages(struct ras_core_context *ras_core,
+		struct eeprom_umc_record *record, uint32_t nps, uint64_t *page_pfn, uint32_t max_pages)
+{
+	int count = 0;
+
+	if (!page_pfn || !max_pages)
+		return -EINVAL;
+
+	if (ras_umc->ip_func && ras_umc->ip_func->eeprom_record_to_nps_pages)
+		count = ras_umc->ip_func->eeprom_record_to_nps_pages(ras_core,
+					record, nps, page_pfn, max_pages);
+
+	return count;
+}
+
 static void ras_umc_reserve_eeprom_record(struct ras_core_context *ras_core,
 				struct eeprom_umc_record *record)
 {
@@ -162,14 +177,12 @@ static void ras_umc_reserve_eeprom_record(struct ras_core_context *ras_core,
 	int count = 0, i;
 
 	memset(page_pfn, 0, sizeof(page_pfn));
-	if (ras_umc->ip_func && ras_umc->ip_func->eeprom_record_to_nps_pages) {
-		count = ras_umc->ip_func->eeprom_record_to_nps_pages(ras_core,
+	count = ras_umc_convert_record_to_nps_pages(ras_core,
 					record, record->cur_nps, page_pfn, ARRAY_SIZE(page_pfn));
-		if (count <= 0) {
-			RAS_DEV_ERR(ras_core->dev,
-				"Fail to convert error address! count:%d\n", count);
-			return;
-		}
+	if (count <= 0) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Fail to convert error address! count:%d\n", count);
+		return;
 	}
 
 	/* Reserve memory */
@@ -367,10 +380,8 @@ static int ras_umc_update_eeprom_ram_data(struct ras_core_context *ras_core,
 	}
 
 	memset(page_pfn, 0, sizeof(page_pfn));
-	if (ras_umc->ip_func && ras_umc->ip_func->eeprom_record_to_nps_pages)
-		count = ras_umc->ip_func->eeprom_record_to_nps_pages(ras_core,
+	count = ras_umc_convert_record_to_nps_pages(ras_core,
 					bps, bps->cur_nps, page_pfn, ARRAY_SIZE(page_pfn));
-
 	if (count > 0) {
 		for (j = 0; j < count; j++) {
 			bps->cur_nps_retired_row_pfn = page_pfn[j];
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index 7d9e779d8c4c..80114a1e9b02 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -163,4 +163,6 @@ int ras_umc_get_badpage_record(struct ras_core_context *ras_core, uint32_t index
 bool ras_umc_check_retired_addr(struct ras_core_context *ras_core, uint64_t addr);
 int ras_umc_translate_soc_pa_and_bank(struct ras_core_context *ras_core,
 			uint64_t *soc_pa, struct umc_bank_addr *bank_addr, bool bank_to_pa);
+int ras_umc_convert_record_to_nps_pages(struct ras_core_context *ras_core,
+		struct eeprom_umc_record *record, uint32_t nps, uint64_t *page_pfn, uint32_t max_pages);
 #endif
-- 
2.43.0

