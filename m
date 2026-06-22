Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1F9CDB471
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFCB10E57C;
	Mon, 22 Jun 2026 08:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fCdg264k";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1401710E57C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCKBDLPVtIRQI8cMovub6HoDSOlh059XIZDe8YCllR/4/dLG0ToiMiuAEK7w1U4V5bXud1lX5ElyMjfXPSj7wwJ4OFh6lyHW0XEVuoMoTnSwJDExR1LDFMh2Th1585uQcKEm8C/2GWJZ8sHgXz2KtfRDsAjgdkD6K3EeFUrAnj586WgnUAqsxFmQdhI96/bRnWBlKmzeCS4K1xjr4zoG+YAMcPHA6vvRrr29K/uTYt6gpWDvnXfewqkznN/E8j7lwhgGJcTvJjj2rLlntL4n6npvrnKsPc5uV0WmbmV6cQP4JagiTj3mXLkqPMQUaSrDA1WXdFhOwHS1WuGqYuF21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlIcRwXMZSqjMHEi65hWATiitbHU752MptOWsFRkfNw=;
 b=mLGxc8C73tj4ad9TTE4Yz7GuxhYTjwmuptK0pFVKTgOWaRofeqsUIUXDtWGmVmfIf0e7wouZ2UzMa23f37YrDchBz+RxhFVW+Jpm3GfrpFo1IALWOjASZtVR3DV5ZMjFZRdPTFhl05gp53GaCydz9jBG92Lt8bIX0THcgpBww45L9DJNqFtaE/NmXYJsDFrhirbnUI2/uM/dZTyYtaDHGml0yEpICWLG0hkIHxIbEszgM9Jo3M6lNKvSrLnN4G8JW8nBIY3W5KYQh9AehXUV+lnnupi91stFBuJopuUBmpEArza6xcCZN8LcViMpLxIlk2rN49KMWbfS4YMydFKPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlIcRwXMZSqjMHEi65hWATiitbHU752MptOWsFRkfNw=;
 b=fCdg264k/FW4iTD7ffEwQsBPtPiYKb9v3Dx2xFDyb2xRAOTvO+ZXGkUtTBWGguq/NFElIqV0izmN3nt9mnlAOBO0+JTvj0wW9lmUpJFdTjb9g9ZLTJLIeV5bCQudCpeGK7QshEoPjw9TSN6pgfZPQgGKwv6GZuWAeEKzG4U3tR0=
Received: from DS7PR06CA0027.namprd06.prod.outlook.com (2603:10b6:8:54::6) by
 DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.19; Mon, 22 Jun 2026 08:46:27 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::10) by DS7PR06CA0027.outlook.office365.com
 (2603:10b6:8:54::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:27 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:24 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 39/48] drm/amdgpu: retire legacy pmfw eeprom interface
 wrapper
Date: Mon, 22 Jun 2026 16:44:41 +0800
Message-ID: <b1e009a7fb68bbfb0d9818f3cf7bd60917afcd34.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7d2eee-56d2-44b3-fbeb-08ded03abf85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tiuFFN/bosrDS2Ih0N+IV18qddYEjMeFep80B+F+sGMuztRXngL7U+PHy666M4sBWFGTL4AC567TH/lcRIuxF4vH+08RcXWWPodIY1IKe5M3kMgn1trYZ8HnBSz9wqk1x4Op5jo/Q1xep+cIJfWkHSgRIvHhcN4ttHiCHWwlTnAsY86Lamk+WkYTLTnjFKX60groDTosB1hQNeMFMMsfUshjjROin3fo2Vbl6ySSO7BbLBzNLaB19FbrEGmP9+tTRemTeAsb9ltl8gyb1rP2Qj45U+KDsIUYIYy34RmpD4JJJk7kjsuiH5kFNgQuPmkQ7pETcbufGdTdM/kXv8EbEURRF5gve6erLKJnyz6Slj0mkxf+wj9Iuhy4WEGt7HeuEfpnD6Lv78rXA6/pC4mXPjXzEXxNIQ1yWUPm+6Jwq/BhaC48aC7DrtJG+JzUv8CETfMEmnI9z28CbHYw5VZ9fbK2gfJYlK7zEnB1CJi52jyEy/E/88tVKIQTmFxxI6AJRecc4wzkwuaDqwHk/C2RgiwXfkoIEyMPBdfwyVBUdRMYYmRgb3ju3i4P775p9Tp3a4eGnzWinmAyTJXSjfZ7JEtbHcULs5bfHZHSSWQOhSBkbr6s151NdIq4EDUAmnay5kSBIJzu2dcblLvBpZ39K+3/ublWS7zeu4MBQeFzXTruwZRTIZ3adpDfxrTGu/H9IQstgj1U8gH+9N32QnL1Bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mIt+WoCX32ajpCFtZ2glMQlcxwlky027dShDTmFZiCIw5kmSbgo4Vix2p3ObgNHl+V0Or3/X2/oVIOJOqp+GNAR7lN8iVEj6f/SjCQFOo/HS0zDCTFv5BHP+YYHGZQyVQb0djrAcX1V+3ZJ+3vQsFTlOrdY902g4kLaZ5vuqRq3Y9ckVsFyFK9PfIQCZNUpmSO/Ks7k1TyKsWxn+J2tZ9dqvJOcF4s7A7LA1XAbxzMRjlLzu/7pC1CWwTU+SNZSikeq+lVoXYsUiiLGU1qhHyxuhVSxn54J/uLxholRshPP2pxBUvMPKEDrRylKuQzhzBeQgkn5fF8hAl/JmME9x/2dS/rrHl4wSIl3ehRxvyJsLDQYeNj0Ze1YA+DTclxSL0nz9DjarxJISithdFbV/yUxfgdDR9VAG57e/AuoiAwp6JoWFZpkk7t+mNqDnXdXy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:27.2227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7d2eee-56d2-44b3-fbeb-08ded03abf85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704
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

