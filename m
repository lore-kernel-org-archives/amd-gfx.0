Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C4FC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD5310F376;
	Fri, 21 Aug 2026 16:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pPhdX5IV";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0234310F376
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBps/O0vltiL5Ov+zN775VkbT/0dRQW0qhlrSIvk/Kqi6/kY430G5gD451tdlLq5DzT5W6F02ZJ5mmpWgBO1IPFe+21Bj1QRk86qh3iWavYbE88AurMD/3VnPjiPp3eFFDbXGzeizJdOCk633LHCcKFJmLthwsmeOoiYDUAcVJIyvnqVDgBdBq5qS6NBc0+DzUNVVXlx9t1lCcJ3qClVrhy3u0z7PMHUE/bBMRSroMesFXfTxJ4iADBxn8epXWTmbjHVnZ9QMrvbaAyhm09j0z5kOBiRldpXIcrXogOM7erAfghPLiNzmuarCk5INSJYT2GiB7HPf/ppe1Vu3bk3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRN/vaPYLB7sRpHxRTt0RUD8tv4nxvLyyqB0klRZ958=;
 b=Il4kNP5s6vfy5juCVUFHhS1w7QtvlkzoTg8/+AyeAmCf+j9z75w/WqXpvMj182xT4yCX13Q8Q+Nz4YVQLh1X2NOUGTbScy97DSUBL+WjdMJQ93PJwae92qP6RKEn0xO1C4EakMlluQsyxCrm3DfwiuAADr+kGv2IFQmHCVOUZ2PSZ8hGFYJSFeFYP6Ky4t/W6xNwjiqOzMiIaIVCv8dNzbX6oGi5QEwschV+xdSx2fAfIyBVyv+VzpUJxp3CSi/s9zi/FMCFXPvz4YjfQbTiNYpfX878bE+duXF1YPrIYMFmHdevqgfiEFw3x0Zk75BjsVt103eKCYWb12Du/TLOow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRN/vaPYLB7sRpHxRTt0RUD8tv4nxvLyyqB0klRZ958=;
 b=pPhdX5IVhe0JdJTlcZscXdk6csYjMTdb6BL23pR01Htyh5MqYn1W6DKTkcM2rWPs8DLQtzKZmMscrh8RCxRA+sZvyXVanVzD+fD0+xP7/aHBT+yH59flN1CJ7QgZwkp0H1GDpXvbNB7spoKLBsWq0f3NvOTJhXlhb7EWAzvUN20=
Received: from MN2PR18CA0027.namprd18.prod.outlook.com (2603:10b6:208:23c::32)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:14:20 +0000
Received: from BN5PEPF0004698D.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::7b) by MN2PR18CA0027.outlook.office365.com
 (2603:10b6:208:23c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF0004698D.mail.protection.outlook.com (10.167.245.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:14:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/14] drm/amdgpu: add
 amdgpu_discovery_get_mem_reserved_region_by_id
Date: Fri, 21 Aug 2026 12:13:52 -0400
Message-ID: <20260821161401.754042-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161401.754042-1-alexander.deucher@amd.com>
References: <20260821161401.754042-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698D:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 8680d569-17d1-44a0-706c-08deff9f41e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|3023799007|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 8n7Dq/cl99XyVsGajcjgZ3mEOkH2NBPmxQrZvHrr5mzqLN2FqATV+++KTl9o0lXcSRD/XGehNzFJLeVIQELWKZ1s43j0bKBFGLRHUII4e4iMzyleuWJ7VphDWMbVRLgWZur9gLRVLL17irQedU39KnYSOVotvZaSuLIA7Mi2do46caoIw+cc89ZDAK73GKjKC13mSie4ll/fZCHy5QCLlh6lPzzpEglMnnVUFx27x3F/TsvcufgvQRXiFPYnbMRkKl5n+w9CMhZLUAwk5/qI2Pdgr1nc7NWbe20Q6mytfH3dj+ZOKPyVNyBAipMfPy43GZ2IpmpT36RtiZFa2yvPYSHxh/9V7nMoobJYukugTk5FxHXAGHKhLC2VDQKkhi5GzjP0i3e+lt+Zes693E5c7uTb+hTKoNk5ftgWDzb1e04HiB7fYF2uVomu8RPM6QSjoB4P27fBVFaoc2Kgrg8acOP9egtBLpI2+EBk4Qd4H2voH3AZPT8xE3l4odTaK+OVYpGKo8oLWikXnF+JOyakqu+ywXYqJNTSK5jP+a18HyBFZF6xIR3xByS6udNbFbMVyOIUvVSnCHiIPgvlN9T2KAoFKrAYx9DeBVVvyGnwlrf7USep+vjWwm/4NjQgK9XhVg5gFjexp8cIue5r405ZKWLFuYv0Zvfp/4/NfbFDZffdAe1WBF+iMax0ghLi1OIJvP9ddaJt7iXwjaExSlJwJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KFQtMDzDwG6CbVTVJN5FvQwIRNicJIIeJ8DOqNRICVPsXcj2UiMB/ZUOnl6mRD2gExk/n2NgkVN8AuQD5cma5zvQZNGno78YGIvNsr30UUU3WGA/Aioy4eUYtRkXfcmqTaqO7/d0YUwh4GuOY9w4ILBxAkipSvQnF4O8zZ19oJTyV4yUbqxsJ9q/duzScEghobWwK4z+MmrpufyiO73ii2vm8cXxQMgNy9LNykgvR1F8bo+peFgfJR6dQPSM3Rzj7nzNrD9HrvN3LdPZ1bB081ItlCOfoQJ4lMqZoLOgn/siJltXnyaWJAGB4PiGmwJ0Jcji3CokHgRIPBlzZsz2nQbLn6ViOcDpjlUwfX1HKdbUbL/nHnBy1hmxNhHddel8LccPXI5v5OY7dEtaH6lC6IBukheCyyLYhvVNlRrbKd6tmpLNP4FnIO9lyLSYkstl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:14:19.8318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8680d569-17d1-44a0-706c-08deff9f41e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
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

From: Feifei Xu <Feifei.Xu@amd.com>

Add a lookup helper to pass a MEM_RESERVED_REGION_ID and receive the
region's start address and size.

A static amdgpu_discovery_mem_reserved_region_name() helper is also
introduced so debug output can refer to regions by symbolic name rather
than raw IDs.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 55 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  4 ++
 2 files changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4d55933f033cc..5d94453e85c6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2391,6 +2391,23 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 	return 0;
 }
 
