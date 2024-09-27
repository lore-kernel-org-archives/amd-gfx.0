Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D079CEBF69
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 04:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A5310EC0E;
	Fri, 27 Sep 2024 04:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LCZics3k";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D2410EC12
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 04:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgPWSdBcu/e6XVaVZWTZ9WMDXAQc9r32WqLHDXGEBSQjbN+bM8SMXFIzMRlqhZhb1bPObZGQ2Nqsu+Z/R3IAi0+muWELWOYS98zQpU9Wxmdvl2Dx98tRyGsXQwYyFbh1iyg7thq6C95M2Vgcn+wd9Of5lCmW8mU/+hCzi0WvnhfH1r+LCn9TCp00n5ZUSvQabnaRvOQ7M2MPML7t8iJg5QBbxZadrMJ8eCtV6ImmbzOTe4RhQCoJhHrqx+/q112GMSmo3i9jImQEANprEARIs5Lh+nQQixyrU7/y6+dW6OSVNGtCyclDSao9rZNmfXRRaWjETu/V/C+4+2kpiq6a1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okF4xSrJ9BpmSSQXAnKC31xtWTkySDzxb1KlwjBvFB8=;
 b=KQoKO43DCMY5ppTMFOWFcaLrjKp1wYLBXmCuIOdnENjFz4aYySnmfBvzhF3B+PTb1v/sXvkV2ecIj1DbWU7Af2uH/yJrmkkCtRwNFgbZPwPQUPX1OTjON0nk6KSfcu7Rhf21JStJAyxHBbGxkWwMfQK5Zog8M47A+8SBanbHeq/cnqroS2lmlXHGytZjG6LEvj7gCf3u+Pz7hV8kHS95pV8FqB7WBBXEETPqlrho/viNc/wxmjsWc7H4R8PjEUH4jZ41hF//vryQnh9SAwkEMflV+L5kKmUM2kAAn53CswcfXN8mZicjk3u+Pqg/wnItHq/293JObNjCu52kPI/BXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okF4xSrJ9BpmSSQXAnKC31xtWTkySDzxb1KlwjBvFB8=;
 b=LCZics3kaiZLkowAegWWeKmqveKpiPBXeBHxREDRTCidYZdoIFYr7A7oqRBoKwSSNYtXiHwNaGEN+m1uT5lRu9y1+DUt9ScJI5TU2T7S+YPNWYle6AimpTWBE5tW25XkTgLqhnMZhuin36rx9Ytgoh3UgCAzI8aQ8a/XVBCCYGI=
Received: from SJ0PR13CA0097.namprd13.prod.outlook.com (2603:10b6:a03:2c5::12)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 04:58:17 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::16) by SJ0PR13CA0097.outlook.office365.com
 (2603:10b6:a03:2c5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.8 via Frontend
 Transport; Fri, 27 Sep 2024 04:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 04:58:17 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 23:58:14 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Ramesh.Errabolu@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH v2 6/7] drm/amdgpu: Check gmc requirement for reset on init
