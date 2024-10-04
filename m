Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF14FCF884E
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 15:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8CA810EA3F;
	Fri,  4 Oct 2024 15:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OyExyRKW";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D68CB10EA3D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 15:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ls86DLMhPj7E7FvwdncDXseCWxW2hE1xiEQBvLFM1cWxPyrCU6uuMZTkhI0QLLame/z3GKebTrHH02B5+LGdHoQSFILIvi83TSMevXSuvFZUrbC/Xo3HorFe74e7fAoK9lFDg+azaEWtNuySR+21NaR3bPH9UGlUhZeO/POAQXhhFNzSwGDbmKrY5l6iAy+rMHRFEeX894BPO3qD8VpKznYP9tCrpg+WmialMwH09OCSLCsoFl48xgf9Nr5yLd2ejj3kUrzWLdV2cpSE/oh/2lEPOPAD6bhXYVaHAX1G14Rf+nR3lCVfEyb4l8layr+TxZEkQg4jWigPnlzXTsKQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBc0XZYBgRp5SQPnMSBlQjIVkC3fEAzOU8HU/s2iYmM=;
 b=mD6LZ3LvIKeMWdFDI17U5XF7J0oLWWtUvAM4FUmLBUQs5zU+PFAAkISrQKaUqhGTEf3lV+qn89dsyoqEKXa37tBcl5oaixH6DbGr4OwqWr2B7kqh/R7whTdUpdJqCFGbBPlk7srFqYA1RV2eCshrLjvydXTsmqfHkXZ0lQelVD8p9NqdicFrhEIyiqSp2Zm0HLVkxt6Q4BNvKNlNhMGULeHKOr99IB4Epllg6cQ5dkYze47SqACDAmFWHrYpTOs0BQCqoiZBJKFF2fkZgjdwc1QDoKZXUxRd8fPnWquHtj6PGB74aIMJirRFFx+M9z+IyhjySQuoXCfjAEJOma9Dug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBc0XZYBgRp5SQPnMSBlQjIVkC3fEAzOU8HU/s2iYmM=;
 b=OyExyRKWSUqA17ny+hBdcZJZqZY6KtH7g4YDuEiNKHhsk9Mc8eHtd25XVFzgoPDIe4K1Oa2SQr4MneCDwDvwGJGZg3gK9CHQGtPhSj0ACjjgEEKz8dDmuS/NjoXWBsi5e9FvJRnyu5nvkeAjcbegMc2s11/COTFIgvALf3q3lxY=