retire legacy pmfw eeprom interface wrapper functions

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 98 -------------------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    | 21 ----
 2 files changed, 119 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index baa8cc3646d5..8c398c2e6709 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1740,104 +1740,6 @@ bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev)
 	return !!(flags & RAS_SMU_FEATURE_BIT__RAS_EEPROM);
 }
 
-int amdgpu_ras_smu_get_table_version(struct amdgpu_device *adev,
-				     uint32_t *table_version)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_ras_table_version)
-		return smu_ras_drv->smu_eeprom_funcs->get_ras_table_version(adev,
-										 table_version);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_get_badpage_count(struct amdgpu_device *adev,
-				     uint32_t *count, uint32_t timeout)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_count)
-		return smu_ras_drv->smu_eeprom_funcs->get_badpage_count(adev,
-									     count, timeout);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_get_badpage_mca_addr(struct amdgpu_device *adev,
-					uint16_t index, uint64_t *mca_addr)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_mca_addr)
-		return smu_ras_drv->smu_eeprom_funcs->get_badpage_mca_addr(adev,
-										index, mca_addr);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_set_timestamp(struct amdgpu_device *adev,
-				 uint64_t timestamp)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->set_timestamp)
-		return smu_ras_drv->smu_eeprom_funcs->set_timestamp(adev,
-									 timestamp);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_get_timestamp(struct amdgpu_device *adev,
-				 uint16_t index, uint64_t *timestamp)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_timestamp)
-		return smu_ras_drv->smu_eeprom_funcs->get_timestamp(adev,
-									 index, timestamp);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_device *adev,
-				    uint16_t index, uint64_t *ipid)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_ipid)
-		return smu_ras_drv->smu_eeprom_funcs->get_badpage_ipid(adev,
-									    index, ipid);
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
-				   uint32_t *result)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return -EOPNOTSUPP;
-
-	if (smu_ras_drv->smu_eeprom_funcs->erase_ras_table)
-		return smu_ras_drv->smu_eeprom_funcs->erase_ras_table(adev,
-									   result);
-	return -EOPNOTSUPP;
-}
-
 void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 3c7fcce5fe8b..5e5275ae7aab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -165,27 +165,6 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
 
 bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev);
 
-int amdgpu_ras_smu_get_table_version(struct amdgpu_device *adev,
-							uint32_t *table_version);
-
-int amdgpu_ras_smu_get_badpage_count(struct amdgpu_device *adev,
-								uint32_t *count, uint32_t timeout);
-
-int amdgpu_ras_smu_get_badpage_mca_addr(struct amdgpu_device *adev,
-								uint16_t index, uint64_t *mca_addr);
-
-int amdgpu_ras_smu_set_timestamp(struct amdgpu_device *adev,
-										uint64_t timestamp);
-
-int amdgpu_ras_smu_get_timestamp(struct amdgpu_device *adev,
-							uint16_t index, uint64_t *timestamp);
-
-int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_device *adev,
-								uint16_t index, uint64_t *ipid);
-
-int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
-									uint32_t *result);
-
 int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 			struct eeprom_table_record *record, u32 rec_idx,
 			const u32 num);
-- 
2.34.1

