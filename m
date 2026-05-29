Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB59ACD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 09:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F6510FBFC;
	Fri, 29 May 2026 09:41:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F6vs68eL";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4ED10FBFC
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 09:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZKarS8zDAKR3xSddXIm5o7zmdArE8BOjQfviR3u/+TLOoW5Ag6uOKbm0Mu4wxkB5mTMmTjMRORvPhLQh4fuaro4z2oIIWqrfJG/0406/3dMqUSXENymbsaRQJekYX2xc7QXoABlqQLDsn8inVhXaoQ80FxucTDM0Aaiyu9gs7sAtL0C+aVPbJzxnvgS1mORu3gaY1QfS7/e0kQZ3pi6nhxRN+N7v3rpiRgBOTCFqwrKCju3KRS0yJC9hwgLXl4PbwBn/PH37dk+VqzjLjvQwxfav1/FI8wsw155qxHrihko+oulEvMjp77f3Ajt22aQLmO7FL8YiuT2gPo1aVPfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMmbVoBK9Ee8/nFPE+qqpcwDb5WG4bM18Sy65ndXA+s=;
 b=HT7Hv3thY6sZ2HoEO2ga5dyotcsNxEfsegdakS8Gc/NUNES0LCcufeDnbzR7cC+MZOiGhccbuEpVMLR9E29QdxP9l4l//jXizsqc+vIOeLQmdb//+fLXindXfIvoh90rlT5PQPhpeMLWdr9MRiY1Wfs10wsSHwybkryWnBtJmX0yjnQlCOtUu1RNWOXKcQjGhlvRMfuP/vcIVwI9KImG94C29RJb2+swBVGgqcvBKLwugsNewXXqJ4De44xg8VZ+N+fbWTcZA68T41N+02nuEpq/sZaCAZMkTvG0bN+uZdTu8PEhXSaXYKNz+71XsWwTOuUMPCqKfheSp57cjhODDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMmbVoBK9Ee8/nFPE+qqpcwDb5WG4bM18Sy65ndXA+s=;
 b=F6vs68eLtfJAly/Mha5mt6Frlw/9gEiiPWrpptVydu0F8t3Jx+w2QuN/DnFLDWVSC4QM+RAB79eRTLDXgXKrFzQu2vtLAfmiaUEfQT7tQ+RXDobySWYQT2L9quqpDKBzqrIGUNtzC6VbglWlNCRFY4Xm7C6p7T2hf8zRViry5g4=
Received: from DS1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::18) by
 PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 09:41:46 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:8:455:cafe::30) by DS1P220CA0014.outlook.office365.com
 (2603:10b6:8:455::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 09:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Fri, 29 May 2026 09:41:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 04:41:43 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 5/5] drm/amd/pm: Use helper to get pptable in SMUv15
Date: Fri, 29 May 2026 15:11:19 +0530
Message-ID: <20260529094119.1134923-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529094119.1134923-1-lijo.lazar@amd.com>
References: <20260529094119.1134923-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ac1eae-e36a-4ba6-69b3-08debd667f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IYhwncHnMhIBJcGw/rUsPhjJB4KDjNQn23JlGqNG+zIqz6ECVaBVkW+s6r9jTpFTmynsKJEodFuMu3k+rUm2+YIWRWw5CWSV/TWg1b2lAZaZeoDBzQCpyPU2szwMyTh/M4tVQ0WjBu/EC11TrPL19nW+93VX/ihGgNwhb+c+8kC7SK/FDQh5oMQ6efTj8wRkDqkpz0jL1UJ+I/IiLv93OzvNK3871zOmIpaseEZdDurqEm1Tb65rPOMXUZsSdsOE11iO3+phixmD+aPcXvJyS6aJbpYHICssM7Nwt/+skNr3+SjXTZsLOHI8H/6VSRRaFi6FQUs0ZpCKyZt0KQGJV/v1NnALq3FvJHypTw9b3ZPg8obTqTk6e3DBrAgfvRBbxALKC05p37VorHyBeNdo3UryjW28sqSxH8SZdxzEUqI7zJAGpNMmccZFv+xlYfKUdTAR5JrouGWlR/vI7gOFWQ22kZsqItqiQQwdapd8Ojn+8KS4w1VGX9YP0ryBvWOgGeR6ArdIYYv2/h8KN+2/39kPDCuz/4VeEAmScnYstwxY6pFDHigZHKEYUKgJl3a63I3TRLLg7Bm+eEOlbvWc/MhzWzs24zccKO5xdpMFL09OhiukRn1cwJ3Rw1c/Lr5xtfgUPy6+Feolc8gHBttjp9xD9qjSq+DO8WK+Xw2EWvkDP7Xmo7MEPPxXsaIJeEOIGP5lhdMRKz2KlLauTO9koWkGbq3CFtV8/KevuHHeICY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0rvZvtumXsUiROYxz16DRsc62XZJATXyrDy0G0dum+Oenlh8GksqZSzWsYssareLIVOR5sMkomsJ/+x26Xnrdxj2UaXhYDs2E5rRZamiQxpNqzsCMLluN/2avxZ+aaMQ8wfXRb32WhR4aH5VODdH/fcIBfWPiyfgoUvVwxpdnwP1k5qTWt/6ij17J/bf5O0qko7J4vTAwGsb1pLP27Dwy/G2fpplpuoDlsqTzcHQUlUipxLXmArpaUsM+CaU9xxxEBI/Y5DUTN86eoZmKDRMzH2CfECerberAYRKW4gw7QlzhO0/hTA4Pmi1HJoBVMy8snJhEz2vp4MBDVnYBFsVmkkZOGHqfm+8L6EQXrAZUacQSkZpGh4KSCO2nQrsR3Yj+U3oibTB7ma3y74o/L+IR3+tl5qMJQ6xXWLIJ1loklnS8QXfkO2MBOdmMu2UaW1m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 09:41:45.6978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ac1eae-e36a-4ba6-69b3-08debd667f8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173
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