Received: from CH5P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::19)
 by DS0PR12MB7703.namprd12.prod.outlook.com (2603:10b6:8:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 15:57:54 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:1f3:cafe::5e) by CH5P223CA0003.outlook.office365.com
 (2603:10b6:610:1f3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 15:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.2 via Frontend Transport; Fri, 4 Oct 2024 15:57:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 10:57:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/swsmu: default to fullscreen 3D profile for
 dGPUs
Date: Fri, 4 Oct 2024 11:57:37 -0400
Message-ID: <20241004155738.488919-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004155738.488919-1-alexander.deucher@amd.com>
References: <20241004155738.488919-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DS0PR12MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fadd468-2e3e-43ec-5243-08dce48d4ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZJUoPUzTHvlViBvcf3kFQr/t9oLqUh2MEdTREy+QBduQ9T+REYX8922HNaZG?=
 =?us-ascii?Q?1ztT1QSFIs+QZ8RVIfAKUDrwcgbk7FREX+G1j7Vgv2OF5QgD+psaEvcqQCwG?=
 =?us-ascii?Q?fCqU3rN3zgktOsGirziJeW8VsF6s51Xl59ktXPo4eIzXOy6gZ4KrkvbDL1Uo?=
 =?us-ascii?Q?GXcSF7p2NgO6+pktwGJF11yv1QLfchz0tMx7fOsGZR7r7yOjri2ASNoXX0kJ?=
 =?us-ascii?Q?62fIsl8Gx7rFiTM5YiN09bmuHRPsJ38wlLNux35hxWeOgN1NrBrMvQCFwRQY?=
 =?us-ascii?Q?fQeCm+2kagYwNzVOqbf3p0L0YiKUFQPAptBZYpD4YWoMyVh39OS9Y1zKtN5v?=
 =?us-ascii?Q?FZB1uJd3146BVrPKNdwIqtYYW8Yu77cTSEZ+jxhy0jnBmmiD8XXX/7RJBLQe?=
 =?us-ascii?Q?s0Kstd9+EjX6JPkJse1zzDVC+pjHnsh82aAGb6bDZojpcwbqBDlUe52IZRe1?=
 =?us-ascii?Q?dJ4kZBuPhmmm7zblXXWmysdh3ZVCYkycPDZByvRu3U3Mpjxn94Zh3fENGtbv?=
 =?us-ascii?Q?Rsc0fkGSYH9v/SYCOt96thn5CvSw7Art+J0pHdHyQFXkVObQQJ1LsyF9f28H?=
 =?us-ascii?Q?GxRv7SBadh9Aw1RrX+XlIyF4CKZlKZBfyc0RGe+MudpkvhyYw3N40CUF4a2S?=
 =?us-ascii?Q?QwVGaCGpLq+YKYr/7HenVwQHlUk9Hb4zw7kZnqEG4ZOMxJYZYwDoVrviOAmO?=
 =?us-ascii?Q?DgZ6JnjJ7N32H6wei5HAgO1e8a6Kql5uDOrioJMJVf+KUznbVpO8apJaT1RU?=
 =?us-ascii?Q?/70C3Sj2qfaUw+9KUZyA2NY7Fwxu42Dw6WX3wcUFxE4fxeFY6cVzRUEzMeXe?=
 =?us-ascii?Q?6VIhiXUb0QIEyHwWE7A/hPxJpOrOqL7Og1kzVtWKnv0eDHKiFq85hHpBMOG6?=
 =?us-ascii?Q?ISu85x9XahBWc/7tm4pv5TbICzHHYZIkz6aLFVuiz5xZxpe1t/cj6TTGUjKq?=
 =?us-ascii?Q?TKaH4sjE0EtGo6jJJX4jDd6GjqlJTvebgOceKT6dtI2/utDibEa4RxYHyFdr?=
 =?us-ascii?Q?rKOthZptXUdlOiFxOu98A6Y0jbduCtax3LmP3lUXOt752pNShl5WeQrKAJj7?=
 =?us-ascii?Q?tjf038pulwJjaZ4lnqcFBMa6cp/IxwfUyPQiA+euslpMWXvLW8jkM1F9zEbV?=
 =?us-ascii?Q?4PZP9zo9esuuRJbAQi8mfLJq9NjUAJ3NX7El0xa1kZ/jMiKAAynH+b8Zl8iN?=
 =?us-ascii?Q?OageQtObqIYxj9VA4co0OCindm1koq1/Gygh+HBnIaZwxWpTMJsQJc0eHpfR?=
 =?us-ascii?Q?FgnwN0vIxB2M611vryeHmw1yWyQbVLqLghFt5Iqgocc9ZNJLltgKqa1q8p6C?=
 =?us-ascii?Q?UfT/uSf1PU1F2OVZnA2FSmoqZ1FpVGUGMupghwTyNTlOQg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:57:54.1800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fadd468-2e3e-43ec-5243-08dce48d4ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7703
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

This uses more aggressive hueristics than the the bootup default
profile.  On windows the OS has a special fullscreen 3D mode
where this is used.  Since we don't have the equivalent on Linux
default to this profile for dGPUs.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3618
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1500
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3131
Fixes: c50fe289ed7207 ("drm/amdgpu/swsmu: always force a state reprogram on init")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4cca1dcac60c..ceaeb0152a5d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1265,7 +1265,11 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
-	smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
+
+	if (smu->is_apu)
+		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
+	else
+		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
 
 	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-- 
2.46.2

