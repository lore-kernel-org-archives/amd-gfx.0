Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D95CD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B89C10E481;
	Mon, 22 Jun 2026 04:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fib5vh6I";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2912410E481
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kekDpCEBAcobVXd/YT4yeiChIQPE9YbL3xh8Do0OjuIs6xKL9WnbxJ7B4EmuEToi+YkAC9s/k/5JETtV5rBomwwhOtZ5Zrwe/gVMyRkxBRRrVijadUjpdLCxTwuqN3+QdZsNB8Mgf7hRwsthfL21KWRXcsDlvbdL5ouTMG5UuBdTbojRrRqZzJO+tTK0Sf3+HnSfzEA3Uhbs0XSy7x1FXNM9zAP9HRKuvJkQLxVVNUUUneub26dTp5pQV9HureJO6mEd7aYemkNQhZgsHGBRovbYNcRLfx76EMWNaw01rIycW4gct0QzihqRbDkvGW7kZo4xNehB7k2oDAtpAHOgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVFbNwnHGnVt1jYpuArY9dsMlpD9NlRYti/oWV4QeCE=;
 b=KMlm7pelgX3JtVjI6NTXJIuKzZb8vs4nDu9N9qVJD8GEvyLRByIqafJ1qU2u8/p+pfAAmO52IWgIXKq2hnrNXSFHTeJPpZrKAD/4s161XJm0G7XX21cMp3war3HOKsUH5Mk0Z7qP0rVSvIHqZbHJLW+IwekG6VGjLqzS6U+W0ZZnL9FTMtRYhTSOgwffLb5Xi8yw+CXWHfLrSr5ortYQVO0zLNIsOL9wk/G1cVrtRiCjXd8+TEV+o9ye2gGuKLfAxhZzhU2BqGE97VwhuI3g1Xs72rMmz2krsiNKmINDeT+7EXdDTcV229amcSVCV+3vK8M0n9UKVLPUB/prXC3ElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVFbNwnHGnVt1jYpuArY9dsMlpD9NlRYti/oWV4QeCE=;
 b=fib5vh6IhxSP1HPd46x7UzrJ550LKkvcZRFv+4jIraJcgxcr8NeidQaO2HQTJeE9vXXSE1tmTxeHuzm7RZmVj6zFRK0dZaiBCHn4N7tboOf4CcP64LsUMwabg8rVX4yQvOyO0rRPsvxnkVv12uxEswJHahUWuDrgkyXz6vKd87g=
Received: from MN2PR01CA0046.prod.exchangelabs.com (2603:10b6:208:23f::15) by
 MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:43:07 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::a) by MN2PR01CA0046.outlook.office365.com
 (2603:10b6:208:23f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Mon,
 22 Jun 2026 04:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:43:06 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:43:05 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 35/48] drm/amd/pm: retire legacy pmfw eeprom feature check
Date: Mon, 22 Jun 2026 12:40:24 +0800
Message-ID: <d9e9797fa4baff2d3cdfcf97fc831635d5930c71.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ec22cd-d20c-4ba7-90ea-08ded018c113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TgCC78fz4EmIeLRTeXWFa3JnUZxsCuAuRiygDmCeGFKdaxfrASzsQfXMpuCP83h6CkhktOhBR7PzAHM1ekA3fCp/X2RJes2n8eVEEx3d4lLsOzgrIkyfnuGFgJ72kuEN7PV8k5KU95dhx5higpJ5/uwwYF5Lp4eQ2h/whgh24W1tTyyw5m7rcUM3neAOQiPqL6SIL85B9KltbykQDwgOR5+kwXW6/k3hRlxYPP6GMRag+WsFPCkABX30VzxmwWMNlrkfFUZiq9yInzBoslyj7MQYVfSYLlSTw9XzzFjxL2OoYDzqpdw3NqeL65Kx5HJQcwgDZzQzrmKryYoFUHDUL0QeqMeCi5joyRG/4Y5mLG+Bdz9VkvcroYcuJF/UUZzrNJG9+EBZKEiS0olN6BLR12L9MIYAX8X1P80k1ehhVwvLL1UOxwd4M7AnzIKUeAutVgmWeKME6L9Dzki0NFqfdCTRNm1KtkyjZ8Jd3+metcIQ05P/oN2M9LsmSq7BFRobbXz2IrWgYNA0gouuQC6dq0zf7bTgH+BLkia/uyQK8jcn2C+y6wxEd//G79nMWtmJQbfHoN357Xs81qmyqoBboRWTvl4uycqRmIX55Z1ka5PcOZaYRdtviNqRFCnEqg8WnLwRD+x3GhodCuU7/Lm3R+TcfpqU4xS9nX9Midt0jmLdyDtByXKWv7i9LSi4aqmAwKhUlPrOCm1Nt1C4qIXxsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2VBA1MQmqYT6V8wDmJennTS1VmPU3jVwEdoC/dDg2xFqoalQYJm25AC0tWiS68fI86kId4OPlhzuhH6SGMRKWz9+1BkQG8Af6b4g0yfgzdnm0HxcPgpULR+fltWtuwMjWUa5M5gKPjqLrKXSAAr99VTYNaiVzCZS1AjtyqVLCIwAWJTUB7+PEcZX/0pPU39LVSC5vG7EAHYDZumvN0EG9//KeFksPq0crx7H47Mv8CjxxBDSgf1o0lFJrXLcDMYxu3QmqQG7dZpPXvq1Q9s1hwt2Fk0kqolhT1QxDef3NqVjDxcdV0EZa2JSP7blBgjkMemecd6gtRN2PGAXduNhqsQSZy8IxY4CqPuzkeZkUDaeQvodTMBLDPuUrqgZFbq/c7MC0oNyNunOdRJbGgZs2ndP5llKYWOkJM+yqbCEGEPx5eW5OM30fu2A/DZ4uQ71
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:43:06.9847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ec22cd-d20c-4ba7-90ea-08ded018c113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333
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

