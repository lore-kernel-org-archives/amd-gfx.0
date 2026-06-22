Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22FACDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9428C10E57A;
	Mon, 22 Jun 2026 08:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AW2wU9pr";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA64C10E57E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPmiGAuZP+pLWhJPk72oFIWQgZd9XGSrl9eZhb8Ilt5XlNASYB4IzfxDG+95uROCu0jjvtZ5GreT8p/r36qpA5byhkuKQHv/6scGQnZQxdHA2wNzjh/pejVzOBq8d/WKDto4r3BoVZHaEv7+50jepcqaIXw9Qw0mgbNydeTVXiu3riLhXP8phdspZFNvNFN9RN7ZXnzTS4MfxhnFcjHI/p3W6lOOLBcvtLpIp4vG7IRhuPH6Z2rPpVs1ZWKcq9YYp3sVNJazXY/qqfjBzrqA71gOkc8D8+tu3z1q6d7Fsh6g2+D69h5DA6NRH811Wxhjo3zSv3UStqz+O7wOJYulEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDfQY3ggAbc3c/0l++f+CD+SRSEY5/vaBGCizK8wTnE=;
 b=wwnmKYTgku3v4/J1S3qHM4KYp27zuS2Pbr/klR8kEUkmUYHgi/7bq4epnilEWuRhRGCsPNb0FncGK1HdywPjfZ0f3W079UfvSHmUenCBrf8CpBS8kJDNd6BuLrv+EJLSRwJeHZmm/ElU5urhTXVA4eo3vsw3gaiz1iyu8FuBXXZNXzkHVVWwwZxnyrpdoR03W9ISJ1kDJV1rl5n2m+MDPoUgDqS/5WQ+xinSDbiQL2SbP0fSyVbaa0pM103rJXSvZ4sPAuU0Y71BDyH8vL7+lLGmI0pXrcV1p3W66sK1Fim7FgSe4xEPfgz0rqMqs0WMVXVDY1OxpAmAH96XmSaMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDfQY3ggAbc3c/0l++f+CD+SRSEY5/vaBGCizK8wTnE=;
 b=AW2wU9prWoO8yR/2Clfx/QIXstN2ZxBr3ViNVRg1Udup/93Fj6oDL21kChgDuZnESnyCgrf5jH7EmcizI9rflE5qDnuKwCqUNCtNvaM7ftG1Lge3VxuGSNyG8+Kb05FjmIfYvCHo4ldCzUtaKf0Tx0V7Gl49UbNh6HRCA3LpqFI=
Received: from DS7PR06CA0030.namprd06.prod.outlook.com (2603:10b6:8:54::22) by
 DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.19; Mon, 22 Jun 2026 08:46:26 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::4b) by DS7PR06CA0030.outlook.office365.com
 (2603:10b6:8:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:26 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:18 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 36/48] drm/amdgpu: retire legacy pmfw eeprom check