Use common helper function to get pptable from firmware binary in
SMUv15.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Sonnet (Cursor AI)
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  4 -
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 85 +------------------
 2 files changed, 2 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index e6fd8be2cc4a..13723d45a7de 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -211,10 +211,6 @@ int smu_v15_0_deep_sleep_control(struct smu_context *smu,
 
 int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu);
 
-int smu_v15_0_get_pptable_from_firmware(struct smu_context *smu,
-					void **table,
-					uint32_t *size,
-					uint32_t pptable_id);
 
 int smu_v15_0_od_edit_dpm_table(struct smu_context *smu,
 				enum PP_OD_DPM_TABLE_COMMAND type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 4a61e900131f..f87c385a6b55 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -174,7 +174,7 @@ int smu_v15_0_init_pptable_microcode(struct smu_context *smu)
 	if (!pptable_id)
 		return 0;
 
-	ret = smu_v15_0_get_pptable_from_firmware(smu, &table, &size, pptable_id);
+	ret = smu_cmn_get_pptable_from_firmware(smu, &table, &size, pptable_id);
 	if (ret)
 		return ret;
 
@@ -207,48 +207,6 @@ int smu_v15_0_check_fw_status(struct smu_context *smu)
 	return -EIO;
 }
 
-static int smu_v15_0_set_pptable_v2_0(struct smu_context *smu, void **table, uint32_t *size)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t ppt_offset_bytes;
-	const struct smc_firmware_header_v2_0 *v2;
-
-	v2 = (const struct smc_firmware_header_v2_0 *) adev->pm.fw->data;
-
-	ppt_offset_bytes = le32_to_cpu(v2->ppt_offset_bytes);
-	*size = le32_to_cpu(v2->ppt_size_bytes);
-	*table = (uint8_t *)v2 + ppt_offset_bytes;
-
-	return 0;
-}
-
-static int smu_v15_0_set_pptable_v2_1(struct smu_context *smu, void **table,
-				      uint32_t *size, uint32_t pptable_id)
-{
-	struct amdgpu_device *adev = smu->adev;
-	const struct smc_firmware_header_v2_1 *v2_1;
-	struct smc_soft_pptable_entry *entries;
-	uint32_t pptable_count = 0;
-	int i = 0;
-
-	v2_1 = (const struct smc_firmware_header_v2_1 *) adev->pm.fw->data;
-	entries = (struct smc_soft_pptable_entry *)
-		((uint8_t *)v2_1 + le32_to_cpu(v2_1->pptable_entry_offset));
-	pptable_count = le32_to_cpu(v2_1->pptable_count);
-	for (i = 0; i < pptable_count; i++) {
-		if (le32_to_cpu(entries[i].id) == pptable_id) {
-			*table = ((uint8_t *)v2_1 + le32_to_cpu(entries[i].ppt_offset_bytes));
-			*size = le32_to_cpu(entries[i].ppt_size_bytes);
-			break;
-		}
-	}
-
-	if (i == pptable_count)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int smu_v15_0_get_pptable_from_vbios(struct smu_context *smu, void **table, uint32_t *size)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -271,45 +229,6 @@ static int smu_v15_0_get_pptable_from_vbios(struct smu_context *smu, void **tabl
 	return 0;
 }
 
-int smu_v15_0_get_pptable_from_firmware(struct smu_context *smu,
-					void **table,
-					uint32_t *size,
-					uint32_t pptable_id)
-{
-	const struct smc_firmware_header_v1_0 *hdr;
-	struct amdgpu_device *adev = smu->adev;
-	uint16_t version_major, version_minor;
-	int ret;
-
-	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
-	if (!hdr)
-		return -EINVAL;
-
-	dev_info(adev->dev, "use driver provided pptable %d\n", pptable_id);
-
-	version_major = le16_to_cpu(hdr->header.header_version_major);
-	version_minor = le16_to_cpu(hdr->header.header_version_minor);
-	if (version_major != 2) {
-		dev_err(adev->dev, "Unsupported smu firmware version %d.%d\n",
-			version_major, version_minor);
-		return -EINVAL;
-	}
-
-	switch (version_minor) {
-	case 0:
-		ret = smu_v15_0_set_pptable_v2_0(smu, table, size);
-		break;
-	case 1:
-		ret = smu_v15_0_set_pptable_v2_1(smu, table, size, pptable_id);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
 int smu_v15_0_setup_pptable(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -329,7 +248,7 @@ int smu_v15_0_setup_pptable(struct smu_context *smu)
 	if ((amdgpu_sriov_vf(adev) || !pptable_id) && (amdgpu_emu_mode != 1))
 		ret = smu_v15_0_get_pptable_from_vbios(smu, &table, &size);
 	else
-		ret = smu_v15_0_get_pptable_from_firmware(smu, &table, &size, pptable_id);
+		ret = smu_cmn_get_pptable_from_firmware(smu, &table, &size, pptable_id);
 
 	if (ret)
 		return ret;
-- 
2.49.0