Date: Fri, 27 Sep 2024 10:27:42 +0530
Message-ID: <20240927045743.2718949-7-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 214bde9a-a7b7-4743-75ee-08dcdeb10021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7bFKFzFTmI91bSbPejJDIbRurPQxhPYKnTLv4Cw74+keN/x6FfKiBLD5tZcK?=
 =?us-ascii?Q?Ok+VL6Rb3n2xfi9lGdg+nQv/NQAwwE42wxcafL7Op+FwB8o23H+UeSFaCYuS?=
 =?us-ascii?Q?FgEpNv5kANpansR41EWDdsLwvyAx8MY3/7t0nQ4cch/UkHnJf5abBE3hBBlt?=
 =?us-ascii?Q?n2g7MSGW8Uk5UItyjkN/MumuwzevPXuIe7XkDBoknFeDCk4Q/7oS2yqhPu2l?=
 =?us-ascii?Q?Lao/iqKLxxXgfGLI9Rrz6PUoNm8SQ1SsM7y8vwHkALuxCODqTdkALs2YVFNP?=
 =?us-ascii?Q?TMETsSXUx5mk6jYf/Vlub5p5GNmn7evTe6MmlqrCxk8zMgpUKeZmt3kbGqhb?=
 =?us-ascii?Q?V7L7yOzU9876lnfidOLWEdQmePq2N6Rdn5C7wW5qaOkNgr0lnkUcJWL1X6HZ?=
 =?us-ascii?Q?wqBf7j4GBRysLq2/AInA3aauBlGUlsbveoHccLnQPNylFg55ZEaTzFWQ1qR9?=
 =?us-ascii?Q?o9vd00PiBMjjZa4edjtOb8aMQglrXukeEwMDk6k/EjU+hupawk+2W/025djm?=
 =?us-ascii?Q?XZoCFBrrW7E1MJJfhyPXLzuasEB1kq5j++d89rMk5QsQo94g0mnktnBXdPAg?=
 =?us-ascii?Q?YCCAehJ5t//pJtKLbxCVC2e04qfKsJVBclNMSroVrqKtPniu/lSALgoC++oZ?=
 =?us-ascii?Q?r9xols0cOyNWpu7rzOdVnPOPXrPLMqg7R5Qx0XBwV3rv3BGhOqAhOaYcdUzy?=
 =?us-ascii?Q?Gtf4Dy29XENRLcNP4hCThU1AGdE3ru2fCGscYU5ypxi1DurANT2qwSkKDr/P?=
 =?us-ascii?Q?xTgQlXKkzklF7ieFUwBNZ7HkX2+2a6UkG95qtVPowCBKBEKCKTmom7bmInA5?=
 =?us-ascii?Q?ogxZVdZ0Ukq2UKYTnpFz2MR+7mqVRKmH5W5tBIIonW0X2a9yXyIU3gxv5O1/?=
 =?us-ascii?Q?/PrvkgHmMk7iaqSR0L2Ktp1eUGbFQHVWfXiM27vX5KZ7gRBuDPk89zTcAXis?=
 =?us-ascii?Q?kJ8J6z2xhJfrULfU+DEQArZvPbnqeozDdVoArjLDwQDjlHadFQO2E0vJNxdb?=
 =?us-ascii?Q?KnwQ+IQLx7FdEDM86fBzg14bFoblwQM+So3nwpLvQYFE6AX4MB46DqFfU8z7?=
 =?us-ascii?Q?PpjPBC98sAWJsfrlLwJshUPVAylU+wkupWwlBv983vr0a1SIn+iSYxMlF+39?=
 =?us-ascii?Q?57bjD6Lh6DlQyQu47kDzomYPA2M0dF+87+gvn+GG8rhzwMJivn7eVoIanDF9?=
 =?us-ascii?Q?Vldk0cLPkOE+TbkiMPmkEBOoW4toJ1ZF2byW2jSO6ClqdKabM2OBBkksOrMb?=
 =?us-ascii?Q?4koNYNycHQRC1EeCQL87vTqKIUXnPg9RwdyAIgR9s2vnWFemsAQPgGZZTIfs?=
 =?us-ascii?Q?1zoS0NEVtZB2LDDtD1ewP+p/TYZXuMPNZ8pFicl9FQW6baFGE90VUkg/ZA6j?=
 =?us-ascii?Q?BSeNWUUyhL7CftjIk4FocPqiRCvy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 04:58:17.0975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 214bde9a-a7b7-4743-75ee-08dcdeb10021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525
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

Add a callback to check if there is any condition detected by GMC block
for reset on init. One case is if a pending NPS change request is
detected. If reset is done because of NPS switch, refresh NPS info from
discovery table.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2:
Move NPS request check ahead of TOS reload requirement check (Feifei)

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  5 +++++
 drivers/gpu/drm/amd/amdgpu/soc15.c      |  2 ++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 21f1e65c9dc9..011fe3a847d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1261,12 +1261,15 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 	struct amdgpu_gmc_memrange *ranges;
 	int range_cnt, ret, i, j;
 	uint32_t nps_type;
+	bool refresh;
 
 	if (!mem_ranges)
 		return -EINVAL;
 
+	refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
+		  (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
 	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
-					    &range_cnt, false);
+					    &range_cnt, refresh);
 
 	if (ret)
 		return ret;
@@ -1392,3 +1395,11 @@ void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev)
 			adev->dev,
 			"NPS mode change request done, reload driver to complete the change\n");
 }
+
+bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev)
+{
+	if (adev->gmc.gmc_funcs->need_reset_on_init)
+		return adev->gmc.gmc_funcs->need_reset_on_init(adev);
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index b13d6adb5efd..d4cd247fe574 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -78,6 +78,8 @@ enum amdgpu_memory_partition {
 	 BIT(AMDGPU_NPS3_PARTITION_MODE) | BIT(AMDGPU_NPS4_PARTITION_MODE) | \
 	 BIT(AMDGPU_NPS6_PARTITION_MODE) | BIT(AMDGPU_NPS8_PARTITION_MODE))
 
+#define AMDGPU_GMC_INIT_RESET_NPS  BIT(0)
+
 /*
  * GMC page fault information
  */
@@ -169,6 +171,7 @@ struct amdgpu_gmc_funcs {
 	/* Request NPS mode */
 	int (*request_mem_partition_mode)(struct amdgpu_device *adev,
 					  int nps_mode);
+	bool (*need_reset_on_init)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_xgmi_ras {
@@ -314,6 +317,7 @@ struct amdgpu_gmc {
 	const struct amdgpu_gmc_funcs	*gmc_funcs;
 	enum amdgpu_memory_partition	requested_nps_mode;
 	uint32_t supported_nps_modes;
+	uint32_t reset_flags;
 
 	struct amdgpu_xgmi xgmi;
 	struct amdgpu_irq_src	ecc_irq;
@@ -468,5 +472,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
 					int nps_mode);
 void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev);
+bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 619933f252aa..6c0913f0d296 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -831,6 +831,8 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_RENOIR)
 		return true;
 
+	if (amdgpu_gmc_need_reset_on_init(adev))
+		return true;
 	if (amdgpu_psp_tos_reload_needed(adev))
 		return true;
 	/* Just return false for soc15 GPUs.  Reset does not seem to
-- 
2.25.1

