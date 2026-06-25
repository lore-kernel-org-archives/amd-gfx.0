Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBE3CDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4289910F195;
	Thu, 25 Jun 2026 08:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KZtfwmuz";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2337210F195
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNSTGsNGwyJwURl1bHultZaUnrcb7t6N+ShwH75rqy9B8t/yyLB51hZc/mdOyWMThTYDpEbs3tAXjo15TubBS1t4Cyin541goHg4gT4MaOqQgmMAN+c/zEWRjyJDZ+AX2KEpyeyoLIN3aV39noH+lI2xn3nSbLlT6UGt1BzWvQJ7ZcEePuoNnGz+9DUv5RV7uBULO3igVorN2o9l4tUDXou+QagxB6fi5TTcKVtxOsJ1kKp5VMfZ1tUYynb2vfYh+/StAvNtgtp81pyKE1WOU2pY3muQJxmbuKkpegArBTEoSnYIQM8Cvw3BoQpNsO9q2BqjJJDFvA8ThrrUNRe3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVFbNwnHGnVt1jYpuArY9dsMlpD9NlRYti/oWV4QeCE=;
 b=w9hbkpnP6uFOLJjHfsV2tezl8DouR16pSJHryKM807KPuQvIZoMNgN7g8B4ML3PeFdDZfy3VkyPevsifdLa4kA8H4Gtc43yCl5EshtDlSnjyBzhYPwsTXZMaeWhxjyIKat+hSu4mEZg1dHVns9g5J/J7R+h0wIJnv/2lAGJd8ZfKkwUaeqaKhE72xluA54uVvLC2uVp6eUFV5agS95UdfUU6Gu1AlK/vGFI1DWZ5u5hLpcEmzvDclwT9PKZo/Z+lc4RdYX87hi2yJpahNGFQoih9ZvQ1WQy42fxUh66YFCepgwpRbKqOaLi9ZaXD8OqO6EkL8j0iMEVymLoYk2ixDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVFbNwnHGnVt1jYpuArY9dsMlpD9NlRYti/oWV4QeCE=;
 b=KZtfwmuzwHZDi6mh3R54/cTEMV1RVtx4fRcMNoL3BbwsPPR0zjo+c0slJyMcjxDkVaUxEarqDBBnjE24FIwN3rPqYF9L6d7WhxRpC7SJ/aD1mgSos9SpjNPD3uA/MYzjsa62TC1JDhzJXL7bHz1SUZsa8va0yyrno1EsYgKtk+o=
Received: from PH8PR07CA0043.namprd07.prod.outlook.com (2603:10b6:510:2cf::28)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 08:21:16 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::a9) by PH8PR07CA0043.outlook.office365.com
 (2603:10b6:510:2cf::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:16 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:14 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 33/44] drm/amd/pm: retire legacy pmfw eeprom feature check
Date: Thu, 25 Jun 2026 16:19:26 +0800
Message-ID: <4b95268174299b7112605b5d985d9f766f5fe92c.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d63cf2-11ef-497d-5e20-08ded292ba55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Jqqqvc8TuZfT49CSiCW1a4vNeX5bPSodyL+yf8/OTh3MEuppNlVdHSPRgudxGB/aZFBv/kbCSkxvgSUktDQt8a3ml3nxnr1Mw9WtmZb0VP9DqTTNIcM5sogdTm/hP/rNYjKCk9I+fhrGPfwH1S+hwQn5FJdWFcCEF0j4NGGFTs5l8Czn+yTm3IHVm4rcFTBFbyiVxoMVlJ6Nb9In4QUSMd2bIrFhopzwD6FZm5caHqddjr8LsvZHiySQgxSKXEZ1Q2Z8qi2+xJARI0he63ycXpqNXJtdxkDd0pMXfvqVnt9XWuGwkqIxcsE6o3MK6eQbe3r9yzSWjx+0IN7gBrPnwcCCbDxGn8ftucQhb9uM2zrrtLPaVFC4jlcaJ8Ui7CKmsdjh8+k4soFSNCFBFPhdK0c+iXWRz4gFw16e9dc+mKZvNgrLbJX9kEsHVVW0YiZx8LQWkRbz391XfPY11qyEx5Fc8epYzymfAnvUXOZCZDOuqBHwz7mWn51nvfDSW+7MfAUT2psMCaBsd/vU5JRP55H1fPsKHakb/SPPhP0iJ08p+t0XXlwyYYHQtfnZovEt3X0v+g+c5gTYPn5c5DhYq4sYL1mNjKDbhJ5Pw04SowI8pPVF+m2TlP6ACVZvUHcq1NSw0+YwRgmTxQ/FadfaInvvDm2w4Dt7zHSPx6lkLr/JLo3SdM7uBvfHvFpngy0P/SOIe6fQUfLHfbc4P6fnGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9JYWpa6Lh63ZSFhFdhpMrsvzvfyZ39IhrM0/kWX6ko8j+OscjujQoMbakeV/XVG3ggAXE1CeRkyMw8pFIBsyfbkMNYEos73jKg9Llge9eVRh0BvaynOLj2UIBUqzw+Fw9lQzA1NfUZhIEPoeoHxYLXxbgJY5XRhFUq8fun05FjZAu0sJsfXXjto53NMAUBCnGJhSIwzanonINXyN91JhKbGZZny5UWO+4V7IgSZPqB4WGFj81Ne2kfZ5RhYXgh65yZh9KPhaQT2h+7CQxoPBYvy1vOLEHZxpedlzjm94Xl4enm1O2BpIci71v5jkbtSmgHPAwgS9C9hGuDPr4v2z4zX0NnEdACdjXrFoGuXRHXigYyyq+csdVGEcYZDAggaLyxSW3xzA6rEXbxRtEu7TaJq667NTQCY69AkUSytzp9mWYXxxJuFu1Ek3WzQF6hVK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:16.5831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d63cf2-11ef-497d-5e20-08ded292ba55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911
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

retire legacy pmfw eeprom feature check

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 6 ------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 12b57a0f4fc4..0098e9414c55 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -1137,16 +1137,10 @@ static const struct ras_eeprom_smu_funcs smu_v13_0_12_eeprom_smu_funcs = {
 
 static void smu_v13_0_12_ras_smu_feature_flags(struct amdgpu_device *adev, uint64_t *flags)
 {
-	struct smu_context *smu = adev->powerplay.pp_handle;
-
 	if (!flags)
 		return;
 
 	*flags = 0ULL;
-
-	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(RAS_EEPROM)))
-		*flags |= RAS_SMU_FEATURE_BIT__RAS_EEPROM;
-
 }
 
 const struct ras_smu_drv smu_v13_0_12_ras_smu_drv = {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 395b735dfa8e..966b2415d983 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3281,9 +3281,6 @@ static int smu_v13_0_6_get_ras_smu_drv(struct smu_context *smu, const struct ras
 	if (amdgpu_sriov_vf(smu->adev))
 		return -EOPNOTSUPP;
 
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_HROM_EN_BIT))
-		smu_v13_0_6_cap_set(smu, SMU_CAP(RAS_EEPROM));
-
 	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
 	case IP_VERSION(13, 0, 12):
 		*ras_smu_drv = &smu_v13_0_12_ras_smu_drv;
-- 
2.34.1