+static const char *amdgpu_discovery_mem_reserved_region_name(u32 id)
+{
+	switch (id) {
+	case NO_RESERVED_REGION_ID:		return "NO_RESERVED_REGION";
+	case PRE_OS_DISP_FW_REGION_ID:		return "PRE_OS_DISP_FW";
+	case MASTER_DIE_UMF_REGION_ID:		return "MASTER_DIE_UMF";
+	case DCC_META_DATA_REGION_ID:		return "DCC_META_DATA";
+	case VM_PAGE_FAULT_REGION_ID:		return "VM_PAGE_FAULT";
+	case G7_PSTATE_APERTURE1_ID:		return "G7_PSTATE_APERTURE1";
+	case G7_PSTATE_APERTURE2_ID:		return "G7_PSTATE_APERTURE2";
+	case G7_PSTATE_MIRROR_REGION_ID:	return "G7_PSTATE_MIRROR";
+	case G7_TRAINING_DATA_REGION_ID:	return "G7_TRAINING_DATA";
+	case SPECIFIC_PURPOSE_REGION_ID:	return "SPECIFIC_PURPOSE";
+	default:				return "UNKNOWN";
+	}
+}
+
 /*
  * Resolve the MEM_RESERVED_INFO table from the IP discovery binary and
  * cache it in adev->discovery.mem_reserved_table.
@@ -2428,6 +2445,44 @@ int amdgpu_discovery_get_mem_reserved_info_table(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * Query mem_reserved_info by region ID
+ *
+ * @reserved_region_id: MEM_RESERVED_REGION_ID to look up
+ * @info:  pass NULL to skip
+ */
+int amdgpu_discovery_get_mem_reserved_region_by_id(struct amdgpu_device *adev,
+						   u32 reserved_region_id,
+						   struct mem_reserved_info *info)
+{
+	struct mem_reserved_info_table_v1_0 *table;
+	u32 list_num, i;
+
+	if (!adev->discovery.mem_reserved_table)
+		return -ENOENT;
+
+	table = adev->discovery.mem_reserved_table;
+	list_num = min_t(u32, le32_to_cpu(table->list_num), MAX_MEM_REGION_NUM);
+
+	for (i = 0; i < list_num; i++) {
+		if (le32_to_cpu(table->list[i].reserved_region_id) != reserved_region_id)
+			continue;
+
+		if (info) {
+			info->reserved_region_id = reserved_region_id;
+			info->reserved_region_size =
+				le64_to_cpu(table->list[i].reserved_region_size);
+			info->reserved_region_start =
+				le64_to_cpu(table->list[i].reserved_region_start);
+		}
+		dev_dbg(adev->dev, "Found reserved region: %s (id=%u)\n",
+			amdgpu_discovery_mem_reserved_region_name(reserved_region_id),
+			reserved_region_id);
+		return 0;
+	}
+	return -ENOENT;
+}
+
 static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 {
 	/* what IP to use for this? */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 070b404c1944c..2cd00cc4ed363 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -63,4 +63,8 @@ void amdgpu_discovery_sysfs_early_fini(struct pci_dev *pdev);
 
 int amdgpu_discovery_get_mem_reserved_info_table(struct amdgpu_device *adev);
 
+int amdgpu_discovery_get_mem_reserved_region_by_id(struct amdgpu_device *adev,
+						   u32 reserved_region_id,
+						   struct mem_reserved_info *info);
+
 #endif /* __AMDGPU_DISCOVERY__ */
-- 
2.55.0