Date: Mon, 22 Jun 2026 16:44:38 +0800
Message-ID: <4294f449f14f9c579a407c6da200274010644d09.1782117608.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e4ce21-34cf-4b5d-66c8-08ded03abece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2cHCjTtp+tDdpH9qm/AW98dqvcHh1aX8Ex4pys70R9mRnWq51yJtkG4C7KSjqj2SfQKswJo5hcFmwOapUWDFod0omEc38IGq2ydtDjIOlReWyKi1PsUaZYmPJjuqYvTFXfQi0KFUcfInvpNnyXPD2OclwpBeO161Sp9/jJ42yKRWLR4XbOE/rwr43A0gMePZOoXzIKFuhgQpVGED1DhvPmXGMn3Q1qgvJRHGghwK5inpYmX2T//aMQaHNfApEyZ5j0feMfzcQQmwX1BIBNNAu3Ytxeu7ym9VSMd+0Hm/oX+t4gwCEjftCjW0RJ0L+LCCubAix6naN2h7X+sXklMcojZmQASjEDYi56BTtnCbEQj+RPvzYrxw3oO1GbBOtkklxIlCyvAos/WkCqslb4J4BCdj8RcESD2kMqCEOzUjJtC01TLmCUwdE95FpXw7pF/DoWTAgMrrMahgbcmiJMb5VnlPD73nwGBZuh8StrgvzQVRSZYLy1cdIWcRoaS+to3PJ6pkXogdF0lUUrUk5VMx1i+2xF0zl1hYMGwjFxyghn9jMdtzHJgxXP1wOQQtaS8wFzCRJdKk+h57oQUtS9Fc7E+d7fZspSaDIyFF/NnXtErTCvkHos1f8yqLC5ogujCKHMFDCdlDQr9Y5n0mRZ9LA5PFKKYA1LEMONKT173mCcwC70BenxFq6e08khHkcrx+EB8uArkmsmFXeC66I4eD/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xWOzurkfSWIyndwk4AfQpuTRyRrzUEK7OxYYnS3oLSUGo73LPiJH0El+/AeDcwk8gp+Vqgn16mN09b/QJ0RNtHjS9x+yNod4IWTJ7dJ1fo0ZMiYK7pUXdMNdHoQ2TFVMbIDer32sCQaw6/FI7KBpsxl+ZxOPUvEobWEbLPZmnUzxnOAZyjVyRGcIm3/cVrvsCMDayZyx82xf6CRL5UyTgmqmSsziXPKre/mXajC19UEMLkU/R6XCCjs0wgcoJZGHLFM+ly41Nx0WEhMnwRy97F1y1KW0kDEh8cLv4XRl5K9JGZ2WPB1lhPdC8ZjxPWcLNNG/NunQQMqX/5K+yZBp7rGoo2s2ztGzqRF+6A1SriVpzQghyWB4reK7gzpbaUQMnATYgTExGIJbGXk0hOP3duW5ONMrrZOcBO2a+apMAisGjZFL8Xp04rFhg2+C7dxa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:26.0192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e4ce21-34cf-4b5d-66c8-08ded03abece
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418
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

Remove the legacy pmfw eeprom check function, as the feature is deprecated and unused

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 44 -------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 9a9633b57022..f5d1bc1142a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1627,47 +1627,6 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	return 0;
 }
 
-static int amdgpu_ras_smu_eeprom_check(struct amdgpu_ras_eeprom_control *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	if (!__is_ras_eeprom_supported(adev))
-		return 0;
-
-	control->ras_num_bad_pages = ras->bad_page_num;
-
-	if ((ras->bad_page_cnt_threshold < control->ras_num_bad_pages) &&
-	    amdgpu_bad_page_threshold != 0) {
-		dev_warn(adev->dev,
-			"RAS records:%d exceed threshold:%d\n",
-			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
-		if ((amdgpu_bad_page_threshold == -1) ||
-			(amdgpu_bad_page_threshold == -2)) {
-			dev_warn(adev->dev,
-				 "Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
-		} else {
-			ras->is_rma = true;
-			dev_warn(adev->dev,
-				 "User defined threshold is set, runtime service will be halt when threshold is reached\n");
-		}
-
-		return 0;
-	}
-
-	dev_dbg(adev->dev,
-		"Found existing EEPROM table with %d records",
-		control->ras_num_bad_pages);
-
-	/* Warn if we are at 90% of the threshold or above
-	 */
-	if (10 * control->ras_num_bad_pages >= 9 * ras->bad_page_cnt_threshold)
-		dev_warn(adev->dev, "RAS records:%u exceeds 90%% of threshold:%d",
-				control->ras_num_bad_pages,
-				ras->bad_page_cnt_threshold);
-	return 0;
-}
-
 int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -1675,9 +1634,6 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int res = 0;
 
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		return amdgpu_ras_smu_eeprom_check(control);
-
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-- 
2.34.1

